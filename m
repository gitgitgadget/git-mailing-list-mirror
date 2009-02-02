From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] Support various HTTP authentication methods
Date: Sun,  1 Feb 2009 22:31:14 -0800
Message-ID: <1233556274-1354-4-git-send-email-gitster@pobox.com>
References: <1233556274-1354-1-git-send-email-gitster@pobox.com>
 <1233556274-1354-2-git-send-email-gitster@pobox.com>
 <1233556274-1354-3-git-send-email-gitster@pobox.com>
Cc: Moriyoshi Koizumi <mozo@mozo.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 07:33:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTsMl-0005wS-55
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 07:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbZBBGbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 01:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbZBBGbc
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 01:31:32 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbZBBGbb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 01:31:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9C66D94EAB;
	Mon,  2 Feb 2009 01:31:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6AD7494EA8; Mon,
  2 Feb 2009 01:31:28 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.333.ged98f
In-Reply-To: <1233556274-1354-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 20A373B4-F0F3-11DD-A9B5-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108052>

From: Moriyoshi Koizumi <mozo@mozo.jp>

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

Signed-off-by: Moriyoshi Koizumi <mozo@mozo.jp>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c |  128 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 127 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index 86be906..7eb849b 100644
--- a/http.c
+++ b/http.c
@@ -25,6 +25,14 @@ static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
+#if LIBCURL_VERSION_NUM >= 0x070a06
+static const char *curl_http_auth;
+static long http_auth_bitmask;
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070a07
+static const char *curl_http_proxy_auth;
+static long http_proxy_auth_bitmask;
+#endif
 
 static struct curl_slist *pragma_header;
 
@@ -152,11 +160,78 @@ static int http_options(const char *var, const char *value, void *cb)
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
+#define is_delim(x) (isspace(x) || x == ',')
+
+static long get_curl_auth_bitmask(const char *auth_method)
+{
+	char buf[20];
+	const unsigned char *p = (const unsigned char *)auth_method;
+	long mask = CURLAUTH_NONE;
+
+	for (;;) {
+		char *q = buf;
+		int toolong = 0;
+
+		while (*p && is_delim(*p))
+			p++;
+		if (!*p)
+			break;
+
+		while (*p && !is_delim(*p)) {
+			if (q < buf + sizeof(buf) - 1)
+				*q++ = tolower(*p);
+			else
+				toolong = 1;
+			p++;
+		}
+		if (toolong)
+			continue;
+
+		while (--q >= buf && is_delim(*q))
+			;
+		q++;
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
+		p++;
+	}
+
+	return mask;
+}
+#undef is_delim
+#endif
+
 static CURL *get_curl_handle(void)
 {
 	CURL *result = curl_easy_init();
@@ -206,12 +281,48 @@ static CURL *get_curl_handle(void)
 	if (curl_ftp_no_epsv)
 		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
 
-	if (curl_http_proxy)
+#if LIBCURL_VERSION_NUM >= 0x070a06
+	if (curl_http_auth)
+		curl_easy_setopt(result, CURLOPT_HTTPAUTH,
+				 http_auth_bitmask);
+#endif
+
+	if (curl_http_proxy) {
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+#if LIBCURL_VERSION_NUM >= 0x070a07
+		if (curl_http_proxy_auth)
+			curl_easy_setopt(result, CURLOPT_PROXYAUTH,
+					 http_proxy_auth_bitmask);
+#endif
+	}
 
 	return result;
 }
 
+static void prepare_http_auth_settings(void)
+{
+#if LIBCURL_VERSION_NUM >= 0x070a06
+	char *val;
+
+	val = getenv("GIT_HTTP_AUTH");
+	if (val)
+		curl_http_auth = val;
+
+	if (curl_http_auth) {
+		http_auth_bitmask = get_curl_auth_bitmask(curl_http_auth);
+	}
+
+#if LIBCURL_VERSION_NUM >= 0x070a07
+	val = getenv("GIT_HTTP_PROXY_AUTH");
+	if (val)
+		curl_http_proxy_auth = val;
+	if (curl_http_proxy_auth) {
+		http_proxy_auth_bitmask = get_curl_auth_bitmask(curl_http_proxy_auth);
+	}
+#endif
+#endif
+}
+
 void http_init(struct remote *remote)
 {
 	char *low_speed_limit;
@@ -258,6 +369,7 @@ void http_init(struct remote *remote)
 		curl_low_speed_time = strtol(low_speed_time, NULL, 10);
 
 	git_config(http_options, NULL);
+	prepare_http_auth_settings();
 
 	if (curl_ssl_verify == -1)
 		curl_ssl_verify = 1;
@@ -308,6 +420,20 @@ void http_cleanup(void)
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
1.6.1.2.333.ged98f
