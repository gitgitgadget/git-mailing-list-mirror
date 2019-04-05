Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00FF720248
	for <e@80x24.org>; Fri,  5 Apr 2019 15:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbfDEPBF (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 11:01:05 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:45656 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728743AbfDEPBD (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Apr 2019 11:01:03 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35EwPFM001918;
        Fri, 5 Apr 2019 08:00:43 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2rmg26mf48-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 05 Apr 2019 08:00:42 -0700
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 5 Apr 2019 08:00:42 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 5 Apr 2019 08:00:42 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 51824220CB2C;
        Fri,  5 Apr 2019 08:00:39 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 08/15] merge-recursive: remove ren[12]_other fields from rename_conflict_info
Date:   Fri, 5 Apr 2019 08:00:19 -0700
Message-ID: <20190405150026.5260-9-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.211.g719c25afaf.dirty
In-Reply-To: <20190405150026.5260-1-newren@gmail.com>
References: <20190330003336.21940-1-newren@gmail.com>
 <20190405150026.5260-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904050102
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ren1_other and ren2_other fields were synthesized from information
in ren1->src_entry and ren2->src_entry.  Since we already have the
necessary information in ren1 and ren2, just use those.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 71 ++++++++++++++---------------------------------
 1 file changed, 21 insertions(+), 50 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index e05f8f22f5..e66b47cfa1 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -242,8 +242,6 @@ struct rename_conflict_info {
 	struct rename *ren2;
 	const char *branch1;
 	const char *branch2;
-	struct diff_filespec ren1_other;
-	struct diff_filespec ren2_other;
 };
 
 static inline void setup_rename_conflict_info(enum rename_type rename_type,
@@ -251,11 +249,8 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 					      struct rename *ren1,
 					      struct rename *ren2,
 					      const char *branch1,
-					      const char *branch2,
-					      struct stage_data *src_entry1,
-					      struct stage_data *src_entry2)
+					      const char *branch2)
 {
-	int ostage1 = 0, ostage2;
 	struct rename_conflict_info *ci;
 
 	/*
@@ -269,8 +264,7 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 		setup_rename_conflict_info(rename_type,
 					   opt,
 					   ren2,       ren1,
-					   branch2,    branch1,
-					   src_entry2, src_entry1);
+					   branch2,    branch1);
 		return;
 	}
 
@@ -287,28 +281,6 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 	if (ren2) {
 		ci->ren2->dst_entry->rename_conflict_info = ci;
 	}
-
-	/*
-	 * For each rename, there could have been
-	 * modifications on the side of history where that
-	 * file was not renamed.
-	 */
-	if (rename_type == RENAME_ADD ||
-	    rename_type == RENAME_TWO_FILES_TO_ONE) {
-		ostage1 = opt->branch1 == branch1 ? 3 : 2;
-
-		ci->ren1_other.path = ren1->pair->one->path;
-		oidcpy(&ci->ren1_other.oid, &src_entry1->stages[ostage1].oid);
-		ci->ren1_other.mode = src_entry1->stages[ostage1].mode;
-	}
-
-	if (rename_type == RENAME_TWO_FILES_TO_ONE) {
-		ostage2 = ostage1 ^ 1;
-
-		ci->ren2_other.path = ren2->pair->one->path;
-		oidcpy(&ci->ren2_other.oid, &src_entry2->stages[ostage2].oid);
-		ci->ren2_other.mode = src_entry2->stages[ostage2].mode;
-	}
 }
 
 static int show(struct merge_options *opt, int v)
