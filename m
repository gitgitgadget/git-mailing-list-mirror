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
	by dcvr.yhbt.net (Postfix) with ESMTP id 86DF9202BB
	for <e@80x24.org>; Sat, 30 Mar 2019 00:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbfC3AeV (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 20:34:21 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:44460 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730333AbfC3AeT (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Mar 2019 20:34:19 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2U0XoXR012881;
        Fri, 29 Mar 2019 17:33:58 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2rht9jgafa-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 29 Mar 2019 17:33:58 -0700
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 29 Mar 2019 17:33:56 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 29 Mar 2019 17:33:59 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 18986220CB2C;
        Fri, 29 Mar 2019 17:33:56 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 07/15] merge-recursive: shrink rename_conflict_info
Date:   Fri, 29 Mar 2019 17:33:28 -0700
Message-ID: <20190330003336.21940-8-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.211.g078f4bef79.dirty
In-Reply-To: <20190330003336.21940-1-newren@gmail.com>
References: <20190306002744.14418-1-newren@gmail.com>
 <20190330003336.21940-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=885 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903300002
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The rename_conflict_info struct used both a pair and a stage_data which
were taken from a rename struct.  Just use the original rename struct.
This will also allow us to start making other simplifications to the
code.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 120 +++++++++++++++++++---------------------------
 1 file changed, 50 insertions(+), 70 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c4a2ef2a37..e05f8f22f5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -238,24 +238,20 @@ struct rename {
 
 struct rename_conflict_info {
 	enum rename_type rename_type;
-	struct diff_filepair *pair1;
-	struct diff_filepair *pair2;
+	struct rename *ren1;
+	struct rename *ren2;
 	const char *branch1;
 	const char *branch2;
-	struct stage_data *dst_entry1;
-	struct stage_data *dst_entry2;
 	struct diff_filespec ren1_other;
 	struct diff_filespec ren2_other;
 };
 
 static inline void setup_rename_conflict_info(enum rename_type rename_type,
-					      struct diff_filepair *pair1,
-					      struct diff_filepair *pair2,
+					      struct merge_options *opt,
+					      struct rename *ren1,
+					      struct rename *ren2,
 					      const char *branch1,
 					      const char *branch2,
-					      struct stage_data *dst_entry1,
-					      struct stage_data *dst_entry2,
-					      struct merge_options *opt,
 					      struct stage_data *src_entry1,
 					      struct stage_data *src_entry2)
 {
@@ -269,31 +265,27 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 	 * ensure that branch1 == opt->branch1.  So, simply flip arguments
 	 * around if we don't have that.
 	 */
-	if (dst_entry2 && branch1 != opt->branch1) {
+	if (ren2 && branch1 != opt->branch1) {
 		setup_rename_conflict_info(rename_type,
-					   pair2,      pair1,
-					   branch2,    branch1,
-					   dst_entry2, dst_entry1,
 					   opt,
+					   ren2,       ren1,
+					   branch2,    branch1,
 					   src_entry2, src_entry1);
 		return;
 	}
 
 	ci = xcalloc(1, sizeof(struct rename_conflict_info));
 	ci->rename_type = rename_type;
-	ci->pair1 = pair1;
+	ci->ren1 = ren1;
+	ci->ren2 = ren2;
 	ci->branch1 = branch1;
 	ci->branch2 = branch2;
 
-	ci->dst_entry1 = dst_entry1;
-	dst_entry1->rename_conflict_info = ci;
-	dst_entry1->processed = 0;
+	ci->ren1->dst_entry->processed = 0;
+	ci->ren1->dst_entry->rename_conflict_info = ci;
 
-	assert(!pair2 == !dst_entry2);
-	if (dst_entry2) {
-		ci->dst_entry2 = dst_entry2;
-		ci->pair2 = pair2;
-		dst_entry2->rename_conflict_info = ci;
+	if (ren2) {
+		ci->ren2->dst_entry->rename_conflict_info = ci;
 	}
 
 	/*
@@ -305,7 +297,7 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 	    rename_type == RENAME_TWO_FILES_TO_ONE) {
 		ostage1 = opt->branch1 == branch1 ? 3 : 2;
 
-		ci->ren1_other.path = pair1->one->path;
+		ci->ren1_other.path = ren1->pair->one->path;
 		oidcpy(&ci->ren1_other.oid, &src_entry1->stages[ostage1].oid);
 		ci->ren1_other.mode = src_entry1->stages[ostage1].mode;
 	}
@@ -313,7 +305,7 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 	if (rename_type == RENAME_TWO_FILES_TO_ONE) {
 		ostage2 = ostage1 ^ 1;
 
-		ci->ren2_other.path = pair2->one->path;
+		ci->ren2_other.path = ren2->pair->one->path;
 		oidcpy(&ci->ren2_other.oid, &src_entry2->stages[ostage2].oid);
 		ci->ren2_other.mode = src_entry2->stages[ostage2].mode;
 	}
@@ -1694,8 +1686,8 @@ static int handle_rename_add(struct merge_options *opt,
 			     struct rename_conflict_info *ci)
 {
 	/* a was renamed to c, and a separate c was added. */
-	struct diff_filespec *a = ci->pair1->one;
-	struct diff_filespec *c = ci->pair1->two;
+	struct diff_filespec *a = ci->ren1->pair->one;
+	struct diff_filespec *c = ci->ren1->pair->two;
 	char *path = c->path;
 	char *prev_path_desc;
 	struct merge_file_info mfi;
@@ -1718,8 +1710,8 @@ static int handle_rename_add(struct merge_options *opt,
 				     c->path, a->path, NULL,
 				     ci->branch1, ci->branch2,
 				     &mfi.oid, mfi.mode,
-				     &ci->dst_entry1->stages[other_stage].oid,
-				     ci->dst_entry1->stages[other_stage].mode);
+				     &ci->ren1->dst_entry->stages[other_stage].oid,
+				     ci->ren1->dst_entry->stages[other_stage].mode);
 }
 
 static char *find_path_for_conflict(struct merge_options *opt,
@@ -1750,9 +1742,9 @@ static int handle_rename_rename_1to2(struct merge_options *opt,
 	struct merge_file_info mfi;
 	struct diff_filespec other;
 	struct diff_filespec *add;
-	struct diff_filespec *o = ci->pair1->one;
-	struct diff_filespec *a = ci->pair1->two;
-	struct diff_filespec *b = ci->pair2->two;
+	struct diff_filespec *o = ci->ren1->pair->one;
+	struct diff_filespec *a = ci->ren1->pair->two;
+	struct diff_filespec *b = ci->ren2->pair->two;
 	char *path_desc;
 
 	output(opt, 1, _("CONFLICT (rename/rename): "
@@ -1788,14 +1780,14 @@ static int handle_rename_rename_1to2(struct merge_options *opt,
 		 * such cases, we should keep the added file around,
 		 * resolving the conflict at that path in its favor.
 		 */
-		add = filespec_from_entry(&other, ci->dst_entry1, 2 ^ 1);
+		add = filespec_from_entry(&other, ci->ren1->dst_entry, 2 ^ 1);
 		if (add) {
 			if (update_file(opt, 0, &add->oid, add->mode, a->path))
 				return -1;
 		}
 		else
 			remove_file_from_index(opt->repo->index, a->path);
-		add = filespec_from_entry(&other, ci->dst_entry2, 3 ^ 1);
+		add = filespec_from_entry(&other, ci->ren2->dst_entry, 3 ^ 1);
 		if (add) {
 			if (update_file(opt, 0, &add->oid, add->mode, b->path))
 				return -1;
@@ -1808,7 +1800,7 @@ static int handle_rename_rename_1to2(struct merge_options *opt,
 		 * rename/add collision.  If not, we can write the file out
 		 * to the specified location.
 		 */
-		add = filespec_from_entry(&other, ci->dst_entry1, 2 ^ 1);
+		add = filespec_from_entry(&other, ci->ren1->dst_entry, 2 ^ 1);
 		if (add) {
 			if (handle_file_collision(opt, a->path,
 						  NULL, NULL,
@@ -1827,7 +1819,7 @@ static int handle_rename_rename_1to2(struct merge_options *opt,
 				return -1;
 		}
 
-		add = filespec_from_entry(&other, ci->dst_entry2, 3 ^ 1);
+		add = filespec_from_entry(&other, ci->ren2->dst_entry, 3 ^ 1);
 		if (add) {
 			if (handle_file_collision(opt, b->path,
 						  NULL, NULL,
@@ -1854,10 +1846,10 @@ static int handle_rename_rename_2to1(struct merge_options *opt,
 				     struct rename_conflict_info *ci)
 {
 	/* Two files, a & b, were renamed to the same thing, c. */
-	struct diff_filespec *a = ci->pair1->one;
-	struct diff_filespec *b = ci->pair2->one;
-	struct diff_filespec *c1 = ci->pair1->two;
-	struct diff_filespec *c2 = ci->pair2->two;
+	struct diff_filespec *a = ci->ren1->pair->one;
+	struct diff_filespec *b = ci->ren2->pair->one;
+	struct diff_filespec *c1 = ci->ren1->pair->two;
+	struct diff_filespec *c2 = ci->ren2->pair->two;
 	char *path = c1->path; /* == c2->path */
 	char *path_side_1_desc;
 	char *path_side_2_desc;
@@ -2732,13 +2724,11 @@ static int process_renames(struct merge_options *opt,
 					     ren2->pair->two);
 			}
 			setup_rename_conflict_info(rename_type,
-						   ren1->pair,
-						   ren2->pair,
+						   opt,
+						   ren1,
+						   ren2,
 						   branch1,
 						   branch2,
-						   ren1->dst_entry,
-						   ren2->dst_entry,
-						   opt,
 						   NULL,
 						   NULL);
 		} else if ((lookup = string_list_lookup(renames2Dst, ren1_dst))) {
@@ -2759,13 +2749,11 @@ static int process_renames(struct merge_options *opt,
 			ren2->src_entry->processed = 1;
 
 			setup_rename_conflict_info(RENAME_TWO_FILES_TO_ONE,
-						   ren1->pair,
-						   ren2->pair,
+						   opt,
+						   ren1,
+						   ren2,
 						   branch1,
 						   branch2,
-						   ren1->dst_entry,
-						   ren2->dst_entry,
-						   opt,
 						   ren1->src_entry,
 						   ren2->src_entry);
 
@@ -2802,24 +2790,20 @@ static int process_renames(struct merge_options *opt,
 			if (oid_eq(&src_other.oid, &null_oid) &&
 			    ren1->add_turned_into_rename) {
 				setup_rename_conflict_info(RENAME_VIA_DIR,
-							   ren1->pair,
+							   opt,
+							   ren1,
 							   NULL,
 							   branch1,
 							   branch2,
-							   ren1->dst_entry,
-							   NULL,
-							   opt,
 							   NULL,
 							   NULL);
 			} else if (oid_eq(&src_other.oid, &null_oid)) {
 				setup_rename_conflict_info(RENAME_DELETE,
-							   ren1->pair,
+							   opt,
+							   ren1,
 							   NULL,
 							   branch1,
 							   branch2,
-							   ren1->dst_entry,
-							   NULL,
-							   opt,
 							   NULL,
 							   NULL);
 			} else if ((dst_other.mode == ren1->pair->two->mode) &&
@@ -2848,13 +2832,11 @@ static int process_renames(struct merge_options *opt,
 				 * file, then the merge will be clean.
 				 */
 				setup_rename_conflict_info(RENAME_ADD,
-							   ren1->pair,
+							   opt,
+							   ren1,
 							   NULL,
 							   branch1,
 							   branch2,
-							   ren1->dst_entry,
-							   NULL,
-							   opt,
 							   ren1->src_entry,
 							   NULL);
 			} else
@@ -2876,13 +2858,11 @@ static int process_renames(struct merge_options *opt,
 				}
 				update_entry(ren1->dst_entry, o, a, b);
 				setup_rename_conflict_info(RENAME_NORMAL,
-							   ren1->pair,
+							   opt,
+							   ren1,
 							   NULL,
 							   branch1,
 							   NULL,
-							   ren1->dst_entry,
-							   NULL,
-							   opt,
 							   NULL,
 							   NULL);
 			}
@@ -3119,15 +3099,15 @@ static int handle_content_merge(struct merge_options *opt,
 	b.mode = b_mode;
 
 	if (ci) {
-		struct diff_filepair *pair1 = ci->pair1;
+		struct diff_filepair *pair1 = ci->ren1->pair;
 
 		path1 = (opt->branch1 == ci->branch1) ?
 			pair1->two->path : pair1->one->path;
-		/* If ci->pair2 != NULL, we are in
+		/* If ci->ren2->pair != NULL, we are in
 		 * RENAME_ONE_FILE_TO_ONE case.  Otherwise, we have a
 		 * normal rename.
 		 */
-		path2 = (ci->pair2 ||
+		path2 = ((ci->ren2 && ci->ren2->pair) ||
 			 opt->branch2 == ci->branch1) ?
 			pair1->two->path : pair1->one->path;
 		one.path = pair1->one->path;
@@ -3264,7 +3244,7 @@ static int process_entry(struct merge_options *opt,
 			break;
 		case RENAME_VIA_DIR:
 			clean_merge = 1;
-			if (handle_rename_via_dir(opt, ci->pair1, ci->branch1))
+			if (handle_rename_via_dir(opt, ci->ren1->pair, ci->branch1))
 				clean_merge = -1;
 			break;
 		case RENAME_ADD:
@@ -3278,7 +3258,7 @@ static int process_entry(struct merge_options *opt,
 			break;
 		case RENAME_DELETE:
 			clean_merge = 0;
-			if (handle_rename_delete(opt, ci->pair1,
+			if (handle_rename_delete(opt, ci->ren1->pair,
 						 ci->branch1, ci->branch2))
 				clean_merge = -1;
 			break;
-- 
2.21.0.211.g078f4bef79.dirty

