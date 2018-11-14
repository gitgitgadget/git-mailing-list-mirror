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
	by dcvr.yhbt.net (Postfix) with ESMTP id 90D011F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbeKNK1E (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:27:04 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:52794 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731048AbeKNK1C (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Nov 2018 05:27:02 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAE0HiRt006748;
        Tue, 13 Nov 2018 16:26:03 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2nr7bw058u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 13 Nov 2018 16:26:03 -0800
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 13 Nov 2018 16:26:00 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 13 Nov 2018 16:25:56 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 1F06B221228B;
        Tue, 13 Nov 2018 16:26:01 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <larsxschneider@gmail.com>, <sandals@crustytoothpaste.net>,
        <peff@peff.net>, <me@ttaylorr.com>, <jrnieder@gmail.com>,
        <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 05/11] fast-export: move commit rewriting logic into a function for reuse
Date:   Tue, 13 Nov 2018 16:25:54 -0800
Message-ID: <20181114002600.29233-6-newren@gmail.com>
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
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Logic to replace a filtered commit with an unfiltered ancestor is useful
elsewhere; put it into a function we can call.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index b984a44224..7888fc98b5 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -187,6 +187,22 @@ static int get_object_mark(struct object *object)
 	return ptr_to_mark(decoration);
 }
 
+static struct commit *rewrite_commit(struct commit *p)
+{
+	for (;;) {
+		if (p->parents && p->parents->next)
+			break;
+		if (p->object.flags & UNINTERESTING)
+			break;
+		if (!(p->object.flags & TREESAME))
+			break;
+		if (!p->parents)
+			return NULL;
+		p = p->parents->item;
+	}
+	return p;
+}
+
 static void show_progress(void)
 {
 	static int counter = 0;
@@ -766,21 +782,12 @@ static void handle_tag(const char *name, struct tag *tag)
 				    oid_to_hex(&tag->object.oid),
 				    type_name(tagged->type));
 			}
-			p = (struct commit *)tagged;
-			for (;;) {
-				if (p->parents && p->parents->next)
-					break;
-				if (p->object.flags & UNINTERESTING)
-					break;
-				if (!(p->object.flags & TREESAME))
-					break;
-				if (!p->parents) {
-					printf("reset %s\nfrom %s\n\n",
-					       name, sha1_to_hex(null_sha1));
-					free(buf);
-					return;
-				}
-				p = p->parents->item;
+			p = rewrite_commit((struct commit *)tagged);
+			if (!p) {
+				printf("reset %s\nfrom %s\n\n",
+				       name, sha1_to_hex(null_sha1));
+				free(buf);
+				return;
 			}
 			tagged_mark = get_object_mark(&p->object);
 		}
-- 
2.19.1.1063.g2b8e4a4f82.dirty

