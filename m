From: Kyle McKay <mackyle@gmail.com>
Subject: [PATCH] config: add support for http.<url>.* settings
Date: Thu, 4 Jul 2013 07:19:36 -0700
Message-ID: <279E20D1-6E36-42A0-A733-72C97C15D860@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 16:19:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UukNu-00038J-3M
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 16:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756249Ab3GDOTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 10:19:42 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:59142 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab3GDOTj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 10:19:39 -0400
Received: by mail-ob0-f178.google.com with SMTP id fb19so1686721obc.23
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 07:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:to:content-type:content-transfer-encoding:subject
         :mime-version:date:x-mailer;
        bh=KO+FmSUcYwUq1Hk/WORj3iiZQtHB2Q7RlGfDJGKsNWo=;
        b=iBDhEA6taeUv2zFH5qxkIELnkyUsq+McnbbLk778NJYwMvWYEYieqf7Kqiur4Nbye6
         A5nETm8uH2/pgnsu2yqBIAtf7LB5cPMHAup1wmHKy1ej9coy1M5RZqC7infAIqGb9OCI
         Py98wvmyoaWE/CPpTQzGD7xYVIEMVGGiHddeDDS+4l1MU01iE7F3auseMUCIEGHtX0U7
         aiDHrk6SOQZBM0jzdzY1HXIVzeI6hnUTE2pkxZthsffqKT0jzlkTgJoHlAKil7VZASwu
         55VdXuQzebegZWTTrJhcAMH4sQmoqAaOKlhUAvo8Jg0RIcKzW+ljqssxP1r2bMKZOF6X
         TBJw==
X-Received: by 10.182.53.194 with SMTP id d2mr6447082obp.28.1372947579241;
        Thu, 04 Jul 2013 07:19:39 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id qa4sm5727940oeb.5.2013.07.04.07.19.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jul 2013 07:19:38 -0700 (PDT)
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229589>

The <url> value is considered a match to a url if the <url>
value is a prefix of the url which ends on a path component
boundary ('/').  So "https://example.com/test" will match
"https://example.com/test" and "https://example.com/test/too"
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

All three of examples will have noEPSV enabled.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---

The credentials configuration values already support url-specific
configuration items in the form credential.<url>.*.  This patch
adds similar support for http configuration values.

Documentation/config.txt |   8 +++
http.c                   | 125 +++++++++++++++++++++++++++++++++++++++ 
+-------
2 files changed, 116 insertions(+), 17 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b4d4887..27d19a1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1531,6 +1531,14 @@ http.useragent::
	of common USER_AGENT strings (but not including those like git/1.7.1).
	Can be overridden by the 'GIT_HTTP_USER_AGENT' environment variable.

+http.<url>.*::
+	Any of the http.* options above can be applied selectively to some  
urls.
+	For example "http.https://example.com.useragent" would set the user
+	agent only for https connections to example.com.  The <url> value
+	matches a url if it is a prefix of the url matching at a '/' boundary.
+	Longer <url> matches take precedence over shorter ones with the
+	environment variable settings taking precedence over all.
+
i18n.commitEncoding::
	Character encoding the commit messages are stored in; Git itself
	does not care per se, but this information is necessary e.g. when
diff --git a/http.c b/http.c
index 2d086ae..7ddf9af 100644
--- a/http.c
+++ b/http.c
@@ -30,6 +30,34 @@ static CURL *curl_default;

char curl_errorstr[CURL_ERROR_SIZE];

+enum http_option_type {
+	o_post_buffer = 0,
+	o_min_sessions,
+#ifdef USE_CURL_MULTI
+	o_max_requests,
+#endif
+	o_ssl_verify,
+	o_ssl_try,
+	o_ssl_cert,
+#if LIBCURL_VERSION_NUM >= 0x070903
+	o_ssl_key,
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070908
+	o_ssl_capath,
+#endif
+	o_ssl_cainfo,
+	o_low_speed,
+	o_low_time,
+	o_no_epsv,
+	o_http_proxy,
+	o_cookie_file,
+	o_user_agent,
+	o_passwd_req,
+	o_max
+};
+
+static int http_option_maxlen[o_max];
+
static int curl_ssl_verify = -1;
static int curl_ssl_try;
static const char *ssl_cert;
@@ -65,6 +93,23 @@ static struct curl_slist *no_pragma_header;

static struct active_request_slot *active_queue_head;

