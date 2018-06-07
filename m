Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09DE11F403
	for <e@80x24.org>; Thu,  7 Jun 2018 17:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933403AbeFGRN5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 13:13:57 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:44636 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932772AbeFGRNx (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Jun 2018 13:13:53 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57H96Oj032548;
        Thu, 7 Jun 2018 10:13:47 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jbs3ghekw-1;
        Thu, 07 Jun 2018 10:13:47 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 4BED322BCF85;
        Thu,  7 Jun 2018 10:13:47 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 40C312CDE86;
        Thu,  7 Jun 2018 10:13:47 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        alban.gruin@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 3/3] git-rebase.sh: make git-rebase--interactive the default
Date:   Thu,  7 Jun 2018 10:13:44 -0700
Message-Id: <20180607171344.23331-4-newren@gmail.com>
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

am-based rebases suffer from an reduced ability to detect directory
renames upstream, which is fundamental to the fact that it throws away
information about the history: in particular, it dispenses with the
original commits involved by turning them into patches, and without the
knowledge of the original commits we cannot determine a proper merge base.

The am-based rebase will proceed by first trying git-apply, and, only if
it fails, will try to reconstruct a provisional merge base using
build_fake_ancestor().  This fake ancestor will ONLY contain the files
modified in the patch; without the full list of files in the real merge
base, renames of any missing files cannot be detected.  Directory rename
detection works by looking at individual file renames and deducing when a
full directory has been renamed.

Trying to modify build_fake_ancestor() to instead create a merge base that
includes common file information by looking for a commit that contained
all the same blobs as the pre-image of the patch would require a very
expensive search through history, may find the wrong commit, and outside
of rebase may not find any commit that matches.

But we had all the relevant information to start.  So, instead of
attempting to fix am which just doesn't have the relevant information,
instead note its strength and weaknesses, and change the default rebase
machinery to interactive since it does not suffer from the same problems.

Documentation updates:

  Several documentation updates were made as part of previous patches to
  note which sets of options were incompatible.  However, adding a new
  --am option allows us to make it clear which options imply this
  machinery and simplify the discussion of incompatible sets of options
  significantly.

testcase modification nodes:
  t3400: git-rebase--interactive.sh explicitly captures output and
         adds die "could not detach HEAD"; adjust to match
  t3401: fixes directory rename detection problems for rebase by default,
         though --am still fails on it
  t3404: testcase said it was for a non-interactive rebase, so add --am
  t3407: instead of having one test per rebase type, also add an extra one
         for the default rebase type.  That'll duplicate --merge for now,
         but will make switching default machinery again in the future
         clearer, if we ever choose to do so.  Also, previously there was
         a conspicuously missing test for all --quit combinations.
  t3420: command output varies by type of rebase and this test script
         has lots of helper functions providing the appropriate
         expectation.  Make sure we call the relevant one.
  t3425: Similar to t3407, add default rebase type to list of types to
         test.  See also comments about t3425 in the switchover of
         --merge to the interactive machinery.
  t5407: This suite has tests for different rebase types, so specify some
         are --am ones.
  t5520: interactive rebases capture and reprint informational message
         about conflicts to stdout rather than stderr.  Also, patches for
         interactive rebases are stored differently under .git than for
         am rebases.
  t9903: Add another testcase for am rebases.  Prompt for default rebases
         is now REBASE-m.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt      | 26 ++++++++++++--------------
 git-rebase.sh                     | 30 +++++++++++++++++++++---------
 t/t3400-rebase.sh                 |  7 ++++---
 t/t3401-rebase-and-am-rename.sh   | 18 +++++++++++++++++-
 t/t3404-rebase-interactive.sh     |  2 +-
 t/t3407-rebase-abort.sh           | 28 +++++++++++++++++++++++++++-
 t/t3420-rebase-autostash.sh       | 15 ++++++++++-----
 t/t3425-rebase-topology-merges.sh |  9 ++++++---
 t/t5407-post-rewrite-hook.sh      |  4 ++--
 t/t5520-pull.sh                   |  9 ++++++---
 t/t9903-bash-prompt.sh            | 12 +++++++++++-
 11 files changed, 117 insertions(+), 43 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 28d1658d7a..6cfb7479fd 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -240,13 +240,16 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 	original branch. The index and working tree are also left
 	unchanged as a result.
 
