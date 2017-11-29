Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 798CC20954
	for <e@80x24.org>; Wed, 29 Nov 2017 01:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbdK2BnI (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 20:43:08 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:55312 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751381AbdK2BnG (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2017 20:43:06 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAT1dU0x005263;
        Tue, 28 Nov 2017 17:42:39 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ef78pmm0y-3;
        Tue, 28 Nov 2017 17:42:39 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 4070522157C2;
        Tue, 28 Nov 2017 17:42:39 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 2FF132CDF19;
        Tue, 28 Nov 2017 17:42:39 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 28/34] merge-recursive: apply necessary modifications for directory renames
Date:   Tue, 28 Nov 2017 17:42:31 -0800
Message-Id: <20171129014237.32570-29-newren@gmail.com>
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

This commit hooks together all the directory rename logic by making the
necessary changes to the rename struct, it's dst_entry, and the
diff_filepair under consideration.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 187 ++++++++++++++++++++++++++++++=
+++++-
 t/t6043-merge-rename-directories.sh |  50 +++++-----
 2 files changed, 211 insertions(+), 26 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 01934bc1e2..cdf8588c75 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -177,6 +177,7 @@ static int oid_eq(const struct object_id *a, const st=
ruct object_id *b)
=20
 enum rename_type {
 	RENAME_NORMAL =3D 0,
+	RENAME_DIR,
 	RENAME_DELETE,
 	RENAME_ONE_FILE_TO_ONE,
 	RENAME_ONE_FILE_TO_TWO,
@@ -607,6 +608,7 @@ struct rename {
 	 */
 	struct stage_data *src_entry;
 	struct stage_data *dst_entry;
+	unsigned add_turned_into_rename:1;
 	unsigned processed:1;
 };
=20
@@ -641,6 +643,27 @@ static int update_stages(struct merge_options *opt, =
const char *path,
 	return 0;
 }
=20
+static int update_stages_for_stage_data(struct merge_options *opt,
+					const char *path,
+					const struct stage_data *stage_data)
+{
+	struct diff_filespec o, a, b;
+
+	o.mode =3D stage_data->stages[1].mode;
+	oidcpy(&o.oid, &stage_data->stages[1].oid);
+
+	a.mode =3D stage_data->stages[2].mode;
+	oidcpy(&a.oid, &stage_data->stages[2].oid);
+
+	b.mode =3D stage_data->stages[3].mode;
+	oidcpy(&b.oid, &stage_data->stages[3].oid);
+
+	return update_stages(opt, path,
+			     is_null_sha1(o.oid.hash) ? NULL : &o,
+			     is_null_sha1(a.oid.hash) ? NULL : &a,
+			     is_null_sha1(b.oid.hash) ? NULL : &b);
+}
+
 static void update_entry(struct stage_data *entry,
 			 struct diff_filespec *o,
 			 struct diff_filespec *a,
@@ -1108,6 +1131,18 @@ static int merge_file_one(struct merge_options *o,
 	return merge_file_1(o, &one, &a, &b, branch1, branch2, mfi);
 }
=20
+static int conflict_rename_dir(struct merge_options *o,
+			       struct diff_filepair *pair,
+			       const char *rename_branch,
+			       const char *other_branch)
+{
+	const struct diff_filespec *dest =3D pair->two;
+
+	if (update_file(o, 1, &dest->oid, dest->mode, dest->path))
+		return -1;
+	return 0;
+}
+
 static int handle_change_delete(struct merge_options *o,
 				 const char *path, const char *old_path,
 				 const struct object_id *o_oid, int o_mode,
@@ -1377,6 +1412,24 @@ static int conflict_rename_rename_2to1(struct merg=
e_options *o,
 		if (!ret)
 			ret =3D update_file(o, 0, &mfi_c2.oid, mfi_c2.mode,
 					  new_path2);
+		/*
+		 * unpack_trees() actually populates the index for us for
+		 * "normal" rename/rename(2to1) situtations so that the
+		 * correct entries are at the higher stages, which would
+		 * make the call below to update_stages_for_stage_data
+		 * unnecessary.  However, if either of the renames came
+		 * from a directory rename, then unpack_trees() will not
+		 * have gotten the right data loaded into the index, so we
+		 * need to do so now.  (While it'd be tempting to move this
+		 * call to update_stages_for_stage_data() to
+		 * apply_directory_rename_modifications(), that would break
+		 * our intermediate calls to would_lose_untracked() since
+		 * those rely on the current in-memory index.  See also the
+		 * big "NOTE" in update_stages()).
+		 */
+		if (update_stages_for_stage_data(o, path, ci->dst_entry1))
+			ret =3D -1;
+
 		free(new_path2);
 		free(new_path1);
 	}
@@ -1910,6 +1963,111 @@ static char *check_for_directory_rename(struct me=
rge_options *o,
 	return new_path;
 }
=20
+static void apply_directory_rename_modifications(struct merge_options *o=
,
+						 struct diff_filepair *pair,
+						 char *new_path,
+						 struct rename *re,
+						 struct tree *tree,
+						 struct tree *o_tree,
+						 struct tree *a_tree,
+						 struct tree *b_tree,
+						 struct string_list *entries,
+						 int *clean)
+{
+	struct string_list_item *item;
+	int stage =3D (tree =3D=3D a_tree ? 2 : 3);
+
+	/*
+	 * In all cases where we can do directory rename detection,
+	 * unpack_trees() will have read pair->two->path into the
+	 * index and the working copy.  We need to remove it so that
+	 * we can instead place it at new_path.  It is guaranteed to
+	 * not be untracked (unpack_trees() would have errored out
+	 * saying the file would have been overwritten), but it might
+	 * be dirty, though.
+	 */
+	remove_file(o, 1, pair->two->path, 0 /* no_wd */);
+
+	/* Find or create a new re->dst_entry */
+	item =3D string_list_lookup(entries, new_path);
+	if (item) {
+		/*
+		 * Since we're renaming on this side of history, and it's
+		 * due to a directory rename on the other side of history
+		 * (which we only allow when the directory in question no
+		 * longer exists on the other side of history), the
+		 * original entry for re->dst_entry is no longer
+		 * necessary...
+		 */
+		re->dst_entry->processed =3D 1;
+
+		/*
+		 * ...because we'll be using this new one.
+		 */
+		re->dst_entry =3D item->util;
+	} else {
+		/*
+		 * re->dst_entry is for the before-dir-rename path, and we
+		 * need it to hold information for the after-dir-rename
+		 * path.  Before creating a new entry, we need to mark the
+		 * old one as unnecessary (...unless it is shared by
+		 * src_entry, i.e. this didn't use to be a rename, in which
+		 * case we can just allow the normal processing to happen
+		 * for it).
+		 */
+		if (pair->status =3D=3D 'R')
+			re->dst_entry->processed =3D 1;
+
+		re->dst_entry =3D insert_stage_data(new_path,
+						  o_tree, a_tree, b_tree,
+						  entries);
+		item =3D string_list_insert(entries, new_path);
+		item->util =3D re->dst_entry;
+	}
+
+	/*
+	 * Update the stage_data with the information about the path we are
+	 * moving into place.  That slot will be empty and available for us
+	 * to write to because of the collision checks in
+	 * handle_path_level_conflicts().  In other words,
+	 * re->dst_entry->stages[stage].oid will be the null_oid, so it's
+	 * open for us to write to.
+	 *
+	 * It may be tempting to actually update the index at this point as
+	 * well, using update_stages_for_stage_data(), but as per the big
+	 * "NOTE" in update_stages(), doing so will modify the current
+	 * in-memory index which will break calls to would_lose_untracked()
+	 * that we need to make.  Instead, we need to just make sure that
+	 * the various conflict_rename_*() functions update the index
+	 * explicitly rather than relying on unpack_trees() to have done it.
+	 */
+	get_tree_entry(tree->object.oid.hash,
+		       pair->two->path,
+		       re->dst_entry->stages[stage].oid.hash,
+		       &re->dst_entry->stages[stage].mode);
+
+	/* Update pair status */
+	if (pair->status =3D=3D 'A') {
+		/*
+		 * Recording rename information for this add makes it look
+		 * like a rename/delete conflict.  Make sure we can
+		 * correctly handle this as an add that was moved to a new
+		 * directory instead of reporting a rename/delete conflict.
+		 */
+		re->add_turned_into_rename =3D 1;
+	}
+	/*
+	 * We don't actually look at pair->status again, but it seems
+	 * pedagogically correct to adjust it.
+	 */
+	pair->status =3D 'R';
+
+	/*
+	 * Finally, record the new location.
+	 */
+	pair->two->path =3D new_path;
+}
+
 /*
  * Get information of all renames which occurred in 'pairs', making use =
of
  * any implicit directory renames inferred from the other side of histor=
y.
@@ -1959,6 +2117,7 @@ static struct string_list *get_renames(struct merge=
_options *o,
=20
 		re =3D xmalloc(sizeof(*re));
 		re->processed =3D 0;
+		re->add_turned_into_rename =3D 0;
 		re->pair =3D pair;
 		item =3D string_list_lookup(entries, re->pair->one->path);
 		if (!item)
@@ -1975,6 +2134,12 @@ static struct string_list *get_renames(struct merg=
e_options *o,
 			re->dst_entry =3D item->util;
 		item =3D string_list_insert(renames, pair->one->path);
 		item->util =3D re;
+		if (new_path)
+			apply_directory_rename_modifications(o, pair, new_path,
+							     re, tree, o_tree,
+							     a_tree, b_tree,
+							     entries,
+							     clean_merge);
 	}
=20
 	hashmap_iter_init(&collisions, &iter);
@@ -2144,7 +2309,19 @@ static int process_renames(struct merge_options *o=
,
 			dst_other.mode =3D ren1->dst_entry->stages[other_stage].mode;
 			try_merge =3D 0;
=20
-			if (oid_eq(&src_other.oid, &null_oid)) {
+			if (oid_eq(&src_other.oid, &null_oid) &&
+			    ren1->add_turned_into_rename) {
+				setup_rename_conflict_info(RENAME_DIR,
+							   ren1->pair,
+							   NULL,
+							   branch1,
+							   branch2,
+							   ren1->dst_entry,
+							   NULL,
+							   o,
+							   NULL,
+							   NULL);
+			} else if (oid_eq(&src_other.oid, &null_oid)) {
 				setup_rename_conflict_info(RENAME_DELETE,
 							   ren1->pair,
 							   NULL,
@@ -2561,6 +2738,14 @@ static int process_entry(struct merge_options *o,
 						    o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
 						    conflict_info);
 			break;
+		case RENAME_DIR:
+			clean_merge =3D 1;
+			if (conflict_rename_dir(o,
+						conflict_info->pair1,
+						conflict_info->branch1,
+						conflict_info->branch2))
+				clean_merge =3D -1;
+			break;
 		case RENAME_DELETE:
 			clean_merge =3D 0;
 			if (conflict_rename_delete(o,
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-d=
irectories.sh
index 836e57c0a3..261fb4917d 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -69,7 +69,7 @@ test_expect_success '1a-setup: Simple directory rename =
detection' '
 	)
 '
=20
-test_expect_failure '1a-check: Simple directory rename detection' '
+test_expect_success '1a-check: Simple directory rename detection' '
 	(
 		cd 1a &&
=20
@@ -131,7 +131,7 @@ test_expect_success '1b-setup: Merge a directory with=
 another' '
 	)
 '
=20
-test_expect_failure '1b-check: Merge a directory with another' '
+test_expect_success '1b-check: Merge a directory with another' '
 	(
 		cd 1b &&
=20
@@ -188,7 +188,7 @@ test_expect_success '1c-setup: Transitive renaming' '
 	)
 '
=20
-test_expect_failure '1c-check: Transitive renaming' '
+test_expect_success '1c-check: Transitive renaming' '
 	(
 		cd 1c &&
=20
@@ -256,7 +256,7 @@ test_expect_success '1d-setup: Directory renames caus=
e a rename/rename(2to1) con
 	)
 '
=20
-test_expect_failure '1d-check: Directory renames cause a rename/rename(2=
to1) conflict' '
+test_expect_success '1d-check: Directory renames cause a rename/rename(2=
to1) conflict' '
 	(
 		cd 1d &&
=20
@@ -332,7 +332,7 @@ test_expect_success '1e-setup: Renamed directory, wit=
h all files being renamed t
 	)
 '
=20
-test_expect_failure '1e-check: Renamed directory, with all files being r=
enamed too' '
+test_expect_success '1e-check: Renamed directory, with all files being r=
enamed too' '
 	(
 		cd 1e &&
=20
@@ -397,7 +397,7 @@ test_expect_success '1f-setup: Split a directory into=
 two other directories' '
 	)
 '
=20
-test_expect_failure '1f-check: Split a directory into two other director=
ies' '
+test_expect_success '1f-check: Split a directory into two other director=
ies' '
 	(
 		cd 1f &&
=20
@@ -875,7 +875,7 @@ test_expect_success '5a-setup: Merge directories, oth=
er side adds files to origi
 	)
 '
=20
-test_expect_failure '5a-check: Merge directories, other side adds files =
to original and target' '
+test_expect_success '5a-check: Merge directories, other side adds files =
to original and target' '
 	(
 		cd 5a &&
=20
@@ -949,7 +949,7 @@ test_expect_success '5b-setup: Rename/delete in order=
 to get add/add/add conflic
 	)
 '
=20
-test_expect_failure '5b-check: Rename/delete in order to get add/add/add=
 conflict' '
+test_expect_success '5b-check: Rename/delete in order to get add/add/add=
 conflict' '
 	(
 		cd 5b &&
=20
@@ -1026,7 +1026,7 @@ test_expect_success '5c-setup: Transitive rename wo=
uld cause rename/rename/renam
 	)
 '
=20
-test_expect_failure '5c-check: Transitive rename would cause rename/rena=
me/rename/add/add/add' '
+test_expect_success '5c-check: Transitive rename would cause rename/rena=
me/rename/add/add/add' '
 	(
 		cd 5c &&
=20
@@ -1108,7 +1108,7 @@ test_expect_success '5d-setup: Directory/file/file =
conflict due to directory ren
 	)
 '
=20
-test_expect_failure '5d-check: Directory/file/file conflict due to direc=
tory rename' '
+test_expect_success '5d-check: Directory/file/file conflict due to direc=
tory rename' '
 	(
 		cd 5d &&
=20
@@ -1526,7 +1526,7 @@ test_expect_success '7a-setup: rename-dir vs. renam=
e-dir (NOT split evenly) PLUS
 	)
 '
=20
-test_expect_failure '7a-check: rename-dir vs. rename-dir (NOT split even=
ly) PLUS add-other-file' '
+test_expect_success '7a-check: rename-dir vs. rename-dir (NOT split even=
ly) PLUS add-other-file' '
 	(
 		cd 7a &&
=20
@@ -1597,7 +1597,7 @@ test_expect_success '7b-setup: rename/rename(2to1),=
 but only due to transitive r
 	)
 '
=20
-test_expect_failure '7b-check: rename/rename(2to1), but only due to tran=
sitive rename' '
+test_expect_success '7b-check: rename/rename(2to1), but only due to tran=
sitive rename' '
 	(
 		cd 7b &&
=20
@@ -1670,7 +1670,7 @@ test_expect_success '7c-setup: rename/rename(1to...=
2or3); transitive rename may
 	)
 '
=20
-test_expect_failure '7c-check: rename/rename(1to...2or3); transitive ren=
ame may add complexity' '
+test_expect_success '7c-check: rename/rename(1to...2or3); transitive ren=
ame may add complexity' '
 	(
 		cd 7c &&
=20
@@ -1731,7 +1731,7 @@ test_expect_success '7d-setup: transitive rename in=
volved in rename/delete; how
 	)
 '
=20
-test_expect_failure '7d-check: transitive rename involved in rename/dele=
te; how is it reported?' '
+test_expect_success '7d-check: transitive rename involved in rename/dele=
te; how is it reported?' '
 	(
 		cd 7d &&
=20
@@ -1818,7 +1818,7 @@ test_expect_success '7e-setup: transitive rename in=
 rename/delete AND dirs in th
 	)
 '
=20
-test_expect_failure '7e-check: transitive rename in rename/delete AND di=
rs in the way' '
+test_expect_success '7e-check: transitive rename in rename/delete AND di=
rs in the way' '
 	(
 		cd 7e &&
=20
@@ -1904,7 +1904,7 @@ test_expect_success '8a-setup: Dual-directory renam=
e, one into the others way' '
 	)
 '
=20
-test_expect_failure '8a-check: Dual-directory rename, one into the other=
s way' '
+test_expect_success '8a-check: Dual-directory rename, one into the other=
s way' '
 	(
 		cd 8a &&
=20
@@ -2043,7 +2043,7 @@ test_expect_success '8c-setup: rename+modify/delete=
' '
 	)
 '
=20
-test_expect_failure '8c-check: rename+modify/delete' '
+test_expect_success '8c-check: rename+modify/delete' '
 	(
 		cd 8c &&
=20
@@ -2127,7 +2127,7 @@ test_expect_success '8d-setup: rename/delete...or n=
ot?' '
 	)
 '
=20
-test_expect_failure '8d-check: rename/delete...or not?' '
+test_expect_success '8d-check: rename/delete...or not?' '
 	(
 		cd 8d &&
=20
@@ -2201,7 +2201,7 @@ test_expect_success '8e-setup: Both sides rename, o=
ne side adds to original dire
 	)
 '
=20
-test_expect_failure '8e-check: Both sides rename, one side adds to origi=
nal directory' '
+test_expect_success '8e-check: Both sides rename, one side adds to origi=
nal directory' '
 	(
 		cd 8e &&
=20
@@ -2288,7 +2288,7 @@ test_expect_success '9a-setup: Inner renamed direct=
ory within outer renamed dire
 	)
 '
=20
-test_expect_failure '9a-check: Inner renamed directory within outer rena=
med directory' '
+test_expect_success '9a-check: Inner renamed directory within outer rena=
med directory' '
 	(
 		cd 9a &&
=20
@@ -2355,7 +2355,7 @@ test_expect_success '9b-setup: Transitive rename wi=
th content merge' '
 	)
 '
=20
-test_expect_failure '9b-check: Transitive rename with content merge' '
+test_expect_success '9b-check: Transitive rename with content merge' '
 	(
 		cd 9b &&
=20
@@ -2444,7 +2444,7 @@ test_expect_success '9c-setup: Doubly transitive re=
name?' '
 	)
 '
=20
-test_expect_failure '9c-check: Doubly transitive rename?' '
+test_expect_success '9c-check: Doubly transitive rename?' '
 	(
 		cd 9c &&
=20
@@ -2530,7 +2530,7 @@ test_expect_success '9d-setup: N-way transitive ren=
ame?' '
 	)
 '
=20
-test_expect_failure '9d-check: N-way transitive rename?' '
+test_expect_success '9d-check: N-way transitive rename?' '
 	(
 		cd 9d &&
=20
@@ -2606,7 +2606,7 @@ test_expect_success '9e-setup: N-to-1 whammo' '
 	)
 '
=20
-test_expect_failure '9e-check: N-to-1 whammo' '
+test_expect_success '9e-check: N-to-1 whammo' '
 	(
 		cd 9e &&
=20
@@ -2681,7 +2681,7 @@ test_expect_success '9f-setup: Renamed directory th=
at only contained immediate s
 	)
 '
=20
-test_expect_failure '9f-check: Renamed directory that only contained imm=
ediate subdirs' '
+test_expect_success '9f-check: Renamed directory that only contained imm=
ediate subdirs' '
 	(
 		cd 9f &&
=20
--=20
2.15.0.408.g850bc54b15

