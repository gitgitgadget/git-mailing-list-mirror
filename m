Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31CD202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbdKTWCO (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:02:14 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38016 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751253AbdKTWCN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2017 17:02:13 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAKLxBmW020083;
        Mon, 20 Nov 2017 14:02:09 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2eakkpb8qf-1;
        Mon, 20 Nov 2017 14:02:09 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 7F02722F41A3;
        Mon, 20 Nov 2017 14:02:09 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 7AF772CDEB1;
        Mon, 20 Nov 2017 14:02:09 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 03/33] merge-recursive: add explanation for src_entry and dst_entry
Date:   Mon, 20 Nov 2017 14:01:39 -0800
Message-Id: <20171120220209.15111-4-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.323.g31fe956618
In-Reply-To: <20171120220209.15111-1-newren@gmail.com>
References: <20171120220209.15111-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-20_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711200295
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I have to walk through the debugger and inspect the values found in
here in order to figure out their meaning, despite having known these
things inside and out some years back, then they probably need a comment
for the casual reader to explain their purpose.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 944f938ec8..c530880333 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -513,6 +513,25 @@ static void record_df_conflict_files(struct merge_options *o,
 
 struct rename {
 	struct diff_filepair *pair;
+	/*
+	 * Purpose of src_entry and dst_entry:
+	 *
+	 * If 'before' is renamed to 'after' then src_entry will contain
+	 * the versions of 'before' from the merge_base, HEAD, and MERGE in
+	 * stages 1, 2, and 3; dst_entry will contain the respective
+	 * versions of 'after' in corresponding locations.  Thus, we have a
+	 * total of six modes and oids, though some will be null.  (Stage 0
+	 * is ignored; we're interested in handling conflicts.)
+	 *
+	 * Since we don't turn on break-rewrites by default, neither
+	 * src_entry nor dst_entry can have all three of their stages have
+	 * non-null oids, meaning at most four of the six will be non-null.
+	 * Also, since this is a rename, both src_entry and dst_entry will
+	 * have at least one non-null oid, meaning at least two will be
+	 * non-null.  Of the six oids, a typical rename will have three be
+	 * non-null.  Only two implies a rename/delete, and four implies a
+	 * rename/add.
+	 */
 	struct stage_data *src_entry;
 	struct stage_data *dst_entry;
 	unsigned processed:1;
-- 
2.15.0.309.g00c152f825

