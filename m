Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E57BC678DB
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 15:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCDPLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 10:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCDPLW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 10:11:22 -0500
Received: from tmailer.gwdg.de (tmailer.gwdg.de [134.76.10.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90318113C1
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 07:11:18 -0800 (PST)
Received: from excmbx-23.um.gwdg.de ([134.76.9.233] helo=email.gwdg.de)
        by mailer.gwdg.de with esmtp (GWDG Mailer)
        (envelope-from <minh-cristian.le@mpsd.mpg.de>)
        id 1pYTXY-000TU2-Pf; Sat, 04 Mar 2023 16:11:16 +0100
Received: from [10.1.1.11] (10.250.9.199) by EXCMBX-23.um.gwdg.de
 (134.76.9.233) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id 15.1.2507.21; Sat, 4
 Mar 2023 16:11:16 +0100
Message-ID: <566c2d09-5e18-49c9-fc7c-7b92d1d7c198@mpsd.mpg.de>
Date:   Sat, 4 Mar 2023 16:11:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Bug in git archive + .gitattributes + relative path
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, <git@vger.kernel.org>
References: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
 <c7b21faa-68dd-8bd9-4670-2cf609741094@web.de>
 <8d04019d-511f-0f99-42cc-d0b25720cd71@mpsd.mpg.de>
 <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de>
Content-Language: en-US
From:   Cristian Le <cristian.le@mpsd.mpg.de>
In-Reply-To: <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
        micalg=sha-256; boundary="------------ms050108040602040503050402"
X-Originating-IP: [10.250.9.199]
X-ClientProxiedBy: EXCMBX-13.um.gwdg.de (134.76.9.222) To EXCMBX-23.um.gwdg.de
 (134.76.9.233)
X-Virus-Scanned: (clean) by clamav
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--------------ms050108040602040503050402
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> I suppose that means e.g. for Git's own repo that
> Tito would allow creating a separate RPM file for e.g. git-gui.
Indeed, that pretty much sums the main idea of why they need sub 
directories there. Ideally we don't want different special cases, and 
instead use as much native behaviour as possible. The main issue here is 
just making it work with `export-subst`, and if it can be achieved with 
both `strip-components` and `prefix`, that might work, even though 
`--transform` would be more flexible.

> However we cannot use the `tar` directly because that would affect
> the timestamps and permissions of the file that are set by `git
> archive`.
I should have explained more thoroughly, I have tried to work around by 
doing a `git archive` and then extracting and re-compressing after 
fixing the paths, but this does not preserve the owner and timestamp of 
the original `git archive`, nor can I use the current implementation of 
their tar fixer to correct these since the headers are different. I do 
not have enough expertise to know what headers need to be set, how to 
set the timestamps and so on. I don't know if the `gzip -n -c` could do 
a better job at that, but we would still not be able to use it as is 
because we would want the correctly generate `export-subst` files, for 
example for a project built with `setuptools_scm` that injects the 
version of the python package from the last tag:

https://github.com/pypa/setuptools_scm#git-archives

> There it was introduced along with a script that changes the mtime
> of archive entries from the current time to the commit timestamp by
> https://github.com/spacewalkproject/spacewalk/commit/34267e39d472.
Thanks for pointing me to this. From your understanding, if we only use 
the git commit directly, we would in principle not need the whole tar 
fixer 
(https://github.com/rpm-software-management/tito/blob/91ef962220ec5154722760dbbd982bed032ee484/src/tito/tar.py#L28-L60 
and 
https://github.com/rpm-software-management/tito/blob/91ef962220ec5154722760dbbd982bed032ee484/src/tito/common.py#L871-L890)? 
If there is no crucial information in the header that is different 
between the `git archive` and the `tar`/`gzip` with appropriate `mtime`, 
`mode` and maybe others, maybe there is some hope in fixing this locally.

I'll be looking forward to `--strip-components`, but just to confirm my 
reading of the email, the intent is to have it working with 
`export-subst` right?

Cheers and thanks for your intuitive answers.


--------------ms050108040602040503050402
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDMwNDE1MTExNVow
LwYJKoZIhvcNAQkEMSIEIOFdi1h74ZWNfQOKI1KrOM26oTyGHQO39lMZoK352PAeMGkGCSsG
AQQBgjcQBDFcMFowRjELMAkGA1UEBhMCTkwxGTAXBgNVBAoTEEdFQU5UIFZlcmVuaWdpbmcx
HDAaBgNVBAMTE0dFQU5UIFBlcnNvbmFsIENBIDQCEFBRTJS4tCRrq8CDtgqMZGMwawYLKoZI
hvcNAQkQAgsxXKBaMEYxCzAJBgNVBAYTAk5MMRkwFwYDVQQKExBHRUFOVCBWZXJlbmlnaW5n
MRwwGgYDVQQDExNHRUFOVCBQZXJzb25hbCBDQSA0AhBQUUyUuLQka6vAg7YKjGRjMGwGCSqG
SIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggq
hkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJ
KoZIhvcNAQEBBQAEggEAtqk0io7NJewgsDC6RplC1j2qNMxgq2QAYOxNwEiPR1mVRN5VgrzC
upcWECbX/KuPZOd5PPG0915PG8S2BA1SRB8i8+ezGbp2kCuT1U6ivqMckBXKogVWeaW+Jnjw
ajpTpGtVEmt0n5bECXj1fP6cwWDabnYRhFtQf7QGg3KMg/Lk4WswJuXlys2TMF9AmBe9DHwH
fwHKB1NaJgH+GkqUWMVMsAdzInh+LvRZVkkDTbITwRSwzNcyHUKGIvAj3AP/2EAO6Ses7nb8
rf4eT4OlAl6VsHlr7fFwv6BOUXx31GyJ4/EnkAp5GH1AQdp0imAKnRoBe4sabo8D7mlBjw8S
UQAAAAAAAA==
--------------ms050108040602040503050402--
