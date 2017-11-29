Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F5AB20954
	for <e@80x24.org>; Wed, 29 Nov 2017 01:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753150AbdK2Bn2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 20:43:28 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:58542 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752999AbdK2BnS (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2017 20:43:18 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAT1bt9i003275;
        Tue, 28 Nov 2017 17:42:38 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ef69q4mx3-2;
        Tue, 28 Nov 2017 17:42:38 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id B3FCF22157CA;
        Tue, 28 Nov 2017 17:42:38 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id AB33D2CDF17;
        Tue, 28 Nov 2017 17:42:38 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 17/34] merge-recursive: fix leaks of allocated renames and diff_filepairs
Date:   Tue, 28 Nov 2017 17:42:20 -0800
Message-Id: <20171129014237.32570-18-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g850bc54b15
In-Reply-To: <20171129014237.32570-1-newren@gmail.com>
References: <20171129014237.32570-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-28_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711290020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get_renames() has always zero'ed out diff_queued_diff.nr while only
manually free'ing diff_filepairs that did not correspond to renames.
Further, it allocated struct renames that were tucked away in the
return string_list.  Make sure all of these are deallocated when we
are done with them.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index e95eac2c70..cdd0afa047 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1653,13 +1653,23 @@ static int handle_renames(struct merge_options *o=
,
 	return process_renames(o, ri->head_renames, ri->merge_renames);
 }
=20
-static void cleanup_renames(struct rename_info *re_info)
+static void cleanup_rename(struct string_list *rename)
 {
-	string_list_clear(re_info->head_renames, 0);
-	string_list_clear(re_info->merge_renames, 0);
+	const struct rename *re;
+	int i;
=20
-	free(re_info->head_renames);
-	free(re_info->merge_renames);
+	for (i =3D 0; i < rename->nr; i++) {
+		re =3D rename->items[i].util;
+		diff_free_filepair(re->pair);
+	}
+	string_list_clear(rename, 1);
+	free(rename);
+}
+
+static void cleanup_renames(struct rename_info *re_info)
+{
+	cleanup_rename(re_info->head_renames);
+	cleanup_rename(re_info->merge_renames);
 }
=20
 static struct object_id *stage_oid(const struct object_id *oid, unsigned=
 mode)
--=20
2.15.0.408.g850bc54b15

