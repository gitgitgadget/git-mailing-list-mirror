Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C26C433B4
	for <git@archiver.kernel.org>; Sat,  1 May 2021 14:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978AC614A7
	for <git@archiver.kernel.org>; Sat,  1 May 2021 14:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhEAODv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 10:03:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:42020 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232174AbhEAODu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 10:03:50 -0400
Received: (qmail 26371 invoked by uid 109); 1 May 2021 14:03:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 May 2021 14:03:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10007 invoked by uid 111); 1 May 2021 14:03:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 May 2021 10:03:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 1 May 2021 10:02:59 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Yiyuan guo <yguoaz@gmail.com>
Subject: [PATCH 1/5] t5300: modernize basic tests
Message-ID: <YI1fk3nE6AJRK8qS@coredump.intra.peff.net>
References: <YI1fbERSuS7Y3LKh@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YI1fbERSuS7Y3LKh@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first set of tests in t5300 goes back to 2005, and doesn't use some
of our customary style and tools these days. In preparation for touching
them, let's modernize a few things:

  - titles go on the line with test_expect_success, with a hanging
    open-quote to start the test body

  - test bodies should be indented with tabs

  - opening braces for shell blocks in &&-chains go on their own line

  - no space between redirect operators and files (">foo", not "> foo")

  - avoid doing work outside of test blocks; in this case, we can stick
    the setup of ".git2" into the appropriate blocks

  - avoid modifying and then cleaning up the environment or current
    directory by using subshells and "git -C"

  - this test does a curious thing when testing the unpacking: it sets
    GIT_OBJECT_DIRECTORY, and then does a "git init" in the _original_
    directory, creating a weird mixed situation. Instead, it's much
    simpler to just "git init --bare" a new repository to unpack into,
    and check the results there. I renamed this "git2" instead of
    ".git2" to make it more clear it's a separate repo.

  - we can observe that the bodies of the no-delta, ref_delta, and
    ofs_delta cases are all virtually identical except for the pack
    creation, and factor out shared helper functions. I collapsed "do
    the unpack" and "check the results of the unpack" into a single
    test, since that makes the expected lifetime of the "git2" temporary
    directory more clear (that also lets us use test_when_finished to
    clean it up). This does make the "-v" output slightly less useful,
    but the improvement in reading the actual test code makes it worth
    it.

  - I dropped the "pwd" calls from some tests. These don't do anything
    functional, and I suspect may have been an aid for debugging when
    the script was more cavalier about leaving the working directory
    changed between tests.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5300-pack-object.sh | 243 ++++++++++++++---------------------------
 1 file changed, 85 insertions(+), 158 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 2fc5e68250..1e10c832a6 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -8,125 +8,74 @@ test_description='git pack-object
 '
 . ./test-lib.sh
 
