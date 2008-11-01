From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/3] Introduce rename factorization in diffcore.
Date: Sat, 01 Nov 2008 23:03:20 +0100
Message-ID: <20081101220319.1116.50509.stgit@gandelf.nowhere.earth>
References: <20081101215739.1116.59319.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 01 23:05:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwOac-0005OB-MI
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 23:05:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbYKAWDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 18:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbYKAWDh
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 18:03:37 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:50502 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbYKAWDg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 18:03:36 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 8645F1AB2C4
	for <git@vger.kernel.org>; Sat,  1 Nov 2008 23:03:33 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 3BC0F1AB2E6
	for <git@vger.kernel.org>; Sat,  1 Nov 2008 23:03:33 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 255181F0C1
	for <git@vger.kernel.org>; Sat,  1 Nov 2008 23:03:20 +0100 (CET)
In-Reply-To: <20081101215739.1116.59319.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99782>

Rename factorization tries to group together files moving from and to
identical directories - the most common case being directory renames.
We do that by first identifying groups of bulk-moved files, and then
hiding those of the individual renames which carry no other
information (further name change, or content changes).
This feature is activated by the new --factorize-renames diffcore
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

 diff-lib.c        |    6 +
 diff.c            |    5 +
 diff.h            |    3 +
 diffcore-rename.c |  301 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 diffcore.h        |    1 
 tree-diff.c       |    4 +
 6 files changed, 307 insertions(+), 13 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index ae96c64..dcc4c2c 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -179,7 +179,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		changed = ce_match_stat(ce, &st, ce_option);
 		if (!changed) {
 			ce_mark_uptodate(ce);
-			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
+			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER) &&
+			    !DIFF_OPT_TST(&revs->diffopt, FACTORIZE_RENAMES))
 				continue;
 		}
 		oldmode = ce->ce_mode;
