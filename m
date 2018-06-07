Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22A731F403
	for <e@80x24.org>; Thu,  7 Jun 2018 17:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933356AbeFGRNz (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 13:13:55 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:44640 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933124AbeFGRNx (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Jun 2018 13:13:53 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57H9GWc000487;
        Thu, 7 Jun 2018 10:13:47 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jbs3ghekv-1;
        Thu, 07 Jun 2018 10:13:47 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 3FAEC22BCF84;
        Thu,  7 Jun 2018 10:13:47 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 323372CDEED;
        Thu,  7 Jun 2018 10:13:47 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        alban.gruin@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 2/3] rebase: Implement --merge via git-rebase--interactive
Date:   Thu,  7 Jun 2018 10:13:43 -0700
Message-Id: <20180607171344.23331-3-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.13.ge6eabe3ad6
In-Reply-To: <20180607171344.23331-1-newren@gmail.com>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607171344.23331-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=48 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806070188
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Interactive rebases are implemented in terms of cherry-pick rather than
the merge-recursive builtin, but cherry-pick also calls into the recursive
merge machinery by default and can accept special merge strategies and/or
special strategy options.  As such, there really is not any need for
having both git-rebase--merge and git-rebase--interactive anymore.

Delete git-rebase--merge.sh and have the --merge option call in to
git-rebase--interactive.  Add one new variable ($actually_interactive) to
help keep cases separate, and adjust the detection of the special
circumstances under which a rebase boils down to a simple fast forward so
that it keeps working with the new structure.

Note that this change fixes a few known test failures (see t3421).

testcase modification notes:
  t3406: --interactive and --merge had slightly different progress output
         while running; adjust a test to match
  t3420: tests of precise output while running, but rebase--am,
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 .gitignore                        |   1 -
 Documentation/git-rebase.txt      |  16 +--
 Makefile                          |   1 -
 git-rebase--interactive.sh        |   5 +-
 git-rebase--merge.sh              | 164 ------------------------------
 git-rebase.sh                     |  49 ++++-----
 t/t3406-rebase-message.sh         |   7 +-
 t/t3420-rebase-autostash.sh       |  78 ++------------
 t/t3421-rebase-topology-linear.sh |  10 +-
 t/t3425-rebase-topology-merges.sh |   6 +-
 t/t5407-post-rewrite-hook.sh      |   1 +
 11 files changed, 55 insertions(+), 283 deletions(-)
 delete mode 100644 git-rebase--merge.sh

diff --git a/.gitignore b/.gitignore
index 388cc4beee..747be69d10 100644
--- a/.gitignore
+++ b/.gitignore
@@ -118,7 +118,6 @@
 /git-rebase--am
 /git-rebase--helper
 /git-rebase--interactive
-/git-rebase--merge
 /git-receive-pack
 /git-reflog
 /git-remote
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 451252c173..28d1658d7a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -275,6 +275,10 @@ branch on top of the <upstream> branch.  Because of this, when a merge
 conflict happens, the side reported as 'ours' is the so-far rebased
 series, starting with <upstream>, and 'theirs' is the working branch.  In
 other words, the sides are swapped.
++
+This uses the `--interactive` machinery internally, and as such,
+anything that is incompatible with --interactive is incompatible
+with this option.
 
 -s <strategy>::
 --strategy=<strategy>::
@@ -328,8 +332,8 @@ which makes little sense.
 	and after each change.  When fewer lines of surrounding
 	context exist they all must match.  By default no context is
 	ever ignored.
-	Incompatible with the --merge and --interactive options, or
-	anything that implies those options or their machinery.
+	Incompatible with the --interactive option, or anything that
+	uses the `--interactive` machinery.
 
 -f::
 --force-rebase::
@@ -361,15 +365,15 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
 --whitespace=<option>::
 	These flag are passed to the 'git apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
-	Incompatible with the --merge and --interactive options, or
-	anything that implies those options or their machinery.
+	Incompatible with the --interactive option, or anything that
+	uses the `--interactive` machinery.
 
 --committer-date-is-author-date::
 --ignore-date::
 	These flags are passed to 'git am' to easily change the dates
 	of the rebased commits (see linkgit:git-am[1]).
-	Incompatible with the --merge and --interactive options, or
-	anything that implies those options or their machinery.
+	Incompatible with the --interactive option, or anything that
+	uses the `--interactive` machinery.
 
 --signoff::
 	Add a Signed-off-by: trailer to all the rebased commits. Note
diff --git a/Makefile b/Makefile
index 1d27f36365..8d24aaf638 100644
--- a/Makefile
+++ b/Makefile
@@ -620,7 +620,6 @@ SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-rebase--am
 SCRIPT_LIB += git-rebase--interactive
-SCRIPT_LIB += git-rebase--merge
 SCRIPT_LIB += git-sh-setup
 SCRIPT_LIB += git-sh-i18n
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 1f2401f702..dcc4a26a78 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -885,7 +885,10 @@ init_basic_state () {
 	mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
 	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
 
-	: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
+	if test -n "$actually_interactive"
+	then
+		: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
+	fi
 	write_basic_state
 }
 
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
diff --git a/git-rebase.sh b/git-rebase.sh
index b639c0d4fe..5ac1dee30b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -239,12 +239,10 @@ then
 	state_dir="$apply_dir"
 elif test -d "$merge_dir"
 then
+	type=interactive
 	if test -f "$merge_dir"/interactive
 	then
-		type=interactive
 		interactive_rebase=explicit
-	else
-		type=merge
 	fi
 	state_dir="$merge_dir"
 fi
@@ -481,13 +479,16 @@ then
 	test -z "$interactive_rebase" && interactive_rebase=implied
 fi
 
+actually_interactive=
 if test -n "$interactive_rebase"
 then
 	type=interactive
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
@@ -501,17 +502,11 @@ fi
 
 if test -n "$git_am_opt"; then
 	incompatible_opts=`echo "$git_am_opt" | sed -e 's/ -q//'`
-	if test -n "$interactive_rebase"
+	if test -n "$incompatible_opts"
 	then
-		if test -n "$incompatible_opts"
+		if test -n "$actually_interactive" || test "$do_merge"
 		then
-			die "$(gettext "error: cannot combine interactive options (--interactive, --exec, --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with am options ($incompatible_opts)")"
-		fi
-	fi
-	if test -n "$do_merge"; then
-		if test -n "$incompatible_opts"
-		then
-			die "$(gettext "error: cannot combine merge options (--merge, --strategy, --strategy-option) with am options ($incompatible_opts)")"
+			die "$(gettext "error: cannot combine am options ($incompatible_opts) with either interactive or merge options")"
 		fi
 	fi
 fi
@@ -660,7 +655,7 @@ require_clean_work_tree "rebase" "$(gettext "Please commit or stash them.")"
 # but this should be done only when upstream and onto are the same
 # and if this is not an interactive rebase.
 mb=$(git merge-base "$onto" "$orig_head")
-if test "$type" != interactive && test "$upstream" = "$onto" &&
+if test -z "$actually_interactive" && test "$upstream" = "$onto" &&
 	test "$mb" = "$onto" && test -z "$restrict_revision" &&
 	# linear history?
 	! (git rev-list --parents "$onto".."$orig_head" | sane_grep " .* ") > /dev/null
@@ -704,6 +699,22 @@ then
 	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
 fi
 
+if test -z "$actually_interactive"
+then
+	# If the $onto is a proper descendant of the tip of the branch, then
+	# we just fast-forwarded.
+	if test "$mb" = "$orig_head"
+	then
+		say "$(eval_gettext "Fast-forwarded \$branch_name to \$onto_name.")"
+		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name" \
+			git checkout -q "$onto^0" || die "could not detach HEAD"
+		git update-ref ORIG_HEAD $orig_head
+		move_to_original_branch
+		finish_rebase
+		exit 0
+	fi
+fi
+
 test "$type" = interactive && run_specific_rebase
 
 # Detach HEAD and reset the tree
@@ -713,16 +724,6 @@ GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name" \
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
index e243700660..c465713672 100755
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
-- 
2.18.0.rc1.12.g2996b9442d

