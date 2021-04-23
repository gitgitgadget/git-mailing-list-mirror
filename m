Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E51C43462
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67DD76113B
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244018AbhDWToB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:44:01 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:35450 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243934AbhDWTnp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 15:43:45 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 9948A80596;
        Fri, 23 Apr 2021 15:43:07 -0400 (EDT)
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
Subject: [PATCH 30/30] subtree: be stricter about validating flags
Date:   Fri, 23 Apr 2021 13:42:30 -0600
Message-Id: <20210423194230.1388945-31-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423194230.1388945-1-lukeshu@lukeshu.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

Don't silently ignore a flag that's invalid for a given subcommand.  The
user expected it to do something; we should tell the user that they are
mistaken, instead of surprising the user.

It could be argued that this change might break existing users.  I'd
argue that those existing users are already broken, and they just don't
know it.  Let them know that they're broken.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 contrib/subtree/git-subtree.sh     |  89 ++++++++++++++++-------
 contrib/subtree/t/t7900-subtree.sh | 111 +++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+), 25 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7361d8de3f..5073d82b2e 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -30,17 +30,6 @@ m,message=    use the given message as the commit message for the merge commit
 
 PATH=$(git --exec-path):$PATH
 
-arg_debug=
-arg_command=
-arg_prefix=
-arg_split_branch=
-arg_split_onto=
-arg_split_rejoin=
-arg_split_ignore_joins=
-arg_split_annotate=
-arg_addmerge_squash=
-arg_addmerge_message=
-
 indent=0
 
 # Usage: debug [MSG...]
@@ -77,10 +66,61 @@ main () {
 	then
 		set -- -h
 	fi
-	eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
+	set_args="$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
+	eval "$set_args"
 	. git-sh-setup
 	require_work_tree
 
+	# First figure out the command and whether we use --rejoin, so
+	# that we can provide more helpful validation when we do the
+	# "real" flag parsing.
+	arg_split_rejoin=
+	allow_split=
+	allow_addmerge=
+	while test $# -gt 0
+	do
+		opt="$1"
+		shift
+		case "$opt" in
+			--annotate|-b|-P|-m|--onto)
+				shift
+				;;
+			--rejoin)
+				arg_split_rejoin=1
+				;;
+			--no-rejoin)
+				arg_split_rejoin=
+				;;
+			--)
+				break
+				;;
+		esac
+	done
+	arg_command=$1
+	case "$arg_command" in
+	add|merge|pull)
+		allow_addmerge=1
+		;;
+	split|push)
+		allow_split=1
+		allow_addmerge=$arg_split_rejoin
+		;;
+	*)
+		die "Unknown command '$arg_command'"
+		;;
+	esac
+	# Reset the arguments array for "real" flag parsing.
+	eval "$set_args"
+
+	# Begin "real" flag parsing.
+	arg_debug=
+	arg_prefix=
+	arg_split_branch=
+	arg_split_onto=
+	arg_split_ignore_joins=
+	arg_split_annotate=
+	arg_addmerge_squash=
+	arg_addmerge_message=
 	while test $# -gt 0
 	do
 		opt="$1"
@@ -94,13 +134,16 @@ main () {
 			arg_debug=1
 			;;
 		--annotate)
+			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
 			arg_split_annotate="$1"
 			shift
 			;;
 		--no-annotate)
+			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
 			arg_split_annotate=
 			;;
 		-b)
+			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
 			arg_split_branch="$1"
 			shift
 			;;
@@ -109,6 +152,7 @@ main () {
 			shift
 			;;
 		-m)
+			test -n "$allow_addmerge" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
 			arg_addmerge_message="$1"
 			shift
 			;;
@@ -116,28 +160,34 @@ main () {
 			arg_prefix=
 			;;
 		--onto)
+			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
 			arg_split_onto="$1"
 			shift
 			;;
 		--no-onto)
+			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
 			arg_split_onto=
 			;;
 		--rejoin)
-			arg_split_rejoin=1
+			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
 			;;
 		--no-rejoin)
-			arg_split_rejoin=
+			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
 			;;
 		--ignore-joins)
+			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
 			arg_split_ignore_joins=1
 			;;
 		--no-ignore-joins)
+			test -n "$allow_split" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
 			arg_split_ignore_joins=
 			;;
 		--squash)
+			test -n "$allow_addmerge" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
 			arg_addmerge_squash=1
 			;;
 		--no-squash)
+			test -n "$allow_addmerge" || die "The '$opt' flag does not make sense with 'git subtree $arg_command'."
 			arg_addmerge_squash=
 			;;
 		--)
