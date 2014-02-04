From: Thomas Rast <tr@thomasrast.ch>
Subject: [RFC PATCH 9/9] log --remerge-diff: show what the conflict resolution changed
Date: Tue,  4 Feb 2014 23:17:38 +0100
Message-ID: <1f2585f382f382717bd3cd5d1eafead149fc1013.1391549294.git.tr@thomasrast.ch>
References: <cover.1391549294.git.tr@thomasrast.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 23:18:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAoK2-0001w8-KW
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 23:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934987AbaBDWSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 17:18:24 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:54784 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934994AbaBDWR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 17:17:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id D670A4D65EC
	for <git@vger.kernel.org>; Tue,  4 Feb 2014 23:17:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id udFlMj8eDWOc for <git@vger.kernel.org>;
	Tue,  4 Feb 2014 23:17:51 +0100 (CET)
Received: from linux.local (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 966D34D65EE
	for <git@vger.kernel.org>; Tue,  4 Feb 2014 23:17:43 +0100 (CET)
X-Mailer: git-send-email 1.9.rc2.232.gdd31389
In-Reply-To: <cover.1391549294.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241570>

Git has --cc as a very fast inspection tool that shows a brief summary
of what a conflicted merge "looks like", and -c/-m as "give me the
full information" data dumps.

But --cc actually loses information: if the merge lost(!) some changes
from one side, that hunk would fully agree with the other side, and
therefore be elided.  So --cc cannot be used to investigate mismerges.
Indeed it is rather hard to find a merge that has lost changes, unless
one knows where to look.

The new option --remerge-diff is an attempt at filling this gap,
admittedly at the cost of a lot of CPU cycles.  For each merge commit,
it diffs the merge result against a recursive merge of the merge's
parents.

For files that can be auto-merged cleanly, it will typically show
nothing.  However, it will make it obvious when the merge introduces
extra changes.

For files that result in merge conflicts, we diff against the
representation with conflict hunks (what the user would usually see in
the worktree).  So the diff will show what was changed in the conflict
hunks to resolve the conflict.

It still takes a bit of staring to tell an evil from a regular merge.
But at least the information is there, unlike with --cc; and the
output is usually much shorter than with -c.

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---
 Documentation/rev-list-options.txt |   7 ++
 log-tree.c                         |  60 +++++++++++++++
 merge-recursive.c                  |   3 +-
 merge-recursive.h                  |   1 +
 revision.c                         |   2 +
 revision.h                         |   4 +-
 t/t4202-log.sh                     |   3 +
 t/t4213-log-remerge-diff.sh        | 145 +++++++++++++++++++++++++++++++++++++
 8 files changed, 223 insertions(+), 2 deletions(-)
 create mode 100755 t/t4213-log-remerge-diff.sh

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index d023290..6611557 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -797,6 +797,13 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 	in that case, the output represents the changes the merge
 	brought _into_ the then-current branch.
 
+--remerge-diff::
+	Diff merge commits against a recursive merge of their parents,
+	with conflict hunks.  Intuitively speaking, this shows what
+	the author of the merge changed to resolve the merge.  It
+	assumes that all (or most) merges are recursive merges; other
+	strategies are not supported.
+
 -r::
 	Show recursive diffs.
 
diff --git a/log-tree.c b/log-tree.c
index 4ab3ffe..fa22737 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -11,6 +11,8 @@
 #include "gpg-interface.h"
 #include "sequencer.h"
 #include "line-log.h"
+#include "cache-tree.h"
+#include "merge-recursive.h"
 
 struct decoration name_decoration = { "object names" };
 
@@ -725,6 +727,62 @@ static int do_diff_combined(struct rev_info *opt, struct commit *commit)
 	return !opt->loginfo;
 }
 
