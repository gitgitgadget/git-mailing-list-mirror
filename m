Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5051E20954
	for <e@80x24.org>; Wed, 29 Nov 2017 01:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753044AbdK2BnS (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 20:43:18 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:58528 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752380AbdK2BnR (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2017 20:43:17 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAT1bup5003278;
        Tue, 28 Nov 2017 17:42:39 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ef69q4mx2-3;
        Tue, 28 Nov 2017 17:42:38 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id E03D222157CC;
        Tue, 28 Nov 2017 17:42:38 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id D99E62CDE74;
        Tue, 28 Nov 2017 17:42:38 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 22/34] merge-recursive: add get_directory_renames()
Date:   Tue, 28 Nov 2017 17:42:25 -0800
Message-Id: <20171129014237.32570-23-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g850bc54b15
In-Reply-To: <20171129014237.32570-1-newren@gmail.com>
References: <20171129014237.32570-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-28_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711290020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This populates a list of directory renames for us.  The list of
directory renames is not yet used, but will be in subsequent commits.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
 1 file changed, 152 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c5932d5c57..6aef357e78 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1384,6 +1384,138 @@ static struct diff_queue_struct *get_diffpairs(st=
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
+	dir_renames =3D malloc(sizeof(struct hashmap));
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
+		/* Strings were xstrndup'ed before inserting into string-list,
+		 * so ask string_list to remove the entries for us.
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
@@ -1695,8 +1827,21 @@ struct rename_info {
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
@@ -1709,6 +1854,7 @@ static int handle_renames(struct merge_options *o,
 			  struct rename_info *ri)
 {
 	struct diff_queue_struct *head_pairs, *merge_pairs;
+	struct hashmap *dir_re_head, *dir_re_merge;
 	int clean;
=20
 	ri->head_renames =3D NULL;
@@ -1720,6 +1866,9 @@ static int handle_renames(struct merge_options *o,
 	head_pairs =3D get_diffpairs(o, common, head);
 	merge_pairs =3D get_diffpairs(o, common, merge);
=20
+	dir_re_head =3D get_directory_renames(head_pairs, head);
+	dir_re_merge =3D get_directory_renames(merge_pairs, merge);
+
 	ri->head_renames  =3D get_renames(o, head_pairs, head,
 					 common, head, merge, entries);
 	ri->merge_renames =3D get_renames(o, merge_pairs, merge,
@@ -1731,8 +1880,8 @@ static int handle_renames(struct merge_options *o,
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
--=20
2.15.0.408.g850bc54b15

