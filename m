Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAF211FAFB
	for <e@80x24.org>; Tue,  4 Apr 2017 02:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbdDDCym (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 22:54:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:56322 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751782AbdDDCyl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 22:54:41 -0400
Received: (qmail 20240 invoked by uid 109); 4 Apr 2017 02:54:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Apr 2017 02:54:40 +0000
Received: (qmail 3308 invoked by uid 111); 4 Apr 2017 02:54:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Apr 2017 22:54:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Apr 2017 22:54:38 -0400
Date:   Mon, 3 Apr 2017 22:54:38 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC] dropping support for ancient versions of curl
Message-ID: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A nearby thread raised the question of whether we can rely on a version
of libcurl that contains a particular feature. The version in question
is curl 7.11.1, which came out in March 2004.

My feeling is that this is old enough to stop caring about. Which means
we can drop some of the #ifdefs that clutter the HTTP code (and there's
a patch at the end of this mail dropping support for everything older
than 7.11.1). But that made wonder: how old is too old? I think it's
nice that we don't force people to upgrade to the latest version of
curl. But at some point, if you are running a 13-year-old version of
libcurl, how likely are you to run a brand new version of Git? :)

If we declared 7.16.0 as a cutoff, we could unconditionally define
USE_CURL_MULTI, which gets rid of quite a few messy ifdefs.

-Peff

---
 http.c        | 51 -----------------------------------
 http.h        | 11 --------
 remote-curl.c |  3 ---
 3 files changed, 65 deletions(-)

diff --git a/http.c b/http.c
index 8d94e2c63..7a81f0b68 100644
--- a/http.c
+++ b/http.c
@@ -12,19 +12,11 @@
 #include "transport.h"
 
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
-#if LIBCURL_VERSION_NUM >= 0x070a08
 long int git_curl_ipresolve = CURL_IPRESOLVE_WHATEVER;
-#else
-long int git_curl_ipresolve;
-#endif
 int active_requests;
 int http_is_verbose;
 size_t http_post_buffer = 16 * LARGE_PACKET_MAX;
 
-#if LIBCURL_VERSION_NUM >= 0x070a06
-#define LIBCURL_CAN_HANDLE_AUTH_ANY
-#endif
-
 static int min_curl_sessions = 1;
 static int curl_session_count;
 #ifdef USE_CURL_MULTI
@@ -57,12 +49,8 @@ static struct {
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
@@ -81,9 +69,7 @@ static struct {
 	{ "digest", CURLAUTH_DIGEST },
 	{ "negotiate", CURLAUTH_GSSNEGOTIATE },
 	{ "ntlm", CURLAUTH_NTLM },
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 	{ "anyauth", CURLAUTH_ANY },
-#endif
 	/*
 	 * CURLAUTH_DIGEST_IE has no corresponding command-line option in
 	 * curl(1) and is not included in CURLAUTH_ANY, so we leave it out
@@ -123,7 +109,6 @@ enum http_follow_config http_follow_config = HTTP_FOLLOW_INITIAL;
 
 static struct credential cert_auth = CREDENTIAL_INIT;
 static int ssl_cert_password_required;
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 static unsigned long http_auth_methods = CURLAUTH_ANY;
 static int http_auth_methods_restricted;
 /* Modes for which empty_auth cannot actually help us. */
@@ -133,7 +118,6 @@ static unsigned long empty_auth_useless =
 	| CURLAUTH_DIGEST_IE
 #endif
 	| CURLAUTH_DIGEST;
-#endif
 
 static struct curl_slist *pragma_header;
 static struct curl_slist *no_pragma_header;
@@ -207,12 +191,8 @@ static void finish_active_slot(struct active_request_slot *slot)
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
@@ -272,14 +252,10 @@ static int http_options(const char *var, const char *value, void *cb)
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
@@ -398,12 +374,6 @@ static int curl_empty_auth_enabled(void)
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
@@ -416,7 +386,6 @@ static int curl_empty_auth_enabled(void)
 	if (http_auth_methods_restricted &&
 	    (http_auth_methods & ~empty_auth_useless))
 		return 1;
-#endif
 	return 0;
 }
 
@@ -487,7 +456,6 @@ static void init_curl_proxy_auth(CURL *result)
 
 	var_override(&http_proxy_authmethod, getenv("GIT_HTTP_PROXY_AUTHMETHOD"));
 
-#if LIBCURL_VERSION_NUM >= 0x070a07 /* CURLOPT_PROXYAUTH and CURLAUTH_ANY */
 	if (http_proxy_authmethod) {
 		int i;
 		for (i = 0; i < ARRAY_SIZE(proxy_authmethods); i++) {
@@ -505,7 +473,6 @@ static void init_curl_proxy_auth(CURL *result)
 	}
 	else
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
-#endif
 }
 
 static int has_cert_password(void)
@@ -707,12 +674,8 @@ static CURL *get_curl_handle(void)
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
@@ -759,14 +722,10 @@ static CURL *get_curl_handle(void)
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
@@ -933,12 +892,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
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
@@ -1111,12 +1066,8 @@ struct active_request_slot *get_active_slot(void)
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
 
@@ -1383,13 +1334,11 @@ static int handle_curl_result(struct slot_results *results)
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
index 02bccb7b0..d1de11a3d 100644
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
index e953d06f6..c792942f0 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -143,8 +143,6 @@ static int set_option(const char *name, const char *value)
 	} else if (!strcmp(name, "push-option")) {
 		string_list_append(&options.push_options, value);
 		return 0;
-
-#if LIBCURL_VERSION_NUM >= 0x070a08
 	} else if (!strcmp(name, "family")) {
 		if (!strcmp(value, "ipv4"))
 			git_curl_ipresolve = CURL_IPRESOLVE_V4;
@@ -155,7 +153,6 @@ static int set_option(const char *name, const char *value)
 		else
 			return -1;
 		return 0;
-#endif /* LIBCURL_VERSION_NUM >= 0x070a08 */
 	} else {
 		return 1 /* unsupported */;
 	}
