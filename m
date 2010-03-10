From: Jeremy Huddleston <jeremyhu@apple.com>
Subject: [PATCH] darwin: Use CommonCrypto to compute SHA1
Date: Tue, 9 Mar 2010 16:01:52 -0800
Message-ID: <9AE94716-A53B-40A6-A7D9-CCD39B820390@apple.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: multipart/signed; boundary=Apple-Mail-14--38179600; micalg=sha1; protocol="application/pkcs7-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 10 01:10:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np9Uz-0001PZ-C3
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 01:10:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299Ab0CJAJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 19:09:58 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:58638 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884Ab0CJAJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 19:09:57 -0500
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Mar 2010 19:09:57 EST
Received: from relay16.apple.com (relay16.apple.com [17.128.113.55])
	by mail-out4.apple.com (Postfix) with ESMTP id ECEDD8FB5397
	for <git@vger.kernel.org>; Tue,  9 Mar 2010 16:01:52 -0800 (PST)
X-AuditID: 11807137-b7bd4ae000000f0d-11-4b96e170f289
Received: from yuffie.apple.com (yuffie.apple.com [17.201.23.139])
	by relay16.apple.com (Apple SCV relay) with SMTP id 9D.D6.03853.071E69B4; Tue,  9 Mar 2010 16:01:52 -0800 (PST)
X-Mailer: Apple Mail (2.936)
X-Brightmail-Tracker: AAAAAgAAAZED5gkQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141858>


--Apple-Mail-14--38179600
Content-Type: multipart/mixed;
	boundary=Apple-Mail-13--38179893


--Apple-Mail-13--38179893
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

 From d5b06f19d5043a261ff007f19dfe88ae0ddde00f Mon Sep 17 00:00:00 2001
From: Jeremy Huddleston <jeremyhu@apple.com>
Date: Mon, 8 Mar 2010 15:10:54 -0800
Subject: [PATCH] darwin: Use CommonCrypto to compute SHA1

Signed-off-by: Jeremy Huddleston <jeremyhu@apple.com>
Reviewed-by: Kevin Van Vechten <kvv@apple.com>
---
  Makefile |   14 ++++++++++++++
  cache.h  |    7 +++++++
  2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index f64610a..bb4a1f0 100644
--- a/Makefile
+++ b/Makefile
@@ -91,6 +91,10 @@ all::
  # Define PPC_SHA1 environment variable when running make to make use  
of
  # a bundled SHA1 routine optimized for PowerPC.
  #
+# Define COMMONCRYPTO_SHA1 environment variable when running make to  
make
+# use of the Darwin/Mac OS X Common Cryptography library for SHA1
+# computation (instead of libcrypto).
+#
  # Define NEEDS_CRYPTO_WITH_SSL if you need -lcrypto when using -lssl  
(Darwin).
  #
  # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto  
(Darwin).
@@ -775,6 +779,7 @@ ifeq ($(uname_S),SCO_SV)
  	TAR = gtar
  endif
  ifeq ($(uname_S),Darwin)
+	COMMONCRYPTO_SHA1 = YesPlease
  	NEEDS_CRYPTO_WITH_SSL = YesPlease
  	NEEDS_SSL_WITH_CRYPTO = YesPlease
  	NEEDS_LIBICONV = YesPlease
@@ -1155,7 +1160,11 @@ ifndef NO_OPENSSL
  	endif
  else
  	BASIC_CFLAGS += -DNO_OPENSSL
+ifndef COMMONCRYPTO_SHA1
+ifndef PPC_SHA1
  	BLK_SHA1 = 1
+endif
+endif
  	OPENSSL_LIBSSL =
  endif
  ifdef NEEDS_SSL_WITH_CRYPTO
@@ -1313,10 +1322,15 @@ ifdef PPC_SHA1
  	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
  	LIB_H += ppc/sha1.h
  else
+ifdef COMMONCRYPTO_SHA1
+	SHA1_HEADER = <CommonCrypto/CommonDigest.h>
+	BASIC_CFLAGS += -DUSE_COMMONCRYPTO_SHA1
+else
  	SHA1_HEADER = <openssl/sha.h>
  	EXTLIBS += $(LIB_4_CRYPTO)
  endif
  endif
+endif
  ifdef NO_PERL_MAKEMAKER
  	export NO_PERL_MAKEMAKER
  endif
diff --git a/cache.h b/cache.h
index 89f6a40..135b25e 100644
--- a/cache.h
+++ b/cache.h
@@ -8,11 +8,18 @@

  #include SHA1_HEADER
  #ifndef git_SHA_CTX
