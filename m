From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v8 5/5] [WIP] Allow hiding renames of individual files involved in a directory rename.
Date: Fri, 29 Oct 2010 00:08:32 +0200
Message-ID: <1288303712-14662-6-git-send-email-ydirson@altern.org>
References: <1288303712-14662-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>, Yann Dirson <ydirson@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 29 00:09:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBaez-0002AX-DV
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 00:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759768Ab0J1WI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 18:08:56 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:60553 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521Ab0J1WIy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 18:08:54 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id EB96BD48085;
	Fri, 29 Oct 2010 00:08:46 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PBaeJ-0003pI-JX; Fri, 29 Oct 2010 00:08:43 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1288303712-14662-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160235>

Once has identified groups of bulk-moved files, and then
the --hide-bulk-move-details flag hides those of the individual renames
which carry no other information (further name change, or content changes).

This makes it much easier to a human reader to spot content changes
in a commit that also moves a whole subtree.

Signed-off-by: Yann Dirson <ydirson@free.fr>
---
 Documentation/diff-options.txt |    5 +++
 diff.c                         |    7 ++++
 diff.h                         |    3 ++
 diffcore-rename.c              |   68 ++++++++++++++++++++++++++++++++++++++--
 diffcore.h                     |    1 +
 5 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 887df4b..f9a2f4e 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -249,6 +249,11 @@ endif::git-log[]
 	Detect bulk move of all files of a directory into a
 	different one.
 
+--hide-bulk-move-details::
+	Hide the individual files moves that make up a bulk move,
+	without hinding other changes to the involved files (contents
+	change, name change relative to the bulk move's destination).
+
 -C[<n>]::
 --detect-copies[=<n>]::
 	Detect copies as well as renames.  See also `--find-copies-harder`.
diff --git a/diff.c b/diff.c
index ab2e201..b920f2e 100644
--- a/diff.c
+++ b/diff.c
@@ -3221,6 +3221,13 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		if (!options->detect_rename)
 			options->detect_rename = DIFF_DETECT_RENAME;
 	}
+	else if (!strcmp(arg, "--hide-bulk-move-details")) {
+		DIFF_OPT_SET(options, HIDE_DIR_RENAME_DETAILS);
+		if (!DIFF_OPT_TST(options, DETECT_BULK_MOVES))
+			DIFF_OPT_SET(options, DETECT_BULK_MOVES);
+		if (!options->detect_rename)
+			options->detect_rename = DIFF_DETECT_RENAME;
+	}
 	else if (!strcmp(arg, "--follow"))
 		DIFF_OPT_SET(options, FOLLOW_RENAMES);
 	else if (!strcmp(arg, "--color"))
diff --git a/diff.h b/diff.h
index 1e2506c..f28fed5 100644
--- a/diff.h
+++ b/diff.h
@@ -79,6 +79,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_IGNORE_DIRTY_SUBMODULES (1 << 26)
 #define DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG (1 << 27)
 #define DIFF_OPT_DETECT_BULK_MOVES  (1 << 28)
+#define DIFF_OPT_HIDE_DIR_RENAME_DETAILS (1 << 29)
 
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
@@ -268,6 +269,8 @@ extern void diffcore_fix_diff_index(struct diff_options *);
 "                try unchanged files as candidate for copy detection.\n" \
 "  --detect-bulk-moves\n" \
 "                detect moves of all files of a single directory.\n" \
+"  --hide-bulk-move-details\n" \
+"                hide individual files moves in a bulk move.\n" \
 "  -l<n>         limit rename attempts up to <n> paths.\n" \
 "  -O<file>      reorder diffs according to the <file>.\n" \
 "  -S<string>    find filepair whose only one side contains the string.\n" \
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 6afc662..940cb7d 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -519,6 +519,34 @@ static struct diff_bulk_rename *locate_bulkmove_candidate(const char *one_path,
 }
 
 /*
+ * Marks as such file_rename if it is made uninteresting by dir_rename.
+ * Returns -1 if the file_rename is outside of the range in which given
+ * renames concerned by dir_rename are to be found (ie. end of loop),
+ * 0 otherwise.
+ */
+static int maybe_mark_uninteresting(struct diff_rename_dst *file_rename,
+				    struct diff_bulk_rename *dir_rename,
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
+	debug_bulkmove(("%s* -> %s* makes %s -> %s uninteresting\n",
+			dir_rename->one->path, dir_rename->two->path,
+			file_rename->pair->one->path, file_rename->two->path));
+	return 0;
+}
+
+/*
  * Copy dirname of src into dst, suitable to append a filename without
  * an additional "/".
  * Only handles relative paths since there is no absolute path in a git repo.
@@ -721,11 +749,44 @@ static void check_one_bulk_move(struct diff_filepair *dstpair)
  * Take all file renames recorded so far and check if they could cause
  * a bulk move to be detected.
  */
-static void diffcore_bulk_moves(void)
+static void diffcore_bulk_moves(int opt_hide_renames)
 {
 	int i;
 	for (i = 0; i < rename_dst_nr; i++)
 		check_one_bulk_move(rename_dst[i].pair);
+
+	if (opt_hide_renames) {
+		/* flag as "uninteresting" those candidates hidden by dir move */
+		struct diff_bulk_rename *candidate;
+		for (candidate = bulkmove_candidates;
+		     candidate < bulkmove_candidates + bulkmove_candidates_nr;
+		     candidate++) {
+			int two_idx, i, one_len, two_len;
+			struct diff_rename_dst *two_sample;
+			if (candidate->discarded)
+				continue;
+
+			/* bisect to any entry within candidate dst dir */
+			two_sample = locate_rename_dst_dir(candidate->two->path);
+			if (!two_sample) {
+				die("PANIC: %s candidate of rename not in target tree (from %s)\n",
+				    candidate->two->path, candidate->one->path);
+			}
+			two_idx = two_sample - rename_dst;
+
+			/* now remove extraneous 100% files inside. */
+			one_len = strlen(candidate->one->path);
+			two_len = strlen(candidate->two->path);
+			for (i = two_idx; i < rename_dst_nr; i++)
+				if (maybe_mark_uninteresting(rename_dst+i, candidate,
+							     one_len, two_len) < 0)
+					break;
+			for (i = two_idx-1; i >= 0; i--)
+				if (maybe_mark_uninteresting(rename_dst+i, candidate,
+							     one_len, two_len) < 0)
+					break;
+		}
+	}
 }
 
 void diffcore_rename(struct diff_options *options)
@@ -897,7 +958,7 @@ void diffcore_rename(struct diff_options *options)
 
 	/* Now possibly factorize those renames and copies. */
 	if (DIFF_OPT_TST(options, DETECT_BULK_MOVES))
-		diffcore_bulk_moves();
+		diffcore_bulk_moves(DIFF_OPT_TST(options, HIDE_DIR_RENAME_DETAILS));
 
 	DIFF_QUEUE_CLEAR(&outq);
 
@@ -932,7 +993,8 @@ void diffcore_rename(struct diff_options *options)
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
index 6dab95b..a4eb8e1 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -69,6 +69,7 @@ struct diff_filepair {
 	unsigned broken_pair : 1;
 	unsigned renamed_pair : 1;
 	unsigned is_unmerged : 1;
+	unsigned uninteresting_rename : 1;
 	unsigned is_bulkmove : 1;
 };
 #define DIFF_PAIR_UNMERGED(p) ((p)->is_unmerged)
-- 
1.7.2.3
