From: Moriyoshi Koizumi <mozo@mozo.jp>
Subject: [PATCH] Support various HTTP authentication methods
Date: Mon, 2 Feb 2009 13:09:24 +0900
Message-ID: <E1LTqDN-0003MF-DP@lena.gsc.riken.jp>
References: <7v3af2h1b0.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Feb 02 05:47:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTqi7-0000QB-35
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 05:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154AbZBBEpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 23:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753970AbZBBEpd
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 23:45:33 -0500
Received: from postmanrt1.riken.jp ([134.160.33.65]:13780 "EHLO
	postmanrt1.riken.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917AbZBBEpc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 23:45:32 -0500
X-Greylist: delayed 1251 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Feb 2009 23:45:32 EST
Received: from postman1.riken.jp (postman1.riken.jp [134.160.33.61])
	by postmanrt1.riken.jp (Postfix) with ESMTP id 35AC6402A9C
	for <git@vger.kernel.org>; Mon,  2 Feb 2009 13:26:03 +0900 (JST)
Received: from postman1.riken.jp (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id E9A6175C4F4
	for <git@vger.kernel.org>; Mon,  2 Feb 2009 13:24:38 +0900 (JST)
Received: from lena.gsc.riken.jp (ipm110.gsc.riken.go.jp [134.160.83.110])
	by postman1.riken.jp (Postfix) with ESMTP id CE5E975C4A0
	for <git@vger.kernel.org>; Mon,  2 Feb 2009 13:24:38 +0900 (JST)
Received: from moriyoshi by lena.gsc.riken.jp with local (Exim 4.69)
	(envelope-from <mozo@mozo.jp>)
	id 1LTqMR-0003nf-Ig
	for git@vger.kernel.org; Mon, 02 Feb 2009 13:24:39 +0900
In-Reply-To: <7v3af2h1b0.fsf@gitster.siamese.dyndns.org>
X-PMX-Version: 5.4.5.350696, Antispam-Engine: 2.6.0.325393, Antispam-Data: 2009.2.2.5526
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108045>

Currently there is no way to specify the preferred authentication
method for the HTTP backend and it always falls back to the CURL's default
settings.

This patch allows users to specify the authentication method if supported
by CURL, adding a couple of new settings and environment variables
listed below (the names within the parentheses indicate the environment
variables.)

- http.auth (GIT_HTTP_AUTH)
  Specifies the preferred authentication method for HTTP.  This can
  be a method name or the combination of those separated by comma. Valid
  values are "basic", "digest", "gss" and "ntlm". You can also specify
  "any" (all of the above), "anysafe" (all of the above except "basic").

  Note that the strings are treated case-insensitive.

- http.proxy_auth (GIT_HTTP_PROXY_AUTH)
  Specifies the preferred authentication method method for HTTP proxy.
  The same thing as above applies to this setting.

Signed-off-by: Moriyoshi <mozo@mozo.jp>
---
 http.c |  120 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 114 insertions(+), 6 deletions(-)

diff --git a/http.c b/http.c
index ee58799..41e8e8c 100644
--- a/http.c
+++ b/http.c
@@ -13,18 +13,24 @@ static CURL *curl_default;
 char curl_errorstr[CURL_ERROR_SIZE];
 
 static int curl_ssl_verify = -1;
-static const char *ssl_cert = NULL;
+static const char *ssl_cert;
 #if LIBCURL_VERSION_NUM >= 0x070902
-static const char *ssl_key = NULL;
+static const char *ssl_key;
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
-static const char *ssl_capath = NULL;
+static const char *ssl_capath;
 #endif
-static const char *ssl_cainfo = NULL;
+static const char *ssl_cainfo;
 static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv = 0;
-static const char *curl_http_proxy = NULL;
+static const char *curl_http_proxy;
+#if LIBCURL_VERSION_NUM >= 0x070a06
+static const char *curl_http_auth;
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070a07
+static const char *curl_http_proxy_auth;
+#endif
 
 static struct curl_slist *pragma_header;
 
@@ -153,11 +159,69 @@ static int http_options(const char *var, const char *value, void *cb)
 			return git_config_string(&curl_http_proxy, var, value);
 		return 0;
 	}
+#if LIBCURL_VERSION_NUM >= 0x070a06
+	if (!strcmp("http.auth", var)) {
+		if (curl_http_auth == NULL)
+			return git_config_string(&curl_http_auth, var, value);
+		return 0;
+	}
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070a07
+	if (!strcmp("http.proxy_auth", var)) {
+		if (curl_http_proxy_auth == NULL)
+			return git_config_string(&curl_http_proxy_auth, var, value);
+		return 0;
+	}
+#endif
 
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
 }
 
