Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 073F01FF6D
	for <e@80x24.org>; Thu,  1 Dec 2016 09:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933040AbcLAJL0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 04:11:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:49669 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758242AbcLAJEm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 04:04:42 -0500
Received: (qmail 4994 invoked by uid 109); 1 Dec 2016 09:04:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 09:04:30 +0000
Received: (qmail 30692 invoked by uid 111); 1 Dec 2016 09:05:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 04:05:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 04:04:28 -0500
Date:   Thu, 1 Dec 2016 04:04:28 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>
Subject: [PATCH 4/6] http: make redirects more obvious
Message-ID: <20161201090428.pweq7slwujbne5hg@sigill.intra.peff.net>
References: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We instruct curl to always follow HTTP redirects. This is
convenient, but it creates opportunities for malicious
servers to create confusing situations. For instance,
imagine Alice is a git user with access to a private
repository on Bob's server. Mallory runs her own server and
wants to access objects from Bob's repository.

Mallory may try a few tricks that involve asking Alice to
clone from her, build on top, and then push the result:

  1. Mallory may simply redirect all fetch requests to Bob's
     server. Git will transparently follow those redirects
     and fetch Bob's history, which Alice may believe she
     got from Mallory. The subsequent push seems like it is
     just feeding Mallory back her own objects, but is
     actually leaking Bob's objects. There is nothing in
     git's output to indicate that Bob's repository was
     involved at all.

     The downside (for Mallory) of this attack is that Alice
     will have received Bob's entire repository, and is
     likely to notice that when building on top of it.

  2. If Mallory happens to know the sha1 of some object X in
     Bob's repository, she can instead build her own history
     that references that object. She then runs a dumb http
     server, and Alice's client will fetch each object
     individually. When it asks for X, Mallory redirects her
     to Bob's server. The end result is that Alice obtains
     objects from Bob, but they may be buried deep in
     history. Alice is less likely to notice.

Both of these attacks are fairly hard to pull off. There's a
social component in getting Mallory to convince Alice to
work with her. Alice may be prompted for credentials in
accessing Bob's repository (but not always, if she is using
a credential helper that caches). Attack (1) requires a
certain amount of obliviousness on Alice's part while making
a new commit. Attack (2) requires that Mallory knows a sha1
in Bob's repository, that Bob's server supports dumb http,
and that the object in question is loose on Bob's server.

But we can probably make things a bit more obvious without
any loss of functionality. This patch does two things to
that end.

First, when we encounter a whole-repo redirect during the
initial ref discovery, we now inform the user on stderr,
making attack (1) much more obvious.

Second, the decision to follow redirects is now
configurable. The truly paranoid can set the new
http.followRedirects to false to avoid any redirection
entirely. But for a more practical default, we will disallow
redirects only after the initial ref discovery. This is
enough to thwart attacks similar to (2), while still
allowing the common use of redirects at the repository
level. Since c93c92f30 (http: update base URLs when we see
redirects, 2013-09-28) we re-root all further requests from
the redirect destination, which should generally mean that
no further redirection is necessary.

As an escape hatch, in case there really is a server that
needs to redirect individual requests, the user can set
http.followRedirects to "true" (and this can be done on a
per-server basis via http.*.followRedirects config).

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt   | 10 ++++++++++
 http.c                     | 33 ++++++++++++++++++++++++++++++---
 http.h                     | 10 +++++++++-
 remote-curl.c              |  4 ++++
 t/lib-httpd/apache.conf    |  6 ++++++
 t/t5550-http-fetch-dumb.sh | 23 +++++++++++++++++++++++
 6 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a0ab66aae..d51182a06 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1891,6 +1891,16 @@ http.userAgent::
 	of common USER_AGENT strings (but not including those like git/1.7.1).
 	Can be overridden by the `GIT_HTTP_USER_AGENT` environment variable.
 
