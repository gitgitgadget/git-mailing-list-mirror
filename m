Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E15C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF12861007
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbhDZRsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:48:31 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:39124 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237563AbhDZRsX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 13:48:23 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 01E1A80595;
        Mon, 26 Apr 2021 13:47:40 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH v2 06/30] subtree: t7900: use 'test' for string equality
Date:   Mon, 26 Apr 2021 11:45:01 -0600
Message-Id: <20210426174525.3937858-7-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426174525.3937858-1-lukeshu@lukeshu.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
 <20210426174525.3937858-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

t7900-subtree.sh defines its own `check_equal A B` function, instead of
just using `test A = B` like all of the other tests.  Don't be special,
get rid of `check_equal` in favor of `test`.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 contrib/subtree/t/t7900-subtree.sh | 60 ++++++++++++------------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index cac08af7f7..3aa5545e5e 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -28,18 +28,6 @@ create () {
 	git add "$1"
 }
 
-check_equal () {
-	test_debug 'echo'
-	test_debug "echo \"check a:\" \"{$1}\""
-	test_debug "echo \"      b:\" \"{$2}\""
-	if test "$1" = "$2"
-	then
-		return 0
-	else
-		return 1
-	fi
-}
-
 undo () {
 	git reset --hard HEAD~
 }
@@ -122,7 +110,7 @@ test_expect_success 'add subproj as subtree into sub dir/ with --prefix' '
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD &&
-		check_equal "$(last_commit_message)" "Add '\''sub dir/'\'' from commit '\''$(git rev-parse FETCH_HEAD)'\''"
+		test "$(last_commit_message)" = "Add '\''sub dir/'\'' from commit '\''$(git rev-parse FETCH_HEAD)'\''"
 	)
 '
 
@@ -135,7 +123,7 @@ test_expect_success 'add subproj as subtree into sub dir/ with --prefix and --me
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" --message="Added subproject" FETCH_HEAD &&
-		check_equal "$(last_commit_message)" "Added subproject"
+		test "$(last_commit_message)" = "Added subproject"
 	)
 '
 
@@ -148,7 +136,7 @@ test_expect_success 'add subproj as subtree into sub dir/ with --prefix as -P an
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add -P "sub dir" -m "Added subproject" FETCH_HEAD &&
-		check_equal "$(last_commit_message)" "Added subproject"
+		test "$(last_commit_message)" = "Added subproject"
 	)
 '
 
@@ -161,7 +149,7 @@ test_expect_success 'add subproj as subtree into sub dir/ with --squash and --pr
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" --message="Added subproject with squash" --squash FETCH_HEAD &&
-		check_equal "$(last_commit_message)" "Added subproject with squash"
+		test "$(last_commit_message)" = "Added subproject with squash"
 	)
 '
 
@@ -184,7 +172,7 @@ test_expect_success 'merge new subproj history into sub dir/ with --prefix' '
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
-		check_equal "$(last_commit_message)" "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
+		test "$(last_commit_message)" = "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
 	)
 '
 
@@ -203,7 +191,7 @@ test_expect_success 'merge new subproj history into sub dir/ with --prefix and -
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" --message="Merged changes from subproject" FETCH_HEAD &&
-		check_equal "$(last_commit_message)" "Merged changes from subproject"
+		test "$(last_commit_message)" = "Merged changes from subproject"
 	)
 '
 
@@ -222,7 +210,7 @@ test_expect_success 'merge new subproj history into sub dir/ with --squash and -
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" --message="Merged changes from subproject using squash" --squash FETCH_HEAD &&
-		check_equal "$(last_commit_message)" "Merged changes from subproject using squash"
+		test "$(last_commit_message)" = "Merged changes from subproject using squash"
 	)
 '
 
@@ -238,7 +226,7 @@ test_expect_success 'merge the added subproj again, should do nothing' '
 		# this shouldn not actually do anything, since FETCH_HEAD
 		# is already a parent
 		result=$(git merge -s ours -m "merge -s -ours" FETCH_HEAD) &&
-		check_equal "${result}" "Already up to date."
+		test "${result}" = "Already up to date."
 	)
 '
 
@@ -257,7 +245,7 @@ test_expect_success 'merge new subproj history into subdir/ with a slash appende
 		cd "$test_count" &&
 		git fetch ./subproj HEAD &&
 		git subtree merge --prefix=subdir/ FETCH_HEAD &&
-		check_equal "$(last_commit_message)" "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
+		test "$(last_commit_message)" = "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
 	)
 '
 
@@ -323,7 +311,7 @@ test_expect_success 'split sub dir/ with --rejoin' '
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
 		git subtree split --prefix="sub dir" --annotate="*" --rejoin &&
-		check_equal "$(last_commit_message)" "Split '\''sub dir/'\'' into commit '\''$split_hash'\''"
+		test "$(last_commit_message)" = "Split '\''sub dir/'\'' into commit '\''$split_hash'\''"
 	)
 '
 
@@ -338,7 +326,7 @@ test_expect_success 'split sub dir/ with --rejoin from scratch' '
 		git commit -m"sub dir file" &&
 		split_hash=$(git subtree split --prefix="sub dir" --rejoin) &&
 		git subtree split --prefix="sub dir" --rejoin &&
