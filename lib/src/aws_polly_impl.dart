import 'dart:async';

import 'package:aws_polly/aws_polly.dart';
import 'package:flutter/services.dart';

class _MethodCalls {
  static final initialize = 'initialize';
  static final getUrl = 'getUrl';
}

class AwsPollyImpl implements AwsPolly {
  static const MethodChannel _channel = const MethodChannel('aws_polly');

  /// The string of the Identity Pool.
  final String poolId;

  /// The region of the Identity Pool.
  final AWSRegionType region;

  AwsPollyImpl({
    required this.poolId,
    required this.region,
  }) {
    _initialize();
  }

  /// Sets your AWSServiceManager configuration to this [poolId] and [region].
  ///
  /// Called once in the [AwsPollyImpl] constructor.
  ///
  void _initialize() async {
    Map<String, String> request = {
      'poolId': poolId,
      'region': region.string,
    };

    await _channel.invokeMethod(_MethodCalls.initialize, request);
  }

  Future<String> getUrl({
    required String input,
    AWSPolyVoiceId voiceId = AWSPolyVoiceId.ivy,
    AWSPolyOutputFormat outputFormat = AWSPolyOutputFormat.mp3,
  }) async {
    Map<String, String> request = {
      'input': input,
      'voiceId': voiceId.string,
      'outputFormat': outputFormat.name,
    };
    return await _channel.invokeMethod(_MethodCalls.getUrl, request);
  }
}
