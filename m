Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24A4B1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 23:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932229AbeA3Xp2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 18:45:28 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:58682 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932224AbeA3Xp1 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Jan 2018 18:45:27 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0UNN8un025769;
        Tue, 30 Jan 2018 15:25:35 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2frq6qw4du-1;
        Tue, 30 Jan 2018 15:25:35 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 362B8221A56C;
        Tue, 30 Jan 2018 15:25:35 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 25CE82CDE88;
        Tue, 30 Jan 2018 15:25:35 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com, szeder.dev@gmail.com,
        jrnieder@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 20/31] merge-recursive: check for directory level conflicts
Date:   Tue, 30 Jan 2018 15:25:22 -0800
Message-Id: <20180130232533.25846-21-newren@gmail.com>
X-Mailer: git-send-email 2.16.1.106.gf69932adfe
In-Reply-To: <20180130232533.25846-1-newren@gmail.com>
References: <20180130232533.25846-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1801300286
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before trying to apply directory renames to paths within the given
directories, we want to make sure that there aren't conflicts at the
directory level.  There will be additional checks at the individual
file level too, which will be added later.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 119 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index c75d3a5139..9e9ad45d2a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1393,6 +1393,15 @@ static struct diff_queue_struct *get_diffpairs(str=
uct merge_options *o,
 	return ret;
 }
=20
+static int tree_has_path(struct tree *tree, const char *path)
+{
+	unsigned char hashy[20];
+	unsigned int mode_o;
+
+	return !get_tree_entry(tree->object.oid.hash, path,
+			       hashy, &mode_o);
+}
+
 static void get_renamed_dir_portion(const char *old_path, const char *ne=
w_path,
 				    char **old_dir, char **new_dir)
 {
@@ -1447,6 +1456,112 @@ static void get_renamed_dir_portion(const char *o=
ld_path, const char *new_path,
 	}
 }
=20
+static void remove_hashmap_entries(struct hashmap *dir_renames,
+				   struct string_list *items_to_remove)
+{
+	int i;
+	struct dir_rename_entry *entry;
+
+	for (i =3D 0; i < items_to_remove->nr; i++) {
+		entry =3D items_to_remove->items[i].util;
+		hashmap_remove(dir_renames, entry, NULL);
+	}
+	string_list_clear(items_to_remove, 0);
+}
+
+/*
+ * There are a couple things we want to do at the directory level:
+ *   1. Check for both sides renaming to the same thing, in order to avo=
id
+ *      implicit renaming of files that should be left in place.  (See
+ *      testcase 6b in t6043 for details.)
+ *   2. Prune directory renames if there are still files left in the
+ *      the original directory.  These represent a partial directory ren=
ame,
+ *      i.e. a rename where only some of the files within the directory
+ *      were renamed elsewhere.  (Technically, this could be done earlie=
r
+ *      in get_directory_renames(), except that would prevent us from
+ *      doing the previous check and thus failing testcase 6b.)
+ *   3. Check for rename/rename(1to2) conflicts (at the directory level)=
.
+ *      In the future, we could potentially record this info as well and
+ *      omit reporting rename/rename(1to2) conflicts for each path withi=
n
+ *      the affected directories, thus cleaning up the merge output.
+ *   NOTE: We do NOT check for rename/rename(2to1) conflicts at the
+ *         directory level, because merging directories is fine.  If it
+ *         causes conflicts for files within those merged directories, t=
hen
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
+	struct string_list remove_from_head =3D STRING_LIST_INIT_NODUP;
+	struct string_list remove_from_merge =3D STRING_LIST_INIT_NODUP;
+
+	hashmap_iter_init(dir_re_head, &iter);
+	while ((head_ent =3D hashmap_iter_next(&iter))) {
+		merge_ent =3D dir_rename_find_entry(dir_re_merge, head_ent->dir);
+		if (merge_ent &&
+		    !head_ent->non_unique_new_dir &&
+		    !merge_ent->non_unique_new_dir &&
+		    !strbuf_cmp(&head_ent->new_dir, &merge_ent->new_dir)) {
+			/* 1. Renamed identically; remove it from both sides */
+			string_list_append(&remove_from_head,
+					   head_ent->dir)->util =3D head_ent;
+			strbuf_release(&head_ent->new_dir);
+			string_list_append(&remove_from_merge,
+					   merge_ent->dir)->util =3D merge_ent;
+			strbuf_release(&merge_ent->new_dir);
+		} else if (tree_has_path(head, head_ent->dir)) {
+			/* 2. This wasn't a directory rename after all */
+			string_list_append(&remove_from_head,
+					   head_ent->dir)->util =3D head_ent;
+			strbuf_release(&head_ent->new_dir);
+		}
+	}
+
+	remove_hashmap_entries(dir_re_head, &remove_from_head);
+	remove_hashmap_entries(dir_re_merge, &remove_from_merge);
+
+	hashmap_iter_init(dir_re_merge, &iter);
+	while ((merge_ent =3D hashmap_iter_next(&iter))) {
+		head_ent =3D dir_rename_find_entry(dir_re_head, merge_ent->dir);
+		if (tree_has_path(merge, merge_ent->dir)) {
+			/* 2. This wasn't a directory rename after all */
+			string_list_append(&remove_from_merge,
+					   merge_ent->dir)->util =3D merge_ent;
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
+					   head_ent->dir)->util =3D head_ent;
+			strbuf_release(&head_ent->new_dir);
+			string_list_append(&remove_from_merge,
+					   merge_ent->dir)->util =3D merge_ent;
+			strbuf_release(&merge_ent->new_dir);
+		}
+	}
+
+	remove_hashmap_entries(dir_re_head, &remove_from_head);
+	remove_hashmap_entries(dir_re_merge, &remove_from_merge);
+}
+
 static struct hashmap *get_directory_renames(struct diff_queue_struct *p=
airs,
 					     struct tree *tree)
 {
@@ -1878,6 +1993,10 @@ static int handle_renames(struct merge_options *o,
 	dir_re_head =3D get_directory_renames(head_pairs, head);
 	dir_re_merge =3D get_directory_renames(merge_pairs, merge);
=20
+	handle_directory_level_conflicts(o,
+					 dir_re_head, head,
+					 dir_re_merge, merge);
+
 	ri->head_renames  =3D get_renames(o, head_pairs, head,
 					 common, head, merge, entries);
 	ri->merge_renames =3D get_renames(o, merge_pairs, merge,
--=20
2.16.1.106.gf69932adfe

