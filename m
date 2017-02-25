Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3DA8201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 19:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbdBYTTq (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 14:19:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:34090 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751980AbdBYTTq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 14:19:46 -0500
Received: (qmail 31900 invoked by uid 109); 25 Feb 2017 19:18:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 19:18:33 +0000
Received: (qmail 5564 invoked by uid 111); 25 Feb 2017 19:18:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 14:18:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Feb 2017 14:18:31 -0500
Date:   Sat, 25 Feb 2017 14:18:31 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     David Turner <David.Turner@twosigma.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] http: add an "auto" mode for http.emptyauth
Message-ID: <20170225191831.dkjasyv3tmkwutre@sigill.intra.peff.net>
References: <20170222233333.dx5lknw4fpopu5hy@sigill.intra.peff.net>
 <20170222234059.iajn2zuwzkzjxit2@sigill.intra.peff.net>
 <b5778a7988ad4dfa9adfc8d312432189@exmbdft7.ad.twosigma.com>
 <20170223013746.lturqad7lnehedb4@sigill.intra.peff.net>
 <alpine.DEB.2.20.1702251243390.3767@virtualbox>
 <20170225191506.4it7pdsi6ijanfft@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170225191506.4it7pdsi6ijanfft@sigill.intra.peff.net>
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
     in only when we know there is an auth method available
     that might make use of it (i.e., something besides
     "Basic" or "Digest").

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

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Jeff King <peff@peff.net>
---
And here's the full patch. It is meant to go on top of the
already-queued 1/2, though I suspect it could apply separately.

Test reports welcome from people who actually have NTLM or Kerberos
servers. The changes from the previous are fairly minimal, but this kind
of bit-mangling is exactly the kind of thing where I tend to
accidentally invert the logic. ;)

 http.c | 50 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/http.c b/http.c
index a05609766..dd637d031 100644
--- a/http.c
+++ b/http.c
@@ -109,7 +109,7 @@ static int curl_save_cookies;
 struct credential http_auth = CREDENTIAL_INIT;
 static int http_proactive_auth;
 static const char *user_agent;
-static int curl_empty_auth;
+static int curl_empty_auth = -1;
 
 enum http_follow_config http_follow_config = HTTP_FOLLOW_INITIAL;
 
@@ -125,6 +125,14 @@ static struct credential cert_auth = CREDENTIAL_INIT;
 static int ssl_cert_password_required;
 #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 static unsigned long http_auth_methods = CURLAUTH_ANY;
+static int http_auth_methods_restricted;
+/* Modes for which empty_auth cannot actually help us. */
+static unsigned long empty_auth_useless =
+	CURLAUTH_BASIC
+#ifdef CURLAUTH_DIGEST_IE
+	| CURLAUTH_DIGEST_IE
+#endif
+	| CURLAUTH_DIGEST;
 #endif
 
 static struct curl_slist *pragma_header;
@@ -333,7 +341,10 @@ static int http_options(const char *var, const char *value, void *cb)
 		return git_config_string(&user_agent, var, value);
 
 	if (!strcmp("http.emptyauth", var)) {
-		curl_empty_auth = git_config_bool(var, value);
+		if (value && !strcmp("auto", value))
+			curl_empty_auth = -1;
+		else
+			curl_empty_auth = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -382,10 +393,37 @@ static int http_options(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+static int curl_empty_auth_enabled(void)
+{
+	if (curl_empty_auth >= 0)
+		return curl_empty_auth;
+
+#ifndef LIBCURL_CAN_HANDLE_AUTH_ANY
+	/*
+	 * Our libcurl is too old to do AUTH_ANY in the first place;
+	 * just default to turning the feature off.
+	 */
+#else
+	/*
+	 * In the automatic case, kick in the empty-auth
+	 * hack as long as we would potentially try some
+	 * method more exotic than "Basic" or "Digest".
+	 *
+	 * But only do this when this is our second or
+	 * subsequent * request, as by then we know what
+	 * methods are available.
+	 */
+	if (http_auth_methods_restricted &&
+	    (http_auth_methods & ~empty_auth_useless))
+		return 1;
+#endif
+	return 0;
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
@@ -1079,7 +1117,7 @@ struct active_request_slot *get_active_slot(void)
 #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
 #endif
-	if (http_auth.password || curl_empty_auth)
+	if (http_auth.password || curl_empty_auth_enabled())
 		init_curl_http_auth(slot->curl);
 
 	return slot;
@@ -1347,8 +1385,10 @@ static int handle_curl_result(struct slot_results *results)
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
2.12.0.616.g5f622f3b1

