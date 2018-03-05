Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 501A21F404
	for <e@80x24.org>; Mon,  5 Mar 2018 17:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeCERMB (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 12:12:01 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:59032 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751818AbeCERLx (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Mar 2018 12:11:53 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w25H9StV025556;
        Mon, 5 Mar 2018 09:11:26 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2gftenb07m-1;
        Mon, 05 Mar 2018 09:11:26 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 4E3522215E1E;
        Mon,  5 Mar 2018 09:11:26 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 4586E2CDE69;
        Mon,  5 Mar 2018 09:11:26 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Somebody <somebody@ex.com>, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 4/5] merge-recursive: improve handling for rename/rename(2to1) conflicts
Date:   Mon,  5 Mar 2018 09:11:24 -0800
Message-Id: <20180305171125.22331-5-newren@gmail.com>
X-Mailer: git-send-email 2.16.0.41.g6a66043158
In-Reply-To: <20180305171125.22331-1-newren@gmail.com>
References: <20180305171125.22331-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803050200
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the rename/rename(2to1) conflicts use the new
handle_file_collision() function.  Since that function was based
originally on the rename/rename(2to1) handling code, the main
differences here are in what was added.  In particular:

  * If the two colliding files are similar, instead of being stored
    at collide_path~HEAD and collide_path~MERGE, the files are two-way
    merged and recorded at collide_path.
  * Instead of recording the version of the renamed file that existed
    on the renamed side in the index (thus ignoring any changes that
    were made to the file on the side of history without the rename),
    we do a three-way content merge on the renamed path, then store
    that at either stage 2 or stage 3.
  * Note that if either of the three-way content merges done for each
    rename have conflicts, we do NOT try to estimate the similarity of
    the resulting two files and just automatically consider them to be
    dissimilar.  This is done to avoid foisting conflicts-of-conflicts
    on the user.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                    | 101 +++++------------------------=
------
 t/t6042-merge-rename-corner-cases.sh |   2 +-
 2 files changed, 14 insertions(+), 89 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 403c0006dc..96f0e9cee2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -657,27 +657,6 @@ static int update_stages(struct merge_options *opt, =
const char *path,
 	return 0;
 }
=20
-static int update_stages_for_stage_data(struct merge_options *opt,
-					const char *path,
-					const struct stage_data *stage_data)
-{
-	struct diff_filespec o, a, b;
-
-	o.mode =3D stage_data->stages[1].mode;
-	oidcpy(&o.oid, &stage_data->stages[1].oid);
-
-	a.mode =3D stage_data->stages[2].mode;
-	oidcpy(&a.oid, &stage_data->stages[2].oid);
-
-	b.mode =3D stage_data->stages[3].mode;
-	oidcpy(&b.oid, &stage_data->stages[3].oid);
-
-	return update_stages(opt, path,
-			     is_null_oid(&o.oid) ? NULL : &o,
-			     is_null_oid(&a.oid) ? NULL : &a,
-			     is_null_oid(&b.oid) ? NULL : &b);
-}
-
 static void update_entry(struct stage_data *entry,
 			 struct diff_filespec *o,
 			 struct diff_filespec *a,
@@ -1615,7 +1594,6 @@ static int conflict_rename_rename_2to1(struct merge=
_options *o,
 	char *path =3D c1->path; /* =3D=3D c2->path */
 	struct merge_file_info mfi_c1;
 	struct merge_file_info mfi_c2;
-	int ret;
=20
 	output(o, 1, _("CONFLICT (rename/rename): "
 	       "Rename %s->%s in %s. "
@@ -1623,9 +1601,6 @@ static int conflict_rename_rename_2to1(struct merge=
_options *o,
 	       a->path, c1->path, ci->branch1,
 	       b->path, c2->path, ci->branch2);
=20
-	remove_file(o, 1, a->path, o->call_depth || would_lose_untracked(a->pat=
h));
-	remove_file(o, 1, b->path, o->call_depth || would_lose_untracked(b->pat=
h));
-
 	if (merge_file_special_markers(o, a, c1, &ci->ren1_other,
 				       o->branch1, c1->path,
 				       o->branch2, ci->ren1_other.path, &mfi_c1) ||
@@ -1634,66 +1609,11 @@ static int conflict_rename_rename_2to1(struct mer=
ge_options *o,
 				       o->branch2, c2->path, &mfi_c2))
 		return -1;
=20
-	if (o->call_depth) {
-		/*
-		 * If mfi_c1.clean && mfi_c2.clean, then it might make
-		 * sense to do a two-way merge of those results.  But, I
-		 * think in all cases, it makes sense to have the virtual
-		 * merge base just undo the renames; they can be detected
-		 * again later for the non-recursive merge.
-		 */
-		remove_file(o, 0, path, 0);
-		ret =3D update_file(o, 0, &mfi_c1.oid, mfi_c1.mode, a->path);
-		if (!ret)
-			ret =3D update_file(o, 0, &mfi_c2.oid, mfi_c2.mode,
-					  b->path);
-	} else {
-		char *new_path1 =3D unique_path(o, path, ci->branch1);
-		char *new_path2 =3D unique_path(o, path, ci->branch2);
-		output(o, 1, _("Renaming %s to %s and %s to %s instead"),
-		       a->path, new_path1, b->path, new_path2);
-		if (was_dirty(o, path))
-			output(o, 1, _("Refusing to lose dirty file at %s"),
-			       path);
-		else if (would_lose_untracked(path))
-			/*
-			 * Only way we get here is if both renames were from
-			 * a directory rename AND user had an untracked file
-			 * at the location where both files end up after the
-			 * two directory renames.  See testcase 10d of t6043.
-			 */
-			output(o, 1, _("Refusing to lose untracked file at "
-				       "%s, even though it's in the way."),
-			       path);
-		else
-			remove_file(o, 0, path, 0);
-		ret =3D update_file(o, 0, &mfi_c1.oid, mfi_c1.mode, new_path1);
-		if (!ret)
-			ret =3D update_file(o, 0, &mfi_c2.oid, mfi_c2.mode,
-					  new_path2);
-		/*
-		 * unpack_trees() actually populates the index for us for
-		 * "normal" rename/rename(2to1) situtations so that the
-		 * correct entries are at the higher stages, which would
-		 * make the call below to update_stages_for_stage_data
-		 * unnecessary.  However, if either of the renames came
-		 * from a directory rename, then unpack_trees() will not
-		 * have gotten the right data loaded into the index, so we
-		 * need to do so now.  (While it'd be tempting to move this
-		 * call to update_stages_for_stage_data() to
-		 * apply_directory_rename_modifications(), that would break
-		 * our intermediate calls to would_lose_untracked() since
-		 * those rely on the current in-memory index.  See also the
-		 * big "NOTE" in update_stages()).
-		 */
-		if (update_stages_for_stage_data(o, path, ci->dst_entry1))
-			ret =3D -1;
-
-		free(new_path2);
-		free(new_path1);
-	}
-
-	return ret;
+	return handle_file_collision(o, path, a->path, b->path,
+				     ci->branch1, ci->branch2,
+				     &mfi_c1.oid, mfi_c1.mode,
+				     &mfi_c2.oid, mfi_c2.mode,
+				     !mfi_c1.clean || !mfi_c2.clean);
 }
=20
 /*
@@ -3075,9 +2995,14 @@ static int process_entry(struct merge_options *o,
 				clean_merge =3D -1;
 			break;
 		case RENAME_TWO_FILES_TO_ONE:
-			clean_merge =3D 0;
-			if (conflict_rename_rename_2to1(o, conflict_info))
-				clean_merge =3D -1;
+			/*
+			 * Probably unclean merge, but if the two renamed
+			 * files merge cleanly and the two resulting files
+			 * can then be two-way merged cleanly, I guess it's
+			 * a clean merge?
+			 */
+			clean_merge =3D conflict_rename_rename_2to1(o,
+								  conflict_info);
 			break;
 		default:
 			entry->processed =3D 0;
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-=
corner-cases.sh
index a6c151ef95..cf5ea5a0f9 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -358,7 +358,7 @@ test_expect_success 'setup rename/rename (2to1) + mod=
ify/modify' '
 	git init &&
=20
 	printf "1\n2\n3\n4\n5\n" >a &&
-	printf "5\n4\n3\n2\n1\n" >b &&
+	printf "9\n8\n7\n6\n5\n" >b &&
 	git add a b &&
 	git commit -m A &&
 	git tag A &&
--=20
2.16.0.41.g6a66043158

