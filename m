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
	by dcvr.yhbt.net (Postfix) with ESMTP id D60521F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 08:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388978AbeKPSLb (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 13:11:31 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:47636 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727410AbeKPSLa (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Nov 2018 13:11:30 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAG7wrCR022772;
        Fri, 16 Nov 2018 00:00:00 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2nr7by3kq4-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 16 Nov 2018 00:00:00 -0800
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 16 Nov 2018 00:00:02 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 16 Nov 2018 00:00:02 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 53E7A2212289;
        Thu, 15 Nov 2018 23:59:58 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, <larsxschneider@gmail.com>,
        <sandals@crustytoothpaste.net>, <peff@peff.net>, <me@ttaylorr.com>,
        <jrnieder@gmail.com>, <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 06/11] fast-export: move commit rewriting logic into a function for reuse
Date:   Thu, 15 Nov 2018 23:59:51 -0800
Message-ID: <20181116075956.27047-7-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.1063.g1796373474.dirty
In-Reply-To: <20181116075956.27047-1-newren@gmail.com>
References: <20181114002600.29233-1-newren@gmail.com>
 <20181116075956.27047-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811160073
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
index 7d50f5414e..43e98a38a8 100644
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
@@ -767,21 +783,12 @@ static void handle_tag(const char *name, struct tag *tag)
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
-					       name, oid_to_hex(&null_oid));
-					free(buf);
-					return;
-				}
-				p = p->parents->item;
+			p = rewrite_commit((struct commit *)tagged);
+			if (!p) {
+				printf("reset %s\nfrom %s\n\n",
+				       name, oid_to_hex(&null_oid));
+				free(buf);
+				return;
 			}
 			tagged_mark = get_object_mark(&p->object);
 		}
-- 
2.19.1.1063.g1796373474.dirty

