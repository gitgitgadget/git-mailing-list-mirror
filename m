Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 073B21F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162365AbeBNSwr (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:52:47 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:37044 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1162336AbeBNSwg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Feb 2018 13:52:36 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1EIm4H6011929;
        Wed, 14 Feb 2018 10:52:08 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2g1xgry8kf-1;
        Wed, 14 Feb 2018 10:52:07 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 77A8C225EBBC;
        Wed, 14 Feb 2018 10:52:07 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 67A432CDE88;
        Wed, 14 Feb 2018 10:52:07 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v8 18/29] merge-recursive: add get_directory_renames()
Date:   Wed, 14 Feb 2018 10:51:55 -0800
Message-Id: <20180214185206.15492-19-newren@gmail.com>
X-Mailer: git-send-email 2.16.1.232.g28d5be9217
In-Reply-To: <20180214185206.15492-1-newren@gmail.com>
References: <20180214185206.15492-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1802140219
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This populates a set of directory renames for us.  The set of directory
renames is not yet used, but will be in subsequent commits.

Note that the use of a string_list for possible_new_dirs in the new
dir_rename_entry struct implies an O(n^2) algorithm; however, in practice
I expect the number of distinct directories that files were renamed into
from a single original directory to be O(1).  My guess is that n has a
mode of 1 and a mean of less than 2, so, for now, string_list seems good
enough for possible_new_dirs.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 224 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
 merge-recursive.h |  18 +++++
 2 files changed, 239 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index be20660527..aca4acdfcb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -49,6 +49,44 @@ static unsigned int path_hash(const char *path)
 	return ignore_case ? strihash(path) : strhash(path);
 }
