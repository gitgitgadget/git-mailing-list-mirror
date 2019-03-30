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
	by dcvr.yhbt.net (Postfix) with ESMTP id B271720248
	for <e@80x24.org>; Sat, 30 Mar 2019 00:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbfC3AeZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 20:34:25 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:36388 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730259AbfC3AeT (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Mar 2019 20:34:19 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2U0XVDq015420;
        Fri, 29 Mar 2019 17:34:01 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2rht7wrarh-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 29 Mar 2019 17:34:01 -0700
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 29 Mar 2019 17:33:59 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 29 Mar 2019 17:33:56 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 3C86F220CB2E;
        Fri, 29 Mar 2019 17:33:56 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 09/15] merge-recursive: track branch where rename occurred in rename struct
Date:   Fri, 29 Mar 2019 17:33:30 -0700
Message-ID: <20190330003336.21940-10-newren@gmail.com>
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
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903300002
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We previously tracked the branch associated with a rename in a separate
field in rename_conflict_info, but since it is directly associated with
the rename it makes more sense to move it into the rename struct.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 113 +++++++++++++++++-----------------------------
 1 file changed, 42 insertions(+), 71 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index e66b47cfa1..f85c276f35 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -211,6 +211,7 @@ struct stage_data {
 
 struct rename {
 	struct diff_filepair *pair;
+	const char *branch; /* branch that the rename occurred on */
 	/*
 	 * Purpose of src_entry and dst_entry:
 	 *
@@ -240,16 +241,12 @@ struct rename_conflict_info {
 	enum rename_type rename_type;
 	struct rename *ren1;
 	struct rename *ren2;
-	const char *branch1;
-	const char *branch2;
 };
 
 static inline void setup_rename_conflict_info(enum rename_type rename_type,
 					      struct merge_options *opt,
 					      struct rename *ren1,
-					      struct rename *ren2,
-					      const char *branch1,
-					      const char *branch2)
+					      struct rename *ren2)
 {
 	struct rename_conflict_info *ci;
 
@@ -260,11 +257,8 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 	 * ensure that branch1 == opt->branch1.  So, simply flip arguments
 	 * around if we don't have that.
 	 */
-	if (ren2 && branch1 != opt->branch1) {
-		setup_rename_conflict_info(rename_type,
-					   opt,
-					   ren2,       ren1,
-					   branch2,    branch1);
+	if (ren2 && ren1->branch != opt->branch1) {
+		setup_rename_conflict_info(rename_type, opt, ren2, ren1);
 		return;
 	}
 
@@ -272,8 +266,6 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 	ci->rename_type = rename_type;
 	ci->ren1 = ren1;
 	ci->ren2 = ren2;
-	ci->branch1 = branch1;
-	ci->branch2 = branch2;
 
 	ci->ren1->dst_entry->processed = 0;
 	ci->ren1->dst_entry->rename_conflict_info = ci;
@@ -1665,12 +1657,15 @@ static int handle_rename_add(struct merge_options *opt,
 	char *prev_path_desc;
 	struct merge_file_info mfi;
 
-	int other_stage = (ci->branch1 == opt->branch1 ? 3 : 2);
+	const char *rename_branch = ci->ren1->branch;
+	const char *add_branch = (opt->branch1 == rename_branch ?
+				  opt->branch2 : opt->branch1);
+	int other_stage = (ci->ren1->branch == opt->branch1 ? 3 : 2);
 
 	output(opt, 1, _("CONFLICT (rename/add): "
 	       "Rename %s->%s in %s.  Added %s in %s"),
-	       a->path, c->path, ci->branch1,
-	       c->path, ci->branch2);
+	       a->path, c->path, rename_branch,
+	       c->path, add_branch);
 
 	filespec_from_entry(&tmp, ci->ren1->src_entry, other_stage);
 	tmp.path = a->path;
@@ -1685,7 +1680,7 @@ static int handle_rename_add(struct merge_options *opt,
 
 	return handle_file_collision(opt,
 				     c->path, a->path, NULL,
-				     ci->branch1, ci->branch2,
+				     rename_branch, add_branch,
 				     &mfi.oid, mfi.mode,
 				     &ci->ren1->dst_entry->stages[other_stage].oid,
 				     ci->ren1->dst_entry->stages[other_stage].mode);
@@ -1727,14 +1722,14 @@ static int handle_rename_rename_1to2(struct merge_options *opt,
 	output(opt, 1, _("CONFLICT (rename/rename): "
 	       "Rename \"%s\"->\"%s\" in branch \"%s\" "
 	       "rename \"%s\"->\"%s\" in \"%s\"%s"),
-	       o->path, a->path, ci->branch1,
-	       o->path, b->path, ci->branch2,
+	       o->path, a->path, ci->ren1->branch,
+	       o->path, b->path, ci->ren2->branch,
 	       opt->call_depth ? _(" (left unresolved)") : "");
 
 	path_desc = xstrfmt("%s and %s, both renamed from %s",
 			    a->path, b->path, o->path);
 	if (merge_mode_and_contents(opt, o, a, b, path_desc,
-				    ci->branch1, ci->branch2,
+				    ci->ren1->branch, ci->ren2->branch,
 				    opt->call_depth * 2, &mfi))
 		return -1;
 	free(path_desc);
@@ -1781,14 +1776,15 @@ static int handle_rename_rename_1to2(struct merge_options *opt,
 		if (add) {
 			if (handle_file_collision(opt, a->path,
 						  NULL, NULL,
-						  ci->branch1, ci->branch2,
+						  ci->ren1->branch,
+						  ci->ren2->branch,
 						  &mfi.oid, mfi.mode,
 						  &add->oid, add->mode) < 0)
 				return -1;
 		} else {
 			char *new_path = find_path_for_conflict(opt, a->path,
-								ci->branch1,
-								ci->branch2);
+								ci->ren1->branch,
+								ci->ren2->branch);
 			if (update_file(opt, 0, &mfi.oid, mfi.mode, new_path ? new_path : a->path))
 				return -1;
 			free(new_path);
@@ -1800,14 +1796,15 @@ static int handle_rename_rename_1to2(struct merge_options *opt,
 		if (add) {
 			if (handle_file_collision(opt, b->path,
 						  NULL, NULL,
-						  ci->branch1, ci->branch2,
+						  ci->ren1->branch,
+						  ci->ren2->branch,
 						  &add->oid, add->mode,
 						  &mfi.oid, mfi.mode) < 0)
 				return -1;
 		} else {
 			char *new_path = find_path_for_conflict(opt, b->path,
-								ci->branch2,
-								ci->branch1);
+								ci->ren2->branch,
+								ci->ren1->branch);
 			if (update_file(opt, 0, &mfi.oid, mfi.mode, new_path ? new_path : b->path))
 				return -1;
 			free(new_path);
@@ -1837,8 +1834,8 @@ static int handle_rename_rename_2to1(struct merge_options *opt,
 	output(opt, 1, _("CONFLICT (rename/rename): "
 	       "Rename %s->%s in %s. "
 	       "Rename %s->%s in %s"),
-	       a->path, c1->path, ci->branch1,
-	       b->path, c2->path, ci->branch2);
+	       a->path, c1->path, ci->ren1->branch,
+	       b->path, c2->path, ci->ren2->branch);
 
 	filespec_from_entry(&tmp1, ci->ren1->src_entry, 3);
 	tmp1.path = a->path;
@@ -1858,7 +1855,7 @@ static int handle_rename_rename_2to1(struct merge_options *opt,
 	free(path_side_2_desc);
 
 	return handle_file_collision(opt, path, a->path, b->path,
-				     ci->branch1, ci->branch2,
+				     ci->ren1->branch, ci->ren2->branch,
 				     &mfi_c1.oid, mfi_c1.mode,
 				     &mfi_c2.oid, mfi_c2.mode);
 }
@@ -2542,6 +2539,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
  * information; tree is always equal to either a_tree or b_tree.
  */
 static struct string_list *get_renames(struct merge_options *opt,
+				       const char *branch,
 				       struct diff_queue_struct *pairs,
 				       struct hashmap *dir_renames,
 				       struct hashmap *dir_rename_exclusions,
@@ -2585,6 +2583,7 @@ static struct string_list *get_renames(struct merge_options *opt,
 		re->processed = 0;
 		re->add_turned_into_rename = 0;
 		re->pair = pair;
+		re->branch = branch;
 		item = string_list_lookup(entries, re->pair->one->path);
 		if (!item)
 			re->src_entry = insert_stage_data(re->pair->one->path,
@@ -2639,7 +2638,6 @@ static int process_renames(struct merge_options *opt,
 	for (i = 0, j = 0; i < a_renames->nr || j < b_renames->nr;) {
 		struct string_list *renames1, *renames2Dst;
 		struct rename *ren1 = NULL, *ren2 = NULL;
-		const char *branch1, *branch2;
 		const char *ren1_src, *ren1_dst;
 		struct string_list_item *lookup;
 
@@ -2660,13 +2658,9 @@ static int process_renames(struct merge_options *opt,
 		if (ren1) {
 			renames1 = a_renames;
 			renames2Dst = &b_by_dst;
-			branch1 = opt->branch1;
-			branch2 = opt->branch2;
 		} else {
 			renames1 = b_renames;
 			renames2Dst = &a_by_dst;
-			branch1 = opt->branch2;
-			branch2 = opt->branch1;
 			SWAP(ren2, ren1);
 		}
 
@@ -2706,12 +2700,7 @@ static int process_renames(struct merge_options *opt,
 					     ren1->pair->two,
 					     ren2->pair->two);
 			}
-			setup_rename_conflict_info(rename_type,
-						   opt,
-						   ren1,
-						   ren2,
-						   branch1,
-						   branch2);
+			setup_rename_conflict_info(rename_type, opt, ren1, ren2);
 		} else if ((lookup = string_list_lookup(renames2Dst, ren1_dst))) {
 			/* Two different files renamed to the same thing */
 			char *ren2_dst;
@@ -2730,11 +2719,7 @@ static int process_renames(struct merge_options *opt,
 			ren2->src_entry->processed = 1;
 
 			setup_rename_conflict_info(RENAME_TWO_FILES_TO_ONE,
-						   opt,
-						   ren1,
-						   ren2,
-						   branch1,
-						   branch2);
+						   opt, ren1, ren2);
 
 		} else {
 			/* Renamed in 1, maybe changed in 2 */
@@ -2769,18 +2754,10 @@ static int process_renames(struct merge_options *opt,
 			if (oid_eq(&src_other.oid, &null_oid) &&
 			    ren1->add_turned_into_rename) {
 				setup_rename_conflict_info(RENAME_VIA_DIR,
-							   opt,
-							   ren1,
-							   NULL,
-							   branch1,
-							   branch2);
+							   opt, ren1, NULL);
 			} else if (oid_eq(&src_other.oid, &null_oid)) {
 				setup_rename_conflict_info(RENAME_DELETE,
-							   opt,
-							   ren1,
-							   NULL,
-							   branch1,
-							   branch2);
+							   opt, ren1, NULL);
 			} else if ((dst_other.mode == ren1->pair->two->mode) &&
 				   oid_eq(&dst_other.oid, &ren1->pair->two->oid)) {
 				/*
@@ -2807,11 +2784,7 @@ static int process_renames(struct merge_options *opt,
 				 * file, then the merge will be clean.
 				 */
 				setup_rename_conflict_info(RENAME_ADD,
-							   opt,
-							   ren1,
-							   NULL,
-							   branch1,
-							   branch2);
+							   opt, ren1, NULL);
 			} else
 				try_merge = 1;
 
@@ -2831,11 +2804,7 @@ static int process_renames(struct merge_options *opt,
 				}
 				update_entry(ren1->dst_entry, o, a, b);
 				setup_rename_conflict_info(RENAME_NORMAL,
-							   opt,
-							   ren1,
-							   NULL,
-							   branch1,
-							   NULL);
+							   opt, ren1, NULL);
 			}
 		}
 	}
@@ -2904,13 +2873,13 @@ static int detect_and_process_renames(struct merge_options *opt,
 		dir_rename_init(dir_re_merge);
 	}
 
-	ri->head_renames  = get_renames(opt, head_pairs,
+	ri->head_renames  = get_renames(opt, opt->branch1, head_pairs,
 					dir_re_merge, dir_re_head, head,
 					common, head, merge, entries,
 					&clean);
 	if (clean < 0)
 		goto cleanup;
-	ri->merge_renames = get_renames(opt, merge_pairs,
+	ri->merge_renames = get_renames(opt, opt->branch2, merge_pairs,
 					dir_re_head, dir_re_merge, merge,
 					common, head, merge, entries,
 					&clean);
@@ -3072,14 +3041,14 @@ static int handle_content_merge(struct merge_options *opt,
 	if (ci) {
 		struct diff_filepair *pair1 = ci->ren1->pair;
 
-		path1 = (opt->branch1 == ci->branch1) ?
+		path1 = (opt->branch1 == ci->ren1->branch) ?
 			pair1->two->path : pair1->one->path;
 		/* If ci->ren2->pair != NULL, we are in
 		 * RENAME_ONE_FILE_TO_ONE case.  Otherwise, we have a
 		 * normal rename.
 		 */
 		path2 = ((ci->ren2 && ci->ren2->pair) ||
-			 opt->branch2 == ci->branch1) ?
+			 opt->branch2 == ci->ren1->branch) ?
 			pair1->two->path : pair1->one->path;
 		one.path = pair1->one->path;
 		a.path = (char *)path1;
@@ -3157,7 +3126,7 @@ static int handle_content_merge(struct merge_options *opt,
 			}
 
 		}
-		new_path = unique_path(opt, path, ci->branch1);
+		new_path = unique_path(opt, path, ci->ren1->branch);
 		if (is_dirty) {
 			output(opt, 1, _("Refusing to lose dirty file at %s"),
 			       path);
@@ -3215,7 +3184,8 @@ static int process_entry(struct merge_options *opt,
 			break;
 		case RENAME_VIA_DIR:
 			clean_merge = 1;
-			if (handle_rename_via_dir(opt, ci->ren1->pair, ci->branch1))
+			if (handle_rename_via_dir(opt, ci->ren1->pair,
+						  ci->ren1->branch))
 				clean_merge = -1;
 			break;
 		case RENAME_ADD:
@@ -3230,7 +3200,8 @@ static int process_entry(struct merge_options *opt,
 		case RENAME_DELETE:
 			clean_merge = 0;
 			if (handle_rename_delete(opt, ci->ren1->pair,
-						 ci->branch1, ci->branch2))
+						 ci->ren1->branch,
+						 ci->ren1->branch == opt->branch1 ? opt->branch2 : opt->branch1))
 				clean_merge = -1;
 			break;
 		case RENAME_ONE_FILE_TO_TWO:
-- 
2.21.0.211.g078f4bef79.dirty

