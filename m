Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B08B1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 17:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbeCERMl (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 12:12:41 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:59212 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751723AbeCERMk (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Mar 2018 12:12:40 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w25H9TDQ025564;
        Mon, 5 Mar 2018 09:11:26 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2gftenb07k-1;
        Mon, 05 Mar 2018 09:11:26 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 454142215E1C;
        Mon,  5 Mar 2018 09:11:26 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 3BACE2CDEED;
        Mon,  5 Mar 2018 09:11:26 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Somebody <somebody@ex.com>, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 3/5] merge-recursive: fix rename/add conflict handling
Date:   Mon,  5 Mar 2018 09:11:23 -0800
Message-Id: <20180305171125.22331-4-newren@gmail.com>
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

This makes the rename/add conflict handling make use of the new
handle_file_collision() function, which fixes several bugs and improves
things for the rename/add case significantly.  Previously, rename/add
would:

  * Not leave any higher order stage entries in the index, making it
    appear as if there were no conflict.
  * Would place the rename file at the colliding path, and move the
    added file elsewhere, which combined with the lack of higher order
    stage entries felt really odd.  It's not clear to me why the
    rename should take precedence over the add; if one should be moved
    out of the way, they both probably should.
  * In the recursive case, it would do a two way merge of the added
    file and the version of the renamed file on the renamed side,
    completely excluding modifications to the renamed file on the
    unrenamed side of history.

Using the new handle_file_collision() fixes all of these issues, and
adds smarts to allow two-way merge OR move colliding files to separate
paths depending on the similarity of the colliding files.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                 | 137 +++++++++++++++++++++++++++-----=
------
 t/t6036-recursive-corner-cases.sh |  19 +++---
 2 files changed, 108 insertions(+), 48 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c54b918dc8..403c0006dc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -181,6 +181,7 @@ static int oid_eq(const struct object_id *a, const st=
ruct object_id *b)
 enum rename_type {
 	RENAME_NORMAL =3D 0,
 	RENAME_DIR,
+	RENAME_ADD,
 	RENAME_DELETE,
 	RENAME_ONE_FILE_TO_ONE,
 	RENAME_ONE_FILE_TO_TWO,
@@ -223,6 +224,7 @@ static inline void setup_rename_conflict_info(enum re=
name_type rename_type,
 					      struct stage_data *src_entry1,
 					      struct stage_data *src_entry2)
 {
+	int ostage1, ostage2;
 	struct rename_conflict_info *ci =3D xcalloc(1, sizeof(struct rename_con=
flict_info));
 	ci->rename_type =3D rename_type;
 	ci->pair1 =3D pair1;
@@ -240,18 +242,22 @@ static inline void setup_rename_conflict_info(enum =
rename_type rename_type,
 		dst_entry2->rename_conflict_info =3D ci;
 	}
=20
-	if (rename_type =3D=3D RENAME_TWO_FILES_TO_ONE) {
-		/*
-		 * For each rename, there could have been
-		 * modifications on the side of history where that
-		 * file was not renamed.
-		 */
-		int ostage1 =3D o->branch1 =3D=3D branch1 ? 3 : 2;
-		int ostage2 =3D ostage1 ^ 1;
+	/*
+	 * For each rename, there could have been
+	 * modifications on the side of history where that
+	 * file was not renamed.
+	 */
+	if (rename_type =3D=3D RENAME_ADD ||
+	    rename_type =3D=3D RENAME_TWO_FILES_TO_ONE) {
+		ostage1 =3D o->branch1 =3D=3D branch1 ? 3 : 2;
=20
 		ci->ren1_other.path =3D pair1->one->path;
 		oidcpy(&ci->ren1_other.oid, &src_entry1->stages[ostage1].oid);
 		ci->ren1_other.mode =3D src_entry1->stages[ostage1].mode;
+	}
+
+	if (rename_type =3D=3D RENAME_TWO_FILES_TO_ONE) {
+		ostage2 =3D ostage1 ^ 1;
=20
 		ci->ren2_other.path =3D pair2->one->path;
 		oidcpy(&ci->ren2_other.oid, &src_entry2->stages[ostage2].oid);
@@ -1119,6 +1125,18 @@ static int merge_file_special_markers(struct merge=
_options *o,
 	char *side2 =3D NULL;
 	int ret;
=20
+	if (o->branch1 !=3D branch1) {
+		/*
+		 * It's weird getting a reverse merge with HEAD on the bottom
+		 * and the other branch on the top.  Fix that.
+		 */
+		return merge_file_special_markers(o,
+						  one, b, a,
+						  branch2, filename2,
+						  branch1, filename1,
+						  mfi);
+	}
+
 	if (filename1)
 		side1 =3D xstrfmt("%s:%s", branch1, filename1);
 	if (filename2)
@@ -1290,7 +1308,6 @@ static struct diff_filespec *filespec_from_entry(st=
ruct diff_filespec *target,
 	return target;
 }
=20
-#if 0 // #if-0-ing avoids unused function warning; will make live in nex=
t commit
 static int handle_file_collision(struct merge_options *o,
 				 const char *collide_path,
 				 const char *prev_path1,
@@ -1307,6 +1324,21 @@ static int handle_file_collision(struct merge_opti=
ons *o,
 	int minimum_score;
 	char *new_path1, *new_path2;
=20
+	/*
+	 * It's easiest to get the correct things into stage 2 and 3, and
+	 * to make sure that the content merge puts HEAD before the other
+	 * branch if we just ensure that branch1 =3D=3D o->branch1.  So, simply
+	 * flip arguments around if we don't have that.
+	 */
+	if (branch1 !=3D o->branch1) {
+		return handle_file_collision(o, collide_path,
+					     prev_path2, prev_path1,
+					     branch2, branch1,
+					     b_oid, b_mode,
+					     a_oid, a_mode,
+					     conflict_markers_already_present);
+	}
+
 	/* Remove rename sources if rename/add or rename/rename(2to1) */
 	if (prev_path1)
 		remove_file(o, 1, prev_path1,
@@ -1412,7 +1444,36 @@ static int handle_file_collision(struct merge_opti=
ons *o,
=20
 	return 0; /* not clean */
 }
-#endif
+
+static int conflict_rename_add(struct merge_options *o,
+			       struct rename_conflict_info *ci)
+{
+	/* a was renamed to c, and a separate c was added. */
+	struct diff_filespec *a =3D ci->pair1->one;
+	struct diff_filespec *c =3D ci->pair1->two;
+	char *path =3D c->path;
+	struct merge_file_info mfi;
+
+	int other_stage =3D (ci->branch1 =3D=3D o->branch1 ? 3 : 2);
+
+	output(o, 1, _("CONFLICT (rename/add): "
+	       "Rename %s->%s in %s.  Added %s in %s"),
+	       a->path, c->path, ci->branch1,
+	       c->path, ci->branch2);
+
+	if (merge_file_special_markers(o, a, c, &ci->ren1_other,
+				       o->branch1, path,
+				       o->branch2, ci->ren1_other.path, &mfi))
+		return -1;
+
+	return handle_file_collision(o,
+				     c->path, a->path, NULL,
+				     ci->branch1, ci->branch2,
+				     &mfi.oid, mfi.mode,
+				     &ci->dst_entry1->stages[other_stage].oid,
+				     ci->dst_entry1->stages[other_stage].mode,
+				     !mfi.clean);
+}
=20
 static int handle_file(struct merge_options *o,
 			struct diff_filespec *rename,
@@ -2582,36 +2643,23 @@ static int process_renames(struct merge_options *=
o,
 						      0  /* update_wd    */))
 					clean_merge =3D -1;
 			} else if (!oid_eq(&dst_other.oid, &null_oid)) {
-				clean_merge =3D 0;
-				try_merge =3D 1;
-				output(o, 1, _("CONFLICT (rename/add): Rename %s->%s in %s. "
-				       "%s added in %s"),
-				       ren1_src, ren1_dst, branch1,
-				       ren1_dst, branch2);
-				if (o->call_depth) {
-					struct merge_file_info mfi;
-					if (merge_file_one(o, ren1_dst, &null_oid, 0,
-							   &ren1->pair->two->oid,
-							   ren1->pair->two->mode,
-							   &dst_other.oid,
-							   dst_other.mode,
-							   branch1, branch2, &mfi)) {
-						clean_merge =3D -1;
-						goto cleanup_and_return;
-					}
-					output(o, 1, _("Adding merged %s"), ren1_dst);
-					if (update_file(o, 0, &mfi.oid,
-							mfi.mode, ren1_dst))
-						clean_merge =3D -1;
-					try_merge =3D 0;
-				} else {
-					char *new_path =3D unique_path(o, ren1_dst, branch2);
-					output(o, 1, _("Adding as %s instead"), new_path);
-					if (update_file(o, 0, &dst_other.oid,
-							dst_other.mode, new_path))
-						clean_merge =3D -1;
-					free(new_path);
-				}
+				/*
+				 * Probably not a clean merge, but it's
+				 * premature to set clean_merge to 0 here,
+				 * because if the rename merges cleanly and
+				 * the merge exactly matches the newly added
+				 * file, then the merge will be clean.
+				 */
+				setup_rename_conflict_info(RENAME_ADD,
+							   ren1->pair,
+							   NULL,
+							   branch1,
+							   branch2,
+							   ren1->dst_entry,
+							   NULL,
+							   o,
+							   ren1->src_entry,
+							   NULL);
 			} else
 				try_merge =3D 1;
=20
@@ -3004,6 +3052,15 @@ static int process_entry(struct merge_options *o,
 						conflict_info->branch2))
 				clean_merge =3D -1;
 			break;
+		case RENAME_ADD:
+			/*
+			 * Probably unclean merge, but if the renamed file
+			 * merges cleanly and the result can then be
+			 * two-way merged cleanly with the added file, I
+			 * guess it's a clean merge?
+			 */
+			clean_merge =3D conflict_rename_add(o, conflict_info);
+			break;
 		case RENAME_DELETE:
 			clean_merge =3D 0;
 			if (conflict_rename_delete(o,
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner=
-cases.sh
index 18aa88b5c0..09accbc62a 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -168,7 +168,7 @@ test_expect_success 'setup differently handled merges=
 of rename/add conflict' '
 	git branch B &&
 	git checkout -b C &&
 	echo 10 >>a &&
-	echo "other content" >>new_a &&
+	printf "0\n1\n2\n3\n4\n5\n6\n7\nfoobar" >new_a &&
 	git add a new_a &&
 	test_tick && git commit -m C &&
=20
@@ -179,13 +179,13 @@ test_expect_success 'setup differently handled merg=
es of rename/add conflict' '
 	git checkout B^0 &&
 	test_must_fail git merge C &&
 	git clean -f &&
+	git add new_a &&
 	test_tick && git commit -m D &&
 	git tag D &&
=20
 	git checkout C^0 &&
 	test_must_fail git merge B &&
-	rm new_a~HEAD new_a &&
-	printf "Incorrectly merged content" >>new_a &&
+	printf "0\n1\n2\n3\n4\n5\n6\n7\nbad merge" >new_a &&
 	git add -u &&
 	test_tick && git commit -m E &&
 	git tag E
@@ -204,15 +204,18 @@ test_expect_success 'git detects differently handle=
d merges conflict' '
 	test $(git rev-parse :2:new_a) =3D $(git rev-parse D:new_a) &&
 	test $(git rev-parse :3:new_a) =3D $(git rev-parse E:new_a) &&
=20
-	git cat-file -p B:new_a >>merged &&
+	# Since A:a =3D=3D B:new_a, the three-way merge of A:a, B:new_a, and
+	# C:a is just C:a.  Then we do a two-way merge of that with
+	# C:new_a.
+	git cat-file -p C:a >>merged &&
 	git cat-file -p C:new_a >>merge-me &&
 	>empty &&
 	test_must_fail git merge-file \
-		-L "Temporary merge branch 2" \
-		-L "" \
 		-L "Temporary merge branch 1" \
-		merged empty merge-me &&
-	sed -e "s/^\([<=3D>]\)/\1\1\1/" merged >merged-internal &&
+		-L "" \
+		-L "Temporary merge branch 2" \
+		merge-me empty merged &&
+	sed -e "s/^\([<=3D>]\)/\1\1\1/" merge-me >merged-internal &&
 	test $(git rev-parse :1:new_a) =3D $(git hash-object merged-internal)
 '
=20
--=20
2.16.0.41.g6a66043158

