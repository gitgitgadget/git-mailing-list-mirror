Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB20C43470
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 496296145F
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243828AbhDWTnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhDWTnX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 15:43:23 -0400
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA01C061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 12:42:46 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id D416280593;
        Fri, 23 Apr 2021 15:42:43 -0400 (EDT)
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
        Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH 03/30] subtree: t7900: use test-lib.sh's test_count
Date:   Fri, 23 Apr 2021 13:42:03 -0600
Message-Id: <20210423194230.1388945-4-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423194230.1388945-1-lukeshu@lukeshu.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

Use test-lib.sh's `test_count`, instead instead of having
t7900-subtree.sh do its own book-keeping with `subtree_test_count` that
has to be explicitly incremented by calling `next_test`.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 contrib/subtree/t/t7900-subtree.sh | 636 ++++++++++++++---------------
 1 file changed, 300 insertions(+), 336 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 4b982e6c2e..a6351d9195 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -86,90 +86,79 @@ last_commit_message()
 	git log --pretty=format:%s -1
 }
 
-subtree_test_count=0
-next_test() {
-	subtree_test_count=$(($subtree_test_count+1))
-}
-
 #
 # Tests for 'git subtree add'
 #
 
-next_test
 test_expect_success 'no merge from non-existent subtree' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		test_must_fail git subtree merge --prefix="sub dir" FETCH_HEAD
 	)
 '
 
-next_test
 test_expect_success 'no pull from non-existent subtree' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		test_must_fail git subtree pull --prefix="sub dir" ./"sub proj" HEAD
 	)'
 
-next_test
 test_expect_success 'add subproj as subtree into sub dir/ with --prefix' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD &&
 		check_equal "$(last_commit_message)" "Add '\''sub dir/'\'' from commit '\''$(git rev-parse FETCH_HEAD)'\''"
 	)
 '
 
-next_test
 test_expect_success 'add subproj as subtree into sub dir/ with --prefix and --message' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" --message="Added subproject" FETCH_HEAD &&
 		check_equal "$(last_commit_message)" "Added subproject"
 	)
 '
 
-next_test
 test_expect_success 'add subproj as subtree into sub dir/ with --prefix as -P and --message as -m' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add -P "sub dir" -m "Added subproject" FETCH_HEAD &&
 		check_equal "$(last_commit_message)" "Added subproject"
 	)
 '
 
-next_test
 test_expect_success 'add subproj as subtree into sub dir/ with --squash and --prefix and --message' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" --message="Added subproject with squash" --squash FETCH_HEAD &&
 		check_equal "$(last_commit_message)" "Added subproject with squash"
@@ -180,74 +169,70 @@ test_expect_success 'add subproj as subtree into sub dir/ with --squash and --pr
 # Tests for 'git subtree merge'
 #
 
-next_test
 test_expect_success 'merge new subproj history into sub dir/ with --prefix' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count/sub proj" sub2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		check_equal "$(last_commit_message)" "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
 	)
 '
 
-next_test
 test_expect_success 'merge new subproj history into sub dir/ with --prefix and --message' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count/sub proj" sub2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" --message="Merged changes from subproject" FETCH_HEAD &&
 		check_equal "$(last_commit_message)" "Merged changes from subproject"
 	)
 '
 
-next_test
 test_expect_success 'merge new subproj history into sub dir/ with --squash and --prefix and --message' '
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	subtree_test_create_repo "$subtree_test_count" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	subtree_test_create_repo "$test_count" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count/sub proj" sub2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" --message="Merged changes from subproject using squash" --squash FETCH_HEAD &&
 		check_equal "$(last_commit_message)" "Merged changes from subproject using squash"
 	)
 '
 
-next_test
 test_expect_success 'merge the added subproj again, should do nothing' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD &&
 		# this shouldn not actually do anything, since FETCH_HEAD
@@ -257,7 +242,6 @@ test_expect_success 'merge the added subproj again, should do nothing' '
 	)
 '
 
