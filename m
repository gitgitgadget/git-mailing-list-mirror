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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C55020248
	for <e@80x24.org>; Sat, 30 Mar 2019 00:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfC3AeV (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 20:34:21 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:36392 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730168AbfC3AeT (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Mar 2019 20:34:19 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2U0XVDv015420;
        Fri, 29 Mar 2019 17:34:03 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2rht7wrarh-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 29 Mar 2019 17:34:02 -0700
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 29 Mar 2019 17:33:59 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 29 Mar 2019 17:33:57 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 72744220CB32;
        Fri, 29 Mar 2019 17:33:56 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 13/15] merge-recursive: track information associated with directory renames
Date:   Fri, 29 Mar 2019 17:33:34 -0700
Message-ID: <20190330003336.21940-14-newren@gmail.com>
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
 mlxlogscore=994 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903300002
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Directory rename detection previously silently applied.  In order to
allow printing information about paths that changed or printing a
conflict notification (and only doing so near other potential conflict
messages associated with the paths), save this information inside the
rename struct for later use.  A subsequent patch will make use of the
additional information.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1d2c9e1772..938a526b20 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -207,8 +207,16 @@ struct stage_data {
 };
 
 struct rename {
+	unsigned processed:1;
 	struct diff_filepair *pair;
 	const char *branch; /* branch that the rename occurred on */
+	/*
+	 * If directory rename detection affected this rename, what was its
+	 * original type ('A' or 'R') and it's original destination before
+	 * the directory rename (otherwise, '\0' and NULL for these two vars).
+	 */
+	char dir_rename_original_type;
+	char *dir_rename_original_dest;
 	/*
 	 * Purpose of src_entry and dst_entry:
 	 *
@@ -230,8 +238,6 @@ struct rename {
 	 */
 	struct stage_data *src_entry;
 	struct stage_data *dst_entry;
-	unsigned add_turned_into_rename:1;
-	unsigned processed:1;
 };
 
 struct rename_conflict_info {
@@ -2484,16 +2490,18 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		       &re->dst_entry->stages[stage].oid,
 		       &re->dst_entry->stages[stage].mode);
 
-	/* Update pair status */
-	if (pair->status == 'A') {
-		/*
-		 * Recording rename information for this add makes it look
-		 * like a rename/delete conflict.  Make sure we can
-		 * correctly handle this as an add that was moved to a new
-		 * directory instead of reporting a rename/delete conflict.
-		 */
-		re->add_turned_into_rename = 1;
-	}
+	/*
+	 * Record the original change status (or 'type' of change).  If it
+	 * was originally an add ('A'), this lets us differentiate later
+	 * between a RENAME_DELETE conflict and RENAME_VIA_DIR (they
+	 * otherwise look the same).  If it was originally a rename ('R'),
+	 * this lets us remember and report accurately about the transitive
+	 * renaming that occurred via the directory rename detection.  Also,
+	 * record the original destination name.
+	 */
+	re->dir_rename_original_type = pair->status;
+	re->dir_rename_original_dest = pair->two->path;
+
 	/*
 	 * We don't actually look at pair->status again, but it seems
 	 * pedagogically correct to adjust it.
@@ -2556,9 +2564,10 @@ static struct string_list *get_renames(struct merge_options *opt,
 
 		re = xmalloc(sizeof(*re));
 		re->processed = 0;
-		re->add_turned_into_rename = 0;
 		re->pair = pair;
 		re->branch = branch;
+		re->dir_rename_original_type = '\0';
+		re->dir_rename_original_dest = NULL;
 		item = string_list_lookup(entries, re->pair->one->path);
 		if (!item)
 			re->src_entry = insert_stage_data(re->pair->one->path,
@@ -2726,7 +2735,7 @@ static int process_renames(struct merge_options *opt,
 			try_merge = 0;
 
 			if (oid_eq(&src_other.oid, &null_oid) &&
-			    ren1->add_turned_into_rename) {
+			    ren1->dir_rename_original_type == 'A') {
 				setup_rename_conflict_info(RENAME_VIA_DIR,
 							   opt, ren1, NULL);
 			} else if (oid_eq(&src_other.oid, &null_oid)) {
-- 
2.21.0.211.g078f4bef79.dirty

