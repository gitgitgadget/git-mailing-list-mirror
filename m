From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v6 1/4] config: add support for http.<url>.* settings
Date: Fri, 19 Jul 2013 05:48:42 -0700
Message-ID: <296e6ff588bb131a7e8274738d4378c@f74d39fa044aa309eaea14b9f57fe79>
References: <9a5e7ef2eb19b10b28f154b3d5e03cd@f74d39fa044aa309eaea14b9f57fe79>
Cc: David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 14:49:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0A7O-00082r-Oq
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 14:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759997Ab3GSMs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 08:48:59 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:60914 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab3GSMs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 08:48:57 -0400
Received: by mail-pd0-f180.google.com with SMTP id 10so4188152pdi.39
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 05:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Clxyy7EpPRVQaP2UayGFF38IaxmVsg4Tu3UGzGY4mrM=;
        b=ZN7SV+tf+d3bczChSaI2hP9Jo4xMchAnDd9Aiau+6msSwZDd/MqgSSLx/i61onI9FK
         hIURNkMqHBvvc8IFWGZ/uc9rJl03kjK/ODluPN5WyxNr8Vd+c7G98qYehkjEnC7lFv9t
         4jMg5n//Jbgh6x7brrN8kcxG/60Tqod6laKLG2ApUT/NahNz5jck07hmL9B669nB/TwN
         pbuJkBJXqpwoYQh64ZDQpjCXXitS3lVNM8sAVDpcM7kra4dvkiKW4fBxXzsH9k/cPtdY
         2CWRYhGn3KtUERqrumHQJ08y10K5nXibuBroDgR5JH/ewN4wRaq0e/cyo/ZpulmCqOGS
         VHpQ==
X-Received: by 10.69.13.132 with SMTP id ey4mr17063280pbd.52.1374238136939;
        Fri, 19 Jul 2013 05:48:56 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ry2sm19426942pbc.41.2013.07.19.05.48.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 05:48:56 -0700 (PDT)
In-Reply-To: <9a5e7ef2eb19b10b28f154b3d5e03cd@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230802>

The credentials configuration values already support url-specific
configuration items in the form credential.<url>.*.  This patch
adds similar support for http configuration values.

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
 Documentation/config.txt |  15 +++++
 http.c                   | 169 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 167 insertions(+), 17 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6e53fc5..41cab91 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1513,6 +1513,21 @@ http.useragent::
 	of common USER_AGENT strings (but not including those like git/1.7.1).
 	Can be overridden by the 'GIT_HTTP_USER_AGENT' environment variable.
 
+http.<url>.*::
+	Any of the http.* options above can be applied selectively to some urls.
+	For example "http.https://example.com.useragent" would set the user
+	agent only for https connections to example.com.  The <url> value
+	matches a url if it is an exact match or a prefix of the url matching
+	at a "/" boundary.  Longer <url> matches take precedence over shorter
+	ones with the environment variable settings taking precedence over all.
+	Note that <url> must match the url passed to git exactly (other than
+	possibly being a prefix).  This means any user, password and/or port
+	setting that appears in a url as well as any %XX escapes that are
+	present must also appear in <url> to have a successful match.  The urls
+	that are matched against are those given directly to git commands.  In
+	other words, use exactly the same url that was passed to git (possibly
+	shortened) for the <url> value of the config setting.
+
 i18n.commitEncoding::
 	Character encoding the commit messages are stored in; Git itself
 	does not care per se, but this information is necessary e.g. when
diff --git a/http.c b/http.c
index 37986f8..f61a79c 100644
--- a/http.c
+++ b/http.c
@@ -30,6 +30,34 @@ static CURL *curl_default;
 
 char curl_errorstr[CURL_ERROR_SIZE];
 
+enum http_option_type {
+	OPT_POST_BUFFER,
+	OPT_MIN_SESSIONS,
+	OPT_SSL_VERIFY,
+	OPT_SSL_TRY,
+	OPT_SSL_CERT,
+	OPT_SSL_CAINFO,
+	OPT_LOW_SPEED,
+	OPT_LOW_TIME,
+	OPT_NO_EPSV,
+	OPT_HTTP_PROXY,
+	OPT_COOKIE_FILE,
+	OPT_USER_AGENT,
+	OPT_PASSWD_REQ,
+#ifdef USE_CURL_MULTI
+	OPT_MAX_REQUESTS,
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070903
+	OPT_SSL_KEY,
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070908
+	OPT_SSL_CAPATH,
+#endif
+	OPT_MAX
+};
+
+static size_t http_option_max_matched_len[OPT_MAX];
+
 static int curl_ssl_verify = -1;
 static int curl_ssl_try;
 static const char *ssl_cert;