-next_test
 test_expect_success 'merge new subproj history into subdir/ with a slash appended to the argument of --prefix' '
 	test_create_repo "$test_count" &&
 	test_create_repo "$test_count/subproj" &&
@@ -281,14 +265,13 @@ test_expect_success 'merge new subproj history into subdir/ with a slash appende
 # Tests for 'git subtree split'
 #
 
-next_test
 test_expect_success 'split requires option --prefix' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD &&
 		echo "You must provide the --prefix option." > expected &&
@@ -301,14 +284,13 @@ test_expect_success 'split requires option --prefix' '
 	)
 '
 
-next_test
 test_expect_success 'split requires path given by option --prefix must exist' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD &&
 		echo "'\''non-existent-directory'\'' does not exist; use '\''git subtree add'\''" > expected &&
@@ -321,23 +303,22 @@ test_expect_success 'split requires path given by option --prefix must exist' '
 	)
 '
 
-next_test
 test_expect_success 'split sub dir/ with --rejoin' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
-	test_create_commit "$subtree_test_count" main2 &&
-	test_create_commit "$subtree_test_count/sub proj" sub2 &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
@@ -346,12 +327,11 @@ test_expect_success 'split sub dir/ with --rejoin' '
 	)
  '
 
-next_test
 test_expect_success 'split sub dir/ with --rejoin from scratch' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	test_create_commit "$subtree_test_count" main1 &&
+	subtree_test_create_repo "$test_count" &&
+	test_create_commit "$test_count" main1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		mkdir "sub dir" &&
 		echo file >"sub dir"/file &&
 		git add "sub dir/file" &&
@@ -362,23 +342,22 @@ test_expect_success 'split sub dir/ with --rejoin from scratch' '
 	)
  '
 
-next_test
 test_expect_success 'split sub dir/ with --rejoin and --message' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
-	test_create_commit "$subtree_test_count" main2 &&
-	test_create_commit "$subtree_test_count/sub proj" sub2 &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		git subtree split --prefix="sub dir" --message="Split & rejoin" --annotate="*" --rejoin &&
@@ -386,23 +365,22 @@ test_expect_success 'split sub dir/ with --rejoin and --message' '
 	)
 '
 
-next_test
 test_expect_success 'split "sub dir"/ with --branch' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
-	test_create_commit "$subtree_test_count" main2 &&
-	test_create_commit "$subtree_test_count/sub proj" sub2 &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
@@ -411,23 +389,22 @@ test_expect_success 'split "sub dir"/ with --branch' '
 	)
 '
 
-next_test
 test_expect_success 'check hash of split' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
-	test_create_commit "$subtree_test_count" main2 &&
-	test_create_commit "$subtree_test_count/sub proj" sub2 &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
@@ -443,24 +420,23 @@ test_expect_success 'check hash of split' '
 	)
 '
 
-next_test
 test_expect_success 'split "sub dir"/ with --branch for an existing branch' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git branch subproj-br FETCH_HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
-	test_create_commit "$subtree_test_count" main2 &&
-	test_create_commit "$subtree_test_count/sub proj" sub2 &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
@@ -469,24 +445,23 @@ test_expect_success 'split "sub dir"/ with --branch for an existing branch' '
 	)
 '
 
-next_test
 test_expect_success 'split "sub dir"/ with --branch for an incompatible branch' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git branch init HEAD &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
-	test_create_commit "$subtree_test_count" main2 &&
-	test_create_commit "$subtree_test_count/sub proj" sub2 &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		test_must_fail git subtree split --prefix="sub dir" --branch init
@@ -497,46 +472,45 @@ test_expect_success 'split "sub dir"/ with --branch for an incompatible branch'
 # Validity checking
 #
 
-next_test
 test_expect_success 'make sure exactly the right set of files ends up in the subproj' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
