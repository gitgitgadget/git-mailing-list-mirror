Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15EDD1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 17:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753290AbeDSR7B (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 13:59:01 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:42140 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752706AbeDSR6h (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Apr 2018 13:58:37 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3JHw4P4014666;
        Thu, 19 Apr 2018 10:58:30 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hdry1au8e-1;
        Thu, 19 Apr 2018 10:58:30 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id A0D7D22175C5;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 976572CDEED;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH v10 34/36] merge-recursive: fix remainder of was_dirty() to use original index
Date:   Thu, 19 Apr 2018 10:58:21 -0700
Message-Id: <20180419175823.7946-35-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.290.ge988e9ce2a
In-Reply-To: <20180419175823.7946-1-newren@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804190157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

was_dirty() uses was_tracked(), which has been updated to use the original
index rather than the current one.  However, was_dirty() also had a
separate call to cache_file_exists(), causing it to still implicitly use
the current index.  Update that to instead use index_file_exists().

Also, was_dirty() had a hack where it would mark any file as non-dirty if
we simply didn't know its modification time.  This was due to using the
current index rather than the original index, because D/F conflicts and
such would cause unpack_trees() to not copy the modification times from
the original index to the current one.  Now that we are using the original
index, we can dispense with this hack.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 097de7e5a7..1a481fa3dc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -842,9 +842,9 @@ static int was_dirty(struct merge_options *o, const char *path)
 	if (o->call_depth || !was_tracked(o, path))
 		return !dirty;
 
-	ce = cache_file_exists(path, strlen(path), ignore_case);
-	dirty = (ce->ce_stat_data.sd_mtime.sec > 0 &&
-		 verify_uptodate(ce, &o->unpack_opts) != 0);
+	ce = index_file_exists(o->unpack_opts.src_index,
+			       path, strlen(path), ignore_case);
+	dirty = verify_uptodate(ce, &o->unpack_opts) != 0;
 	return dirty;
 }
 
-- 
2.17.0.290.ge988e9ce2a

