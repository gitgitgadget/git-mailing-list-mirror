Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC83D1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 21:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeJMFAY (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 01:00:24 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:39108 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726131AbeJMFAY (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 13 Oct 2018 01:00:24 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9CLNfWq011264;
        Fri, 12 Oct 2018 14:25:58 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2mxtwhajtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 12 Oct 2018 14:25:58 -0700
Received: from sj-prod-exch-02.YOJOE.local (10.160.10.15) by
 sj-prod-exch-02.YOJOE.local (10.160.10.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 12 Oct 2018 14:25:56 -0700
Received: from EX02-WEST.YOJOE.local (10.160.10.131) by
 sj-prod-exch-02.YOJOE.local (10.160.10.15) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Fri, 12 Oct 2018 14:25:56 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 EX02-WEST.YOJOE.local (10.160.10.131) with Microsoft SMTP Server id
 14.3.319.2; Fri, 12 Oct 2018 14:25:53 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech
 [10.100.71.66])        by smtp-transport.yojoe.local (Postfix) with ESMTPS id
 92D26209F075;  Fri, 12 Oct 2018 14:25:53 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH 4/4] merge-recursive: Avoid showing conflicts with merge branch before HEAD
Date:   Fri, 12 Oct 2018 14:25:51 -0700
Message-ID: <20181012212551.7689-5-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.235.g7c386e1068
In-Reply-To: <20181012212551.7689-1-newren@gmail.com>
References: <20181012212551.7689-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-12_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810120214
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want to load unmerged entries from HEAD into the index at stage 2 and
from MERGE_HEAD into stage 3.  Similarly, folks expect merge conflicts
to look like

<<<<<<<< HEAD
content from our side
========
content from their side
>>>>>>>> MERGE_HEAD

not

<<<<<<<< MERGE_HEAD
content from their side
========
content from our side
>>>>>>>> HEAD

The correct order usually comes naturally and for free, but with renames
we often have data in the form {rename_branch, other_branch}, and
working relative to the rename first (e.g. for rename/add) is more
convenient elsewhere in the code.  Address the slight impedance
mismatch by having some functions re-call themselves with flipped
arguments when the branch order is reversed.

Note that setup_rename_conflict_info() has one asymmetry in it, in
setting dst_entry1->processed=0 but not doing similarly for
dst_entry2->processed.  When dealing with rename/rename and similar
conflicts, we do not want the processing to happen twice, so the
desire to only set one of the entries to unprocessed is intentional.
So, while this change modifies which branch's entry will be marked as
unprocessed, that dovetails nicely with putting HEAD first so that we
get the index stage entries and conflict markers in the right order.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                 | 33 ++++++++++++++++++++++++++++++-
 t/t6036-recursive-corner-cases.sh |  8 ++++----
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 33cd9ee81f..f795c92a69 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -228,7 +228,26 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 					      struct stage_data *src_entry1,
 					      struct stage_data *src_entry2)
 {
-	struct rename_conflict_info *ci = xcalloc(1, sizeof(struct rename_conflict_info));
+	struct rename_conflict_info *ci;
+
+	/*
+	 * When we have two renames involved, it's easiest to get the
+	 * correct things into stage 2 and 3, and to make sure that the
+	 * content merge puts HEAD before the other branch if we just
+	 * ensure that branch1 == o->branch1.  So, simply flip arguments
+	 * around if we don't have that.
+	 */
+	if (dst_entry2 && branch1 != o->branch1) {
+		setup_rename_conflict_info(rename_type,
+					   pair2,      pair1,
+					   branch2,    branch1,
+					   dst_entry2, dst_entry1,
+					   o,
+					   src_entry2, src_entry1);
+		return;
+	}
+
+	ci = xcalloc(1, sizeof(struct rename_conflict_info));
 	ci->rename_type = rename_type;
 	ci->pair1 = pair1;
 	ci->branch1 = branch1;
@@ -1286,6 +1305,18 @@ static int merge_mode_and_contents(struct merge_options *o,
 				   const int extra_marker_size,
 				   struct merge_file_info *result)
 {
+	if (o->branch1 != branch1) {
+		/*
+		 * It's weird getting a reverse merge with HEAD on the bottom
+		 * side of the conflict markers and the other branch on the
+		 * top.  Fix that.
+		 */
+		return merge_mode_and_contents(o, one, b, a,
+					       filename,
+					       branch2, branch1,
+					       extra_marker_size, result);
+	}
+
 	result->merge = 0;
 	result->clean = 1;
 
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 21954db624..276b4e8792 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -230,13 +230,13 @@ test_expect_success 'git detects differently handled merges conflict' '
 			:2:new_a :3:new_a &&
 		test_cmp expect actual &&
 
-		git cat-file -p B:new_a >ours &&
-		git cat-file -p C:new_a >theirs &&
+		git cat-file -p C:new_a >ours &&
+		git cat-file -p B:new_a >theirs &&
 		>empty &&
 		test_must_fail git merge-file \
-			-L "Temporary merge branch 2" \
-			-L "" \
 			-L "Temporary merge branch 1" \
+			-L "" \
+			-L "Temporary merge branch 2" \
 			ours empty theirs &&
 		sed -e "s/^\([<=>]\)/\1\1\1/" ours >expect &&
 		git cat-file -p :1:new_a >actual &&
-- 
2.19.0.235.g7c386e1068