+--am:
+	Use git-am internally to rebase.  This may run faster, but have
+	problems with rename detection on the upstream side.
+	Incompatible with the --interactive option, or anything that
+	uses the `--interactive` machinery.
+
 --keep-empty::
 	Keep the commits that do not change anything from its
 	parents in the result.
-+
-This uses the `--interactive` machinery internally, and as such,
-anything that is incompatible with --interactive is incompatible
-with this option.
+	This uses the `--interactive` machinery internally.
 
 --allow-empty-message::
 	By default, rebasing commits with an empty message will fail.
@@ -268,7 +271,7 @@ with this option.
 --merge::
 	Use merging strategies to rebase.  When the recursive (default) merge
 	strategy is used, this allows rebase to be aware of renames on the
-	upstream side.
+	upstream side.  This is the default.
 +
 Note that a rebase merge works by replaying each commit from the working
 branch on top of the <upstream> branch.  Because of this, when a merge
@@ -276,9 +279,7 @@ conflict happens, the side reported as 'ours' is the so-far rebased
 series, starting with <upstream>, and 'theirs' is the working branch.  In
 other words, the sides are swapped.
 +
-This uses the `--interactive` machinery internally, and as such,
-anything that is incompatible with --interactive is incompatible
-with this option.
+This uses the `--interactive` machinery internally.
 
 -s <strategy>::
 --strategy=<strategy>::
@@ -332,8 +333,7 @@ which makes little sense.
 	and after each change.  When fewer lines of surrounding
 	context exist they all must match.  By default no context is
 	ever ignored.
-	Incompatible with the --interactive option, or anything that
-	uses the `--interactive` machinery.
+	Implies --am.
 
 -f::
 --force-rebase::
@@ -365,15 +365,13 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
 --whitespace=<option>::
 	These flag are passed to the 'git apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
-	Incompatible with the --interactive option, or anything that
-	uses the `--interactive` machinery.
+	Implies --am.
 
 --committer-date-is-author-date::
 --ignore-date::
 	These flags are passed to 'git am' to easily change the dates
 	of the rebased commits (see linkgit:git-am[1]).
-	Incompatible with the --interactive option, or anything that
-	uses the `--interactive` machinery.
+	Implies --am.
 
 --signoff::
 	Add a Signed-off-by: trailer to all the rebased commits. Note
diff --git a/git-rebase.sh b/git-rebase.sh
index 5ac1dee30b..c8c3d0d05a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -21,7 +21,8 @@ r,rebase-merges?   try to rebase merges instead of skipping them
 p,preserve-merges! try to recreate merges instead of ignoring them
 s,strategy=!       use the given merge strategy
 no-ff!             cherry-pick all commits, even if unchanged
-m,merge!           use merging strategies to rebase
+am                 use git-am to rebase
+m,merge!           use merging strategies to rebase; this is the default
 i,interactive!     let the user edit the list of commits to rebase
 x,exec=!           add exec lines after each commit of the editable list
 k,keep-empty	   preserve empty commits during rebase
@@ -69,6 +70,7 @@ unset restrict_revision
 cmd=
 strategy=
 strategy_opts=
+use_am=
 do_merge=
 merge_dir="$GIT_DIR"/rebase-merge
 apply_dir="$GIT_DIR"/rebase-apply
@@ -311,6 +313,9 @@ do
 	--no-fork-point)
 		fork_point=
 		;;
+	--am)
+		use_am=t
+		;;
 	--merge)
 		do_merge=t
 		;;
