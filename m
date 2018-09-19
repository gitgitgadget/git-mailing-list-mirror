Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBB3D1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 16:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbeISVxR (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 17:53:17 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:44152 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731355AbeISVxQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Sep 2018 17:53:16 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8JGDL7X004972;
        Wed, 19 Sep 2018 09:14:38 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2mgxyj7gq8-1;
        Wed, 19 Sep 2018 09:14:38 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 18255228A052;
        Wed, 19 Sep 2018 09:14:38 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 3/4] merge-recursive: remove final remaining caller of merge_file_one()
Date:   Wed, 19 Sep 2018 09:14:33 -0700
Message-Id: <20180919161434.3272-4-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.12.gc6760fd9a9
In-Reply-To: <20180919161434.3272-1-newren@gmail.com>
References: <20180919161434.3272-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=956 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809190158
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function names merge_file_one() and merge_file_1() aren't
particularly intuitive function names, especially since there is no
associated merge_file() function that these are related to.  The
previous commit showed that merge_file_one() was prone to be called when
merge_file_1() should be, and since it is just a thin wrapper around
merge_file_1() anyway and only has one caller left, let's just remove
merge_file_one() entirely.

(It also turns out that the one remaining caller of merge_file_one()
has very broken code that needs to be completely rewritten, but that's
the subject of a future patch series; for now, we're just translating
it into a merge_file_1() call.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 44 +++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 9e4e3da672..2654a8a485 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1366,27 +1366,6 @@ static int merge_file_1(struct merge_options *o,
 	return 0;
 }
 
-static int merge_file_one(struct merge_options *o,
-			  const char *path,
-			  const struct object_id *o_oid, int o_mode,
-			  const struct object_id *a_oid, int a_mode,
-			  const struct object_id *b_oid, int b_mode,
-			  const char *branch1,
-			  const char *branch2,
-			  struct merge_file_info *mfi)
-{
-	struct diff_filespec one, a, b;
-
-	one.path = a.path = b.path = (char *)path;
-	oidcpy(&one.oid, o_oid);
-	one.mode = o_mode;
-	oidcpy(&a.oid, a_oid);
-	a.mode = a_mode;
-	oidcpy(&b.oid, b_oid);
-	b.mode = b_mode;
-	return merge_file_1(o, &one, &a, &b, path, branch1, branch2, mfi);
-}
-
 static int handle_rename_via_dir(struct merge_options *o,
 				 struct diff_filepair *pair,
 				 const char *rename_branch,
@@ -2730,12 +2709,23 @@ static int process_renames(struct merge_options *o,
 				       ren1_dst, branch2);
 				if (o->call_depth) {
 					struct merge_file_info mfi;
-					if (merge_file_one(o, ren1_dst, &null_oid, 0,
-							   &ren1->pair->two->oid,
-							   ren1->pair->two->mode,
-							   &dst_other.oid,
-							   dst_other.mode,
-							   branch1, branch2, &mfi)) {
+					struct diff_filespec one, a, b;
+
+					oidcpy(&one.oid, &null_oid);
+					one.mode = 0;
+					one.path = ren1->pair->two->path;
+
+					oidcpy(&a.oid, &ren1->pair->two->oid);
+					a.mode = ren1->pair->two->mode;
+					a.path = one.path;
+
+					oidcpy(&b.oid, &dst_other.oid);
+					b.mode = dst_other.mode;
+					b.path = one.path;
+
+					if (merge_file_1(o, &one, &a, &b, ren1_dst,
+							 branch1, branch2,
+							 &mfi)) {
 						clean_merge = -1;
 						goto cleanup_and_return;
 					}
-- 
2.19.0.12.gc6760fd9a9

