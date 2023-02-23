Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C452C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 11:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjBWLAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 06:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbjBWLAq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 06:00:46 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9620A52DFC
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 03:00:40 -0800 (PST)
Received: (qmail 24962 invoked by uid 109); 23 Feb 2023 11:00:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 11:00:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20221 invoked by uid 111); 23 Feb 2023 11:00:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 06:00:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 06:00:38 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 09/16] t5551: handle v2 protocol in upload-pack service test
Message-ID: <Y/dHVu3p125CgcYR@coredump.intra.peff.net>
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We perform a clone and a fetch, and then check that we saw the expected
requests in Apache's access log. In the v2 protocol, there will be one
extra request to /git-upload-pack for each operation (since the initial
/info/refs probe is just used to upgrade the protocol).

As a result, this test is a noop unless the use of the v0 protocol is
forced. Which means that hardly anybody runs it, since you have to do so
manually.

Let's update it to handle v2 and run it always. We could do this by just
conditionally adding in the extra POST lines. But if we look at the
origin of the test in 7da4e2280c (test smart http fetch and push,
2009-10-30), the point is really just to make sure that the smart
git-upload-pack service was used at all. So rather than counting up the
individual requests, let's just make sure we saw each of the expected
types. This is a bit looser, but makes maintenance easier.

Since we're now matching with grep, we can also loosen the HTTP/1.1
match, which allows this test to pass when run with HTTP/2 via t5559.
That lets:

  GIT_TEST_PROTOCOL_VERSION=0 ./t5559-http-fetch-smart-http2.sh

run to completion, which previously failed (and of course it works if
you use v2, as well).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5551-http-fetch-smart.sh | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 9d99cefb92..b912958518 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -143,19 +143,9 @@ test_expect_success 'fetch changes via http' '
 '
 
 test_expect_success 'used upload-pack service' '
-	cat >exp <<-\EOF &&
-	GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
-	POST /smart/repo.git/git-upload-pack HTTP/1.1 200
-	GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
-	POST /smart/repo.git/git-upload-pack HTTP/1.1 200
-	EOF
-
-	# NEEDSWORK: If the overspecification of the expected result is reduced, we
-	# might be able to run this test in all protocol versions.
-	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
-	then
-		check_access_log exp
-	fi
+	strip_access_log >log &&
+	grep "GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/[0-9.]* 200" log &&
+	grep "POST /smart/repo.git/git-upload-pack HTTP/[0-9.]* 200" log
 '
 
 test_expect_success 'follow redirects (301)' '
-- 
2.39.2.981.g6157336f25

