From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] provide a new "theirs" strategy, useful for rebase --onto
Date: Fri, 6 Jun 2008 12:59:30 +0200
Message-ID: <E1K4a1Q-0002hq-QE@fencepost.gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 06 13:25:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4a4E-00033T-AO
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 13:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbYFFLYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 07:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbYFFLYR
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 07:24:17 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:47626 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623AbYFFLYP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 07:24:15 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1K4a1Q-0002hq-QE
	for git@vger.kernel.org; Fri, 06 Jun 2008 07:22:16 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84047>

The new strategy resolves only two heads, and the result of the merge
is always the second head.  It can be useful with `rebase --onto`,
because it always resolves conflicts in favor of the commits
being applied.

The patch includes an update to git-rebase's documentation, showing
how to use the new patch to convert an "--amend"ing commit into a
separate one, as if --amend had not been used.
---
 .gitignore                         |    1 +
 Documentation/git-rebase.txt       |   39 +++++++++++++++++++++++++
 Documentation/merge-strategies.txt |    6 ++++
 Makefile                           |    3 +-
 builtin-merge-theirs.c             |   56 ++++++++++++++++++++++++++++++++++++
 builtin.h                          |    1 +
 git-merge.sh                       |    6 ++--
 git.c                              |    1 +
 t/t3409-rebase-merge-theirs.sh     |   43 +++++++++++++++++++++++++++
 9 files changed, 152 insertions(+), 4 deletions(-)
 create mode 100644 builtin-merge-theirs.c
 create mode 100755 t/t3409-rebase-merge-theirs.sh

	This is equivalent to this script that I suggested in
	http://permalink.gmane.org/gmane.comp.version-control.git/83528

		#! /bin/sh
		eval git reset \$$# -- .
		git-checkout-index -q -f -a 

	The use-case in the manual is also based on that thread.

diff --git a/.gitignore b/.gitignore
index 4ff2fec..6d000e5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -77,6 +77,7 @@ git-merge-recursive
 git-merge-resolve
 git-merge-stupid
 git-merge-subtree
+git-merge-theirs
 git-mergetool
 git-mktag
 git-mktree
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index cc4e94f..577ae83 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -168,6 +168,45 @@ This is useful if F and G were flawed in some way, or should not be
 part of topicA.  Note that the argument to --onto and the <upstream>
 parameter can be any valid commit-ish.
 
+`git rebase` rewrites history, and this is in general something that
+you do not want to do when somebody else is pulling from your
+repository.  For this reason, history rewrites ("forced updates")
+are often forbidden when pushing to a remote repository.  However,
+there are other commands that rewrite history, and indeed rebasing
+can help fixing mistakes and reverting to the published history.
+
+For example, `git commit --amend` also has this effect, and it can
+happen that you use it even though you had already pushed to the
+remote repository before amending your commit.  You can then
+use `git rebase` (with the --onto option) to transform the `--amend`
+commit into a separate commit (as if you had not used the `--amend`
+option).  The situation is like this:
+
+------------
+    o---D---E  origin/master
+         \
+          E'---F---G---H---I  master
+------------
+
+because the parent of the amended commit E' is D, that is
+origin/master^.  To avoid a forced update from master to
+origin/master, you need the history to look like this:
+
+------------
+    o---D---E  origin/master
+             \
+              E''---F'---G'---H'---I'  master
+------------
+
+You can achieve this with:
+
+    git-rebase -s theirs --onto origin/master origin/master^ master
+
+The merge strategy `-s theirs` resolves conflicts in favor of the commits
+being rebased---in this case, you know that the only conflicts will occur
+when replaying E', and you definitely E'' to have those changes.
+
+
 In case of conflict, git-rebase will stop at the first problematic commit
 and leave conflict markers in the tree.  You can use git diff to locate
 the markers (<<<<<<) and make edits to resolve the conflict.  For each
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 1276f85..384c34a 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -34,6 +34,12 @@ ours::
 	be used to supersede old development history of side
 	branches.
 
+theirs::
+	This resolves only two heads, and the result of the merge is
+	always the second head.  It can be useful with `rebase --onto`,
+	because it always resolves conflicts in favor of the commits
+	being applied.
+
 subtree::
 	This is a modified recursive strategy. When merging trees A and
 	B, if B corresponds to a subtree of A, B is first adjusted to
diff --git a/Makefile b/Makefile
index cce5a6e..6241e5d 100644
--- a/Makefile
+++ b/Makefile
@@ -515,6 +515,7 @@ BUILTIN_OBJS += builtin-merge-base.o
 BUILTIN_OBJS += builtin-merge-file.o
 BUILTIN_OBJS += builtin-merge-ours.o
 BUILTIN_OBJS += builtin-merge-recursive.o
+BUILTIN_OBJS += builtin-merge-theirs.o
 BUILTIN_OBJS += builtin-mv.o
 BUILTIN_OBJS += builtin-name-rev.o
 BUILTIN_OBJS += builtin-pack-objects.o
