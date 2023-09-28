Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1266CE7AFB
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 04:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjI1Eiw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 00:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjI1Eiv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 00:38:51 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C59121
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 21:38:48 -0700 (PDT)
Received: (qmail 3690 invoked by uid 109); 28 Sep 2023 04:38:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Sep 2023 04:38:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9663 invoked by uid 111); 28 Sep 2023 04:38:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Sep 2023 00:38:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Sep 2023 00:38:47 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 3/6] t5324: harmonize sha1/sha256 graph chain corruption
Message-ID: <20230928043847.GC58367@coredump.intra.peff.net>
References: <20230928043746.GB57926@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230928043746.GB57926@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t5324.20, we corrupt a hex character 60 bytes into the graph chain
file. Since the file consists of two hash identifiers, one per line, the
corruption differs between sha1 and sha256. In a sha1 repository, the
corruption is on the second line, and in a sha256 repository, it is on
the first.

We should of course detect the problem with either line. But as the next
few patches will show (and fix), that is not the case (in fact, we
currently do not exit non-zero for either line!). And while at the end
of our series we'll catch all errors, our intermediate states will have
differing behavior between the two hashes.

Let's make sure we test corruption of both the first and second lines,
and do so consistently with either hash by choosing offsets which are
always in the first hash (30 bytes) or in the second (70).

Signed-off-by: Jeff King <peff@peff.net>
---
In v2 we are now testing both first and second lines, instead of just
the first.

 t/t5324-split-commit-graph.sh | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 36c4141e67..a9b2428b56 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -312,15 +312,30 @@ test_expect_success 'warn on base graph chunk incorrect' '
 	)
 '
 
-test_expect_success 'verify after commit-graph-chain corruption' '
-	git clone --no-hardlinks . verify-chain &&
+test_expect_success 'verify after commit-graph-chain corruption (base)' '
+	git clone --no-hardlinks . verify-chain-base &&
 	(
-		cd verify-chain &&
-		corrupt_file "$graphdir/commit-graph-chain" 60 "G" &&
+		cd verify-chain-base &&
+		corrupt_file "$graphdir/commit-graph-chain" 30 "G" &&
 		git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_i18ngrep "invalid commit-graph chain" err &&
-		corrupt_file "$graphdir/commit-graph-chain" 60 "A" &&
+		corrupt_file "$graphdir/commit-graph-chain" 30 "A" &&
+		git commit-graph verify 2>test_err &&
+		grep -v "^+" test_err >err &&
+		test_i18ngrep "unable to find all commit-graph files" err
+	)
+'
+
+test_expect_success 'verify after commit-graph-chain corruption (tip)' '
+	git clone --no-hardlinks . verify-chain-tip &&
+	(
+		cd verify-chain-tip &&
+		corrupt_file "$graphdir/commit-graph-chain" 70 "G" &&
+		git commit-graph verify 2>test_err &&
+		grep -v "^+" test_err >err &&
+		test_i18ngrep "invalid commit-graph chain" err &&
+		corrupt_file "$graphdir/commit-graph-chain" 70 "A" &&
 		git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_i18ngrep "unable to find all commit-graph files" err
-- 
2.42.0.773.ga6e30199be

