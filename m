Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3C8C1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbeKNK1G (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:27:06 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38474 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731199AbeKNK1F (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Nov 2018 05:27:05 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAE0Ib3m024224;
        Tue, 13 Nov 2018 16:26:04 -0800
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2nr7by051s-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 13 Nov 2018 16:26:04 -0800
Received: from dc-prod-exch-01.YOJOE.local (10.193.18.14) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 13 Nov 2018 19:26:02 -0500
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 13 Nov 2018 19:26:02 -0500
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 25FEF221228C;
        Tue, 13 Nov 2018 16:26:01 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <larsxschneider@gmail.com>, <sandals@crustytoothpaste.net>,
        <peff@peff.net>, <me@ttaylorr.com>, <jrnieder@gmail.com>,
        <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 06/11] fast-export: when using paths, avoid corrupt stream with non-existent mark
Date:   Tue, 13 Nov 2018 16:25:55 -0800
Message-ID: <20181114002600.29233-7-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.1063.g2b8e4a4f82.dirty
In-Reply-To: <20181114002600.29233-1-newren@gmail.com>
References: <20181111062312.16342-1-newren@gmail.com>
 <20181114002600.29233-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-13_17:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=893 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If file paths are specified to fast-export and multiple refs point to a
commit that does not touch any of the relevant file paths, then
fast-export can hit problems.  fast-export has a list of additional refs
that it needs to explicitly set after exporting all blobs and commits,
and when it tries to get_object_mark() on the relevant commit, it can
get a mark of 0, i.e. "not found", because the commit in question did
not touch the relevant paths and thus was not exported.  Trying to
import a stream with a mark corresponding to an unexported object will
cause fast-import to crash.

Avoid this problem by taking the commit the ref points to and finding an
ancestor of it that was exported, and make the ref point to that commit
instead.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c  | 13 ++++++++++++-
 t/t9350-fast-export.sh | 20 ++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 7888fc98b5..2eafe351ea 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -900,7 +900,18 @@ static void handle_tags_and_duplicates(void)
 			if (anonymize)
 				name = anonymize_refname(name);
 			/* create refs pointing to already seen commits */
-			commit = (struct commit *)object;
+			commit = rewrite_commit((struct commit *)object);
+			if (!commit) {
+				/*
+				 * Neither this object nor any of its
+				 * ancestors touch any relevant paths, so
+				 * it has been filtered to nothing.  Delete
+				 * it.
+				 */
+				printf("reset %s\nfrom %s\n\n",
+				       name, sha1_to_hex(null_sha1));
+				continue;
+			}
 			printf("reset %s\nfrom :%d\n\n", name,
 			       get_object_mark(&commit->object));
 			show_progress();
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 3400ebeb51..299120ba70 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -382,6 +382,26 @@ test_expect_success 'path limiting with import-marks does not lose unmodified fi
 	grep file0 actual
 '
 
+test_expect_success 'avoid corrupt stream with non-existent mark' '
+	test_create_repo avoid_non_existent_mark &&
+	(
+		cd avoid_non_existent_mark &&
+
+		test_commit important-path &&
+
+		test_commit ignored &&
+
+		git branch A &&
+		git branch B &&
+
+		echo foo >>important-path.t &&
+		git add important-path.t &&
+		test_commit more changes &&
+
+		git fast-export --all -- important-path.t | git fast-import --force
+	)
+'
+
 test_expect_success 'full-tree re-shows unmodified files'        '
 	git checkout -f simple &&
 	git fast-export --full-tree simple >actual &&
-- 
2.19.1.1063.g2b8e4a4f82.dirty

