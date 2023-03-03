Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1FFC64EC4
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 11:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjCCLHZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 06:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjCCLHY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 06:07:24 -0500
X-Greylist: delayed 2538 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Mar 2023 03:07:21 PST
Received: from tmailer.gwdg.de (tmailer.gwdg.de [134.76.10.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82035F6DD
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 03:07:21 -0800 (PST)
Received: from excmbx-23.um.gwdg.de ([134.76.9.233] helo=email.gwdg.de)
        by mailer.gwdg.de with esmtp (GWDG Mailer)
        (envelope-from <minh-cristian.le@mpsd.mpg.de>)
        id 1pY2az-0007W2-ID
        for git@vger.kernel.org; Fri, 03 Mar 2023 11:25:01 +0100
Received: from [131.169.116.164] (10.250.9.199) by EXCMBX-23.um.gwdg.de
 (134.76.9.233) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id 15.1.2507.21; Fri, 3
 Mar 2023 11:25:01 +0100
Message-ID: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
Date:   Fri, 3 Mar 2023 11:25:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     <git@vger.kernel.org>
Content-Language: en-US
From:   Cristian Le <cristian.le@mpsd.mpg.de>
Subject: Bug in git archive + .gitattributes + relative path
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
        micalg=sha-256; boundary="------------ms090609040403030307090300"
X-Originating-IP: [10.250.9.199]
X-ClientProxiedBy: excmbx-08.um.gwdg.de (134.76.9.215) To EXCMBX-23.um.gwdg.de
 (134.76.9.233)
X-Virus-Scanned: (clean) by clamav
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--------------ms090609040403030307090300
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Using `git archive` with or without `--worktree-attributes` does not 
properly read `.gitattributes` files if using a relative path in 
`<tree-ish>`.
Related github comment: 
https://github.com/rpm-software-management/tito/pull/445#issuecomment-1450298871
Related stackoverflow discussion: 
https://stackoverflow.com/questions/52804334/how-to-ignore-files-directories-in-git-archive-and-only-create-an-archive-of-a

Git version: `2.39.2`
Mwe git repo: Two files:
```
# .gitattributes:
.git_archival.txt export-subst
```
```
# .git_archival.txt:
node: $Format:%H$
```

Commands to reproduce and expected behaviour:
```console
$ git archive HEAD:./ --output=test.tar.gz
$ tar -axf test.tar.gz .git_archival.txt -O
node: 745ce26169fb44e04d91d40ee581cccd591c941e
```
Important: Notice the path `./` given after `HEAD`.

Actual output:
```console
$ tar -axf test.tar.gz .git_archival.txt -O
node: $Format:%H$
```

It doesn't matter if `.gitattributes` is in a subfolder, or if I change 
the relative path `./` to a subfolder, the files are still not properly 
generated.

Using `--worktree-attributes` did not have any effect either.
According to the documentation, I understand that the expected behaviour 
with regards to `--worktree-attributes`:
- Read the `.gitattributes` of the relative path, e.g. `./sub_dir` 
regardless of `--worktree-attributes`. (similar behaviour as not passing 
a relative path)
- Include the `.gitattributes` of the top-level path if 
`--worktree-attributes` is passed

Maybe the intended behaviour is to completely ignore all 
`.gitattributes` unless `--worktree-attributes` is provided, in which 
case, it does not have the intended behaviour and please include a flag 
to achieve the above behaviour.


--------------ms090609040403030307090300
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DTcwggZJMIIEMaADAgECAhBQUUyUuLQka6vAg7YKjGRjMA0GCSqGSIb3DQEBDAUAMEYxCzAJ
BgNVBAYTAk5MMRkwFwYDVQQKExBHRUFOVCBWZXJlbmlnaW5nMRwwGgYDVQQDExNHRUFOVCBQ
ZXJzb25hbCBDQSA0MB4XDTIyMTEwNzAwMDAwMFoXDTIzMTEwNzIzNTk1OVowgdIxDjAMBgNV
BBETBTgwNTM5MUcwRQYDVQQKEz5NYXgtUGxhbmNrLUdlc2VsbHNjaGFmdCB6dXIgRm9lcmRl
cnVuZyBkZXIgV2lzc2Vuc2NoYWZ0ZW4gZS5WLjEbMBkGA1UECQwSSG9mZ2FydGVuc3RyYcOf
ZSA4MQ8wDQYDVQQIEwZCYXllcm4xCzAJBgNVBAYTAkRFMRQwEgYDVQQDEwtDcmlzdGlhbiBM
ZTEmMCQGCSqGSIb3DQEJARYXY3Jpc3RpYW4ubGVAbXBzZC5tcGcuZGUwggEiMA0GCSqGSIb3
DQEBAQUAA4IBDwAwggEKAoIBAQDBNitl7zpnIpfymK7IX/4MAcuFjIb4pwfLVSsO8KTbc8fo
QrhIqsll81GPihVdJCnp9XWGQsmH3dh2L5Ky74/wxVN7nryGkGO31Yrszof8rCYABAeNAw5Q
S32NYrIp5G6GNcH2l4dswn+9m+HZqOYmaGPWHMygXFwq+bi0hOkfBLTko/ZmvgowIgeA6y7P
OqOiyIOlYyD4boBYinHeeFE5g9SD8Zfuq1KS8Gt5PNANxKFy31/nLlPjjmuLhf1mluulMtaY
1MhDBWMLbbLiGjjd+jaF/PO+0wVaeOZmhCYO1hdnWHQoYTIH+C2oTVWC7cirbxsdfisTGuos
rIri8ordAgMBAAGjggGkMIIBoDAfBgNVHSMEGDAWgBRpAKHHIVj44MUbILAK3adRvxPZ5DAd
BgNVHQ4EFgQU2SssCWheJZFculeJMuOkytjjCkEwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB
/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMD8GA1UdIAQ4MDYwNAYLKwYB
BAGyMQECAk8wJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9DUFMwQgYDVR0f
BDswOTA3oDWgM4YxaHR0cDovL0dFQU5ULmNybC5zZWN0aWdvLmNvbS9HRUFOVFBlcnNvbmFs
Q0E0LmNybDB4BggrBgEFBQcBAQRsMGowPQYIKwYBBQUHMAKGMWh0dHA6Ly9HRUFOVC5jcnQu
c2VjdGlnby5jb20vR0VBTlRQZXJzb25hbENBNC5jcnQwKQYIKwYBBQUHMAGGHWh0dHA6Ly9H
RUFOVC5vY3NwLnNlY3RpZ28uY29tMCIGA1UdEQQbMBmBF2NyaXN0aWFuLmxlQG1wc2QubXBn
LmRlMA0GCSqGSIb3DQEBDAUAA4ICAQAm+pHsJz+lz7/XacTmlvz9m4dC4AAmaUaVohnA7dNP
ehHs3iJ1CEpArVGJDxN7qXQUf9/vpTfMBHaphhmgjg4rwK+biO2qxkIYR9i2ln0+St89ryV5
CiwiyBIITgrprUwpIf3NFC9oVzl07jkhXqB6lWRiVzv8vXVUQMQKPOHvn22cnQPBH9zbjNtX
oBUC28E7MCqJAeqAtq6XK0JkQVOsqF54SDEmQX+6PIVaeUiQtM/rb8aY9gwk01Vjqyg8y+Sm
uvnizdtdYL0XlE2XlRW/H6mq/wpVEHFmedrKbtgzm3Odyo8mb6DvVueLOj+nONeP3vrD7kJr
4aKDJESRGlOLZP84/rdYcg0Ae8a/CjJT+6Rst4nIAr6Of5Mbwles3KFbj/oJN68RWpmOE3aB
2nJAEmibtfHpugqRoDEe9iY/81vydwF2IpoywpHe5epJGyXa3aJxvseKyzLUwPYPrO1rAkym
MrUIxsyYbnN2GbNb4SWhl8f74fuwsf7E0YSiRoOFV3a+F+woi18cIOZXaL+fGw9uOst570J2
X0iTbexnHXbG4MjAneqBg0snsHaYy0/kvrM4n4qBO+a+ukfJ3OdvjD7B5PZmW0FLNwCeXIEJ
gmiYsX1PuGgl1nu7Qw6EP4u2iYfFXjA7xkhy91LX5AcFuQib1eglspnDvD0Tlhuf4zCCBuYw
ggTOoAMCAQICEDECcNQ1vpskmvhW0OHihUkwDQYJKoZIhvcNAQEMBQAwgYgxCzAJBgNVBAYT
AlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UE
ChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRp
ZmljYXRpb24gQXV0aG9yaXR5MB4XDTIwMDIxODAwMDAwMFoXDTMzMDUwMTIzNTk1OVowRjEL
MAkGA1UEBhMCTkwxGTAXBgNVBAoTEEdFQU5UIFZlcmVuaWdpbmcxHDAaBgNVBAMTE0dFQU5U
IFBlcnNvbmFsIENBIDQwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCzSuIiXidb
6QRbFAQ1MiAUrrTSMUDGzVDAHqFEyq+eSmF/LZDeYpszai2kQsqWATz/cBA9gGjunvJ45G48
ycC4D6gwZFvbBt5JotxlunBeB8K+crGar3v+RCQ4VfvToX07v+HTJ6EeEONR3IzJPTMyzgAw
ENGsAWf9va9HePQFJiChCzXqhKpp0zen53S+8f9itEy06GS8aku7Mvyb4tMBBa9An3Y3ALIq
Ieymg/iYs8m9WkSkMyekNtFRB1+1KlnNUpM05G8+sY9EucnQQRUIdHzYsvqjP3XlaSuB4Jj0
ia66UGfi5Wx31mm5sKAz8Re9UGVWIqq6wKFKxkSfuO4iwYiIPJoiGEux3dqabwFLduAroDF1
IxE40PqGIdPXzYuZ/wL6BEfFAb0xy8bfm5S9G7y/ts9mIlFpPtkLZ/nQ/iVOWdsu9ale/nK/
uGF47xsxeW2LIvB4sH5U2+D4ad8vpNbcCrXIXXKtkBnNHgxumNNZ0R1Isq/Pz7TALCxxDzWd
sM7AO32/Jn7R4ldtGRZmKpJyfACDn8HU1QPhOtiWsjifrMWnanJhQ6K7M/5qz8BmfPrca+MU
rr1Y4NHZb9MrgPtWKQQyGDXy+G5F/iHGdZk7LS+F8NH+Ddolt2wZpz52JqGMTDPIH5Qok4LL
O95wbxtn+79Tw+wQxmDTuIg+LwIDAQABo4IBizCCAYcwHwYDVR0jBBgwFoAUU3m/WqorSs9U
gOHYm8Cd8rIDZsswHQYDVR0OBBYEFGkAocchWPjgxRsgsArdp1G/E9nkMA4GA1UdDwEB/wQE
AwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcD
BDA4BgNVHSAEMTAvMC0GBFUdIAAwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNv
bS9DUFMwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2VydHJ1c3QuY29tL1VTRVJU
cnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUFBwEBBGowaDA/Bggr
BgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUFkZFRydXN0
Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3
DQEBDAUAA4ICAQAKBU57DY8fEzkA/W/sYsbD7e0XquMBzHjcP0eXXXRD4EAEAGCWSs+QRL9X
Ixmx+52zx9wMa8YTejlR+NKejiyKPTF0q63zMxrO/z/hUwo8IDcRRLS0NSgvTW6AN2rCXJe5
iLN5fIfYgIBB9cy1L6trPuZ/vjUJm87nQ7ExQzGqWN5F9U8MlAk0c5iLanG7GCMoNjHiF1n0
baj6guUeG7n5qcwOQTyDS19+NEqfwjUPUGasN1ZH8h1sE6PrzvRpti+rKzWpiU+i2/k3l2b5
fFDy+Wu9jv6R9BoBh47es/UMzwEZ2kSrIVVr4jSukk+FpmR5ZbtwiYNAV6sdb1srMGsILzXl
rdasSE2nGHvZklk2zUdgn7b01MHq67g0mNozGmT6Dam41Kbhv25WMFs871XqwVIb4gGoT1yR
f/VePMm1jwauqijhKJFvrNweGnebGPeipaLxIo2iEA4qdRztEg/qyzWGogXK/TFdmivg322f
MPQWjQkMhRGMM8SCjlZN22L8x0ZOYoVA2rHJm5P25IjZe+HPyn7ikJiSJmqlqFmUeowXF3D1
dFlCCs/5yC06RYRqI2REFu+28t2nswIvY6xCFAR0RtS8Mz2yXNld0js2MmiRUGrc7imWzdUP
bPcv9sdUF7SsERGPIzYL8dIiHzit+YCoGCSXMg6peF37hHNp1TGCAzgwggM0AgEBMFowRjEL
MAkGA1UEBhMCTkwxGTAXBgNVBAoTEEdFQU5UIFZlcmVuaWdpbmcxHDAaBgNVBAMTE0dFQU5U
IFBlcnNvbmFsIENBIDQCEFBRTJS4tCRrq8CDtgqMZGMwDQYJYIZIAWUDBAIBBQCgggGvMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDMwMzEwMjUwMVow
LwYJKoZIhvcNAQkEMSIEIJlQPEtqrUj2TSupv7ndjVObGcD4Mi+wWznagmjyS2XoMGkGCSsG
AQQBgjcQBDFcMFowRjELMAkGA1UEBhMCTkwxGTAXBgNVBAoTEEdFQU5UIFZlcmVuaWdpbmcx
HDAaBgNVBAMTE0dFQU5UIFBlcnNvbmFsIENBIDQCEFBRTJS4tCRrq8CDtgqMZGMwawYLKoZI
hvcNAQkQAgsxXKBaMEYxCzAJBgNVBAYTAk5MMRkwFwYDVQQKExBHRUFOVCBWZXJlbmlnaW5n
MRwwGgYDVQQDExNHRUFOVCBQZXJzb25hbCBDQSA0AhBQUUyUuLQka6vAg7YKjGRjMGwGCSqG
SIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggq
hkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJ
KoZIhvcNAQEBBQAEggEAUbVA+UBiu4ShaVf55PKdl5hcJGAZyDz2PJcP13HDXqd1rhss3KTC
3PYCN9E/o/Ywmx2JviKo5T/1100p+rEqnHIDERKJUh8BvU90YHeQnx4pADjO5esHp42O/65s
Bqd/fw83YtRrSWZQE5SG5rH3MQFjOKKKkFMqzVLhtvqigOjmgVgY+OcFNxYnvDGUkbL7YsQc
fZaxFzWAsgl+lR7vKuN7uQNm/t543Vw84FO6LNKbmHTvhStejIeNa9qLIXWYN1avjbem1Nw+
d97nuwkgx1iaZtoSF/cTFz+/WV7zxfE0+cji5EtGAWs3TroAU/vseTDDqU4e0vGdBnpowI+f
3AAAAAAAAA==
--------------ms090609040403030307090300--
