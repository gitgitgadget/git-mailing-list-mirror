Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 750AF2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 12:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbcF1MRR (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 08:17:17 -0400
Received: from mail.aegee.org ([144.76.142.78]:55986 "EHLO mail.aegee.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062AbcF1MRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 08:17:16 -0400
X-Greylist: delayed 739 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jun 2016 08:17:16 EDT
Received: from mail.your-server.de (localhost [127.0.0.1])
	by mail.aegee.org (8.15.2/8.15.1) with ESMTP id u5SC4Yd1028146;
	Tue, 28 Jun 2016 12:04:34 GMT
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.aegee.org u5SC4Yd1028146
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=aegee.org; s=k4096;
	t=1467115474; i=dkim+sm-localhost@aegee.org;
	bh=gr/0G1mTlOTkzFR4hyExCg84bJUnq7WpXy6mA0o0fGk=;
	h=From:To:Subject:Date;
	b=neDT+pnvCPn5CLcaUkXj+r2Hx1HgbIXMaDOO5oRXuO2ExXIKDvnaykPZlpsgXKWsN
	 EPYurznMdWmJIO8pJC4xOHwlE1sOxD7JqebDweTkOViZAnJWulp955IlAMYbUVk0rn
	 OPl6W14i/4QRTyGy2ItJFFp14K3fuCAN03yGp9cjZsBqQGdQ0r/xe3bR0/pIGr9zZE
	 /O3oafB65WWF5nwhsjgXjuNH6ZaKEXU8d5oivET88ApA1nOHvMPfD7AJTi2gTMMwMh
	 vdOYuOzVgMGupvGbrU+DNgg6WwjVk+GsPWH3Ol/+OUw3y69vGJJoj5In1+s+127LAE
	 xkXB73xWC4veVlcq3C4rlWaeALZU6eoMlGEAnBMA/donEdLx89tdpDSS1L+dbydvng
	 gBfyOEVPvh2vSITionqDHv+cnjGlK2IOdC3Fw8Be5XxH0WT7YWuaRLAfmV1rBv4TUV
	 wQJ6YTJRQMcFTAEr9sJf9hY739+x7WA93/zyhQyYH9zFqisbdGcirs87XFHNvtxFeY
	 KZLKF3h4lGhZvM9ZshrZQa2cyMic/dYqPti4hVu1BM2BdFGFaEtnbLOJYdQQEQ5KMG
	 ytAzF10lPbo3hoWWWE2faq/cpUsDZj0PgwmFxOLq7QLeMKXF4bUZf9I/CLkPTr7Dk5
	 zh5+wz8Gd9l7StGHMqVdOVxc=
Authentication-Results:	mail.aegee.org; dkim=none
From:	=?UTF-8?q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD=20=D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2?= 
	<git-dpa@aegee.org>
To:	git@vger.kernel.org
Subject: [PATCH] ./configure.ac: Detect SSL in libcurl using curl-config
Date:	Tue, 28 Jun 2016 12:04:34 +0000
Message-Id: <20160628120434.28105-1-git-dpa@aegee.org>
X-Mailer: git-send-email 2.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail.aegee.org
X-Virus-Status:	Clean
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The API of libcurl does not mention Curl_ssl_init() and when curl is built
with -flto, the Curl_ssl_init symbol is not exported.

https://curl.haxx.se/libcurl/using/ suggests calling
  curl-config --feature | grep SSL
to see, if the installed curl has SSL support.  Another approach would
be calling curl_version_info and checking the returned struct.

This patch removes the check for the Curl_ssl_init exported symbol from
libcurl and uses curl-config to detect SSL support in libcurl.

Signed-Off-By: Дилян Палаузов <git-dpa@aegee.org>
---
 configure.ac | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/configure.ac b/configure.ac
index c279025..5e9ba59 100644
--- a/configure.ac
+++ b/configure.ac
@@ -528,16 +528,6 @@ AC_CHECK_LIB([curl], [curl_global_init],
 [NO_CURL=],
 [NO_CURL=YesPlease])
 
-if test -z "${NO_CURL}" && test -z "${NO_OPENSSL}"; then
-
-AC_CHECK_LIB([curl], [Curl_ssl_init],
-[NEEDS_SSL_WITH_CURL=YesPlease],
-[NEEDS_SSL_WITH_CURL=])
-
-GIT_CONF_SUBST([NEEDS_SSL_WITH_CURL])
-
-fi
-
 GIT_UNSTASH_FLAGS($CURLDIR)
 
 GIT_CONF_SUBST([NO_CURL])
@@ -550,6 +540,17 @@ AC_CHECK_PROG([CURL_CONFIG], [curl-config],
 
 if test $CURL_CONFIG != no; then
     GIT_CONF_SUBST([CURL_CONFIG])
+    if test -z "${NO_OPENSSL}"; then
+      AC_MSG_CHECKING([if Curl supports SSL])
+      if test $(curl-config --features|grep SSL) = SSL; then
+         NEEDS_SSL_WITH_CURL=YesPlease
+         AC_MSG_RESULT([yes])
+      else
+         NEEDS_SSL_WITH_CURL=
+         AC_MSG_RESULT([no])
+      fi
+      GIT_CONF_SUBST([NEEDS_SSL_WITH_CURL])
+    fi
 fi
 
 fi
-- 
2.9.0

