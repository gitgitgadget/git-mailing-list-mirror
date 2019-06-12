Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18AC11F462
	for <e@80x24.org>; Wed, 12 Jun 2019 16:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440330AbfFLQeS (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 12:34:18 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:6572 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440337AbfFLQeP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 12:34:15 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45PCBC2wD9z5tlC;
        Wed, 12 Jun 2019 18:34:11 +0200 (CEST)
Received: from dx.site (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 17D23221F;
        Wed, 12 Jun 2019 18:34:11 +0200 (CEST)
From:   Johannes Sixt <j6t@kdbg.org>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, gitster@pobox.com,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 2/4] t7610-mergetool: use test_cmp instead of test $(cat file) = $txt
Date:   Wed, 12 Jun 2019 18:33:46 +0200
Message-Id: <82bafc90de5892d95b17c95f8193660a2fcd3b9c.1560356675.git.j6t@kdbg.org>
X-Mailer: git-send-email 2.21.0.285.gc38d92e052
In-Reply-To: <cover.1560356675.git.j6t@kdbg.org>
References: <cover.1560356675.git.j6t@kdbg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix that anti-pattern by a sequence of echo and test_cmp.

The patch was generated with this command:

   sed -i -e '/test.*(cat/s/^\(\t*\)test "..cat \(.*\))" = \(".*"\)\(.*\)/\1echo \3 >expect \&\&\n\1test_cmp expect \2\4/' t7610-mergetool.sh

This helps on Windows, where test_cmp avoids spawning a process when
there is no difference.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t7610-mergetool.sh | 135 ++++++++++++++++++++++++++++---------------
 1 file changed, 90 insertions(+), 45 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index b67440882b..ad288ddc69 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -138,10 +138,14 @@ test_expect_success 'custom mergetool' '
 	yes "d" | git mergetool file11 &&
 	yes "d" | git mergetool file12 &&
 	yes "l" | git mergetool submod &&
-	test "$(cat file1)" = "master updated" &&
-	test "$(cat file2)" = "master new" &&
-	test "$(cat subdir/file3)" = "master new sub" &&
-	test "$(cat submod/bar)" = "branch1 submodule" &&
+	echo "master updated" >expect &&
+	test_cmp expect file1 &&
+	echo "master new" >expect &&
+	test_cmp expect file2 &&
+	echo "master new sub" >expect &&
+	test_cmp expect subdir/file3 &&
+	echo "branch1 submodule" >expect &&
+	test_cmp expect submod/bar &&
 	git commit -m "branch1 resolved with mergetool"
 '
 
@@ -160,10 +164,14 @@ test_expect_success 'gui mergetool' '
 	yes "d" | git mergetool --gui file11 &&
 	yes "d" | git mergetool --gui file12 &&
 	yes "l" | git mergetool --gui submod &&
-	test "$(cat file1)" = "gui master updated" &&
-	test "$(cat file2)" = "gui master new" &&
-	test "$(cat subdir/file3)" = "gui master new sub" &&
-	test "$(cat submod/bar)" = "branch1 submodule" &&
+	echo "gui master updated" >expect &&
+	test_cmp expect file1 &&
+	echo "gui master new" >expect &&
+	test_cmp expect file2 &&
+	echo "gui master new sub" >expect &&
+	test_cmp expect subdir/file3 &&
+	echo "branch1 submodule" >expect &&
+	test_cmp expect submod/bar &&
 	git commit -m "branch1 resolved with mergetool"
 '
 
@@ -179,10 +187,14 @@ test_expect_success 'gui mergetool without merge.guitool set falls back to merge
 	yes "d" | git mergetool --gui file11 &&
 	yes "d" | git mergetool --gui file12 &&
 	yes "l" | git mergetool --gui submod &&
-	test "$(cat file1)" = "master updated" &&
-	test "$(cat file2)" = "master new" &&
-	test "$(cat subdir/file3)" = "master new sub" &&
-	test "$(cat submod/bar)" = "branch1 submodule" &&
+	echo "master updated" >expect &&
+	test_cmp expect file1 &&
+	echo "master new" >expect &&
+	test_cmp expect file2 &&
+	echo "master new sub" >expect &&
+	test_cmp expect subdir/file3 &&
+	echo "branch1 submodule" >expect &&
+	test_cmp expect submod/bar &&
 	git commit -m "branch1 resolved with mergetool"
 '
 
@@ -207,7 +219,8 @@ test_expect_success 'mergetool crlf' '
 	test "$(printf x | cat file2 -)" = "$(printf "master new\r\nx")" &&
 	test "$(printf x | cat subdir/file3 -)" = "$(printf "master new sub\r\nx")" &&
 	git submodule update -N &&
-	test "$(cat submod/bar)" = "master submodule" &&
+	echo "master submodule" >expect &&
+	test_cmp expect submod/bar &&
 	git commit -m "branch1 resolved with mergetool - autocrlf"
 '
 
@@ -219,7 +232,8 @@ test_expect_success 'mergetool in subdir' '
 		cd subdir &&
 		test_must_fail git merge master &&
 		yes "" | git mergetool file3 &&
-		test "$(cat file3)" = "master new sub"
+		echo "master new sub" >expect &&
+		test_cmp expect file3
 	)
 '
 
