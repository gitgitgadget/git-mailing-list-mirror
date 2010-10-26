From: Johan Herland <johan@herland.net>
Subject: [PATCHv5.1 23/23] Provide 'git merge --abort' as a synonym to 'git
 reset --merge'
Date: Tue, 26 Oct 2010 03:34:50 +0200
Message-ID: <201010260334.51162.johan@herland.net>
References: <1287965333-5099-1-git-send-email-johan@herland.net>
 <201010251203.00389.johan@herland.net> <201010260326.33200.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Jonathan Nieder <jrnieder@gmail.com>, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 26 03:35:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAYRL-00007M-BY
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 03:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755484Ab0JZBey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 21:34:54 -0400
Received: from smtp.getmail.no ([84.208.15.66]:48963 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914Ab0JZBex (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 21:34:53 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAV006BOJ24XN00@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 26 Oct 2010 03:34:52 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 84E151799460_CC6303CB	for <git@vger.kernel.org>; Tue,
 26 Oct 2010 01:34:52 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 292741796324_CC6303CF	for <git@vger.kernel.org>; Tue,
 26 Oct 2010 01:34:52 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAV00JQXJ238F00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 26 Oct 2010 03:34:52 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-ARCH; KDE/4.5.2; x86_64; ; )
In-reply-to: <201010260326.33200.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159977>

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

This patch has been improved by the following contributions:
- Jonathan Nieder: Move test documentation into test_description

Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Johan Herland <johan@herland.net>
---

Hi,

The documentation and test cases in this patch has been extensively
updated. The code in builtin/merge.s is unchanged.

Again, thanks to Jonathan Nieder for extremely helpful reviews.


Have fun! :)

...Johan

 Documentation/git-merge.txt |   27 ++++-
 builtin/merge.c             |   14 ++
 t/t7609-merge-abort.sh      |  313 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 351 insertions(+), 3 deletions(-)
 create mode 100755 t/t7609-merge-abort.sh

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 84043cc..47b59a5 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 	[-s <strategy>] [-X <strategy-option>]
 	[--[no-]rerere-autoupdate] [-m <msg>] <commit>...
 'git merge' <msg> HEAD <commit>...
+'git merge' --abort
 
 DESCRIPTION
 -----------
@@ -47,6 +48,14 @@ The second syntax (<msg> `HEAD` <commit>...) is supported for
 historical reasons.  Do not use it from the command line or in
 new scripts.  It is the same as `git merge -m <msg> <commit>...`.
 
+The third syntax ("`git merge --abort`") can only be run after the
+merge has resulted in conflicts. 'git merge --abort' will abort the
+merge process and try to reconstruct the pre-merge state. However,
+if there were uncommitted changes when the merge started (and
+especially if those changes were further modified after the merge
+was started), 'git merge --abort' will in some cases be unable to
+reconstruct the original (pre-merge) changes. Therefore:
+
 *Warning*: Running 'git merge' with uncommitted changes is
 discouraged: while possible, it leaves you in a state that is hard to
 back out of in the case of a conflict.
@@ -72,6 +81,18 @@ include::merge-options.txt[]
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
 
+--abort::
+	Abort the current conflict resolution process, and
+	try to reconstruct the pre-merge state.
++
+If there were uncommitted worktree changes present when the merge
+started, 'git merge --abort' will in some cases be unable to
+reconstruct these changes. It is therefore recommended to always
+commit or stash your changes before running 'git merge'.
++
+'git merge --abort' is equivalent to 'git reset --merge' when
+`MERGE_HEAD` is present.
+
 <commit>...::
 	Commits, usually other branch heads, to merge into our branch.
 	You need at least one <commit>.  Specifying more than one
@@ -142,7 +163,7 @@ happens:
    i.e. matching `HEAD`.
 
 If you tried a merge which resulted in complex conflicts and
-want to start over, you can recover with `git reset --merge`.
+want to start over, you can recover with `git merge --abort`.
 
 HOW CONFLICTS ARE PRESENTED
 ---------------------------
