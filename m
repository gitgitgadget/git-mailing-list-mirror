From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v4 3/4] Allow hiding renames of individual files involved in a directory rename.
Date: Sun,  3 Oct 2010 22:42:08 +0200
Message-ID: <1286138529-6780-4-git-send-email-ydirson@altern.org>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
 <1286138529-6780-2-git-send-email-ydirson@altern.org>
 <1286138529-6780-3-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 22:32:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2VEh-000189-1V
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 22:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037Ab0JCUcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 16:32:32 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:32889 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754980Ab0JCUca (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 16:32:30 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 5A7D1D48132;
	Sun,  3 Oct 2010 22:32:24 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P2VNu-0001qW-8U; Sun, 03 Oct 2010 22:42:14 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286138529-6780-3-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157918>

From: Yann Dirson <ydirson@free.fr>

Once --detect-dir-renames has identified groups of bulk-moved files, and then
the --hide-dir-rename-details flag hides those of the individual renames
which carry no other information (further name change, or content changes).

This makes it much easier to a human reader to spot content changes
in a commit that also moves a whole subtree.
---
 diff.c            |    7 +++++
 diff.h            |    3 ++
 diffcore-rename.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 diffcore.h        |    1 +
 4 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 47ef7ea..2731c33 100644
--- a/diff.c
+++ b/diff.c
@@ -3193,6 +3193,13 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		if (!options->detect_rename)
 			options->detect_rename = DIFF_DETECT_RENAME;
 	}
+	else if (!strcmp(arg, "--hide-dir-rename-details")) {
+		DIFF_OPT_SET(options, HIDE_DIR_RENAME_DETAILS);
+		if (!DIFF_OPT_TST(options, DETECT_DIR_RENAMES))
+			DIFF_OPT_SET(options, DETECT_DIR_RENAMES);
+		if (!options->detect_rename)
+			options->detect_rename = DIFF_DETECT_RENAME;
+	}
 	else if (!strcmp(arg, "--follow"))
 		DIFF_OPT_SET(options, FOLLOW_RENAMES);
 	else if (!strcmp(arg, "--color"))
diff --git a/diff.h b/diff.h
index 40c548d..ae1e2e7 100644
--- a/diff.h
+++ b/diff.h
@@ -79,6 +79,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_IGNORE_DIRTY_SUBMODULES (1 << 26)
 #define DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG (1 << 27)
 #define DIFF_OPT_DETECT_DIR_RENAMES  (1 << 28)
+#define DIFF_OPT_HIDE_DIR_RENAME_DETAILS (1 << 29)
 
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
@@ -268,6 +269,8 @@ extern void diffcore_fix_diff_index(struct diff_options *);
 "                try unchanged files as candidate for copy detection.\n" \
 "  --detect-dir-renames\n" \
 "                detect wholesale directory renames.\n" \
+"  --hide-dir-rename-details\n" \
+"                hide renames of individual files in a directory rename.\n" \
 "  -l<n>         limit rename attempts up to <n> paths.\n" \
 "  -O<file>      reorder diffs according to the <file>.\n" \
 "  -S<string>    find filepair whose only one side contains the string.\n" \
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 06a8b6c..89e0b53 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -452,6 +452,34 @@ struct diff_dir_rename {
 	struct diff_dir_rename* next;
 };
 
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
 // FIXME: prevent possible overflow
 /*
  * Copy dirname of src into dst, suitable to append a filename without
@@ -497,7 +525,7 @@ static const char* copy_dirname(char* dst, const char* src)
  * FIXME: ideas to consider under-threshold moves as part of bulk move ?
  */
 static struct diff_dir_rename* factorization_candidates = NULL;
-static void diffcore_factorize_renames(void)
+static void diffcore_factorize_renames(int opt_hide_renames)
 {
 	char one_parent_path[PATH_MAX], two_parent_path[PATH_MAX];
 	int i;
@@ -616,6 +644,38 @@ static void diffcore_factorize_renames(void)
 		/* all checks ok, we keep that entry */
 	}
 
+	if (opt_hide_renames) {
+		// flag as "uninteresting" those candidates hidden by dir move
+		struct diff_dir_rename* candidate;
+		for (candidate=factorization_candidates;
+		     candidate; candidate = candidate->next) {
+			int two_idx, i, one_len, two_len;
+			if (candidate->discarded)
+				continue;
+
+			// bisect to any entry within candidate dst dir
+			struct diff_rename_dst* two_sample =
+				locate_rename_dst_dir(candidate->two);
+			if (!two_sample) {
+				die ("PANIC: %s candidate of rename not in target tree (from %s)\n",
+				     candidate->two->path, candidate->one->path);
+			}
+			two_idx = two_sample - rename_dst;
+
+			// now remove extraneous 100% files inside.
+			one_len = strlen(candidate->one->path);
+			two_len = strlen(candidate->two->path);
+			for (i = two_idx; i < rename_dst_nr; i++)
+				if (maybe_mark_uninteresting (rename_dst+i, candidate,
+							      one_len, two_len) < 0)
+					break;
+			for (i = two_idx-1; i >= 0; i--)
+				if (maybe_mark_uninteresting (rename_dst+i, candidate,
+							      one_len, two_len) < 0)
+					break;
+		}
+	}
+
 	return;
 }
 
@@ -788,7 +848,7 @@ void diffcore_rename(struct diff_options *options)
 
 	/* Now possibly factorize those renames and copies. */
 	if (DIFF_OPT_TST(options, DETECT_DIR_RENAMES))
-		diffcore_factorize_renames();
+		diffcore_factorize_renames(DIFF_OPT_TST(options, HIDE_DIR_RENAME_DETAILS));
 
 	DIFF_QUEUE_CLEAR(&outq);
 
@@ -821,7 +881,8 @@ void diffcore_rename(struct diff_options *options)
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
index b8f1fde..beee596 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -69,6 +69,7 @@ struct diff_filepair {
 	unsigned broken_pair : 1;
 	unsigned renamed_pair : 1;
 	unsigned is_unmerged : 1;
+	unsigned uninteresting_rename : 1;
 };
 #define DIFF_PAIR_UNMERGED(p) ((p)->is_unmerged)
 
-- 
1.7.2.3