@@ -1343,7 +1344,7 @@ check-docs::
 		case "$$v" in \
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
 		git-merge-resolve | git-merge-stupid | git-merge-subtree | \
-		git-fsck-objects | git-init-db | \
+		git-merge-theirs | git-fsck-objects | git-init-db | \
 		git-?*--?* ) continue ;; \
 		esac ; \
 		test -f "Documentation/$$v.txt" || \
diff --git a/builtin-merge-theirs.c b/builtin-merge-theirs.c
new file mode 100644
index 0000000..6f3e66a
--- /dev/null
+++ b/builtin-merge-theirs.c
@@ -0,0 +1,56 @@
+/*
+ * Implementation the `theirs' merge strategy.
+ *
+ * Copyright (c) 2008 Paolo Bonzini
+ *
+ * A one-way merge, declaring that the merged-from tree trumps everybody else.
+ */
+
+#include "cache.h"
+#include "run-command.h"
+#include "tree.h"
+#include "tree-walk.h"
+#include "unpack-trees.h"
+
+int cmd_merge_theirs(int argc, const char **argv, const char *prefix)
+{
+	int i, fd;
+	struct tree *tree;
+	struct tree_desc desc;
+	struct unpack_trees_options opts;
+	struct lock_file lock_file;
+	unsigned char sha1[20];
+
+	if (argc < 4)
+		die("Usage: %s <base>... -- <head> <remote> ...\n", argv[0]);
+
+	for (i = 1; i < argc; ++i)
+		if (!strcmp(argv[i], "--"))
+			break;
+	if (argc - i != 3) /* "--" "<head>" "<remote>" */
+		die("Not handling anything other than two heads merge.");
+	if (get_sha1(argv[i + 2], sha1))
+		die("%s: not a valid SHA1", argv[i + 2]);
+	if (unmerged_cache())
+		die("you need to resolve your current index first");
+
+	fd = hold_locked_index(&lock_file, 1);
+
+	memset(&opts, 0, sizeof(opts));
+	opts.update = 1;
+	opts.reset = 1;
+	opts.merge = 1;
+	opts.fn = oneway_merge;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+
+	tree = parse_tree_indirect(sha1);
+	init_tree_desc(&desc, tree->buffer, tree->size);
+	if (unpack_trees(1, &desc, &opts))
+		return 128;
+
+	if (write_cache(fd, active_cache, active_nr) ||
+	    commit_locked_index(&lock_file))
+		die("unable to write new index file");
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 8bda111..933ba84 100644
--- a/builtin.h
+++ b/builtin.h
@@ -60,6 +60,7 @@ extern int cmd_merge_base(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
+extern int cmd_merge_theirs(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
diff --git a/git-merge.sh b/git-merge.sh
index 2d177c1..24ba651 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -30,11 +30,11 @@ test -z "$(git ls-files -u)" ||
 LF='
 '
 
-all_strategies='recur recursive octopus resolve stupid ours subtree'
+all_strategies='recur recursive octopus resolve stupid ours theirs subtree'
 default_twohead_strategies='recursive'
 default_octopus_strategies='octopus'
-no_fast_forward_strategies='subtree ours'
-no_trivial_strategies='recursive recur subtree ours'
+no_fast_forward_strategies='subtree ours theirs'
+no_trivial_strategies='recursive recur subtree ours theirs'
 use_strategies=
 
 allow_fast_forward=t
diff --git a/git.c b/git.c
index 272bf03..4ee0822 100644
--- a/git.c
+++ b/git.c
@@ -326,6 +326,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
 		{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
+		{ "merge-theirs", cmd_merge_theirs, RUN_SETUP },
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
diff --git a/t/t3409-rebase-merge-theirs.sh b/t/t3409-rebase-merge-theirs.sh
new file mode 100755
index 0000000..01a0434
--- /dev/null
+++ b/t/t3409-rebase-merge-theirs.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Paolo Bonzini
+#
+
+test_description='git rebase -s theirs test'
+
+. ./test-lib.sh
+
+test_expect_success setup  '
+	T="A quick brown fox jumps over the lazy dog."
+	echo "$T" >file &&
+	echo "$T" >untouched
+	git add file untouched &&
+	git commit -m"initial" &&
+	for i in 1 2 3 4 5
+	do
+		echo "$i $T"
+	done >file &&
+	git commit -a -m"more work" &&
+	git branch origin &&
+	sed "s/5/AMEND/" file >file.tmp &&
+	mv file.tmp file &&
+	git commit --amend -a -m"master amended." &&
+	for i in 6 7 8 9 10
+	do
+		echo "$i $T" >> file &&
+		git commit -a -m"$i" || exit 1
+	done &&
+	git branch amended
+'
+
+test_expect_success 'grafting amended history using rebase -s theirs...' '
+	git rebase -s theirs --onto origin origin^ master &&
+	git diff amended HEAD'
+
+test_expect_success '... should allow a subsequent fast forward merge' '
+	git checkout origin &&
+	git merge master &&
+	test $(git rev-parse origin) = $(git rev-parse master)
+'
+
+test_done
-- 
1.5.5
