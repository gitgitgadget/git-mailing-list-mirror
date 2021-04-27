Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E058C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6FD613DA
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbhD0VTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 17:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238970AbhD0VT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 17:19:29 -0400
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C100BC061342
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 14:18:43 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 14B7C8059D;
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
Subject: [PATCH v3 27/30] subtree: allow --squash to be used with --rejoin
Date:   Tue, 27 Apr 2021 15:17:45 -0600
Message-Id: <20210427211748.2607474-28-lukeshu@lukeshu.com>
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

Besides being a genuinely useful thing to do, this also just makes sense
and harmonizes which flags may be used when.  `git subtree split
--rejoin` amounts to "automatically go ahead and do a `git subtree
merge` after doing the main `git subtree split`", so it's weird and
arbitrary that you can't pass `--squash` to `git subtree split --rejoin`
like you can `git subtree merge`.  It's weird that `git subtree split
--rejoin` inherits `git subtree merge`'s `--message` but not `--squash`.

Reconcile the situation by just having `split --rejoin` actually just
call `merge` internally (or call `add` instead, as appropriate), so it
can get access to the full `merge` behavior, including `--squash`.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
v2:
 - In the added tests, use `test_must_fail` instead of `!`, as
   appropriate.
v3:
 - Style: Put the `then` of an `if/then` on its own line.
 - Fix a bug (and add a test) where the resulting commits confuse a
   subsequent `git subtree merge --squash`.

 contrib/subtree/git-subtree.sh     | 37 +++++++++++++++-----
 contrib/subtree/git-subtree.txt    | 27 ++++++--------
 contrib/subtree/t/t7900-subtree.sh | 56 ++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 24 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 3bffddf277..25d69d7973 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -33,15 +33,15 @@ h,help        show the help
 q             quiet
 d             show debug messages
 P,prefix=     the name of the subdir to split out
-m,message=    use the given message as the commit message for the merge commit
  options for 'split'
 annotate=     add a prefix to commit message of new commits
 b,branch=     create a new branch from the split subtree
 ignore-joins  ignore prior --rejoin commits
 onto=         try connecting new tree to an existing one
 rejoin        merge the new branch back into HEAD
- options for 'add' and 'merge' (also: 'pull')
+ options for 'add' and 'merge' (also: 'pull' and 'split --rejoin')
 squash        merge subtree changes as a single commit
+m,message=    use the given message as the commit message for the merge commit
 "
 
 arg_debug=
@@ -346,7 +346,8 @@ find_latest_squash () {
 				then
 					# a rejoin commit?
 					# Pretend its sub was a squash.
-					sq="$sub"
+					sq=$(git rev-parse --verify "$sq^2") ||
+						die
 				fi
 				debug "Squash found: $sq $sub"
 				echo "$sq" "$sub"
@@ -453,6 +454,13 @@ add_msg () {
 	else
 		commit_message="Add '$dir/' from commit '$latest_new'"
 	fi
+	if test -n "$arg_split_rejoin"
+	then
+		# If this is from a --rejoin, then rejoin_msg has
+		# already inserted the `git-subtree-xxx:` tags
+		echo "$commit_message"
+		return
+	fi
 	cat <<-EOF
 		$commit_message
 
@@ -775,7 +783,12 @@ cmd_add_commit () {
 	rev=$(git rev-parse --verify "$1^{commit}") || exit $?
 
 	debug "Adding $dir as '$rev'..."
-	git read-tree --prefix="$dir" $rev || exit $?
+	if test -z "$arg_split_rejoin"
+	then
+		# Only bother doing this if this is a genuine 'add',
+		# not a synthetic 'add' from '--rejoin'.
+		git read-tree --prefix="$dir" $rev || exit $?
+	fi
 	git checkout -- "$dir" || exit $?
 	tree=$(git write-tree) || exit $?
 
@@ -815,6 +828,11 @@ cmd_split () {
 		die "You must provide exactly one revision.  Got: '$*'"
 	fi
 
+	if test -n "$arg_split_rejoin"
+	then
+		ensure_clean
+	fi
+
 	debug "Splitting $dir..."
 	cache_setup || exit $?
 
@@ -857,10 +875,13 @@ cmd_split () {
 	then
 		debug "Merging split branch into HEAD..."
 		latest_old=$(cache_get latest_old) || exit $?
-		git merge -s ours \
-			--allow-unrelated-histories \
-			-m "$(rejoin_msg "$dir" "$latest_old" "$latest_new")" \
-			"$latest_new" >&2 || exit $?
+		arg_addmerge_message="$(rejoin_msg "$dir" "$latest_old" "$latest_new")" || exit $?
+		if test -z "$(find_latest_squash "$dir")"
+		then
+			cmd_add "$latest_new" >&2 || exit $?
+		else
+			cmd_merge "$latest_new" >&2 || exit $?
+		fi
 	fi
 	if test -n "$arg_split_branch"
 	then
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 78baac1e6b..d7e6e7867c 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -109,9 +109,6 @@ settings passed to 'split' (such as '--annotate') are the same.
 Because of this, if you add new commits and then re-split, the new
 commits will be attached as commits on top of the history you
 generated last time, so 'git merge' and friends will work as expected.
-+
-Note that if you use '--squash' when you merge, you should usually not
-just '--rejoin' when you split.
 
 pull <repository> <remote-ref>::
 	Exactly like 'merge', but parallels 'git pull' in that
@@ -124,8 +121,8 @@ push <repository> <remote-ref>::
 	<remote-ref>.  This can be used to push your subtree to
 	different branches of the remote repository.
 
-OPTIONS
--------
+OPTIONS FOR ALL COMMANDS
+------------------------
 -q::
 --quiet::
 	Suppress unnecessary output messages on stderr.
@@ -140,15 +137,11 @@ OPTIONS
 	want to manipulate.  This option is mandatory
 	for all commands.
 
--m <message>::
---message=<message>::
-	This option is only valid for 'add', 'merge', 'pull', and 'split --rejoin'.
-	Specify <message> as the commit message for the merge commit.
-
-OPTIONS FOR 'add' AND 'merge' (ALSO: 'pull')
---------------------------------------------
+OPTIONS FOR 'add' AND 'merge' (ALSO: 'pull' AND 'split --rejoin')
+-----------------------------------------------------------------
 These options for 'add' and 'merge' may also be given to 'pull' (which
-wraps 'merge').
+wraps 'merge') and 'split --rejoin' (which wraps either 'add' or
+'merge' as appropriate).
 
 --squash::
 	Instead of merging the entire history from the subtree project, produce
@@ -176,6 +169,9 @@ Whether or not you use '--squash', changes made in your local repository
 remain intact and can be later split and send upstream to the
 subproject.
 
+-m <message>::
+--message=<message>::
+	Specify <message> as the commit message for the merge commit.
 
 OPTIONS FOR 'split'
 -------------------
@@ -229,9 +225,8 @@ Unfortunately, using this option results in 'git log' showing an extra
 copy of every new commit that was created (the original, and the
 synthetic one).
 +
-If you do all your merges with '--squash', don't use '--rejoin' when you
-split, because you don't want the subproject's history to be part of
-your project anyway.
+If you do all your merges with '--squash', make sure you also use
+'--squash' when you 'split --rejoin'.
 
 
 EXAMPLE 1. 'add' command
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index ce6861c22d..2561e25f43 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -324,6 +324,62 @@ test_expect_success 'split sub dir/ with --rejoin and --message' '
 	)
 '
 
+test_expect_success 'split "sub dir"/ with --rejoin and --squash' '
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
+		SPLIT=$(git subtree split --prefix="sub dir" --annotate="*" --rejoin --squash) &&
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
+		test "$(last_commit_subject)" = "Split '\''sub dir/'\'' into commit '\''$SPLIT'\''"
+	)
+'
+
+test_expect_success 'split then pull "sub dir"/ with --rejoin and --squash' '
+	# 1. "add"
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	git -C "$test_count" subtree --prefix="sub dir" add --squash ./"sub proj" HEAD &&
+
+	# 2. commit from parent
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+
+	# 3. "split --rejoin --squash"
+	git -C "$test_count" subtree --prefix="sub dir" split --rejoin --squash &&
+
+	# 4. "pull --squash"
+	test_create_commit "$test_count/sub proj" sub2 &&
+	git -C "$test_count" subtree -d --prefix="sub dir" pull --squash ./"sub proj" HEAD &&
+
+	test_must_fail git merge-base HEAD FETCH_HEAD
+'
+
 test_expect_success 'split "sub dir"/ with --branch' '
 	subtree_test_create_repo "$test_count" &&
 	subtree_test_create_repo "$test_count/sub proj" &&
-- 
2.31.1

