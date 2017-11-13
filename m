Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 102D71F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 20:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755424AbdKMUQM (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 15:16:12 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:59620 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755271AbdKMUQI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2017 15:16:08 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vADKDv91011915;
        Mon, 13 Nov 2017 12:16:06 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e5yxp31b9-1;
        Mon, 13 Nov 2017 12:16:06 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 7C5D62265D3D;
        Mon, 13 Nov 2017 12:16:06 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 734982CDF18;
        Mon, 13 Nov 2017 12:16:06 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 3/4] Remove silent clamp of renameLimit
Date:   Mon, 13 Nov 2017 12:15:59 -0800
Message-Id: <20171113201600.24878-4-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.44.gf995e411c7
In-Reply-To: <20171113201600.24878-1-newren@gmail.com>
References: <20171113201600.24878-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-13_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711130279
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 0024a5492 (Fix the rename detection limit checking; 2007-09-14),
the renameLimit was clamped to 32767.  This appears to have been to simply
avoid integer overflow in the following computation:

   num_create * num_src <= rename_limit * rename_limit

although it also could be viewed as a hardcoded bound on the amount of CPU
time we're willing to allow users to tell git to spend on handling
renames.  An upper bound may make sense, but unfortunately this upper
bound was neither communicated to the users, nor documented anywhere.

Although large limits can make things slow, we have users who would be
ecstatic to have a small five file change be correctly cherry picked even
if they have to manually specify a large limit and wait ten minutes for
the renames to be detected.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c            |  2 +-
 diffcore-rename.c | 11 ++++-------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 6fd288420b..c6597e3231 100644
--- a/diff.c
+++ b/diff.c
@@ -5524,7 +5524,7 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
 		warning(_(rename_limit_warning));
 	else
 		return;
-	if (0 < needed && needed < 32767)
+	if (0 < needed)
 		warning(_(rename_limit_advice), varname, needed);
 }
 
diff --git a/diffcore-rename.c b/diffcore-rename.c
index c03f484d53..32366632f4 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -391,14 +391,10 @@ static int too_many_rename_candidates(int num_create,
 	 * growing larger than a "rename_limit" square matrix, ie:
 	 *
 	 *    num_create * num_src > rename_limit * rename_limit
-	 *
-	 * but handles the potential overflow case specially (and we
-	 * assume at least 32-bit integers)
 	 */
-	if (rename_limit <= 0 || rename_limit > 32767)
-		rename_limit = 32767;
 	if ((num_create <= rename_limit || num_src <= rename_limit) &&
-	    (num_create * num_src <= rename_limit * rename_limit))
+	    ((uint64_t)num_create * (uint64_t)num_src
+	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
 		return 0;
 
 	options->needed_rename_limit =
@@ -415,7 +411,8 @@ static int too_many_rename_candidates(int num_create,
 		num_src++;
 	}
 	if ((num_create <= rename_limit || num_src <= rename_limit) &&
-	    (num_create * num_src <= rename_limit * rename_limit))
+	    ((uint64_t)num_create * (uint64_t)num_src
+	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
 		return 2;
 	return 1;
 }
-- 
2.15.0.44.gf995e411c7

