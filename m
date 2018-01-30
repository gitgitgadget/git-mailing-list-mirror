Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 909BB1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 23:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932138AbeA3Xol (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 18:44:41 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:58542 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932130AbeA3Xoj (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Jan 2018 18:44:39 -0500
X-Greylist: delayed 1115 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jan 2018 18:44:37 EST
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0UNN7r8025766;
        Tue, 30 Jan 2018 15:25:36 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2frq6qw4dm-3;
        Tue, 30 Jan 2018 15:25:35 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 9636C221A57A;
        Tue, 30 Jan 2018 15:25:35 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 8D6492CDE88;
        Tue, 30 Jan 2018 15:25:35 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com, szeder.dev@gmail.com,
        jrnieder@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 28/31] merge-recursive: fix remaining directory rename + dirty overwrite cases
Date:   Tue, 30 Jan 2018 15:25:30 -0800
Message-Id: <20180130232533.25846-29-newren@gmail.com>
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 26 +++++++++++++++++++++++---
 t/t6043-merge-rename-directories.sh |  8 ++++----
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index fba1a0d207..62e4266d21 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1320,11 +1320,23 @@ static int handle_file(struct merge_options *o,
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
+		 * Stupid double negatives in remove_file; it somehow manages
+		 * to repeatedly mess me up.  So, just for myself:
+		 *    1) update_wd iff !ren_src_was_dirty.
+		 *    2) no_wd iff !update_wd
+		 *    3) so, no_wd =3D=3D !!ren_src_was_dirty =3D=3D ren_src_was_dirty
+		 */
+		remove_file(o, 0, rename->path, ren_src_was_dirty);
 		dst_name =3D unique_path(o, rename->path, cur_branch);
 	} else {
 		if (dir_in_way(rename->path, !o->call_depth, 0)) {
@@ -1462,7 +1474,10 @@ static int conflict_rename_rename_2to1(struct merg=
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
@@ -2042,6 +2057,7 @@ static void apply_directory_rename_modifications(st=
ruct merge_options *o,
 {
 	struct string_list_item *item;
 	int stage =3D (tree =3D=3D a_tree ? 2 : 3);
+	int update_wd;
=20
 	/*
 	 * In all cases where we can do directory rename detection,
@@ -2052,7 +2068,11 @@ static void apply_directory_rename_modifications(s=
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
index 89b2eacf38..a34c57d986 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -3362,7 +3362,7 @@ test_expect_success '11b-setup: Avoid losing dirty =
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
@@ -3504,7 +3504,7 @@ test_expect_success '11d-setup: Avoid losing not-up=
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
@@ -3583,7 +3583,7 @@ test_expect_success '11e-setup: Avoid deleting not-=
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
@@ -3659,7 +3659,7 @@ test_expect_success '11f-setup: Avoid deleting not-=
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
2.16.1.106.gf69932adfe

