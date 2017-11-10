Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B00C1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 19:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753828AbdKJTGM (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 14:06:12 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:51760 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753772AbdKJTGD (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 14:06:03 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAJ2v3B017414;
        Fri, 10 Nov 2017 11:06:01 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e535n1cde-3;
        Fri, 10 Nov 2017 11:06:01 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 24E0922F6287;
        Fri, 10 Nov 2017 11:06:01 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 1C3442CDE6A;
        Fri, 10 Nov 2017 11:06:01 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 21/30] merge-recursive: Add get_directory_renames()
Date:   Fri, 10 Nov 2017 11:05:41 -0800
Message-Id: <20171110190550.27059-22-newren@gmail.com>
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

This populates a list of directory renames for us.  The list of
directory renames is not yet used, but will be in subsequent commits.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 89a9b32635..b5770d3d7f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1376,6 +1376,124 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
 	return ret;
 }
 
+static void get_renamed_dir_portion(const char *old_path, const char *new_path,
+				    char **old_dir, char **new_dir) {
+	*old_dir = NULL;
+	*new_dir = NULL;
+
+	/* For
+	 *    "a/b/c/d/foo.c" -> "a/b/something-else/d/foo.c"
+	 * the "d/foo.c" part is the same, we just want to know that
+	 *    "a/b/c" was renamed to "a/b/something-else"
+	 * so, for this example, this function returns "a/b/c" in
+	 * *old_dir and "a/b/something-else" in *new_dir.
+	 *
+	 * Also, if the basename of the file changed, we don't care.  We
+	 * want to know which portion of the directory, if any, changed.
+	 */
+	char *end_of_old = strrchr(old_path, '/');
+	char *end_of_new = strrchr(new_path, '/');
+	if (end_of_old == NULL || end_of_new == NULL)
+		return;
+	while (*--end_of_new == *--end_of_old &&
+	       end_of_old != old_path &&
+	       end_of_new != new_path)
+		; // Do nothing; all in the while loop
+	/*
+	 * We've found the first non-matching character in the directory
+	 * paths.  That means the current directory we were comparing
+	 * represents the rename.  Move end_of_old and end_of_new back
+	 * to the full directory name.
+	 */
+	if (*end_of_old == '/')
+		end_of_old++;
+	if (*end_of_old != '/')
+		end_of_new++;
+	end_of_old = strchr(end_of_old, '/');
+	end_of_new = strchr(end_of_new, '/');
+
+	/*
+	 * It may have been the case that old_path and new_path were the same
+	 * directory all along.  Don't claim a rename if they're the same.
+	 */
+	int old_len = end_of_old - old_path;
+	int new_len = end_of_new - new_path;
+
+	if (old_len != new_len || strncmp(old_path, new_path, old_len)) {
+		*old_dir = strndup(old_path, old_len);
+		*new_dir = strndup(new_path, new_len);
+	}
+}
+
+static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs,
+					     struct tree *tree) {
+	struct hashmap *dir_renames;
+	struct hashmap_iter iter;
+	struct dir_rename_entry *entry;
+	int i;
+
+	dir_renames = malloc(sizeof(struct hashmap));
+	dir_rename_init(dir_renames);
+	for (i = 0; i < pairs->nr; ++i) {
+		struct string_list_item *item;
+		int *count;
+		struct diff_filepair *pair = pairs->queue[i];
+
+		char *old_dir, *new_dir;
+		get_renamed_dir_portion(pair->one->path, pair->two->path,
+					&old_dir,        &new_dir);
+		if (!old_dir)
+			// Directory didn't change at all; ignore this one.
+			continue;
+
+		entry = dir_rename_find_entry(dir_renames, old_dir);
+		if (!entry) {
+			entry = xcalloc(1, sizeof(struct dir_rename_entry));
+			hashmap_entry_init(entry, strhash(old_dir));
+			hashmap_put(dir_renames, entry);
+			entry->dir = old_dir;
+		} else {
+			free(old_dir);
+		}
+		item = string_list_lookup(&entry->possible_new_dirs, new_dir);
+		if (!item) {
+			item = string_list_insert(&entry->possible_new_dirs, new_dir);
+			item->util = xcalloc(1, sizeof(int));
+		} else {
+			free(new_dir);
+		}
+		count = item->util;
+		*count += 1;
+	}
+
+	hashmap_iter_init(dir_renames, &iter);
+	while ((entry = hashmap_iter_next(&iter))) {
+		int max = 0;
+		int bad_max = 0;
+		char *best = NULL;
+		for (i = 0; i < entry->possible_new_dirs.nr; i++) {
+			int *count = entry->possible_new_dirs.items[i].util;
+			if (*count == max)
+				bad_max = max;
+			else if (*count > max) {
+				max = *count;
+				best = entry->possible_new_dirs.items[i].string;
+			}
+		}
+		if (bad_max == max)
+			entry->non_unique_new_dir = 1;
+		else
+			entry->new_dir = strdup(best);
+		/* Strings were strndup'ed before inserting into string-list,
+		 * so ask string_list to remove the entries for us.
+		 */
+		entry->possible_new_dirs.strdup_strings = 1;
+		string_list_clear(&entry->possible_new_dirs, 1);
+	}
+
+	return dir_renames;
+}
+
 /*
  * Get information of all renames which occurred in 'pairs', making use of
  * any implicit directory renames inferred from the other side of history.
@@ -1695,6 +1813,9 @@ static struct rename_info *handle_renames(struct merge_options *o,
 {
 	struct rename_info *rei = xcalloc(1, sizeof(struct rename_info));
 	struct diff_queue_struct *head_pairs, *merge_pairs;
+	struct hashmap *dir_re_head, *dir_re_merge;
+	struct hashmap_iter iter;
+	struct dir_rename_entry *e;
 
 	*clean = 1;
 	if (!o->detect_rename)
@@ -1703,6 +1824,9 @@ static struct rename_info *handle_renames(struct merge_options *o,
 	head_pairs = get_diffpairs(o, common, head);
 	merge_pairs = get_diffpairs(o, common, merge);
 
+	dir_re_head = get_directory_renames(head_pairs, head);
+	dir_re_merge = get_directory_renames(merge_pairs, merge);
+
 	rei->head_renames  = get_renames(o, head_pairs, head,
 					 common, head, merge, entries);
 	rei->merge_renames = get_renames(o, merge_pairs, merge,
@@ -1716,6 +1840,28 @@ static struct rename_info *handle_renames(struct merge_options *o,
 	 * process_entry().  But there are a few things we can free now.
 	 */
 
+	hashmap_iter_init(dir_re_head, &iter);
+	while ((e = hashmap_iter_next(&iter))) {
+		free(e->dir);
+		if (e->new_dir)
+			free(e->new_dir);
+		/* possible_new_dirs already cleared in get_directory_renames */
+		//string_list_clear(&e->possible_new_dirs, 1);
+	}
+	hashmap_free(dir_re_head, 1);
+	free(dir_re_head);
+
+	hashmap_iter_init(dir_re_merge, &iter);
+	while ((e = hashmap_iter_next(&iter))) {
+		free(e->dir);
+		if (e->new_dir)
+			free(e->new_dir);
+		/* possible_new_dirs already cleared in get_directory_renames */
+		//string_list_clear(&e->possible_new_dirs, 1);
+	}
+	hashmap_free(dir_re_merge, 1);
+	free(dir_re_merge);
+
 	free(head_pairs->queue);
 	free(head_pairs);
 	free(merge_pairs->queue);
-- 
2.15.0.5.g9567be9905