@@ -148,19 +198,8 @@ main () {
 			;;
 		esac
 	done
-
-	arg_command="$1"
 	shift
 
-	case "$arg_command" in
-	add|merge|pull|split|push)
-		:
-		;;
-	*)
-		die "Unknown command '$arg_command'"
-		;;
-	esac
-
 	if test -z "$arg_prefix"
 	then
 		die "You must provide the --prefix option."
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index fb85eed5fc..f83c491a61 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -33,6 +33,12 @@ test_create_commit () (
 	git commit -m "$commit" || error "Could not commit"
 )
 
+test_wrong_flag() {
+	test_must_fail "$@" >out 2>err &&
+	test_must_be_empty out &&
+	grep "flag does not make sense with" err
+}
+
 last_commit_subject () {
 	git log --pretty=format:%s -1
 }
@@ -72,6 +78,22 @@ test_expect_success 'no pull from non-existent subtree' '
 	)
 '
 
+test_expect_success 'add rejects flags for split' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		test_wrong_flag git subtree add --prefix="sub dir" --annotate=foo FETCH_HEAD &&
+		test_wrong_flag git subtree add --prefix="sub dir" --branch=foo FETCH_HEAD &&
+		test_wrong_flag git subtree add --prefix="sub dir" --ignore-joins FETCH_HEAD &&
+		test_wrong_flag git subtree add --prefix="sub dir" --onto=foo FETCH_HEAD &&
+		test_wrong_flag git subtree add --prefix="sub dir" --rejoin FETCH_HEAD
+	)
+'
+
 test_expect_success 'add subproj as subtree into sub dir/ with --prefix' '
 	subtree_test_create_repo "$test_count" &&
 	subtree_test_create_repo "$test_count/sub proj" &&
@@ -128,6 +150,28 @@ test_expect_success 'add subproj as subtree into sub dir/ with --squash and --pr
 # Tests for 'git subtree merge'
 #
 
+test_expect_success 'merge rejects flags for split' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD
+	) &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		test_wrong_flag git subtree merge --prefix="sub dir" --annotate=foo FETCH_HEAD &&
+		test_wrong_flag git subtree merge --prefix="sub dir" --branch=foo FETCH_HEAD &&
+		test_wrong_flag git subtree merge --prefix="sub dir" --ignore-joins FETCH_HEAD &&
+		test_wrong_flag git subtree merge --prefix="sub dir" --onto=foo FETCH_HEAD &&
+		test_wrong_flag git subtree merge --prefix="sub dir" --rejoin FETCH_HEAD
+	)
+'
+
 test_expect_success 'merge new subproj history into sub dir/ with --prefix' '
 	subtree_test_create_repo "$test_count" &&
 	subtree_test_create_repo "$test_count/sub proj" &&
@@ -262,6 +306,30 @@ test_expect_success 'split requires path given by option --prefix must exist' '
 	)
 '
 
+test_expect_success 'split rejects flags for add' '
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
+		test_wrong_flag git subtree split --prefix="sub dir" --squash &&
+		test_wrong_flag git subtree split --prefix="sub dir" --message=foo
+	)
+'
+
 test_expect_success 'split sub dir/ with --rejoin' '
 	subtree_test_create_repo "$test_count" &&
 	subtree_test_create_repo "$test_count/sub proj" &&
@@ -521,6 +589,26 @@ test_expect_success 'pull basic operation' '
 	)
 '
 
+test_expect_success 'pull rejects flags for split' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD
+	) &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	(
+		test_must_fail git subtree pull --prefix="sub dir" --annotate=foo ./"sub proj" HEAD &&
+		test_must_fail git subtree pull --prefix="sub dir" --branch=foo ./"sub proj" HEAD &&
+		test_must_fail git subtree pull --prefix="sub dir" --ignore-joins ./"sub proj" HEAD &&
+		test_must_fail git subtree pull --prefix="sub dir" --onto=foo ./"sub proj" HEAD &&
+		test_must_fail git subtree pull --prefix="sub dir" --rejoin ./"sub proj" HEAD
+	)
+'
+
 #
 # Tests for 'git subtree push'
 #
@@ -563,6 +651,29 @@ test_expect_success 'push requires path given by option --prefix must exist' '
 	)
 '
 
+test_expect_success 'push rejects flags for add' '
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
+		test_wrong_flag git subtree split --prefix="sub dir" --squash ./"sub proj" from-mainline &&
+		test_wrong_flag git subtree split --prefix="sub dir" --message=foo ./"sub proj" from-mainline
+	)
+'
+
 test_expect_success 'push basic operation' '
 	subtree_test_create_repo "$test_count" &&
 	subtree_test_create_repo "$test_count/sub proj" &&
-- 
2.31.1

