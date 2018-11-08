Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A96491F453
	for <e@80x24.org>; Thu,  8 Nov 2018 06:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbeKHPgC (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 10:36:02 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:58846 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725724AbeKHPgC (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Nov 2018 10:36:02 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA85rB2G029052;
        Wed, 7 Nov 2018 22:02:07 -0800
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2nm9610gvx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 07 Nov 2018 22:02:06 -0800
Received: from dc-prod-exch-01.YOJOE.local (10.193.18.14) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Thu, 8 Nov 2018 01:02:05 -0500
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Thu, 8 Nov 2018 01:02:03 -0500
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 756AA2101E93;
        Wed,  7 Nov 2018 22:02:03 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, <Johannes.Schindelin@gmx.de>,
        <predatoramigo@gmail.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 2/2] rebase: Implement --merge via git-rebase--interactive
Date:   Wed, 7 Nov 2018 22:01:58 -0800
Message-ID: <20181108060158.27145-3-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.858.g526e8fe740.dirty
In-Reply-To: <20181108060158.27145-1-newren@gmail.com>
References: <20181108060158.27145-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=48 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080050
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Interactive rebases are implemented in terms of cherry-pick rather than
the merge-recursive builtin, but cherry-pick also calls into the recursive
merge machinery by default and can accept special merge strategies and/or
special strategy options.  As such, there really is not any need for
having both git-rebase--merge and git-rebase--interactive anymore.

Delete git-rebase--merge.sh and have the --merge option be implemented
by the now built-in interactive machinery.

Note that this change fixes a few known test failures (see t3421).

testcase modification notes:
  t3406: --interactive and --merge had slightly different progress output
         while running; adjust a test to match
  t3420: these test precise output while running, but rebase--am,
         rebase--merge, and rebase--interactive all were built on very
         different commands (am, merge-recursive, cherry-pick), so the
         tests expected different output for each type.  Now we expect
         --merge and --interactive to have the same output.
  t3421: --interactive fixes some bugs in --merge!  Wahoo!
  t3425: topology linearization was inconsistent across flavors of rebase,
         as already noted in a TODO comment in the testcase.  This was not
         considered a bug before, so getting a different linearization due
         to switching out backends should not be considered a bug now.
  t5407: different rebase types varied slightly in how many times checkout
         or commit or equivalents were called based on a quick comparison
         of this tests and previous ones which covered different rebase
         flavors.  I think this is just attributable to this difference.
  t9903: --merge uses the interactive backend so the prompt expected is
         now REBASE-i.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 .gitignore                        |   1 -
 Documentation/git-rebase.txt      |  17 +---
 Makefile                          |   1 -
 builtin/rebase.c                  |  10 +-
 git-legacy-rebase.sh              |  55 +++++-----
 git-rebase--merge.sh              | 164 ------------------------------
 t/t3406-rebase-message.sh         |   7 +-
 t/t3420-rebase-autostash.sh       |  78 ++------------
 t/t3421-rebase-topology-linear.sh |  10 +-
 t/t3425-rebase-topology-merges.sh |   6 +-
 t/t5407-post-rewrite-hook.sh      |   1 +
 t/t9903-bash-prompt.sh            |   2 +-
 12 files changed, 50 insertions(+), 302 deletions(-)
 delete mode 100644 git-rebase--merge.sh

diff --git a/.gitignore b/.gitignore
index 0d77ea5894..910b1d2d2f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -124,7 +124,6 @@
 /git-rebase--am
 /git-rebase--common
 /git-rebase--interactive
-/git-rebase--merge
 /git-rebase--preserve-merges
 /git-receive-pack
 /git-reflog
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 3407d835bd..35084f5681 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -504,15 +504,7 @@ See also INCOMPATIBLE OPTIONS below.
 INCOMPATIBLE OPTIONS
 --------------------
 
-git-rebase has many flags that are incompatible with each other,
-predominantly due to the fact that it has three different underlying
-implementations:
-
- * one based on linkgit:git-am[1] (the default)
- * one based on git-merge-recursive (merge backend)
- * one based on linkgit:git-cherry-pick[1] (interactive backend)
-
-Flags only understood by the am backend:
+The following options:
 
  * --committer-date-is-author-date
  * --ignore-date
@@ -520,15 +512,12 @@ Flags only understood by the am backend:
  * --ignore-whitespace
  * -C
 
-Flags understood by both merge and interactive backends:
+are incompatible with the following options:
 
  * --merge
  * --strategy
  * --strategy-option
  * --allow-empty-message
-
-Flags only understood by the interactive backend:
-
  * --[no-]autosquash
  * --rebase-merges
  * --preserve-merges
@@ -539,7 +528,7 @@ Flags only understood by the interactive backend:
  * --edit-todo
  * --root when used in combination with --onto
 
-Other incompatible flag pairs:
+In addition, the following pairs of options are incompatible:
 
  * --preserve-merges and --interactive
  * --preserve-merges and --signoff
diff --git a/Makefile b/Makefile
index bbfbb4292d..18e79fdea8 100644
--- a/Makefile
+++ b/Makefile
@@ -628,7 +628,6 @@ SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-rebase--am
 SCRIPT_LIB += git-rebase--common
 SCRIPT_LIB += git-rebase--preserve-merges
-SCRIPT_LIB += git-rebase--merge
 SCRIPT_LIB += git-sh-setup
 SCRIPT_LIB += git-sh-i18n
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index be004406a6..d55bbb9eb9 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -118,7 +118,7 @@ static void imply_interactive(struct rebase_options *opts, const char *option)
 	case REBASE_PRESERVE_MERGES:
 		break;
 	case REBASE_MERGE:
-		/* we silently *upgrade* --merge to --interactive if needed */
+		/* we now implement --merge via --interactive */
 	default:
 		opts->type = REBASE_INTERACTIVE; /* implied */
 		break;
@@ -475,10 +475,6 @@ static int run_specific_rebase(struct rebase_options *opts)
 		backend = "git-rebase--am";
 		backend_func = "git_rebase__am";
 		break;
-	case REBASE_MERGE:
-		backend = "git-rebase--merge";
-		backend_func = "git_rebase__merge";
-		break;
 	case REBASE_PRESERVE_MERGES:
 		backend = "git-rebase--preserve-merges";
 		backend_func = "git_rebase__preserve_merges";
@@ -1156,6 +1152,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (options.type == REBASE_MERGE) {
+		imply_interactive(&options, "--merge");
+	}
+
 	if (options.root && !options.onto_name)
 		imply_interactive(&options, "--root without --onto");
 
diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
index da27bfca5a..4abcceed06 100755
--- a/git-legacy-rebase.sh
+++ b/git-legacy-rebase.sh
@@ -218,6 +218,7 @@ then
 	state_dir="$apply_dir"
 elif test -d "$merge_dir"
 then
+	type=interactive
 	if test -d "$merge_dir"/rewritten
 	then
 		type=preserve-merges
@@ -225,10 +226,7 @@ then
 		preserve_merges=t
 	elif test -f "$merge_dir"/interactive
 	then
-		type=interactive
 		interactive_rebase=explicit
-	else
-		type=merge
 	fi
 	state_dir="$merge_dir"
 fi
@@ -469,6 +467,7 @@ then
 	test -z "$interactive_rebase" && interactive_rebase=implied
 fi
 
+actually_interactive=
 if test -n "$interactive_rebase"
 then
 	if test -z "$preserve_merges"
@@ -477,11 +476,12 @@ then
 	else
 		type=preserve-merges
 	fi
-
+	actually_interactive=t
 	state_dir="$merge_dir"
 elif test -n "$do_merge"
 then
-	type=merge
+	interactive_rebase=implied
+	type=interactive
 	state_dir="$merge_dir"
 else
 	type=am
@@ -493,21 +493,13 @@ then
 	git_format_patch_opt="$git_format_patch_opt --progress"
 fi
 
-if test -n "$git_am_opt"; then
-	incompatible_opts=$(echo " $git_am_opt " | \
-			    sed -e 's/ -q / /g' -e 's/^ \(.*\) $/\1/')
-	if test -n "$interactive_rebase"
+incompatible_opts=$(echo " $git_am_opt " | \
+		    sed -e 's/ -q / /g' -e 's/^ \(.*\) $/\1/')
+if test -n "$incompatible_opts"
+then
+	if test -n "$actually_interactive" || test "$do_merge"
 	then
-		if test -n "$incompatible_opts"
-		then
-			die "$(gettext "error: cannot combine interactive options (--interactive, --exec, --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with am options ($incompatible_opts)")"
-		fi
-	fi
-	if test -n "$do_merge"; then
-		if test -n "$incompatible_opts"
-		then
-			die "$(gettext "error: cannot combine merge options (--merge, --strategy, --strategy-option) with am options ($incompatible_opts)")"
-		fi
+		die "$(gettext "error: cannot combine am options ($incompatible_opts) with either interactive or merge options")"
 	fi
 fi
 
@@ -672,7 +664,7 @@ require_clean_work_tree "rebase" "$(gettext "Please commit or stash them.")"
 # but this should be done only when upstream and onto are the same
 # and if this is not an interactive rebase.
 mb=$(git merge-base "$onto" "$orig_head")
-if test -z "$interactive_rebase" && test "$upstream" = "$onto" &&
+if test -z "$actually_interactive" && test "$upstream" = "$onto" &&
 	test "$mb" = "$onto" && test -z "$restrict_revision" &&
 	# linear history?
 	! (git rev-list --parents "$onto".."$orig_head" | sane_grep " .* ") > /dev/null
@@ -716,6 +708,19 @@ then
 	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
 fi
 
+if test -z "$actually_interactive" && test "$mb" = "$orig_head"
+then
+	# If the $onto is a proper descendant of the tip of the branch, then
+	# we just fast-forwarded.
+	say "$(eval_gettext "Fast-forwarded \$branch_name to \$onto_name.")"
+	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name" \
+		git checkout -q "$onto^0" || die "could not detach HEAD"
+	git update-ref ORIG_HEAD $orig_head
+	move_to_original_branch
+	finish_rebase
+	exit 0
+fi
+
 test -n "$interactive_rebase" && run_specific_rebase
 
 # Detach HEAD and reset the tree
@@ -725,16 +730,6 @@ GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name" \
 	git checkout -q "$onto^0" || die "could not detach HEAD"
 git update-ref ORIG_HEAD $orig_head
 
-# If the $onto is a proper descendant of the tip of the branch, then
-# we just fast-forwarded.
-if test "$mb" = "$orig_head"
-then
-	say "$(eval_gettext "Fast-forwarded \$branch_name to \$onto_name.")"
-	move_to_original_branch
-	finish_rebase
-	exit 0
-fi
-
 if test -n "$rebase_root"
 then
 	revisions="$onto..$orig_head"
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
deleted file mode 100644
index aa2f2f0872..0000000000
--- a/git-rebase--merge.sh
+++ /dev/null
@@ -1,164 +0,0 @@
-# This shell script fragment is sourced by git-rebase to implement
-# its merge-based non-interactive mode that copes well with renamed
-# files.
-#
-# Copyright (c) 2010 Junio C Hamano.
-#
-
-prec=4
-
-read_state () {
-	onto_name=$(cat "$state_dir"/onto_name) &&
-	end=$(cat "$state_dir"/end) &&
-	msgnum=$(cat "$state_dir"/msgnum)
-}
-
-continue_merge () {
-	test -d "$state_dir" || die "$state_dir directory does not exist"
-
-	unmerged=$(git ls-files -u)
-	if test -n "$unmerged"
-	then
-		echo "You still have unmerged paths in your index"
-		echo "did you forget to use git add?"
-		die "$resolvemsg"
-	fi
-
-	cmt=$(cat "$state_dir/current")
-	if ! git diff-index --quiet --ignore-submodules HEAD --
-	then
-		if ! git commit ${gpg_sign_opt:+"$gpg_sign_opt"} $signoff $allow_empty_message \
-			--no-verify -C "$cmt"
-		then
-			echo "Commit failed, please do not call \"git commit\""
-			echo "directly, but instead do one of the following: "
-			die "$resolvemsg"
-		fi
-		if test -z "$GIT_QUIET"
-		then
-			printf "Committed: %0${prec}d " $msgnum
-		fi
-		echo "$cmt $(git rev-parse HEAD^0)" >> "$state_dir/rewritten"
-	else
-		if test -z "$GIT_QUIET"
-		then
-			printf "Already applied: %0${prec}d " $msgnum
-		fi
-	fi
-	test -z "$GIT_QUIET" &&
-	GIT_PAGER='' git log --format=%s -1 "$cmt"
-
-	# onto the next patch:
-	msgnum=$(($msgnum + 1))
-	echo "$msgnum" >"$state_dir/msgnum"
-}
-
-call_merge () {
-	msgnum="$1"
-	echo "$msgnum" >"$state_dir/msgnum"
-	cmt="$(cat "$state_dir/cmt.$msgnum")"
-	echo "$cmt" > "$state_dir/current"
-	git update-ref REBASE_HEAD "$cmt"
-	hd=$(git rev-parse --verify HEAD)
-	cmt_name=$(git symbolic-ref HEAD 2> /dev/null || echo HEAD)
-	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
-	eval GITHEAD_$hd='$onto_name'
-	export GITHEAD_$cmt GITHEAD_$hd
-	if test -n "$GIT_QUIET"
-	then
-		GIT_MERGE_VERBOSITY=1 && export GIT_MERGE_VERBOSITY
-	fi
-	test -z "$strategy" && strategy=recursive
-	# If cmt doesn't have a parent, don't include it as a base
-	base=$(git rev-parse --verify --quiet $cmt^)
-	eval 'git merge-$strategy' $strategy_opts $base ' -- "$hd" "$cmt"'
-	rv=$?
-	case "$rv" in
-	0)
-		unset GITHEAD_$cmt GITHEAD_$hd
-		return
-		;;
-	1)
-		git rerere $allow_rerere_autoupdate
-		die "$resolvemsg"
-		;;
-	2)
-		echo "Strategy: $strategy failed, try another" 1>&2
-		die "$resolvemsg"
-		;;
-	*)
-		die "Unknown exit code ($rv) from command:" \
-			"git merge-$strategy $cmt^ -- HEAD $cmt"
-		;;
-	esac
-}
-
-finish_rb_merge () {
-	move_to_original_branch
-	if test -s "$state_dir"/rewritten
-	then
-		git notes copy --for-rewrite=rebase <"$state_dir"/rewritten
-		hook="$(git rev-parse --git-path hooks/post-rewrite)"
-		test -x "$hook" && "$hook" rebase <"$state_dir"/rewritten
-	fi
-	say All done.
-}
-
-git_rebase__merge () {
-
-case "$action" in
-continue)
-	read_state
-	continue_merge
-	while test "$msgnum" -le "$end"
-	do
-		call_merge "$msgnum"
-		continue_merge
-	done
-	finish_rb_merge
-	return
-	;;
-skip)
-	read_state
-	git rerere clear
-	msgnum=$(($msgnum + 1))
-	while test "$msgnum" -le "$end"
-	do
-		call_merge "$msgnum"
-		continue_merge
-	done
-	finish_rb_merge
-	return
-	;;
-show-current-patch)
-	exec git show REBASE_HEAD --
-	;;
-esac
-
-mkdir -p "$state_dir"
-echo "$onto_name" > "$state_dir/onto_name"
-write_basic_state
-rm -f "$(git rev-parse --git-path REBASE_HEAD)"
-
-msgnum=0
-for cmt in $(git rev-list --reverse --no-merges "$revisions")
-do
-	msgnum=$(($msgnum + 1))
-	echo "$cmt" > "$state_dir/cmt.$msgnum"
-done
-
-echo 1 >"$state_dir/msgnum"
-echo $msgnum >"$state_dir/end"
-
-end=$msgnum
-msgnum=1
-
-while test "$msgnum" -le "$end"
-do
-	call_merge "$msgnum"
-	continue_merge
-done
-
-finish_rb_merge
-
-}
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 0392e36d23..04d6c71899 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -17,14 +17,9 @@ test_expect_success 'setup' '
 	git tag start
 '
 
