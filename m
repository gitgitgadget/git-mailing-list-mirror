From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v4] config: add support for http.<url>.* settings
Date: Fri, 12 Jul 2013 04:20:04 -0700
Message-ID: <a2ef80fd50c466e5c69726a1968f8ad@f74d39fa044aa309eaea14b9f57fe79>
Cc: David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 13:20:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxbOg-0001sH-1A
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 13:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932876Ab3GLLUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 07:20:15 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:43426 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932637Ab3GLLUO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 07:20:14 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so8916760pac.29
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 04:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=fUysjrnYz1EgNC1sBELlhWzEW2FcaWHaz4LOy4d47vA=;
        b=o9rXLIdlw9Pv8KdQN/GoXi+Oh0pHGCad8avqlcE7AbYd64Swk2Ry9hC1buViwNXYRU
         Hvy1TZ04ujdsuV8A4omqxuTv7/R1fDq2ziyDTojhoRFZmJf0OUqyT45wiSxG9OnZmuks
         +ny7Gc+6Xp362EfxGg3ykyQEFmCnJ68Ezcq1iRAuvS99W3HewUzAsajoNlbQ3o2gdEE/
         kjDZTC5j2WjyA0zSFHkadX8rbzTtscvP2ayuPwpbHwOY+3Ud/Tx60i4bZF14Ai1IJN+T
         RSlclN23Kk1m0gq+RRZgX+5J1ooAfT2M3ggObZPg8wJdHnAocbgMxHj66oEx2XGnNPaM
         BnYA==
X-Received: by 10.66.2.164 with SMTP id 4mr43240812pav.55.1373628013554;
        Fri, 12 Jul 2013 04:20:13 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id py6sm44872091pbb.33.2013.07.12.04.20.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 04:20:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230194>

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
Reviewed-by: Junio C Hamano <gitster@pobox.com>
---

The credentials configuration values already support url-specific
configuration items in the form credential.<url>.*.  This patch
adds similar support for http configuration values.

This version of the patch addresses the following feedback:

  * The url[url_prefix_len-1] test can now never succeed.  It is removed.

  * More text added to check_matched_len to clarify behavior when two
    options have the same key.

 Documentation/config.txt |  11 ++++
 http.c                   | 168 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 162 insertions(+), 17 deletions(-)

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
index 2d086ae..feca70a 100644
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
+static size_t http_option_max_matched_len[opt_max];
+
 static int curl_ssl_verify = -1;
 static int curl_ssl_try;
 static const char *ssl_cert;
@@ -141,34 +169,121 @@ static void process_curl_messages(void)
 }
 #endif
 
