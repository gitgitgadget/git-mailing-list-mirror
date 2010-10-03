From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v4 1/4] Introduce wholesame directory move detection in diffcore.
Date: Sun,  3 Oct 2010 22:42:06 +0200
Message-ID: <1286138529-6780-2-git-send-email-ydirson@altern.org>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 22:32:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2VEf-000189-RR
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 22:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755002Ab0JCUc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 16:32:29 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:32807 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754841Ab0JCUc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 16:32:27 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id C1483D480AF;
	Sun,  3 Oct 2010 22:32:20 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P2VNu-0001qQ-50; Sun, 03 Oct 2010 22:42:14 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286138529-6780-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157916>

This feature tries to group together files moving from and to
identical directories - the most common case being directory renames.

It is activated by the new --detect-dir-renames diffcore
flag.

This is only the first step, adding the basic functionnality and
adding support to raw diff output (and it breaks unified-diff output
which does not know how to handle that stuff yet).

Even the output format may not be kept as is.  For now both the result
of "mv a b" and "mv a/* b/" are displayed as "Rnnn a/ b/", which is
probably not what we want.  "Rnnn a/* b/" could be a good choice for
the latter if we want them to be distinguished, and even if we want
them to look the same.

Other future developements to be made on top of this include:
* extension of unified-diff format to express this
* application of such new diffs
* teach git-svn (and others ?) to make use of that flag
* merge correctly in case of addition into a moved dir
* detect "directory splits" so merge can flag a conflict on file adds
* use inexact dir renames to bump score of below-threshold renames
  from/to same locations
* add yours here
---
 diff-lib.c        |    6 +-
 diff.c            |    5 +
 diff.h            |    3 +
 diffcore-rename.c |  253 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 tree-diff.c       |    4 +-
 5 files changed, 260 insertions(+), 11 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 392ce2b..f95a672 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -208,7 +208,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 						    ce_option, &dirty_submodule);
 		if (!changed && !dirty_submodule) {
 			ce_mark_uptodate(ce);
-			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
+			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER) &&
+			    !DIFF_OPT_TST(&revs->diffopt, DETECT_DIR_RENAMES))
 				continue;
 		}
 		oldmode = ce->ce_mode;
@@ -338,7 +339,8 @@ static int show_modified(struct rev_info *revs,
 
 	oldmode = old->ce_mode;
 	if (mode == oldmode && !hashcmp(sha1, old->sha1) && !dirty_submodule &&
-	    !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
+	    !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER) &&
+	    !DIFF_OPT_TST(&revs->diffopt, DETECT_DIR_RENAMES))
 		return 0;
 
 	diff_change(&revs->diffopt, oldmode, mode,
diff --git a/diff.c b/diff.c
index 71efa8e..47ef7ea 100644
--- a/diff.c
+++ b/diff.c
@@ -3188,6 +3188,11 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_SET(options, REVERSE_DIFF);
 	else if (!strcmp(arg, "--find-copies-harder"))
 		DIFF_OPT_SET(options, FIND_COPIES_HARDER);
+	else if (!strcmp(arg, "--detect-dir-renames")) {
+		DIFF_OPT_SET(options, DETECT_DIR_RENAMES);
+		if (!options->detect_rename)
+			options->detect_rename = DIFF_DETECT_RENAME;
+	}
 	else if (!strcmp(arg, "--follow"))
 		DIFF_OPT_SET(options, FOLLOW_RENAMES);
 	else if (!strcmp(arg, "--color"))
diff --git a/diff.h b/diff.h
index 1fd44f5..40c548d 100644
--- a/diff.h
+++ b/diff.h
@@ -78,6 +78,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES (1 << 25)
 #define DIFF_OPT_IGNORE_DIRTY_SUBMODULES (1 << 26)
 #define DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG (1 << 27)
+#define DIFF_OPT_DETECT_DIR_RENAMES  (1 << 28)
 
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
@@ -265,6 +266,8 @@ extern void diffcore_fix_diff_index(struct diff_options *);
 "  -C            detect copies.\n" \
 "  --find-copies-harder\n" \
 "                try unchanged files as candidate for copy detection.\n" \
+"  --detect-dir-renames\n" \
+"                detect wholesale directory renames.\n" \
 "  -l<n>         limit rename attempts up to <n> paths.\n" \
 "  -O<file>      reorder diffs according to the <file>.\n" \
 "  -S<string>    find filepair whose only one side contains the string.\n" \
diff --git a/diffcore-rename.c b/diffcore-rename.c
index df41be5..06a8b6c 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -11,6 +11,7 @@
 static struct diff_rename_dst {
 	struct diff_filespec *two;
 	struct diff_filepair *pair;
+	int i_am_not_single:1; // does not look for a match, only here to be looked at
 } *rename_dst;
 static int rename_dst_nr, rename_dst_alloc;
 
@@ -49,9 +50,36 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
 	rename_dst[first].two = alloc_filespec(two->path);
 	fill_filespec(rename_dst[first].two, two->sha1, two->mode);
 	rename_dst[first].pair = NULL;
+	rename_dst[first].i_am_not_single = 0;
 	return &(rename_dst[first]);
 }
 
