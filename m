From: Modestas Vainius <modestas@vainius.eu>
Subject: [PATCH] Support FTP-over-SSL/TLS for regular FTP
Date: Sat, 12 Jan 2013 15:59:52 +0200
Message-ID: <1357999192-877-1-git-send-email-modestas@vainius.eu>
Cc: Modestas Vainius <modestas@vainius.eu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 15:22:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu1yV-0005jC-PV
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 15:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573Ab3ALOV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 09:21:59 -0500
Received: from smtp-q8.skynet.lt ([212.122.94.187]:56890 "EHLO
	smtp-q3.skynet.lt" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753456Ab3ALOV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 09:21:58 -0500
X-Greylist: delayed 1310 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Jan 2013 09:21:58 EST
Received: from nd1.smtpcl1.5ci.lt (nd1.smtpcl1.5ci.lt [212.122.94.182])
	by smtp-q3.skynet.lt (Postfix) with ESMTP id 9D52561E5CC;
	Sat, 12 Jan 2013 15:59:54 +0200 (EET)
Received: from [127.0.0.1] (helo=localhost)
	by nd1.smtpcl1.5ci.lt with esmtp (Exim 4.77)
	(envelope-from <modestas@vainius.eu>)
	id 1Tu1ct-0005kT-R5; Sat, 12 Jan 2013 15:59:59 +0200
X-Spam-Flag: NO
X-Spam-Score: 1.274
X-Spam-Level: *
X-Spam-Status: No, score=1.274 required=8 tests=[RDNS_NONE=1.274]
	autolearn=disabled
Received: from nd1.smtpcl1.5ci.lt ([127.0.0.1])
	by localhost (nd1.smtpcl1.5ci.lt [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gZxECdYLo1Vt; Sat, 12 Jan 2013 15:59:54 +0200 (EET)
Received: from [84.240.22.131] (helo=mdxdesktop.lan.vainius.eu)
	by nd1.smtpcl1.5ci.lt with esmtp (Exim 4.77)
	(envelope-from <modestas@vainius.eu>)
	id 1Tu1co-0005kC-7d; Sat, 12 Jan 2013 15:59:54 +0200
Received: from modax by mdxdesktop.lan.vainius.eu with local (Exim 4.80)
	(envelope-from <modestas@vainius.eu>)
	id 1Tu1ct-0000Ek-8D; Sat, 12 Jan 2013 15:59:59 +0200
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213282>

Add a boolean http.sslTry option which allows to enable AUTH SSL/TLS and
encrypted data transfers when connecting via regular FTP protocol.

Default is false since it might trigger certificate verification errors on
misconfigured servers.

Signed-off-by: Modestas Vainius <modestas@vainius.eu>
---
 Documentation/config.txt |    8 ++++++++
 http.c                   |   10 ++++++++++
 http.h                   |    9 +++++++++
 3 files changed, 27 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d5809e0..1abd161 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1406,6 +1406,14 @@ http.sslCAPath::
 	with when fetching or pushing over HTTPS. Can be overridden
 	by the 'GIT_SSL_CAPATH' environment variable.
 
+http.sslTry::
+	Attempt to use AUTH SSL/TLS and encrypted data transfers
+	when connecting via regular FTP protocol. This might be needed
+	if the FTP server requires it for security reasons or you wish
+	to connect securely whenever remote FTP server supports it.
+	Default is false since it might trigger certificate verification
+	errors on misconfigured servers.
+
 http.maxRequests::
 	How many HTTP requests to launch in parallel. Can be overridden
 	by the 'GIT_HTTP_MAX_REQUESTS' environment variable. Default is 5.
diff --git a/http.c b/http.c
index 44f3525..d49a3d4 100644
--- a/http.c
+++ b/http.c
@@ -30,6 +30,7 @@ static CURL *curl_default;
 char curl_errorstr[CURL_ERROR_SIZE];
 
 static int curl_ssl_verify = -1;
+static int curl_ssl_try;
 static const char *ssl_cert;
 #if LIBCURL_VERSION_NUM >= 0x070903
 static const char *ssl_key;
@@ -162,6 +163,10 @@ static int http_options(const char *var, const char *value, void *cb)
 			ssl_cert_password_required = 1;
 		return 0;
 	}
+	if (!strcmp("http.ssltry", var)) {
+		curl_ssl_try = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp("http.minsessions", var)) {
 		min_curl_sessions = git_config_int(var, value);
 #ifndef USE_CURL_MULTI
@@ -306,6 +311,11 @@ static CURL *get_curl_handle(void)
 	if (curl_ftp_no_epsv)
 		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
 
+#ifdef CURLOPT_USE_SSL
+    if (curl_ssl_try)
+		curl_easy_setopt(result, CURLOPT_USE_SSL, CURLUSESSL_TRY);
+#endif
+
 	if (curl_http_proxy) {
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
diff --git a/http.h b/http.h
index 0a80d30..f861662 100644
--- a/http.h
+++ b/http.h
@@ -42,6 +42,15 @@
 #define NO_CURL_IOCTL
 #endif
 
+/*
+ * CURLOPT_USE_SSL was known as CURLOPT_FTP_SSL up to 7.16.4,
+ * and the constants were known as CURLFTPSSL_*
+*/
+#if !defined(CURLOPT_USE_SSL) && defined(CURLOPT_FTP_SSL)
+#define CURLOPT_USE_SSL CURLOPT_FTP_SSL
+#define CURLUSESSL_TRY CURLFTPSSL_TRY
+#endif
+
 struct slot_results {
 	CURLcode curl_result;
 	long http_code;
-- 
1.7.10.4
