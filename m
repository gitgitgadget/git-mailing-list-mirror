Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F16720899
	for <e@80x24.org>; Wed,  9 Aug 2017 12:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbdHIMCE (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 08:02:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:33154 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752409AbdHIMCE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 08:02:04 -0400
Received: (qmail 1880 invoked by uid 109); 9 Aug 2017 12:02:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 12:02:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26473 invoked by uid 111); 9 Aug 2017 12:02:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 08:02:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 08:02:01 -0400
Date:   Wed, 9 Aug 2017 08:02:01 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/4] http: drop support for curl < 7.19.4
Message-ID: <20170809120201.2eagzkljervqeusx@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since v2.12.0, Git does not compile with versions of curl
older than 7.19.4. That version of curl is about 8 years
old. This means it may still be used in some distributions
with long-running support periods. But the fact that we
haven't received a single bug report about the compile-time
breakage implies that nobody cares about building recent
releases on such platforms.

As discussed in the previous two commits, this cleans up the
code and gives a more realistic signal to users about which
versions of Git are actually tested (in particular, this
moves us past the potential use-after-free issues with curl
older than 7.17.0).

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 46 ----------------------------------------------
 http.h |  4 ----
 2 files changed, 50 deletions(-)

diff --git a/http.c b/http.c
index 6e5f4ce5f9..5280511c74 100644
--- a/http.c
+++ b/http.c
@@ -22,9 +22,7 @@ static int min_curl_sessions = 1;
 static int curl_session_count;
 static int max_requests = -1;
 static CURLM *curlm;
-#ifndef NO_CURL_EASY_DUPHANDLE
 static CURL *curl_default;
-#endif
 
 #define PREV_BUF_SIZE 4096
 
@@ -382,24 +380,8 @@ static void init_curl_http_auth(CURL *result)
 
 	credential_fill(&http_auth);
 
-#if LIBCURL_VERSION_NUM >= 0x071301
 	curl_easy_setopt(result, CURLOPT_USERNAME, http_auth.username);
 	curl_easy_setopt(result, CURLOPT_PASSWORD, http_auth.password);
-#else
-	{
-		static struct strbuf up = STRBUF_INIT;
-		/*
-		 * Note that we assume we only ever have a single set of
-		 * credentials in a given program run, so we do not have
-		 * to worry about updating this buffer, only setting its
-		 * initial value.
-		 */
-		if (!up.len)
-			strbuf_addf(&up, "%s:%s",
-				http_auth.username, http_auth.password);
-		curl_easy_setopt(result, CURLOPT_USERPWD, up.buf);
-	}
-#endif
 }
 
 /* *var must be free-able */
@@ -413,20 +395,10 @@ static void var_override(const char **var, char *value)
 
 static void set_proxyauth_name_password(CURL *result)
 {
-#if LIBCURL_VERSION_NUM >= 0x071301
 		curl_easy_setopt(result, CURLOPT_PROXYUSERNAME,
 			proxy_auth.username);
 		curl_easy_setopt(result, CURLOPT_PROXYPASSWORD,
 			proxy_auth.password);
-#else
-		struct strbuf s = STRBUF_INIT;
-
-		strbuf_addstr_urlencode(&s, proxy_auth.username, 1);
-		strbuf_addch(&s, ':');
-		strbuf_addstr_urlencode(&s, proxy_auth.password, 1);
-		curl_proxyuserpwd = strbuf_detach(&s, NULL);
-		curl_easy_setopt(result, CURLOPT_PROXYUSERPWD, curl_proxyuserpwd);
-#endif
 }
 
 static void init_curl_proxy_auth(CURL *result)
@@ -718,20 +690,12 @@ static CURL *get_curl_handle(void)
 	}
 
 	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
-#if LIBCURL_VERSION_NUM >= 0x071301
 	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
-#elif LIBCURL_VERSION_NUM >= 0x071101
 	curl_easy_setopt(result, CURLOPT_POST301, 1);
-#endif
-#if LIBCURL_VERSION_NUM >= 0x071304
 	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
 			 get_curl_allowed_protocols(0));
 	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
 			 get_curl_allowed_protocols(-1));
-#else
-	warning("protocol restrictions not applied to curl redirects because\n"
-		"your curl version is too old (>= 7.19.4)");
-#endif
 	if (getenv("GIT_CURL_VERBOSE"))
 		curl_easy_setopt(result, CURLOPT_VERBOSE, 1L);
 	setup_curl_trace(result);
@@ -807,11 +771,9 @@ static CURL *get_curl_handle(void)
 			die("Invalid proxy URL '%s'", curl_http_proxy);
 
 		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
-#if LIBCURL_VERSION_NUM >= 0x071304
 		var_override(&curl_no_proxy, getenv("NO_PROXY"));
 		var_override(&curl_no_proxy, getenv("no_proxy"));
 		curl_easy_setopt(result, CURLOPT_NOPROXY, curl_no_proxy);
-#endif
 	}
 	init_curl_proxy_auth(result);
 
@@ -907,9 +869,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 			ssl_cert_password_required = 1;
 	}
 
-#ifndef NO_CURL_EASY_DUPHANDLE
 	curl_default = get_curl_handle();
-#endif
 }
 
 void http_cleanup(void)
@@ -927,9 +887,7 @@ void http_cleanup(void)
 	}
 	active_queue_head = NULL;
 
-#ifndef NO_CURL_EASY_DUPHANDLE
 	curl_easy_cleanup(curl_default);
-#endif
 
 	curl_multi_cleanup(curlm);
 	curl_global_cleanup();
@@ -1003,11 +961,7 @@ struct active_request_slot *get_active_slot(void)
 	}
 
 	if (slot->curl == NULL) {
-#ifdef NO_CURL_EASY_DUPHANDLE
-		slot->curl = get_curl_handle();
-#else
 		slot->curl = curl_easy_duphandle(curl_default);
-#endif
 		curl_session_count++;
 	}
 
diff --git a/http.h b/http.h
index 57e97c128d..da4d8589d8 100644
--- a/http.h
+++ b/http.h
@@ -12,10 +12,6 @@
 
 #define DEFAULT_MAX_REQUESTS 5
 
-#if LIBCURL_VERSION_NUM == 0x071000
-#define NO_CURL_EASY_DUPHANDLE
-#endif
-
 /*
  * CURLOPT_USE_SSL was known as CURLOPT_FTP_SSL up to 7.16.4,
  * and the constants were known as CURLFTPSSL_*
-- 
2.14.0.609.gd2d1f7ddf

