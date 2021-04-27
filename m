Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972DAC433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53E1A613B1
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbhD0VTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 17:19:41 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:41632 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239201AbhD0VT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 17:19:28 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id E6A778059E;
        Tue, 27 Apr 2021 17:18:43 -0400 (EDT)
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
Subject: [PATCH v3 28/30] subtree: allow 'split' flags to be passed to 'push'
Date:   Tue, 27 Apr 2021 15:17:46 -0600
Message-Id: <20210427211748.2607474-29-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427211748.2607474-1-lukeshu@lukeshu.com>
References: <20210426174525.3937858-1-lukeshu@lukeshu.com>
 <20210427211748.2607474-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

'push' does a 'split' internally, but it doesn't pass flags through to the
'split'.  This is silly, if you need to pass flags to 'split', then it
means that you can't use 'push'!

So, have 'push' accept 'split' flags, and pass them through to 'split'.

Add tests for this by copying split's tests with minimal modification.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
v2:
 - In the added tests, use `test_must_fail` instead of `!`, as
   appropriate.

 contrib/subtree/git-subtree.sh     |   6 +-
 contrib/subtree/git-subtree.txt    |  15 +-
 contrib/subtree/t/t7900-subtree.sh | 214 ++++++++++++++++++++++++++++-
 3 files changed, 223 insertions(+), 12 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 25d69d7973..431214a1d3 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -33,13 +33,13 @@ h,help        show the help
 q             quiet
 d             show debug messages
 P,prefix=     the name of the subdir to split out
- options for 'split'
+ options for 'split' (also: 'push')
 annotate=     add a prefix to commit message of new commits
 b,branch=     create a new branch from the split subtree
 ignore-joins  ignore prior --rejoin commits
 onto=         try connecting new tree to an existing one
 rejoin        merge the new branch back into HEAD
- options for 'add' and 'merge' (also: 'pull' and 'split --rejoin')
+ options for 'add' and 'merge' (also: 'pull', 'split --rejoin', and 'push --rejoin')
 squash        merge subtree changes as a single commit
 m,message=    use the given message as the commit message for the merge commit
 "
@@ -964,7 +964,7 @@ cmd_push () {
 		repository=$1
 		refspec=$2
 		echo "git push using: " "$repository" "$refspec"
-		localrev=$(git subtree split --prefix="$arg_prefix") || die
+		localrev=$(cmd_split) || die
 		git push "$repository" "$localrev":"refs/heads/$refspec"
 	else
 		die "'$dir' must already exist. Try 'git subtree add'."
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index d7e6e7867c..fbb52f127b 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -137,11 +137,11 @@ OPTIONS FOR ALL COMMANDS
 	want to manipulate.  This option is mandatory
 	for all commands.
 
-OPTIONS FOR 'add' AND 'merge' (ALSO: 'pull' AND 'split --rejoin')
------------------------------------------------------------------
+OPTIONS FOR 'add' AND 'merge' (ALSO: 'pull', 'split --rejoin', AND 'push --rejoin')
+-----------------------------------------------------------------------------------
 These options for 'add' and 'merge' may also be given to 'pull' (which
-wraps 'merge') and 'split --rejoin' (which wraps either 'add' or
-'merge' as appropriate).
+wraps 'merge'), 'split --rejoin' (which wraps either 'add' or 'merge'
+as appropriate), and 'push --rejoin' (which wraps 'split --rejoin').
 
 --squash::
 	Instead of merging the entire history from the subtree project, produce
@@ -173,9 +173,10 @@ subproject.
 --message=<message>::
 	Specify <message> as the commit message for the merge commit.
 
-OPTIONS FOR 'split'
--------------------
-These options are only valid for 'split'.
+OPTIONS FOR 'split' (ALSO: 'push')
+----------------------------------
+These options for 'split' may also be given to 'push' (which wraps
+'split').
 
 --annotate=<annotation>::
 	When generating synthetic history, add <annotation> as a prefix to each
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 2561e25f43..5a6541437b 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -5,8 +5,8 @@
 #
 test_description='Basic porcelain support for subtrees
 
-This test verifies the basic operation of the add, pull, merge
-and split subcommands of git subtree.
+This test verifies the basic operation of the add, merge, split, pull,
+and push subcommands of git subtree.
 '
 
 TEST_DIRECTORY=$(pwd)/../../../t
@@ -610,6 +610,216 @@ test_expect_success 'push basic operation' '
 	)
 '
 
