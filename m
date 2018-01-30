Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9142D1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 23:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932168AbeA3XpH (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 18:45:07 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:36692 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754074AbeA3XpD (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Jan 2018 18:45:03 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0UNOJZq009741;
        Tue, 30 Jan 2018 15:25:36 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2frr5qd2d6-4;
        Tue, 30 Jan 2018 15:25:35 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id B3E81221A56A;
        Tue, 30 Jan 2018 15:25:35 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id A12302CDE88;
        Tue, 30 Jan 2018 15:25:35 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com, szeder.dev@gmail.com,
        jrnieder@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 30/31] merge-recursive: avoid spurious rename/rename conflict from dir renames
Date:   Tue, 30 Jan 2018 15:25:32 -0800
Message-Id: <20180130232533.25846-31-newren@gmail.com>
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
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1801300286
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a file on one side of history was renamed, and merely modified on the
other side, then applying a directory rename to the modified side gives u=
s
a rename/rename(1to2) conflict.  We should only apply directory renames t=
o
pairs representing either adds or renames.

Making this change means that a directory rename testcase that was
previously reported as a rename/delete conflict will now be reported as a
modify/delete conflict.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   |  4 +--
 t/t6043-merge-rename-directories.sh | 55 +++++++++++++++++--------------=
------
 2 files changed, 27 insertions(+), 32 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 62e4266d21..97859e1ab7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1960,7 +1960,7 @@ static void compute_collisions(struct hashmap *coll=
isions,
 		char *new_path;
 		struct diff_filepair *pair =3D pairs->queue[i];
=20
-		if (pair->status =3D=3D 'D')
+		if (pair->status !=3D 'A' && pair->status !=3D 'R')
 			continue;
 		dir_rename_ent =3D check_dir_renamed(pair->two->path,
 						   dir_renames);
@@ -2187,7 +2187,7 @@ static struct string_list *get_renames(struct merge=
_options *o,
 		struct diff_filepair *pair =3D pairs->queue[i];
 		char *new_path; /* non-NULL only with directory renames */
=20
-		if (pair->status =3D=3D 'D') {
+		if (pair->status !=3D 'A' && pair->status !=3D 'R') {
 			diff_free_filepair(pair);
 			continue;
 		}
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-d=
irectories.sh
index 3d292f0c5f..f349f69984 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -2070,18 +2070,23 @@ test_expect_success '8b-check: Dual-directory ren=
ame, one into the others way, w
 	)
 '
=20
-# Testcase 8c, rename+modify/delete
-#   (Related to testcases 5b and 8d)
+# Testcase 8c, modify/delete or rename+modify/delete?
+#   (Related to testcases 5b, 8d, and 9h)
 #   Commit O: z/{b,c,d}
 #   Commit A: y/{b,c}
 #   Commit B: z/{b,c,d_modified,e}
-#   Expected: y/{b,c,e}, CONFLICT(rename+modify/delete: x/d -> y/d or de=
leted)
+#   Expected: y/{b,c,e}, CONFLICT(modify/delete: on z/d)
 #
-#   Note: This testcase doesn't present any concerns for me...until you
-#         compare it with testcases 5b and 8d.  See notes in 8d for more
-#         details.
-
-test_expect_success '8c-setup: rename+modify/delete' '
+#   Note: It could easily be argued that the correct resolution here is
+#         y/{b,c,e}, CONFLICT(rename/delete: z/d -> y/d vs deleted)
+#         and that the modifed version of d should be present in y/ afte=
r
+#         the merge, just marked as conflicted.  Indeed, I previously di=
d
+#         argue that.  But applying directory renames to the side of
+#         history where a file is merely modified results in spurious
+#         rename/rename(1to2) conflicts -- see testcase 9h.  See also
+#         notes in 8d.
+
+test_expect_success '8c-setup: modify/delete or rename+modify/delete?' '
 	test_create_repo 8c &&
 	(
 		cd 8c &&
@@ -2114,32 +2119,32 @@ test_expect_success '8c-setup: rename+modify/dele=
te' '
 	)
 '
=20
-test_expect_success '8c-check: rename+modify/delete' '
+test_expect_success '8c-check: modify/delete or rename+modify/delete' '
 	(
 		cd 8c &&
=20
 		git checkout A^0 &&
=20
 		test_must_fail git merge -s recursive B^0 >out &&
-		test_i18ngrep "CONFLICT (rename/delete).* z/d.*y/d" out &&
+		test_i18ngrep "CONFLICT (modify/delete).* z/d" out &&
=20
 		git ls-files -s >out &&
-		test_line_count =3D 4 out &&
+		test_line_count =3D 5 out &&
 		git ls-files -u >out &&
-		test_line_count =3D 1 out &&
+		test_line_count =3D 2 out &&
 		git ls-files -o >out &&
 		test_line_count =3D 1 out &&
=20
 		git rev-parse >actual \
-			:0:y/b :0:y/c :0:y/e :3:y/d &&
+			:0:y/b :0:y/c :0:y/e :1:z/d :3:z/d &&
 		git rev-parse >expect \
-			 O:z/b  O:z/c  B:z/e  B:z/d &&
+			 O:z/b  O:z/c  B:z/e  O:z/d  B:z/d &&
 		test_cmp expect actual &&
=20
-		test_must_fail git rev-parse :1:y/d &&
-		test_must_fail git rev-parse :2:y/d &&
-		git ls-files -s y/d | grep ^100755 &&
-		test_path_is_file y/d
+		test_must_fail git rev-parse :2:z/d &&
+		git ls-files -s z/d | grep ^100755 &&
+		test_path_is_file z/d &&
+		test_path_is_missing y/d
 	)
 '
=20
@@ -2153,16 +2158,6 @@ test_expect_success '8c-check: rename+modify/delet=
e' '
 #
 #   Note: It would also be somewhat reasonable to resolve this as
 #             y/{b,c,e}, CONFLICT(rename/delete: x/d -> y/d or deleted)
-#   The logic being that the only difference between this testcase and 8=
c
-#   is that there is no modification to d.  That suggests that instead o=
f a
-#   rename/modify vs. delete conflict, we should just have a rename/dele=
te
-#   conflict, otherwise we are being inconsistent.
-#
-#   However...as far as consistency goes, we didn't report a conflict fo=
r
-#   path d_1 in testcase 5b due to a different file being in the way.  S=
o,
-#   we seem to be forced to have cases where users can change things
-#   slightly and get what they may perceive as inconsistent results.  It
-#   would be nice to avoid that, but I'm not sure I see how.
 #
 #   In this case, I'm leaning towards: commit A was the one that deleted=
 z/d
 #   and it did the rename of z to y, so the two "conflicts" (rename vs.
@@ -2907,7 +2902,7 @@ test_expect_success '9h-setup: Avoid dir rename on =
merely modified path' '
 	)
 '
=20
-test_expect_failure '9h-check: Avoid dir rename on merely modified path'=
 '
+test_expect_success '9h-check: Avoid dir rename on merely modified path'=
 '
 	(
 		cd 9h &&
=20
@@ -3951,7 +3946,7 @@ test_expect_success '12c-setup: Moving one director=
y hierarchy into another w/ c
 	)
 '
=20
-test_expect_failure '12c-check: Moving one directory hierarchy into anot=
her w/ content merge' '
+test_expect_success '12c-check: Moving one directory hierarchy into anot=
her w/ content merge' '
 	(
 		cd 12c &&
=20
--=20
2.16.1.106.gf69932adfe