-	test_create_commit "$subtree_test_count" main2 &&
-	test_create_commit "$subtree_test_count/sub proj" sub2 &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
-	test_create_commit "$subtree_test_count/sub proj" sub3 &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub3 &&
+	test_create_commit "$test_count/sub proj" sub3 &&
+	test_create_commit "$test_count" "sub dir"/main-sub3 &&
 	(
-		cd "$subtree_test_count/sub proj" &&
+		cd "$test_count/sub proj" &&
 		git fetch .. subproj-br &&
 		git merge FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count/sub proj" sub4 &&
+	test_create_commit "$test_count/sub proj" sub4 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub4 &&
+	test_create_commit "$test_count" "sub dir"/main-sub4 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
 	(
-		cd "$subtree_test_count/sub proj" &&
+		cd "$test_count/sub proj" &&
 		git fetch .. subproj-br &&
 		git merge FETCH_HEAD &&
 
@@ -547,46 +521,45 @@ test_expect_success 'make sure exactly the right set of files ends up in the sub
 	)
 '
 
-next_test
 test_expect_success 'make sure the subproj *only* contains commits that affect the "sub dir"' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
-	test_create_commit "$subtree_test_count" main2 &&
-	test_create_commit "$subtree_test_count/sub proj" sub2 &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
-	test_create_commit "$subtree_test_count/sub proj" sub3 &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub3 &&
+	test_create_commit "$test_count/sub proj" sub3 &&
+	test_create_commit "$test_count" "sub dir"/main-sub3 &&
 	(
-		cd "$subtree_test_count/sub proj" &&
+		cd "$test_count/sub proj" &&
 		git fetch .. subproj-br &&
 		git merge FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count/sub proj" sub4 &&
+	test_create_commit "$test_count/sub proj" sub4 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub4 &&
+	test_create_commit "$test_count" "sub dir"/main-sub4 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
 	(
-		cd "$subtree_test_count/sub proj" &&
+		cd "$test_count/sub proj" &&
 		git fetch .. subproj-br &&
 		git merge FETCH_HEAD &&
 
@@ -598,51 +571,50 @@ test_expect_success 'make sure the subproj *only* contains commits that affect t
 	)
 '
 
-next_test
 test_expect_success 'make sure exactly the right set of files ends up in the mainline' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
-	test_create_commit "$subtree_test_count" main2 &&
-	test_create_commit "$subtree_test_count/sub proj" sub2 &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
-	test_create_commit "$subtree_test_count/sub proj" sub3 &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub3 &&
+	test_create_commit "$test_count/sub proj" sub3 &&
+	test_create_commit "$test_count" "sub dir"/main-sub3 &&
 	(
-		cd "$subtree_test_count/sub proj" &&
+		cd "$test_count/sub proj" &&
 		git fetch .. subproj-br &&
 		git merge FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count/sub proj" sub4 &&
+	test_create_commit "$test_count/sub proj" sub4 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub4 &&
+	test_create_commit "$test_count" "sub dir"/main-sub4 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
 	(
-		cd "$subtree_test_count/sub proj" &&
+		cd "$test_count/sub proj" &&
 		git fetch .. subproj-br &&
 		git merge FETCH_HEAD
 	) &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git subtree pull --prefix="sub dir" ./"sub proj" HEAD &&
 
 		test_write_lines main1 main2 >chkm &&
@@ -657,52 +629,51 @@ test_expect_success 'make sure exactly the right set of files ends up in the mai
 	)
 '
 
-next_test
 test_expect_success 'make sure each filename changed exactly once in the entire history' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git config log.date relative &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
-	test_create_commit "$subtree_test_count" main2 &&
-	test_create_commit "$subtree_test_count/sub proj" sub2 &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
-	test_create_commit "$subtree_test_count/sub proj" sub3 &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub3 &&
+	test_create_commit "$test_count/sub proj" sub3 &&
+	test_create_commit "$test_count" "sub dir"/main-sub3 &&
 	(
-		cd "$subtree_test_count/sub proj" &&
+		cd "$test_count/sub proj" &&
 		git fetch .. subproj-br &&
 		git merge FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count/sub proj" sub4 &&
+	test_create_commit "$test_count/sub proj" sub4 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub4 &&
+	test_create_commit "$test_count" "sub dir"/main-sub4 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
 	(
-		cd "$subtree_test_count/sub proj" &&
+		cd "$test_count/sub proj" &&
 		git fetch .. subproj-br &&
 		git merge FETCH_HEAD
 	) &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git subtree pull --prefix="sub dir" ./"sub proj" HEAD &&
 
 		test_write_lines main1 main2 >chkm &&
@@ -723,101 +694,99 @@ test_expect_success 'make sure each filename changed exactly once in the entire
 	)
 '
 
-next_test
 test_expect_success 'make sure the --rejoin commits never make it into subproj' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
-	test_create_commit "$subtree_test_count" main2 &&
-	test_create_commit "$subtree_test_count/sub proj" sub2 &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
-	test_create_commit "$subtree_test_count/sub proj" sub3 &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub3 &&
+	test_create_commit "$test_count/sub proj" sub3 &&
+	test_create_commit "$test_count" "sub dir"/main-sub3 &&
 	(
-		cd "$subtree_test_count/sub proj" &&
+		cd "$test_count/sub proj" &&
 		git fetch .. subproj-br &&
 		git merge FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count/sub proj" sub4 &&
+	test_create_commit "$test_count/sub proj" sub4 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub4 &&
+	test_create_commit "$test_count" "sub dir"/main-sub4 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
 	(
-		cd "$subtree_test_count/sub proj" &&
+		cd "$test_count/sub proj" &&
 		git fetch .. subproj-br &&
 		git merge FETCH_HEAD
 	) &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git subtree pull --prefix="sub dir" ./"sub proj" HEAD &&
 		check_equal "$(git log --pretty=format:"%s" HEAD^2 | grep -i split)" ""
 	)
 '
 
-next_test
 test_expect_success 'make sure no "git subtree" tagged commits make it into subproj' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
-	test_create_commit "$subtree_test_count" main2 &&
-	test_create_commit "$subtree_test_count/sub proj" sub2 &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
-	test_create_commit "$subtree_test_count/sub proj" sub3 &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub3 &&
+	test_create_commit "$test_count/sub proj" sub3 &&
+	test_create_commit "$test_count" "sub dir"/main-sub3 &&
 	(
-		cd "$subtree_test_count/sub proj" &&
+		cd "$test_count/sub proj" &&
 		git fetch .. subproj-br &&
 		 git merge FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count/sub proj" sub4 &&
+	test_create_commit "$test_count/sub proj" sub4 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub4 &&
+	test_create_commit "$test_count" "sub dir"/main-sub4 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git subtree split --prefix="sub dir" --annotate="*" --branch subproj-br --rejoin
 	) &&
 	(
-		cd "$subtree_test_count/sub proj" &&
+		cd "$test_count/sub proj" &&
 		git fetch .. subproj-br &&
 		git merge FETCH_HEAD
 	) &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git subtree pull --prefix="sub dir" ./"sub proj" HEAD &&
 
 		# They are meaningless to subproj since one side of the merge refers to the mainline
@@ -829,27 +798,26 @@ test_expect_success 'make sure no "git subtree" tagged commits make it into subp
 # A new set of tests
 #
 
-next_test
 test_expect_success 'make sure "git subtree split" find the correct parent' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count/sub proj" sub2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git branch subproj-ref FETCH_HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git subtree split --prefix="sub dir" --branch subproj-br &&
 
 		# at this point, the new commit parent should be subproj-ref, if it is
@@ -860,32 +828,31 @@ test_expect_success 'make sure "git subtree split" find the correct parent' '
 	)
 '
 
-next_test
 test_expect_success 'split a new subtree without --onto option' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count/sub proj" sub2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git subtree split --prefix="sub dir" --branch subproj-br
 	) &&
