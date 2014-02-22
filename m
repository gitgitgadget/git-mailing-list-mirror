From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v2 8/8] log --remerge-diff: show what the conflict resolution changed
Date: Sat, 22 Feb 2014 10:17:56 +0100
Message-ID: <75c29215c6a61fe1dc3f088f0fcd9acfa54f24fa.1393059605.git.tr@thomasrast.ch>
References: <cover.1393059605.git.tr@thomasrast.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 22 10:18:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH8jE-0003jt-S2
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 10:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbaBVJS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 04:18:29 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:34863 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbaBVJSN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 04:18:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 689014D64BD;
	Sat, 22 Feb 2014 10:18:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id htjA0fEKL8Or; Sat, 22 Feb 2014 10:18:08 +0100 (CET)
Received: from linux.local (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id BC1E34D65EF;
	Sat, 22 Feb 2014 10:18:03 +0100 (CET)
X-Mailer: git-send-email 1.9.0.313.g3d0a325
In-Reply-To: <cover.1393059605.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242520>

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
 Documentation/rev-list-options.txt |   7 +
 log-tree.c                         | 298 +++++++++++++++++++++++++++++++++++++
 merge-recursive.c                  |   3 +-
 merge-recursive.h                  |   1 +
 revision.c                         |   2 +
 revision.h                         |   4 +-
 t/t4213-log-remerge-diff.sh        | 222 +++++++++++++++++++++++++++
 7 files changed, 535 insertions(+), 2 deletions(-)
 create mode 100755 t/t4213-log-remerge-diff.sh

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 03533af..73264dc 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -790,6 +790,13 @@ options may be given. See linkgit:git-diff-files[1] for more options.
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
index 30b3063..9b831e9 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -11,6 +11,8 @@
 #include "gpg-interface.h"
 #include "sequencer.h"
 #include "line-log.h"
+#include "cache-tree.h"
+#include "merge-recursive.h"
 
 struct decoration name_decoration = { "object names" };
 
@@ -723,6 +725,300 @@ static int do_diff_combined(struct rev_info *opt, struct commit *commit)
 }
 
 /*
+ * Helpers for make_asymmetric_conflict_entries() below.
+ */
+static char *load_cache_entry_blob(struct cache_entry *entry,
+				   unsigned long *size)
+{
+	enum object_type type;
+	void *data;
+
+	if (!entry)
+		return NULL;
+
+	data = read_sha1_file(entry->sha1, &type, size);
+	if (type != OBJ_BLOB)
+		die("BUG: load_cache_entry_blob for non-blob");
+
+	return data;
+}
+
+static void strbuf_append_cache_entry_blob(struct strbuf *sb,
+					   struct cache_entry *entry)
+{
+	unsigned long size;
+	char *data = load_cache_entry_blob(entry, &size);;
+
+	if (!data)
+		return;
+
+	strbuf_add(sb, data, size);
+	free(data);
+}
+
+static void assemble_conflict_entry(struct strbuf *sb,
+				    const char *branch1,
+				    const char *branch2,
+				    struct cache_entry *entry1,
+				    struct cache_entry *entry2)
+{
+	strbuf_addf(sb, "<<<<<<< %s\n", branch1);
+	strbuf_append_cache_entry_blob(sb, entry1);
+	strbuf_addstr(sb, "=======\n");
+	strbuf_append_cache_entry_blob(sb, entry2);
+	strbuf_addf(sb, ">>>>>>> %s\n", branch2);
+}
+
+/*
+ * For --remerge-diff, we need conflicted (<<<<<<< ... >>>>>>>)
+ * representations of as many conflicts as possible.  Default conflict
+ * generation only applies to files that have all three stages.
+ *
+ * This function generates conflict hunk representations for files
+ * that have only one of stage 2 or 3.  The corresponding side in the
+ * conflict hunk format will be empty.  A stage 1, if any, will be
+ * dropped in the process.
+ */
+static void make_asymmetric_conflict_entries(const char *branch1,
+					     const char *branch2)
+{
+	int o = 0, i = 0;
+
+	/*
+	 * NEEDSWORK: we trample all over the cache below, so we need
+	 * to set up the name hash early, before modifying it.  And
+	 * after that we cannot free any cache entries, because they
+	 * remain hashed even if deleted.  Sigh.
+	 */
+	init_name_hash(&the_index, 1);
+
+	/*
+	 * The loop always starts with 'i' pointing at the first entry
+	 * for a pathname.
+	 */
+	while (i < active_nr) {
+		struct cache_entry *ce;
+		struct cache_entry *stage1 = NULL;
+		struct cache_entry *stage2 = NULL;
+		struct cache_entry *stage3 = NULL;
+		struct cache_entry *new_ce = NULL;
+		struct strbuf content = STRBUF_INIT;
+		unsigned char sha1[20];
+
+		assert(o <= i);
+
+		ce = active_cache[i];
+
+		/*
+		 * Pass through stage 0 and submodules unchanged, we
+		 * don't know how to handle them.
+		 */
+		if (ce_stage(ce) == 0
+		    || S_ISGITLINK(ce->ce_mode)) {
+			active_cache[o++] = ce;
+			i++;
+			continue;
+		}
+
+		/*
+		 * Collect the stages we have.  Point 'i' past the
+		 * entry.
+		 */
+		if (/* i < active_nr && */
+		    !strcmp(ce->name, active_cache[i]->name) &&
+		    ce_stage(active_cache[i]) == 1)
+			stage1 = active_cache[i++];
+
+		if (i < active_nr &&
+		    !strcmp(ce->name, active_cache[i]->name) &&
+		    ce_stage(active_cache[i]) == 2)
+			stage2 = active_cache[i++];
+
+		if (i < active_nr &&
+		    !strcmp(ce->name, active_cache[i]->name) &&
+		    ce_stage(active_cache[i]) == 3)
+			stage3 = active_cache[i++];
+
+		if (!stage2 && !stage3)
+			die("BUG: merging resulted in conflict with neither "
+			    "stage 2 nor 3");
+
+		if (cache_dir_exists(ce->name, ce->ce_namelen)) {
+			/*
+			 * If a conflicting directory for this entry exists,
+			 * we can drop it:
+			 *
+			 * In the face of a file/directory conflict,
+			 * merge-recursive
+			 * - puts the file at stage >0 as usual
+			 * - also attempts to check out the file as
+			 *   'file~side' where side is the sha1 of the commit
+			 *   the file came from, to avoid colliding with the
+			 *   directory
+			 *
+			 * But we have requested that files go to the index
+			 * instead of the worktree, so by the time we get
+			 * here, we have both stage>0 'file' from ordinary
+			 * merging and a stage=0 'file~side' from the "write
+			 * all files to index".
+			 *
+			 * We need to remove one of them.  Currently we ditch
+			 * the 'file' entry because it's easier to detect.
+			 * This amounts to always renaming the file to make
+			 * room for the directory.
+			 *
+			 * NEEDSWORK: Two options:
+			 *
+			 * - If the merge result kept the file, it would be
+			 *   better to rename the _directory_ to make room for
+			 *   the file, so that filenames match between the
+			 *   result and the re-merge.
+			 *
+			 * - Or we could avoid going through a tree, since the
+			 *   index can represent (though it's not "legal") a
+			 *   file/directory collision just fine.
+			 */
+		} else {
+			/*
+			 * Otherwise, there is room for a file entry
+			 * at stage 0.  It has fake-conflict content,
+			 * but its mode is the same.
+			 */
+
+			assemble_conflict_entry(&content,
+						branch1, branch2,
+						stage2, stage3);
+			if (write_sha1_file(content.buf, content.len,
+					    typename(OBJ_BLOB), sha1))
+				die("write_sha1_file failed");
+			strbuf_release(&content);
+
+			new_ce = xmalloc(cache_entry_size(ce->ce_namelen));
+			new_ce->ce_mode = ce->ce_mode;
+			new_ce->ce_flags = ce->ce_flags & ~CE_STAGEMASK;
+			new_ce->ce_namelen = ce->ce_namelen;
+			hashcpy(new_ce->sha1, sha1);
+			new_ce->next = NULL;
+			memcpy(new_ce->name, ce->name, ce->ce_namelen+1);
+			active_cache[o++] = new_ce;
+			add_name_hash(&the_index, new_ce);
+		}
+
+		if (stage1)
+			remove_name_hash(&the_index, stage1);
+		if (stage2)
+			remove_name_hash(&the_index, stage2);
+		if (stage3)
+			remove_name_hash(&the_index, stage3);
+		/*
+		 * Can't free stage[1-3] because they are still in the
+		 * name hash, just marked deleted :-(  So we leak them.
+		 */
+	}
+
+	active_nr = o;
+}
+
+/*
+ * --remerge-diff doesn't currently handle entries that cannot be
+ * turned into a stage0 conflicted-file format blob.  So this routine
+ * clears the corresponding entries from the index.  This is
+ * suboptimal; we should eventually handle them _somehow_.
+*/
+static void drop_non_stage0()
+{
+	int o = 0, i = 0;
+
+	while (i < active_nr) {
+		struct cache_entry *ce = active_cache[i];
+		const char *name;
+
+		if (!ce_stage(ce)) {
+			active_cache[o++] = active_cache[i++];
+			continue;
+		}
+
+		name = ce->name;
+
+		printf("Cannot handle stage %d entry '%s', skipping\n",
+		       ce_stage(ce), name);
+		i++;
+
+		while (i < active_nr && !strcmp(name, active_cache[i]->name))
+			free(active_cache[i++]);
+
+		free(ce);
+	}
+
+	active_nr = o;
+}
+
+static int do_diff_remerge(struct rev_info *opt, struct commit *commit)
+{
+	struct commit_list *merge_bases;
+	struct commit *result, *parent1, *parent2;
+	struct merge_options o;
+	char *branch1, *branch2;
+
+	/*
+	 * We show the log message early to avoid headaches later.  In
+	 * general we need to run this before printing anything in
+	 * this routine.
+	 */
+	if (opt->loginfo && !opt->no_commit_id) {
+		show_log(opt);
+
+		if (opt->verbose_header && opt->diffopt.output_format)
+			printf("%s%c", diff_line_prefix(&opt->diffopt),
+			       opt->diffopt.line_termination);
+	}
+
+	if (commit->parents->next->next) {
+		printf("--remerge-diff not supported for octopus merges.\n");
+		return !opt->loginfo;
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
+
+	make_asymmetric_conflict_entries(branch1, branch2);
+	drop_non_stage0();
+
+	free(branch1);
+	free(branch2);
+
+	active_cache_tree = cache_tree();
+	if (cache_tree_update(active_cache_tree,
+			      (const struct cache_entry * const *)active_cache,
+			      active_nr, WRITE_TREE_SILENT) < 0) {
+		printf("BUG: merge conflicts not fully folded, cannot diff.\n");
+		return !opt->loginfo;
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
+/*
  * Show the diff of a commit.
  *
  * Return true if we printed any log info messages
@@ -755,6 +1051,8 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
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
index 127b75a..956a527 100644
--- a/revision.c
+++ b/revision.c
@@ -1811,6 +1811,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->merge_diff_mode = MERGE_DIFF_COMBINED;
 	} else if (!strcmp(arg, "--cc")) {
 		revs->merge_diff_mode = MERGE_DIFF_COMBINED_CONDENSED;
+	} else if (!strcmp(arg, "--remerge-diff")) {
+		revs->merge_diff_mode = MERGE_DIFF_REMERGE;
 	} else if (!strcmp(arg, "-v")) {
 		revs->verbose_header = 1;
 	} else if (!strcmp(arg, "--pretty")) {
diff --git a/revision.h b/revision.h
index 0847902..10a2992 100644
--- a/revision.h
+++ b/revision.h
@@ -58,7 +58,9 @@ enum merge_diff_mode {
 	/* combined format (-c) */
 	MERGE_DIFF_COMBINED,
 	/* combined-condensed format (-cc) */
-	MERGE_DIFF_COMBINED_CONDENSED
+	MERGE_DIFF_COMBINED_CONDENSED,
+	/* --remerge-diff */
+	MERGE_DIFF_REMERGE
 };
 
 struct rev_info {
diff --git a/t/t4213-log-remerge-diff.sh b/t/t4213-log-remerge-diff.sh
new file mode 100755
index 0000000..36ef17a
--- /dev/null
+++ b/t/t4213-log-remerge-diff.sh
@@ -0,0 +1,222 @@
+#!/bin/sh
+
+test_description='test log --remerge-diff'
+. ./test-lib.sh
+
+# A -----------------+----
+# | \  \      \      |    \
+# |  C  \      \     |    |
+# B  |\  \      |    |    |
+# |  | |  D     U   dir  file
+# |\ | |__|__   |    | \ /|
+# | X  |_ |  \  |    |  X |
+# |/ \/  \|   \ |    | / \|
+# M1 M2   M3   M4    M5   M6
+# ^  ^    ^     ^    ^    ^
+# |  |    |     |    |    filedir
+# |  |    |     |    dirfile
+# |  |    dm    unrelated
+# |  evil
+# benign
+#
+#
+# M1 has a "benign" conflict
+# M2 has an "evil" conflict: it ignores the changes in D
+# M3 has a delete/modify conflict, resolved in favor of a modification
+# M4 is a merge of an unrelated change, without conflicts
+# M5 has a file/directory conflict, resolved in favor of the directory
+# M6 has a file/directory conflict, resolved in favor of the file
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
+	git checkout -b dir A &&
+	mkdir sub &&
+	test_commit dir sub/file &&
+	git checkout -b file A &&
+	test_commit file sub &&
+	git checkout -b dirfile tags/dir &&
+	test_must_fail git merge tags/file &&
+	git rm --cached sub &&
+	test_commit M5 sub/file resolved &&
+	git checkout -b filedir tags/file &&
+	test_must_fail git merge tags/dir &&
+	git rm --cached sub/file &&
+	rm -rf sub &&
+	test_commit M6 sub resolved &&
+	git branch -D master side delete dir file
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
+@@ -1,4 +1 @@
+-<<<<<<< tags/C
+-side
+-=======
+->>>>>>> tags/D
++resolved
+EOF
+
+test_expect_success 'delete/modify conflict' '
+	git log -1 --remerge-diff -p dm >output &&
+	clean_output <output >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+commit dirfile
+Merge:
+Author: A U Thor <author@example.com>
+Date:
+
+    M5
+
+diff --git a/sub/file b/sub/file
+index
+--- a/sub/file
++++ b/sub/file
+@@ -1 +1 @@
+-dir
++resolved
+diff --git a/sub~tags/file b/sub~tags/file
+deleted file mode 100644
+index
+--- a/sub~tags/file
++++ /dev/null
+@@ -1 +0,0 @@
+-file
+EOF
+
+test_expect_success 'file/directory conflict resulting in directory' '
+	git log -1 --remerge-diff -p dirfile >output &&
+	clean_output <output >actual &&
+	test_cmp expected actual
+'
+
+# This is wishful thinking, see the NEEDSWORK in
+# make_asymmetric_conflict_entries().
+cat >expected <<EOF
+commit filedir
+Merge:
+Author: A U Thor <author@example.com>
+Date:
+
+    M6
+
+diff --git a/sub b/sub
+index
+--- a/sub
++++ b/sub
+@@ -1 +1 @@
+-file
++resolved
+diff --git a/sub/file b/sub/file
+deleted file mode 100644
+index
+--- a/sub/file
++++ /dev/null
+@@ -1 +0,0 @@
+-dir
+EOF
+
+test_expect_failure 'file/directory conflict resulting in file' '
+	git log -1 --remerge-diff -p filedir >output &&
+	clean_output <output >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.9.0.313.g3d0a325
