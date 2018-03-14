Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 773301FAE3
	for <e@80x24.org>; Wed, 14 Mar 2018 11:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeCNLLr (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 07:11:47 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:58051 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeCNLLg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 07:11:36 -0400
Received: from lindisfarne.localdomain ([89.242.187.47])
        by smtp.talktalk.net with SMTP
        id w4JdeGnv5HCoww4JieseBU; Wed, 14 Mar 2018 11:11:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521025895;
        bh=k15dXNTFHvujzv+sphoBiX5iVE23wf1bQFmvvla0KwI=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=datB0rPsMujan57NoIOHPuYeT6HvW9yDIWs7uf7YwRojDd7sRZJhSP3ld5xSBOP4n
         dHnKIlIGdFIh0SdPYqECMbBtGJDvhzWAGpY/KfMLvGghlj5DK3j1p+/7vf2xVLSHmz
         VFim8RdPAL+9oKsFrEiFk/L6KbVxCnCWLNZ2Rrq4=
X-Originating-IP: [89.242.187.47]
X-Spam: 0
X-OAuthority: v=2.3 cv=SfXZiMZu c=1 sm=1 tr=0 a=xTMdeSjPtcrjTRwaJcecEQ==:117
 a=xTMdeSjPtcrjTRwaJcecEQ==:17 a=evINK-nbAAAA:8 a=qvPaiQwnwfsVToo98CAA:9
 a=Y0-FZYADvyhzYL6V:21 a=cV3Wu-KFiwkUtIuk:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/2] rebase: support --signoff with implicit rebase
Date:   Wed, 14 Mar 2018 11:11:26 +0000
Message-Id: <20180314111127.14217-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfPw2lDShVB0SbjC1iY/Q/3A6wXZ1C21OR1j89avALRs+n5YIREWdO1VM1SFupHoRROvf9gd4c9+z4tG/ng/Kdw/x+jExns/N2yDNK09YaMbW9MhrvA9U
 p3KQ6LYdbLF/ufwfnICYXw437TpUscNOD51mNk5WtSI/MKKkYRvk2rmO/Z7w2q6lCAq5P/UeP/V0hIrjQnDgD5D92z33bk6hCzVI5jAbwljnlX8I1htStj22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This allows one to run 'git rebase --exec "make check" --signoff'
which is useful when preparing a patch series for publication and is
more convenient than doing the signoff with another --exec command.
This change also allows --root without --onto to work with --signoff
as well (--root with --onto was already supported). Note that the
failing test is due to a bug in 'rebase --root' when the root commit
is empty which will be fixed in the next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-rebase--interactive.sh |  6 +++---
 git-rebase.sh              | 26 +++++++++++++++++++++++++-
 sequencer.c                |  6 ++++++
 t/t3428-rebase-signoff.sh  | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 81c5b42875..4ea54fc1c4 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -283,7 +283,7 @@ pick_one () {
 		pick_one_preserving_merges "$@" && return
 	output eval git cherry-pick $allow_rerere_autoupdate $allow_empty_message \
 			${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
-			"$strategy_args" $empty_args $ff "$@"
+			$signoff "$strategy_args" $empty_args $ff "$@"
 
 	# If cherry-pick dies it leaves the to-be-picked commit unrecorded. Reschedule
 	# previous task so this commit is not lost.
@@ -525,10 +525,10 @@ do_pick () {
 		# resolve before manually running git commit --amend then git
 		# rebase --continue.
 		git commit --allow-empty --allow-empty-message --amend \
-			   --no-post-rewrite -n -q -C $sha1 &&
+			   --no-post-rewrite -n -q -C $sha1 $signoff &&
 			pick_one -n $sha1 &&
 			git commit --allow-empty --allow-empty-message \
-				   --amend --no-post-rewrite -n -q -C $sha1 \
+				   --amend --no-post-rewrite -n -q -C $sha1 $signoff \
 				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
 				   die_with_patch $sha1 "$(eval_gettext "Could not apply \$sha1... \$rest")"
 	else
diff --git a/git-rebase.sh b/git-rebase.sh
index b353c33d41..40301756be 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -91,6 +91,7 @@ preserve_merges=
 autosquash=
 keep_empty=
 allow_empty_message=
+signoff=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 case "$(git config --bool commit.gpgsign)" in
 true)	gpg_sign_opt=-S ;;
@@ -120,6 +121,10 @@ read_basic_state () {
 		allow_rerere_autoupdate="$(cat "$state_dir"/allow_rerere_autoupdate)"
 	test -f "$state_dir"/gpg_sign_opt &&
 		gpg_sign_opt="$(cat "$state_dir"/gpg_sign_opt)"
+	test -f "$state_dir"/signoff && {
+		signoff="$(cat "$state_dir"/signoff)"
+		force_rebase=t
+	}
 }
 
 write_basic_state () {
@@ -134,6 +139,7 @@ write_basic_state () {
 	test -n "$allow_rerere_autoupdate" && echo "$allow_rerere_autoupdate" > \
 		"$state_dir"/allow_rerere_autoupdate
 	test -n "$gpg_sign_opt" && echo "$gpg_sign_opt" > "$state_dir"/gpg_sign_opt
+	test -n "$signoff" && echo "$signoff" >"$state_dir"/signoff
 }
 
 output () {
@@ -329,7 +335,13 @@ do
 	--ignore-whitespace)
 		git_am_opt="$git_am_opt $1"
 		;;
-	--committer-date-is-author-date|--ignore-date|--signoff|--no-signoff)
+	--signoff)
+		signoff=--signoff
+		;;
+	--no-signoff)
+		signoff=
+		;;
+	--committer-date-is-author-date|--ignore-date)
 		git_am_opt="$git_am_opt $1"
 		force_rebase=t
 		;;
