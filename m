Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C46421F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 22:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754599AbdKJWWO (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 17:22:14 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:50372 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754511AbdKJWWF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 17:22:05 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAMCd8O030107;
        Fri, 10 Nov 2017 14:22:04 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e535n1nd9-1;
        Fri, 10 Nov 2017 14:22:03 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id E2DBF22F94DC;
        Fri, 10 Nov 2017 14:22:03 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id D9C4A2CDE6A;
        Fri, 10 Nov 2017 14:22:03 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 8/9] merge-recursive: Accelerate rename detection
Date:   Fri, 10 Nov 2017 14:21:55 -0800
Message-Id: <20171110222156.23221-9-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.46.g41dca04efb
In-Reply-To: <20171110222156.23221-1-newren@gmail.com>
References: <20171110222156.23221-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100306
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a file is unmodified on one side of history (no content changes, no
name change, and no mode change) and is renamed on the other side, then
the correct merge result is to take both the file name and the file
contents (and file mode) of the renamed file.  merge-recursive detects
this rename and gets the correct merge result.

Note that if no rename detection is done, then this will appear to the
merge machinery as two files: one that was unmodified on one side of
history and deleted on the other (thus the merge should delete it), and
one which was newly added on one side of history (thus the merge should
include it).  Thus, even if the rename wasn't detected, we still would
have ended up with the correct result.

In other words, rename detection is a waste of time for files that were
unmodified on the OTHER side of history.  We can accelerate rename
detection for merges by providing information about the other side of
history, which will allow us to remove all such rename sources from the
list of candidates we care about.

There are two gotchas:

  1) Not trying to detect renames for these types of files can result in
     rename/add conflicts being instead detected as add/add conflicts,
     and can result in rename/rename(2to1) conflicts being instead
     detected as either rename/add or add/add conflicts.  Luckily for
     us, these three types of conflicts happen to make the same changes
     to the index and working tree (what a coincidence...), so this
     isn't a significant issue; the only annoyance is that the stdout
     from the merge command will include a "CONFLICT($type)" message for
     a related conflict type instead of the precise conflict type.

  2) If there is a directory rename on one side of history AND all files
     within the directory are not merely renamed but are modified as
     well AND none of the original files in the directory are modified
     on the other side of history AND there are new files added (or
     moved into) to the original directory on that other side of
     history, then this change will prevent us from being able to detect
     that directory rename and placing the new file(s) into the
     appropriate directory.  A subsequent commit will correct this
     downside.

In one particular testcase involving a large repository and some
high-level directories having been renamed, this cut the time necessary
for a cherry-pick down by a factor of about 8 (from around 4.5 minutes
down to around 34 seconds)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c            |  1 +
 diff.h            |  3 +++
 diffcore-rename.c | 43 ++++++++++++++++++++++++++++++++++++++-
 merge-recursive.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index c6597e3231..83723ab26d 100644
--- a/diff.c
+++ b/diff.c
@@ -4173,6 +4173,7 @@ void diff_setup(struct diff_options *options)
 	}
 
 	options->color_moved = diff_color_moved_default;
+	options->ignore_for_renames = NULL;
 }
 
 void diff_setup_done(struct diff_options *options)
diff --git a/diff.h b/diff.h
index adf7e92eb5..1288f36fd2 100644
--- a/diff.h
+++ b/diff.h
@@ -196,6 +196,9 @@ struct diff_options {
 	} color_moved;
 	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
 	#define COLOR_MOVED_MIN_ALNUM_COUNT 20
+
+	/* Paths we should ignore for rename purposes */
+	struct string_list *ignore_for_renames;
 };
 
 void diff_emit_submodule_del(struct diff_options *o, const char *line);
diff --git a/diffcore-rename.c b/diffcore-rename.c
index b15d9d74ef..aa8e0e4d4a 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -437,6 +437,40 @@ static int find_renames(struct diff_score *mx, int dst_cnt, int minimum_score, i
 	return count;
 }
 
+static int handle_rename_ignores(struct diff_options *options)
+{
+	int detect_rename = options->detect_rename;
+	struct string_list *ignores = options->ignore_for_renames;
+	int ignored = 0;
+	int i, j;
+
+	/* rename_ignores onlhy relevant when we're not detecting copies */
+	if (ignores == NULL || detect_rename == DIFF_DETECT_COPY)
+		return 0;
+
+	for (i = 0, j = 0; i < ignores->nr && j < rename_src_nr;) {
+		struct diff_filespec *one = rename_src[j].p->one;
+		int cmp;
+
+		if (one->rename_used) {
+			j++;
+			continue;
+		}
+
+		cmp = strcmp(ignores->items[i].string, one->path);
+		if (cmp < 0)
+			i++;
+		else if (cmp > 0)
+			j++;
+		else {
+			one->rename_used++;
+			ignored++;
+		}
+	}
+
+	return ignored;
+}
+
 void diffcore_rename(struct diff_options *options)
 {
 	int detect_rename = options->detect_rename;
@@ -445,7 +479,7 @@ void diffcore_rename(struct diff_options *options)
 	struct diff_queue_struct outq;
 	struct diff_score *mx;
 	int i, j, rename_count, skip_unmodified = 0;
-	int num_create, dst_cnt, num_src;
+	int num_create, dst_cnt, num_src, ignore_count;
 	struct progress *progress = NULL;
 
 	if (!minimum_score)
@@ -506,6 +540,12 @@ void diffcore_rename(struct diff_options *options)
 	if (minimum_score == MAX_SCORE)
 		goto cleanup;
 
+	/*
+	 * Mark source files as used if they are found in the
+	 * ignore_for_renames list.
+	 */
+	ignore_count = handle_rename_ignores(options);
+
 	/*
 	 * Calculate how many renames are left (but all the source
 	 * files still remain as options for rename/copies!)
@@ -513,6 +553,7 @@ void diffcore_rename(struct diff_options *options)
 	num_create = (rename_dst_nr - rename_count);
 	num_src = (detect_rename == DIFF_DETECT_COPY ?
 		   rename_src_nr : rename_src_nr - rename_count);
+	num_src -= ignore_count;
 
 	/* All done? */
 	if (!num_create)
diff --git a/merge-recursive.c b/merge-recursive.c
index 7bc9a2ac80..7dceaf5e9f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -487,6 +487,50 @@ static struct string_list *get_unmerged(void)
 	return unmerged;
 }
 