+static struct diff_rename_dst *locate_rename_dst_dir(struct diff_filespec *dir)
+{
+	/* code mostly duplicated from locate_rename_dst - not sure we
+	 * could merge them efficiently,though
+	 */
+	int first, last;
+	int prefixlength = strlen(dir->path);
+
+	first = 0;
+	last = rename_dst_nr;
+	while (last > first) {
+		int next = (last + first) >> 1;
+		struct diff_rename_dst *dst = &(rename_dst[next]);
+		int cmp = strncmp(dir->path, dst->two->path, prefixlength);
+		if (!cmp)
+			return dst;
+		if (cmp < 0) {
+			last = next;
+			continue;
+		}
+		first = next+1;
+	}
+	/* not found */
+	return NULL;
+}
+
 /* Table of rename/copy src files */
 static struct diff_rename_src {
 	struct diff_filespec *one;
@@ -386,8 +414,11 @@ static int find_exact_renames(void)
 	for (i = 0; i < rename_src_nr; i++)
 		insert_file_table(&file_table, -1, i, rename_src[i].one);
 
-	for (i = 0; i < rename_dst_nr; i++)
+	for (i = 0; i < rename_dst_nr; i++) {
+		if (rename_dst[i].i_am_not_single)
+			continue;
 		insert_file_table(&file_table, 1, i, rename_dst[i].two);
+	}
 
 	/* Find the renames */
 	i = for_each_hash(&file_table, find_same_files);
@@ -414,6 +445,180 @@ static void record_if_better(struct diff_score m[], struct diff_score *o)
 		m[worst] = *o;
 }
 