+static int http_options_url_match(const char *url, const char  
*config_url)
+{
+	/*
+	 * config option with config_url matches url if config_url is a
+	 * prefix of url and the match ends on a path component boundary.
+	 * the return value is the length of the match in characters or
+	 * 0 for no match.
+	 */
+	size_t url_len, config_url_len = strlen(config_url);
+	if (!config_url || strncmp(url, config_url, config_url_len))
+		return 0;
+	url_len = strlen(url);
+	if (url_len == config_url_len || url[config_url_len - 1] == '/' ||  
url[config_url_len] == '/')
+		return url[config_url_len - 1] == '/' ? config_url_len - 1 :  
config_url_len;
+	return 0;
+}
+
size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void  
*buffer_)
{
	size_t size = eltsize * nmemb;
@@ -143,32 +188,65 @@ static void process_curl_messages(void)

static int http_options(const char *var, const char *value, void *cb)
{
-	if (!strcmp("http.sslverify", var)) {
+#define CHECKLEN(opt) if (http_option_maxlen[opt] > matchlen) return  
0; \
+		      else http_option_maxlen[opt] = matchlen
+
+	const char *url = (const char *)cb;
+	const char *key, *dot;
+	int matchlen = 0;
+
+	key = skip_prefix(var, "http.");
+	if (!key)
+		return git_default_config(var, value, cb);
+
+	dot = strrchr(key, '.');
+	if (dot) {
+		char *config_url = xmemdupz(key, dot - key);
+		matchlen = http_options_url_match(url, config_url);
+		free(config_url);
+		if (!matchlen)
+			return git_default_config(var, value, cb);
+		key = dot + 1;
+	}
+
+	if (!strcmp("sslverify", key)) {
+		CHECKLEN(o_ssl_verify);
		curl_ssl_verify = git_config_bool(var, value);
		return 0;
	}
-	if (!strcmp("http.sslcert", var))
+	if (!strcmp("sslcert", key)) {
+		CHECKLEN(o_ssl_cert);
		return git_config_string(&ssl_cert, var, value);
+	}
#if LIBCURL_VERSION_NUM >= 0x070903
-	if (!strcmp("http.sslkey", var))
+	if (!strcmp("sslkey", key)) {
+		CHECKLEN(o_ssl_key);
		return git_config_string(&ssl_key, var, value);
+	}
#endif
#if LIBCURL_VERSION_NUM >= 0x070908
-	if (!strcmp("http.sslcapath", var))
+	if (!strcmp("sslcapath", key)) {
+		CHECKLEN(o_ssl_capath);
		return git_config_string(&ssl_capath, var, value);
+	}
#endif
-	if (!strcmp("http.sslcainfo", var))
+	if (!strcmp("sslcainfo", key)) {
+		CHECKLEN(o_ssl_cainfo);
		return git_config_string(&ssl_cainfo, var, value);
-	if (!strcmp("http.sslcertpasswordprotected", var)) {
+	}
+	if (!strcmp("sslcertpasswordprotected", key)) {
+		CHECKLEN(o_passwd_req);
		if (git_config_bool(var, value))
			ssl_cert_password_required = 1;
		return 0;
	}
-	if (!strcmp("http.ssltry", var)) {
+	if (!strcmp("ssltry", key)) {
+		CHECKLEN(o_ssl_try);
		curl_ssl_try = git_config_bool(var, value);
		return 0;
	}
-	if (!strcmp("http.minsessions", var)) {
+	if (!strcmp("minsessions", key)) {
+		CHECKLEN(o_min_sessions);
		min_curl_sessions = git_config_int(var, value);
#ifndef USE_CURL_MULTI
		if (min_curl_sessions > 1)
@@ -177,42 +255,55 @@ static int http_options(const char *var, const  
char *value, void *cb)
		return 0;
	}
#ifdef USE_CURL_MULTI
-	if (!strcmp("http.maxrequests", var)) {
+	if (!strcmp("maxrequests", key)) {
+		CHECKLEN(o_max_requests);
		max_requests = git_config_int(var, value);
		return 0;
	}
#endif
-	if (!strcmp("http.lowspeedlimit", var)) {
+	if (!strcmp("lowspeedlimit", key)) {
+		CHECKLEN(o_low_speed);
		curl_low_speed_limit = (long)git_config_int(var, value);
		return 0;
	}
-	if (!strcmp("http.lowspeedtime", var)) {
+	if (!strcmp("lowspeedtime", key)) {
+		CHECKLEN(o_low_time);
		curl_low_speed_time = (long)git_config_int(var, value);
		return 0;
	}

-	if (!strcmp("http.noepsv", var)) {
+	if (!strcmp("noepsv", key)) {
+		CHECKLEN(o_no_epsv);
		curl_ftp_no_epsv = git_config_bool(var, value);
		return 0;
	}
-	if (!strcmp("http.proxy", var))
+	if (!strcmp("proxy", key)) {
+		CHECKLEN(o_http_proxy);
		return git_config_string(&curl_http_proxy, var, value);
+	}

-	if (!strcmp("http.cookiefile", var))
+	if (!strcmp("cookiefile", key)) {
+		CHECKLEN(o_cookie_file);
		return git_config_string(&curl_cookie_file, var, value);
+	}

-	if (!strcmp("http.postbuffer", var)) {
+	if (!strcmp("postbuffer", key)) {
+		CHECKLEN(o_post_buffer);
		http_post_buffer = git_config_int(var, value);
		if (http_post_buffer < LARGE_PACKET_MAX)
			http_post_buffer = LARGE_PACKET_MAX;
		return 0;
	}

-	if (!strcmp("http.useragent", var))
+	if (!strcmp("useragent", key)) {
+		CHECKLEN(o_user_agent);
		return git_config_string(&user_agent, var, value);
+	}

	/* Fall back on the default ones */
	return git_default_config(var, value, cb);
+
+#undef CHECKLEN
}

static void init_curl_http_auth(CURL *result)
@@ -344,7 +435,7 @@ void http_init(struct remote *remote, const char  
*url, int proactive_auth)

	http_is_verbose = 0;

-	git_config(http_options, NULL);
+	git_config(http_options, (void *)url);

	curl_global_init(CURL_GLOBAL_ALL);

-- 
1.8.3
