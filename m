From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 23/23] Provide 'git merge --abort' as a synonym to 'git reset
 --merge'
Date: Mon, 25 Oct 2010 02:08:53 +0200
Message-ID: <1287965333-5099-24-git-send-email-johan@herland.net>
References: <1287965333-5099-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 25 02:10:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAAdn-0000ju-Ic
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 02:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023Ab0JYAJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 20:09:32 -0400
Received: from smtp.getmail.no ([84.208.15.66]:59910 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017Ab0JYAJb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 20:09:31 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT0052CKFOGG50@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:24 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id D0B71179913D_CC4CAB4B	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:24 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 7FA0A1796996_CC4CAB4F	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:23 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT004SRKFAVB20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:18 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1287965333-5099-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159909>

Teach 'git merge' the --abort option, which verifies the existence of
MERGE_HEAD and then invokes 'git reset --merge' to abort the current
in-progress merge and attempt to reconstruct the pre-merge state.

The reason for adding this option is to provide a user interface for
aborting an in-progress merge that is consistent with the interface
for aborting a rebase ('git rebase --abort'), aborting the application
of a patch series ('git am --abort'), and aborting an in-progress notes
merge ('git notes merge --abort').

The patch includes documentation and testcases that explain and verify
the various scenarios in which 'git merge --abort' can run. The
testcases also document the cases in which 'git merge --abort' is
unable to correctly restore the pre-merge state (look for the '###'
comments towards the bottom of t/t7609-merge-abort.sh).

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-merge.txt |   29 ++++-
 builtin/merge.c             |   14 ++
 t/t7609-merge-abort.sh      |  290 ++++++++++++++++++++++++++++++++++---------
 3 files changed, 273 insertions(+), 60 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 84043cc..d0099d3 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 	[-s <strategy>] [-X <strategy-option>]
 	[--[no-]rerere-autoupdate] [-m <msg>] <commit>...
 'git merge' <msg> HEAD <commit>...
+'git merge' --abort
 
 DESCRIPTION
 -----------
@@ -47,6 +48,15 @@ The second syntax (<msg> `HEAD` <commit>...) is supported for
 historical reasons.  Do not use it from the command line or in
 new scripts.  It is the same as `git merge -m <msg> <commit>...`.
 
+The third syntax ("`git merge --abort`") can only be run after the
+merge has resulted in conflicts. 'git merge --abort' will abort the
+merge process and reconstruct the pre-merge state. However, if there
+were uncommitted changes when the merge started (and these changes
+did not interfere with the merge itself, otherwise the merge would
+have refused to start), and then additional modifications were made
+to these uncommitted changes, 'git merge --abort' will not be able
+reconstruct the original (pre-merge) uncommitted changes. Therefore:
+
 *Warning*: Running 'git merge' with uncommitted changes is
 discouraged: while possible, it leaves you in a state that is hard to
 back out of in the case of a conflict.
@@ -72,6 +82,19 @@ include::merge-options.txt[]
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
 
+--abort::
+	Abort the current conflict resolution process, and
+	reconstruct the pre-merge state.
++
+Any uncommitted worktree changes present when the merge started,
+will only be preserved if they have not been further modified
+since the merge started. Otherwise, git is unable to reconstruct
+uncommitted changes. It is therefore recommended to always commit
+or stash your changes before running 'git merge'.
++
+'git merge --abort' is equivalent to 'git reset --merge' when
+`MERGE_HEAD` is present.
+
 <commit>...::
 	Commits, usually other branch heads, to merge into our branch.
 	You need at least one <commit>.  Specifying more than one
@@ -142,7 +165,7 @@ happens:
    i.e. matching `HEAD`.
 
 If you tried a merge which resulted in complex conflicts and
-want to start over, you can recover with `git reset --merge`.
+want to start over, you can recover with `git merge --abort`.
 
 HOW CONFLICTS ARE PRESENTED
 ---------------------------
@@ -213,8 +236,8 @@ After seeing a conflict, you can do two things:
 
  * Decide not to merge.  The only clean-ups you need are to reset
    the index file to the `HEAD` commit to reverse 2. and to clean
-   up working tree changes made by 2. and 3.; `git-reset --hard` can
-   be used for this.
+   up working tree changes made by 2. and 3.; `git merge --abort`
+   can be used for this.
 
  * Resolve the conflicts.  Git will mark the conflicts in
    the working tree.  Edit the files into shape and
diff --git a/builtin/merge.c b/builtin/merge.c
index 702f399..fbe342f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -56,6 +56,7 @@ static size_t xopts_nr, xopts_alloc;
 static const char *branch;
 static int verbosity;
 static int allow_rerere_auto;
+static int abort_current_merge;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -194,6 +195,8 @@ static struct option builtin_merge_options[] = {
 		"message to be used for the merge commit (if any)",
 		option_parse_message),
 	OPT__VERBOSITY(&verbosity),
+	OPT_BOOLEAN(0, "abort", &abort_current_merge,
+		"abort the current in-progress merge"),
 	OPT_END()
 };
 
