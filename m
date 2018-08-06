Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05E49208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 15:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732859AbeHFRfS (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 13:35:18 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:59892 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728626AbeHFRfR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Aug 2018 13:35:17 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76FKJDx006412;
        Mon, 6 Aug 2018 08:25:26 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kn91kbc05-1;
        Mon, 06 Aug 2018 08:25:26 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id EA1932243D15;
        Mon,  6 Aug 2018 08:25:25 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id E45FF2CDE73;
        Mon,  6 Aug 2018 08:25:25 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/3] t7406: avoid having git commands upstream of a pipe
Date:   Mon,  6 Aug 2018 08:25:23 -0700
Message-Id: <20180806152524.27516-3-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.550.g7224c72da7
In-Reply-To: <20180806152524.27516-1-newren@gmail.com>
References: <20180803231407.10662-1-newren@gmail.com>
 <20180806152524.27516-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=43 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=971 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060162
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a git command is on the left side of a pipe, the pipe will swallow
its exit status, preventing us from detecting failures in said commands.
Restructure the tests to put the output in a temporary file to avoid
this problem.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7406-submodule-update.sh | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index e2405c96b5..c8971abd07 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -481,7 +481,8 @@ test_expect_success 'recursive submodule update - com=
mand in .git/config catches
=20
 test_expect_success 'submodule init does not copy command into .git/conf=
ig' '
 	(cd super &&
-	 H=3D$(git ls-files -s submodule | cut -d" " -f2) &&
+	 git ls-files -s submodule >out &&
+	 H=3D$(cut -d" " -f2 out) &&
 	 mkdir submodule1 &&
 	 git update-index --add --cacheinfo 160000 $H submodule1 &&
 	 git config -f .gitmodules submodule.submodule1.path submodule1 &&
@@ -579,9 +580,11 @@ test_expect_success 'submodule update - update=3Dnon=
e in .git/config' '
 	  git checkout master &&
 	  compare_head
 	 ) &&
-	 git diff --name-only | grep submodule &&
+	 git diff --name-only >out &&
+	 grep submodule out &&
 	 git submodule update &&
-	 git diff --name-only | grep submodule &&
+	 git diff --name-only >out &&
+	 grep submodule out &&
 	 (cd submodule &&
 	  compare_head
 	 ) &&
@@ -597,7 +600,8 @@ test_expect_success 'submodule update - update=3Dnone=
 in .git/config but --checkou
 	  git checkout master &&
 	  compare_head
 	 ) &&
-	 git diff --name-only | grep submodule &&
+	 git diff --name-only >out &&
+	 grep submodule out &&
 	 git submodule update --checkout &&
 	 test_must_fail git diff --name-only \| grep submodule &&
 	 (cd submodule &&
@@ -885,7 +889,8 @@ test_expect_success 'submodule update properly revive=
s a moved submodule' '
 	 H=3D$(git rev-parse --short HEAD) &&
 	 git commit -am "pre move" &&
 	 H2=3D$(git rev-parse --short HEAD) &&
-	 git status | sed "s/$H/XXX/" >expect &&
+	 git status >out &&
+	 sed "s/$H/XXX/" out >expect &&
 	 H=3D$(cd submodule2 && git rev-parse HEAD) &&
 	 git rm --cached submodule2 &&
 	 rm -rf submodule2 &&
@@ -894,7 +899,8 @@ test_expect_success 'submodule update properly revive=
s a moved submodule' '
 	 git config -f .gitmodules submodule.submodule2.path "moved/sub module"=
 &&
 	 git commit -am "post move" &&
 	 git submodule update &&
-	 git status | sed "s/$H2/XXX/" >actual &&
+	 git status > out &&
+	 sed "s/$H2/XXX/" out >actual &&
 	 test_cmp expect actual
 	)
 '
@@ -912,7 +918,7 @@ test_expect_success SYMLINKS 'submodule update can ha=
ndle symbolic links in pwd'
=20
 test_expect_success 'submodule update clone shallow submodule' '
 	test_when_finished "rm -rf super3" &&
-	first=3D$(git -C cloned submodule status submodule |cut -c2-41) &&
+	first=3D$(git -C cloned rev-parse HEAD:submodule) &&
 	second=3D$(git -C submodule rev-parse HEAD) &&
 	commit_count=3D$(git -C submodule rev-list --count $first^..$second) &&
 	git clone cloned super3 &&
@@ -922,7 +928,7 @@ test_expect_success 'submodule update clone shallow s=
ubmodule' '
 		sed -e "s#url =3D ../#url =3D file://$pwd/#" <.gitmodules >.gitmodules=
.tmp &&
 		mv -f .gitmodules.tmp .gitmodules &&
 		git submodule update --init --depth=3D$commit_count &&
-		test 1 =3D $(git -C submodule log --oneline | wc -l)
+		test 1 =3D $(git -C submodule rev-list --count HEAD)
 	)
 '
=20
@@ -938,7 +944,7 @@ test_expect_success 'submodule update clone shallow s=
ubmodule outside of depth'
 		test_i18ngrep "Direct fetching of that commit failed." actual &&
 		git -C ../submodule config uploadpack.allowReachableSHA1InWant true &&
 		git submodule update --init --depth=3D1 >actual &&
-		test 1 =3D $(git -C submodule log --oneline | wc -l)
+		test 1 =3D $(git -C submodule rev-list --count HEAD)
 	)
 '
=20
--=20
2.18.0.548.gd57a518419