@@ -237,9 +251,12 @@ test_expect_success 'mergetool on file in parent dir' '
 		yes "d" | git mergetool ../file11 &&
 		yes "d" | git mergetool ../file12 &&
 		yes "l" | git mergetool ../submod &&
-		test "$(cat ../file1)" = "master updated" &&
-		test "$(cat ../file2)" = "master new" &&
-		test "$(cat ../submod/bar)" = "branch1 submodule" &&
+		echo "master updated" >expect &&
+		test_cmp expect ../file1 &&
+		echo "master new" >expect &&
+		test_cmp expect ../file2 &&
+		echo "branch1 submodule" >expect &&
+		test_cmp expect ../submod/bar &&
 		git commit -m "branch1 resolved with mergetool - subdir"
 	)
 '
@@ -266,11 +283,15 @@ test_expect_success 'mergetool merges all from subdir (rerere disabled)' '
 		test_must_fail git merge master &&
 		yes "r" | git mergetool ../submod &&
 		yes "d" "d" | git mergetool --no-prompt &&
-		test "$(cat ../file1)" = "master updated" &&
-		test "$(cat ../file2)" = "master new" &&
-		test "$(cat file3)" = "master new sub" &&
+		echo "master updated" >expect &&
+		test_cmp expect ../file1 &&
+		echo "master new" >expect &&
+		test_cmp expect ../file2 &&
+		echo "master new sub" >expect &&
+		test_cmp expect file3 &&
 		( cd .. && git submodule update -N ) &&
-		test "$(cat ../submod/bar)" = "master submodule" &&
+		echo "master submodule" >expect &&
+		test_cmp expect ../submod/bar &&
 		git commit -m "branch2 resolved by mergetool from subdir"
 	)
 '
@@ -285,11 +306,15 @@ test_expect_success 'mergetool merges all from subdir (rerere enabled)' '
 		test_must_fail git merge master &&
 		yes "r" | git mergetool ../submod &&
 		yes "d" "d" | git mergetool --no-prompt &&
-		test "$(cat ../file1)" = "master updated" &&
-		test "$(cat ../file2)" = "master new" &&
-		test "$(cat file3)" = "master new sub" &&
+		echo "master updated" >expect &&
+		test_cmp expect ../file1 &&
+		echo "master new" >expect &&
+		test_cmp expect ../file2 &&
+		echo "master new sub" >expect &&
+		test_cmp expect file3 &&
 		( cd .. && git submodule update -N ) &&
