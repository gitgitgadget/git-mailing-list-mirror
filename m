Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46B081F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 17:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753256AbdKJRpD (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 12:45:03 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:41034 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752625AbdKJRpC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 12:45:02 -0500
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Nov 2017 12:45:02 EST
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAHbpm8020024
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 09:39:57 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e535n18cb-1
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 09:39:57 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 5F02522F444A
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 09:39:57 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 4DF212CDE6A
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 09:39:57 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/4] Remove silent clamp of renameLimit
Date:   Fri, 10 Nov 2017 09:39:54 -0800
Message-Id: <20171110173956.25105-3-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.5.g9567be9905
In-Reply-To: <20171110173956.25105-1-newren@gmail.com>
References: <20171110173956.25105-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100246
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
renames.  An upper bound may make sense, particularly as the computation
is O(rename_limit^2), but only if the bound is documented and communicated
to the user -- neither of which were true.

In fact, the silent clamping of the renameLimit to a smaller value and
lack of reporting of the needed renameLimit when it was too large made it
appear to the user as though they had used a high enough value; however,
git would proceed to mess up the merge or cherry-pick badly based on the
lack of rename detection.  Some hardy folks, despite the lack of feedback
on the correct limit to choose, were desperate enough to repeatedly retry
their cherry-picks with increasingly larger renameLimit values (going
orders of magnitude beyond the built-in limit of 32767), but were
consistently met with the same failure.

Although large limits can make things slow, we have users who would be
ecstatic to have a small five file change be correctly cherry picked even
if they have to manually specify a large limit and it took git ten minutes
to compute it.

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
index 0d8c3d2ee4..7f9a463f5a 100644
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
+	    ((double)num_create * (double)num_src
+	     <= (double)rename_limit * (double)rename_limit))
 		return 0;
 
 	options->needed_rename_limit =
@@ -415,7 +411,8 @@ static int too_many_rename_candidates(int num_create,
 		num_src++;
 	}
 	if ((num_create <= rename_limit || num_src <= rename_limit) &&
-	    (num_create * num_src <= rename_limit * rename_limit))
+	    ((double)num_create * (double)num_src
+	     <= (double)rename_limit * (double)rename_limit))
 		return 2;
 	return 1;
 }
-- 
2.15.0.5.g9567be9905