+test_expect_success 'push sub dir/ with --rejoin' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree merge --prefix="sub dir" FETCH_HEAD &&
+		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
+		git subtree push --prefix="sub dir" --annotate="*" --rejoin ./"sub proj" from-mainline &&
+		test "$(last_commit_subject)" = "Split '\''sub dir/'\'' into commit '\''$split_hash'\''" &&
+		test "$split_hash" = "$(git -C "sub proj" rev-parse --verify refs/heads/from-mainline)"
+	)
+'
+
+test_expect_success 'push sub dir/ with --rejoin from scratch' '
+	subtree_test_create_repo "$test_count" &&
+	test_create_commit "$test_count" main1 &&
+	(
+		cd "$test_count" &&
+		mkdir "sub dir" &&
+		echo file >"sub dir"/file &&
+		git add "sub dir/file" &&
+		git commit -m"sub dir file" &&
+		split_hash=$(git subtree split --prefix="sub dir" --rejoin) &&
+		git init --bare "sub proj.git" &&
+		git subtree push --prefix="sub dir" --rejoin ./"sub proj.git" from-mainline &&
+		test "$(last_commit_subject)" = "Split '\''sub dir/'\'' into commit '\''$split_hash'\''" &&
+		test "$split_hash" = "$(git -C "sub proj.git" rev-parse --verify refs/heads/from-mainline)"
+	)
+'
+
+test_expect_success 'push sub dir/ with --rejoin and --message' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree merge --prefix="sub dir" FETCH_HEAD &&
+		git subtree push --prefix="sub dir" --message="Split & rejoin" --annotate="*" --rejoin ./"sub proj" from-mainline &&
+		test "$(last_commit_subject)" = "Split & rejoin" &&
+		split_hash="$(git rev-parse --verify HEAD^2)" &&
+		test "$split_hash" = "$(git -C "sub proj" rev-parse --verify refs/heads/from-mainline)"
+	)
+'
+
+test_expect_success 'push "sub dir"/ with --rejoin and --squash' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" --squash FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git subtree pull --prefix="sub dir" --squash ./"sub proj" HEAD &&
+		MAIN=$(git rev-parse --verify HEAD) &&
+		SUB=$(git -C "sub proj" rev-parse --verify HEAD) &&
+
+		SPLIT=$(git subtree split --prefix="sub dir" --annotate="*") &&
+		git subtree push --prefix="sub dir" --annotate="*" --rejoin --squash ./"sub proj" from-mainline &&
+
+		test_must_fail git merge-base --is-ancestor $SUB HEAD &&
+		test_must_fail git merge-base --is-ancestor $SPLIT HEAD &&
+		git rev-list HEAD ^$MAIN >commit-list &&
+		test_line_count = 2 commit-list &&
+		test "$(git rev-parse --verify HEAD:)"           = "$(git rev-parse --verify $MAIN:)" &&
+		test "$(git rev-parse --verify HEAD:"sub dir")"  = "$(git rev-parse --verify $SPLIT:)" &&
+		test "$(git rev-parse --verify HEAD^1)"          = $MAIN &&
+		test "$(git rev-parse --verify HEAD^2)"         != $SPLIT &&
+		test "$(git rev-parse --verify HEAD^2:)"         = "$(git rev-parse --verify $SPLIT:)" &&
+		test "$(last_commit_subject)" = "Split '\''sub dir/'\'' into commit '\''$SPLIT'\''" &&
+		test "$SPLIT" = "$(git -C "sub proj" rev-parse --verify refs/heads/from-mainline)"
+	)
+'
+
+test_expect_success 'push "sub dir"/ with --branch' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree merge --prefix="sub dir" FETCH_HEAD &&
+		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
+		git subtree push --prefix="sub dir" --annotate="*" --branch subproj-br ./"sub proj" from-mainline &&
+		test "$(git rev-parse subproj-br)" = "$split_hash" &&
+		test "$split_hash" = "$(git -C "sub proj" rev-parse --verify refs/heads/from-mainline)"
+	)
+'
+
+test_expect_success 'check hash of push' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree merge --prefix="sub dir" FETCH_HEAD &&
+		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
+		git subtree push --prefix="sub dir" --annotate="*" --branch subproj-br ./"sub proj" from-mainline &&
+		test "$(git rev-parse subproj-br)" = "$split_hash" &&
+		# Check hash of split
+		new_hash=$(git rev-parse subproj-br^2) &&
+		(
+			cd ./"sub proj" &&
+			subdir_hash=$(git rev-parse HEAD) &&
+			test "$new_hash" = "$subdir_hash"
+		) &&
+		test "$split_hash" = "$(git -C "sub proj" rev-parse --verify refs/heads/from-mainline)"
+	)
+'
+
+test_expect_success 'push "sub dir"/ with --branch for an existing branch' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git branch subproj-br FETCH_HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree merge --prefix="sub dir" FETCH_HEAD &&
+		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
+		git subtree push --prefix="sub dir" --annotate="*" --branch subproj-br ./"sub proj" from-mainline &&
+		test "$(git rev-parse subproj-br)" = "$split_hash" &&
+		test "$split_hash" = "$(git -C "sub proj" rev-parse --verify refs/heads/from-mainline)"
+	)
+'
+
+test_expect_success 'push "sub dir"/ with --branch for an incompatible branch' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git branch init HEAD &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree merge --prefix="sub dir" FETCH_HEAD &&
+		test_must_fail git subtree push --prefix="sub dir" --branch init "./sub proj" from-mainline
+	)
+'
+
 #
 # Validity checking
 #
-- 
2.31.1

