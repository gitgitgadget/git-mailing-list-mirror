Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 831CA1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 17:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbeDSR7A (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 13:59:00 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:41722 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752769AbeDSR6h (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Apr 2018 13:58:37 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3JHnDir028655;
        Thu, 19 Apr 2018 10:58:30 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hdryeas78-1;
        Thu, 19 Apr 2018 10:58:30 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 11C4A22175CD;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 08B9B2CDEED;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH v10 20/36] merge-recursive: add computation of collisions due to dir rename & merging
Date:   Thu, 19 Apr 2018 10:58:07 -0700
Message-Id: <20180419175823.7946-21-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.290.ge988e9ce2a
In-Reply-To: <20180419175823.7946-1-newren@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804190156
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

directory renaming and merging can cause one or more files to be moved to
where an existing file is, or to cause several files to all be moved to
the same (otherwise vacant) location.  Add checking and reporting for such
cases, falling back to no-directory-rename handling for such paths.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c | 146 +++++++++++++++++++++++++++++++++++++++++++++-
 merge-recursive.h |   7 +++
 2 files changed, 150 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 3b0e509513..25ea6841fc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -87,6 +87,29 @@ static void dir_rename_entry_init(struct dir_rename_entry *entry,
 	string_list_init(&entry->possible_new_dirs, 0);
 }
 
+static struct collision_entry *collision_find_entry(struct hashmap *hashmap,
+						    char *target_file)
+{
+	struct collision_entry key;
+
+	hashmap_entry_init(&key, strhash(target_file));
+	key.target_file = target_file;
+	return hashmap_get(hashmap, &key, NULL);
+}
+
+static int collision_cmp(void *unused_cmp_data,
+			 const struct collision_entry *e1,
+			 const struct collision_entry *e2,
+			 const void *unused_keydata)
+{
+	return strcmp(e1->target_file, e2->target_file);
+}
+
+static void collision_init(struct hashmap *map)
+{
+	hashmap_init(map, (hashmap_cmp_fn) collision_cmp, NULL, 0);
+}
+
 static void flush_output(struct merge_options *o)
 {
 	if (o->buffer_output < 2 && o->obuf.len) {
@@ -1404,6 +1427,31 @@ static int tree_has_path(struct tree *tree, const char *path)
 			       &hashy, &mode_o);
 }
 
+/*
+ * Return a new string that replaces the beginning portion (which matches
+ * entry->dir), with entry->new_dir.  In perl-speak:
+ *   new_path_name = (old_path =~ s/entry->dir/entry->new_dir/);
+ * NOTE:
+ *   Caller must ensure that old_path starts with entry->dir + '/'.
+ */
+static char *apply_dir_rename(struct dir_rename_entry *entry,
+			      const char *old_path)
+{
+	struct strbuf new_path = STRBUF_INIT;
+	int oldlen, newlen;
+
+	if (entry->non_unique_new_dir)
+		return NULL;
+
+	oldlen = strlen(entry->dir);
+	newlen = entry->new_dir.len + (strlen(old_path) - oldlen) + 1;
+	strbuf_grow(&new_path, newlen);
+	strbuf_addbuf(&new_path, &entry->new_dir);
+	strbuf_addstr(&new_path, &old_path[oldlen]);
+
+	return strbuf_detach(&new_path, NULL);
+}
+
 static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 				    char **old_dir, char **new_dir)
 {
@@ -1673,6 +1721,84 @@ static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs,
 	return dir_renames;
 }
 