+#ifdef USE_COMMONCRYPTO_SHA1
+#define git_SHA_CTX	CC_SHA1_CTX
+#define git_SHA1_Init	CC_SHA1_Init
+#define git_SHA1_Update	CC_SHA1_Update
+#define git_SHA1_Final	CC_SHA1_Final
+#else
  #define git_SHA_CTX	SHA_CTX
  #define git_SHA1_Init	SHA1_Init
  #define git_SHA1_Update	SHA1_Update
  #define git_SHA1_Final	SHA1_Final
  #endif
+#endif

  #include <zlib.h>
  #if defined(NO_DEFLATE_BOUND) || ZLIB_VERNUM < 0x1200
-- 
1.6.3.1




--Apple-Mail-13--38179893
Content-Disposition: attachment;
	filename=0001-darwin-Use-CommonCrypto-to-compute-SHA1.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0001-darwin-Use-CommonCrypto-to-compute-SHA1.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20d5b06f19d5043a261ff007f19dfe88ae0ddde00f=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Jeremy=20Huddleston=20<jeremyhu@apple.com>=0A=
Date:=20Mon,=208=20Mar=202010=2015:10:54=20-0800=0ASubject:=20[PATCH]=20=
darwin:=20Use=20CommonCrypto=20to=20compute=20SHA1=0A=0ASigned-off-by:=20=
Jeremy=20Huddleston=20<jeremyhu@apple.com>=0AReviewed-by:=20Kevin=20Van=20=
Vechten=20<kvv@apple.com>=0A---=0A=20Makefile=20|=20=20=2014=20=
++++++++++++++=0A=20cache.h=20=20|=20=20=20=207=20+++++++=0A=202=20files=20=
changed,=2021=20insertions(+),=200=20deletions(-)=0A=0Adiff=20--git=20=
a/Makefile=20b/Makefile=0Aindex=20f64610a..bb4a1f0=20100644=0A---=20=
a/Makefile=0A+++=20b/Makefile=0A@@=20-91,6=20+91,10=20@@=20all::=0A=20#=20=
Define=20PPC_SHA1=20environment=20variable=20when=20running=20make=20to=20=
make=20use=20of=0A=20#=20a=20bundled=20SHA1=20routine=20optimized=20for=20=
PowerPC.=0A=20#=0A+#=20Define=20COMMONCRYPTO_SHA1=20environment=20=
variable=20when=20running=20make=20to=20make=0A+#=20use=20of=20the=20=
Darwin/Mac=20OS=20X=20Common=20Cryptography=20library=20for=20SHA1=0A+#=20=
computation=20(instead=20of=20libcrypto).=0A+#=0A=20#=20Define=20=
NEEDS_CRYPTO_WITH_SSL=20if=20you=20need=20-lcrypto=20when=20using=20=
-lssl=20(Darwin).=0A=20#=0A=20#=20Define=20NEEDS_SSL_WITH_CRYPTO=20if=20=
you=20need=20-lssl=20when=20using=20-lcrypto=20(Darwin).=0A@@=20-775,6=20=
+779,7=20@@=20ifeq=20($(uname_S),SCO_SV)=0A=20=09TAR=20=3D=20gtar=0A=20=
endif=0A=20ifeq=20($(uname_S),Darwin)=0A+=09COMMONCRYPTO_SHA1=20=3D=20=
YesPlease=0A=20=09NEEDS_CRYPTO_WITH_SSL=20=3D=20YesPlease=0A=20=09=
NEEDS_SSL_WITH_CRYPTO=20=3D=20YesPlease=0A=20=09NEEDS_LIBICONV=20=3D=20=
YesPlease=0A@@=20-1155,7=20+1160,11=20@@=20ifndef=20NO_OPENSSL=0A=20=09=
endif=0A=20else=0A=20=09BASIC_CFLAGS=20+=3D=20-DNO_OPENSSL=0A+ifndef=20=
COMMONCRYPTO_SHA1=0A+ifndef=20PPC_SHA1=0A=20=09BLK_SHA1=20=3D=201=0A=
+endif=0A+endif=0A=20=09OPENSSL_LIBSSL=20=3D=0A=20endif=0A=20ifdef=20=
NEEDS_SSL_WITH_CRYPTO=0A@@=20-1313,10=20+1322,15=20@@=20ifdef=20PPC_SHA1=0A=
=20=09LIB_OBJS=20+=3D=20ppc/sha1.o=20ppc/sha1ppc.o=0A=20=09LIB_H=20+=3D=20=
ppc/sha1.h=0A=20else=0A+ifdef=20COMMONCRYPTO_SHA1=0A+=09SHA1_HEADER=20=3D=20=
<CommonCrypto/CommonDigest.h>=0A+=09BASIC_CFLAGS=20+=3D=20=
-DUSE_COMMONCRYPTO_SHA1=0A+else=0A=20=09SHA1_HEADER=20=3D=20=
<openssl/sha.h>=0A=20=09EXTLIBS=20+=3D=20$(LIB_4_CRYPTO)=0A=20endif=0A=20=
endif=0A+endif=0A=20ifdef=20NO_PERL_MAKEMAKER=0A=20=09export=20=
NO_PERL_MAKEMAKER=0A=20endif=0Adiff=20--git=20a/cache.h=20b/cache.h=0A=
index=2089f6a40..135b25e=20100644=0A---=20a/cache.h=0A+++=20b/cache.h=0A=
@@=20-8,11=20+8,18=20@@=0A=20=0A=20#include=20SHA1_HEADER=0A=20#ifndef=20=
git_SHA_CTX=0A+#ifdef=20USE_COMMONCRYPTO_SHA1=0A+#define=20git_SHA_CTX=09=
CC_SHA1_CTX=0A+#define=20git_SHA1_Init=09CC_SHA1_Init=0A+#define=20=
git_SHA1_Update=09CC_SHA1_Update=0A+#define=20git_SHA1_Final=09=
CC_SHA1_Final=0A+#else=0A=20#define=20git_SHA_CTX=09SHA_CTX=0A=20#define=20=
git_SHA1_Init=09SHA1_Init=0A=20#define=20git_SHA1_Update=09SHA1_Update=0A=
=20#define=20git_SHA1_Final=09SHA1_Final=0A=20#endif=0A+#endif=0A=20=0A=20=
#include=20<zlib.h>=0A=20#if=20defined(NO_DEFLATE_BOUND)=20||=20=
ZLIB_VERNUM=20<=200x1200=0A--=20=0A1.6.3.1=0A=0A=

