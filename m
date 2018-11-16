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
	by dcvr.yhbt.net (Postfix) with ESMTP id 86DB01F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 08:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389350AbeKPSLc (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 13:11:32 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:47650 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727878AbeKPSLc (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Nov 2018 13:11:32 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAG7wrCO022772;
        Fri, 16 Nov 2018 00:00:00 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2nr7by3kq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 15 Nov 2018 23:59:59 -0800
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 16 Nov 2018 00:00:01 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 16 Nov 2018 00:00:01 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 213C52212283;
        Thu, 15 Nov 2018 23:59:58 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, <larsxschneider@gmail.com>,
        <sandals@crustytoothpaste.net>, <peff@peff.net>, <me@ttaylorr.com>,
        <jrnieder@gmail.com>, <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 01/11] fast-export: convert sha1 to oid
Date:   Thu, 15 Nov 2018 23:59:46 -0800
Message-ID: <20181116075956.27047-2-newren@gmail.com>
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
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811160073
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename anonymize_sha1() to anonymize_oid(() and change its signature,
and switch from sha1_to_hex() to oid_to_hex() and from GIT_SHA1_RAWSZ to
the_hash_algo->rawsz.  Also change a comment and a die string to mention
oid instead of sha1.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 456797c12a..f5166ac71e 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -243,7 +243,7 @@ static void export_blob(const struct object_id *oid)
 		if (!buf)
 			die("could not read blob %s", oid_to_hex(oid));
 		if (check_object_signature(oid, buf, size, type_name(type)) < 0)
-			die("sha1 mismatch in blob %s", oid_to_hex(oid));
+			die("oid mismatch in blob %s", oid_to_hex(oid));
 		object = parse_object_buffer(the_repository, oid, type,
 					     size, buf, &eaten);
 	}
@@ -330,17 +330,18 @@ static void print_path(const char *path)
 
 static void *generate_fake_oid(const void *old, size_t *len)
 {
-	static uint32_t counter = 1; /* avoid null sha1 */
-	unsigned char *out = xcalloc(GIT_SHA1_RAWSZ, 1);
-	put_be32(out + GIT_SHA1_RAWSZ - 4, counter++);
+	static uint32_t counter = 1; /* avoid null oid */
+	const unsigned hashsz = the_hash_algo->rawsz;
+	unsigned char *out = xcalloc(hashsz, 1);
+	put_be32(out + hashsz - 4, counter++);
 	return out;
 }
 
-static const unsigned char *anonymize_sha1(const struct object_id *oid)
+static const struct object_id *anonymize_oid(const struct object_id *oid)
 {
-	static struct hashmap sha1s;
-	size_t len = GIT_SHA1_RAWSZ;
-	return anonymize_mem(&sha1s, generate_fake_oid, oid, &len);
+	static struct hashmap objs;
+	size_t len = the_hash_algo->rawsz;
+	return anonymize_mem(&objs, generate_fake_oid, oid, &len);
 }
 
 static void show_filemodify(struct diff_queue_struct *q,
@@ -399,9 +400,9 @@ static void show_filemodify(struct diff_queue_struct *q,
 			 */
 			if (no_data || S_ISGITLINK(spec->mode))
 				printf("M %06o %s ", spec->mode,
-				       sha1_to_hex(anonymize ?
-						   anonymize_sha1(&spec->oid) :
-						   spec->oid.hash));
+				       oid_to_hex(anonymize ?
+						  anonymize_oid(&spec->oid) :
+						  &spec->oid));
 			else {
 				struct object *object = lookup_object(the_repository,
 								      spec->oid.hash);
@@ -988,7 +989,7 @@ static void handle_deletes(void)
 			continue;
 
 		printf("reset %s\nfrom %s\n\n",
-				refspec->dst, sha1_to_hex(null_sha1));
+				refspec->dst, oid_to_hex(&null_oid));
 	}
 }
 
-- 
2.19.1.1063.g1796373474.dirty

