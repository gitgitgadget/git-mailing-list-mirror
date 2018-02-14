Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13BD31F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162403AbeBNSxi (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:53:38 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:39170 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1162321AbeBNSxY (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Feb 2018 13:53:24 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1EInD7w002757;
        Wed, 14 Feb 2018 10:52:08 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2g1yfs77a1-1;
        Wed, 14 Feb 2018 10:52:08 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 19FDD225F0F0;
        Wed, 14 Feb 2018 10:52:08 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 0EADE2CDE88;
        Wed, 14 Feb 2018 10:52:08 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v8 29/29] merge-recursive: ensure we write updates for directory-renamed file
Date:   Wed, 14 Feb 2018 10:52:06 -0800
Message-Id: <20180214185206.15492-30-newren@gmail.com>
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

When a file is present in HEAD before the merge and the other side of the
merge does not modify that file, we try to avoid re-writing the file and
making it stat-dirty.  However, when a file is present in HEAD before the
merge and was in a directory that was renamed by the other side of the
merge, we have to move the file to a new location and re-write it.
Update the code that checks whether we can skip the update to also work i=
n
the presence of directory renames.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 4 +---
 t/t6043-merge-rename-directories.sh | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5063caabe1..ffe1d0d117 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2772,7 +2772,6 @@ static int merge_content(struct merge_options *o,
=20
 	if (mfi.clean && !df_conflict_remains &&
 	    oid_eq(&mfi.oid, a_oid) && mfi.mode =3D=3D a_mode) {
-		int path_renamed_outside_HEAD;
 		output(o, 3, _("Skipped %s (merged same as existing)"), path);
 		/*
 		 * The content merge resulted in the same file contents we
@@ -2780,8 +2779,7 @@ static int merge_content(struct merge_options *o,
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
index 45f620633f..2e28f2908d 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -3884,7 +3884,7 @@ test_expect_success '12b-setup: Moving one director=
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
2.16.1.232.g28d5be9217

