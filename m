Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC9A21F453
	for <e@80x24.org>; Tue, 16 Oct 2018 20:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbeJQEMJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 00:12:09 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:41548 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725960AbeJQEMJ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Oct 2018 00:12:09 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9GKIstb028399;
        Tue, 16 Oct 2018 13:20:01 -0700
Received: from mail.palantir.com (mxw2.palantir.com [66.70.54.22] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2n3ejh54j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 16 Oct 2018 13:20:01 -0700
Received: from sj-prod-exch-02.YOJOE.local (10.160.10.15) by
 sj-prod-exch-02.YOJOE.local (10.160.10.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 16 Oct 2018 13:19:59 -0700
Received: from EX02-WEST.YOJOE.local (10.160.10.131) by
 sj-prod-exch-02.YOJOE.local (10.160.10.15) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Tue, 16 Oct 2018 13:19:59 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 EX02-WEST.YOJOE.local (10.160.10.131) with Microsoft SMTP Server id
 14.3.319.2; Tue, 16 Oct 2018 13:19:59 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech
 [10.100.71.66])        by smtp-transport.yojoe.local (Postfix) with ESMTPS id
 9A05621F89E1;  Tue, 16 Oct 2018 13:19:59 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 1/2] merge-recursive: improve auto-merging messages with path collisions
Date:   Tue, 16 Oct 2018 13:19:47 -0700
Message-ID: <20181016201948.16025-2-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.280.g0c175526bf
In-Reply-To: <20181016201948.16025-1-newren@gmail.com>
References: <20181012212551.7689-1-newren@gmail.com>
 <20181016201948.16025-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=751 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810160169
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Each individual file involved in a rename could have also been modified
on both sides of history, meaning it may need to have content merges.
If two such files are renamed into the same location, then on top of the
two natural auto-merging messages we also have to two-way merge the
result, giving us messages that look like

  Auto-merging somefile.c (was somecase.c)
  Auto-merging somefile.c (was somefolder.c)
  Auto-merging somefile.c

However, despite the fact that I was the one who put the "(was %s)"
portions into the messages (and just a few months ago), I was still
initially confused when running into a rename/rename(2to1) case and
wondered if somefile.c had been merged three times.  Update this to
instead be:

  Auto-merging version of somefile.c from somecase.c
  Auto-merging version of somefile.c from someportfolio.c
  Auto-merging somefile.c

This is an admittedly long set of messages for a single path, but you
only get all three messages when dealing with the rare case of a
rename/rename(2to1) conflict where both sides of both original files
were also modified, in conflicting ways.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5206d6cfb6..8a47e54e2f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1674,8 +1674,8 @@ static int handle_rename_rename_2to1(struct merge_options *o,
 	remove_file(o, 1, a->path, o->call_depth || would_lose_untracked(a->path));
 	remove_file(o, 1, b->path, o->call_depth || would_lose_untracked(b->path));
 
-	path_side_1_desc = xstrfmt("%s (was %s)", path, a->path);
-	path_side_2_desc = xstrfmt("%s (was %s)", path, b->path);
+	path_side_1_desc = xstrfmt("version of %s from %s", path, a->path);
+	path_side_2_desc = xstrfmt("version of %s from %s", path, b->path);
 	if (merge_mode_and_contents(o, a, c1, &ci->ren1_other, path_side_1_desc,
 				    o->branch1, o->branch2, &mfi_c1) ||
 	    merge_mode_and_contents(o, b, &ci->ren2_other, c2, path_side_2_desc,
-- 
2.19.1.280.g0c175526bf

