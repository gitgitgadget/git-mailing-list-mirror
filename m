Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5572A20954
	for <e@80x24.org>; Wed, 29 Nov 2017 01:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753406AbdK2Bon (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 20:44:43 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:58706 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752497AbdK2Bom (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2017 20:44:42 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAT1bup2003278;
        Tue, 28 Nov 2017 17:42:38 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ef69q4mx0-1;
        Tue, 28 Nov 2017 17:42:37 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id E456422157C9;
        Tue, 28 Nov 2017 17:42:37 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id D00FF2CDF17;
        Tue, 28 Nov 2017 17:42:37 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 01/34] Tighten and correct a few testcases for merging and cherry-picking
Date:   Tue, 28 Nov 2017 17:42:04 -0800
Message-Id: <20171129014237.32570-2-newren@gmail.com>
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
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711290020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t3501 had a testcase originally added in 05f2dfb965 (cherry-pick:
demonstrate a segmentation fault, 2016-11-26) to ensure cherry-pick
wouldn't segfault when working with a dirty file involved in a rename.
While the segfault was fixed, there was another problem this test
demonstrated: namely, that git would overwrite a dirty file involved in a
rename.  Further, the test encoded a "successful merge" and overwriting o=
f
this file as correct behavior.  Modify the test so that it would still
catch the segfault, but to require the correct behavior.  Mark it as
test_expect_failure for now too, since this second bug is not yet fixed.

t7607 had a test added in 30fd3a5425 (merge overwrites unstaged changes i=
n
renamed file, 2012-04-15) specific to looking for a merge overwriting a
dirty file involved in a rename, but it too actually encoded what I would
term incorrect behavior: it expected the merge to succeed.  Fix that, and
add a few more checks to make sure that the merge really does produce the
expected results.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3501-revert-cherry-pick.sh | 7 +++++--
 t/t7607-merge-overwrite.sh    | 5 ++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.s=
h
index 4f2a263b63..783bdbf59d 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -141,7 +141,7 @@ test_expect_success 'cherry-pick "-" works with argum=
ents' '
 	test_cmp expect actual
 '
=20
-test_expect_success 'cherry-pick works with dirty renamed file' '
+test_expect_failure 'cherry-pick works with dirty renamed file' '
 	test_commit to-rename &&
 	git checkout -b unrelated &&
 	test_commit unrelated &&
@@ -150,7 +150,10 @@ test_expect_success 'cherry-pick works with dirty re=
named file' '
 	test_tick &&
 	git commit -m renamed &&
 	echo modified >renamed &&
-	git cherry-pick refs/heads/unrelated
+	test_must_fail git cherry-pick refs/heads/unrelated >out &&
+	test_i18ngrep "Refusing to lose dirty file at renamed" out &&
+	test $(git rev-parse :0:renamed) =3D $(git rev-parse HEAD^:to-rename.t)=
 &&
+	grep -q "^modified$" renamed
 '
=20
 test_done
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index 9444d6a9b9..00617dadf8 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -97,7 +97,10 @@ test_expect_failure 'will not overwrite unstaged chang=
es in renamed file' '
 	git mv c1.c other.c &&
 	git commit -m rename &&
 	cp important other.c &&
-	git merge c1a &&
+	test_must_fail git merge c1a >out &&
+	test_i18ngrep "Refusing to lose dirty file at other.c" out &&
+	test -f other.c~HEAD &&
+	test $(git hash-object other.c~HEAD) =3D $(git rev-parse c1a:c1.c) &&
 	test_cmp important other.c
 '
=20
--=20
2.15.0.408.g850bc54b15

