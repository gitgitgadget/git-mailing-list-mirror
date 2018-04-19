Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D1561F404
	for <e@80x24.org>; Thu, 19 Apr 2018 17:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753318AbeDSR7D (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 13:59:03 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:41718 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752671AbeDSR6h (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Apr 2018 13:58:37 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3JHnHYv028676;
        Thu, 19 Apr 2018 10:58:30 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hdryeas76-1;
        Thu, 19 Apr 2018 10:58:29 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id C7E3422175CB;
        Thu, 19 Apr 2018 10:58:28 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id BEEBD2CDEED;
        Thu, 19 Apr 2018 10:58:28 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH v10 14/36] merge-recursive: fix leaks of allocated renames and diff_filepairs
Date:   Thu, 19 Apr 2018 10:58:01 -0700
Message-Id: <20180419175823.7946-15-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.290.ge988e9ce2a
In-Reply-To: <20180419175823.7946-1-newren@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804190156
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get_renames() has always zero'ed out diff_queued_diff.nr while only
manually free'ing diff_filepairs that did not correspond to renames.
Further, it allocated struct renames that were tucked away in the
return string_list.  Make sure all of these are deallocated when we
are done with them.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 40e142efdb..fc96653f63 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1663,13 +1663,23 @@ static int handle_renames(struct merge_options *o,
 	return process_renames(o, ri->head_renames, ri->merge_renames);
 }
 
-static void cleanup_renames(struct rename_info *re_info)
+static void cleanup_rename(struct string_list *rename)
 {
-	string_list_clear(re_info->head_renames, 0);
-	string_list_clear(re_info->merge_renames, 0);
+	const struct rename *re;
+	int i;
 
-	free(re_info->head_renames);
-	free(re_info->merge_renames);
+	for (i = 0; i < rename->nr; i++) {
+		re = rename->items[i].util;
+		diff_free_filepair(re->pair);
+	}
+	string_list_clear(rename, 1);
+	free(rename);
+}
+
+static void cleanup_renames(struct rename_info *re_info)
+{
+	cleanup_rename(re_info->head_renames);
+	cleanup_rename(re_info->merge_renames);
 }
 
 static struct object_id *stage_oid(const struct object_id *oid, unsigned mode)
-- 
2.17.0.290.ge988e9ce2a

