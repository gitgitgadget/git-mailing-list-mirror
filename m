From: Tordek <kedrot@gmail.com>
Subject: [PATCH (try 3)] http.c: 'use_git_config_string' on configuration
 options.
Date: Sat, 19 Apr 2008 19:39:21 -0300
Message-ID: <480A7499.1040705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 20 00:40:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnLjB-0006Dt-Tb
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 00:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbYDSWj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 18:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbYDSWj1
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 18:39:27 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:21510 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbYDSWj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 18:39:26 -0400
Received: by yw-out-2324.google.com with SMTP id 5so712195ywb.1
        for <git@vger.kernel.org>; Sat, 19 Apr 2008 15:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:x-enigmail-version:content-type:content-transfer-encoding;
        bh=2hq48gZMS5aWDLO2zbeDbBTfWiCv0xR15JrE5hNZHPI=;
        b=GhKsgyCXugMl4R2t0jcR/R7+U+wVt8YWRYjaJLchLu0tXzUknhGf4bEULkllYQsGkosJkG8G1JjTZMYvfwZYroJngZNt9gxOgMUO0V8Wr500Z3y5sjQIm+FXRzWnXJq01Xd2IXvbe0c0JQKPm7vzVj3KVZFjGEP6LkSwCITQLT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=rKoxOJIT6o6Y5ULIHqrap2NTPrFEYWBNrqgIPGEp/MiYWu5AfxyCcFdUMsCvMMEPHUmho7mUvDoDJ5WFPNTtVgbs5L38raWmNlNqOz9zF8SRsBsxek1Dl9QrSlQnsmi5Tbafl5OenySZdbcYHny+YyJX4fBfSKCfmxQkvGEiNz0=
Received: by 10.151.42.12 with SMTP id u12mr5458751ybj.97.1208644765712;
        Sat, 19 Apr 2008 15:39:25 -0700 (PDT)
Received: from ?192.168.0.101? ( [190.137.195.23])
        by mx.google.com with ESMTPS id 6sm3918598ywc.9.2008.04.19.15.39.22
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 19 Apr 2008 15:39:24 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79927>

Signed-off-by: Guillermo O. Freschi <tordek@tordek.com.ar>
---
My apologies, I had made a mistake on the previous attempt.

  http.c |   36 ++++++++++++------------------------
  1 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/http.c b/http.c
index 256a5f1..8ae6432 100644
--- a/http.c
+++ b/http.c
@@ -13,14 +13,14 @@ static CURL *curl_default;
  char curl_errorstr[CURL_ERROR_SIZE];

  static int curl_ssl_verify = -1;
-static char *ssl_cert = NULL;
+static const char *ssl_cert = NULL;
  #if LIBCURL_VERSION_NUM >= 0x070902
-static char *ssl_key = NULL;
+static const char *ssl_key = NULL;
  #endif
  #if LIBCURL_VERSION_NUM >= 0x070908
-static char *ssl_capath = NULL;
+static const char *ssl_capath = NULL;
  #endif
-static char *ssl_cainfo = NULL;
+static const char *ssl_cainfo = NULL;
  static long curl_low_speed_limit = -1;
  static long curl_low_speed_time = -1;
  static int curl_ftp_no_epsv = 0;
@@ -100,39 +100,27 @@ static int http_options(const char *var, const 
char *value)
  	}

  	if (!strcmp("http.sslcert", var)) {
-		if (ssl_cert == NULL) {
-			if (!value)
-				return config_error_nonbool(var);
-			ssl_cert = xstrdup(value);
-		}
+		if (ssl_cert == NULL)
+			return git_config_string(&ssl_cert, var, value);
  		return 0;
  	}
  #if LIBCURL_VERSION_NUM >= 0x070902
  	if (!strcmp("http.sslkey", var)) {
-		if (ssl_key == NULL) {
-			if (!value)
-				return config_error_nonbool(var);
-			ssl_key = xstrdup(value);
-		}
+		if (ssl_key == NULL)
+			return git_config_string(&ssl_key, var, value);
  		return 0;
  	}
  #endif
  #if LIBCURL_VERSION_NUM >= 0x070908
  	if (!strcmp("http.sslcapath", var)) {
-		if (ssl_capath == NULL) {
-			if (!value)
-				return config_error_nonbool(var);
-			ssl_capath = xstrdup(value);
-		}
+		if (ssl_capath == NULL)
+			return git_config_string(&ssl_capath, var, value);
  		return 0;
  	}
  #endif
  	if (!strcmp("http.sslcainfo", var)) {
-		if (ssl_cainfo == NULL) {
-			if (!value)
-				return config_error_nonbool(var);
-			ssl_cainfo = xstrdup(value);
-		}
+		if (ssl_cainfo == NULL)
+			return git_config_string(&ssl_cainfo, var, value);
  		return 0;
  	}

-- 
1.5.2.2
