Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB865E7D0C5
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 05:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjIZF6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 01:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjIZF6o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 01:58:44 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88CFE9
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 22:58:37 -0700 (PDT)
Received: (qmail 14775 invoked by uid 109); 26 Sep 2023 05:58:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Sep 2023 05:58:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21441 invoked by uid 111); 26 Sep 2023 05:58:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Sep 2023 01:58:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Sep 2023 01:58:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 3/6] t5324: harmonize sha1/sha256 graph chain corruption
Message-ID: <20230926055836.GC1341418@coredump.intra.peff.net>
References: <20230926055452.GA1341109@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230926055452.GA1341109@coredump.intra.peff.net>
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

Let's make this test behave consistently with either hash by always
corrupting the first line. We'll add additional tests that explicitly
cover the second line as we fix those bugs.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5324-split-commit-graph.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 36c4141e67..e335ef87a6 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -316,11 +316,11 @@ test_expect_success 'verify after commit-graph-chain corruption' '
 	git clone --no-hardlinks . verify-chain &&
 	(
 		cd verify-chain &&
-		corrupt_file "$graphdir/commit-graph-chain" 60 "G" &&
+		corrupt_file "$graphdir/commit-graph-chain" 30 "G" &&
 		git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_i18ngrep "invalid commit-graph chain" err &&
-		corrupt_file "$graphdir/commit-graph-chain" 60 "A" &&
+		corrupt_file "$graphdir/commit-graph-chain" 30 "A" &&
 		git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_i18ngrep "unable to find all commit-graph files" err
-- 
2.42.0.758.gd56856b565

