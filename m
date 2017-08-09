Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EC02208B4
	for <e@80x24.org>; Wed,  9 Aug 2017 12:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbdHIMB2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 08:01:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:33144 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752409AbdHIMB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 08:01:27 -0400
Received: (qmail 1838 invoked by uid 109); 9 Aug 2017 12:01:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 12:01:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26454 invoked by uid 111); 9 Aug 2017 12:01:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 08:01:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 08:01:24 -0400
Date:   Wed, 9 Aug 2017 08:01:24 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/4] http: drop support for curl < 7.11.1
Message-ID: <20170809120124.3i5xjmk7mfxzwmdq@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recent versions of Git will not build with curl older than
7.11.1 due to (at least) two issues:

  - our use of CURLOPT_POSTFIELDSIZE in 37ee680d9b
    (http.postbuffer: allow full range of ssize_t values,
    2017-04-11). This field was introduced in curl 7.11.1.

  - our use of CURLPROTO_* outside any #ifdef in aeae4db174
    (http: create function to get curl allowed protocols,
    2016-12-14). These were introduced in curl 7.19.4.

We could solve these compilation problems with more #ifdefs,
but it's not worth the trouble. Version 7.11.1 came out in
March of 2004, over 13 years ago. Let's declare that too old
and drop any existing ifdefs that go further back. One
obvious benefit is that we'll have fewer conditional bits
cluttering the code.

But more importantly, we're doing a disservice to users to
pretend that Git works with old versions. It's clear that
nobody is testing modern Git with such old versions of curl
(we've had 3 released versions with the CURLPROTO issue
without a report of anyone seeing the breakage in the wild).
And there are a lot of subtle ways we could be getting this
wrong (for instance, curl prior to 7.17.0 did not copy
string arguments to curl_easy_setopt(), which means that
using an old copy of curl could produce use-after-free
bugs that are not present with more recent versions).

This patch drops all #ifdefs that reference older versions
(note that curl's preprocessor macros are in hex, so we're
looking for 070b01, not 071101).

Signed-off-by: Jeff King <peff@peff.net>
---
There may be other problems, too.  I couldn't actually get a version of
curl older than 7.12.2 to compile due to bison/yacc woes.

 http.c        | 51 ---------------------------------------------------
 http.h        | 11 -----------
 remote-curl.c |  3 ---
 3 files changed, 65 deletions(-)

diff --git a/http.c b/http.c
index c6c010f881..a3675a0eaa 100644
--- a/http.c
+++ b/http.c
@@ -13,19 +13,11 @@
 #include "transport.h"
 
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
-#if LIBCURL_VERSION_NUM >= 0x070a08
 long int git_curl_ipresolve = CURL_IPRESOLVE_WHATEVER;
-#else
-long int git_curl_ipresolve;
-#endif
 int active_requests;
 int http_is_verbose;
 ssize_t http_post_buffer = 16 * LARGE_PACKET_MAX;
 
-#if LIBCURL_VERSION_NUM >= 0x070a06
-#define LIBCURL_CAN_HANDLE_AUTH_ANY
-#endif
-
 static int min_curl_sessions = 1;
 static int curl_session_count;
 #ifdef USE_CURL_MULTI