+static struct dir_rename_entry *check_dir_renamed(const char *path,
+						  struct hashmap *dir_renames)
+{
+	char temp[PATH_MAX];
+	char *end;
+	struct dir_rename_entry *entry;
+
+	strcpy(temp, path);
+	while ((end = strrchr(temp, '/'))) {
+		*end = '\0';
+		entry = dir_rename_find_entry(dir_renames, temp);
+		if (entry)
+			return entry;
+	}
+	return NULL;
+}
+
+static void compute_collisions(struct hashmap *collisions,
+			       struct hashmap *dir_renames,
+			       struct diff_queue_struct *pairs)
+{
+	int i;
+
+	/*
+	 * Multiple files can be mapped to the same path due to directory
+	 * renames done by the other side of history.  Since that other
+	 * side of history could have merged multiple directories into one,
+	 * if our side of history added the same file basename to each of
+	 * those directories, then all N of them would get implicitly
+	 * renamed by the directory rename detection into the same path,
+	 * and we'd get an add/add/.../add conflict, and all those adds
+	 * from *this* side of history.  This is not representable in the
+	 * index, and users aren't going to easily be able to make sense of
+	 * it.  So we need to provide a good warning about what's
+	 * happening, and fall back to no-directory-rename detection
+	 * behavior for those paths.
+	 *
+	 * See testcases 9e and all of section 5 from t6043 for examples.
+	 */
+	collision_init(collisions);
+
+	for (i = 0; i < pairs->nr; ++i) {
+		struct dir_rename_entry *dir_rename_ent;
+		struct collision_entry *collision_ent;
+		char *new_path;
+		struct diff_filepair *pair = pairs->queue[i];
+
+		if (pair->status == 'D')
+			continue;
+		dir_rename_ent = check_dir_renamed(pair->two->path,
+						   dir_renames);
+		if (!dir_rename_ent)
+			continue;
+
+		new_path = apply_dir_rename(dir_rename_ent, pair->two->path);
+		if (!new_path)
+			/*
+			 * dir_rename_ent->non_unique_new_path is true, which
+			 * means there is no directory rename for us to use,
+			 * which means it won't cause us any additional
+			 * collisions.
+			 */
+			continue;
+		collision_ent = collision_find_entry(collisions, new_path);
+		if (!collision_ent) {
+			collision_ent = xcalloc(1,
+						sizeof(struct collision_entry));
+			hashmap_entry_init(collision_ent, strhash(new_path));
+			hashmap_put(collisions, collision_ent);
+			collision_ent->target_file = new_path;
+		} else {
+			free(new_path);
+		}
+		string_list_insert(&collision_ent->source_files,
+				   pair->two->path);
+	}
+}
+
 /*
  * Get information of all renames which occurred in 'pairs', making use of
  * any implicit directory renames inferred from the other side of history.
@@ -1682,6 +1808,7 @@ static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs,
  */
 static struct string_list *get_renames(struct merge_options *o,
 				       struct diff_queue_struct *pairs,
+				       struct hashmap *dir_renames,
 				       struct tree *tree,
 				       struct tree *o_tree,
 				       struct tree *a_tree,
@@ -1689,8 +1816,12 @@ static struct string_list *get_renames(struct merge_options *o,
 				       struct string_list *entries)
 {
 	int i;
+	struct hashmap collisions;
+	struct hashmap_iter iter;
+	struct collision_entry *e;
 	struct string_list *renames;
 
+	compute_collisions(&collisions, dir_renames, pairs);
 	renames = xcalloc(1, sizeof(struct string_list));
 
 	for (i = 0; i < pairs->nr; ++i) {
@@ -1721,6 +1852,13 @@ static struct string_list *get_renames(struct merge_options *o,
 		item = string_list_insert(renames, pair->one->path);
 		item->util = re;
 	}
+
+	hashmap_iter_init(&collisions, &iter);
+	while ((e = hashmap_iter_next(&iter))) {
+		free(e->target_file);
+		string_list_clear(&e->source_files, 0);
+	}
+	hashmap_free(&collisions, 1);
 	return renames;
 }
 
@@ -2030,9 +2168,11 @@ static int handle_renames(struct merge_options *o,
 					 dir_re_head, head,
 					 dir_re_merge, merge);
 
-	ri->head_renames  = get_renames(o, head_pairs, head,
-					 common, head, merge, entries);
-	ri->merge_renames = get_renames(o, merge_pairs, merge,
+	ri->head_renames  = get_renames(o, head_pairs,
+					dir_re_merge, head,
+					common, head, merge, entries);
+	ri->merge_renames = get_renames(o, merge_pairs,
+					dir_re_head, merge,
 					 common, head, merge, entries);
 	clean = process_renames(o, ri->head_renames, ri->merge_renames);
 
diff --git a/merge-recursive.h b/merge-recursive.h
index fe64c78de4..50a4e6af4e 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -47,6 +47,13 @@ struct dir_rename_entry {
 	struct string_list possible_new_dirs;
 };
 
+struct collision_entry {
+	struct hashmap_entry ent; /* must be the first member! */
+	char *target_file;
+	struct string_list source_files;
+	unsigned reported_already:1;
+};
+
 /* merge_trees() but with recursive ancestor consolidation */
 int merge_recursive(struct merge_options *o,
 		    struct commit *h1,
-- 
2.17.0.290.ge988e9ce2a

