Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 850FC208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 22:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbeHGA7H (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 20:59:07 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:44016 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732824AbeHGA7E (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Aug 2018 20:59:04 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76MggkE031788;
        Mon, 6 Aug 2018 15:47:48 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kn91kc2e2-1;
        Mon, 06 Aug 2018 15:47:47 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id B32FB228A031;
        Mon,  6 Aug 2018 15:47:47 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id AB13B2CDEA7;
        Mon,  6 Aug 2018 15:47:47 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [RFC/WIP PATCH 1/3] rerere: avoid buffer overrun
Date:   Mon,  6 Aug 2018 15:47:43 -0700
Message-Id: <20180806224745.8681-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.550.g44d6daf40a.dirty
In-Reply-To: <20180806224745.8681-1-newren@gmail.com>
References: <CABPp-BHxJyWsAQ3FkfdC-5Vqe3d7wWZm-hVYd0-afNY9dEgMeQ@mail.gmail.com>
 <20180806224745.8681-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=820 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060237
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

check_one_conflict() compares `i` to `active_nr` in two places to avoid
buffer overruns, but left out an important third location.  This has
not previously been a problem, because existing merge strategies have
tended to not create entries at stage #1 that do not have a
corresponding entry at either stage #2 or stage #3.  However, this is
not guaranteed, so add a check to avoid segfaults.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 rerere.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rerere.c b/rerere.c
index 16c8aac621..7d22fb08c7 100644
--- a/rerere.c
+++ b/rerere.c
@@ -533,7 +533,7 @@ static int check_one_conflict(int i, int *type)
 	}
=20
 	*type =3D PUNTED;
-	while (ce_stage(active_cache[i]) =3D=3D 1)
+	while (i < active_nr && ce_stage(active_cache[i]) =3D=3D 1)
 		i++;
=20
 	/* Only handle regular files with both stages #2 and #3 */
--=20
2.18.0.550.g44d6daf40a.dirty