@@ -914,6 +917,17 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, builtin_merge_options,
 			builtin_merge_usage, 0);
 
+	if (abort_current_merge) {
+		int nargc = 2;
+		const char *nargv[] = {"reset", "--merge", NULL};
+
+		if (!file_exists(git_path("MERGE_HEAD")))
+			die("There is no merge to abort (MERGE_HEAD missing).");
+
+		/* Invoke 'git reset --merge' */
+		return cmd_reset(nargc, nargv, prefix);
+	}
+
 	if (read_cache_unmerged()) {
 		die_resolve_conflict("merge");
 	}
diff --git a/t/t7609-merge-abort.sh b/t/t7609-merge-abort.sh
index 88d76e1..011a4c0 100755
--- a/t/t7609-merge-abort.sh
+++ b/t/t7609-merge-abort.sh
@@ -3,95 +3,271 @@
 test_description='test aborting in-progress merges'
 . ./test-lib.sh
 
+# Set up repo with conflicting and non-conflicting branches:
+#
+# master1---master2---foo_foo  <-- master
+#        \
+#         --clean1             <-- clean_branch
+#                 \
+#                  --foo_bar   <-- conflict_branch
+
+test_expect_success 'setup' '
+	test_commit master1 &&
+	git checkout -b clean_branch &&
+	test_commit clean1 &&
+	git checkout -b conflict_branch &&
+	echo bar > foo &&
+	git add foo &&
+	git commit -m "foo_bar" &&
+	git tag foo_bar &&
+	git checkout master &&
+	test_commit master2 &&
+	echo foo > foo &&
+	git add foo &&
+	git commit -m "foo_foo" &&
+	git tag foo_foo
+'
+
 # Test git merge --abort with the following variables:
 # - before/after successful merge (i.e. should fail if not in merge context)
 # - with/without conflicts
+# - clean/dirty index before merge (merge fails on dirty index)
 # - clean/dirty worktree before merge (may fail to reconstruct dirty worktree)
-# - clean/dirty index before merge (merge should fail on dirty index)
+# - dirty worktree before merge matches contents on remote branch
 # - changed/unchanged worktree after merge
 # - changed/unchanged index after merge
 
-test_done
+pre_merge_head="$(git rev-parse HEAD)"
 
 test_expect_success 'fails without MERGE_HEAD (unstarted merge)' '
 	test_must_fail git merge --abort 2>output &&
-	grep -q MERGE_HEAD output
+	grep -q MERGE_HEAD output &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)"
 '
 
 test_expect_success 'fails without MERGE_HEAD (completed merge)' '
-	test_commit master-1 &&
-	test_commit master-2 &&
-	git checkout -b side HEAD^ &&
-	test_commit side-1 &&
-	git checkout master &&
-	git merge side &&
+	git merge clean_branch &&
+	test ! -f .git/MERGE_HEAD &&
 	# Merge successfully completed
+	post_merge_head="$(git rev-parse HEAD)" &&
 	test_must_fail git merge --abort 2>output &&
-	grep -q MERGE_HEAD output
+	grep -q MERGE_HEAD output &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$post_merge_head" = "$(git rev-parse HEAD)"
 '
 