@@ -213,8 +234,8 @@ After seeing a conflict, you can do two things:
 
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
new file mode 100755
index 0000000..61890bc
--- /dev/null
+++ b/t/t7609-merge-abort.sh
@@ -0,0 +1,313 @@
+#!/bin/sh
+
+test_description='test aborting in-progress merges
+
+Set up repo with conflicting and non-conflicting branches:
+
+There are three files foo/bar/baz, and the following graph illustrates the
+content of these files in each commit:
+
+# foo/bar/baz --- foo/bar/bazz     <-- master
+#             \
+#              --- foo/barf/bazf   <-- conflict_branch
+#               \
+#                --- foo/bart/baz  <-- clean_branch
+
+Next, test git merge --abort with the following variables:
+- before/after successful merge (should fail when not in merge context)
+- with/without conflicts
+- clean/dirty index before merge
+- clean/dirty worktree before merge
+- dirty index before merge matches contents on remote branch
+- changed/unchanged worktree after merge
+- changed/unchanged index after merge
+'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	# Create the above repo
+	echo foo > foo &&
+	echo bar > bar &&
+	echo baz > baz &&
+	git add foo bar baz &&
+	git commit -m initial &&
+	echo bazz > baz &&
+	git commit -a -m "second" &&
+	git checkout -b conflict_branch HEAD^ &&
+	echo barf > bar &&
+	echo bazf > baz &&
+	git commit -a -m "conflict" &&
+	git checkout -b clean_branch HEAD^ &&
+	echo bart > bar &&
+	git commit -a -m "clean" &&
+	git checkout master
+'
+
+pre_merge_head="$(git rev-parse HEAD)"
+
+test_expect_success 'fails without MERGE_HEAD (unstarted merge)' '
+	test_must_fail git merge --abort 2>output &&
+	grep -q MERGE_HEAD output &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)"
+'
+
+test_expect_success 'fails without MERGE_HEAD (completed merge)' '
+	git merge clean_branch &&
+	test ! -f .git/MERGE_HEAD &&
+	# Merge successfully completed
+	post_merge_head="$(git rev-parse HEAD)" &&
+	test_must_fail git merge --abort 2>output &&
+	grep -q MERGE_HEAD output &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$post_merge_head" = "$(git rev-parse HEAD)"
+'
+
+test_expect_success 'Forget previous merge' '
+	git reset --hard "$pre_merge_head"
+'
+
+test_expect_success 'Abort after --no-commit' '
+	# Redo merge, but stop before creating merge commit
+	git merge --no-commit clean_branch &&
+	test -f .git/MERGE_HEAD &&
+	# Abort non-conflicting merge
+	git merge --abort &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	test -z "$(git diff)" &&
+	test -z "$(git diff --staged)"
+'
+
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
+
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
+
+test_expect_success 'Conflicting merge with dirty index fails' '
+	test_must_fail git merge conflict_branch &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	test -z "$(git diff)" &&
+	git diff --staged > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Reset index (but preserve worktree changes)' '
+	git reset "$pre_merge_head" &&
+	git diff > actual &&
+	test_cmp expect actual
+'
+
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
+'
+
+test_expect_success 'Abort conflicting merge with non-conflicting dirty worktree' '
+	test_must_fail git merge conflict_branch &&
+	test -f .git/MERGE_HEAD &&
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
+	git reset --hard "$pre_merge_head"
+'
+
+test_expect_success 'Fail clean merge with conflicting dirty worktree' '
+	echo xyzzy >> bar &&
+	git diff > expect &&
+	test_must_fail git merge --no-commit clean_branch &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	test -z "$(git diff --staged)" &&
+	git diff > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Fail conflicting merge with conflicting dirty worktree' '
+	test_must_fail git merge conflict_branch &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	test -z "$(git diff --staged)" &&
+	git diff > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Reset worktree changes' '
+	git reset --hard "$pre_merge_head"
+'
+
+test_expect_success 'Fail clean merge with matching dirty worktree' '
+	echo bart > bar &&
+	git diff > expect &&
+	test_must_fail git merge --no-commit clean_branch &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	test -z "$(git diff --staged)" &&
+	git diff > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Abort clean merge with matching dirty index' '
+	git add bar &&
+	git diff --staged > expect &&
+	git merge --no-commit clean_branch &&
+	test -f .git/MERGE_HEAD &&
+	### When aborting the merge, git will discard all staged changes,
+	### including those that were staged pre-merge. In other words,
+	### --abort will LOSE any staged changes (the staged changes that
+	### are lost must match the merge result, or the merge would not
+	### have been allowed to start). Change expectations accordingly:
+	rm expect &&
+	touch expect &&
+	# Abort merge
+	git merge --abort &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	git diff --staged > actual &&
+	test_cmp expect actual &&
+	test -z "$(git diff)"
+'
+
+test_expect_success 'Reset worktree changes' '
+	git reset --hard "$pre_merge_head"
+'
+
+test_expect_success 'Fail conflicting merge with matching dirty worktree' '
+	echo barf > bar &&
+	git diff > expect &&
+	test_must_fail git merge conflict_branch &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	test -z "$(git diff --staged)" &&
+	git diff > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Abort conflicting merge with matching dirty index' '
+	git add bar &&
+	git diff --staged > expect &&
+	test_must_fail git merge conflict_branch &&
+	test -f .git/MERGE_HEAD &&
+	### When aborting the merge, git will discard all staged changes,
+	### including those that were staged pre-merge. In other words,
+	### --abort will LOSE any staged changes (the staged changes that
+	### are lost must match the merge result, or the merge would not
+	### have been allowed to start). Change expectations accordingly:
+	rm expect &&
+	touch expect &&
+	# Abort merge
+	git merge --abort &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	git diff --staged > actual &&
+	test_cmp expect actual &&
+	test -z "$(git diff)"
+'
+
+test_expect_success 'Reset worktree changes' '
+	git reset --hard "$pre_merge_head"
+'
+
+test_expect_success 'Abort merge with pre- and post-merge worktree changes' '
+	# Pre-merge worktree changes
+	echo xyzzy > foo &&
+	echo barf > bar &&
+	git add bar &&
+	git diff > expect &&
+	git diff --staged > expect-staged &&
+	# Perform merge
+	test_must_fail git merge conflict_branch &&
+	test -f .git/MERGE_HEAD &&
+	# Post-merge worktree changes
+	echo yzxxz > foo &&
+	echo blech > baz &&
+	### When aborting the merge, git will discard staged changes (bar)
+	### and unmerged changes (baz). Other changes that are neither
+	### staged nor marked as unmerged (foo), will be preserved. For
+	### these changed, git cannot tell pre-merge changes apart from
+	### post-merge changes, so the post-merge changes will be
+	### preserved. Change expectations accordingly:
+	git diff -- foo > expect &&
+	rm expect-staged &&
+	touch expect-staged &&
+	# Abort merge
+	git merge --abort &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	git diff > actual &&
+	test_cmp expect actual &&
+	git diff --staged > actual-staged &&
+	test_cmp expect-staged actual-staged
+'
+
+test_expect_success 'Reset worktree changes' '
+	git reset --hard "$pre_merge_head"
+'
+
+test_expect_success 'Abort merge with pre- and post-merge index changes' '
+	# Pre-merge worktree changes
+	echo xyzzy > foo &&
+	echo barf > bar &&
+	git add bar &&
+	git diff > expect &&
+	git diff --staged > expect-staged &&
+	# Perform merge
+	test_must_fail git merge conflict_branch &&
+	test -f .git/MERGE_HEAD &&
+	# Post-merge worktree changes
+	echo yzxxz > foo &&
+	echo blech > baz &&
+	git add foo bar &&
+	### When aborting the merge, git will discard all staged changes
+	### (foo, bar and baz), and no changes will be preserved. Whether
+	### the changes were staged pre- or post-merge does not matter
+	### (except for not preventing starting the merge).
+	### Change expectations accordingly:
+	rm expect expect-staged &&
+	touch expect &&
+	touch expect-staged &&
+	# Abort merge
+	git merge --abort &&
+	test ! -f .git/MERGE_HEAD &&
+	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
+	git diff > actual &&
+	test_cmp expect actual &&
+	git diff --staged > actual-staged &&
+	test_cmp expect-staged actual-staged
+'
+
+test_done
-- 
1.7.3.2.173.gab1c9.dirty
