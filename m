Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE64C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 06:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjDLGeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 02:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDLGeg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 02:34:36 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446103ABC
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 23:34:35 -0700 (PDT)
Received: (qmail 17919 invoked by uid 109); 12 Apr 2023 06:34:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Apr 2023 06:34:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17144 invoked by uid 111); 12 Apr 2023 06:34:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Apr 2023 02:34:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Apr 2023 02:34:33 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jonas Haag <jonas@lophus.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: [PATCH 4/7] t5512: add v2 support for "ls-remote --symref" test
Message-ID: <20230412063433.GD1681312@coredump.intra.peff.net>
References: <20230412062300.GA838367@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230412062300.GA838367@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit b2f73b70b2 (t5512: compensate for v0 only sending HEAD symrefs,
2019-02-25) configured this test to always run with protocol v0, since
the output is different for v2.

But that means we are not getting any test coverage of the feature with
v2 at all. We could obviously switch to using and expecting v2, but then
that leaves v0 behind (and while we don't use it by default, it's still
important for testing interoperability with older servers). Likewise, we
could switch the expected output based on $GIT_TEST_PROTOCOL_VERSION,
but hardly anybody runs the tests for v0 these days.

Instead, let's explicitly run it for both protocol versions to make sure
they're well behaved. This matches other similar tests added later in
6a139cdd74 (ls-remote: pass heads/tags prefixes to transport,
2018-10-31), etc.

Signed-off-by: Jeff King <peff@peff.net>
---
I wondered briefly if anybody ever runs with GIT_TEST_PROTOCOL_VERSION=0,
but I'm pretty sure the answer is "no", because a bunch of test scripts
fail. Those are almost certainly all non-bugs, but rather just tests
that assume modern v2 behavior. I'm not sure if it's worth putting any
effort into fixing. I didn't do so here (though before and after my
patches t5512 itself runs OK in either mode).

 t/t5512-ls-remote.sh | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 4e21ab60bf..74f0204c5b 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -244,22 +244,25 @@ test_expect_success 'protocol v2 supports hiderefs' '
 
 test_expect_success 'ls-remote --symref' '
 	git fetch origin &&
-	echo "ref: refs/heads/main	HEAD" >expect &&
+	echo "ref: refs/heads/main	HEAD" >expect.v2 &&
 	generate_references \
 		HEAD \
-		refs/heads/main >>expect &&
+		refs/heads/main >>expect.v2 &&
+	echo "ref: refs/remotes/origin/main	refs/remotes/origin/HEAD" >>expect.v2 &&
 	oid=$(git rev-parse HEAD) &&
-	echo "$oid	refs/remotes/origin/HEAD" >>expect &&
+	echo "$oid	refs/remotes/origin/HEAD" >>expect.v2 &&
 	generate_references \
 		refs/remotes/origin/main \
 		refs/tags/mark \
 		refs/tags/mark1.1 \
 		refs/tags/mark1.10 \
-		refs/tags/mark1.2 >>expect &&
-	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
-	# protocol v0 here.
-	GIT_TEST_PROTOCOL_VERSION=0 git ls-remote --symref >actual &&
-	test_cmp expect actual
+		refs/tags/mark1.2 >>expect.v2 &&
+	# v0 does not show non-HEAD symrefs
+	grep -v "ref: refs/remotes" <expect.v2 >expect.v0 &&
+	git -c protocol.version=0 ls-remote --symref >actual.v0 &&
+	test_cmp expect.v0 actual.v0 &&
+	git -c protocol.version=2 ls-remote --symref >actual.v2 &&
+	test_cmp expect.v2 actual.v2
 '
 
 test_expect_success 'ls-remote with filtered symref (refname)' '
-- 
2.40.0.493.gfc602f1919