@@ -58,12 +50,8 @@ static struct {
 	{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
 #endif
 };
-#if LIBCURL_VERSION_NUM >= 0x070903
 static const char *ssl_key;
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
 static const char *ssl_capath;
-#endif
 #if LIBCURL_VERSION_NUM >= 0x072c00
 static const char *ssl_pinnedkey;
 #endif
@@ -82,9 +70,7 @@ static struct {
 	{ "digest", CURLAUTH_DIGEST },
 	{ "negotiate", CURLAUTH_GSSNEGOTIATE },
 	{ "ntlm", CURLAUTH_NTLM },
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 	{ "anyauth", CURLAUTH_ANY },
-#endif
 	/*
 	 * CURLAUTH_DIGEST_IE has no corresponding command-line option in
 	 * curl(1) and is not included in CURLAUTH_ANY, so we leave it out
@@ -124,7 +110,6 @@ enum http_follow_config http_follow_config = HTTP_FOLLOW_INITIAL;
 
 static struct credential cert_auth = CREDENTIAL_INIT;
 static int ssl_cert_password_required;
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 static unsigned long http_auth_methods = CURLAUTH_ANY;
 static int http_auth_methods_restricted;
 /* Modes for which empty_auth cannot actually help us. */
@@ -134,7 +119,6 @@ static unsigned long empty_auth_useless =
 	| CURLAUTH_DIGEST_IE
 #endif
 	| CURLAUTH_DIGEST;
-#endif
 
 static struct curl_slist *pragma_header;
 static struct curl_slist *no_pragma_header;
@@ -208,12 +192,8 @@ static void finish_active_slot(struct active_request_slot *slot)
 	if (slot->results != NULL) {
 		slot->results->curl_result = slot->curl_result;
 		slot->results->http_code = slot->http_code;
-#if LIBCURL_VERSION_NUM >= 0x070a08
 		curl_easy_getinfo(slot->curl, CURLINFO_HTTPAUTH_AVAIL,
 				  &slot->results->auth_avail);
-#else
-		slot->results->auth_avail = 0;
-#endif
 
 		curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CONNECTCODE,
 			&slot->results->http_connectcode);
@@ -273,14 +253,10 @@ static int http_options(const char *var, const char *value, void *cb)
 		return git_config_string(&ssl_version, var, value);
 	if (!strcmp("http.sslcert", var))
 		return git_config_string(&ssl_cert, var, value);
-#if LIBCURL_VERSION_NUM >= 0x070903
 	if (!strcmp("http.sslkey", var))
 		return git_config_string(&ssl_key, var, value);
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
 	if (!strcmp("http.sslcapath", var))
 		return git_config_pathname(&ssl_capath, var, value);
-#endif
 	if (!strcmp("http.sslcainfo", var))
 		return git_config_pathname(&ssl_cainfo, var, value);
 	if (!strcmp("http.sslcertpasswordprotected", var)) {
@@ -401,12 +377,6 @@ static int curl_empty_auth_enabled(void)
 	if (curl_empty_auth >= 0)
 		return curl_empty_auth;
 
-#ifndef LIBCURL_CAN_HANDLE_AUTH_ANY
-	/*
-	 * Our libcurl is too old to do AUTH_ANY in the first place;
-	 * just default to turning the feature off.
-	 */
-#else
 	/*
 	 * In the automatic case, kick in the empty-auth
 	 * hack as long as we would potentially try some
@@ -419,7 +389,6 @@ static int curl_empty_auth_enabled(void)
 	if (http_auth_methods_restricted &&
 	    (http_auth_methods & ~empty_auth_useless))
 		return 1;
-#endif
 	return 0;
 }
 
@@ -490,7 +459,6 @@ static void init_curl_proxy_auth(CURL *result)
 
 	var_override(&http_proxy_authmethod, getenv("GIT_HTTP_PROXY_AUTHMETHOD"));
 
-#if LIBCURL_VERSION_NUM >= 0x070a07 /* CURLOPT_PROXYAUTH and CURLAUTH_ANY */
 	if (http_proxy_authmethod) {
 		int i;
 		for (i = 0; i < ARRAY_SIZE(proxy_authmethods); i++) {
@@ -508,7 +476,6 @@ static void init_curl_proxy_auth(CURL *result)
 	}
 	else
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
-#endif
 }
 
 static int has_cert_password(void)
@@ -710,12 +677,8 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
 	}
 
-#if LIBCURL_VERSION_NUM >= 0x070907
 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
-#endif
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
-#endif
 
 #if LIBCURL_VERSION_NUM >= 0x071600
 	if (curl_deleg) {
@@ -762,14 +725,10 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
 	if (has_cert_password())
 		curl_easy_setopt(result, CURLOPT_KEYPASSWD, cert_auth.password);
-#if LIBCURL_VERSION_NUM >= 0x070903
 	if (ssl_key != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
 	if (ssl_capath != NULL)
 		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
-#endif
 #if LIBCURL_VERSION_NUM >= 0x072c00
 	if (ssl_pinnedkey != NULL)
 		curl_easy_setopt(result, CURLOPT_PINNEDPUBLICKEY, ssl_pinnedkey);
@@ -945,12 +904,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 		curl_ssl_verify = 0;
 
 	set_from_env(&ssl_cert, "GIT_SSL_CERT");
-#if LIBCURL_VERSION_NUM >= 0x070903
 	set_from_env(&ssl_key, "GIT_SSL_KEY");
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
 	set_from_env(&ssl_capath, "GIT_SSL_CAPATH");
-#endif
 	set_from_env(&ssl_cainfo, "GIT_SSL_CAINFO");
 
 	set_from_env(&user_agent, "GIT_HTTP_USER_AGENT");
@@ -1120,12 +1075,8 @@ struct active_request_slot *get_active_slot(void)
 	else
 		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 0);
 
-#if LIBCURL_VERSION_NUM >= 0x070a08
 	curl_easy_setopt(slot->curl, CURLOPT_IPRESOLVE, git_curl_ipresolve);
-#endif
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
-#endif
 	if (http_auth.password || curl_empty_auth_enabled())
 		init_curl_http_auth(slot->curl);
 
@@ -1392,13 +1343,11 @@ static int handle_curl_result(struct slot_results *results)
 			credential_reject(&http_auth);
 			return HTTP_NOAUTH;
 		} else {
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
 			if (results->auth_avail) {
 				http_auth_methods &= results->auth_avail;
 				http_auth_methods_restricted = 1;
 			}
-#endif
 			return HTTP_REAUTH;
 		}
 	} else {
diff --git a/http.h b/http.h
index f7bd3b26b0..90b20a711a 100644
--- a/http.h
+++ b/http.h
@@ -22,21 +22,10 @@
 #define DEFAULT_MAX_REQUESTS 5
 #endif
 
-#if LIBCURL_VERSION_NUM < 0x070704
-#define curl_global_cleanup() do { /* nothing */ } while (0)
-#endif
-#if LIBCURL_VERSION_NUM < 0x070800
-#define curl_global_init(a) do { /* nothing */ } while (0)
-#endif
-
 #if (LIBCURL_VERSION_NUM < 0x070c04) || (LIBCURL_VERSION_NUM == 0x071000)
 #define NO_CURL_EASY_DUPHANDLE
 #endif
 
-#if LIBCURL_VERSION_NUM < 0x070a03
-#define CURLE_HTTP_RETURNED_ERROR CURLE_HTTP_NOT_FOUND
-#endif
-
 #if LIBCURL_VERSION_NUM < 0x070c03
 #define NO_CURL_IOCTL
 #endif
diff --git a/remote-curl.c b/remote-curl.c
index 0053b09549..23e2a1f3ac 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -144,8 +144,6 @@ static int set_option(const char *name, const char *value)
 	} else if (!strcmp(name, "push-option")) {
 		string_list_append(&options.push_options, value);
 		return 0;
-
-#if LIBCURL_VERSION_NUM >= 0x070a08
 	} else if (!strcmp(name, "family")) {
 		if (!strcmp(value, "ipv4"))
 			git_curl_ipresolve = CURL_IPRESOLVE_V4;
@@ -156,7 +154,6 @@ static int set_option(const char *name, const char *value)
 		else
 			return -1;
 		return 0;
-#endif /* LIBCURL_VERSION_NUM >= 0x070a08 */
 	} else {
 		return 1 /* unsupported */;
 	}
-- 
2.14.0.609.gd2d1f7ddf

