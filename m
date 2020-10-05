Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152E7C47420
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D76902078D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgJEMQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 08:16:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:49588 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgJEMQl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 08:16:41 -0400
Received: (qmail 32253 invoked by uid 109); 5 Oct 2020 12:16:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Oct 2020 12:16:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19049 invoked by uid 111); 5 Oct 2020 12:16:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Oct 2020 08:16:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Oct 2020 08:16:39 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 5/8] t7450: test .gitmodules symlink matching against
 obscured names
Message-ID: <20201005121639.GE2907394@coredump.intra.peff.net>
References: <20201005121609.GA2907272@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005121609.GA2907272@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t7450 we check that both verify_path() and fsck catch malformed
.gitmodules entries in trees. However, we don't check that we catch
filesystem-equivalent forms of these (e.g., ".GITMOD~1" on Windows).
Our name-matching functions are exercised well in t0060, but there's
nothing to test that we correctly call the matching functions from the
actual fsck and verify_path() code.

So instead of testing just .gitmodules, let's repeat our tests for a few
basic cases. We don't need to be exhaustive here (t0060 handles that),
but just make sure we hit one name of each type.

Besides pushing the tests into a function that takes the path as a
parameter, we'll need to do a few things:

  - adjust the directory name to accommodate the tests running multiple
    times

  - set core.protecthfs for index checks. Fsck always protects all types
    by default, but we want to be able to exercise the HFS routines on
    every system. Note that core.protectntfs is already the default
    these days, but it doesn't hurt to explicitly label our need for it.

  - we'll also take the filename ("gitmodules") as a parameter. All
    calls use the same name for now, but a future patch will extend this
    to handle other .gitfoo files. Note that our fake-content symlink
    destination is somewhat .gitmodules specific. But it isn't necessary
    for other files (which don't do a content check). And it happens to
    be a valid attribute and ignore file anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7450-bad-dotgitx-files.sh | 91 +++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 38 deletions(-)

diff --git a/t/t7450-bad-dotgitx-files.sh b/t/t7450-bad-dotgitx-files.sh
index 8bfd32b10a..0cd0f71c39 100755
--- a/t/t7450-bad-dotgitx-files.sh
+++ b/t/t7450-bad-dotgitx-files.sh
@@ -139,44 +139,59 @@ test_expect_success 'index-pack --strict works for non-repo pack' '
 	grep gitmodulesName output
 '
 
-test_expect_success 'set up repo with symlinked .gitmodules file' '
-	git init symlink &&
-	(
-		cd symlink &&
-
-		# Make the tree directly to avoid index restrictions.
-		#
-		# Because symlinks store the target as a blob, choose
-		# a pathname that could be parsed as a .gitmodules file
-		# to trick naive non-symlink-aware checking.
-		tricky="[foo]bar=true" &&
-		content=$(git hash-object -w ../.gitmodules) &&
-		target=$(printf "$tricky" | git hash-object -w --stdin) &&
-		{
-			printf "100644 blob $content\t$tricky\n" &&
-			printf "120000 blob $target\t.gitmodules\n"
-		} >bad-tree
-	) &&
-	tree=$(git -C symlink mktree <symlink/bad-tree)
-'
-
-test_expect_success 'fsck detects symlinked .gitmodules file' '
-	(
-		cd symlink &&
-
-		# Check not only that we fail, but that it is due to the
-		# symlink detector
-		test_must_fail git fsck 2>output &&
-		test_i18ngrep "tree $tree: gitmodulesSymlink" output
-	)
-'
-
-test_expect_success 'refuse to load symlinked .gitmodules into index' '
-	test_must_fail git -C symlink read-tree $tree 2>err &&
-	test_i18ngrep "invalid path.*gitmodules" err &&
-	git -C symlink ls-files >out &&
-	test_must_be_empty out
-'
+check_forbidden_symlink () {
+	name=$1
+	type=$2
+	path=$3
+	dir=symlink-$name-$type
+
+	test_expect_success "set up repo with symlinked $name ($type)" '
+		git init $dir &&
+		(
+			cd $dir &&
+
+			# Make the tree directly to avoid index restrictions.
+			#
+			# Because symlinks store the target as a blob, choose
+			# a pathname that could be parsed as a .gitmodules file
+			# to trick naive non-symlink-aware checking.
+			tricky="[foo]bar=true" &&
+			content=$(git hash-object -w ../.gitmodules) &&
+			target=$(printf "$tricky" | git hash-object -w --stdin) &&
+			{
+				printf "100644 blob $content\t$tricky\n" &&
+				printf "120000 blob $target\t$path\n"
+			} >bad-tree
+		) &&
+		tree=$(git -C $dir mktree <$dir/bad-tree)
+	'
+
+	test_expect_success "fsck detects symlinked $name ($type)" '
+		(
+			cd $dir &&
+
+			# Check not only that we fail, but that it is due to the
+			# symlink detector
+			test_must_fail git fsck 2>output &&
+			test_i18ngrep "tree $tree: ${name}Symlink" output
+		)
+	'
+
+	test_expect_success "refuse to load symlinked $name into index ($type)" '
+		test_must_fail \
+			git -C $dir \
+			    -c core.protectntfs \
+			    -c core.protecthfs \
+			    read-tree $tree 2>err &&
+		test_i18ngrep "invalid path.*$name" err &&
+		git -C $dir ls-files -s >out &&
+		test_must_be_empty out
+	'
+}
+
+check_forbidden_symlink gitmodules vanilla .gitmodules
+check_forbidden_symlink gitmodules ntfs ".gitmodules ."
+check_forbidden_symlink gitmodules hfs ".${u200c}gitmodules"
 
 test_expect_success 'fsck detects non-blob .gitmodules' '
 	git init non-blob &&
-- 
2.28.0.1295.gf70bcb366f

