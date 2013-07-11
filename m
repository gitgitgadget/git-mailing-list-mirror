From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v2] config: add support for http.<url>.* settings
Date: Thu, 11 Jul 2013 09:47:15 -0700
Message-ID: <26507a43bd82855050b90f6a2b9d01bd@f74d39fa044aa309eaea14b9f57fe79c>
Cc: David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 11 18:47:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxK1i-0005zC-Hs
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 18:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490Ab3GKQr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 12:47:26 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:44221 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076Ab3GKQrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 12:47:25 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so8069889pab.41
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 09:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0lQBrr/ft/o3z99uIfdQkUjX8WFbfI0qVs5myBH4jBA=;
        b=Iv50Lu5xGpfY3QT2tiuztBV/Z6svvI0cyo3sVL8kVgFDEsFVccP/Imwyf6ysAGhua4
         djg92WAgP3Sx5eO80YNAblGXtda7B1pDsuGc3GRDJy9YLurL+LVrz6o9Nbp3ZzmFZt58
         nip/HBosCv+8lZQgq1JclFy3ak1D8BLiBiyjjzop8KPZBQ+5hj4BtOol9IhI4vBpD8uS
         gQh8+vOv61liU3aIbuU0qZiV2arq14xGPs3exjpvf6Hq4O1I/rUfMoWY5w5KJpn+7X8n
         Y/oqYpV67RiGnxs5NnGhrijKoPQfED+uNboAxF5xOxCrzbZ6EaPDGcwanV9Mq443bS26
         nTLg==
X-Received: by 10.68.41.106 with SMTP id e10mr38119089pbl.136.1373561244631;
        Thu, 11 Jul 2013 09:47:24 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id iv4sm40625295pbc.9.2013.07.11.09.47.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Jul 2013 09:47:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230118>

From: "Kyle J. McKay" <mackyle@gmail.com>

The <url> value is considered a match to a url if the <url> value
is either an exact match or a prefix of the url which ends on a
path component boundary ('/').  So "https://example.com/test" will
match "https://example.com/test" and "https://example.com/test/too"
but not "https://example.com/testextra".

Longer matches take precedence over shorter matches with
environment variable settings taking precedence over all.

With this configuration:

[http]
        useragent = other-agent
        noEPSV = true
[http "https://example.com"]
        useragent = example-agent
        sslVerify = false
[http "https://example.com/path"]
        useragent = path-agent

The "https://other.example.com/" url will have useragent
"other-agent" and sslVerify will be on.

The "https://example.com/" url will have useragent
"example-agent" and sslVerify will be off.

The "https://example.com/path/sub" url will have useragent
"path-agent" and sslVerify will be off.

All three of the examples will have noEPSV enabled.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---

The credentials configuration values already support url-specific
configuration items in the form credential.<url>.*.  This patch
adds similar support for http configuration values.

 Documentation/config.txt |  11 ++++
 http.c                   | 140 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 134 insertions(+), 17 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b4d4887..3731a3a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1531,6 +1531,17 @@ http.useragent::
 	of common USER_AGENT strings (but not including those like git/1.7.1).
 	Can be overridden by the 'GIT_HTTP_USER_AGENT' environment variable.
 
+http.<url>.*::
+	Any of the http.* options above can be applied selectively to some urls.
+	For example "http.https://example.com.useragent" would set the user
+	agent only for https connections to example.com.  The <url> value
+	matches a url if it is an exact match or a prefix of the url matching
+	at a '/' boundary.  Longer <url> matches take precedence over shorter
+	ones with the environment variable settings taking precedence over all.
+	Note that <url> must match the url exactly (other than possibly being a
+	prefix).  This means any user, password and/or port setting that appears
+	in a url must also appear in <url> to have a successful match.
+
 i18n.commitEncoding::
 	Character encoding the commit messages are stored in; Git itself
 	does not care per se, but this information is necessary e.g. when