-cat >expect <<\EOF
-Already applied: 0001 A
-Already applied: 0002 B
-Committed: 0003 Z
-EOF
-
 test_expect_success 'rebase -m' '
 	git rebase -m master >report &&
+	>expect &&
 	sed -n -e "/^Already applied: /p" \
 		-e "/^Committed: /p" report >actual &&
 	test_cmp expect actual
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index f355c6825a..49077200c5 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -53,41 +53,6 @@ create_expected_success_interactive () {
 	EOF
 }
 
-create_expected_success_merge () {
-	cat >expected <<-EOF
-	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
-	HEAD is now at $(git rev-parse --short feature-branch) third commit
-	First, rewinding head to replay your work on top of it...
-	Merging unrelated-onto-branch with HEAD~1
-	Merging:
-	$(git rev-parse --short unrelated-onto-branch) unrelated commit
-	$(git rev-parse --short feature-branch^) second commit
-	found 1 common ancestor:
-	$(git rev-parse --short feature-branch~2) initial commit
-	[detached HEAD $(git rev-parse --short rebased-feature-branch~1)] second commit
-	 Author: A U Thor <author@example.com>
-	 Date: Thu Apr 7 15:14:13 2005 -0700
-	 2 files changed, 2 insertions(+)
-	 create mode 100644 file1
-	 create mode 100644 file2
-	Committed: 0001 second commit
-	Merging unrelated-onto-branch with HEAD~0
-	Merging:
-	$(git rev-parse --short rebased-feature-branch~1) second commit
-	$(git rev-parse --short feature-branch) third commit
-	found 1 common ancestor:
-	$(git rev-parse --short feature-branch~1) second commit
-	[detached HEAD $(git rev-parse --short rebased-feature-branch)] third commit
-	 Author: A U Thor <author@example.com>
-	 Date: Thu Apr 7 15:15:13 2005 -0700
-	 1 file changed, 1 insertion(+)
-	 create mode 100644 file3
-	Committed: 0002 third commit
-	All done.
-	Applied autostash.
-	EOF
-}
-
 create_expected_failure_am () {
 	cat >expected <<-EOF
 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
@@ -112,43 +77,6 @@ create_expected_failure_interactive () {
 	EOF
 }
 
-create_expected_failure_merge () {
-	cat >expected <<-EOF
-	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
-	HEAD is now at $(git rev-parse --short feature-branch) third commit
-	First, rewinding head to replay your work on top of it...
-	Merging unrelated-onto-branch with HEAD~1
-	Merging:
-	$(git rev-parse --short unrelated-onto-branch) unrelated commit
-	$(git rev-parse --short feature-branch^) second commit
-	found 1 common ancestor:
-	$(git rev-parse --short feature-branch~2) initial commit
-	[detached HEAD $(git rev-parse --short rebased-feature-branch~1)] second commit
-	 Author: A U Thor <author@example.com>
-	 Date: Thu Apr 7 15:14:13 2005 -0700
-	 2 files changed, 2 insertions(+)
-	 create mode 100644 file1
-	 create mode 100644 file2
-	Committed: 0001 second commit
-	Merging unrelated-onto-branch with HEAD~0
-	Merging:
-	$(git rev-parse --short rebased-feature-branch~1) second commit
-	$(git rev-parse --short feature-branch) third commit
-	found 1 common ancestor:
-	$(git rev-parse --short feature-branch~1) second commit
-	[detached HEAD $(git rev-parse --short rebased-feature-branch)] third commit
-	 Author: A U Thor <author@example.com>
-	 Date: Thu Apr 7 15:15:13 2005 -0700
-	 1 file changed, 1 insertion(+)
-	 create mode 100644 file3
-	Committed: 0002 third commit
-	All done.
-	Applying autostash resulted in conflicts.
-	Your changes are safe in the stash.
-	You can run "git stash pop" or "git stash drop" at any time.
-	EOF
-}
-
 testrebase () {
 	type=$1
 	dotest=$2
@@ -177,6 +105,9 @@ testrebase () {
 	test_expect_success "rebase$type --autostash: check output" '
 		test_when_finished git branch -D rebased-feature-branch &&
 		suffix=${type#\ --} && suffix=${suffix:-am} &&
+		if test ${suffix} = "merge"; then
+			suffix=interactive
+		fi &&
 		create_expected_success_$suffix &&
 		test_i18ncmp expected actual
 	'
@@ -274,6 +205,9 @@ testrebase () {
 	test_expect_success "rebase$type: check output with conflicting stash" '
 		test_when_finished git branch -D rebased-feature-branch &&
 		suffix=${type#\ --} && suffix=${suffix:-am} &&
+		if test ${suffix} = "merge"; then
+			suffix=interactive
+		fi &&
 		create_expected_failure_$suffix &&
 		test_i18ncmp expected actual
 	'
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index 99b2aac921..911ef49f70 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -111,7 +111,7 @@ test_run_rebase () {
 	"
 }
 test_run_rebase success ''
-test_run_rebase failure -m
+test_run_rebase success -m
 test_run_rebase success -i
 test_run_rebase success -p
 
@@ -126,7 +126,7 @@ test_run_rebase () {
 	"
 }
 test_run_rebase success ''
-test_run_rebase failure -m
+test_run_rebase success -m
 test_run_rebase success -i
 test_run_rebase success -p
 
@@ -141,7 +141,7 @@ test_run_rebase () {
 	"
 }
 test_run_rebase success ''
-test_run_rebase failure -m
+test_run_rebase success -m
 test_run_rebase success -i
 test_run_rebase success -p
 
@@ -284,7 +284,7 @@ test_run_rebase () {
 	"
 }
 test_run_rebase success ''
-test_run_rebase failure -m
+test_run_rebase success -m
 test_run_rebase success -i
 test_run_rebase success -p
 
@@ -315,7 +315,7 @@ test_run_rebase () {
 	"
 }
 test_run_rebase success ''
-test_run_rebase failure -m
+test_run_rebase success -m
 test_run_rebase success -i
 test_run_rebase failure -p
 
diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
index 846f85c27e..cd505c0711 100755
--- a/t/t3425-rebase-topology-merges.sh
+++ b/t/t3425-rebase-topology-merges.sh
@@ -72,7 +72,7 @@ test_run_rebase () {
 }
 #TODO: make order consistent across all flavors of rebase
 test_run_rebase success 'e n o' ''
-test_run_rebase success 'e n o' -m
+test_run_rebase success 'n o e' -m
 test_run_rebase success 'n o e' -i
 
 test_run_rebase () {
@@ -89,7 +89,7 @@ test_run_rebase () {
 }
 #TODO: make order consistent across all flavors of rebase
 test_run_rebase success 'd e n o' ''
-test_run_rebase success 'd e n o' -m
+test_run_rebase success 'd n o e' -m
 test_run_rebase success 'd n o e' -i
 
 test_run_rebase () {
@@ -106,7 +106,7 @@ test_run_rebase () {
 }
 #TODO: make order consistent across all flavors of rebase
 test_run_rebase success 'd e n o' ''
-test_run_rebase success 'd e n o' -m
+test_run_rebase success 'd n o e' -m
 test_run_rebase success 'd n o e' -i
 
 test_expect_success "rebase -p is no-op in non-linear history" "
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 9b2a274c71..145c61251d 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -120,6 +120,7 @@ test_expect_success 'git rebase -m --skip' '
 	git rebase --continue &&
 	echo rebase >expected.args &&
 	cat >expected.data <<-EOF &&
+	$(git rev-parse C) $(git rev-parse HEAD^)
 	$(git rev-parse D) $(git rev-parse HEAD)
 	EOF
 	verify_hook_input
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 81a5179e28..5cadedb2a9 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -180,7 +180,7 @@ test_expect_success 'prompt - interactive rebase' '
 '
 
 test_expect_success 'prompt - rebase merge' '
-	printf " (b2|REBASE-m 1/3)" >expected &&
+	printf " (b2|REBASE-i 1/3)" >expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout master" &&
 	test_must_fail git rebase --merge b1 b2 &&
-- 
2.19.1.858.g526e8fe740.dirty