+http.followRedirects::
+	Whether git should follow HTTP redirects. If set to `true`, git
+	will transparently follow any redirect issued by a server it
+	encounters. If set to `false`, git will treat all redirects as
+	errors. If set to `initial`, git will follow redirects only for
+	the initial request to a remote, but not for subsequent
+	follow-up HTTP requests. Since git uses the redirected URL as
+	the base for the follow-up requests, this is generally
+	sufficient. The default is `initial`.
+
 http.<url>.*::
 	Any of the http.* options above can be applied selectively to some URLs.
 	For a config key to match a URL, each element of the config key is
diff --git a/http.c b/http.c
index ba03beead..825118481 100644
--- a/http.c
+++ b/http.c
@@ -111,6 +111,8 @@ static int http_proactive_auth;
 static const char *user_agent;
 static int curl_empty_auth;
 
+enum http_follow_config http_follow_config = HTTP_FOLLOW_INITIAL;
+
 #if LIBCURL_VERSION_NUM >= 0x071700
 /* Use CURLOPT_KEYPASSWD as is */
 #elif LIBCURL_VERSION_NUM >= 0x070903
@@ -366,6 +368,16 @@ static int http_options(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp("http.followredirects", var)) {
+		if (value && !strcmp(value, "initial"))
+			http_follow_config = HTTP_FOLLOW_INITIAL;
+		else if (git_config_bool(var, value))
+			http_follow_config = HTTP_FOLLOW_ALWAYS;
+		else
+			http_follow_config = HTTP_FOLLOW_NONE;
+		return 0;
+	}
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
 }
@@ -717,7 +729,6 @@ static CURL *get_curl_handle(void)
 				 curl_low_speed_time);
 	}
 
-	curl_easy_setopt(result, CURLOPT_FOLLOWLOCATION, 1);
 	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
 #if LIBCURL_VERSION_NUM >= 0x071301
 	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
@@ -1044,6 +1055,16 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_RANGE, NULL);
 
+	/*
+	 * Default following to off unless "ALWAYS" is configured; this gives
+	 * callers a sane starting point, and they can tweak for individual
+	 * HTTP_FOLLOW_* cases themselves.
+	 */
+	if (http_follow_config == HTTP_FOLLOW_ALWAYS)
+		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
+	else
+		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 0);
+
 #if LIBCURL_VERSION_NUM >= 0x070a08
 	curl_easy_setopt(slot->curl, CURLOPT_IPRESOLVE, git_curl_ipresolve);
 #endif