diff --git a/http.c b/http.c
index 2d086ae..68dc789 100644
--- a/http.c
+++ b/http.c
@@ -30,6 +30,34 @@ static CURL *curl_default;
 
 char curl_errorstr[CURL_ERROR_SIZE];
 
+enum http_option_type {
+	opt_post_buffer = 0,
+	opt_min_sessions,
+#ifdef USE_CURL_MULTI
+	opt_max_requests,
+#endif
+	opt_ssl_verify,
+	opt_ssl_try,
+	opt_ssl_cert,
+#if LIBCURL_VERSION_NUM >= 0x070903
+	opt_ssl_key,
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070908
+	opt_ssl_capath,
+#endif
+	opt_ssl_cainfo,
+	opt_low_speed,
+	opt_low_time,
+	opt_no_epsv,
+	opt_http_proxy,
+	opt_cookie_file,
+	opt_user_agent,
+	opt_passwd_req,
+	opt_max
+};
+
+static int http_option_maxlen[opt_max];
+
 static int curl_ssl_verify = -1;
 static int curl_ssl_try;
 static const char *ssl_cert;
@@ -141,34 +169,99 @@ static void process_curl_messages(void)
 }
 #endif
 
+static int http_options_url_match_prefix(const char *url, const char *url_prefix)
+{
+	/*
+	 * url_prefix matches url if url_prefix is an exact match for url or it
+	 * is a prefix of url and the match ends on a path component boundary.
+	 * url_prefix is considered to have an implicit '/' on the end for
+	 * matching purposes if it does not already and it is shorter than url.
+	 * the return value is the length of the match in characters (excluding
+	 * any final '/') or 0 for no match.
+	 */
+	size_t url_len, url_prefix_len = strlen(url_prefix);
+	if (!url_prefix_len || strncmp(url, url_prefix, url_prefix_len))
+		return 0;
+	url_len = strlen(url);
+	if (url_len == url_prefix_len || url[url_prefix_len - 1] == '/' || url[url_prefix_len] == '/')
+		return url[url_prefix_len - 1] == '/' ? url_prefix_len - 1 : url_prefix_len;
+	return 0;
+}
+
 static int http_options(const char *var, const char *value, void *cb)
 {
-	if (!strcmp("http.sslverify", var)) {
+/*
+ * Macro to ignore matches with a match length less than previously seen
+ * for the same option type and to remember the largest match length seen so
+ * far for each option type
+ */
+#define CHECK_MATCHLEN(opt) \
+	if (http_option_maxlen[opt] > matchlen) return 0; \
+	else http_option_maxlen[opt] = matchlen
+
+	const char *url = (const char *)cb;
+	const char *key, *dot;
+	int matchlen = 0;
+
+	key = skip_prefix(var, "http.");
+	if (!key)
+		return git_default_config(var, value, cb);
+
+	/*
+	 * If the part following the leading "http." contains a '.' then check
+	 * to see if the part between "http." and the last '.' is a match to
+	 * url.  if it's not then ignore the setting.  Otherwise set key to
+	 * point to the option which is the final part after the final '.' and
+	 * use key in subsequent comparisons to determine the option type.
+	 */
+	dot = strrchr(key, '.');
+	if (dot) {
+		char *config_url = xmemdupz(key, dot - key);
+		matchlen = http_options_url_match_prefix(url, config_url);
+		free(config_url);
+		if (!matchlen)
+			return 0;
+		key = dot + 1;
+	}
+
+	if (!strcmp("sslverify", key)) {
+		CHECK_MATCHLEN(opt_ssl_verify);
 		curl_ssl_verify = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp("http.sslcert", var))
+	if (!strcmp("sslcert", key)) {
+		CHECK_MATCHLEN(opt_ssl_cert);
 		return git_config_string(&ssl_cert, var, value);
+	}
 #if LIBCURL_VERSION_NUM >= 0x070903
-	if (!strcmp("http.sslkey", var))
+	if (!strcmp("sslkey", key)) {
+		CHECK_MATCHLEN(opt_ssl_key);
 		return git_config_string(&ssl_key, var, value);
+	}
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
-	if (!strcmp("http.sslcapath", var))
+	if (!strcmp("sslcapath", key)) {
+		CHECK_MATCHLEN(opt_ssl_capath);
 		return git_config_string(&ssl_capath, var, value);
+	}
 #endif
-	if (!strcmp("http.sslcainfo", var))
+	if (!strcmp("sslcainfo", key)) {
+		CHECK_MATCHLEN(opt_ssl_cainfo);
 		return git_config_string(&ssl_cainfo, var, value);
-	if (!strcmp("http.sslcertpasswordprotected", var)) {
+	}
+	if (!strcmp("sslcertpasswordprotected", key)) {
+		CHECK_MATCHLEN(opt_passwd_req);
 		if (git_config_bool(var, value))
 			ssl_cert_password_required = 1;
 		return 0;
 	}
-	if (!strcmp("http.ssltry", var)) {
+	if (!strcmp("ssltry", key)) {
+		CHECK_MATCHLEN(opt_ssl_try);
 		curl_ssl_try = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp("http.minsessions", var)) {
+	if (!strcmp("minsessions", key)) {
+		CHECK_MATCHLEN(opt_min_sessions);
 		min_curl_sessions = git_config_int(var, value);
 #ifndef USE_CURL_MULTI
 		if (min_curl_sessions > 1)
@@ -177,42 +270,55 @@ static int http_options(const char *var, const char *value, void *cb)
 		return 0;
 	}
 #ifdef USE_CURL_MULTI
-	if (!strcmp("http.maxrequests", var)) {
+	if (!strcmp("maxrequests", key)) {
+		CHECK_MATCHLEN(opt_max_requests);
 		max_requests = git_config_int(var, value);
 		return 0;
 	}
 #endif
-	if (!strcmp("http.lowspeedlimit", var)) {
+	if (!strcmp("lowspeedlimit", key)) {
+		CHECK_MATCHLEN(opt_low_speed);
 		curl_low_speed_limit = (long)git_config_int(var, value);
 		return 0;
 	}
-	if (!strcmp("http.lowspeedtime", var)) {
+	if (!strcmp("lowspeedtime", key)) {
+		CHECK_MATCHLEN(opt_low_time);
 		curl_low_speed_time = (long)git_config_int(var, value);
 		return 0;
 	}
 
-	if (!strcmp("http.noepsv", var)) {
+	if (!strcmp("noepsv", key)) {
+		CHECK_MATCHLEN(opt_no_epsv);
 		curl_ftp_no_epsv = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp("http.proxy", var))
+	if (!strcmp("proxy", key)) {
+		CHECK_MATCHLEN(opt_http_proxy);
 		return git_config_string(&curl_http_proxy, var, value);
+	}
 
-	if (!strcmp("http.cookiefile", var))
+	if (!strcmp("cookiefile", key)) {
+		CHECK_MATCHLEN(opt_cookie_file);
 		return git_config_string(&curl_cookie_file, var, value);
+	}
 
-	if (!strcmp("http.postbuffer", var)) {
+	if (!strcmp("postbuffer", key)) {
+		CHECK_MATCHLEN(opt_post_buffer);
 		http_post_buffer = git_config_int(var, value);
 		if (http_post_buffer < LARGE_PACKET_MAX)
 			http_post_buffer = LARGE_PACKET_MAX;
 		return 0;
 	}
 
-	if (!strcmp("http.useragent", var))
+	if (!strcmp("useragent", key)) {
+		CHECK_MATCHLEN(opt_user_agent);
 		return git_config_string(&user_agent, var, value);
+	}
 
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
+
+#undef CHECKLEN
 }
 
 static void init_curl_http_auth(CURL *result)
@@ -344,7 +450,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 
 	http_is_verbose = 0;
 
-	git_config(http_options, NULL);
+	git_config(http_options, (void *)url);
 
 	curl_global_init(CURL_GLOBAL_ALL);
 
-- 
1.8.3