@@ -1688,6 +1660,7 @@ static int handle_rename_add(struct merge_options *opt,
 	/* a was renamed to c, and a separate c was added. */
 	struct diff_filespec *a = ci->ren1->pair->one;
 	struct diff_filespec *c = ci->ren1->pair->two;
+	struct diff_filespec tmp;
 	char *path = c->path;
 	char *prev_path_desc;
 	struct merge_file_info mfi;
@@ -1699,8 +1672,12 @@ static int handle_rename_add(struct merge_options *opt,
 	       a->path, c->path, ci->branch1,
 	       c->path, ci->branch2);
 
+	filespec_from_entry(&tmp, ci->ren1->src_entry, other_stage);
+	tmp.path = a->path;
+
 	prev_path_desc = xstrfmt("version of %s from %s", path, a->path);
-	if (merge_mode_and_contents(opt, a, c, &ci->ren1_other, prev_path_desc,
+	if (merge_mode_and_contents(opt, a, c, &tmp,
+				    prev_path_desc,
 				    opt->branch1, opt->branch2,
 				    1 + opt->call_depth * 2, &mfi))
 		return -1;
@@ -1850,6 +1827,7 @@ static int handle_rename_rename_2to1(struct merge_options *opt,
 	struct diff_filespec *b = ci->ren2->pair->one;
 	struct diff_filespec *c1 = ci->ren1->pair->two;
 	struct diff_filespec *c2 = ci->ren2->pair->two;
+	struct diff_filespec tmp1, tmp2;
 	char *path = c1->path; /* == c2->path */
 	char *path_side_1_desc;
 	char *path_side_2_desc;
@@ -1862,12 +1840,17 @@ static int handle_rename_rename_2to1(struct merge_options *opt,
 	       a->path, c1->path, ci->branch1,
 	       b->path, c2->path, ci->branch2);
 
+	filespec_from_entry(&tmp1, ci->ren1->src_entry, 3);
+	tmp1.path = a->path;
+	filespec_from_entry(&tmp2, ci->ren2->src_entry, 2);
+	tmp2.path = b->path;
+
 	path_side_1_desc = xstrfmt("version of %s from %s", path, a->path);
 	path_side_2_desc = xstrfmt("version of %s from %s", path, b->path);
-	if (merge_mode_and_contents(opt, a, c1, &ci->ren1_other, path_side_1_desc,
+	if (merge_mode_and_contents(opt, a, c1, &tmp1, path_side_1_desc,
 				    opt->branch1, opt->branch2,
 				    1 + opt->call_depth * 2, &mfi_c1) ||
-	    merge_mode_and_contents(opt, b, &ci->ren2_other, c2, path_side_2_desc,
+	    merge_mode_and_contents(opt, b, &tmp2, c2, path_side_2_desc,
 				    opt->branch1, opt->branch2,
 				    1 + opt->call_depth * 2, &mfi_c2))
 		return -1;
@@ -2728,9 +2711,7 @@ static int process_renames(struct merge_options *opt,
 						   ren1,
 						   ren2,
 						   branch1,
-						   branch2,
-						   NULL,
-						   NULL);
+						   branch2);
 		} else if ((lookup = string_list_lookup(renames2Dst, ren1_dst))) {
 			/* Two different files renamed to the same thing */
 			char *ren2_dst;
@@ -2753,9 +2734,7 @@ static int process_renames(struct merge_options *opt,
 						   ren1,
 						   ren2,
 						   branch1,
-						   branch2,
-						   ren1->src_entry,
-						   ren2->src_entry);
+						   branch2);
 
 		} else {
 			/* Renamed in 1, maybe changed in 2 */
@@ -2794,18 +2773,14 @@ static int process_renames(struct merge_options *opt,
 							   ren1,
 							   NULL,
 							   branch1,
-							   branch2,
-							   NULL,
-							   NULL);
+							   branch2);
 			} else if (oid_eq(&src_other.oid, &null_oid)) {
 				setup_rename_conflict_info(RENAME_DELETE,
 							   opt,
 							   ren1,
 							   NULL,
 							   branch1,
-							   branch2,
-							   NULL,
-							   NULL);
+							   branch2);
 			} else if ((dst_other.mode == ren1->pair->two->mode) &&
 				   oid_eq(&dst_other.oid, &ren1->pair->two->oid)) {
 				/*
@@ -2836,9 +2811,7 @@ static int process_renames(struct merge_options *opt,
 							   ren1,
 							   NULL,
 							   branch1,
-							   branch2,
-							   ren1->src_entry,
-							   NULL);
+							   branch2);
 			} else
 				try_merge = 1;
 
@@ -2862,8 +2835,6 @@ static int process_renames(struct merge_options *opt,
 							   ren1,
 							   NULL,
 							   branch1,
-							   NULL,
-							   NULL,
 							   NULL);
 			}
 		}
-- 
2.21.0.211.g719c25afaf.dirty