-		check_equal "$(last_commit_message)" "Split '\''sub dir/'\'' into commit '\''$split_hash'\''"
+		test "$(last_commit_message)" = "Split '\''sub dir/'\'' into commit '\''$split_hash'\''"
 	)
 '
 
@@ -361,7 +349,7 @@ test_expect_success 'split sub dir/ with --rejoin and --message' '
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		git subtree split --prefix="sub dir" --message="Split & rejoin" --annotate="*" --rejoin &&
-		check_equal "$(last_commit_message)" "Split & rejoin"
+		test "$(last_commit_message)" = "Split & rejoin"
 	)
 '
 
@@ -385,7 +373,7 @@ test_expect_success 'split "sub dir"/ with --branch' '
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br &&
-		check_equal "$(git rev-parse subproj-br)" "$split_hash"
+		test "$(git rev-parse subproj-br)" = "$split_hash"
 	)
 '
 
@@ -409,13 +397,13 @@ test_expect_success 'check hash of split' '
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br &&
-		check_equal "$(git rev-parse subproj-br)" "$split_hash" &&
+		test "$(git rev-parse subproj-br)" = "$split_hash" &&
 		# Check hash of split
 		new_hash=$(git rev-parse subproj-br^2) &&
 		(
 			cd ./"sub proj" &&
 			subdir_hash=$(git rev-parse HEAD) &&
-			check_equal ''"$new_hash"'' "$subdir_hash"
+			test ''"$new_hash"'' = "$subdir_hash"
 		)
 	)
 '
@@ -441,7 +429,7 @@ test_expect_success 'split "sub dir"/ with --branch for an existing branch' '
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br &&
-		check_equal "$(git rev-parse subproj-br)" "$split_hash"
+		test "$(git rev-parse subproj-br)" = "$split_hash"
 	)
 '
 
@@ -739,7 +727,7 @@ test_expect_success 'make sure the --rejoin commits never make it into subproj'
 	(
 		cd "$test_count" &&
 		git subtree pull --prefix="sub dir" ./"sub proj" HEAD &&
-		check_equal "$(git log --pretty=format:"%s" HEAD^2 | grep -i split)" ""
+		test "$(git log --pretty=format:"%s" HEAD^2 | grep -i split)" = ""
 	)
 '
 
@@ -790,7 +778,7 @@ test_expect_success 'make sure no "git subtree" tagged commits make it into subp
 		git subtree pull --prefix="sub dir" ./"sub proj" HEAD &&
 
 		# They are meaningless to subproj since one side of the merge refers to the mainline
-		check_equal "$(git log --pretty=format:"%s%n%b" HEAD^2 | grep "git-subtree.*:")" ""
+		test "$(git log --pretty=format:"%s%n%b" HEAD^2 | grep "git-subtree.*:")" = ""
 	)
 '
 
@@ -824,7 +812,7 @@ test_expect_success 'make sure "git subtree split" find the correct parent' '
 		# not, something went wrong (the "newparent" of "HEAD~" commit should
 		# have been sub2, but it was not, because its cache was not set to
 		# itself)
-		check_equal "$(git log --pretty=format:%P -1 subproj-br)" "$(git rev-parse subproj-ref)"
+		test "$(git log --pretty=format:%P -1 subproj-br)" = "$(git rev-parse subproj-ref)"
 	)
 '
 
@@ -858,7 +846,7 @@ test_expect_success 'split a new subtree without --onto option' '
 		# if the parent of the first commit in the tree is not empty,
 		# then the new subtree has accidentally been attached to something
 		git subtree split --prefix="sub dir2" --branch subproj2-br &&
-		check_equal "$(git log --pretty=format:%P -1 subproj2-br)" ""
+		test "$(git log --pretty=format:%P -1 subproj2-br)" = ""
 	)
 '
 
@@ -897,10 +885,10 @@ test_expect_success 'verify one file change per commit' '
 				test_debug "echo Verifying commit $commit"
 				test_debug "echo a: $a"
 				test_debug "echo b: $b"
-				check_equal "$b" ""
+				test "$b" = ""
 				x=1
 			done
-			check_equal "$x" 1
+			test "$x" = 1
 		)
 	)
 '
@@ -932,7 +920,7 @@ test_expect_success 'push split to subproj' '
 		git subtree push ./"sub proj" --prefix "sub dir" sub-branch-1 &&
 		cd ./"sub proj" &&
 		git checkout sub-branch-1 &&
-		check_equal "$(last_commit_message)" "sub dir/main-sub3"
+		test "$(last_commit_message)" = "sub dir/main-sub3"
 	)
 '
 
@@ -992,7 +980,7 @@ test_expect_success 'subtree descendant check' '
 
 		git subtree split --prefix folder_subtree/ --branch subtree_tip $defaultBranch &&
 		git subtree split --prefix folder_subtree/ --branch subtree_branch branch &&
-		check_equal $(git rev-list --count subtree_tip..subtree_branch) 0
+		test $(git rev-list --count subtree_tip..subtree_branch) = 0
 	)
 '
 
-- 
2.31.1

