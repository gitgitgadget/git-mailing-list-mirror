Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9C5C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B74E7611EE
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhECUoW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 16:44:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:43550 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229727AbhECUoM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 16:44:12 -0400
Received: (qmail 7593 invoked by uid 109); 3 May 2021 20:43:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 May 2021 20:43:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7486 invoked by uid 111); 3 May 2021 20:43:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 May 2021 16:43:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 May 2021 16:43:15 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/9] t7450: test verify_path() handling of gitmodules
Message-ID: <YJBgY6mHavaHNrXH@coredump.intra.peff.net>
References: <YJBgMP9eXq31INyN@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJBgMP9eXq31INyN@coredump.intra.peff.net>
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
 t/t7450-bad-git-dotfiles.sh | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index 34d4dc6def..eace9a2216 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -139,7 +139,7 @@ test_expect_success 'index-pack --strict works for non-repo pack' '
 	grep gitmodulesName output
 '
 
-test_expect_success 'fsck detects symlinked .gitmodules file' '
+test_expect_success 'set up repo with symlinked .gitmodules file' '
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
 		# symlink detector
@@ -165,6 +171,13 @@ test_expect_success 'fsck detects symlinked .gitmodules file' '
 	)
 '
 
+test_expect_success 'refuse to load symlinked .gitmodules into index' '
+	test_must_fail git -C symlink read-tree $tree 2>err &&
+	grep "invalid path.*gitmodules" err &&
+	git -C symlink ls-files >out &&
+	test_must_be_empty out
+'
+
 test_expect_success 'fsck detects non-blob .gitmodules' '
 	git init non-blob &&
 	(
-- 
2.31.1.926.gd12152deb6

