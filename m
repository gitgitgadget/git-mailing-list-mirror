Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD4B91F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 22:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754569AbdKJWWH (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 17:22:07 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:50368 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754413AbdKJWWF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 17:22:05 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAMCar0030101;
        Fri, 10 Nov 2017 14:22:03 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e535n1nd7-1;
        Fri, 10 Nov 2017 14:22:03 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 95A7522F94D7;
        Fri, 10 Nov 2017 14:22:03 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 8A1CD2CDEC1;
        Fri, 10 Nov 2017 14:22:03 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 2/9] merge-recursive: Avoid unnecessary string list lookups
Date:   Fri, 10 Nov 2017 14:21:49 -0800
Message-Id: <20171110222156.23221-3-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.46.g41dca04efb
In-Reply-To: <20171110222156.23221-1-newren@gmail.com>
References: <20171110222156.23221-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100306
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we're taking entries from active_cache, which is already in sorted
order with same-named entries adjacent, we can skip a lookup.  Also, we can
just use append instead of insert (avoiding the need to find where to put
the new item) and still end up with a sorted list.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Assumed negligible performance change; I didn't even bother measuring it.
But I just happened to be looking around at this code while trying to figure
out some of the performance and figured it was at least speeding it up a
tiny bit.

 merge-recursive.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 6ef1d52f0a..d54466649e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -451,22 +451,28 @@ static struct stage_data *insert_stage_data(const char *path,
 static struct string_list *get_unmerged(void)
 {
 	struct string_list *unmerged = xcalloc(1, sizeof(struct string_list));
+	struct string_list_item *item;
+	const char *last = NULL;
 	int i;
 
 	unmerged->strdup_strings = 1;
 
 	for (i = 0; i < active_nr; i++) {
-		struct string_list_item *item;
 		struct stage_data *e;
 		const struct cache_entry *ce = active_cache[i];
 		if (!ce_stage(ce))
 			continue;
 
-		item = string_list_lookup(unmerged, ce->name);
-		if (!item) {
-			item = string_list_insert(unmerged, ce->name);
+		if (last == NULL || strcmp(last, ce->name)) {
+			/*
+			 * active_cache is in sorted order, so we can just call
+			 * string_list_append instead of string_list_insert and
+			 * still end up with a sorted list.
+			 */
+			item = string_list_append(unmerged, ce->name);
 			item->util = xcalloc(1, sizeof(struct stage_data));
 		}
+		last = ce->name;
 		e = item->util;
 		e->stages[ce_stage(ce)].mode = ce->ce_mode;
 		oidcpy(&e->stages[ce_stage(ce)].oid, &ce->oid);
-- 
2.15.0.46.g41dca04efb

