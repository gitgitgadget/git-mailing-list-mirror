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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7043C1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbeKNK1H (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:27:07 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38476 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727203AbeKNK1E (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Nov 2018 05:27:04 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAE0Ib3l024224;
        Tue, 13 Nov 2018 16:26:04 -0800
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2nr7by051s-2
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
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 1806F221228A;
        Tue, 13 Nov 2018 16:26:01 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <larsxschneider@gmail.com>, <sandals@crustytoothpaste.net>,
        <peff@peff.net>, <me@ttaylorr.com>, <jrnieder@gmail.com>,
        <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 04/11] fast-export: avoid dying when filtering by paths and old tags exist
Date:   Tue, 13 Nov 2018 16:25:53 -0800
Message-ID: <20181114002600.29233-5-newren@gmail.com>
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
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If --tag-of-filtered-object=rewrite is specified along with a set of
paths to limit what is exported, then any tags pointing to old commits
that do not contain any of those specified paths cause problems.  Since
the old tagged commit is not exported, fast-export attempts to rewrite
such tags to an ancestor commit which was exported.  If no such commit
exists, then fast-export currently die()s.  Five years after the tag
rewriting logic was added to fast-export (see commit 2d8ad4691921,
"fast-export: Add a --tag-of-filtered-object  option for newly dangling
tags", 2009-06-25), fast-import gained the ability to delete refs (see
commit 4ee1b225b99f, "fast-import: add support to delete refs",
2014-04-20), so now we do have a valid option to rewrite the tag to.
Delete these tags instead of dying.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c  |  9 ++++++---
 t/t9350-fast-export.sh | 16 ++++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index af724e9937..b984a44224 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -774,9 +774,12 @@ static void handle_tag(const char *name, struct tag *tag)
 					break;
 				if (!(p->object.flags & TREESAME))
 					break;
-				if (!p->parents)
-					die("can't find replacement commit for tag %s",
-					     oid_to_hex(&tag->object.oid));
+				if (!p->parents) {
+					printf("reset %s\nfrom %s\n\n",
+					       name, sha1_to_hex(null_sha1));
+					free(buf);
+					return;
+				}
 				p = p->parents->item;
 			}
 			tagged_mark = get_object_mark(&p->object);
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 6a392e87bc..3400ebeb51 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -325,6 +325,22 @@ test_expect_success 'rewriting tag of filtered out object' '
 )
 '
 
+test_expect_success 'rewrite tag predating pathspecs to nothing' '
+	test_create_repo rewrite_tag_predating_pathspecs &&
+	(
+		cd rewrite_tag_predating_pathspecs &&
+
+		test_commit initial &&
+
+		git tag -a -m "Some old tag" v0.0.0.0.0.0.1 &&
+
+		test_commit bar &&
+
+		git fast-export --tag-of-filtered-object=rewrite --all -- bar.t >output &&
+		grep from.$ZERO_OID output
+	)
+'
+
 cat > limit-by-paths/expected << EOF
 blob
 mark :1
-- 
2.19.1.1063.g2b8e4a4f82.dirty