@@ -310,7 +311,8 @@ static int show_modified(struct oneway_unpack_data *cbdata,
 
 	oldmode = old->ce_mode;
 	if (mode == oldmode && !hashcmp(sha1, old->sha1) &&
-	    !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
+	    !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER) &&
+	    !DIFF_OPT_TST(&revs->diffopt, FACTORIZE_RENAMES))
 		return 0;
 
 	diff_change(&revs->diffopt, oldmode, mode,
diff --git a/diff.c b/diff.c
index e368fef..f91fcf6 100644
--- a/diff.c
+++ b/diff.c
@@ -2437,6 +2437,11 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_SET(options, REVERSE_DIFF);
 	else if (!strcmp(arg, "--find-copies-harder"))
 		DIFF_OPT_SET(options, FIND_COPIES_HARDER);
+	else if (!strcmp(arg, "--factorize-renames")) {
+		DIFF_OPT_SET(options, FACTORIZE_RENAMES);
+		if (!options->detect_rename)
+			options->detect_rename = DIFF_DETECT_RENAME;
+	}
 	else if (!strcmp(arg, "--follow"))
 		DIFF_OPT_SET(options, FOLLOW_RENAMES);
 	else if (!strcmp(arg, "--color"))
diff --git a/diff.h b/diff.h
index a49d865..db1658b 100644
--- a/diff.h
+++ b/diff.h
@@ -65,6 +65,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_IGNORE_SUBMODULES   (1 << 18)
 #define DIFF_OPT_DIRSTAT_CUMULATIVE  (1 << 19)
 #define DIFF_OPT_DIRSTAT_BY_FILE     (1 << 20)
+#define DIFF_OPT_FACTORIZE_RENAMES   (1 << 21)
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
 #define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
@@ -220,6 +221,8 @@ extern void diffcore_std(struct diff_options *);
 "  -C            detect copies.\n" \
 "  --find-copies-harder\n" \
 "                try unchanged files as candidate for copy detection.\n" \
+"  --factorize-renames\n" \
+"                factorize renames of all files of a directory.\n" \
 "  -l<n>         limit rename attempts up to <n> paths.\n" \
 "  -O<file>      reorder diffs according to the <file>.\n" \
 "  -S<string>    find filepair whose only one side contains the string.\n" \
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 168a95b..ab6149e 100644
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
@@ -262,7 +290,7 @@ static int find_identical_files(struct file_similarity *src,
 			int score;
 			struct diff_filespec *source = p->filespec;
 
-			/* False hash collission? */
+			/* False hash collision? */
 			if (hashcmp(source->sha1, target->sha1))
 				continue;
 			/* Non-regular files? If so, the modes must match! */
@@ -381,8 +409,11 @@ static int find_exact_renames(void)
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
@@ -409,6 +440,223 @@ static void record_if_better(struct diff_score m[], struct diff_score *o)
 		m[worst] = *o;
 }
 
+struct diff_dir_rename {
+	struct diff_filespec *one;
+	struct diff_filespec *two;
+	int discarded;
+	struct diff_dir_rename* next;
+};
+
+/*
+ * Marks as such file_rename if it is made uninteresting by dir_rename.
+ * Returns -1 if the file_rename is outside of the range in which given
+ * renames concerned by dir_rename are to be found (ie. end of loop),
+ * 0 otherwise.
+ */
+static int maybe_mark_uninteresting(struct diff_rename_dst* file_rename,
+				    struct diff_dir_rename* dir_rename,
+				    int one_len, int two_len)
+{
+	if (!file_rename->pair) /* file add */
+		return 0;
+	if (strncmp(file_rename->two->path,
+		    dir_rename->two->path, two_len))
+		return -1;
+	if (strncmp(file_rename->pair->one->path,
+		    dir_rename->one->path, one_len) ||
+	    !basename_same(file_rename->pair->one, file_rename->two) ||
+	    file_rename->pair->score != MAX_SCORE)
+		return 0;
+
+	file_rename->pair->uninteresting_rename = 1;
+	fprintf (stderr, "[DBG] %s* -> %s* makes %s -> %s uninteresting\n",
+		dir_rename->one->path, dir_rename->two->path,
+		file_rename->pair->one->path, file_rename->two->path);
+	return 0;
+}
+
+// FIXME: prevent possible overflow
+/*
+ * Copy dirname of src into dst, suitable to append a filename without
+ * an additional "/".
+ * Only handles relative paths since there is no relative path in a git repo.
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
+ * FIXME: we could optimize the 100%-rename case by preventing
+ * recursion to unfold what we know we would refold here.
+ * FIXME: do we want to replace linked list with sorted array ?
+ * FIXME: this prototype only handles renaming of dirs without
+ * a subdir.
+ * FIXME: leaks like hell.
+ * FIXME: ideas to evaluate a similarity score, anyone ?
+ *  10% * tree similarity + 90% * moved files similarity ?
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
+		struct diff_filespec* one_parent = alloc_filespec(one_parent_path);
+		fill_filespec(one_parent, null_sha1 /*FIXME*/, S_IFDIR);
+
+		struct diff_rename_dst* one_leftover =
+			locate_rename_dst_dir(one_parent);
+		if (one_leftover) { // FIXME: should only be run if !seen
+			/* this might be a dir split, or files added
+			 * after the bulk rename, or just an isolated
+			 * rename */
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
+				fprintf (stderr, "[DBG] leftover file %s in %s\n",
+					 rename_dst[j].two->path, one_parent_path);
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
+				fprintf (stderr, "[DBG] ... not believed to prevent bulk rename\n");
+			}
+			if (!maybe_dir_rename) continue;
+			for (j = two_idx-1; j >= 0; j--) {
+				if (strncmp(rename_dst[j].two->path,
+					    one_parent_path, onep_len))
+					break; // exhausted directory in this direction
+				fprintf (stderr, "[DBG] leftover file %s in %s\n",
+					 rename_dst[j].two->path, one_parent_path);
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
+				fprintf (stderr, "[DBG] ... not believed to prevent bulk rename\n");
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
+			fprintf (stderr, "[DBG] %s -> %s suggests possible rename from %s to %s\n",
+			       rename_dst[i].pair->one->path,
+			       rename_dst[i].pair->two->path,
+			       one_parent_path, two_parent_path);
+			continue;
+		}
+		if (seen->discarded)
+			continue;
+		// check that seen entry matches this rename
+		if (strcmp(two_parent_path, seen->two->path)) {
+			fprintf (stderr, "[DBG] discarding dir split of %s from renames (into %s and %s)\n",
+			       one_parent_path, two_parent_path, seen->two->path);
+			seen->discarded = 1;
+		}
+
+		/* all checks ok, we keep that entry */
+	}
+
+	// turn candidates into real renames
+	struct diff_dir_rename* candidate;
+	for (candidate=factorization_candidates; candidate; candidate = candidate->next) {
+		int two_idx, i, one_len, two_len;
+		if (candidate->discarded)
+			continue;
+
+		// bisect to an entry within candidate dst dir
+		struct diff_rename_dst* two_sample =
+			locate_rename_dst_dir(candidate->two);
+		if (!two_sample) {
+			die ("PANIC: %s candidate of rename not in target tree (from %s)\n",
+			     candidate->two->path, candidate->one->path);
+		}
+		two_idx = two_sample - rename_dst;
+
+		// now remove extraneous 100% files inside.
+		one_len = strlen(candidate->one->path);
+		two_len = strlen(candidate->two->path);
+		for (i = two_idx; i < rename_dst_nr; i++)
+			if (maybe_mark_uninteresting (rename_dst+i, candidate,
+						      one_len, two_len) < 0)
+				break;
+		for (i = two_idx-1; i >= 0; i--)
+			if (maybe_mark_uninteresting (rename_dst+i, candidate,
+						      one_len, two_len) < 0)
+				break;
+	}
+
+	return;
+}
+
 void diffcore_rename(struct diff_options *options)
 {
 	int detect_rename = options->detect_rename;
@@ -446,13 +694,22 @@ void diffcore_rename(struct diff_options *options)
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
+			if (DIFF_OPT_TST(options, FACTORIZE_RENAMES)) {
+				/* similarly, rename factorization needs to
+				 * see all files from second tree, but we don't
+				 * want them to be matched against single sources.
+				 */
+				locate_rename_dst(p->two, 1)->i_am_not_single = 1;
+			}
 		}
 	}
 	if (rename_dst_nr == 0 || rename_src_nr == 0)