-	mkdir "$subtree_test_count"/"sub dir2" &&
-	test_create_commit "$subtree_test_count" "sub dir2"/main-sub2 &&
+	mkdir "$test_count"/"sub dir2" &&
+	test_create_commit "$test_count" "sub dir2"/main-sub2 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 
 		# also test that we still can split out an entirely new subtree
 		# if the parent of the first commit in the tree is not empty,
@@ -895,33 +862,32 @@ test_expect_success 'split a new subtree without --onto option' '
 	)
 '
 
-next_test
 test_expect_success 'verify one file change per commit' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git branch sub1 FETCH_HEAD &&
 		git subtree add --prefix="sub dir" sub1
 	) &&
-	test_create_commit "$subtree_test_count/sub proj" sub2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git subtree split --prefix="sub dir" --branch subproj-br
 	) &&
-	mkdir "$subtree_test_count"/"sub dir2" &&
-	test_create_commit "$subtree_test_count" "sub dir2"/main-sub2 &&
+	mkdir "$test_count"/"sub dir2" &&
+	test_create_commit "$test_count" "sub dir2"/main-sub2 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git subtree split --prefix="sub dir2" --branch subproj2-br &&
 
 		x= &&
@@ -939,31 +905,30 @@ test_expect_success 'verify one file change per commit' '
 	)
 '
 