-		test "$(cat ../submod/bar)" = "master submodule" &&
+		echo "master submodule" >expect &&
+		test_cmp expect ../submod/bar &&
 		git commit -m "branch2 resolved by mergetool from subdir"
 	)
 '
@@ -345,7 +370,8 @@ test_expect_success 'mergetool takes partial path' '
 
 	yes "" | git mergetool subdir &&
 
-	test "$(cat subdir/file3)" = "master new sub"
+	echo "master new sub" >expect &&
+	test_cmp expect subdir/file3
 '
 
 test_expect_success 'mergetool delete/delete conflict' '
@@ -415,9 +441,11 @@ test_expect_success 'deleted vs modified submodule' '
 	yes "d" | git mergetool file11 file12 &&
 	yes "r" | git mergetool submod &&
 	rmdir submod && mv submod-movedaside submod &&
-	test "$(cat submod/bar)" = "branch1 submodule" &&
+	echo "branch1 submodule" >expect &&
+	test_cmp expect submod/bar &&
 	git submodule update -N &&
-	test "$(cat submod/bar)" = "master submodule" &&
+	echo "master submodule" >expect &&
+	test_cmp expect submod/bar &&
 	output="$(git mergetool --no-prompt)" &&
 	test "$output" = "No files need merging" &&
 	git commit -m "Merge resolved by keeping module" &&
@@ -461,9 +489,11 @@ test_expect_success 'deleted vs modified submodule' '
 	yes "" | git mergetool both &&
 	yes "d" | git mergetool file11 file12 &&
 	yes "l" | git mergetool submod &&
-	test "$(cat submod/bar)" = "master submodule" &&
+	echo "master submodule" >expect &&
+	test_cmp expect submod/bar &&
 	git submodule update -N &&
-	test "$(cat submod/bar)" = "master submodule" &&
+	echo "master submodule" >expect &&
+	test_cmp expect submod/bar &&
 	output="$(git mergetool --no-prompt)" &&
 	test "$output" = "No files need merging" &&
 	git commit -m "Merge resolved by keeping module"
@@ -486,9 +516,11 @@ test_expect_success 'file vs modified submodule' '
 	yes "d" | git mergetool file11 file12 &&
 	yes "r" | git mergetool submod &&
 	rmdir submod && mv submod-movedaside submod &&
-	test "$(cat submod/bar)" = "branch1 submodule" &&
+	echo "branch1 submodule" >expect &&
+	test_cmp expect submod/bar &&
 	git submodule update -N &&
-	test "$(cat submod/bar)" = "master submodule" &&
+	echo "master submodule" >expect &&
+	test_cmp expect submod/bar &&
 	output="$(git mergetool --no-prompt)" &&
 	test "$output" = "No files need merging" &&
 	git commit -m "Merge resolved by keeping module" &&
@@ -502,7 +534,8 @@ test_expect_success 'file vs modified submodule' '
 	yes "d" | git mergetool file11 file12 &&
 	yes "l" | git mergetool submod &&
 	git submodule update -N &&
-	test "$(cat submod)" = "not a submodule" &&
+	echo "not a submodule" >expect &&
+	test_cmp expect submod &&
 	output="$(git mergetool --no-prompt)" &&
 	test "$output" = "No files need merging" &&
 	git commit -m "Merge resolved by keeping file" &&
@@ -519,7 +552,8 @@ test_expect_success 'file vs modified submodule' '
 	yes "r" | git mergetool submod &&
 	test -d submod.orig &&
 	git submodule update -N &&
-	test "$(cat submod)" = "not a submodule" &&
+	echo "not a submodule" >expect &&
+	test_cmp expect submod &&
 	output="$(git mergetool --no-prompt)" &&
 	test "$output" = "No files need merging" &&
 	git commit -m "Merge resolved by keeping file" &&
@@ -533,9 +567,11 @@ test_expect_success 'file vs modified submodule' '
 	yes "" | git mergetool both &&
 	yes "d" | git mergetool file11 file12 &&
 	yes "l" | git mergetool submod &&
