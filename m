Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF44E1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162366AbeBNSws (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:52:48 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38962 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1162339AbeBNSwg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Feb 2018 13:52:36 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1EInD7v002757;
        Wed, 14 Feb 2018 10:52:08 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2g1yfs77a0-1;
        Wed, 14 Feb 2018 10:52:08 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id DC928225EF54;
        Wed, 14 Feb 2018 10:52:07 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id D61A82CDEB4;
        Wed, 14 Feb 2018 10:52:07 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v8 26/29] merge-recursive: fix remaining directory rename + dirty overwrite cases
Date:   Wed, 14 Feb 2018 10:52:03 -0800
Message-Id: <20180214185206.15492-27-newren@gmail.com>
X-Mailer: git-send-email 2.16.1.232.g28d5be9217
In-Reply-To: <20180214185206.15492-1-newren@gmail.com>
References: <20180214185206.15492-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1802140219
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 25 ++++++++++++++++++++++---
 t/t6043-merge-rename-directories.sh |  8 ++++----
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4532b982a4..6ff54c0e86 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1323,11 +1323,22 @@ static int handle_file(struct merge_options *o,
=20
 	add =3D filespec_from_entry(&other, dst_entry, stage ^ 1);
 	if (add) {
+		int ren_src_was_dirty =3D was_dirty(o, rename->path);
 		char *add_name =3D unique_path(o, rename->path, other_branch);
 		if (update_file(o, 0, &add->oid, add->mode, add_name))
 			return -1;
=20
-		remove_file(o, 0, rename->path, 0);
+		if (ren_src_was_dirty) {
+			output(o, 1, _("Refusing to lose dirty file at %s"),
+			       rename->path);
+		}
+		/*
+		 * Because the double negatives somehow keep confusing me...
+		 *    1) update_wd iff !ren_src_was_dirty.
+		 *    2) no_wd iff !update_wd
+		 *    3) so, no_wd =3D=3D !!ren_src_was_dirty =3D=3D ren_src_was_dirty
+		 */
+		remove_file(o, 0, rename->path, ren_src_was_dirty);
 		dst_name =3D unique_path(o, rename->path, cur_branch);
 	} else {
 		if (dir_in_way(rename->path, !o->call_depth, 0)) {
@@ -1465,7 +1476,10 @@ static int conflict_rename_rename_2to1(struct merg=
e_options *o,
 		char *new_path2 =3D unique_path(o, path, ci->branch2);
 		output(o, 1, _("Renaming %s to %s and %s to %s instead"),
 		       a->path, new_path1, b->path, new_path2);
-		if (would_lose_untracked(path))
+		if (was_dirty(o, path))
+			output(o, 1, _("Refusing to lose dirty file at %s"),
+			       path);
+		else if (would_lose_untracked(path))
 			/*
 			 * Only way we get here is if both renames were from
 			 * a directory rename AND user had an untracked file
@@ -2074,6 +2088,7 @@ static void apply_directory_rename_modifications(st=
ruct merge_options *o,
 {
 	struct string_list_item *item;
 	int stage =3D (tree =3D=3D a_tree ? 2 : 3);
+	int update_wd;
=20
 	/*
 	 * In all cases where we can do directory rename detection,
@@ -2084,7 +2099,11 @@ static void apply_directory_rename_modifications(s=
truct merge_options *o,
 	 * saying the file would have been overwritten), but it might
 	 * be dirty, though.
 	 */
-	remove_file(o, 1, pair->two->path, 0 /* no_wd */);
+	update_wd =3D !was_dirty(o, pair->two->path);
+	if (!update_wd)
+		output(o, 1, _("Refusing to lose dirty file at %s"),
+		       pair->two->path);
+	remove_file(o, 1, pair->two->path, !update_wd);
=20
 	/* Find or create a new re->dst_entry */
 	item =3D string_list_lookup(entries, new_path);
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-d=
irectories.sh
index b94ba066fe..33e2649824 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -3370,7 +3370,7 @@ test_expect_success '11b-setup: Avoid losing dirty =
file involved in directory re
 	)
 '
=20
-test_expect_failure '11b-check: Avoid losing dirty file involved in dire=
ctory rename' '
+test_expect_success '11b-check: Avoid losing dirty file involved in dire=
ctory rename' '
 	(
 		cd 11b &&
=20
@@ -3512,7 +3512,7 @@ test_expect_success '11d-setup: Avoid losing not-up=
todate with rename + D/F conf
 	)
 '
=20
-test_expect_failure '11d-check: Avoid losing not-uptodate with rename + =
D/F conflict' '
+test_expect_success '11d-check: Avoid losing not-uptodate with rename + =
D/F conflict' '
 	(
 		cd 11d &&
=20
@@ -3591,7 +3591,7 @@ test_expect_success '11e-setup: Avoid deleting not-=
uptodate with dir rename/rena
 	)
 '
=20
-test_expect_failure '11e-check: Avoid deleting not-uptodate with dir ren=
ame/rename(1to2)/add' '
+test_expect_success '11e-check: Avoid deleting not-uptodate with dir ren=
ame/rename(1to2)/add' '
 	(
 		cd 11e &&
=20
@@ -3667,7 +3667,7 @@ test_expect_success '11f-setup: Avoid deleting not-=
uptodate with dir rename/rena
 	)
 '
=20
-test_expect_failure '11f-check: Avoid deleting not-uptodate with dir ren=
ame/rename(2to1)' '
+test_expect_success '11f-check: Avoid deleting not-uptodate with dir ren=
ame/rename(2to1)' '
 	(
 		cd 11f &&
=20
--=20
2.16.1.232.g28d5be9217

