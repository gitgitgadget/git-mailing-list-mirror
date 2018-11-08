Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D71C81F453
	for <e@80x24.org>; Thu,  8 Nov 2018 04:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbeKHOOR (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 09:14:17 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:47310 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbeKHOOR (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Nov 2018 09:14:17 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA84bwu9026337;
        Wed, 7 Nov 2018 20:40:38 -0800
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2nm9610eb8-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 07 Nov 2018 20:40:38 -0800
Received: from dc-prod-exch-01.YOJOE.local (10.193.18.14) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Wed, 7 Nov 2018 23:40:35 -0500
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Wed, 7 Nov 2018 23:40:34 -0500
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 394DF2101E99;
        Wed,  7 Nov 2018 20:40:34 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 10/10] merge-recursive: combine error handling
Date:   Wed, 7 Nov 2018 20:40:31 -0800
Message-ID: <20181108044031.25885-11-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.858.g526e8fe740.dirty
In-Reply-To: <20181108044031.25885-1-newren@gmail.com>
References: <CABPp-BG2rFEeKVe8ok+a-jLFvPBfnZs1b3Mp2Jfi2JgNZcO8gA@mail.gmail.com>
 <20181108044031.25885-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=819 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080038
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <stolee@gmail.com>

In handle_rename_rename_1to2(), we have duplicated error handling
around colliding paths. Specifically, when we want to write out
the file and there is a directory or untracked file in the way,
we need to create a temporary file to hold the contents. This has
some special output to alert the user, and this output is
duplicated for each side of the conflict.

Simplify the call by generating this new path in a helper
function.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 53 ++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 3e2a63d094..ecf8db0b71 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1710,6 +1710,27 @@ static int handle_rename_add(struct merge_options *o,
 				     ci->dst_entry1->stages[other_stage].mode);
 }
 
+static char *find_path_for_conflict(struct merge_options *o,
+				    const char *path,
+				    const char *branch1,
+				    const char *branch2)
+{
+	char *new_path = NULL;
+	if (dir_in_way(path, !o->call_depth, 0)) {
+		new_path = unique_path(o, path, branch1);
+		output(o, 1, _("%s is a directory in %s adding "
+			       "as %s instead"),
+		       path, branch2, new_path);
+	} else if (would_lose_untracked(path)) {
+		new_path = unique_path(o, path, branch1);
+		output(o, 1, _("Refusing to lose untracked file"
+			       " at %s; adding as %s instead"),
+		       path, new_path);
+	}
+
+	return new_path;
+}
+
 static int handle_rename_rename_1to2(struct merge_options *o,
 				     struct rename_conflict_info *ci)
 {
@@ -1784,19 +1805,9 @@ static int handle_rename_rename_1to2(struct merge_options *o,
 						  &add->oid, add->mode) < 0)
 				return -1;
 		} else {
-			char *new_path = NULL;
-			if (dir_in_way(a->path, !o->call_depth, 0)) {
-				new_path = unique_path(o, a->path, ci->branch1);
-				output(o, 1, _("%s is a directory in %s adding "
-					       "as %s instead"),
-				       a->path, ci->branch2, new_path);
-			} else if (would_lose_untracked(a->path)) {
-				new_path = unique_path(o, a->path, ci->branch1);
-				output(o, 1, _("Refusing to lose untracked file"
-					       " at %s; adding as %s instead"),
-				       a->path, new_path);
-			}
-
+			char *new_path = find_path_for_conflict(o, a->path,
+								ci->branch1,
+								ci->branch2);
 			if (update_file(o, 0, &mfi.oid, mfi.mode, new_path ? new_path : a->path))
 				return -1;
 			free(new_path);
@@ -1813,19 +1824,9 @@ static int handle_rename_rename_1to2(struct merge_options *o,
 						  &mfi.oid, mfi.mode) < 0)
 				return -1;
 		} else {
-			char *new_path = NULL;
-			if (dir_in_way(b->path, !o->call_depth, 0)) {
-				new_path = unique_path(o, b->path, ci->branch2);
-				output(o, 1, _("%s is a directory in %s adding "
-					       "as %s instead"),
-				       b->path, ci->branch1, new_path);
-			} else if (would_lose_untracked(b->path)) {
-				new_path = unique_path(o, b->path, ci->branch2);
-				output(o, 1, _("Refusing to lose untracked file"
-					       " at %s; adding as %s instead"),
-				       b->path, new_path);
-			}
-
+			char *new_path = find_path_for_conflict(o, b->path,
+								ci->branch2,
+								ci->branch1);
 			if (update_file(o, 0, &mfi.oid, mfi.mode, new_path ? new_path : b->path))
 				return -1;
 			free(new_path);
-- 
2.19.1.858.g526e8fe740.dirty

