Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 757AB1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 23:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754082AbeA3XqO (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 18:46:14 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:58670 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932204AbeA3XpT (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Jan 2018 18:45:19 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0UNN1n4025717;
        Tue, 30 Jan 2018 15:25:36 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2frq6qw4dq-2;
        Tue, 30 Jan 2018 15:25:35 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 829A1221A567;
        Tue, 30 Jan 2018 15:25:35 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 79AF02CDE88;
        Tue, 30 Jan 2018 15:25:35 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com, szeder.dev@gmail.com,
        jrnieder@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 26/31] merge-recursive: avoid clobbering untracked files with directory renames
Date:   Tue, 30 Jan 2018 15:25:28 -0800
Message-Id: <20180130232533.25846-27-newren@gmail.com>
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
 mlxlogscore=736 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1801300286
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 42 +++++++++++++++++++++++++++++++=
++++--
 t/t6043-merge-rename-directories.sh |  6 +++---
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 7c78dc2dc1..39e161e094 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1147,6 +1147,26 @@ static int conflict_rename_dir(struct merge_option=
s *o,
 {
 	const struct diff_filespec *dest =3D pair->two;
=20
+	if (!o->call_depth && would_lose_untracked(dest->path)) {
+		char *alt_path =3D unique_path(o, dest->path, rename_branch);
+
+		output(o, 1, _("Error: Refusing to lose untracked file at %s; "
+			       "writing to %s instead."),
+		       dest->path, alt_path);
+		/*
+		 * Write the file in worktree at alt_path, but not in the
+		 * index.  Instead, write to dest->path for the index but
+		 * only at the higher appropriate stage.
+		 */
+		if (update_file(o, 0, &dest->oid, dest->mode, alt_path))
+			return -1;
+		free(alt_path);
+		return update_stages(o, dest->path, NULL,
+				     rename_branch =3D=3D o->branch1 ? dest : NULL,
+				     rename_branch =3D=3D o->branch1 ? NULL : dest);
+	}
+
+	/* Update dest->path both in index and in worktree */
 	if (update_file(o, 1, &dest->oid, dest->mode, dest->path))
 		return -1;
 	return 0;
@@ -1165,7 +1185,8 @@ static int handle_change_delete(struct merge_option=
s *o,
 	const char *update_path =3D path;
 	int ret =3D 0;
=20
-	if (dir_in_way(path, !o->call_depth, 0)) {
+	if (dir_in_way(path, !o->call_depth, 0) ||
+	    (!o->call_depth && would_lose_untracked(path))) {
 		update_path =3D alt_path =3D unique_path(o, path, change_branch);
 	}
=20
@@ -1291,6 +1312,12 @@ static int handle_file(struct merge_options *o,
 			dst_name =3D unique_path(o, rename->path, cur_branch);
 			output(o, 1, _("%s is a directory in %s adding as %s instead"),
 			       rename->path, other_branch, dst_name);
+		} else if (!o->call_depth &&
+			   would_lose_untracked(rename->path)) {
+			dst_name =3D unique_path(o, rename->path, cur_branch);
+			output(o, 1, _("Refusing to lose untracked file at %s; "
+				       "adding as %s instead"),
+			       rename->path, dst_name);
 		}
 	}
 	if ((ret =3D update_file(o, 0, &rename->oid, rename->mode, dst_name)))
@@ -1416,7 +1443,18 @@ static int conflict_rename_rename_2to1(struct merg=
e_options *o,
 		char *new_path2 =3D unique_path(o, path, ci->branch2);
 		output(o, 1, _("Renaming %s to %s and %s to %s instead"),
 		       a->path, new_path1, b->path, new_path2);
-		remove_file(o, 0, path, 0);
+		if (would_lose_untracked(path))
+			/*
+			 * Only way we get here is if both renames were from
+			 * a directory rename AND user had an untracked file
+			 * at the location where both files end up after the
+			 * two directory renames.  See testcase 10d of t6043.
+			 */
+			output(o, 1, _("Refusing to lose untracked file at "
+				       "%s, even though it's in the way."),
+			       path);
+		else
+			remove_file(o, 0, path, 0);
 		ret =3D update_file(o, 0, &mfi_c1.oid, mfi_c1.mode, new_path1);
 		if (!ret)
 			ret =3D update_file(o, 0, &mfi_c2.oid, mfi_c2.mode,
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-d=
irectories.sh
index b6207763cf..abb5b20f6b 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -2984,7 +2984,7 @@ test_expect_success '10b-setup: Overwrite untracked=
 with dir rename + delete' '
 	)
 '
=20
-test_expect_failure '10b-check: Overwrite untracked with dir rename + de=
lete' '
+test_expect_success '10b-check: Overwrite untracked with dir rename + de=
lete' '
 	(
 		cd 10b &&
=20
@@ -3062,7 +3062,7 @@ test_expect_success '10c-setup: Overwrite untracked=
 with dir rename/rename(1to2)
 	)
 '
=20
-test_expect_failure '10c-check: Overwrite untracked with dir rename/rena=
me(1to2)' '
+test_expect_success '10c-check: Overwrite untracked with dir rename/rena=
me(1to2)' '
 	(
 		cd 10c &&
=20
@@ -3137,7 +3137,7 @@ test_expect_success '10d-setup: Delete untracked wi=
th dir rename/rename(2to1)' '
 	)
 '
=20
-test_expect_failure '10d-check: Delete untracked with dir rename/rename(=
2to1)' '
+test_expect_success '10d-check: Delete untracked with dir rename/rename(=
2to1)' '
 	(
 		cd 10d &&
=20
--=20
2.16.1.106.gf69932adfe