+static size_t http_options_url_match_prefix(const char *url,
+					    const char *url_prefix,
+					    size_t url_prefix_len)
+{
+	/*
+	 * url_prefix matches url if url_prefix is an exact match for url or it
+	 * is a prefix of url and the match ends on a path component boundary.
+	 * Both url and url_prefix are considered to have an implicit '/' on the
+	 * end for matching purposes if they do not already.
+	 *
+	 * url must be NUL terminated.  url_prefix_len is the length of
+	 * url_prefix which need not be NUL terminated.
+	 *
+	 * The return value is the length of the match in characters (excluding
+	 * any final '/') or 0 for no match.  Passing "/" as url_prefix will
+	 * always cause 0 to be returned.
+	 */
+	size_t url_len;
+	if (url_prefix_len && url_prefix[url_prefix_len - 1] == '/')
+		url_prefix_len--;
+	if (!url_prefix_len || strncmp(url, url_prefix, url_prefix_len))
+		return 0;
+	url_len = strlen(url);
+	if ((url_len == url_prefix_len) || (url[url_prefix_len] == '/'))
+		return url_prefix_len;
+	return 0;
+}
+
+static int check_matched_len(enum http_option_type opt, size_t matchlen)
+{
+	/*
+	 * Check the last matched length of option opt against matchlen and
+	 * return true if the last matched length is larger (meaning the config
+	 * setting should be ignored).  Upon seeing the _same_ key (i.e. new key
+	 * has the same match length which is therefore not larger) the new
+	 * setting will override the previous setting.  Otherwise return false
+	 * and record matchlen as the current last matched length of option opt.
+	 */
+	if (http_option_max_matched_len[opt] > matchlen)
+		return 1;
+	http_option_max_matched_len[opt] = matchlen;
+	return 0;
+}
+
 static int http_options(const char *var, const char *value, void *cb)
 {
-	if (!strcmp("http.sslverify", var)) {
+	const char *url = (const char *)cb;
+	const char *key, *dot;
+	size_t matchlen = 0;
+
+	key = skip_prefix(var, "http.");
+	if (!key)
+		return git_default_config(var, value, cb);
+
+	/*
+	 * If the part following the leading "http." contains a '.' then check
+	 * to see if the part between "http." and the last '.' is a match to
+	 * url.  If it's not then ignore the setting.  Otherwise set key to
+	 * point to the option which is the part after the final '.' and
+	 * use key in subsequent comparisons to determine the option type.
+	 */
+	dot = strrchr(key, '.');
+	if (dot) {
+		matchlen = http_options_url_match_prefix(url, key, dot - key);
+		if (!matchlen)
+			return 0;
+		key = dot + 1;
+	}
+
+	if (!strcmp("sslverify", key)) {
+		if (check_matched_len(opt_ssl_verify, matchlen))
+			return 0;
 		curl_ssl_verify = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp("http.sslcert", var))
+	if (!strcmp("sslcert", key)) {
+		if (check_matched_len(opt_ssl_cert, matchlen))
+			return 0;
 		return git_config_string(&ssl_cert, var, value);
+	}
 #if LIBCURL_VERSION_NUM >= 0x070903
-	if (!strcmp("http.sslkey", var))
+	if (!strcmp("sslkey", key)) {
+		if (check_matched_len(opt_ssl_key, matchlen))
+			return 0;
 		return git_config_string(&ssl_key, var, value);
+	}
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
-	if (!strcmp("http.sslcapath", var))
+	if (!strcmp("sslcapath", key)) {
+		if (check_matched_len(opt_ssl_capath, matchlen))
+			return 0;
 		return git_config_string(&ssl_capath, var, value);
+	}
 #endif
-	if (!strcmp("http.sslcainfo", var))
+	if (!strcmp("sslcainfo", key)) {
+		if (check_matched_len(opt_ssl_cainfo, matchlen))
+			return 0;
 		return git_config_string(&ssl_cainfo, var, value);
-	if (!strcmp("http.sslcertpasswordprotected", var)) {
+	}
+	if (!strcmp("sslcertpasswordprotected", key)) {
+		if (check_matched_len(opt_passwd_req, matchlen))
+			return 0;
 		if (git_config_bool(var, value))
 			ssl_cert_password_required = 1;
 		return 0;
 	}
-	if (!strcmp("http.ssltry", var)) {
+	if (!strcmp("ssltry", key)) {
+		if (check_matched_len(opt_ssl_try, matchlen))
+			return 0;
 		curl_ssl_try = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp("http.minsessions", var)) {
+	if (!strcmp("minsessions", key)) {
+		if (check_matched_len(opt_min_sessions, matchlen))
+			return 0;
 		min_curl_sessions = git_config_int(var, value);
 #ifndef USE_CURL_MULTI
 		if (min_curl_sessions > 1)
@@ -177,39 +292,58 @@ static int http_options(const char *var, const char *value, void *cb)
 		return 0;
 	}
 #ifdef USE_CURL_MULTI
-	if (!strcmp("http.maxrequests", var)) {
+	if (!strcmp("maxrequests", key)) {
+		if (check_matched_len(opt_max_requests, matchlen))
+			return 0;
 		max_requests = git_config_int(var, value);
 		return 0;
 	}
 #endif
-	if (!strcmp("http.lowspeedlimit", var)) {
+	if (!strcmp("lowspeedlimit", key)) {
+		if (check_matched_len(opt_low_speed, matchlen))
+			return 0;
 		curl_low_speed_limit = (long)git_config_int(var, value);
 		return 0;
 	}
-	if (!strcmp("http.lowspeedtime", var)) {
+	if (!strcmp("lowspeedtime", key)) {
+		if (check_matched_len(opt_low_time, matchlen))
+			return 0;
 		curl_low_speed_time = (long)git_config_int(var, value);
 		return 0;
 	}
 
-	if (!strcmp("http.noepsv", var)) {
+	if (!strcmp("noepsv", key)) {
+		if (check_matched_len(opt_no_epsv, matchlen))
+			return 0;
 		curl_ftp_no_epsv = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp("http.proxy", var))
+	if (!strcmp("proxy", key)) {
+		if (check_matched_len(opt_http_proxy, matchlen))
+			return 0;
 		return git_config_string(&curl_http_proxy, var, value);
+	}
 
-	if (!strcmp("http.cookiefile", var))
+	if (!strcmp("cookiefile", key)) {
+		if (check_matched_len(opt_cookie_file, matchlen))
+			return 0;
 		return git_config_string(&curl_cookie_file, var, value);
+	}
 
-	if (!strcmp("http.postbuffer", var)) {
+	if (!strcmp("postbuffer", key)) {
+		if (check_matched_len(opt_post_buffer, matchlen))
+			return 0;
 		http_post_buffer = git_config_int(var, value);
 		if (http_post_buffer < LARGE_PACKET_MAX)
 			http_post_buffer = LARGE_PACKET_MAX;
 		return 0;
 	}
 
-	if (!strcmp("http.useragent", var))
+	if (!strcmp("useragent", key)) {
+		if (check_matched_len(opt_user_agent, matchlen))
+			return 0;
 		return git_config_string(&user_agent, var, value);
+	}
 
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
@@ -344,7 +478,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 
 	http_is_verbose = 0;
 
-	git_config(http_options, NULL);
+	git_config(http_options, (void *)url);
 
 	curl_global_init(CURL_GLOBAL_ALL);
 
-- 
1.8.3
