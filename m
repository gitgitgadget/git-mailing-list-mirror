Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6CFF20954
	for <e@80x24.org>; Wed, 29 Nov 2017 01:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753422AbdK2Bop (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 20:44:45 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:55610 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753396AbdK2Bon (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2017 20:44:43 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAT1dU10005263;
        Tue, 28 Nov 2017 17:42:39 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ef78pmm10-3;
        Tue, 28 Nov 2017 17:42:39 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 8A61322157CF;
        Tue, 28 Nov 2017 17:42:39 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 7BCE92CDF17;
        Tue, 28 Nov 2017 17:42:39 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 34/34] merge-recursive: ensure we write updates for directory-renamed file
Date:   Tue, 28 Nov 2017 17:42:37 -0800
Message-Id: <20171129014237.32570-35-newren@gmail.com>
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
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711290020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a file is present in HEAD before the merge and the other side of the
merge does not modify that file, we try to avoid re-writing the file and
making it stat-dirty.  However, when a file is present in HEAD before the
merge and was in a directory that was renamed by the other side of the
merge, we have to move the file to a new location and re-write it.
Update the code that checks whether we can skip the update to also work i=
n
the presence of directory renames.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 4 +---
 t/t6043-merge-rename-directories.sh | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d00786f719..16c52a4347 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2732,7 +2732,6 @@ static int merge_content(struct merge_options *o,
=20
 	if (mfi.clean && !df_conflict_remains &&
 	    oid_eq(&mfi.oid, a_oid) && mfi.mode =3D=3D a_mode) {
-		int path_renamed_outside_HEAD;
 		output(o, 3, _("Skipped %s (merged same as existing)"), path);
 		/*
 		 * The content merge resulted in the same file contents we
@@ -2740,8 +2739,7 @@ static int merge_content(struct merge_options *o,
 		 * are recorded at the correct path (which may not be true
 		 * if the merge involves a rename).
 		 */
-		path_renamed_outside_HEAD =3D !path2 || !strcmp(path, path2);
-		if (!path_renamed_outside_HEAD) {
+		if (was_tracked(path)) {
 			add_cacheinfo(o, mfi.mode, &mfi.oid, path,
 				      0, (!o->call_depth), 0);
 			return mfi.clean;
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-d=
irectories.sh
index 8ed85c79de..f64c7d273b 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -3713,7 +3713,7 @@ test_expect_success '12b-setup: Moving one director=
y hierarchy into another' '
 	)
 '
=20
-test_expect_failure '12b-check: Moving one directory hierarchy into anot=
her' '
+test_expect_success '12b-check: Moving one directory hierarchy into anot=
her' '
 	(
 		cd 12b &&
=20
--=20
2.15.0.408.g850bc54b15

