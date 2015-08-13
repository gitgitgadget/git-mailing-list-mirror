From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH v3] http: add support for specifying the SSL version
Date: Thu, 13 Aug 2015 17:28:51 +0200
Message-ID: <1439479731-16018-1-git-send-email-gitter.spiros@gmail.com>
Cc: remi.galan-alfonso@ensimag.grenoble-inp.fr,
	sunshine@sunshineco.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 17:29:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPuRC-0002gV-JO
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 17:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbbHMP26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 11:28:58 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36362 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbbHMP25 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 11:28:57 -0400
Received: by pacrr5 with SMTP id rr5so39540344pac.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xdys+0Y4DlB2Twh0QjlCuYl51588vKZYChOtHaf7cnk=;
        b=bWAtASDo6Z6MBVWNtHA98krvno2RZsIPf+OH5qYFvzxa9JlDBBMTVmP9V8ow805BVX
         dnf/K4hnycidBXYg6+sm5c9hJ5Q389fyxLqn5OQz1rxh7e19erRz3DxfFHuMeVwsTWKP
         Yr4nz+C0r5kS5khb8YsLa/RW2zhBiv0ko9nN5knjpu8U7hO/wr5sBQL1QWBOAikZrIwB
         TfZTXJXTCm7zu3YRsoZrWiDZ2BkodXllaAAsVqG/Ja9JOJhnum1hbcwY5+l8W2uOP7ww
         HLPZnRuGwJQLziDtwDa7CewGUfLPmw93foO/lzd3sfeI5jqsnQxYoc/gIERCXla3BK/R
         WFvg==
X-Received: by 10.68.232.104 with SMTP id tn8mr78293341pbc.155.1439479736921;
        Thu, 13 Aug 2015 08:28:56 -0700 (PDT)
Received: from ubuntu14.nephoscale.com (static-67.207.195.141.nephosdns.com. [67.207.195.141])
        by smtp.gmail.com with ESMTPSA id rt6sm3043694pbb.62.2015.08.13.08.28.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Aug 2015 08:28:56 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.234.gefc8a62.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275849>

Teach git about a new option, "http.sslVersion", which permits one to
specify the SSL version  to use when negotiating SSL connections.  The
setting can be overridden by the GIT_SSL_VERSION environment
variable.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
This is the third version of the patch. The changes compared to the previous version are:

- Eliminated the unnecessary blank (Junio)
- Place a structure to associate mnemonic names with the curl enum constant (Junio)
- Eliminated the invocation to curl_easy_setopt to set the default SSL value. Also removed the static global variable.
  (Junio)
- Slight correction in config.txt (Eric)

 Documentation/config.txt               | 22 ++++++++++++++++++++++
 contrib/completion/git-completion.bash |  1 +
 http.c                                 | 32 +++++++++++++++++++++++++++++++-
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 315f271..b23b01a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1595,6 +1595,28 @@ http.saveCookies::
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
+
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
index e9c6fdd..d5fecd6 100644
--- a/http.c
+++ b/http.c
@@ -37,6 +37,21 @@ static int curl_ssl_verify = -1;
 static int curl_ssl_try;
 static const char *ssl_cert;
 static const char *ssl_cipherlist;
+static const char *ssl_version;
+static struct {
+	const char *name;
+	long ssl_version;
+	} sslversions[] = {
+		{ "sslv2", CURL_SSLVERSION_SSLv2 },
+		{ "sslv3", CURL_SSLVERSION_TLSv1 },
+		{ "tlsv1", CURL_SSLVERSION_TLSv1 },
+#if LIBCURL_VERSION_NUM >= 0x072200
+		{ "tlsv1.0", CURL_SSLVERSION_TLSv1_0 },
+		{ "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
+		{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
+#endif
+		{ NULL }
+};
 #if LIBCURL_VERSION_NUM >= 0x070903
 static const char *ssl_key;
 #endif
@@ -190,6 +205,8 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp("http.sslcipherlist", var))
 		return git_config_string(&ssl_cipherlist, var, value);
+	if (!strcmp("http.sslversion", var))
+		return git_config_string(&ssl_version, var, value);
 	if (!strcmp("http.sslcert", var))
 		return git_config_string(&ssl_cert, var, value);
 #if LIBCURL_VERSION_NUM >= 0x070903
@@ -364,9 +381,22 @@ static CURL *get_curl_handle(void)
 	if (http_proactive_auth)
 		init_curl_http_auth(result);
 
+	if (getenv("GIT_SSL_VERSION"))
+		ssl_version = getenv("GIT_SSL_VERSION");
+	if (ssl_version != NULL && *ssl_version) {
+		int i;
+		for ( i = 0; i < ARRAY_SIZE(sslversions); i++ ) {
+			if (sslversions[i].name != NULL && *sslversions[i].name && !strcmp(ssl_version,sslversions[i].name)) {
+				curl_easy_setopt(result, CURLOPT_SSLVERSION,
+					sslversions[i].ssl_version);
+				break;
+		}
+		if ( i == ARRAY_SIZE(sslversions) ) warning("unsupported ssl version %s: using default",
+							ssl_version);
+	}
+
 	if (getenv("GIT_SSL_CIPHER_LIST"))
 		ssl_cipherlist = getenv("GIT_SSL_CIPHER_LIST");
-
 	if (ssl_cipherlist != NULL && *ssl_cipherlist)
 		curl_easy_setopt(result, CURLOPT_SSL_CIPHER_LIST,
 				ssl_cipherlist);
-- 
2.5.0.234.gefc8a62.dirty
