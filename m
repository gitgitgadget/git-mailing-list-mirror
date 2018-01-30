Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43C381F404
	for <e@80x24.org>; Tue, 30 Jan 2018 23:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932221AbeA3XpX (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 18:45:23 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:58668 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932196AbeA3XpS (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Jan 2018 18:45:18 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0UNN50U025761;
        Tue, 30 Jan 2018 15:25:35 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2frq6qw4dn-2;
        Tue, 30 Jan 2018 15:25:35 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 53C38221A575;
        Tue, 30 Jan 2018 15:25:35 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 4B27C2CDE88;
        Tue, 30 Jan 2018 15:25:35 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com, szeder.dev@gmail.com,
        jrnieder@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 22/31] merge-recursive: add computation of collisions due to dir rename & merging
Date:   Tue, 30 Jan 2018 15:25:24 -0800
Message-Id: <20180130232533.25846-23-newren@gmail.com>
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
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1801300286
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

directory renaming and merging can cause one or more files to be moved to
where an existing file is, or to cause several files to all be moved to
the same (otherwise vacant) location.  Add checking and reporting for suc=
h
cases, falling back to no-directory-rename handling for such paths.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
 1 file changed, 120 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index ac968ad2ae..dc03b1bb54 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1425,6 +1425,31 @@ static int tree_has_path(struct tree *tree, const =
char *path)
 			       hashy, &mode_o);
 }
=20
+/*
+ * Return a new string that replaces the beginning portion (which matche=
s
+ * entry->dir), with entry->new_dir.  In perl-speak:
+ *   new_path_name =3D (old_path =3D~ s/entry->dir/entry->new_dir/);
+ * NOTE:
+ *   Caller must ensure that old_path starts with entry->dir + '/'.
+ */
+static char *apply_dir_rename(struct dir_rename_entry *entry,
+			      const char *old_path)
+{
+	struct strbuf new_path =3D STRBUF_INIT;
+	int oldlen, newlen;
+
+	if (entry->non_unique_new_dir)
+		return NULL;
+
+	oldlen =3D strlen(entry->dir);
+	newlen =3D entry->new_dir.len + (strlen(old_path) - oldlen) + 1;
+	strbuf_grow(&new_path, newlen);
+	strbuf_addbuf(&new_path, &entry->new_dir);
+	strbuf_addstr(&new_path, &old_path[oldlen]);
+
+	return strbuf_detach(&new_path, NULL);
+}
+
 static void get_renamed_dir_portion(const char *old_path, const char *ne=
w_path,
 				    char **old_dir, char **new_dir)
 {
@@ -1663,6 +1688,84 @@ static struct hashmap *get_directory_renames(struc=
t diff_queue_struct *pairs,
 	return dir_renames;
 }
=20
+static struct dir_rename_entry *check_dir_renamed(const char *path,
+						  struct hashmap *dir_renames)
+{
+	char temp[PATH_MAX];
+	char *end;
+	struct dir_rename_entry *entry;
+
+	strcpy(temp, path);
+	while ((end =3D strrchr(temp, '/'))) {
+		*end =3D '\0';
+		entry =3D dir_rename_find_entry(dir_renames, temp);
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
+	for (i =3D 0; i < pairs->nr; ++i) {
+		struct dir_rename_entry *dir_rename_ent;
+		struct collision_entry *collision_ent;
+		char *new_path;
+		struct diff_filepair *pair =3D pairs->queue[i];
+
+		if (pair->status =3D=3D 'D')
+			continue;
+		dir_rename_ent =3D check_dir_renamed(pair->two->path,
+						   dir_renames);
+		if (!dir_rename_ent)
+			continue;
+
+		new_path =3D apply_dir_rename(dir_rename_ent, pair->two->path);
+		if (!new_path)
+			/*
+			 * dir_rename_ent->non_unique_new_path is true, which
+			 * means there is no directory rename for us to use,
+			 * which means it won't cause us any additional
+			 * collisions.
+			 */
+			continue;
+		collision_ent =3D collision_find_entry(collisions, new_path);
+		if (!collision_ent) {
+			collision_ent =3D xcalloc(1,
+						sizeof(struct collision_entry));
+			hashmap_entry_init(collision_ent, strhash(new_path));
+			hashmap_put(collisions, collision_ent);
+			collision_ent->target_file =3D new_path;
+		} else {
+			free(new_path);
+		}
+		string_list_insert(&collision_ent->source_files,
+				   pair->two->path);
+	}
+}
+
 /*
  * Get information of all renames which occurred in 'pairs', making use =
of
  * any implicit directory renames inferred from the other side of histor=
y.
@@ -1672,6 +1775,7 @@ static struct hashmap *get_directory_renames(struct=
 diff_queue_struct *pairs,
  */
 static struct string_list *get_renames(struct merge_options *o,
 				       struct diff_queue_struct *pairs,
+				       struct hashmap *dir_renames,
 				       struct tree *tree,
 				       struct tree *o_tree,
 				       struct tree *a_tree,
@@ -1679,8 +1783,12 @@ static struct string_list *get_renames(struct merg=
e_options *o,
 				       struct string_list *entries)
 {
 	int i;
+	struct hashmap collisions;
+	struct hashmap_iter iter;
+	struct collision_entry *e;
 	struct string_list *renames;
=20
+	compute_collisions(&collisions, dir_renames, pairs);
 	renames =3D xcalloc(1, sizeof(struct string_list));
=20
 	for (i =3D 0; i < pairs->nr; ++i) {
@@ -1711,6 +1819,13 @@ static struct string_list *get_renames(struct merg=
e_options *o,
 		item =3D string_list_insert(renames, pair->one->path);
 		item->util =3D re;
 	}
+
+	hashmap_iter_init(&collisions, &iter);
+	while ((e =3D hashmap_iter_next(&iter))) {
+		free(e->target_file);
+		string_list_clear(&e->source_files, 0);
+	}
+	hashmap_free(&collisions, 1);
 	return renames;
 }
=20
@@ -2020,9 +2135,11 @@ static int handle_renames(struct merge_options *o,
 					 dir_re_head, head,
 					 dir_re_merge, merge);
=20
-	ri->head_renames  =3D get_renames(o, head_pairs, head,
-					 common, head, merge, entries);
-	ri->merge_renames =3D get_renames(o, merge_pairs, merge,
+	ri->head_renames  =3D get_renames(o, head_pairs,
+					dir_re_merge, head,
+					common, head, merge, entries);
+	ri->merge_renames =3D get_renames(o, merge_pairs,
+					dir_re_head, merge,
 					 common, head, merge, entries);
 	clean =3D process_renames(o, ri->head_renames, ri->merge_renames);
=20
--=20
2.16.1.106.gf69932adfe