-test_expect_success 'Abort successfully after --no-commit' '
-	# Forget previous merge
-	git reset --hard master^ &&
-	head=$(git rev-parse HEAD) &&
-	git merge --no-commit side &&
+test_expect_success 'Forget previous merge' '
+	git reset --hard "$pre_merge_head"
+'
+
+test_expect_success 'Abort after --no-commit' '
+	# Redo merge, but stop before creating merge commit
+	git merge --no-commit clean_branch &&
 	test -f .git/MERGE_HEAD &&
+	# Abort non-conflicting merge
 	git merge --abort &&
-	test "$head" = "$(git rev-parse HEAD)" &&
-	test -z "$(git diff HEAD)" &&
-	test ! -f .git/MERGE_HEAD
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	test -z "$(git diff)" &&
+	test -z "$(git diff --staged)"
 '
 
+test_expect_success 'Abort after conflicts' '
+	# Create conflicting merge
+	test_must_fail git merge conflict_branch &&
+	test -f .git/MERGE_HEAD &&
+	# Abort conflicting merge
+	git merge --abort &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	test -z "$(git diff)" &&
+	test -z "$(git diff --staged)"
+'
 
+test_expect_success 'Clean merge with dirty index fails' '
+	echo xyzzy >> foo &&
+	git add foo &&
+	git diff --staged > expect &&
+	test_must_fail git merge clean_branch &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	test -z "$(git diff)" &&
+	git diff --staged > actual &&
+	test_cmp expect actual
+'
 
-test_done
+test_expect_success 'Conflicting merge with dirty index fails' '
+	test_must_fail git merge conflict_branch &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	test -z "$(git diff)" &&
+	git diff --staged > actual &&
+	test_cmp expect actual
+'
 
-test_expect_success 'merge local branch' '
-	test_commit master-1 &&
-	git checkout -b local-branch &&
-	test_commit branch-1 &&
-	git checkout master &&
-	test_commit master-2 &&
-	git merge local-branch &&
-	check_oneline "Merge branch Qlocal-branchQ"
+test_expect_success 'Reset index (but preserve worktree changes)' '
+	git reset "$pre_merge_head" &&
+	git diff > actual &&
+	test_cmp expect actual
 '
 
-test_expect_success 'merge octopus branches' '
-	git checkout -b octopus-a master &&
-	test_commit octopus-1 &&
-	git checkout -b octopus-b master &&
-	test_commit octopus-2 &&
-	git checkout master &&
-	git merge octopus-a octopus-b &&
-	check_oneline "Merge branches Qoctopus-aQ and Qoctopus-bQ"
+test_expect_success 'Abort clean merge with non-conflicting dirty worktree' '
+	git merge --no-commit clean_branch &&
+	test -f .git/MERGE_HEAD &&
+	# Abort merge
+	git merge --abort &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	test -z "$(git diff --staged)" &&
+	git diff > actual &&
+	test_cmp expect actual
 '
 
-test_expect_success 'merge tag' '
-	git checkout -b tag-branch master &&
-	test_commit tag-1 &&
-	git checkout master &&
-	test_commit master-3 &&
-	git merge tag-1 &&
-	check_oneline "Merge commit Qtag-1Q"
+test_expect_success 'Reset worktree changes' '
+	git reset --hard "$pre_merge_head" &&
+	git clean -f
 '
 
-test_expect_success 'ambiguous tag' '
-	git checkout -b ambiguous master &&
-	test_commit ambiguous &&
-	git checkout master &&
-	test_commit master-4 &&
-	git merge ambiguous &&
-	check_oneline "Merge commit QambiguousQ"
+test_expect_success 'Abort conflicting merge with non-conflicting dirty worktree' '
+	echo xyzzy >> master1.t &&
+	git diff > expect &&
+	test_must_fail git merge conflict_branch &&
+	test -f .git/MERGE_HEAD &&
+	# Abort merge
+	git merge --abort &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	test -z "$(git diff --staged)" &&
+	git diff > actual &&
+	test_cmp expect actual
 '
 
