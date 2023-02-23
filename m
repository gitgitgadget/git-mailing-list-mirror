Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B63C636D6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 11:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbjBWLBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 06:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjBWLBe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 06:01:34 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0754452DEC
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 03:01:32 -0800 (PST)
Received: (qmail 24980 invoked by uid 109); 23 Feb 2023 11:01:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 11:01:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20226 invoked by uid 111); 23 Feb 2023 11:01:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 06:01:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 06:01:31 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/16] t5551: simplify expected cookie file
Message-ID: <Y/dHi+I6a2yLT4HY@coredump.intra.peff.net>
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After making an HTTP request that should store cookies, we check that
the expected values are in the cookie file. We don't want to look at the
whole file, because it has noisy comments at the top that we shouldn't
depend on. But we strip out the interesting bits using "tail -3", which
is brittle. It requires us to put an extra blank line in our expected
output, and it would fail to notice any reordering or extra content in
the cookie file.

Instead, let's just grep for non-blank lines that are not comments,
which more directly describes what we're interested in.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5551-http-fetch-smart.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index b912958518..2f15a707d4 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -294,7 +294,6 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
 	127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
 	EOF
 	sort >expect_cookies.txt <<-\EOF &&
-
 	127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
 	127.0.0.1	FALSE	/smart_cookies/repo.git/info/	FALSE	0	name	value
 	EOF
@@ -306,8 +305,8 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
 	# might be able to run this test in all protocol versions.
 	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
 	then
-		tail -3 cookies.txt | sort >cookies_tail.txt &&
-		test_cmp expect_cookies.txt cookies_tail.txt
+		grep "^[^#]" cookies.txt | sort >cookies_stripped.txt &&
+		test_cmp expect_cookies.txt cookies_stripped.txt
 	fi
 '
 
-- 
2.39.2.981.g6157336f25