@@ -479,6 +484,7 @@ then
 	test -z "$interactive_rebase" && interactive_rebase=implied
 fi
 
+interactive_only_opts=`echo "$git_am_opt" | sed -e 's/ -q//'`
 actually_interactive=
 if test -n "$interactive_rebase"
 then
@@ -490,9 +496,18 @@ then
 	interactive_rebase=implied
 	type=interactive
 	state_dir="$merge_dir"
-else
+elif test -n "$use_am"
+then
 	type=am
 	state_dir="$apply_dir"
+elif test -n "$interactive_only_opts"
+then
+	type=am
+	state_dir="$apply_dir"
+else
+	interactive_rebase=implied
+	type=interactive
+	state_dir="$merge_dir"
 fi
 
 if test -t 2 && test -z "$GIT_QUIET"
@@ -500,14 +515,11 @@ then
 	git_format_patch_opt="$git_format_patch_opt --progress"
 fi
 
-if test -n "$git_am_opt"; then
-	incompatible_opts=`echo "$git_am_opt" | sed -e 's/ -q//'`
-	if test -n "$incompatible_opts"
+if test -n "$interactive_only_opts"
+then
+	if test -n "$actually_interactive" || test "$do_merge"
 	then
-		if test -n "$actually_interactive" || test "$do_merge"
-		then
-			die "$(gettext "error: cannot combine am options ($incompatible_opts) with either interactive or merge options")"
-		fi
+		die "$(gettext "error: cannot combine am options ($interactive_only_opts) with either interactive or merge options")"
 	fi
 fi
 
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 72d9564747..03713572d6 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -136,8 +136,9 @@ test_expect_success 'setup: recover' '
 test_expect_success 'Show verbose error when HEAD could not be detached' '
 	>B &&
 	test_must_fail git rebase topic 2>output.err >output.out &&
-	test_i18ngrep "The following untracked working tree files would be overwritten by checkout:" output.err &&
-	test_i18ngrep B output.err
+	test_i18ngrep "The following untracked working tree files would be overwritten by checkout:" output.out &&
+	test_i18ngrep B output.out &&
+	test_i18ngrep "could not detach HEAD" output.err
 '
 rm -f B
 
@@ -289,7 +290,7 @@ test_expect_success 'rebase--am.sh and --show-current-patch' '
 		git tag two &&
 		test_must_fail git rebase --onto init HEAD^ &&
 		GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
-		grep "show.*$(git rev-parse two)" stderr
+		grep "show REBASE_HEAD" stderr
 	)
 '
 
diff --git a/t/t3401-rebase-and-am-rename.sh b/t/t3401-rebase-and-am-rename.sh
index ec87439bc6..6b54031201 100755
--- a/t/t3401-rebase-and-am-rename.sh
+++ b/t/t3401-rebase-and-am-rename.sh
@@ -54,7 +54,7 @@ test_expect_success 'rebase --interactive: directory rename detected' '
 	)
 '
 
-test_expect_failure 'rebase (am): directory rename detected' '
+test_expect_success 'rebase (default): directory rename detected' '
 	(
 		cd dir-rename &&
 
@@ -70,6 +70,22 @@ test_expect_failure 'rebase (am): directory rename detected' '
 	)
 '
 
