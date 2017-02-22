Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DB45201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 23:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934342AbdBVXmV (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 18:42:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:60324 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934171AbdBVXl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 18:41:56 -0500
Received: (qmail 1290 invoked by uid 109); 22 Feb 2017 23:41:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 23:41:02 +0000
Received: (qmail 25341 invoked by uid 111); 22 Feb 2017 23:41:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 18:41:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2017 18:40:59 -0500
Date:   Wed, 22 Feb 2017 18:40:59 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/2] http: add an "auto" mode for http.emptyauth
Message-ID: <20170222234059.iajn2zuwzkzjxit2@sigill.intra.peff.net>
References: <20170222233333.dx5lknw4fpopu5hy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170222233333.dx5lknw4fpopu5hy@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This variable needs to be specified to make some types of
non-basic authentication work, but ideally this would just
work out of the box for everyone.

However, simply setting it to "1" by default introduces an
extra round-trip for cases where it _isn't_ useful. We end
up sending a bogus empty credential that the server rejects.

Instead, let's introduce an automatic mode, that works like
this:

  1. We won't try to send the bogus credential on the first
     request. We'll wait to get an HTTP 401, as usual.

  2. After seeing an HTTP 401, the empty-auth hack will kick
     in only when we know there is an auth method beyond
     "Basic" to be tried.

That should make it work out of the box, without incurring
any extra round-trips for people hitting Basic-only servers.

This _does_ incur an extra round-trip if you really want to
use "Basic" but your server advertises other methods (the
emptyauth hack will kick in but fail, and then Git will
actually ask for a password).

The auto mode may incur an extra round-trip over setting
http.emptyauth=true, because part of the emptyauth hack is
to feed this blank password to curl even before we've made a
single request.

Signed-off-by: Jeff King <peff@peff.net>
---
My open questions are:

  - I don't have anything but a Basic server to test against. So it's
    entirely possible that this doesn't actually work in the NTLM case.

  - what does a request log look like for somebody actually using NTLM?
    It's possible if the initial request sends a restrict auth_avail,
    that curl could get away without the extra probe request, and we'd
    end up with the same number of requests for "auto" mode versus
    http.emptyauth=true.

  - the whole "don't use this on the initial request" flag feels really
    hacky. It's a side effect of how emptyauth tries to kick in even
    before we have sent any requests. Probably it should have been
    handled in the 401 code path originally, but I'm hesitant to change
    it now. I suspect it is eliminating a round-trip in practice when it
    is enabled.

  - I didn't test a server that advertises Basic and something else, but
    really only takes Basic. So I'm just assuming that it incurs the
    extra round-trip (actually probably two, one for curl's method
    probe).

  - When your curl is too old to do CURLAUTH_ANY, I just left the
    default to disable emptyauth. But it could easily be "1" if people
    care.

 http.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index a05609766..ea70ec1ee 100644
--- a/http.c
+++ b/http.c
@@ -109,7 +109,7 @@ static int curl_save_cookies;
 struct credential http_auth = CREDENTIAL_INIT;
 static int http_proactive_auth;
 static const char *user_agent;
-static int curl_empty_auth;
+static int curl_empty_auth = -1;
 
 enum http_follow_config http_follow_config = HTTP_FOLLOW_INITIAL;
 
@@ -125,6 +125,7 @@ static struct credential cert_auth = CREDENTIAL_INIT;
 static int ssl_cert_password_required;
 #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 static unsigned long http_auth_methods = CURLAUTH_ANY;
+static int http_auth_methods_restricted;
 #endif
 
 static struct curl_slist *pragma_header;
@@ -382,10 +383,37 @@ static int http_options(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+static int curl_empty_auth_enabled(void)
+{
+	if (curl_empty_auth < 0) {
+#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+		/*
+		 * In the automatic case, kick in the empty-auth
+		 * hack as long as we would potentially try some
+		 * method more exotic than "Basic".
+		 *
+		 * But only do so when this is _not_ our initial
+		 * request, as we would not then yet know what
+		 * methods are available.
+		 */
+		return http_auth_methods_restricted &&
+		       http_auth_methods != CURLAUTH_BASIC;
+#else
+		/*
+		 * Our libcurl is too old to do AUTH_ANY in the first place;
+		 * just default to turning the feature off.
+		 */
+		return 0;
+#endif
+	}
+
+	return curl_empty_auth;
+}
+
 static void init_curl_http_auth(CURL *result)
 {
 	if (!http_auth.username || !*http_auth.username) {
-		if (curl_empty_auth)
+		if (curl_empty_auth_enabled())
 			curl_easy_setopt(result, CURLOPT_USERPWD, ":");
 		return;
 	}
@@ -1079,7 +1107,7 @@ struct active_request_slot *get_active_slot(void)
 #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
 #endif
-	if (http_auth.password || curl_empty_auth)
+	if (http_auth.password || curl_empty_auth_enabled())
 		init_curl_http_auth(slot->curl);
 
 	return slot;
@@ -1347,8 +1375,10 @@ static int handle_curl_result(struct slot_results *results)
 		} else {
 #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
-			if (results->auth_avail)
+			if (results->auth_avail) {
 				http_auth_methods &= results->auth_avail;
+				http_auth_methods_restricted = 1;
+			}
 #endif
 			return HTTP_REAUTH;
 		}
-- 
2.12.0.rc2.597.g959f68882