@@ -459,6 +471,18 @@ then
 	git_format_patch_opt="$git_format_patch_opt --progress"
 fi
 
+if test -n "$signoff"
+then
+	test "$interactive_rebase" = explicit &&
+		die "$(gettext "error: interactive rebase does not support --signoff")"
+	test "$type" = merge &&
+		die "$(gettext "error: merge rebase does not support --signoff")"
+	test -n "$preserve_merges" &&
+		die "$(gettext "error: cannot combine '--signoff' with '--preserve-merges'")"
+	git_am_opt="$git_am_opt $signoff"
+	force_rebase=t
+fi
+
 if test -z "$rebase_root"
 then
 	case "$#" in
diff --git a/sequencer.c b/sequencer.c
index e9baaf59bd..311569e37d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -127,6 +127,7 @@ static GIT_PATH_FUNC(rebase_path_rewritten_pending,
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
 static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
 static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
+static GIT_PATH_FUNC(rebase_path_signoff, "rebase-merge/signoff")
 static GIT_PATH_FUNC(rebase_path_head_name, "rebase-merge/head-name")
 static GIT_PATH_FUNC(rebase_path_onto, "rebase-merge/onto")
 static GIT_PATH_FUNC(rebase_path_autostash, "rebase-merge/autostash")
@@ -2035,6 +2036,11 @@ static int read_populate_opts(struct replay_opts *opts)
 		if (file_exists(rebase_path_verbose()))
 			opts->verbose = 1;
 
+		if (file_exists(rebase_path_signoff())) {
+			opts->allow_ff = 0;
+			opts->signoff = 1;
+		}
+
 		read_strategy_opts(opts, &buf);
 		strbuf_release(&buf);
 
diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
index 2afb564701..2ff7f534e3 100755
--- a/t/t3428-rebase-signoff.sh
+++ b/t/t3428-rebase-signoff.sh
@@ -12,6 +12,13 @@ cat >file <<EOF
 a
 EOF
 
+# Expected commit message for initial commit after rebase --signoff
+cat >expected-initial-signed <<EOF
+Initial empty commit
+
+Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
+EOF
+
 # Expected commit message after rebase --signoff
 cat >expected-signed <<EOF
 first
@@ -43,4 +50,29 @@ test_expect_success 'rebase --no-signoff does not add a sign-off line' '
 	test_cmp expected-unsigned actual
 '
 
+test_expect_success 'rebase --exec --signoff adds a sign-off line' '
+	test_when_finished "rm exec" &&
+	git commit --amend -m "first" &&
+	git rebase --exec "touch exec" --signoff HEAD^ &&
+	test_path_is_file exec &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	test_cmp expected-signed actual
+'
+
+test_expect_failure 'rebase --root --signoff adds a sign-off line' '
+	git commit --amend -m "first" &&
+	git rebase --root --keep-empty --signoff &&
+	git cat-file commit HEAD^ | sed -e "1,/^\$/d" >actual &&
+	test_cmp expected-initial-signed actual &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	test_cmp expected-signed actual
+'
+
+test_expect_success 'rebase -i --signoff fails' '
+	test_must_fail git rebase -i --signoff HEAD^
+'
+
+test_expect_success 'rebase -m --signoff fails' '
+	test_must_fail git rebase -m --signoff HEAD^
+'
 test_done
-- 
2.16.2

