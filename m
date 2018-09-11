Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 976321F404
	for <e@80x24.org>; Tue, 11 Sep 2018 18:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeIKX4a (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 19:56:30 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:57296 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726645AbeIKX4a (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Sep 2018 19:56:30 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8BIrCNK004485;
        Tue, 11 Sep 2018 11:55:49 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2mcbajn2k3-1;
        Tue, 11 Sep 2018 11:55:49 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 56777226E7F2;
        Tue, 11 Sep 2018 11:55:49 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 44FF72CDE80;
        Tue, 11 Sep 2018 11:55:49 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 2/2] rerere: avoid buffer overrun
Date:   Tue, 11 Sep 2018 11:55:46 -0700
Message-Id: <20180911185546.10449-3-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.2.gdbd064c81f
In-Reply-To: <20180911185546.10449-1-newren@gmail.com>
References: <20180905175605.12341-1-newren@gmail.com>
 <20180911185546.10449-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=694 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809110187
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

check_one_conflict() compares `i` to `active_nr` in two places to avoid
buffer overruns, but left out an important third location.

The code did used to have a check here comparing i to active_nr, back
before commit fb70a06da2f1 ("rerere: fix an off-by-one non-bug",
2015-06-28), however the code at the time used an 'if' rather than a
'while' meaning back then that this loop could not have read past the
end of the array, making the check unnecessary and it was removed.
Unfortunately, in commit 5eda906b2873 ("rerere: handle conflicts with
multiple stage #1 entries", 2015-07-24), the 'if' was changed to a
'while' and the check comparing i and active_nr was not re-instated,
leading to this problem.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 rerere.c          | 2 +-
 t/t4200-rerere.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index f9294b7677..313222d0d6 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -596,7 +596,7 @@ test_expect_success 'setup simple stage 1 handling' '
 	)
 '
=20
-test_expect_failure 'test simple stage 1 handling' '
+test_expect_success 'test simple stage 1 handling' '
 	(
 		cd stage_1_handling &&
=20
--=20
2.19.0.2.gdbd064c81f

