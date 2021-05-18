Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C0CC433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 06:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA556105A
	for <git@archiver.kernel.org>; Tue, 18 May 2021 06:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240253AbhERG3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 02:29:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:57360 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234413AbhERG3B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 02:29:01 -0400
Received: (qmail 10567 invoked by uid 109); 18 May 2021 06:27:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 May 2021 06:27:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5109 invoked by uid 111); 18 May 2021 06:27:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 May 2021 02:27:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 May 2021 02:27:42 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Humphreys <behumphreys@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christopher Schenk <christopher@cschenk.net>,
        git@vger.kernel.org
Subject: [PATCH 2/2] Revert "remote-curl: fall back to basic auth if
 Negotiate fails"
Message-ID: <YKNeXq3JzxYWkxKl@coredump.intra.peff.net>
References: <YKNeJ+NKUbD5ixA9@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKNeJ+NKUbD5ixA9@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit 1b0d9545bb85912a16b367229d414f55d140d3be.

That commit does fix the situation it intended to (avoiding Negotiate
even when the credentials were provided in the URL), but it creates a
more serious regression: we now never hit the conditional for "we had a
username and password, tried them, but the server still gave us a 401".
That has two bad effects:

 1. we never call credential_reject(), and thus a bogus credential
    stored by a helper will live on forever

 2. we never return HTTP_NOAUTH, so the error message the user gets is
    "The requested URL returned error: 401", instead of "Authentication
    failed".

Doing this correctly seems non-trivial, as we don't know whether the
Negotiate auth was a problem. Since this is a regression in the upcoming
v2.23.0 release (for which we're in -rc0), let's revert for now and work
on a fix separately.

(Note that this isn't a pure revert; the previous commit added a test
showing the regression, so we can now flip it to expect_success).

Reported-by: Ben Humphreys <behumphreys@atlassian.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 http.c                      | 15 +++++++--------
 t/t5551-http-fetch-smart.sh |  2 +-
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/http.c b/http.c
index c83bc33a5f..8119247149 100644
--- a/http.c
+++ b/http.c
@@ -1650,18 +1650,17 @@ static int handle_curl_result(struct slot_results *results)
 	} else if (missing_target(results))
 		return HTTP_MISSING_TARGET;
 	else if (results->http_code == 401) {
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
-		http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
-		if (results->auth_avail) {
-			http_auth_methods &= results->auth_avail;
-			http_auth_methods_restricted = 1;
-			return HTTP_REAUTH;
-		}
-#endif
 		if (http_auth.username && http_auth.password) {
 			credential_reject(&http_auth);
 			return HTTP_NOAUTH;
 		} else {
+#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
+			if (results->auth_avail) {
+				http_auth_methods &= results->auth_avail;
+				http_auth_methods_restricted = 1;
+			}
+#endif
 			return HTTP_REAUTH;
 		}
 	} else {
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 1de87e4ffe..4f87d90c5b 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -533,7 +533,7 @@ test_expect_success 'http auth remembers successful credentials' '
 	expect_askpass none
 '
 
-test_expect_failure 'http auth forgets bogus credentials' '
+test_expect_success 'http auth forgets bogus credentials' '
 	# seed credential store with bogus values. In real life,
 	# this would probably come from a password which worked
 	# for a previous request.
-- 
2.32.0.rc0.421.g64c9147932
