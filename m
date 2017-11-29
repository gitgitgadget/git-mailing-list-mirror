Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DBAE20954
	for <e@80x24.org>; Wed, 29 Nov 2017 01:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753188AbdK2Bnm (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 20:43:42 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:55322 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752599AbdK2BnK (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2017 20:43:10 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAT1dPG8005251;
        Tue, 28 Nov 2017 17:42:39 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ef78pmm14-1;
        Tue, 28 Nov 2017 17:42:39 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 1135222157D1;
        Tue, 28 Nov 2017 17:42:39 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 07F272CDE74;
        Tue, 28 Nov 2017 17:42:39 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 26/34] merge-recursive: check for file level conflicts then get new name
Date:   Tue, 28 Nov 2017 17:42:29 -0800
Message-Id: <20171129014237.32570-27-newren@gmail.com>
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

Before trying to apply directory renames to paths within the given
directories, we want to make sure that there aren't conflicts at the
file level either.  If there aren't any, then get the new name from
any directory renames.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 174 ++++++++++++++++++++++++++++++=
++++--
 strbuf.c                            |  16 ++++
 strbuf.h                            |  16 ++++
 t/t6043-merge-rename-directories.sh |   2 +-
 4 files changed, 199 insertions(+), 9 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 9e31baaf33..78f707d0d7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1508,6 +1508,91 @@ static void remove_hashmap_entries(struct hashmap =
*dir_renames,
 	string_list_clear(items_to_remove, 0);
 }
=20
+/*
+ * See if there is a directory rename for path, and if there are any fil=
e
+ * level conflicts for the renamed location.  If there is a rename and
+ * there are no conflicts, return the new name.  Otherwise, return NULL.
+ */
+static char *handle_path_level_conflicts(struct merge_options *o,
+					 const char *path,
+					 struct dir_rename_entry *entry,
+					 struct hashmap *collisions,
+					 struct tree *tree)
+{
+	char *new_path =3D NULL;
+	struct collision_entry *collision_ent;
+	int clean =3D 1;
+	struct strbuf collision_paths =3D STRBUF_INIT;
+
+	/*
+	 * entry has the mapping of old directory name to new directory name
+	 * that we want to apply to path.
+	 */
+	new_path =3D apply_dir_rename(entry, path);
+
+	if (!new_path) {
+		/* This should only happen when entry->non_unique_new_dir set */
+		if (!entry->non_unique_new_dir)
+			BUG("entry->non_unqiue_dir not set and !new_path");
+		output(o, 1, _("CONFLICT (directory rename split): "
+			       "Unclear where to place %s because directory "
+			       "%s was renamed to multiple other directories, "
+			       "with no destination getting a majority of the "
+			       "files."),
+		       path, entry->dir);
+		clean =3D 0;
+		return NULL;
+	}
+
+	/*
+	 * The caller needs to have ensured that it has pre-populated
+	 * collisions with all paths that map to new_path.  Do a quick check
+	 * to ensure that's the case.
+	 */
+	collision_ent =3D collision_find_entry(collisions, new_path);
+	if (collision_ent =3D=3D NULL)
+		BUG("collision_ent is NULL");
+
+	/*
+	 * Check for one-sided add/add/.../add conflicts, i.e.
+	 * where implicit renames from the other side doing
+	 * directory rename(s) can affect this side of history
+	 * to put multiple paths into the same location.  Warn
+	 * and bail on directory renames for such paths.
+	 */
+	if (collision_ent->reported_already) {
+		clean =3D 0;
+	} else if (tree_has_path(tree, new_path)) {
+		collision_ent->reported_already =3D 1;
+		strbuf_add_separated_string_list(&collision_paths, ", ",
+						 &collision_ent->source_files);
+		output(o, 1, _("CONFLICT (implicit dir rename): Existing "
+			       "file/dir at %s in the way of implicit "
+			       "directory rename(s) putting the following "
+			       "path(s) there: %s."),
+		       new_path, collision_paths.buf);
+		clean =3D 0;
+	} else if (collision_ent->source_files.nr > 1) {
+		collision_ent->reported_already =3D 1;
+		strbuf_add_separated_string_list(&collision_paths, ", ",
+						 &collision_ent->source_files);
+		output(o, 1, _("CONFLICT (implicit dir rename): Cannot map "
+			       "more than one path to %s; implicit directory "
+			       "renames tried to put these paths there: %s"),
+		       new_path, collision_paths.buf);
+		clean =3D 0;
+	}
+
+	/* Free memory we no longer need */
+	strbuf_release(&collision_paths);
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
  *   1. Check for both sides renaming to the same thing, in order to avo=
id
@@ -1757,6 +1842,59 @@ static void compute_collisions(struct hashmap *col=
lisions,
 	}
 }
=20
+static char *check_for_directory_rename(struct merge_options *o,
+					const char *path,
+					struct tree *tree,
+					struct hashmap *dir_renames,
+					struct hashmap *dir_rename_exclusions,
+					struct hashmap *collisions,
+					int *clean_merge)
+{
+	char *new_path =3D NULL;
+	struct dir_rename_entry *entry =3D check_dir_renamed(path, dir_renames)=
;
+	struct dir_rename_entry *oentry =3D NULL;
+
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
+	oentry =3D dir_rename_find_entry(dir_rename_exclusions, entry->new_dir.=
buf);
+	if (oentry) {
+		output(o, 1, _("WARNING: Avoiding applying %s -> %s rename "
+			       "to %s, because %s itself was renamed."),
+		       entry->dir, entry->new_dir.buf, path, entry->new_dir.buf);
+	} else {
+		new_path =3D handle_path_level_conflicts(o, path, entry,
+						       collisions, tree);
+		*clean_merge &=3D (new_path !=3D NULL);
+	}
+
+	return new_path;
+}
+
 /*
  * Get information of all renames which occurred in 'pairs', making use =
of
  * any implicit directory renames inferred from the other side of histor=
y.
@@ -1767,11 +1905,13 @@ static void compute_collisions(struct hashmap *co=
llisions,
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
@@ -1786,11 +1926,22 @@ static struct string_list *get_renames(struct mer=
ge_options *o,
 		struct string_list_item *item;
 		struct rename *re;
 		struct diff_filepair *pair =3D pairs->queue[i];
+		char *new_path; /* non-NULL only with directory renames */
=20
-		if (pair->status !=3D 'R') {
+		if (pair->status =3D=3D 'D') {
+			diff_free_filepair(pair);
+			continue;
+		}
+		new_path =3D check_for_directory_rename(o, pair->two->path, tree,
+						      dir_renames,
+						      dir_rename_exclusions,
+						      &collisions,
+						      clean_merge);
+		if (pair->status !=3D 'R' && !new_path) {
 			diff_free_filepair(pair);
 			continue;
 		}
+
 		re =3D xmalloc(sizeof(*re));
 		re->processed =3D 0;
 		re->pair =3D pair;
@@ -2108,7 +2259,7 @@ static int handle_renames(struct merge_options *o,
 {
 	struct diff_queue_struct *head_pairs, *merge_pairs;
 	struct hashmap *dir_re_head, *dir_re_merge;
-	int clean;
+	int clean =3D 1;
=20
 	ri->head_renames =3D NULL;
 	ri->merge_renames =3D NULL;
@@ -2127,13 +2278,20 @@ static int handle_renames(struct merge_options *o=
,
 					 dir_re_merge, merge);
=20
 	ri->head_renames  =3D get_renames(o, head_pairs,
-					dir_re_merge, head,
-					common, head, merge, entries);
+					dir_re_merge, dir_re_head, head,
+					common, head, merge, entries,
+					&clean);
+	if (clean < 0)
+		goto cleanup;
 	ri->merge_renames =3D get_renames(o, merge_pairs,
-					dir_re_head, merge,
-					 common, head, merge, entries);
-	clean =3D process_renames(o, ri->head_renames, ri->merge_renames);
+					dir_re_head, dir_re_merge, merge,
+					common, head, merge, entries,
+					&clean);
+	if (clean < 0)
+		goto cleanup;
+	clean &=3D process_renames(o, ri->head_renames, ri->merge_renames);
=20
+cleanup:
 	/*
 	 * Some cleanup is deferred until cleanup_renames() because the
 	 * data structures are still needed and referenced in
diff --git a/strbuf.c b/strbuf.c
index 323c49ceb3..6ae384f9cd 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "refs.h"
+#include "string-list.h"
 #include "utf8.h"
=20
 int starts_with(const char *str, const char *prefix)
@@ -141,6 +142,21 @@ struct strbuf **strbuf_split_buf(const char *str, si=
ze_t slen,
 	return ret;
 }
=20
+void strbuf_add_separated_string_list(struct strbuf *str,
+				      const char *sep,
+				      struct string_list *slist)
+{
+	struct string_list_item *item;
+	int sep_needed =3D 0;
+
+	for_each_string_list_item(item, slist) {
+		if (sep_needed)
+			strbuf_addstr(str, sep);
+		strbuf_addstr(str, item->string);
+		sep_needed =3D 1;
+	}
+}
+
 void strbuf_list_free(struct strbuf **sbs)
 {
 	struct strbuf **s =3D sbs;
diff --git a/strbuf.h b/strbuf.h
index 0a74acb236..fd6d787a7b 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -1,6 +1,8 @@
 #ifndef STRBUF_H
 #define STRBUF_H
=20
+struct string_list;
+
 /**
  * strbuf's are meant to be used with all the usual C string and memory
  * APIs. Given that the length of the buffer is known, it's often better=
 to
@@ -537,6 +539,20 @@ static inline struct strbuf **strbuf_split(const str=
uct strbuf *sb,
 	return strbuf_split_max(sb, terminator, 0);
 }
=20
+/*
+ * Adds all strings of a string list to the strbuf, separated by the giv=
en
+ * separator.  For example, if sep is
+ *   ', '
+ * and slist contains
+ *   ['element1', 'element2', ..., 'elementN'],
+ * then write:
+ *   'element1, element2, ..., elementN'
+ * to str.  If only one element, just write "element1" to str.
+ */
+extern void strbuf_add_separated_string_list(struct strbuf *str,
+					     const char *sep,
+					     struct string_list *slist);
+
 /**
  * Free a NULL-terminated list of strbufs (for example, the return
  * values of the strbuf_split*() functions).
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-d=
irectories.sh
index 0644b95ec5..836e57c0a3 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -477,7 +477,7 @@ test_expect_success '2a-setup: Directory split into t=
wo on one side, with equal
 	)
 '
=20
-test_expect_failure '2a-check: Directory split into two on one side, wit=
h equal numbers of paths' '
+test_expect_success '2a-check: Directory split into two on one side, wit=
h equal numbers of paths' '
 	(
 		cd 2a &&
=20
--=20
2.15.0.408.g850bc54b15

