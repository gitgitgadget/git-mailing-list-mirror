From: Moriyoshi Koizumi <mozo@mozo.jp>
Subject: [PATCH] Support various HTTP authentication methods
Date: Thu, 29 Jan 2009 18:32:12 +0900
Message-ID: <1233221532.21518.1.camel@lena.gsc.riken.jp>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 10:33:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSTHN-0001ef-Nc
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 10:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbZA2JcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 04:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbZA2JcT
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 04:32:19 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:41140 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbZA2JcR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 04:32:17 -0500
Received: by rv-out-0506.google.com with SMTP id k40so7413655rvb.1
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 01:32:14 -0800 (PST)
Received: by 10.141.107.13 with SMTP id j13mr483159rvm.65.1233221534643;
        Thu, 29 Jan 2009 01:32:14 -0800 (PST)
Received: from ?10.64.99.128? (ipm110.gsc.riken.go.jp [134.160.83.110])
        by mx.google.com with ESMTPS id l31sm6206983rvb.9.2009.01.29.01.32.13
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 29 Jan 2009 01:32:14 -0800 (PST)
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107650>

Currently there is no way to specify the preferred authentication
method for the HTTP backend and it always ends up with the CURL's
default
settings.

This patch enables it if supported by CURL, adding a couple of new
settings
and config environment variables listed below (the names within the
parentheses indicate the latter.)

- http.auth (GIT_HTTP_AUTH)
  Specifies the preferred authentication method for HTTP.  This can
  be a method name or the combination of those separated by comma. Valid
  values are "basic", "digest", "gss" and "ntlm". You can also specify
  "any" (all of the above), "anysafe" (all of the above except "basic").

  Note that the strings are treated case-insensitive.

- http.proxy_auth (GIT_HTTP_PROXY_AUTH)
  Specifies the preferred authentication method method for HTTP proxy.
  The same thing as above applies to this setting.

Signed-off-by: Moriyoshi Koizumi <mozo@mozo.jp>
---
 http.c |  105
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 105 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index ee58799..889135f 100644
--- a/http.c
+++ b/http.c
@@ -25,6 +25,12 @@ static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv = 0;
 static const char *curl_http_proxy = NULL;
+#if LIBCURL_VERSION_NUM >= 0x070a06
+static const char *curl_http_auth = NULL;
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070a07
+static const char *curl_http_proxy_auth = NULL;
+#endif
 
 static struct curl_slist *pragma_header;
 
@@ -153,11 +159,67 @@ static int http_options(const char *var, const
char *value, void *cb)
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
+	char *buf = xmalloc(strlen(auth_method) + 1);
+	const unsigned char *p = (const unsigned char *)auth_method;
+	long mask = CURLAUTH_NONE;
+
+	for (;;) {
+		char *q = buf;
+		while (*p && isspace(*p))
+			++p;
+
+		while (*p && *p != ',')
+			*q++ = tolower(*p++);
+
+		while (--q >= buf && isspace(*(unsigned char *)q));
+		++q;
+
+		*q = '\0';
+
+		if (strcmp(buf, "basic") == 0)
+			mask |= CURLAUTH_BASIC;
+		else if (strcmp(buf, "digest") == 0)
+			mask |= CURLAUTH_DIGEST;
+		else if (strcmp(buf, "gss") == 0)
+			mask |= CURLAUTH_GSSNEGOTIATE;
+		else if (strcmp(buf, "ntlm") == 0)
+			mask |= CURLAUTH_NTLM;
+		else if (strcmp(buf, "any") == 0)
+			mask |= CURLAUTH_ANY;
+		else if (strcmp(buf, "anysafe") == 0)
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
@@ -210,6 +272,20 @@ static CURL* get_curl_handle(void)
 	if (curl_http_proxy)
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
 
+	if (curl_http_auth) {
+		long n = get_curl_auth_bitmask(curl_http_auth);
+		curl_easy_setopt(result, CURLOPT_HTTPAUTH, n);
+	}
+
+	if (curl_http_proxy) {
+		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+
+		if (curl_http_proxy_auth) {
+			long n = get_curl_auth_bitmask(curl_http_proxy_auth);
+			curl_easy_setopt(result, CURLOPT_PROXYAUTH, n);
+		}
+	}
+
 	return result;
 }
 
@@ -258,6 +334,21 @@ void http_init(struct remote *remote)
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
@@ -309,6 +400,20 @@ void http_cleanup(void)
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