-TRASH=$(pwd)
-
-test_expect_success \
-    'setup' \
-    'rm -f .git/index* &&
-     perl -e "print \"a\" x 4096;" > a &&
-     perl -e "print \"b\" x 4096;" > b &&
-     perl -e "print \"c\" x 4096;" > c &&
-     test-tool genrandom "seed a" 2097152 > a_big &&
-     test-tool genrandom "seed b" 2097152 > b_big &&
-     git update-index --add a a_big b b_big c &&
-     cat c >d && echo foo >>d && git update-index --add d &&
-     tree=$(git write-tree) &&
-     commit=$(git commit-tree $tree </dev/null) && {
-	 echo $tree &&
-	 echo $commit &&
-	 git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
-     } >obj-list && {
-	 git diff-tree --root -p $commit &&
-	 while read object
-	 do
-	    t=$(git cat-file -t $object) &&
-	    git cat-file $t $object || return 1
-	 done <obj-list
-     } >expect'
-
-test_expect_success \
-    'pack without delta' \
-    'packname_1=$(git pack-objects --window=0 test-1 <obj-list)'
-
-test_expect_success \
-    'pack-objects with bogus arguments' \
-    'test_must_fail git pack-objects --window=0 test-1 blah blah <obj-list'
-
-rm -fr .git2
-mkdir .git2
-
-test_expect_success \
-    'unpack without delta' \
-    "GIT_OBJECT_DIRECTORY=.git2/objects &&
-     export GIT_OBJECT_DIRECTORY &&
-     git init &&
-     git unpack-objects -n <test-1-${packname_1}.pack &&
-     git unpack-objects <test-1-${packname_1}.pack"
-
-unset GIT_OBJECT_DIRECTORY
-cd "$TRASH/.git2"
+test_expect_success 'setup' '
+	rm -f .git/index* &&
+	perl -e "print \"a\" x 4096;" >a &&
+	perl -e "print \"b\" x 4096;" >b &&
+	perl -e "print \"c\" x 4096;" >c &&
+	test-tool genrandom "seed a" 2097152 >a_big &&
+	test-tool genrandom "seed b" 2097152 >b_big &&
+	git update-index --add a a_big b b_big c &&
+	cat c >d && echo foo >>d && git update-index --add d &&
+	tree=$(git write-tree) &&
+	commit=$(git commit-tree $tree </dev/null) &&
+	{
+		echo $tree &&
+		echo $commit &&
+		git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
+	} >obj-list &&
+	{
+		git diff-tree --root -p $commit &&
+		while read object
+		do
+			t=$(git cat-file -t $object) &&
+			git cat-file $t $object || return 1
+		done <obj-list
+	} >expect
+'
 
-test_expect_success \
-    'check unpack without delta' \
-    '(cd ../.git && find objects -type f -print) |
-     while read path
-     do
-         cmp $path ../.git/$path || {
-	     echo $path differs.
-	     return 1
-	 }
-     done'
-cd "$TRASH"
+test_expect_success 'pack without delta' '
+	packname_1=$(git pack-objects --window=0 test-1 <obj-list)
+'
 
-test_expect_success \
-    'pack with REF_DELTA' \
-    'pwd &&
-     packname_2=$(git pack-objects test-2 <obj-list)'
+test_expect_success 'pack-objects with bogus arguments' '
+	test_must_fail git pack-objects --window=0 test-1 blah blah <obj-list
+'
 
-rm -fr .git2
-mkdir .git2
+check_unpack () {
+	test_when_finished "rm -rf git2" &&
+	git init --bare git2 &&
+	git -C git2 unpack-objects -n <"$1".pack &&
+	git -C git2 unpack-objects <"$1".pack &&
+	(cd .git && find objects -type f -print) |
+	while read path
+	do
+		cmp git2/$path .git/$path || {
+			echo $path differs.
+			return 1
+		}
+	done
+}
+
+test_expect_success 'unpack without delta' '
+	check_unpack test-1-${packname_1}
+'
 
-test_expect_success \
-    'unpack with REF_DELTA' \
-    'GIT_OBJECT_DIRECTORY=.git2/objects &&
-     export GIT_OBJECT_DIRECTORY &&
-     git init &&
-     git unpack-objects -n <test-2-${packname_2}.pack &&
-     git unpack-objects <test-2-${packname_2}.pack'
-
-unset GIT_OBJECT_DIRECTORY
-cd "$TRASH/.git2"
-test_expect_success \
-    'check unpack with REF_DELTA' \
-    '(cd ../.git && find objects -type f -print) |
-     while read path
-     do
-         cmp $path ../.git/$path || {
-	     echo $path differs.
-	     return 1
-	 }
-     done'
-cd "$TRASH"
+test_expect_success 'pack with REF_DELTA' '
+	packname_2=$(git pack-objects test-2 <obj-list)
+'
 
-test_expect_success \
-    'pack with OFS_DELTA' \
-    'pwd &&
-     packname_3=$(git pack-objects --delta-base-offset test-3 <obj-list)'
+test_expect_success 'unpack with REF_DELTA' '
+	check_unpack test-2-${packname_2}
+'
 
-rm -fr .git2
-mkdir .git2
+test_expect_success 'pack with OFS_DELTA' '
+	packname_3=$(git pack-objects --delta-base-offset test-3 <obj-list)
+'
 