--Apple-Mail-13--38179893--

--Apple-Mail-14--38179600
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIITbjCCAz8w
ggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0
ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcx
KDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0
ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxA
dGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpB
MSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUg
UGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEA
xKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7d
yfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/
p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCBkTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDow
OKA2oDSGMmh0dHA6Ly9jcmwudGhhd3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3Js
MAsGA1UdDwQEAwIBBjApBgNVHREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgw
DQYJKoZIhvcNAQEFBQADgYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A
9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYI
Tq726jTlEBpbNU1341YheILcIRk13iSx0x1G/11fZU8wggM/MIICqKADAgECAgENMA0GCSqGSIb3
DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlD
YXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0
aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwg
Q0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3
MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENv
bnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElz
c3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f
6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYk
KhPPK9Xzgnc9A74r/rsYPge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGj
gZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRo
YXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0R
BCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM
0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZ
GwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZ
Nd4ksdMdRv9dX2VPMIIGcDCCBdmgAwIBAgIQKF0Nr8sW2fhCBNsoUjwm8zANBgkqhkiG9w0BAQUF
ADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEs
MCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDkwNTA0MDUy
OTE0WhcNMTAwNTA0MDUyOTE0WjCCAnAxHzAdBgNVBAMTFlRoYXd0ZSBGcmVlbWFpbCBNZW1iZXIx
JDAiBgkqhkiG9w0BCQEWFWplcmVteWh1QGJlcmtlbGV5LmVkdTErMCkGCSqGSIb3DQEJARYcamVy
ZW15aHVAdWNsaW5rLmJlcmtlbGV5LmVkdTEsMCoGCSqGSIb3DQEJARYdamVyZW15aHVAdWNsaW5r
NC5iZXJrZWxleS5lZHUxJzAlBgkqhkiG9w0BCQEWGGplcmVteWh1QGNzLmJlcmtlbGV5LmVkdTEp
MCcGCSqGSIb3DQEJARYaamVyZW15QHVwZS5jcy5iZXJrZWxleS5lZHUxKTAnBgkqhkiG9w0BCQEW
GmplcmVteWh1QGVlY3MuYmVya2VsZXkuZWR1MScwJQYJKoZIhvcNAQkBFhhqZXJlbXlodUBmcmVl
ZGVza3RvcC5vcmcxJDAiBgkqhkiG9w0BCQEWFWplcmVteWh1QG1hY3BvcnRzLm9yZzElMCMGCSqG
SIb3DQEJARYWamVyZW15QG91dGVyc3F1YXJlLm9yZzEgMB4GCSqGSIb3DQEJARYRamVyZW15aHVk
QG1hYy5jb20xIzAhBgkqhkiG9w0BCQEWFGplcmVteUBodWRzY2FiaW4uY29tMSEwHwYJKoZIhvcN
AQkBFhJqZXJlbXlodUBhcHBsZS5jb20xJTAjBgkqhkiG9w0BCQEWFmplcmVteUBvdXRlcnNxdWFy
ZS5jb20xJTAjBgkqhkiG9w0BCQEWFnBheXBhbEBvdXRlcnNxdWFyZS5jb20xHzAdBgkqhkiG9w0B
CQEWEGplcmVteWh1ZEBtZS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCwVnJ8
XrKgByWkhJhQDk7Kj45PnZYRXJNQfcTyBQsqSqfUh13Limf2qJTxpw8Mdq/SuNkO3ZjLkaYGPB4+
8uaHdDqGEanq2wf4qKV4dyFEQO92mRQRxLijfBS4CunlSYzHuPd6g5osI0BVpFbNRswqOXWbHd1z
XRVvRqpvYKQJFWLf3dqXU3zZO2nv4sabnovbNCKEO6HrxQeawFfwxL20adsK5F1ejK1VRSEsTzd7
BjNs8QTWC4qZKrrNuaPJLVt4LDbRXIqOggrZaOkggIBIIdXubjOrrpR41PvcvibfvYLUpo3bdX5e
tWH/VU/ywIS3oIc4d+VtOL/O3YdCpX0FAgMBAAGjggGRMIIBjTCCAXsGA1UdEQSCAXIwggFugRVq
ZXJlbXlodUBiZXJrZWxleS5lZHWBHGplcmVteWh1QHVjbGluay5iZXJrZWxleS5lZHWBHWplcmVt
eWh1QHVjbGluazQuYmVya2VsZXkuZWR1gRhqZXJlbXlodUBjcy5iZXJrZWxleS5lZHWBGmplcmVt
eUB1cGUuY3MuYmVya2VsZXkuZWR1gRpqZXJlbXlodUBlZWNzLmJlcmtlbGV5LmVkdYEYamVyZW15
aHVAZnJlZWRlc2t0b3Aub3JngRVqZXJlbXlodUBtYWNwb3J0cy5vcmeBFmplcmVteUBvdXRlcnNx
dWFyZS5vcmeBEWplcmVteWh1ZEBtYWMuY29tgRRqZXJlbXlAaHVkc2NhYmluLmNvbYESamVyZW15
aHVAYXBwbGUuY29tgRZqZXJlbXlAb3V0ZXJzcXVhcmUuY29tgRZwYXlwYWxAb3V0ZXJzcXVhcmUu
Y29tgRBqZXJlbXlodWRAbWUuY29tMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAMtx6
voXn2w2+kaevSb7REuy5TBAQNzwlcwLiaC44HMVhwQGEYG544mBabCqY2+MtLbEn2RDQGHArtuCA
Tv9liObLp6UPNKo+8Bcd3edN0dlFSeb0wFPVt71e05dGeyIoBxIrM4ix2BON/SHcGsgt3n1DRXen
JLYVV809vRtHQpowggZwMIIF2aADAgECAhBfIA3CIvCJAyf8rsNvgxtuMA0GCSqGSIb3DQEBBQUA
MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSww
KgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTAeFw0wOTA5MTQyMTM2
MjdaFw0xMDA5MTQyMTM2MjdaMIICcDEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEk
MCIGCSqGSIb3DQEJARYVamVyZW15aHVAYmVya2VsZXkuZWR1MSswKQYJKoZIhvcNAQkBFhxqZXJl
bXlodUB1Y2xpbmsuYmVya2VsZXkuZWR1MSwwKgYJKoZIhvcNAQkBFh1qZXJlbXlodUB1Y2xpbms0
LmJlcmtlbGV5LmVkdTEnMCUGCSqGSIb3DQEJARYYamVyZW15aHVAY3MuYmVya2VsZXkuZWR1MSkw
JwYJKoZIhvcNAQkBFhpqZXJlbXlAdXBlLmNzLmJlcmtlbGV5LmVkdTEpMCcGCSqGSIb3DQEJARYa
amVyZW15aHVAZWVjcy5iZXJrZWxleS5lZHUxJzAlBgkqhkiG9w0BCQEWGGplcmVteWh1QGZyZWVk
ZXNrdG9wLm9yZzEkMCIGCSqGSIb3DQEJARYVamVyZW15aHVAbWFjcG9ydHMub3JnMSUwIwYJKoZI
hvcNAQkBFhZqZXJlbXlAb3V0ZXJzcXVhcmUub3JnMSAwHgYJKoZIhvcNAQkBFhFqZXJlbXlodWRA
bWFjLmNvbTEjMCEGCSqGSIb3DQEJARYUamVyZW15QGh1ZHNjYWJpbi5jb20xITAfBgkqhkiG9w0B
CQEWEmplcmVteWh1QGFwcGxlLmNvbTElMCMGCSqGSIb3DQEJARYWamVyZW15QG91dGVyc3F1YXJl
LmNvbTElMCMGCSqGSIb3DQEJARYWcGF5cGFsQG91dGVyc3F1YXJlLmNvbTEfMB0GCSqGSIb3DQEJ
ARYQamVyZW15aHVkQG1lLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL+c2RGH
leO3G25PQEPEVsV3H/cWDewBCnMbqV0zgEg3hMyoRUG3aRUgH4gWbhVNkx/5t0A+mLQQWNnktg2J
ku4MJJhHmarkxQAwITyamyO+37GHFl2d7oe5J7CFwg3Evf/2Lli0mfglfDHBy5YN9yURbSMVRaDV
WGHhpYkqTwGXG2Bpai7oqdOlB0hDcRGE4Fv5aurxAuxyIohZMuxhZBzDfmidKsOUTnsz+NCUFIXK
cMLYWwvH4XOBC4l0SU523phMyEW0OPas38EWd2NMCYaO1URA944+cS68DUvCqrrRzGmixY03PcaV
uJ/+KA3L2u9esq8vt8s5m8aW8MWQWIkCAwEAAaOCAZEwggGNMIIBewYDVR0RBIIBcjCCAW6BFWpl
cmVteWh1QGJlcmtlbGV5LmVkdYEcamVyZW15aHVAdWNsaW5rLmJlcmtlbGV5LmVkdYEdamVyZW15
aHVAdWNsaW5rNC5iZXJrZWxleS5lZHWBGGplcmVteWh1QGNzLmJlcmtlbGV5LmVkdYEaamVyZW15
QHVwZS5jcy5iZXJrZWxleS5lZHWBGmplcmVteWh1QGVlY3MuYmVya2VsZXkuZWR1gRhqZXJlbXlo
dUBmcmVlZGVza3RvcC5vcmeBFWplcmVteWh1QG1hY3BvcnRzLm9yZ4EWamVyZW15QG91dGVyc3F1
YXJlLm9yZ4ERamVyZW15aHVkQG1hYy5jb22BFGplcmVteUBodWRzY2FiaW4uY29tgRJqZXJlbXlo
dUBhcHBsZS5jb22BFmplcmVteUBvdXRlcnNxdWFyZS5jb22BFnBheXBhbEBvdXRlcnNxdWFyZS5j
b22BEGplcmVteWh1ZEBtZS5jb20wDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQUFAAOBgQBAga5a
Jmkyd0TMiY0icyR7j5soyooiP4q9+Iu6lG+s/S+7vF5sDadCq+Y7US091MNT4LmbQehwwhi4jUWy
EZ+KP9dhfWMqi51rZDbhWxAqAoKmgWgoQ9UsA4LqaC1wWlrM/DtzZ7+L5ZZ+MWlr94fDNL8qU3+y
3ZfiXgpWBV1x1zGCAxAwggMMAgEBMHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBD
b25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJ
c3N1aW5nIENBAhBfIA3CIvCJAyf8rsNvgxtuMAkGBSsOAwIaBQCgggFvMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTEwMDMxMDAwMDE1M1owIwYJKoZIhvcNAQkEMRYE
FF3PW1UZifKEleMLIQ99VXjlvKe5MIGFBgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUw
IwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVy
c29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQKF0Nr8sW2fhCBNsoUjwm8zCBhwYLKoZIhvcNAQkQ
AgsxeKB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBM
dGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQKF0Nr8sW
2fhCBNsoUjwm8zANBgkqhkiG9w0BAQEFAASCAQBnC0DMyO08+JZbsWf6I/L8Q7W46Hyjo4YTM/UD
ttrHHzoJA+9wfMg+PM7pp7SweRQDisAz5QePPaqUiE36sog8Q0RGA42sbJ9t/d7NF8wKpOw1XjdB
NQJb9E/yNmAvpVN3BKT74kchTOOsmKWaFjGxismrFi/wano5aTIgATwQMe0+w0LtLeumYawxWq2R
wogolaVblCEEM13vnhev8T4uK0m+qtqHnhYv2W0DQ4XU29i4/pzVgcY8/KXUDOpdcnd4c3WyS8B+
7cfCvkHtqjSZywS/bvxtNk2wl+ZliyMxVnBngfWFk1+yM9OsS+79uzgaQJoB54ZC6xdqyxOECnZt
AAAAAAAA

--Apple-Mail-14--38179600--