+struct diff_dir_rename {
+	struct diff_filespec *one;
+	struct diff_filespec *two;
+	int discarded;
+	struct diff_dir_rename* next;
+};
+
+// FIXME: prevent possible overflow
+/*
+ * Copy dirname of src into dst, suitable to append a filename without
+ * an additional "/".
+ * Only handles relative paths since there is no absolute path in a git repo.
+ * Writes "" when there is no "/" in src.
+ * May overwrite more chars than really needed, if src ends with a "/".
+ */
+static const char* copy_dirname(char* dst, const char* src)
+{
+	char* lastslash = strrchr(src, '/');
+	if (!lastslash) {
+		*dst = '\0';
+		return dst;
+	}
+	strncpy(dst, src, lastslash - src + 1);
+	dst[lastslash - src + 1] = '\0';
+
+	// if src ends with a "/" strip the last component
+	if (lastslash[1] == '\0') {
+		lastslash = strrchr(dst, '/');
+		if (!lastslash)
+			return strcpy(dst, ".");
+		lastslash[1] = '\0';
+	}
+
+	return dst;
+}
+
+/*
+ * Take all file renames recorded so far and check if they could cause
+ * a bulk-rename to be detected.
+ *
+ *
+ * FIXME: we could optimize the 100%-rename case by preventing
+ * recursion to unfold what we know we would refold here.
+ * FIXME: do we want to replace linked list with sorted array ?
+ * FIXME: this prototype only properly handles renaming of dirs without
+ * a subdir.
+ * FIXME: leaks like hell.
+ * FIXME: ideas to evaluate a similarity score, anyone ?
+ *  10% * tree similarity + 90% * moved files similarity ?
+ * FIXME: ideas to consider under-threshold moves as part of bulk move ?
+ */
+static struct diff_dir_rename* factorization_candidates = NULL;
+static void diffcore_factorize_renames(void)
+{
+	char one_parent_path[PATH_MAX], two_parent_path[PATH_MAX];
+	int i;
+
+	for (i = 0; i < rename_dst_nr; i++) {
+		struct diff_dir_rename* seen;
+
+		// FIXME: what are those ?
+		if (!rename_dst[i].pair)
+			continue;
+		// dummy renames used by copy detection
+		if (!strcmp(rename_dst[i].pair->one->path, rename_dst[i].pair->two->path))
+			continue;
+
+		copy_dirname(one_parent_path, rename_dst[i].pair->one->path);
+		copy_dirname(two_parent_path, rename_dst[i].pair->two->path);
+
+		// simple rename with no directory change
+		if (!strcmp(one_parent_path, two_parent_path))
+			continue;
+
+		struct diff_filespec* one_parent = alloc_filespec(one_parent_path);
+		fill_filespec(one_parent, null_sha1 /*FIXME*/, S_IFDIR);
+
+		// After this commit, are there any files still under one_parent_path ?
+		struct diff_rename_dst* one_leftover = locate_rename_dst_dir(one_parent);
+		if (one_leftover) { // FIXME: should only be run if !seen
+			/* this might be a dir split, or files added
+			 * after the bulk rename, or just an isolated
+			 * rename */
+			/* FIXME: should we cache this information to avoid
+			 * recomputing that result when many files trigger it ?
+			 * See eg. git.git:761e742d692.
+			 */
+			int two_idx, j, onep_len, maybe_dir_rename;
+
+			// try to see if it is a file added after the bulk rename
+			two_idx = one_leftover - rename_dst;
+			onep_len = strlen(one_parent_path);
+			maybe_dir_rename = 1;
+
+			// check no leftover file was already here before
+			for (j = two_idx; j < rename_dst_nr; j++) {
+				if (strncmp(rename_dst[j].two->path,
+					    one_parent_path, onep_len))
+					break; // exhausted directory in this direction
+				fprintf(stderr, "[DBG] leftover file %s in %s\n",
+					rename_dst[j].two->path, one_parent_path);
+				if (rename_dst[j].i_am_not_single || // those were already here
+				    (rename_dst[j].pair &&
+				     !strncmp(rename_dst[j].pair->one->path,
+					      one_parent_path, onep_len) && // renamed from here
+				     strncmp(rename_dst[j].two->path,
+					     one_parent_path, onep_len))) { // not to a subdir
+					maybe_dir_rename = 0;
+					fprintf(stderr, "[DBG] ... tells not a bulk rename\n");
+					break;
+				}
+				fprintf(stderr, "[DBG] ... not believed to prevent bulk rename\n");
+			}
+			if (!maybe_dir_rename) continue;
+			// try the other direction (dup code)
+			for (j = two_idx-1; j >= 0; j--) {
+				if (strncmp(rename_dst[j].two->path,
+					    one_parent_path, onep_len))
+					break; // exhausted directory in this direction
+				fprintf(stderr, "[DBG] leftover file %s in %s\n",
+					rename_dst[j].two->path, one_parent_path);
+				if (rename_dst[j].i_am_not_single || // those were already here
+				    (rename_dst[j].pair &&
+				     !strncmp(rename_dst[j].pair->one->path,
+					      one_parent_path, onep_len) && // renamed from here
+				     strncmp(rename_dst[j].two->path,
+					     one_parent_path, onep_len))) { // not to a subdir
+					maybe_dir_rename = 0;
+					fprintf (stderr, "[DBG] ... tells not a bulk rename\n");
+					break;
+				}
+				fprintf(stderr, "[DBG] ... not believed to prevent bulk rename\n");
+			}
+			if (!maybe_dir_rename) continue;
+
+			// here we are in the case where a directory
+			// content was completely moved, but files
+			// were added to it afterwards.  Proceed as
+			// for a simple bulk move.
+		}
+
+		// already considered ?
+		for (seen=factorization_candidates; seen; seen = seen->next)
+			if (!strcmp(seen->one->path, one_parent_path)) break;
+		if (!seen) {
+			// record potential dir rename
+			seen = xmalloc(sizeof(*seen));
+			seen->one = one_parent;
+			seen->two = alloc_filespec(two_parent_path);
+			fill_filespec(seen->two, null_sha1 /*FIXME*/, S_IFDIR);
+			seen->discarded = 0;
+			seen->next = factorization_candidates;
+			factorization_candidates = seen;
+			fprintf(stderr, "[DBG] %s -> %s suggests possible rename from %s to %s\n",
+				rename_dst[i].pair->one->path,
+				rename_dst[i].pair->two->path,
+				one_parent_path, two_parent_path);
+			continue;
+		}
+		if (seen->discarded)
+			continue;
+		// check that seen entry matches this rename
+		if (strcmp(two_parent_path, seen->two->path)) {
+			fprintf(stderr, "[DBG] discarding dir %s from renames (split into %s and %s)\n",
+				one_parent_path, two_parent_path, seen->two->path);
+			seen->discarded = 1;
+		}
+
+		/* all checks ok, we keep that entry */
+	}
+
+	return;
+}
+
 void diffcore_rename(struct diff_options *options)
 {
 	int detect_rename = options->detect_rename;
@@ -451,13 +656,22 @@ void diffcore_rename(struct diff_options *options)
 				p->one->rename_used++;
 			register_rename_src(p->one, p->score);
 		}