-test_expect_success \
-    'unpack with OFS_DELTA' \
-    'GIT_OBJECT_DIRECTORY=.git2/objects &&
-     export GIT_OBJECT_DIRECTORY &&
-     git init &&
-     git unpack-objects -n <test-3-${packname_3}.pack &&
-     git unpack-objects <test-3-${packname_3}.pack'
-
-unset GIT_OBJECT_DIRECTORY
-cd "$TRASH/.git2"
-test_expect_success \
-    'check unpack with OFS_DELTA' \
-    '(cd ../.git && find objects -type f -print) |
-     while read path
-     do
-         cmp $path ../.git/$path || {
-	     echo $path differs.
-	     return 1
-	 }
-     done'
-cd "$TRASH"
+test_expect_success 'unpack with OFS_DELTA' '
+	check_unpack test-3-${packname_3}
+'
 
 test_expect_success 'compare delta flavors' '
 	perl -e '\''
@@ -135,55 +84,33 @@ test_expect_success 'compare delta flavors' '
 	'\'' test-2-$packname_2.pack test-3-$packname_3.pack
 '
 
-rm -fr .git2
-mkdir .git2
+check_use_objects () {
+	test_when_finished "rm -rf git2" &&
+	git init --bare git2 &&
+	cp "$1".pack "$1".idx git2/objects/pack &&
+	(
+		cd git2 &&
+		git diff-tree --root -p $commit &&
+		while read object
+		do
+			t=$(git cat-file -t $object) &&
+			git cat-file $t $object || exit 1
+		done
+	) <obj-list >current &&
+	cmp expect current
+}
 
-test_expect_success \
-    'use packed objects' \
-    'GIT_OBJECT_DIRECTORY=.git2/objects &&
-     export GIT_OBJECT_DIRECTORY &&
-     git init &&
-     cp test-1-${packname_1}.pack test-1-${packname_1}.idx .git2/objects/pack && {
-	 git diff-tree --root -p $commit &&
-	 while read object
-	 do
-	    t=$(git cat-file -t $object) &&
-	    git cat-file $t $object || return 1
-	 done <obj-list
-    } >current &&
-    cmp expect current'
+test_expect_success 'use packed objects' '
+	check_use_objects test-1-${packname_1}
+'
 
-test_expect_success \
-    'use packed deltified (REF_DELTA) objects' \
-    'GIT_OBJECT_DIRECTORY=.git2/objects &&
-     export GIT_OBJECT_DIRECTORY &&
-     rm -f .git2/objects/pack/test-* &&
-     cp test-2-${packname_2}.pack test-2-${packname_2}.idx .git2/objects/pack && {
-	 git diff-tree --root -p $commit &&
-	 while read object
-	 do
-	    t=$(git cat-file -t $object) &&
-	    git cat-file $t $object || return 1
-	 done <obj-list
-    } >current &&
-    cmp expect current'
+test_expect_success 'use packed deltified (REF_DELTA) objects' '
+	check_use_objects test-2-${packname_2}
+'
 
-test_expect_success \
-    'use packed deltified (OFS_DELTA) objects' \
-    'GIT_OBJECT_DIRECTORY=.git2/objects &&
-     export GIT_OBJECT_DIRECTORY &&
-     rm -f .git2/objects/pack/test-* &&
-     cp test-3-${packname_3}.pack test-3-${packname_3}.idx .git2/objects/pack && {
-	 git diff-tree --root -p $commit &&
-	 while read object
-	 do
-	    t=$(git cat-file -t $object) &&
-	    git cat-file $t $object || return 1
-	 done <obj-list
-    } >current &&
-    cmp expect current'
-
-unset GIT_OBJECT_DIRECTORY
+test_expect_success 'use packed deltified (OFS_DELTA) objects' '
+	check_use_objects test-3-${packname_3}
+'
 
 test_expect_success 'survive missing objects/pack directory' '
 	(
-- 
2.31.1.875.g5dccece0aa