@@ -1286,9 +1307,12 @@ static int handle_curl_result(struct slot_results *results)
 	 * If we see a failing http code with CURLE_OK, we have turned off
 	 * FAILONERROR (to keep the server's custom error response), and should
 	 * translate the code into failure here.
+	 *
+	 * Likewise, if we see a redirect (30x code), that means we turned off
+	 * redirect-following, and we should treat the result as an error.
 	 */
 	if (results->curl_result == CURLE_OK &&
-	    results->http_code >= 400) {
+	    results->http_code >= 300) {
 		results->curl_result = CURLE_HTTP_RETURNED_ERROR;
 		/*
 		 * Normally curl will already have put the "reason phrase"
@@ -1607,6 +1631,9 @@ static int http_request(const char *url,
 		strbuf_addstr(&buf, " no-cache");
 	if (options && options->keep_error)
 		curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
+	if (options && options->initial_request &&
+	    http_follow_config == HTTP_FOLLOW_INITIAL)
+		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
 
 	headers = curl_slist_append(headers, buf.buf);
 
@@ -2030,7 +2057,7 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 		if (c != CURLE_OK)
 			die("BUG: curl_easy_getinfo for HTTP code failed: %s",
 				curl_easy_strerror(c));
-		if (slot->http_code >= 400)
+		if (slot->http_code >= 300)
 			return size;
 	}
 
diff --git a/http.h b/http.h
index 5ab9d9c32..02bccb7b0 100644
--- a/http.h
+++ b/http.h
@@ -116,6 +116,13 @@ extern struct credential http_auth;
 
 extern char curl_errorstr[CURL_ERROR_SIZE];
 
+enum http_follow_config {
+	HTTP_FOLLOW_NONE,
+	HTTP_FOLLOW_ALWAYS,
+	HTTP_FOLLOW_INITIAL
+};
+extern enum http_follow_config http_follow_config;
+
 static inline int missing__target(int code, int result)
 {
 	return	/* file:// URL -- do we ever use one??? */
@@ -139,7 +146,8 @@ extern char *get_remote_object_url(const char *url, const char *hex,
 /* Options for http_get_*() */
 struct http_get_options {
 	unsigned no_cache:1,
-		 keep_error:1;
+		 keep_error:1,
+		 initial_request:1;
 
 	/* If non-NULL, returns the content-type of the response. */
 	struct strbuf *content_type;
diff --git a/remote-curl.c b/remote-curl.c
index f4145fd5c..28d9d1063 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -296,6 +296,7 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	http_options.charset = &charset;
 	http_options.effective_url = &effective_url;
 	http_options.base_url = &url;
+	http_options.initial_request = 1;
 	http_options.no_cache = 1;
 	http_options.keep_error = 1;
 
@@ -314,6 +315,9 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		die("unable to access '%s': %s", url.buf, curl_errorstr);
 	}
 
+	if (options.verbosity && !starts_with(refs_url.buf, url.buf))
+		warning(_("redirecting to %s"), url.buf);
+
 	last= xcalloc(1, sizeof(*last_discovery));
 	last->service = service;
 	last->buf_alloc = strbuf_detach(&buffer, &last->len);
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index f98b23a3c..69174c6e3 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -123,6 +123,7 @@ ScriptAlias /error/ error.sh/
 </Files>
 
 RewriteEngine on
+RewriteRule ^/dumb-redir/(.*)$ /dumb/$1 [R=301]
 RewriteRule ^/smart-redir-perm/(.*)$ /smart/$1 [R=301]
 RewriteRule ^/smart-redir-temp/(.*)$ /smart/$1 [R=302]
 RewriteRule ^/smart-redir-auth/(.*)$ /auth/smart/$1 [R=301]
@@ -140,6 +141,11 @@ RewriteRule ^/loop-redir/(.*)$ /loop-redir/x-$1 [R=302]
 RewriteRule ^/insane-redir/(.*)$ /intern-redir/$1/foo [R=301]
 RewriteRule ^/intern-redir/(.*)/foo$ /smart/$1 [PT]
 
+# Serve info/refs internally without redirecting, but
+# issue a redirect for any object requests.
+RewriteRule ^/redir-objects/(.*/info/refs)$ /dumb/$1 [PT]
+RewriteRule ^/redir-objects/(.*/objects/.*)$ /dumb/$1 [R=301]
+
 # Apache 2.2 does not understand <RequireAll>, so we use RewriteCond.
 # And as RewriteCond does not allow testing for non-matches, we match
 # the desired case first (one has abra, two has cadabra), and let it
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 7641417b4..532507b7c 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -307,5 +307,28 @@ test_expect_success 'remote-http complains cleanly about malformed urls' '
 	test_must_fail git remote-http http::/example.com/repo.git
 '
 
+test_expect_success 'redirects can be forbidden/allowed' '
+	test_must_fail git -c http.followRedirects=false \
+		clone $HTTPD_URL/dumb-redir/repo.git dumb-redir &&
+	git -c http.followRedirects=true \
+		clone $HTTPD_URL/dumb-redir/repo.git dumb-redir 2>stderr
+'
+
+test_expect_success 'redirects are reported to stderr' '
+	# just look for a snippet of the redirected-to URL
+	test_i18ngrep /dumb/ stderr
+'
+
+test_expect_success 'non-initial redirects can be forbidden' '
+	test_must_fail git -c http.followRedirects=initial \
+		clone $HTTPD_URL/redir-objects/repo.git redir-objects &&
+	git -c http.followRedirects=true \
+		clone $HTTPD_URL/redir-objects/repo.git redir-objects
+'
+
+test_expect_success 'http.followRedirects defaults to "initial"' '
+	test_must_fail git clone $HTTPD_URL/redir-objects/repo.git default
+'
+
 stop_httpd
 test_done
-- 
2.11.0.319.g1f4e1e0