-		else if (detect_rename == DIFF_DETECT_COPY) {
-			/*
-			 * Increment the "rename_used" score by
-			 * one, to indicate ourselves as a user.
-			 */
-			p->one->rename_used++;
-			register_rename_src(p->one, p->score);
+		else {
+			if (detect_rename == DIFF_DETECT_COPY) {
+				/*
+				 * Increment the "rename_used" score by
+				 * one, to indicate ourselves as a user.
+				 */
+				p->one->rename_used++;
+				register_rename_src(p->one, p->score);
+			}
+			if (DIFF_OPT_TST(options, DETECT_DIR_RENAMES)) {
+				/* similarly, rename factorization needs to
+				 * see all files from second tree, but we don't
+				 * want them to be matched against single sources.
+				 */
+				locate_rename_dst(p->two, 1)->i_am_not_single = 1;
+			}
 		}
 	}
 	if (rename_dst_nr == 0 || rename_src_nr == 0)
@@ -509,6 +723,8 @@ void diffcore_rename(struct diff_options *options)
 
 		if (rename_dst[i].pair)
 			continue; /* dealt with exact match already. */
+		if (rename_dst[i].i_am_not_single)
+			continue; /* not looking for a match. */
 
 		m = &mx[dst_cnt * NUM_CANDIDATE_PER_DST];
 		for (j = 0; j < NUM_CANDIDATE_PER_DST; j++)
@@ -569,7 +785,28 @@ void diffcore_rename(struct diff_options *options)
 	/* At this point, we have found some renames and copies and they
 	 * are recorded in rename_dst.  The original list is still in *q.
 	 */
+
+	/* Now possibly factorize those renames and copies. */
+	if (DIFF_OPT_TST(options, DETECT_DIR_RENAMES))
+		diffcore_factorize_renames();
+
 	DIFF_QUEUE_CLEAR(&outq);
+
+	// Now turn non-discarded factorization_candidates into real renames
+	struct diff_dir_rename* candidate;
+	for (candidate=factorization_candidates; candidate; candidate = candidate->next) {
+		struct diff_filepair* pair;
+		if (candidate->discarded) continue;
+		// visualize toplevel dir if needed - FIXME: wrong place for this ?
+		if (!*candidate->one->path)
+			candidate->one->path = "./";
+		if (!*candidate->two->path)
+			candidate->two->path = "./";
+		pair = diff_queue(&outq, candidate->one, candidate->two);
+		pair->score = MAX_SCORE;
+		pair->renamed_pair = 1;
+	}
+
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		struct diff_filepair *pair_to_free = NULL;
diff --git a/tree-diff.c b/tree-diff.c
index cd659c6..ca0b84f 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -49,7 +49,9 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
 		show_entry(opt, "+", t2, base, baselen);
 		return 1;
 	}
-	if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER) && !hashcmp(sha1, sha2) && mode1 == mode2)
+	if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER) &&
+	    !DIFF_OPT_TST(opt, DETECT_DIR_RENAMES) &&
+	    !hashcmp(sha1, sha2) && mode1 == mode2)
 		return 0;
 
 	/*
-- 
1.7.2.3