-	test "$(cat submod/bar)" = "master submodule" &&
+	echo "master submodule" >expect &&
+	test_cmp expect submod/bar &&
 	git submodule update -N &&
-	test "$(cat submod/bar)" = "master submodule" &&
+	echo "master submodule" >expect &&
+	test_cmp expect submod/bar &&
 	output="$(git mergetool --no-prompt)" &&
 	test "$output" = "No files need merging" &&
 	git commit -m "Merge resolved by keeping module"
@@ -589,17 +625,21 @@ test_expect_success 'submodule in subdirectory' '
 		cd subdir &&
 		yes "l" | git mergetool subdir_module
 	) &&
-	test "$(cat subdir/subdir_module/file15)" = "test$test_count.b" &&
+	echo "test$test_count.b" >expect &&
+	test_cmp expect subdir/subdir_module/file15 &&
 	git submodule update -N &&
-	test "$(cat subdir/subdir_module/file15)" = "test$test_count.b" &&
+	echo "test$test_count.b" >expect &&
+	test_cmp expect subdir/subdir_module/file15 &&
 	git reset --hard &&
 	git submodule update -N &&
 
 	test_must_fail git merge test$test_count.a &&
 	yes "r" | git mergetool subdir/subdir_module &&
-	test "$(cat subdir/subdir_module/file15)" = "test$test_count.b" &&
+	echo "test$test_count.b" >expect &&
+	test_cmp expect subdir/subdir_module/file15 &&
 	git submodule update -N &&
-	test "$(cat subdir/subdir_module/file15)" = "test$test_count.a" &&
+	echo "test$test_count.a" >expect &&
+	test_cmp expect subdir/subdir_module/file15 &&
 	git commit -m "branch1 resolved with mergetool"
 '
 
@@ -616,7 +656,8 @@ test_expect_success 'directory vs modified submodule' '
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
 	yes "l" | git mergetool submod &&
-	test "$(cat submod/file16)" = "not a submodule" &&
+	echo "not a submodule" >expect &&
+	test_cmp expect submod/file16 &&
 	rm -rf submod.orig &&
 
 	git reset --hard &&
@@ -625,12 +666,14 @@ test_expect_success 'directory vs modified submodule' '
 	test ! -e submod.orig &&
 	yes "r" | git mergetool submod &&
 	test -d submod.orig &&
-	test "$(cat submod.orig/file16)" = "not a submodule" &&
+	echo "not a submodule" >expect &&
+	test_cmp expect submod.orig/file16 &&
 	rm -r submod.orig &&
 	mv submod-movedaside/.git submod &&
 	( cd submod && git clean -f && git reset --hard ) &&
 	git submodule update -N &&
-	test "$(cat submod/bar)" = "master submodule" &&
+	echo "master submodule" >expect &&
+	test_cmp expect submod/bar &&
 	git reset --hard &&
 	rm -rf submod-movedaside &&
 
@@ -640,7 +683,8 @@ test_expect_success 'directory vs modified submodule' '
 	test -n "$(git ls-files -u)" &&
 	yes "l" | git mergetool submod &&
 	git submodule update -N &&
-	test "$(cat submod/bar)" = "master submodule" &&
+	echo "master submodule" >expect &&
+	test_cmp expect submod/bar &&
 
 	git reset --hard &&
 	git submodule update -N &&
@@ -648,7 +692,8 @@ test_expect_success 'directory vs modified submodule' '
 	test -n "$(git ls-files -u)" &&
 	test ! -e submod.orig &&
 	yes "r" | git mergetool submod &&
-	test "$(cat submod/file16)" = "not a submodule" &&
+	echo "not a submodule" >expect &&
+	test_cmp expect submod/file16 &&
 
 	git reset --hard master &&
 	( cd submod && git clean -f && git reset --hard ) &&
-- 
2.21.0.285.gc38d92e052

