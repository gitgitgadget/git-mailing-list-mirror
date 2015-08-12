From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] http: add support for specifying the SSL version
Date: Wed, 12 Aug 2015 15:00:56 +0200
Message-ID: <1439384456-16335-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 15:01:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPVej-0002Cc-U9
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 15:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbbHLNBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 09:01:10 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34751 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbbHLNBI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 09:01:08 -0400
Received: by pdbfa8 with SMTP id fa8so7250989pdb.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 06:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=DZPAvK66tNPsoaXqFgUg4rMzt2ejWm2Y+0UjEwqRUHo=;
        b=X7ZCxKF7CevAFpUGRSfnldPoBLou97LaGWM2fd3qN9CPnMaMFJCvnGZdVm3im+Rq4m
         G2GbbEy1pOX0U5mV5A7BGKKA5qGBShEi+ocMocVk4O6xYRIwDHxFK/lWbPY+dIX5tC7j
         tyM2iAy3h9cYADX48XfB5cnaYeuJk3TSRDO+Qd9JWSkJd/D94BUqW3c75uAqhQo8agBF
         4Ph9qs+rKkVkG0ZiuUuhaNbHwMj66xCMzNfc0k+MjWQSeKHG6J2E+Q/WyiXlwKbdFCKG
         jTw5xeE7jcqX+7q55BN1TLsw6UYg5DIDv40rX7nImSZXD7NwUTylSYso5mrQgRyx3onC
         7ICA==
X-Received: by 10.70.38.69 with SMTP id e5mr67342032pdk.27.1439384466751;
        Wed, 12 Aug 2015 06:01:06 -0700 (PDT)
Received: from ubuntu14.nephoscale.com (static-67.207.195.141.nephosdns.com. [67.207.195.141])
        by smtp.gmail.com with ESMTPSA id pt3sm6412995pbb.38.2015.08.12.06.01.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Aug 2015 06:01:05 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.234.gefc8a62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275762>

Teach git about a new option, "http.sslVersion", which permits one to
specify the SSL version  to use when negotiating SSL connections.  The
setting can be overridden by the GIT_SSL_VERSION environment
variable.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 Documentation/config.txt               | 21 +++++++++++++++++++++
 contrib/completion/git-completion.bash |  1 +
 http.c                                 | 31 +++++++++++++++++++++++++++++--
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 315f271..76a4f2b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1595,6 +1595,27 @@ http.saveCookies::
 	If set, store cookies received during requests to the file specified by
 	http.cookieFile. Has no effect if http.cookieFile is unset.
 
+http.sslVersion::
+	The SSL version to use when negotiating an SSL connection, if you
+	want to force the default.  The available and default version depend on
+	whether libcurl was built against NSS or OpenSSL and the particular configuration
+	of the crypto library in use. Internally this sets the 'CURLOPT_SSL_VERSION'
+	option; see the libcurl documentation for more details on the format
+	of this option and for the ssl version supported. Actually the possible values
+	of this option are:
+
+	- sslv2
+	- sslv3
+	- tlsv1
+	- tlsv1.0
+	- tlsv1.1
+	- tlsv1.2
++
+Can be overridden by the 'GIT_SSL_VERSION' environment variable.
+To force git to use libcurl's default ssl version and ignore any
+explicit http.sslversion option, set 'GIT_SSL_VERSION' to the
+empty string.
+
 http.sslCipherList::
   A list of SSL ciphers to use when negotiating an SSL connection.
   The available ciphers depend on whether libcurl was built against
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c97c648..6e9359c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2118,6 +2118,7 @@ _git_config ()
 		http.postBuffer
 		http.proxy
 		http.sslCipherList
+		http.sslVersion
 		http.sslCAInfo
 		http.sslCAPath
 		http.sslCert
diff --git a/http.c b/http.c
index e9c6fdd..a7401b1 100644
--- a/http.c
+++ b/http.c
@@ -37,6 +37,8 @@ static int curl_ssl_verify = -1;
 static int curl_ssl_try;
 static const char *ssl_cert;
 static const char *ssl_cipherlist;
+static const char *ssl_version;
+static long sslversion = CURL_SSLVERSION_DEFAULT;
 #if LIBCURL_VERSION_NUM >= 0x070903
 static const char *ssl_key;
 #endif
@@ -190,6 +192,8 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp("http.sslcipherlist", var))
 		return git_config_string(&ssl_cipherlist, var, value);
+	if (!strcmp("http.sslversion", var))
+		return git_config_string(&ssl_version, var, value);
 	if (!strcmp("http.sslcert", var))
 		return git_config_string(&ssl_cert, var, value);
 #if LIBCURL_VERSION_NUM >= 0x070903
@@ -364,13 +368,36 @@ static CURL *get_curl_handle(void)
 	if (http_proactive_auth)
 		init_curl_http_auth(result);
 
+
+	if (getenv("GIT_SSL_VERSION"))
+		ssl_version = getenv("GIT_SSL_VERSION");
+	if (ssl_version != NULL && *ssl_version) {
+		if (!strcmp(ssl_version,"tlsv1")) {
+			sslversion = CURL_SSLVERSION_TLSv1;
+		} else if (!strcmp(ssl_version,"sslv2")) {
+			sslversion = CURL_SSLVERSION_SSLv2;
+		} else if (!strcmp(ssl_version,"sslv3")) {
+			sslversion = CURL_SSLVERSION_SSLv3;
+#if LIBCURL_VERSION_NUM >= 0x072200
+		} else if (!strcmp(ssl_version,"tlsv1.0")) {
+			sslversion = CURL_SSLVERSION_TLSv1_0;
+		} else if (!strcmp(ssl_version,"tlsv1.1")) {
+			sslversion = CURL_SSLVERSION_TLSv1_1;
+		} else if (!strcmp(ssl_version,"tlsv1.2")) {
+			sslversion = CURL_SSLVERSION_TLSv1_2;
+                } else {
+			warning("unsupported ssl version %s : using default",
+			ssl_version);
+#endif
+		}
+        }
+	curl_easy_setopt(result, CURLOPT_SSLVERSION,
+				sslversion);
 	if (getenv("GIT_SSL_CIPHER_LIST"))
 		ssl_cipherlist = getenv("GIT_SSL_CIPHER_LIST");
-
 	if (ssl_cipherlist != NULL && *ssl_cipherlist)
 		curl_easy_setopt(result, CURLOPT_SSL_CIPHER_LIST,
 				ssl_cipherlist);
-
 	if (ssl_cert != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
 	if (has_cert_password())
-- 
2.5.0.234.gefc8a62