=20
+static struct dir_rename_entry *dir_rename_find_entry(struct hashmap *ha=
shmap,
+						      char *dir)
+{
+	struct dir_rename_entry key;
+
+	if (dir =3D=3D NULL)
+		return NULL;
+	hashmap_entry_init(&key, strhash(dir));
+	key.dir =3D dir;
+	return hashmap_get(hashmap, &key, NULL);
+}
+
+static int dir_rename_cmp(const void *unused_cmp_data,
+			  const void *entry,
+			  const void *entry_or_key,
+			  const void *unused_keydata)
+{
+	const struct dir_rename_entry *e1 =3D entry;
+	const struct dir_rename_entry *e2 =3D entry_or_key;
+
+	return strcmp(e1->dir, e2->dir);
+}
+
+static void dir_rename_init(struct hashmap *map)
+{
+	hashmap_init(map, dir_rename_cmp, NULL, 0);
+}
+
+static void dir_rename_entry_init(struct dir_rename_entry *entry,
+				  char *directory)
+{
+	hashmap_entry_init(entry, strhash(directory));
+	entry->dir =3D directory;
+	entry->non_unique_new_dir =3D 0;
+	strbuf_init(&entry->new_dir, 0);
+	string_list_init(&entry->possible_new_dirs, 0);
+}
+
 static void flush_output(struct merge_options *o)
 {
 	if (o->buffer_output < 2 && o->obuf.len) {
@@ -1356,6 +1394,169 @@ static struct diff_queue_struct *get_diffpairs(st=
ruct merge_options *o,
 	return ret;
 }
=20
+static void get_renamed_dir_portion(const char *old_path, const char *ne=
w_path,
+				    char **old_dir, char **new_dir)
+{
+	char *end_of_old, *end_of_new;
+	int old_len, new_len;
+
+	*old_dir =3D NULL;
+	*new_dir =3D NULL;
+
+	/*
+	 * For
+	 *    "a/b/c/d/e/foo.c" -> "a/b/some/thing/else/e/foo.c"
+	 * the "e/foo.c" part is the same, we just want to know that
+	 *    "a/b/c/d" was renamed to "a/b/some/thing/else"
+	 * so, for this example, this function returns "a/b/c/d" in
+	 * *old_dir and "a/b/some/thing/else" in *new_dir.
+	 *
+	 * Also, if the basename of the file changed, we don't care.  We
+	 * want to know which portion of the directory, if any, changed.
+	 */
+	end_of_old =3D strrchr(old_path, '/');
+	end_of_new =3D strrchr(new_path, '/');
+
+	if (end_of_old =3D=3D NULL || end_of_new =3D=3D NULL)
+		return;
+	while (*--end_of_new =3D=3D *--end_of_old &&
+	       end_of_old !=3D old_path &&
+	       end_of_new !=3D new_path)
+		; /* Do nothing; all in the while loop */
+	/*
+	 * We've found the first non-matching character in the directory
+	 * paths.  That means the current directory we were comparing
+	 * represents the rename.  Move end_of_old and end_of_new back
+	 * to the full directory name.
+	 */
+	if (*end_of_old =3D=3D '/')
+		end_of_old++;
+	if (*end_of_old !=3D '/')
+		end_of_new++;
+	end_of_old =3D strchr(end_of_old, '/');
+	end_of_new =3D strchr(end_of_new, '/');
+
+	/*
+	 * It may have been the case that old_path and new_path were the same
+	 * directory all along.  Don't claim a rename if they're the same.
+	 */
+	old_len =3D end_of_old - old_path;
+	new_len =3D end_of_new - new_path;
+
+	if (old_len !=3D new_len || strncmp(old_path, new_path, old_len)) {
+		*old_dir =3D xstrndup(old_path, old_len);
+		*new_dir =3D xstrndup(new_path, new_len);
+	}
+}
+
+static struct hashmap *get_directory_renames(struct diff_queue_struct *p=
airs,
+					     struct tree *tree)
+{
+	struct hashmap *dir_renames;
+	struct hashmap_iter iter;
+	struct dir_rename_entry *entry;
+	int i;
+
+	/*
+	 * Typically, we think of a directory rename as all files from a
+	 * certain directory being moved to a target directory.  However,
+	 * what if someone first moved two files from the original
+	 * directory in one commit, and then renamed the directory
+	 * somewhere else in a later commit?  At merge time, we just know
+	 * that files from the original directory went to two different
+	 * places, and that the bulk of them ended up in the same place.
+	 * We want each directory rename to represent where the bulk of the
+	 * files from that directory end up; this function exists to find
+	 * where the bulk of the files went.
+	 *
+	 * The first loop below simply iterates through the list of file
+	 * renames, finding out how often each directory rename pair
+	 * possibility occurs.
+	 */
+	dir_renames =3D xmalloc(sizeof(struct hashmap));
+	dir_rename_init(dir_renames);
+	for (i =3D 0; i < pairs->nr; ++i) {
+		struct string_list_item *item;
+		int *count;
+		struct diff_filepair *pair =3D pairs->queue[i];
+		char *old_dir, *new_dir;
+
+		/* File not part of directory rename if it wasn't renamed */
+		if (pair->status !=3D 'R')
+			continue;
+
+		get_renamed_dir_portion(pair->one->path, pair->two->path,
+					&old_dir,        &new_dir);
+		if (!old_dir)
+			/* Directory didn't change at all; ignore this one. */
+			continue;
+
+		entry =3D dir_rename_find_entry(dir_renames, old_dir);
+		if (!entry) {
+			entry =3D xmalloc(sizeof(struct dir_rename_entry));
+			dir_rename_entry_init(entry, old_dir);
+			hashmap_put(dir_renames, entry);
+		} else {
+			free(old_dir);
+		}
+		item =3D string_list_lookup(&entry->possible_new_dirs, new_dir);
+		if (!item) {
+			item =3D string_list_insert(&entry->possible_new_dirs,
+						  new_dir);
+			item->util =3D xcalloc(1, sizeof(int));
+		} else {
+			free(new_dir);
+		}
+		count =3D item->util;
+		*count +=3D 1;
+	}
+
+	/*
+	 * For each directory with files moved out of it, we find out which
+	 * target directory received the most files so we can declare it to
+	 * be the "winning" target location for the directory rename.  This
+	 * winner gets recorded in new_dir.  If there is no winner
+	 * (multiple target directories received the same number of files),
+	 * we set non_unique_new_dir.  Once we've determined the winner (or
+	 * that there is no winner), we no longer need possible_new_dirs.
+	 */
+	hashmap_iter_init(dir_renames, &iter);
+	while ((entry =3D hashmap_iter_next(&iter))) {
+		int max =3D 0;
+		int bad_max =3D 0;
+		char *best =3D NULL;
+
+		for (i =3D 0; i < entry->possible_new_dirs.nr; i++) {
+			int *count =3D entry->possible_new_dirs.items[i].util;
+
+			if (*count =3D=3D max)
+				bad_max =3D max;
+			else if (*count > max) {
+				max =3D *count;
+				best =3D entry->possible_new_dirs.items[i].string;
+			}
+		}
+		if (bad_max =3D=3D max)
+			entry->non_unique_new_dir =3D 1;
+		else {
+			assert(entry->new_dir.len =3D=3D 0);
+			strbuf_addstr(&entry->new_dir, best);
+		}
+		/*
+		 * The relevant directory sub-portion of the original full
+		 * filepaths were xstrndup'ed before inserting into
+		 * possible_new_dirs, and instead of manually iterating the
+		 * list and free'ing each, just lie and tell
+		 * possible_new_dirs that it did the strdup'ing so that it
+		 * will free them for us.
+		 */
+		entry->possible_new_dirs.strdup_strings =3D 1;
+		string_list_clear(&entry->possible_new_dirs, 1);
+	}
+
+	return dir_renames;
+}
+
 /*
  * Get information of all renames which occurred in 'pairs', making use =
of
  * any implicit directory renames inferred from the other side of histor=
y.
@@ -1667,8 +1868,21 @@ struct rename_info {
 	struct string_list *merge_renames;
 };
=20
-static void initial_cleanup_rename(struct diff_queue_struct *pairs)
+static void initial_cleanup_rename(struct diff_queue_struct *pairs,
+				   struct hashmap *dir_renames)
 {
+	struct hashmap_iter iter;
+	struct dir_rename_entry *e;
+
+	hashmap_iter_init(dir_renames, &iter);
+	while ((e =3D hashmap_iter_next(&iter))) {
+		free(e->dir);
+		strbuf_release(&e->new_dir);
+		/* possible_new_dirs already cleared in get_directory_renames */
+	}
+	hashmap_free(dir_renames, 1);
+	free(dir_renames);
+
 	free(pairs->queue);
 	free(pairs);
 }
