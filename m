Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6714920954
	for <e@80x24.org>; Wed, 29 Nov 2017 01:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbdK2Bnc (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 20:43:32 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:55382 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752959AbdK2Bn3 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2017 20:43:29 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAT1dPG7005251;
        Tue, 28 Nov 2017 17:42:39 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ef78pmm11-2;
        Tue, 28 Nov 2017 17:42:38 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id BDD7022157C4;
        Tue, 28 Nov 2017 17:42:38 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id B4CB42CDE74;
        Tue, 28 Nov 2017 17:42:38 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 18/34] merge-recursive: make !o->detect_rename codepath more obvious
Date:   Tue, 28 Nov 2017 17:42:21 -0800
Message-Id: <20171129014237.32570-19-newren@gmail.com>
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
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711290020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, if !o->detect_rename then get_renames() would return an
empty string_list, and then process_renames() would have nothing to
iterate over.  It seems more straightforward to simply avoid calling
either function in that case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index cdd0afa047..da7c67eb82 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1329,8 +1329,6 @@ static struct string_list *get_renames(struct merge=
_options *o,
 	struct diff_options opts;
=20
 	renames =3D xcalloc(1, sizeof(struct string_list));
-	if (!o->detect_rename)
-		return renames;
=20
 	diff_setup(&opts);
 	opts.flags.recursive =3D 1;
@@ -1648,6 +1646,12 @@ static int handle_renames(struct merge_options *o,
 			  struct string_list *entries,
 			  struct rename_info *ri)
 {
+	ri->head_renames =3D NULL;
+	ri->merge_renames =3D NULL;
+
+	if (!o->detect_rename)
+		return 1;
+
 	ri->head_renames  =3D get_renames(o, head, common, head, merge, entries=
);
 	ri->merge_renames =3D get_renames(o, merge, common, head, merge, entrie=
s);
 	return process_renames(o, ri->head_renames, ri->merge_renames);
@@ -1658,6 +1662,9 @@ static void cleanup_rename(struct string_list *rena=
me)
 	const struct rename *re;
 	int i;
=20
+	if (rename =3D=3D NULL)
+		return;
+
 	for (i =3D 0; i < rename->nr; i++) {
 		re =3D rename->items[i].util;
 		diff_free_filepair(re->pair);
--=20
2.15.0.408.g850bc54b15