@@ -504,6 +761,8 @@ void diffcore_rename(struct diff_options *options)
 
 		if (rename_dst[i].pair)
 			continue; /* dealt with exact match already. */
+		if (rename_dst[i].i_am_not_single)
+			continue; /* not looking for a match. */
 
 		m = &mx[dst_cnt * NUM_CANDIDATE_PER_DST];
 		for (j = 0; j < NUM_CANDIDATE_PER_DST; j++)
@@ -561,8 +820,29 @@ void diffcore_rename(struct diff_options *options)
 	/* At this point, we have found some renames and copies and they
 	 * are recorded in rename_dst.  The original list is still in *q.
 	 */
+
+	/* Now possibly factorize those renames and copies. */
+	if (DIFF_OPT_TST(options, FACTORIZE_RENAMES))
+		diffcore_factorize_renames();
+
 	outq.queue = NULL;
 	outq.nr = outq.alloc = 0;
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
@@ -577,7 +857,8 @@ void diffcore_rename(struct diff_options *options)
 			struct diff_rename_dst *dst =
 				locate_rename_dst(p->two, 0);
 			if (dst && dst->pair) {
-				diff_q(&outq, dst->pair);
+				if (!dst->pair->uninteresting_rename)
+					diff_q(&outq, dst->pair);
 				pair_to_free = p;
 			}
 			else
diff --git a/diffcore.h b/diffcore.h
index 05d0898..ce781ae 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -66,6 +66,7 @@ struct diff_filepair {
 	unsigned broken_pair : 1;
 	unsigned renamed_pair : 1;
 	unsigned is_unmerged : 1;
+	unsigned uninteresting_rename : 1;
 };
 #define DIFF_PAIR_UNMERGED(p) ((p)->is_unmerged)
 
diff --git a/tree-diff.c b/tree-diff.c
index 9f67af6..872f757 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -49,7 +49,9 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
 		show_entry(opt, "+", t2, base, baselen);
 		return 1;
 	}
-	if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER) && !hashcmp(sha1, sha2) && mode1 == mode2)
+	if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER) &&
+	    !DIFF_OPT_TST(opt, FACTORIZE_RENAMES) &&
+	    !hashcmp(sha1, sha2) && mode1 == mode2)
 		return 0;
 
 	/*