+static struct string_list *get_rename_ignore(struct string_list *unmerged)
+{
+	/*
+	 * If a file is unmodified on one side of history (no content
+	 * changes, no mode change, and no name change) and is renamed on
+	 * the other side, then the correct merge result is to take both
+	 * the file name and the file contents (and file mode) of the
+	 * renamed file.  merge-recursive detects this rename and gets the
+	 * correct merge result.
+	 *
+	 * Note that if no rename detection is done, then this will appear
+	 * to the merge machinery as two files: one that was unmodified on
+	 * one side of history and deleted on the other (thus the merge
+	 * should delete it), and one which was newly added on one side of
+	 * history (thus the merge should include it).  Thus, even if the
+	 * rename wasn't detected, we still would have ended up with the
+	 * correct result.
+	 *
+	 * In other words, rename detection is a waste of time for files
+	 * that were unmodified on the OTHER side of history.  We can
+	 * accelerate rename detection for merges by find these sets of
+	 * unmodified files, and feeding them to get_renames so it can
+	 * omit using those files as rename sources.
+	 */
+	struct string_list *rename_ignore;
+	int i;
+
+	rename_ignore = xcalloc(1, sizeof(struct string_list));
+	for (i = 0; i < unmerged->nr; i++) {
+		const char *path = unmerged->items[i].string;
+		struct stage_data *e = unmerged->items[i].util;
+		unsigned ign_head = is_null_oid(&e->stages[2].oid) &&
+		  oid_eq(&e->stages[1].oid, &e->stages[3].oid) &&
+		  e->stages[1].mode == e->stages[3].mode;
+		unsigned ign_merge = is_null_oid(&e->stages[3].oid) &&
+		  oid_eq(&e->stages[1].oid, &e->stages[2].oid) &&
+		  e->stages[1].mode == e->stages[2].mode;
+		if (ign_head || ign_merge)
+			string_list_append(rename_ignore, path);
+	}
+	return rename_ignore;
+}
+
+
 static int string_list_df_name_compare(const char *one, const char *two)
 {
 	int onelen = strlen(one);
@@ -1605,7 +1649,8 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
  */
 static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
 					       struct tree *o_tree,
-					       struct tree *tree)
+					       struct tree *tree,
+					       struct string_list *rename_ignore)
 {
 	struct diff_queue_struct *ret;
 	struct diff_options opts;
@@ -1614,6 +1659,7 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
 	DIFF_OPT_SET(&opts, RECURSIVE);
 	DIFF_OPT_CLR(&opts, RENAME_EMPTY);
 	opts.detect_rename = DIFF_DETECT_RENAME;
+	opts.ignore_for_renames = rename_ignore;
 	opts.rename_limit = o->merge_rename_limit >= 0 ? o->merge_rename_limit :
 			    o->diff_rename_limit >= 0 ? o->diff_rename_limit :
 			    1000;
@@ -2578,6 +2624,7 @@ static struct rename_info *handle_renames(struct merge_options *o,
 					  struct tree *head,
 					  struct tree *merge,
 					  struct string_list *entries,
+					  struct string_list *rename_ignore,
 					  int *clean)
 {
 	struct rename_info *rei = xcalloc(1, sizeof(struct rename_info));
@@ -2590,8 +2637,8 @@ static struct rename_info *handle_renames(struct merge_options *o,
 	if (!o->detect_rename)
 		return NULL;
 
-	head_pairs = get_diffpairs(o, common, head);
-	merge_pairs = get_diffpairs(o, common, merge);
+	head_pairs = get_diffpairs(o, common, head, rename_ignore);
+	merge_pairs = get_diffpairs(o, common, merge, rename_ignore);
 
 	dir_re_head = get_directory_renames(head_pairs, head);
 	dir_re_merge = get_directory_renames(merge_pairs, merge);
@@ -3090,7 +3137,7 @@ int merge_trees(struct merge_options *o,
 	}
 
 	if (unmerged_cache()) {
-		struct string_list *entries;
+		struct string_list *entries, *rename_ignore;
 		struct rename_info *re_info;
 		int i;
 		/*
@@ -3105,7 +3152,9 @@ int merge_trees(struct merge_options *o,
 		get_files_dirs(o, merge);
 
 		entries = get_unmerged();
-		re_info = handle_renames(o, common, head, merge, entries, &clean);
+		rename_ignore = get_rename_ignore(entries);
+		re_info = handle_renames(o, common, head, merge, entries,
+					 rename_ignore, &clean);
 		record_df_conflict_files(o, entries);
 		if (clean < 0)
 			goto cleanup;
@@ -3131,7 +3180,7 @@ int merge_trees(struct merge_options *o,
 
 cleanup:
 		cleanup_renames(re_info);
-
+		string_list_clear(rename_ignore, 0);
 		string_list_clear(entries, 1);
 		free(entries);
 
-- 
2.15.0.46.g41dca04efb

