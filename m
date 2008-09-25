From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Introduce patch factorization in diffcore.
Date: Thu, 25 Sep 2008 23:47:07 +0200
Message-ID: <20080925214707.27029.36260.stgit@gandelf.nowhere.earth>
References: <20080925213819.27029.47944.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 23:46:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kiyfc-0003Zt-GK
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 23:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbYIYVp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 17:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753773AbYIYVp2
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 17:45:28 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:58579 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753866AbYIYVp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 17:45:27 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 9EC4017B597
	for <git@vger.kernel.org>; Thu, 25 Sep 2008 23:45:25 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 4F90217B53F
	for <git@vger.kernel.org>; Thu, 25 Sep 2008 23:45:25 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id C69CD1F0C1
	for <git@vger.kernel.org>; Thu, 25 Sep 2008 23:47:07 +0200 (CEST)
In-Reply-To: <20080925213819.27029.47944.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96808>


---

 diff-lib.c        |    6 +-
 diff.c            |    5 +
 diff.h            |    3 +
 diffcore-rename.c |  194 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 diffcore.h        |    1 
 tree-diff.c       |    4 +
 6 files changed, 202 insertions(+), 11 deletions(-)

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
index 9053d4d..2315980 100644
--- a/diff.c
+++ b/diff.c
@@ -2599,6 +2599,11 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
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
index 1ca4f46..7b862c6 100644
--- a/diff.h
+++ b/diff.h
@@ -64,6 +64,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_RELATIVE_NAME       (1 << 17)
 #define DIFF_OPT_IGNORE_SUBMODULES   (1 << 18)
 #define DIFF_OPT_DIRSTAT_CUMULATIVE  (1 << 19)
+#define DIFF_OPT_FACTORIZE_RENAMES   (1 << 20)
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
 #define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
@@ -219,6 +220,8 @@ extern void diffcore_std(struct diff_options *);
 "  -C            detect copies.\n" \
 "  --find-copies-harder\n" \
 "                try unchanged files as candidate for copy detection.\n" \
+"  --factorize_renames\n" \
+"                factorize renames of all files of a directory.\n" \
 "  -l<n>         limit rename attempts up to <n> paths.\n" \
 "  -O<file>      reorder diffs according to the <file>.\n" \
 "  -S<string>    find filepair whose only one side contains the string.\n" \
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 1b2ebb4..2757204 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -6,6 +6,8 @@
 #include "diffcore.h"
 #include "hash.h"
 
+#include <libgen.h>
+
 /* Table of rename/copy destinations */
 
 static struct diff_rename_dst {
@@ -52,6 +54,32 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
 	return &(rename_dst[first]);
 }
 
+static struct diff_rename_dst *locate_rename_dst_dir(struct diff_filespec *dir)
+{
+	/* code mostly duplicated from locate_rename_dst - not sure we
+	 * could merge them efficiently,though
+	 */
+	int first, last;
+	int dirlength = strlen(dir->path);
+
+	first = 0;
+	last = rename_dst_nr;
+	while (last > first) {
+		int next = (last + first) >> 1;
+		struct diff_rename_dst *dst = &(rename_dst[next]);
+		int cmp = strncmp(dir->path, dst->two->path, dirlength);
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
@@ -409,6 +437,130 @@ static void record_if_better(struct diff_score m[], struct diff_score *o)
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
+				    int one_len, int two_len) {
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
+	printf ("[DBG] %s* -> %s* makes %s -> %s uninteresting\n",
+		dir_rename->one->path, dir_rename->two->path,
+		file_rename->pair->one->path, file_rename->two->path);
+	return 0;
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
+	char buffer[PATH_MAX], one_parent_path[PATH_MAX], two_parent_path[PATH_MAX];
+	int i;
+
+	for (i = 0; i < rename_dst_nr; i++) {
+		if (!rename_dst[i].pair)
+			continue;
+		strcpy(buffer, rename_dst[i].pair->one->path);
+		strcpy(one_parent_path, dirname(buffer));
+		strcat(one_parent_path, "/");
+
+		struct diff_filespec* one_parent = alloc_filespec(one_parent_path);
+		fill_filespec(one_parent, null_sha1 /*FIXME*/, S_IFDIR);
+
+		if (!locate_rename_dst_dir(one_parent)) {
+			// one_parent_path is empty in result tree
+
+			// already considered ?
+			struct diff_dir_rename* seen;
+			for (seen=factorization_candidates; seen; seen = seen->next)
+				if (!strcmp(seen->one->path, one_parent_path)) break;
+			if (!seen) {
+				// record potential dir rename
+				strcpy(buffer, rename_dst[i].pair->two->path);
+				strcpy(two_parent_path, dirname(buffer));
+				strcat(two_parent_path, "/");
+
+				seen = xmalloc(sizeof(*seen));
+				seen->one = one_parent;
+				seen->two = alloc_filespec(two_parent_path);
+				fill_filespec(seen->two, null_sha1 /*FIXME*/, S_IFDIR);
+				seen->discarded = 0;
+				seen->next = factorization_candidates;
+				factorization_candidates = seen;
+				printf("[DBG] possible rename from %s to %s\n",
+				       one_parent_path, two_parent_path);
+				continue;
+			}
+			if (seen->discarded)
+				continue;
+			// check that seen entry matches this rename
+			strcpy(buffer, rename_dst[i].pair->two->path);
+			strcpy(two_parent_path, dirname(buffer));
+			strcat(two_parent_path, "/");
+			if (strcmp(two_parent_path, seen->two->path)) {
+				printf("[DBG] discarding dir rename of %s, mixing %s and %s\n",
+				       one_parent_path, two_parent_path, seen->two->path);
+				seen->discarded = 1;
+			}
+
+			/* all checks ok, we keep that entry */
+		}
+	}
+
+	// turn candidates into real renames
+	struct diff_dir_rename* candidate;
+	for (candidate=factorization_candidates; candidate; candidate = candidate->next) {
+		int two_idx, i, one_len, two_len;
+		if (candidate->discarded)
+			continue;
+
+		// any entry within candidate dst dir
+		two_idx = locate_rename_dst_dir(candidate->two) - rename_dst;
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
@@ -446,13 +598,22 @@ void diffcore_rename(struct diff_options *options)
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
+				 * see all files from second tree
+				 */
+				//p->two->rename_used++; // FIXME: would we need that ?
+				locate_rename_dst(p->two, 1);
+			}
 		}
 	}
 	if (rename_dst_nr == 0 || rename_src_nr == 0)
@@ -561,8 +722,24 @@ void diffcore_rename(struct diff_options *options)
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
+	// first, turn factorization_candidates into real renames
+	struct diff_dir_rename* candidate;
+	for (candidate=factorization_candidates; candidate; candidate = candidate->next) {
+		struct diff_filepair* pair;
+		if (candidate->discarded) continue;
+		pair = diff_queue(&outq, candidate->one, candidate->two);
+		pair->score = MAX_SCORE;
+		pair->renamed_pair = 1;
+	}
+
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		struct diff_filepair *pair_to_free = NULL;
@@ -577,7 +754,8 @@ void diffcore_rename(struct diff_options *options)
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
index 8ae3578..e4aa099 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -62,6 +62,7 @@ struct diff_filepair {
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
