Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B10541F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 19:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753881AbdKJTGJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 14:06:09 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:48756 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753766AbdKJTGD (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 14:06:03 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAJ4HD0002784;
        Fri, 10 Nov 2017 11:06:01 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e53631bgr-4;
        Fri, 10 Nov 2017 11:06:01 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 4C2A622F6280;
        Fri, 10 Nov 2017 11:06:01 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 44BB42CDEE6;
        Fri, 10 Nov 2017 11:06:01 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 25/30] merge-recursive: Check for file level conflicts then get new name
Date:   Fri, 10 Nov 2017 11:05:45 -0800
Message-Id: <20171110190550.27059-26-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.5.g9567be9905
In-Reply-To: <20171110190550.27059-1-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100261
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before trying to apply directory renames to paths within the given
directories, we want to make sure that there aren't conflicts at the
file level either.  If there aren't any, then get the new name from
any directory renames.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 184 ++++++++++++++++++++++++++++++++++--
 t/t6043-merge-rename-directories.sh |   2 +-
 2 files changed, 176 insertions(+), 10 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 251c4cc7fa..7c2c29bb51 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1481,6 +1481,102 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 	}
 }
 
+/*
+ * Write:
+ *   element1, element2, element3, ..., elementN
+ * to str.  If only one element, just write "element1" to str.
+ */
+static void comma_separated_list(char *str, struct string_list *slist) {
+	int i;
+	for (i=0; i<slist->nr; i++) {
+		str += sprintf(str, "%s", slist->items[i].string);
+		if (i < slist->nr-1)
+			str += sprintf(str, ", ");
+	}
+}
+
+/*
+ * See if there is a directory rename for path, and if there are any file
+ * level conflicts for the renamed location.  If there is a rename and
+ * there are no conflicts, return the new name.  Otherwise, return NULL.
+ */
+static char* handle_path_level_conflicts(struct merge_options *o,
+					 const char *path,
+					 struct dir_rename_entry *entry,
+					 struct hashmap *collisions,
+					 struct tree *tree)
+{
+	char *new_path = NULL;
+	struct collision_entry *collision_ent;
+	int clean = 1;
+
+	/*
+	 * entry has the mapping of old directory name to new directory name
+	 * that we want to apply to path.
+	 */
+	new_path = apply_dir_rename(entry, path);
+
+	if (!new_path) {
+		/* This should only happen when entry->non_unique_new_dir set */
+		assert(entry->non_unique_new_dir);
+		output(o, 1, _("CONFLICT (directory rename split): "
+			       "Unclear where to place %s because directory "
+			       "%s was renamed to multiple other directories, "
+			       "with no destination getting a majority of the "
+			       "files."),
+		       path, entry->dir);
+		clean = 0;
+		return NULL;
+	}
+
+	/*
+	 * The caller needs to have ensured that it has pre-populated
+	 * collisions with all paths that map to new_path.  Do a quick check
+	 * to ensure that's the case.
+	  */
+	collision_ent = collision_find_entry(collisions, new_path);
+	assert(collision_ent != NULL);
+
+	/*
+	 * Check for one-sided add/add/.../add conflicts, i.e.
+	 * where implicit renames from the other side doing
+	 * directory rename(s) can affect this side of history
+	 * to put multiple paths into the same location.  Warn
+	 * and bail on directory renames for such paths.
+	 */
+	char collision_paths[(PATH_MAX+2) * collision_ent->source_files.nr];
+	if (collision_ent->reported_already) {
+		clean = 0;
+	} else if (tree_has_path(tree, new_path)) {
+		collision_ent->reported_already = 1;
+		comma_separated_list(collision_paths,
+				     &collision_ent->source_files);
+		output(o, 1, _("CONFLICT (implicit dir rename): Existing "
+			       "file/dir at %s in the way of implicit "
+			       "directory rename(s) putting the following "
+			       "path(s) there: %s."),
+		       new_path, collision_paths);
+		clean = 0;
+	} else if (collision_ent->source_files.nr > 1) {
+		collision_ent->reported_already = 1;
+		comma_separated_list(collision_paths,
+				     &collision_ent->source_files);
+		output(o, 1, _("CONFLICT (implicit dir rename): Cannot map "
+			       "more than one path to %s; implicit directory "
+			       "renames tried to put these paths there: %s"),
+		       new_path, collision_paths);
+		clean = 0;
+	}
+
+	/* Free memory we no longer need */
+	if (!clean && new_path) {
+		free(new_path);
+		return NULL;
+	}
+
+	return new_path;
+}
+
 /*
  * There are a couple things we want to do at the directory level:
  *   1. Check for both sides renaming to the same thing, in order to avoid
@@ -1725,6 +1821,58 @@ static void compute_collisions(struct hashmap *collisions,
 	}
 }
 
+static char *check_for_directory_rename(struct merge_options *o,
+					const char *path,
+					struct tree *tree,
+					struct hashmap *dir_renames,
+					struct hashmap *dir_rename_exclusions,
+					struct hashmap *collisions,
+					int *clean_merge)
+{
+	char *new_path = NULL;
+	struct dir_rename_entry *entry = check_dir_renamed(path, dir_renames);
+	if (!entry)
+		return new_path;
+
+	/*
+	 * This next part is a little weird.  We do not want to do an
+	 * implicit rename into a directory we renamed on our side, because
+	 * that will result in a spurious rename/rename(1to2) conflict.  An
+	 * example:
+	 *   Base commit: dumbdir/afile, otherdir/bfile
+	 *   Side 1:      smrtdir/afile, otherdir/bfile
+	 *   Side 2:      dumbdir/afile, dumbdir/bfile
+	 * Here, while working on Side 1, we could notice that otherdir was
+	 * renamed/merged to dumbdir, and change the diff_filepair for
+	 * otherdir/bfile into a rename into dumbdir/bfile.  However, Side
+	 * 2 will notice the rename from dumbdir to smrtdir, and do the
+	 * transitive rename to move it from dumbdir/bfile to
+	 * smrtdir/bfile.  That gives us bfile in dumbdir vs being in
+	 * smrtdir, a rename/rename(1to2) conflict.  We really just want
+	 * the file to end up in smrtdir.  And the way to achieve that is
+	 * to not let Side1 do the rename to dumbdir, since we know that is
+	 * the source of one of our directory renames.
+	 *
+	 * That's why oentry and dir_rename_exclusions is here.
+	 *
+	 * As it turns out, this also prevents N-way transient rename
+	 * confusion; See testcases 9c and 9d of t6043.
+	 */
+	struct dir_rename_entry *oentry = NULL;
+	oentry = dir_rename_find_entry(dir_rename_exclusions, entry->new_dir);
+	if (oentry) {
+		output(o, 1, _("WARNING: Avoiding applying %s -> %s rename "
+			       "to %s, because %s itself was renamed."),
+		       entry->dir, entry->new_dir, path, entry->new_dir);
+	} else {
+		new_path = handle_path_level_conflicts(o, path, entry,
+						       collisions, tree);
+		*clean_merge &= (new_path != NULL);
+	}
+
+	return new_path;
+}
+
 /*
  * Get information of all renames which occurred in 'pairs', making use of
  * any implicit directory renames inferred from the other side of history.
@@ -1735,11 +1883,13 @@ static void compute_collisions(struct hashmap *collisions,
 static struct string_list *get_renames(struct merge_options *o,
 				       struct diff_queue_struct *pairs,
 				       struct hashmap *dir_renames,
+				       struct hashmap *dir_rename_exclusions,
 				       struct tree *tree,
 				       struct tree *o_tree,
 				       struct tree *a_tree,
 				       struct tree *b_tree,
-				       struct string_list *entries)
+				       struct string_list *entries,
+				       int *clean_merge)
 {
 	int i;
 	struct hashmap collisions;
@@ -1754,10 +1904,22 @@ static struct string_list *get_renames(struct merge_options *o,
 		struct string_list_item *item;
 		struct rename *re;
 		struct diff_filepair *pair = pairs->queue[i];
-		if (pair->status != 'R') {
+		char *new_path; // non-NULL only with directory renames
+
+		if (pair->status == 'D') {
 			diff_free_filepair(pair);
 			continue;
 		}
+		new_path = check_for_directory_rename(o, pair->two->path, tree,
+						      dir_renames,
+						      dir_rename_exclusions,
+						      &collisions,
+						      clean_merge);
+		if (pair->status != 'R' && !new_path) {
+			diff_free_filepair(pair);
+			continue;
+		}
+
 		re = xmalloc(sizeof(*re));
 		re->processed = 0;
 		re->pair = pair;
@@ -2075,12 +2237,18 @@ static struct rename_info *handle_renames(struct merge_options *o,
 					 dir_re_merge, merge);
 
 	rei->head_renames  = get_renames(o, head_pairs,
-					 dir_re_merge, head,
-					 common, head, merge, entries);
+					 dir_re_merge, dir_re_head, head,
+					 common, head, merge, entries,
+					 clean);
+	if (*clean < 0)
+		goto cleanup;
 	rei->merge_renames = get_renames(o, merge_pairs,
-					 dir_re_head, merge,
-					 common, head, merge, entries);
-	*clean = process_renames(o, rei->head_renames, rei->merge_renames);
+					 dir_re_head, dir_re_merge, merge,
+					 common, head, merge, entries,
+					 clean);
+	if (*clean < 0)
+		goto cleanup;
+	*clean &= process_renames(o, rei->head_renames, rei->merge_renames);
 
 cleanup:
 	/*
@@ -2095,7 +2263,6 @@ static struct rename_info *handle_renames(struct merge_options *o,
 		if (e->new_dir)
 			free(e->new_dir);
 		/* possible_new_dirs already cleared in get_directory_renames */
-		//string_list_clear(&e->possible_new_dirs, 1);
 	}
 	hashmap_free(dir_re_head, 1);
 	free(dir_re_head);
@@ -2106,7 +2273,6 @@ static struct rename_info *handle_renames(struct merge_options *o,
 		if (e->new_dir)
 			free(e->new_dir);
 		/* possible_new_dirs already cleared in get_directory_renames */
-		//string_list_clear(&e->possible_new_dirs, 1);
 	}
 	hashmap_free(dir_re_merge, 1);
 	free(dir_re_merge);
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 4066b08767..858d83016a 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -438,7 +438,7 @@ test_expect_success '2a-setup: Directory split into two on one side, with equal
 	git commit -m "C"
 '
 
-test_expect_failure '2a-check: Directory split into two on one side, with equal numbers of paths' '
+test_expect_success '2a-check: Directory split into two on one side, with equal numbers of paths' '
 	git checkout B^0 &&
 
 	test_must_fail git merge -s recursive C^0 >out &&
-- 
2.15.0.5.g9567be9905