+static int do_diff_remerge(struct rev_info *opt, struct commit *commit)
+{
+	struct commit_list *merge_bases;
+	struct commit *result, *parent1, *parent2;
+	struct merge_options o;
+	char *branch1, *branch2;
+
+	if (commit->parents->next->next) {
+		printf("--remerge-diff not supported for octopus merges.\n");
+		return 0;
+	}
+
+	parent1 = commit->parents->item;
+	parent2 = commit->parents->next->item;
+	parse_commit(parent1);
+	parse_commit(parent2);
+	branch1 = xstrdup(sha1_to_hex(parent1->object.sha1));
+	branch2 = xstrdup(sha1_to_hex(parent2->object.sha1));
+
+	merge_bases = get_octopus_merge_bases(commit->parents);
+	init_merge_options(&o);
+	o.verbosity = -1;
+	o.no_worktree = 1;
+	o.conflicts_in_index = 1;
+	o.use_ondisk_index = 0;
+	o.branch1 = branch1;
+	o.branch2 = branch2;
+	merge_recursive(&o, parent1, parent2, merge_bases, &result);
+	free(branch1);
+	free(branch2);
+
+	active_cache_tree = cache_tree();
+	if (cache_tree_update(active_cache_tree,
+			      (const struct cache_entry * const *)active_cache,
+			      active_nr, WRITE_TREE_SILENT) < 0) {
+		printf("BUG: merge conflicts not fully folded, cannot diff.\n");
+		return 0;
+	}
+
+	if (opt->loginfo && !opt->no_commit_id) {
+		show_log(opt);
+
+		if (opt->verbose_header && opt->diffopt.output_format)
+			printf("%s%c", diff_line_prefix(&opt->diffopt),
+			       opt->diffopt.line_termination);
+	}
+
+	diff_tree_sha1(active_cache_tree->sha1, commit->tree->object.sha1,
+		       "", &opt->diffopt);
+	log_tree_diff_flush(opt);
+
+	cache_tree_free(&active_cache_tree);
+
+	return !opt->loginfo;
+}
+
 /*
  * Show the diff of a commit.
  *
@@ -758,6 +816,8 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 			return 0;
 		else if (merge_diff_mode_is_any_combined(opt))
 			return do_diff_combined(opt, commit);
+		else if (opt->merge_diff_mode == MERGE_DIFF_REMERGE)
+			return do_diff_remerge(opt, commit);
 		else if (opt->first_parent_only) {
 			/*
 			 * Generate merge log entry only for the first
diff --git a/merge-recursive.c b/merge-recursive.c
index b682812..1507a7a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1947,7 +1947,7 @@ int merge_recursive(struct merge_options *o,
 	}
 
 	discard_cache();
-	if (!o->call_depth)
+	if (!o->call_depth && o->use_ondisk_index)
 		read_cache();
 
 	o->ancestor = "merged common ancestors";
@@ -2043,6 +2043,7 @@ void init_merge_options(struct merge_options *o)
 	o->diff_rename_limit = -1;
 	o->merge_rename_limit = -1;
 	o->renormalize = 0;
+	o->use_ondisk_index = 1;
 	git_config(merge_recursive_config, o);
 	if (getenv("GIT_MERGE_VERBOSITY"))
 		o->verbosity =
diff --git a/merge-recursive.h b/merge-recursive.h
index 9b8e20b..d7466c7 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -17,6 +17,7 @@ struct merge_options {
 	unsigned renormalize : 1;
 	unsigned no_worktree : 1; /* do not touch worktree */
 	unsigned conflicts_in_index : 1; /* index will contain conflict hunks */
+	unsigned use_ondisk_index : 1; /* tree-level merge loads .git/index */
 	long xdl_opts;
 	int verbosity;
 	int diff_rename_limit;