+#if LIBCURL_VERSION_NUM >= 0x070a06
+static long get_curl_auth_bitmask(const char* auth_method)
+{
+	char buf[4096];
+	const unsigned char *p = (const unsigned char *)auth_method;
+	long mask = CURLAUTH_NONE;
+
+    strlcpy(buf, auth_method, sizeof(buf));
+
+	for (;;) {
+		char *q = buf;
+		while (*p && isspace(*p))
+			++p;
+
+		while (*p && *p != ',')
+			*q++ = tolower(*p++);
+
+		while (--q >= buf && isspace(*q));
+		++q;
+
+		*q = '\0';
+
+		if (!strcmp(buf, "basic"))
+			mask |= CURLAUTH_BASIC;
+		else if (!strcmp(buf, "digest"))
+			mask |= CURLAUTH_DIGEST;
+		else if (!strcmp(buf, "gss"))
+			mask |= CURLAUTH_GSSNEGOTIATE;
+		else if (!strcmp(buf, "ntlm"))
+			mask |= CURLAUTH_NTLM;
+		else if (!strcmp(buf, "any"))
+			mask |= CURLAUTH_ANY;
+		else if (!strcmp(buf, "anysafe"))
+			mask |= CURLAUTH_ANYSAFE;
+
+		if (!*p)
+			break;
+		++p;
+	}
+
+	return mask;
+}
+#endif
+
 static CURL* get_curl_handle(void)
 {
 	CURL* result = curl_easy_init();
@@ -207,9 +271,24 @@ static CURL* get_curl_handle(void)
 	if (curl_ftp_no_epsv)
 		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
 
-	if (curl_http_proxy)
+#if LIBCURL_VERSION_NUM >= 0x070a06
+	if (curl_http_auth) {
+		long n = get_curl_auth_bitmask(curl_http_auth);
+		curl_easy_setopt(result, CURLOPT_HTTPAUTH, n);
+	}
+#endif
+
+	if (curl_http_proxy) {
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
 
+#if LIBCURL_VERSION_NUM >= 0x070a07
+		if (curl_http_proxy_auth) {
+			long n = get_curl_auth_bitmask(curl_http_proxy_auth);
+			curl_easy_setopt(result, CURLOPT_PROXYAUTH, n);
+		}
+#endif
+	}
+
 	return result;
 }
 
@@ -258,6 +337,21 @@ void http_init(struct remote *remote)
 	if (low_speed_time != NULL)
 		curl_low_speed_time = strtol(low_speed_time, NULL, 10);
 
+#if LIBCURL_VERSION_NUM >= 0x070a06
+	{
+		char *http_auth = getenv("GIT_HTTP_AUTH");
+		if (http_auth)
+			curl_http_auth = xstrdup(http_auth);
+	}
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070a07
+	{
+		char *http_proxy_auth = getenv("GIT_HTTP_PROXY_AUTH");
+		if (http_proxy_auth)
+			curl_http_proxy_auth = xstrdup(http_proxy_auth);
+	}
+#endif
+
 	git_config(http_options, NULL);
 
 	if (curl_ssl_verify == -1)
@@ -309,6 +403,20 @@ void http_cleanup(void)
 		free((void *)curl_http_proxy);
 		curl_http_proxy = NULL;
 	}
+
+#if LIBCURL_VERSION_NUM >= 0x070a06
+	if (curl_http_auth) {
+		free((void *)curl_http_auth);
+		curl_http_auth = NULL;
+	}
+#endif
+
+#if LIBCURL_VERSION_NUM >= 0x070a07
+	if (curl_http_proxy_auth) {
+		free((void *)curl_http_proxy_auth);
+		curl_http_proxy_auth = NULL;
+	}
+#endif
 }
 
 struct active_request_slot *get_active_slot(void)
-- 
1.5.6.3