+test_expect_failure 'rebase --am: directory rename detected' '
+	(
+		cd dir-rename &&
+
+		git checkout B^0 &&
+
+		git rebase --am A &&
+
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+
+		test_path_is_file y/d &&
+		test_path_is_missing x/d
+	)
+'
+
 test_expect_success 'rebase --merge: directory rename detected' '
 	(
 		cd dir-rename &&
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c65826ddac..116060204e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -975,7 +975,7 @@ test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-int
 	git reset --hard &&
 	git checkout conflict-branch &&
 	set_fake_editor &&
-	test_must_fail git rebase --onto HEAD~2 HEAD~ &&
+	test_must_fail git rebase --am --onto HEAD~2 HEAD~ &&
 	test_must_fail git rebase --edit-todo &&
 	git rebase --abort
 '
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 910f218284..33084b17f5 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -96,14 +96,28 @@ testrebase() {
 	'
 }
 
-testrebase "" .git/rebase-apply
+testrebase " --am" .git/rebase-apply
+testrebase "" .git/rebase-merge
 testrebase " --merge" .git/rebase-merge
+testrebase " --interactive" .git/rebase-merge
 
 test_expect_success 'rebase --quit' '
 	cd "$work_dir" &&
 	# Clean up the state from the previous one
 	git reset --hard pre-rebase &&
 	test_must_fail git rebase master &&
+	test_path_is_dir .git/rebase-merge &&
+	head_before=$(git rev-parse HEAD) &&
+	git rebase --quit &&
+	test $(git rev-parse HEAD) = $head_before &&
+	test ! -d .git/rebase-merge
+'
+
+test_expect_success 'rebase --am --quit' '
+	cd "$work_dir" &&
+	# Clean up the state from the previous one
+	git reset --hard pre-rebase &&
+	test_must_fail git rebase --am master &&
 	test_path_is_dir .git/rebase-apply &&
 	head_before=$(git rev-parse HEAD) &&
 	git rebase --quit &&
@@ -123,4 +137,16 @@ test_expect_success 'rebase --merge --quit' '
 	test ! -d .git/rebase-merge
 '
 
+test_expect_success 'rebase --interactive --quit' '
+	cd "$work_dir" &&
+	# Clean up the state from the previous one
+	git reset --hard pre-rebase &&
+	test_must_fail git rebase --interactive master &&
+	test_path_is_dir .git/rebase-merge &&
+	head_before=$(git rev-parse HEAD) &&
+	git rebase --quit &&
+	test $(git rev-parse HEAD) = $head_before &&
+	test ! -d .git/rebase-merge
+'
+
 test_done
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index c465713672..9af0d27435 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -104,8 +104,10 @@ testrebase () {
 
 	test_expect_success "rebase$type --autostash: check output" '
 		test_when_finished git branch -D rebased-feature-branch &&
-		suffix=${type#\ --} && suffix=${suffix:-am} &&
-		if test ${suffix} = "merge"; then
+		suffix=${type#\ --} &&
+		if test ${suffix} = "am"; then
+			suffix=am
+		else
 			suffix=interactive
 		fi &&
 		create_expected_success_$suffix &&
@@ -204,8 +206,10 @@ testrebase () {
 
 	test_expect_success "rebase$type: check output with conflicting stash" '
 		test_when_finished git branch -D rebased-feature-branch &&
-		suffix=${type#\ --} && suffix=${suffix:-am} &&
-		if test ${suffix} = "merge"; then
+		suffix=${type#\ --} &&
+		if test ${suffix} = "am"; then
+			suffix=am
+		else
 			suffix=interactive
 		fi &&
 		create_expected_failure_$suffix &&
@@ -235,7 +239,8 @@ test_expect_success "rebase: noop rebase" '
 	git checkout feature-branch
 '
 
-testrebase "" .git/rebase-apply
+testrebase " --am" .git/rebase-apply
+testrebase "" .git/rebase-merge
 testrebase " --merge" .git/rebase-merge
 testrebase " --interactive" .git/rebase-merge
 
diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
index cd505c0711..8fd14c86d3 100755
--- a/t/t3425-rebase-topology-merges.sh
+++ b/t/t3425-rebase-topology-merges.sh
@@ -71,7 +71,8 @@ test_run_rebase () {
 	"
 }
 #TODO: make order consistent across all flavors of rebase
-test_run_rebase success 'e n o' ''
+test_run_rebase success 'e n o' --am
+test_run_rebase success 'n o e' ''
 test_run_rebase success 'n o e' -m
 test_run_rebase success 'n o e' -i
 
@@ -88,7 +89,8 @@ test_run_rebase () {
 	"
 }
 #TODO: make order consistent across all flavors of rebase
-test_run_rebase success 'd e n o' ''
+test_run_rebase success 'd e n o' --am
+test_run_rebase success 'd n o e' ''
 test_run_rebase success 'd n o e' -m
 test_run_rebase success 'd n o e' -i
 
@@ -105,7 +107,8 @@ test_run_rebase () {
 	"
 }
 #TODO: make order consistent across all flavors of rebase
-test_run_rebase success 'd e n o' ''
+test_run_rebase success 'd e n o' --am
+test_run_rebase success 'd n o e' ''
 test_run_rebase success 'd n o e' -m
 test_run_rebase success 'd n o e' -i
 
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 145c61251d..f5b5f4f04c 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -71,7 +71,7 @@ test_expect_success 'git rebase' '
 test_expect_success 'git rebase --skip' '
 	git reset --hard D &&
 	clear_hook_input &&
-	test_must_fail git rebase --onto A B &&
+	test_must_fail git rebase --am --onto A B &&
 	test_must_fail git rebase --skip &&
 	echo D > foo &&
 	git add foo &&
@@ -86,7 +86,7 @@ test_expect_success 'git rebase --skip' '
 test_expect_success 'git rebase --skip the last one' '
 	git reset --hard F &&
 	clear_hook_input &&
-	test_must_fail git rebase --onto D A &&
+	test_must_fail git rebase --am --onto D A &&
 	git rebase --skip &&
 	echo rebase >expected.args &&
 	cat >expected.data <<-EOF &&
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 59c4b778d3..d7c915a209 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -305,7 +305,7 @@ test_expect_success '--rebase with conflicts shows advice' '
 	test_tick &&
 	git commit -m "Create conflict" seq.txt &&
 	test_must_fail git pull --rebase . seq 2>err >out &&
-	test_i18ngrep "Resolve all conflicts manually" out
+	test_i18ngrep "Resolve all conflicts manually" err
 '
 
 test_expect_success 'failed --rebase shows advice' '
@@ -319,7 +319,7 @@ test_expect_success 'failed --rebase shows advice' '
 	git checkout -f -b fails-to-rebase HEAD^ &&
 	test_commit v2-without-cr file "2" file2-lf &&
 	test_must_fail git pull --rebase . diverging 2>err >out &&
-	test_i18ngrep "Resolve all conflicts manually" out
+	test_i18ngrep "Resolve all conflicts manually" err
 '
 
 test_expect_success '--rebase fails with multiple branches' '
@@ -671,7 +671,10 @@ test_expect_success 'setup for avoiding reapplying old patches' '
 test_expect_success 'git pull --rebase does not reapply old patches' '
 	(cd dst &&
 	 test_must_fail git pull --rebase &&
-	 test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
+	 cat .git/rebase-merge/done .git/rebase-merge/git-rebase-todo >work &&
+	 grep -v -e \# -e ^$ work >patches &&
+	 test_line_count = 1 patches &&
+	 rm -f work patches
 	)
 '
 
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index c3b89ae783..29a83ae8cf 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -192,10 +192,20 @@ test_expect_success 'prompt - rebase merge' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - rebase' '
+test_expect_success 'prompt - rebase am' '
 	printf " (b2|REBASE 1/3)" >expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout master" &&
+	test_must_fail git rebase --am b1 b2 &&
+	test_when_finished "git rebase --abort" &&
+	__git_ps1 >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - rebase' '
+	printf " (b2|REBASE-m 1/3)" >expected &&
+	git checkout b2 &&
+	test_when_finished "git checkout master" &&
 	test_must_fail git rebase b1 b2 &&
 	test_when_finished "git rebase --abort" &&
 	__git_ps1 >"$actual" &&
-- 
2.18.0.rc1.12.g2996b9442d

