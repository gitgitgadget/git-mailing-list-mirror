Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BCC920248
	for <e@80x24.org>; Fri,  5 Apr 2019 15:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbfDEPBC (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 11:01:02 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:45634 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728743AbfDEPA7 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Apr 2019 11:00:59 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35EwPFK001918;
        Fri, 5 Apr 2019 08:00:41 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2rmg26mf48-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 05 Apr 2019 08:00:41 -0700
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 5 Apr 2019 08:00:42 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 5 Apr 2019 08:00:42 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 3B666220CB27;
        Fri,  5 Apr 2019 08:00:39 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 04/15] merge-recursive: rename locals 'o' and 'a' to 'obuf' and 'abuf'
Date:   Fri, 5 Apr 2019 08:00:15 -0700
Message-ID: <20190405150026.5260-5-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.211.g719c25afaf.dirty
In-Reply-To: <20190405150026.5260-1-newren@gmail.com>
References: <20190330003336.21940-1-newren@gmail.com>
 <20190405150026.5260-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904050102
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we want to replace oid,mode pairs with a single diff_filespec,
we will soon want to be able to use the names 'o', 'a', and 'b' for
the three different file versions.  Rename some local variables in
blob_unchanged() that would otherwise conflict.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 36af5d9cc6..4ed1b48630 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3031,9 +3031,10 @@ static int blob_unchanged(struct merge_options *opt,
 			  unsigned a_mode,
 			  int renormalize, const char *path)
 {
-	struct strbuf o = STRBUF_INIT;
-	struct strbuf a = STRBUF_INIT;
+	struct strbuf obuf = STRBUF_INIT;
+	struct strbuf abuf = STRBUF_INIT;
 	int ret = 0; /* assume changed for safety */
+	const struct index_state *idx = opt->repo->index;
 
 	if (a_mode != o_mode)
 		return 0;
@@ -3043,20 +3044,21 @@ static int blob_unchanged(struct merge_options *opt,
 		return 0;
 
 	assert(o_oid && a_oid);
-	if (read_oid_strbuf(opt, o_oid, &o) || read_oid_strbuf(opt, a_oid, &a))
+	if (read_oid_strbuf(opt, o_oid, &obuf) ||
+	    read_oid_strbuf(opt, a_oid, &abuf))
 		goto error_return;
 	/*
 	 * Note: binary | is used so that both renormalizations are
 	 * performed.  Comparison can be skipped if both files are
 	 * unchanged since their sha1s have already been compared.
 	 */
-	if (renormalize_buffer(opt->repo->index, path, o.buf, o.len, &o) |
-	    renormalize_buffer(opt->repo->index, path, a.buf, a.len, &a))
-		ret = (o.len == a.len && !memcmp(o.buf, a.buf, o.len));
+	if (renormalize_buffer(idx, path, obuf.buf, obuf.len, &obuf) |
+	    renormalize_buffer(idx, path, abuf.buf, abuf.len, &abuf))
+		ret = (obuf.len == abuf.len && !memcmp(obuf.buf, abuf.buf, obuf.len));
 
 error_return:
-	strbuf_release(&o);
-	strbuf_release(&a);
+	strbuf_release(&obuf);
+	strbuf_release(&abuf);
 	return ret;
 }
 
-- 
2.21.0.211.g719c25afaf.dirty