-next_test
 test_expect_success 'push split to subproj' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-	test_create_commit "$subtree_test_count" main1 &&
-	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub1 &&
-	test_create_commit "$subtree_test_count" main2 &&
-	test_create_commit "$subtree_test_count/sub proj" sub2 &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
 	(
-		cd $subtree_test_count/"sub proj" &&
+		cd $test_count/"sub proj" &&
                 git branch sub-branch-1 &&
                 cd .. &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD
 	) &&
-	test_create_commit "$subtree_test_count" "sub dir"/main-sub3 &&
+	test_create_commit "$test_count" "sub dir"/main-sub3 &&
         (
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 	        git subtree push ./"sub proj" --prefix "sub dir" sub-branch-1 &&
                 cd ./"sub proj" &&
                 git checkout sub-branch-1 &&
@@ -991,38 +956,37 @@ test_expect_success 'push split to subproj' '
 #   set of commits.
 #
 
-next_test
 test_expect_success 'subtree descendant check' '
-	subtree_test_create_repo "$subtree_test_count" &&
-	defaultBranch=$(sed "s,ref: refs/heads/,," "$subtree_test_count/.git/HEAD") &&
-	test_create_commit "$subtree_test_count" folder_subtree/a &&
+	subtree_test_create_repo "$test_count" &&
+	defaultBranch=$(sed "s,ref: refs/heads/,," "$test_count/.git/HEAD") &&
+	test_create_commit "$test_count" folder_subtree/a &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git branch branch
 	) &&
-	test_create_commit "$subtree_test_count" folder_subtree/0 &&
-	test_create_commit "$subtree_test_count" folder_subtree/b &&
-	cherry=$(cd "$subtree_test_count"; git rev-parse HEAD) &&
+	test_create_commit "$test_count" folder_subtree/0 &&
+	test_create_commit "$test_count" folder_subtree/b &&
+	cherry=$(cd "$test_count"; git rev-parse HEAD) &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git checkout branch
 	) &&
-	test_create_commit "$subtree_test_count" commit_on_branch &&
+	test_create_commit "$test_count" commit_on_branch &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git cherry-pick $cherry &&
 		git checkout $defaultBranch &&
 		git merge -m "merge should be kept on subtree" branch &&
 		git branch no_subtree_work_branch
 	) &&
-	test_create_commit "$subtree_test_count" folder_subtree/d &&
+	test_create_commit "$test_count" folder_subtree/d &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git checkout no_subtree_work_branch
 	) &&
-	test_create_commit "$subtree_test_count" not_a_subtree_change &&
+	test_create_commit "$test_count" not_a_subtree_change &&
 	(
-		cd "$subtree_test_count" &&
+		cd "$test_count" &&
 		git checkout $defaultBranch &&
 		git merge -m "merge should be skipped on subtree" no_subtree_work_branch &&
 
-- 
2.31.1