diff --git a/revision.c b/revision.c
index 3a1a810..bfdf91d 100644
--- a/revision.c
+++ b/revision.c
@@ -1813,6 +1813,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->merge_diff_mode = MERGE_DIFF_COMBINED;
 	} else if (!strcmp(arg, "--cc")) {
 		revs->merge_diff_mode = MERGE_DIFF_COMBINED_CONDENSED;
+	} else if (!strcmp(arg, "--remerge-diff")) {
+		revs->merge_diff_mode = MERGE_DIFF_REMERGE;
 	} else if (!strcmp(arg, "-v")) {
 		revs->verbose_header = 1;
 	} else if (!strcmp(arg, "--pretty")) {
diff --git a/revision.h b/revision.h
index 2ec596f..419bbd9 100644
--- a/revision.h
+++ b/revision.h
@@ -59,7 +59,9 @@ enum merge_diff_mode {
 	/* combined format (-c) */
 	MERGE_DIFF_COMBINED,
 	/* combined-condensed format (-cc) */
-	MERGE_DIFF_COMBINED_CONDENSED
+	MERGE_DIFF_COMBINED_CONDENSED,
+	/* --remerge-diff */
+	MERGE_DIFF_REMERGE
 };
 
 struct rev_info {
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 64f34a6..bd3f536 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -872,4 +872,7 @@ test_expect_success '--merge-bases' '
 	test_cmp expect actual
 '
 
+cat >expect <<\EOF
+EOF
+
 test_done
diff --git a/t/t4213-log-remerge-diff.sh b/t/t4213-log-remerge-diff.sh
new file mode 100755
index 0000000..ca6bbde
--- /dev/null
+++ b/t/t4213-log-remerge-diff.sh
@@ -0,0 +1,145 @@
+#!/bin/sh
+
+test_description='test log --remerge-diff'
+. ./test-lib.sh
+
+# A ----------
+# | \  \      \
+# |  C  \      \
+# B  |\  \      |
+# |  | |  D    unrelated_file
+# |\ | |__|__   |
+# | X  |_ |  \  |
+# |/ \/  \|   \ |
+# M1 M2   M3   M4
+# ^  ^    ^     ^
+# |  |    dm    unrelated
+# |  evil
+# benign
+#
+#
+# M1 has a "benign" conflict
+# M2 has an "evil" conflict: it ignores the changes in D
+# M3 has a delete/modify conflict, resolved in favor of a modification
+# M4 is a merge of an unrelated change, without conflicts
+
+test_expect_success 'setup' '
+	test_commit A file original &&
+	test_commit B file change &&
+	git checkout -b side A &&
+	test_commit C file side &&
+	git checkout -b delete A &&
+	git rm file &&
+	test_commit D &&
+	git checkout -b benign master &&
+	test_must_fail git merge C &&
+	test_commit M1 file merged &&
+	git checkout -b evil B &&
+	test_must_fail git merge C &&
+	test_commit M2 file change &&
+	git checkout -b dm C &&
+	test_must_fail git merge D &&
+	test_commit M3 file resolved &&
+	git checkout -b unrelated A &&
+	test_commit unrelated_file &&
+	git merge C &&
+	test_tick &&
+	git tag M4 &&
+	git branch -D master side
+'
+
+test_expect_success 'unrelated merge: without conflicts' '
+	git log -p --cc unrelated >expected &&
+	git log -p --remerge-diff unrelated >actual &&
+	test_cmp expected actual
+'
+
+clean_output () {
+	git name-rev --name-only --stdin |
+	# strip away bits that aren't treated by the above
+	sed -e 's/^\(index\|Merge:\|Date:\).*/\1/'
+}
+
+cat >expected <<EOF
+commit benign
+Merge:
+Author: A U Thor <author@example.com>
+Date:
+
+    M1
+
+diff --git a/file b/file
+index
+--- a/file
++++ b/file
+@@ -1,5 +1 @@
+-<<<<<<< tags/B
+-change
+-=======
+-side
+->>>>>>> tags/C
++merged
+EOF
+
+test_expect_success 'benign merge: conflicts resolved' '
+	git log -1 -p --remerge-diff benign >output &&
+	clean_output <output >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+commit evil
+Merge:
+Author: A U Thor <author@example.com>
+Date:
+
+    M2
+
+diff --git a/file b/file
+index
+--- a/file
++++ b/file
+@@ -1,5 +1 @@
+-<<<<<<< tags/B
+ change
+-=======
+-side
+->>>>>>> tags/C
+EOF
+
+test_expect_success 'evil merge: changes ignored' '
+	git log -1 --remerge-diff -p evil >output &&
+	clean_output <output >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+commit dm
+Merge:
+Author: A U Thor <author@example.com>
+Date:
+
+    M3
+
+diff --git a/file b/file
+index
+--- a/file
++++ b/file
+@@ -1,5 +1 @@
+-<<<<<<< tags/B
+ change
+-=======
+->>>>>>> tags/D
++resolved
+EOF
+
+# The above just one idea what the output might be.  It's not clear
+# yet what the best solution is.
+
+test_expect_failure 'delete/modify conflict' '
+	git log -1 --remerge-diff -p dm >output &&
+	clean_output <output >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.9.rc2.232.gdd31389
