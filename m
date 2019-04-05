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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3080720248
	for <e@80x24.org>; Fri,  5 Apr 2019 15:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbfDEPA6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 11:00:58 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:45622 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbfDEPA5 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Apr 2019 11:00:57 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35EwPFP001918;
        Fri, 5 Apr 2019 08:00:45 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2rmg26mf48-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 05 Apr 2019 08:00:44 -0700
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 5 Apr 2019 08:00:43 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 5 Apr 2019 08:00:40 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 68D09220CB2E;
        Fri,  5 Apr 2019 08:00:39 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 10/15] merge-recursive: cleanup handle_rename_* function signatures
Date:   Fri, 5 Apr 2019 08:00:21 -0700
Message-ID: <20190405150026.5260-11-newren@gmail.com>
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
 lowpriorityscore=0 mlxlogscore=844 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.0.1-1810050000 definitions=main-1904050102
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of passing various bits and pieces of 'ci', just pass it
directly.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index f85c276f35..ada1c19ed2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1357,8 +1357,7 @@ static int merge_mode_and_contents(struct merge_options *opt,
 }
 
 static int handle_rename_via_dir(struct merge_options *opt,
-				 struct diff_filepair *pair,
-				 const char *rename_branch)
+				 struct rename_conflict_info *ci)
 {
 	/*
 	 * Handle file adds that need to be renamed due to directory rename
@@ -1366,10 +1365,11 @@ static int handle_rename_via_dir(struct merge_options *opt,
 	 * there is no content merge to do; just move the file into the
 	 * desired final location.
 	 */
-	const struct diff_filespec *dest = pair->two;
+	const struct rename *ren = ci->ren1;
+	const struct diff_filespec *dest = ren->pair->two;
 
 	if (!opt->call_depth && would_lose_untracked(opt, dest->path)) {
-		char *alt_path = unique_path(opt, dest->path, rename_branch);
+		char *alt_path = unique_path(opt, dest->path, ren->branch);
 
 		output(opt, 1, _("Error: Refusing to lose untracked file at %s; "
 			       "writing to %s instead."),
@@ -1383,8 +1383,8 @@ static int handle_rename_via_dir(struct merge_options *opt,
 			return -1;
 		free(alt_path);
 		return update_stages(opt, dest->path, NULL,
-				     rename_branch == opt->branch1 ? dest : NULL,
-				     rename_branch == opt->branch1 ? NULL : dest);
+				     ren->branch == opt->branch1 ? dest : NULL,
+				     ren->branch == opt->branch1 ? NULL : dest);
 	}
 
 	/* Update dest->path both in index and in worktree */
@@ -1476,12 +1476,14 @@ static int handle_change_delete(struct merge_options *opt,
 }
 
 static int handle_rename_delete(struct merge_options *opt,
-				struct diff_filepair *pair,
-				const char *rename_branch,
-				const char *delete_branch)
+				struct rename_conflict_info *ci)
 {
-	const struct diff_filespec *orig = pair->one;
-	const struct diff_filespec *dest = pair->two;
+	const struct rename *ren = ci->ren1;
+	const struct diff_filespec *orig = ren->pair->one;
+	const struct diff_filespec *dest = ren->pair->two;
+	const char *rename_branch = ren->branch;
+	const char *delete_branch = (opt->branch1 == ren->branch ?
+				     opt->branch2 : opt->branch1);
 
 	if (handle_change_delete(opt,
 				 opt->call_depth ? orig->path : dest->path,
@@ -3184,8 +3186,7 @@ static int process_entry(struct merge_options *opt,
 			break;
 		case RENAME_VIA_DIR:
 			clean_merge = 1;
-			if (handle_rename_via_dir(opt, ci->ren1->pair,
-						  ci->ren1->branch))
+			if (handle_rename_via_dir(opt, ci))
 				clean_merge = -1;
 			break;
 		case RENAME_ADD:
@@ -3199,9 +3200,7 @@ static int process_entry(struct merge_options *opt,
 			break;
 		case RENAME_DELETE:
 			clean_merge = 0;
-			if (handle_rename_delete(opt, ci->ren1->pair,
-						 ci->ren1->branch,
-						 ci->ren1->branch == opt->branch1 ? opt->branch2 : opt->branch1))
+			if (handle_rename_delete(opt, ci))
 				clean_merge = -1;
 			break;
 		case RENAME_ONE_FILE_TO_TWO:
-- 
2.21.0.211.g719c25afaf.dirty

