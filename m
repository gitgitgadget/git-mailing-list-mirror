Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 061CF1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 01:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfBHBNE (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 20:13:04 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:40512 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726799AbfBHBNE (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Feb 2019 20:13:04 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x181CbXv013117;
        Thu, 7 Feb 2019 17:12:53 -0800
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2qgv6hr9yv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 07 Feb 2019 17:12:53 -0800
Received: from dc-prod-exch-01.YOJOE.local (10.193.18.14) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Thu, 7 Feb 2019 20:12:50 -0500
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Thu, 7 Feb 2019 20:12:50 -0500
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id E696121E6B40;
        Thu,  7 Feb 2019 17:12:49 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 2/2] squash! log,diff-tree: add --combined-all-paths option
Date:   Thu, 7 Feb 2019 17:12:47 -0800
Message-ID: <20190208011247.21021-3-newren@gmail.com>
X-Mailer: git-send-email 2.20.1.311.gb8408a6075
In-Reply-To: <20190208011247.21021-1-newren@gmail.com>
References: <20190204200754.16413-1-newren@gmail.com>
 <20190208011247.21021-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-07_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080008
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This also adds "rename from <oldpath>" and "copy from <oldpath>"
extended headers when renames or copies are involved.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/diff-generate-patch.txt |  7 +++----
 combine-diff.c                        | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index f10ca410ad..f0c2a17aef 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -128,12 +128,11 @@ or like this (when `--cc` option is used):
        mode <mode>,<mode>..<mode>
        new file mode <mode>
        deleted file mode <mode>,<mode>
+       copy from <path>
+       rename from <path>
 +
 The `mode <mode>,<mode>..<mode>` line appears only if at least one of
-the <mode> is different from the rest. Extended headers with
-information about detected contents movement (renames and
-copying detection) are designed to work with diff of two
-<tree-ish> and are not used by combined diff format.
+the <mode> is different from the rest.
 
 3.   It is followed by two-line from-file/to-file header
 
diff --git a/combine-diff.c b/combine-diff.c
index 54cb892ae5..04a139ea03 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -981,6 +981,21 @@ static void show_combined_header(struct combine_diff_path *elem,
 		printf("%s\n", c_reset);
 	}
 
+	for (i = 0; i < num_parent; i++) {
+		switch (elem->parent[i].status) {
+		case DIFF_STATUS_COPIED:
+			dump_quoted_path("copy from ", "",
+					 elem->parent[i].path.buf,
+					 line_prefix, c_meta, c_reset);
+			break;
+		case DIFF_STATUS_RENAMED:
+			dump_quoted_path("rename from ", "",
+					 elem->parent[i].path.buf,
+					 line_prefix, c_meta, c_reset);
+			break;
+		}
+	}
+
 	if (!show_file_header)
 		return;
 
-- 
2.20.1.311.gb8408a6075