@@ -141,33 +169,121 @@ static void process_curl_messages(void)
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
+static int new_match_is_shorter(size_t matchlen, enum http_option_type opt)
+{
+	/*
+	 * Compare matchlen to the last matched length of option opt and
+	 * return true if matchlen is shorter than the last matched length
+	 * (meaning the config setting should be ignored).  Upon seeing the
+	 * _same_ key (i.e. new key has the same match length which is therefore
+	 * not shorter) the new setting will override the previous setting.
+	 * Otherwise return false and record matchlen as the current last
+	 * matched length of option opt.
+	 */
+	if (matchlen < http_option_max_matched_len[opt])
+		return 1;
+	http_option_max_matched_len[opt] = matchlen;
+	return 0;
+}
+
 static int http_options(const char *var, const char *value, void *cb)
 {
-	if (!strcmp("http.sslverify", var)) {
+	const char *url = cb;
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
+		if (new_match_is_shorter(matchlen, OPT_SSL_VERIFY))
+			return 0;
 		curl_ssl_verify = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp("http.sslcert", var))
+	if (!strcmp("sslcert", key)) {
+		if (new_match_is_shorter(matchlen, OPT_SSL_CERT))
+			return 0;
 		return git_config_string(&ssl_cert, var, value);
+	}
 #if LIBCURL_VERSION_NUM >= 0x070903
-	if (!strcmp("http.sslkey", var))
+	if (!strcmp("sslkey", key)) {
+		if (new_match_is_shorter(matchlen, OPT_SSL_KEY))
+			return 0;
 		return git_config_string(&ssl_key, var, value);
+	}
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
-	if (!strcmp("http.sslcapath", var))
+	if (!strcmp("sslcapath", key)) {
+		if (new_match_is_shorter(matchlen, OPT_SSL_CAPATH))
+			return 0;
 		return git_config_string(&ssl_capath, var, value);
+	}
 #endif
-	if (!strcmp("http.sslcainfo", var))
+	if (!strcmp("sslcainfo", key)) {
+		if (new_match_is_shorter(matchlen, OPT_SSL_CAINFO))
+			return 0;
 		return git_config_string(&ssl_cainfo, var, value);
-	if (!strcmp("http.sslcertpasswordprotected", var)) {
+	}
+	if (!strcmp("sslcertpasswordprotected", key)) {
+		if (new_match_is_shorter(matchlen, OPT_PASSWD_REQ))
+			return 0;
 		ssl_cert_password_required = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp("http.ssltry", var)) {
+	if (!strcmp("ssltry", key)) {
+		if (new_match_is_shorter(matchlen, OPT_SSL_TRY))
+			return 0;
 		curl_ssl_try = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp("http.minsessions", var)) {
+	if (!strcmp("minsessions", key)) {
+		if (new_match_is_shorter(matchlen, OPT_MIN_SESSIONS))
+			return 0;
 		min_curl_sessions = git_config_int(var, value);
 #ifndef USE_CURL_MULTI
 		if (min_curl_sessions > 1)
@@ -176,39 +292,58 @@ static int http_options(const char *var, const char *value, void *cb)
 		return 0;
 	}
 #ifdef USE_CURL_MULTI
-	if (!strcmp("http.maxrequests", var)) {
+	if (!strcmp("maxrequests", key)) {
+		if (new_match_is_shorter(matchlen, OPT_MAX_REQUESTS))
+			return 0;
 		max_requests = git_config_int(var, value);
 		return 0;
 	}
 #endif
-	if (!strcmp("http.lowspeedlimit", var)) {
+	if (!strcmp("lowspeedlimit", key)) {
+		if (new_match_is_shorter(matchlen, OPT_LOW_SPEED))
+			return 0;
 		curl_low_speed_limit = (long)git_config_int(var, value);
 		return 0;
 	}
-	if (!strcmp("http.lowspeedtime", var)) {
+	if (!strcmp("lowspeedtime", key)) {
+		if (new_match_is_shorter(matchlen, OPT_LOW_TIME))
+			return 0;
 		curl_low_speed_time = (long)git_config_int(var, value);
 		return 0;
 	}
 
-	if (!strcmp("http.noepsv", var)) {
+	if (!strcmp("noepsv", key)) {
+		if (new_match_is_shorter(matchlen, OPT_NO_EPSV))
+			return 0;
 		curl_ftp_no_epsv = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp("http.proxy", var))
+	if (!strcmp("proxy", key)) {
+		if (new_match_is_shorter(matchlen, OPT_HTTP_PROXY))
+			return 0;
 		return git_config_string(&curl_http_proxy, var, value);
+	}
 
-	if (!strcmp("http.cookiefile", var))
+	if (!strcmp("cookiefile", key)) {
+		if (new_match_is_shorter(matchlen, OPT_COOKIE_FILE))
+			return 0;
 		return git_config_string(&curl_cookie_file, var, value);
+	}
 
-	if (!strcmp("http.postbuffer", var)) {
+	if (!strcmp("postbuffer", key)) {
+		if (new_match_is_shorter(matchlen, OPT_POST_BUFFER))
+			return 0;
 		http_post_buffer = git_config_int(var, value);
 		if (http_post_buffer < LARGE_PACKET_MAX)
 			http_post_buffer = LARGE_PACKET_MAX;
 		return 0;
 	}
 
-	if (!strcmp("http.useragent", var))
+	if (!strcmp("useragent", key)) {
+		if (new_match_is_shorter(matchlen, OPT_USER_AGENT))
+			return 0;
 		return git_config_string(&user_agent, var, value);
+	}
 
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
@@ -337,7 +472,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 
 	http_is_verbose = 0;
 
-	git_config(http_options, NULL);
+	git_config(http_options, (void *)url);
 
 	curl_global_init(CURL_GLOBAL_ALL);
 
-- 
1.8.3
