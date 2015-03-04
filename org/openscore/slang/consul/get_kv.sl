#   (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
####################################################
#   get consul key 
#
#   Inputs:
#       - host - consul agent host
#       - consul_port - optional - consul agent port (defualt 8500)
#       - key_name - name for the new key
#       - key_value - optional - value for the new key (default is null)
#       - flags - optional - flags for the new key (default is 0)
#   Outputs:
#       - returnResult - response of the operation
#       - statusCode - normal status code is 200
#       - returnCode - if returnCode is equal to -1 then there was an error
#       - errorMessage: returnResult if returnCode is equal to -1 or statusCode different than 200
#   Results:
#       - SUCCESS - operation succeeded (returnCode != '-1' and statusCode == '200')
#       - FAILURE - otherwise
####################################################

namespace: org.openscore.slang.consul

operation:
      name: get_kv
      inputs:
        - host
        - consul_port:
            default: "'8500'"
            required: false
        - key_name
        - url:
            default: "'http://'+ host + ':' + consul_port +'/v1/kv/'+key_name"
            overridable: false
        - method:
            default: "'get'"
            overridable: false
      action:
        java_action:
          className: org.openscore.content.httpclient.HttpClientAction
          methodName: execute
      outputs:
        - returnResult
        - statusCode
        - returnCode
        - errorMessage: returnResult if returnCode == '-1' or statusCode != '200' else ''
      results:
        - SUCCESS: returnCode != '-1' and statusCode == '200'
        - FAILURE