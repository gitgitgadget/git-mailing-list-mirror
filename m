Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 506A320954
	for <e@80x24.org>; Tue, 21 Nov 2017 08:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbdKUIBn (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 03:01:43 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:40612 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751345AbdKUIBl (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2017 03:01:41 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAL7xL2j002570;
        Tue, 21 Nov 2017 00:01:01 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2eajmr44rn-1;
        Tue, 21 Nov 2017 00:01:01 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 0A46922665AF;
        Tue, 21 Nov 2017 00:01:01 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id EB5B92CDEC1;
        Tue, 21 Nov 2017 00:01:00 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 22/33] merge-recursive: check for directory level conflicts
Date:   Tue, 21 Nov 2017 00:00:48 -0800
Message-Id: <20171121080059.32304-23-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.309.g62ce55426d
In-Reply-To: <20171121080059.32304-1-newren@gmail.com>
References: <20171121080059.32304-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-21_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711210110
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
 merge-recursive.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 112 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 6a0a6d4366..c235b27c55 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1384,6 +1384,15 @@ static struct diff_queue_struct *get_diffpairs(str=
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
@@ -1438,6 +1447,105 @@ static void get_renamed_dir_portion(const char *o=
ld_path, const char *new_path,
 	}
 }
=20
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
+	int i;
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
+		    !strcmp(head_ent->new_dir, merge_ent->new_dir)) {
+			/* 1. Renamed identically; remove it from both sides */
+			string_list_append(&remove_from_head,
+					   head_ent->dir)->util =3D head_ent;
+			free(head_ent->new_dir);
+			string_list_append(&remove_from_merge,
+					   merge_ent->dir)->util =3D merge_ent;
+			free(merge_ent->new_dir);
+		} else if (tree_has_path(head, head_ent->dir)) {
+			/* 2. This wasn't a directory rename after all */
+			string_list_append(&remove_from_head,
+					   head_ent->dir)->util =3D head_ent;
+			free(head_ent->new_dir);
+		}
+	}
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
+			/* We can assume it's not rename/rename(1to1) because
+			 * that was case (1), already checked above.  So we
+			 * know that head_ent->new_dir and merge_ent->new_dir
+			 * are different strings.
+			 */
+			output(o, 1, _("CONFLICT (rename/rename): "
+				       "Rename directory %s->%s in %s. "
+				       "Rename directory %s->%s in %s"),
+			       head_ent->dir, head_ent->new_dir, o->branch1,
+			       head_ent->dir, merge_ent->new_dir, o->branch2);
+			string_list_append(&remove_from_head,
+					   head_ent->dir)->util =3D head_ent;
+			free(head_ent->new_dir);
+			string_list_append(&remove_from_merge,
+					   merge_ent->dir)->util =3D merge_ent;
+			free(merge_ent->new_dir);
+		}
+	}
+
+	for (i =3D 0; i < remove_from_head.nr; i++) {
+		head_ent =3D remove_from_head.items[i].util;
+		hashmap_remove(dir_re_head, head_ent, NULL);
+	}
+	for (i =3D 0; i < remove_from_merge.nr; i++) {
+		merge_ent =3D remove_from_merge.items[i].util;
+		hashmap_remove(dir_re_merge, merge_ent, NULL);
+	}
+
+	string_list_clear(&remove_from_head, 0);
+	string_list_clear(&remove_from_merge, 0);
+}
+
 static struct hashmap *get_directory_renames(struct diff_queue_struct *p=
airs,
 					     struct tree *tree)
 {
@@ -1846,6 +1954,10 @@ static int handle_renames(struct merge_options *o,
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
2.15.0.309.g62ce55426d

