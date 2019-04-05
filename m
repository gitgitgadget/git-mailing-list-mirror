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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9891720248
	for <e@80x24.org>; Fri,  5 Apr 2019 15:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbfDEPBI (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 11:01:08 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:40230 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731365AbfDEPBG (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Apr 2019 11:01:06 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35EwSnw001751;
        Fri, 5 Apr 2019 08:00:46 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2rmg324g4c-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 05 Apr 2019 08:00:44 -0700
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 5 Apr 2019 08:00:40 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 5 Apr 2019 08:00:43 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id AB25A220CB32;
        Fri,  5 Apr 2019 08:00:39 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 14/15] merge-recursive: give callers of handle_content_merge() access to contents
Date:   Fri, 5 Apr 2019 08:00:25 -0700
Message-ID: <20190405150026.5260-15-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.211.g719c25afaf.dirty
In-Reply-To: <20190405150026.5260-1-newren@gmail.com>
References: <20190330003336.21940-1-newren@gmail.com>
 <20190405150026.5260-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=13
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=882 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.0.1-1810050000 definitions=main-1904050102
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass a merge_file_info struct to handle_content_merge() so that the
callers can access the oid and mode of the result afterward.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 938a526b20..2edfa01e43 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2982,7 +2982,8 @@ static int handle_modify_delete(struct merge_options *opt,
 				    _("modify"), _("modified"));
 }
 
-static int handle_content_merge(struct merge_options *opt,
+static int handle_content_merge(struct merge_file_info *mfi,
+				struct merge_options *opt,
 				const char *path,
 				int is_dirty,
 				const struct diff_filespec *o,
@@ -2991,7 +2992,6 @@ static int handle_content_merge(struct merge_options *opt,
 				struct rename_conflict_info *ci)
 {
 	const char *reason = _("content");
-	struct merge_file_info mfi;
 	unsigned df_conflict_remains = 0;
 
 	if (!is_valid(o))
@@ -3004,7 +3004,7 @@ static int handle_content_merge(struct merge_options *opt,
 
 	if (merge_mode_and_contents(opt, o, a, b, path,
 				    opt->branch1, opt->branch2,
-				    opt->call_depth * 2, &mfi))
+				    opt->call_depth * 2, mfi))
 		return -1;
 
 	/*
@@ -3013,13 +3013,13 @@ static int handle_content_merge(struct merge_options *opt,
 	 *   b) The merge matches what was in HEAD (content, mode, pathname)
 	 *   c) The target path is usable (i.e. not involved in D/F conflict)
 	 */
-	if (mfi.clean && was_tracked_and_matches(opt, path, &mfi.blob) &&
+	if (mfi->clean && was_tracked_and_matches(opt, path, &mfi->blob) &&
 	    !df_conflict_remains) {
 		int pos;
 		struct cache_entry *ce;
 
 		output(opt, 3, _("Skipped %s (merged same as existing)"), path);
-		if (add_cacheinfo(opt, &mfi.blob, path,
+		if (add_cacheinfo(opt, &mfi->blob, path,
 				  0, (!opt->call_depth && !is_dirty), 0))
 			return -1;
 		/*
@@ -3035,11 +3035,11 @@ static int handle_content_merge(struct merge_options *opt,
 			ce = opt->repo->index->cache[pos];
 			ce->ce_flags |= CE_SKIP_WORKTREE;
 		}
-		return mfi.clean;
+		return mfi->clean;
 	}
 
-	if (!mfi.clean) {
-		if (S_ISGITLINK(mfi.blob.mode))
+	if (!mfi->clean) {
+		if (S_ISGITLINK(mfi->blob.mode))
 			reason = _("submodule");
 		output(opt, 1, _("CONFLICT (%s): Merge conflict in %s"),
 				reason, path);
@@ -3053,15 +3053,15 @@ static int handle_content_merge(struct merge_options *opt,
 		if (opt->call_depth) {
 			remove_file_from_index(opt->repo->index, path);
 		} else {
-			if (!mfi.clean) {
+			if (!mfi->clean) {
 				if (update_stages(opt, path, o, a, b))
 					return -1;
 			} else {
 				int file_from_stage2 = was_tracked(opt, path);
 
 				if (update_stages(opt, path, NULL,
-						  file_from_stage2 ? &mfi.blob : NULL,
-						  file_from_stage2 ? NULL : &mfi.blob))
+						  file_from_stage2 ? &mfi->blob : NULL,
+						  file_from_stage2 ? NULL : &mfi->blob))
 					return -1;
 			}
 
@@ -3072,15 +3072,15 @@ static int handle_content_merge(struct merge_options *opt,
 			       path);
 		}
 		output(opt, 1, _("Adding as %s instead"), new_path);
-		if (update_file(opt, 0, &mfi.blob, new_path)) {
+		if (update_file(opt, 0, &mfi->blob, new_path)) {
 			free(new_path);
 			return -1;
 		}
 		free(new_path);
-		mfi.clean = 0;
-	} else if (update_file(opt, mfi.clean, &mfi.blob, path))
+		mfi->clean = 0;
+	} else if (update_file(opt, mfi->clean, &mfi->blob, path))
 		return -1;
-	return !is_dirty && mfi.clean;
+	return !is_dirty && mfi->clean;
 }
 
 static int handle_rename_normal(struct merge_options *opt,
@@ -3091,7 +3091,8 @@ static int handle_rename_normal(struct merge_options *opt,
 				struct rename_conflict_info *ci)
 {
 	/* Merge the content and write it out */
-	return handle_content_merge(opt, path, was_dirty(opt, path),
+	struct merge_file_info mfi;
+	return handle_content_merge(&mfi, opt, path, was_dirty(opt, path),
 				    o, a, b, ci);
 }
 
@@ -3256,8 +3257,10 @@ static int process_entry(struct merge_options *opt,
 							    a, b);
 		} else {
 			/* case D: Modified in both, but differently. */
+			struct merge_file_info mfi;
 			int is_dirty = 0; /* unpack_trees would have bailed if dirty */
-			clean_merge = handle_content_merge(opt, path, is_dirty,
+			clean_merge = handle_content_merge(&mfi, opt, path,
+							   is_dirty,
 							   o, a, b, NULL);
 		}
 	} else if (!o_valid && !a_valid && !b_valid) {
-- 
2.21.0.211.g719c25afaf.dirty

