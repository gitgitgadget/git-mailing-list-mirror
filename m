Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029F71F404
	for <e@80x24.org>; Thu, 19 Apr 2018 17:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752946AbeDSR6n (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 13:58:43 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:42126 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751092AbeDSR6g (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Apr 2018 13:58:36 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3JHw46Z014669;
        Thu, 19 Apr 2018 10:58:30 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hdry1au83-2;
        Thu, 19 Apr 2018 10:58:29 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 0833A22175B8;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id F05602CDE6F;
        Thu, 19 Apr 2018 10:58:28 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH v10 19/36] merge-recursive: check for directory level conflicts
Date:   Thu, 19 Apr 2018 10:58:06 -0700
Message-Id: <20180419175823.7946-20-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.290.ge988e9ce2a
In-Reply-To: <20180419175823.7946-1-newren@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804190157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before trying to apply directory renames to paths within the given
directories, we want to make sure that there aren't conflicts at the
directory level.  There will be additional checks at the individual
file level too, which will be added later.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 22c5e8e5c9..3b0e509513 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1395,6 +1395,15 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
 	return ret;
 }
 
+static int tree_has_path(struct tree *tree, const char *path)
+{
+	struct object_id hashy;
+	unsigned int mode_o;
+
+	return !get_tree_entry(&tree->object.oid, path,
+			       &hashy, &mode_o);
+}
+
 static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 				    char **old_dir, char **new_dir)
 {
@@ -1450,6 +1459,112 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 	}
 }
 
+static void remove_hashmap_entries(struct hashmap *dir_renames,
+				   struct string_list *items_to_remove)
+{
+	int i;
+	struct dir_rename_entry *entry;
+
+	for (i = 0; i < items_to_remove->nr; i++) {
+		entry = items_to_remove->items[i].util;
+		hashmap_remove(dir_renames, entry, NULL);
+	}
+	string_list_clear(items_to_remove, 0);
+}
+
+/*
+ * There are a couple things we want to do at the directory level:
+ *   1. Check for both sides renaming to the same thing, in order to avoid
+ *      implicit renaming of files that should be left in place.  (See
+ *      testcase 6b in t6043 for details.)
+ *   2. Prune directory renames if there are still files left in the
+ *      the original directory.  These represent a partial directory rename,
+ *      i.e. a rename where only some of the files within the directory
+ *      were renamed elsewhere.  (Technically, this could be done earlier
+ *      in get_directory_renames(), except that would prevent us from
+ *      doing the previous check and thus failing testcase 6b.)
+ *   3. Check for rename/rename(1to2) conflicts (at the directory level).
+ *      In the future, we could potentially record this info as well and
+ *      omit reporting rename/rename(1to2) conflicts for each path within
+ *      the affected directories, thus cleaning up the merge output.
+ *   NOTE: We do NOT check for rename/rename(2to1) conflicts at the
+ *         directory level, because merging directories is fine.  If it
+ *         causes conflicts for files within those merged directories, then
+ *         that should be detected at the individual path level.
+ */
+static void handle_directory_level_conflicts(struct merge_options *o,
+					     struct hashmap *dir_re_head,
+					     struct tree *head,
+					     struct hashmap *dir_re_merge,
+					     struct tree *merge)
+{
+	struct hashmap_iter iter;
+	struct dir_rename_entry *head_ent;
+	struct dir_rename_entry *merge_ent;
+
+	struct string_list remove_from_head = STRING_LIST_INIT_NODUP;
+	struct string_list remove_from_merge = STRING_LIST_INIT_NODUP;
+
+	hashmap_iter_init(dir_re_head, &iter);
+	while ((head_ent = hashmap_iter_next(&iter))) {
+		merge_ent = dir_rename_find_entry(dir_re_merge, head_ent->dir);
+		if (merge_ent &&
+		    !head_ent->non_unique_new_dir &&
+		    !merge_ent->non_unique_new_dir &&
+		    !strbuf_cmp(&head_ent->new_dir, &merge_ent->new_dir)) {
+			/* 1. Renamed identically; remove it from both sides */
+			string_list_append(&remove_from_head,
+					   head_ent->dir)->util = head_ent;
+			strbuf_release(&head_ent->new_dir);
+			string_list_append(&remove_from_merge,
+					   merge_ent->dir)->util = merge_ent;
+			strbuf_release(&merge_ent->new_dir);
+		} else if (tree_has_path(head, head_ent->dir)) {
+			/* 2. This wasn't a directory rename after all */
+			string_list_append(&remove_from_head,
+					   head_ent->dir)->util = head_ent;
+			strbuf_release(&head_ent->new_dir);
+		}
+	}
+
+	remove_hashmap_entries(dir_re_head, &remove_from_head);
+	remove_hashmap_entries(dir_re_merge, &remove_from_merge);
+
+	hashmap_iter_init(dir_re_merge, &iter);
+	while ((merge_ent = hashmap_iter_next(&iter))) {
+		head_ent = dir_rename_find_entry(dir_re_head, merge_ent->dir);
+		if (tree_has_path(merge, merge_ent->dir)) {
+			/* 2. This wasn't a directory rename after all */
+			string_list_append(&remove_from_merge,
+					   merge_ent->dir)->util = merge_ent;
+		} else if (head_ent &&
+			   !head_ent->non_unique_new_dir &&
+			   !merge_ent->non_unique_new_dir) {
+			/* 3. rename/rename(1to2) */
+			/*
+			 * We can assume it's not rename/rename(1to1) because
+			 * that was case (1), already checked above.  So we
+			 * know that head_ent->new_dir and merge_ent->new_dir
+			 * are different strings.
+			 */
+			output(o, 1, _("CONFLICT (rename/rename): "
+				       "Rename directory %s->%s in %s. "
+				       "Rename directory %s->%s in %s"),
+			       head_ent->dir, head_ent->new_dir.buf, o->branch1,
+			       head_ent->dir, merge_ent->new_dir.buf, o->branch2);
+			string_list_append(&remove_from_head,
+					   head_ent->dir)->util = head_ent;
+			strbuf_release(&head_ent->new_dir);
+			string_list_append(&remove_from_merge,
+					   merge_ent->dir)->util = merge_ent;
+			strbuf_release(&merge_ent->new_dir);
+		}
+	}
+
+	remove_hashmap_entries(dir_re_head, &remove_from_head);
+	remove_hashmap_entries(dir_re_merge, &remove_from_merge);
+}
+
 static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs,
 					     struct tree *tree)
 {
@@ -1911,6 +2026,10 @@ static int handle_renames(struct merge_options *o,
 	dir_re_head = get_directory_renames(head_pairs, head);
 	dir_re_merge = get_directory_renames(merge_pairs, merge);
 
+	handle_directory_level_conflicts(o,
+					 dir_re_head, head,
+					 dir_re_merge, merge);
+
 	ri->head_renames  = get_renames(o, head_pairs, head,
 					 common, head, merge, entries);
 	ri->merge_renames = get_renames(o, merge_pairs, merge,
-- 
2.17.0.290.ge988e9ce2a