-test_expect_success 'remote branch' '
-	git checkout -b remote master &&
-	test_commit remote-1 &&
-	git update-ref refs/remotes/origin/master remote &&
-	git checkout master &&
-	test_commit master-5 &&
-	git merge origin/master &&
-	check_oneline "Merge remote branch Qorigin/masterQ"
+test_expect_success 'Reset worktree changes' '
+	git reset --hard "$pre_merge_head" &&
+	git clean -f
+'
+
+test_expect_success 'Fail clean merge with conflicting dirty worktree' '
+	echo xyzzy >> clean1.t &&
+	git diff > expect &&
+	test_must_fail git merge --no-commit clean_branch &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	test -z "$(git diff --staged)" &&
+	git diff > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Reset worktree changes' '
+	git reset --hard "$pre_merge_head" &&
+	git clean -f
+'
+
+test_expect_success 'Fail clean merge with matching dirty worktree' '
+	echo clean1 > clean1.t &&
+	git diff > expect &&
+	test_must_fail git merge --no-commit clean_branch &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	test -z "$(git diff --staged)" &&
+	git diff > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Reset worktree changes' '
+	git reset --hard "$pre_merge_head" &&
+	git clean -f
+'
+
+test_expect_success 'Fail conflicting merge with conflicting dirty worktree' '
+	echo xyzzy >> foo &&
+	git diff > expect &&
+	test_must_fail git merge conflict_branch &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	test -z "$(git diff --staged)" &&
+	git diff > actual &&
+	test_cmp expect actual
+'
+test_expect_success 'Reset worktree changes' '
+	git reset --hard "$pre_merge_head" &&
+	git clean -f
+'
+
+test_expect_success 'Fail conflicting merge with matching dirty worktree' '
+	echo bar > foo &&
+	git diff > expect &&
+	test_must_fail git merge conflict_branch &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	test -z "$(git diff --staged)" &&
+	git diff > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Reset worktree changes' '
+	git reset --hard "$pre_merge_head" &&
+	git clean -f
+'
+
+test_expect_success 'Abort merge with pre- and post-merge worktree changes' '
+	# Pre-merge worktree changes
+	echo xyzzy >> master1.t &&
+	git diff > expect &&
+	# Perform merge
+	test_must_fail git merge conflict_branch &&
+	test -f .git/MERGE_HEAD &&
+	# Post-merge worktree changes
+	echo barf >> master1.t &&
+	echo barf > foo &&
+	### When aborting the merge, git can reconstruct foo, but for non-
+	### conflicting files it cannot tell pre-merge changes apart from
+	### post-merge changes. Therefore, the master1.t file will reflect
+	### the post-merge state, while the foo file will reflect the
+	### pre-merge (unchanged) state. Change expectations accordingly:
+	git diff master1.t > expect &&
+	# Abort merge
+	git merge --abort &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	test -z "$(git diff --staged)" &&
+	git diff > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Reset worktree changes' '
+	git reset --hard "$pre_merge_head" &&
+	git clean -f
+'
+
+test_expect_success 'Abort merge with pre-merge worktree changes and post-merge index changes' '
+	# Pre-merge worktree changes
+	echo xyzzy >> master1.t &&
+	echo xyzzy >> master2.t &&
+	### See explanation below for why we only expect the diff of master2.t
+	git diff master2.t > expect &&
+	# Perform merge
+	test_must_fail git merge conflict_branch &&
+	test -f .git/MERGE_HEAD &&
+	# Post-merge worktree changes
+	echo barf >> master1.t &&
+	echo barf > foo &&
+	git add master1.t foo &&
+	### When aborting the merge, git will remove all staged changes,
+	### including those that were staged post-merge. For any post-merge
+	### changes that have overwritten pre-merge changes, git cannot
+	### reconstruct the pre-merge changes. In this scenario, foo and
+	### master1.t are reset to a clean state (i.e. losing the pre-merge
+	### changes in master1.t), but the pre-merge changes in master2.t are
+	### preserved (since it was not changed post-merge).
+	# Abort merge
+	git merge --abort &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	test -z "$(git diff --staged)" &&
+	git diff > actual &&
+	test_cmp expect actual
 '
 
 test_done
-- 
1.7.3.98.g5ad7d9