@@ -1681,6 +1895,7 @@ static int handle_renames(struct merge_options *o,
 			  struct rename_info *ri)
 {
 	struct diff_queue_struct *head_pairs, *merge_pairs;
+	struct hashmap *dir_re_head, *dir_re_merge;
 	int clean;
=20
 	ri->head_renames =3D NULL;
@@ -1692,6 +1907,9 @@ static int handle_renames(struct merge_options *o,
 	head_pairs =3D get_diffpairs(o, common, head);
 	merge_pairs =3D get_diffpairs(o, common, merge);
=20
+	dir_re_head =3D get_directory_renames(head_pairs, head);
+	dir_re_merge =3D get_directory_renames(merge_pairs, merge);
+
 	ri->head_renames  =3D get_renames(o, head_pairs, head,
 					 common, head, merge, entries);
 	ri->merge_renames =3D get_renames(o, merge_pairs, merge,
@@ -1703,8 +1921,8 @@ static int handle_renames(struct merge_options *o,
 	 * data structures are still needed and referenced in
 	 * process_entry().  But there are a few things we can free now.
 	 */
-	initial_cleanup_rename(head_pairs);
-	initial_cleanup_rename(merge_pairs);
+	initial_cleanup_rename(head_pairs, dir_re_head);
+	initial_cleanup_rename(merge_pairs, dir_re_merge);
=20
 	return clean;
 }
diff --git a/merge-recursive.h b/merge-recursive.h
index 80d69d1401..fe64c78de4 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -29,6 +29,24 @@ struct merge_options {
 	struct string_list df_conflict_file_set;
 };
=20
+/*
+ * For dir_rename_entry, directory names are stored as a full path from =
the
+ * toplevel of the repository and do not include a trailing '/'.  Also:
+ *
+ *   dir:                original name of directory being renamed
+ *   non_unique_new_dir: if true, could not determine new_dir
+ *   new_dir:            final name of directory being renamed
+ *   possible_new_dirs:  temporary used to help determine new_dir; see c=
omments
+ *                       in get_directory_renames() for details
+ */
+struct dir_rename_entry {
+	struct hashmap_entry ent; /* must be the first member! */
+	char *dir;
+	unsigned non_unique_new_dir:1;
+	struct strbuf new_dir;
+	struct string_list possible_new_dirs;
+};
+
 /* merge_trees() but with recursive ancestor consolidation */
 int merge_recursive(struct merge_options *o,
 		    struct commit *h1,
--=20
2.16.1.232.g28d5be9217

