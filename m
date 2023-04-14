Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFFFC77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 21:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjDNV0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 17:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjDNVZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 17:25:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8E66EBB
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 14:25:29 -0700 (PDT)
Received: (qmail 22431 invoked by uid 109); 14 Apr 2023 21:25:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Apr 2023 21:25:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31712 invoked by uid 111); 14 Apr 2023 21:25:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Apr 2023 17:25:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Apr 2023 17:25:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jonas Haag <jonas@lophus.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: [PATCH v3 6/7] t5512: test "ls-remote --heads --symref" filtering
 with v0 and v2
Message-ID: <20230414212518.GF639756@coredump.intra.peff.net>
References: <20230414212404.GA639653@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230414212404.GA639653@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have two overlapping tests for checking the behavior of "ls-remote
--symref" when filtering output. The first test checks that using
"--heads" will omit the symref for HEAD (since we don't print anything
about HEAD at all), but still prints other symrefs.

This has been marked as expecting failure since it was added in
99c08d4eb2 (ls-remote: add support for showing symrefs, 2016-01-19).
That's because back then, we only had the v0 protocol, and it only
reported on the HEAD symref, not others. But these days we have v2,
which does exactly what the test wants. It would even have started
unexpectedly passing when we switched to v2 by default, except that
b2f73b70b2 (t5512: compensate for v0 only sending HEAD symrefs,
2019-02-25) over-zealously marked it to run only in v0 mode.

So let's run it with both protocol versions, and adjust the expected
output for each. It passes in v2 without modification. In v0 mode, we'll
drop the extra symref, but this is still testing something useful: it
ensures that we do omit HEAD.

The test after this checks "--heads" again, this time using the expected
v0 output. That's now redundant. It also checks that limiting with a
pattern like "refs/heads/*" works similarly, but that's redundant with a
test earlier in the script which limits by HEAD (again, back then the
"HEAD" test was less interesting because there were no other symrefs to
omit, but in a modern v2 world, there are). So we can just delete that
second test entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5512-ls-remote.sh | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index fbf23d12a6..151c76eb09 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -275,30 +275,18 @@ test_expect_success 'ls-remote with filtered symref (refname)' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'ls-remote with filtered symref (--heads)' '
+test_expect_success 'ls-remote with filtered symref (--heads)' '
 	git symbolic-ref refs/heads/foo refs/tags/mark &&
-	cat >expect <<-EOF &&
+	cat >expect.v2 <<-EOF &&
 	ref: refs/tags/mark	refs/heads/foo
 	$rev	refs/heads/foo
 	$rev	refs/heads/main
 	EOF
-	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
-	# protocol v0 here.
-	GIT_TEST_PROTOCOL_VERSION=0 git ls-remote --symref --heads . >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'ls-remote --symref omits filtered-out matches' '
-	cat >expect <<-EOF &&
-	$rev	refs/heads/foo
-	$rev	refs/heads/main
-	EOF
-	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
-	# protocol v0 here.
-	GIT_TEST_PROTOCOL_VERSION=0 git ls-remote --symref --heads . >actual &&
-	test_cmp expect actual &&
-	GIT_TEST_PROTOCOL_VERSION=0 git ls-remote --symref . "refs/heads/*" >actual &&
-	test_cmp expect actual
+	grep -v "^ref: refs/tags/" <expect.v2 >expect.v0 &&
+	git -c protocol.version=0 ls-remote --symref --heads . >actual.v0 &&
+	test_cmp expect.v0 actual.v0 &&
+	git -c protocol.version=2 ls-remote --symref --heads . >actual.v2 &&
+	test_cmp expect.v2 actual.v2
 '
 
 test_expect_success 'indicate no refs in v0 standards-compliant empty remote' '
-- 
2.40.0.515.gdfb9e78b42

