Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFF7C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 07:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DBA20795
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 07:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgJEHUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 03:20:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:49244 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgJEHUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 03:20:16 -0400
Received: (qmail 30323 invoked by uid 109); 5 Oct 2020 07:20:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Oct 2020 07:20:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16525 invoked by uid 111); 5 Oct 2020 07:20:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Oct 2020 03:20:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Oct 2020 03:20:15 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/7] t7450: test verify_path() handling of gitmodules
Message-ID: <20201005072015.GD2291074@coredump.intra.peff.net>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005071751.GA2290770@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 10ecfa7649 (verify_path: disallow symlinks in .gitmodules,
2018-05-04) made it impossible to load a symlink .gitmodules file into
the index. However, there are no tests of this behavior. Let's make sure
this case is covered. We can easily reuse the test setup created by
the matching b7b1fca175 (fsck: complain when .gitmodules is a symlink,
2018-05-04).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7450-bad-meta-files.sh | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/t/t7450-bad-meta-files.sh b/t/t7450-bad-meta-files.sh
index 6b703b12bc..b73985157f 100755
--- a/t/t7450-bad-meta-files.sh
+++ b/t/t7450-bad-meta-files.sh
@@ -139,7 +139,7 @@ test_expect_success 'index-pack --strict works for non-repo pack' '
 	grep gitmodulesName output
 '
 
-test_expect_success 'fsck detects symlinked .gitmodules file' '
+test_expect_success 'create repo with symlinked .gitmodules file' '
 	git init symlink &&
 	(
 		cd symlink &&
@@ -155,8 +155,14 @@ test_expect_success 'fsck detects symlinked .gitmodules file' '
 		{
 			printf "100644 blob $content\t$tricky\n" &&
 			printf "120000 blob $target\t.gitmodules\n"
-		} >bad-tree &&
-		tree=$(git mktree <bad-tree) &&
+		} >bad-tree
+	) &&
+	tree=$(git -C symlink mktree <symlink/bad-tree)
+'
+
+test_expect_success 'fsck detects symlinked .gitmodules file' '
+	(
+		cd symlink &&
 
 		# Check not only that we fail, but that it is due to the
 		# symlink detector; this grep string comes from the config
@@ -166,6 +172,11 @@ test_expect_success 'fsck detects symlinked .gitmodules file' '
 	)
 '
 
+test_expect_success 'refuse to load symlinked .gitmodule into index' '
+	test_must_fail git -C symlink read-tree $tree 2>err &&
+	test_i18ngrep "invalid path.*gitmodules" err
+'
+
 test_expect_success 'fsck detects non-blob .gitmodules' '
 	git init non-blob &&
 	(
-- 
2.28.0.1295.g4824feede7

