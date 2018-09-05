Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F8FD1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 18:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeIEWtg (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 18:49:36 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:40584 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727069AbeIEWtf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Sep 2018 18:49:35 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85IDxfv029768;
        Wed, 5 Sep 2018 11:18:14 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2m7rmkfb8m-1;
        Wed, 05 Sep 2018 11:18:13 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 6E76122FCFA0;
        Wed,  5 Sep 2018 11:18:13 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 6623A2CDEA5;
        Wed,  5 Sep 2018 11:18:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH] rerere: avoid buffer overrun
Date:   Wed,  5 Sep 2018 10:56:05 -0700
Message-Id: <20180905175605.12341-1-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050182
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

check_one_conflict() compares `i` to `active_nr` in two places to avoid
buffer overruns, but left out an important third location.

Note that this bug probably cannot be triggered in the current codebase.
Existing merge strategies have tended not to create entries at stage #1
that do not have a corresponding entry at either stage #2 or stage #3.
(The bug was found while exploring some ideas for modifying conflict
resolution.)  However, it is technically possible that an external merge
strategy could create such entries, so add a check to avoid segfaults.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Originally submitted here:
  https://public-inbox.org/git/20180806224745.8681-2-newren@gmail.com/
While I want to push that RFC series more and will get back to it, this
patch is independently good so I'm submitting separately.

For some history about how the current code got to where it is today, see=
:
  fb70a06da2f1 ("rerere: fix an off-by-one non-bug", 2015-06-28)
  5eda906b2873 ("rerere: handle conflicts with multiple stage #1 entries"=
, 2015-07-24)

 rerere.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rerere.c b/rerere.c
index c7787aa07f..783d4dae2a 100644
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
2.19.0.rc2

