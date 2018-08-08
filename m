Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E93D9208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 16:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbeHHSvm (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 14:51:42 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:56656 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727952AbeHHSvl (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Aug 2018 14:51:41 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w78GN3nX012057;
        Wed, 8 Aug 2018 09:31:09 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kr3478389-1;
        Wed, 08 Aug 2018 09:31:09 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 65E632290350;
        Wed,  8 Aug 2018 09:31:09 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 5E0572CDE73;
        Wed,  8 Aug 2018 09:31:09 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        martin.agren@gmail.com, szeder.dev@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 4/5] t7406: prefer test_* helper functions to test -[feds]
Date:   Wed,  8 Aug 2018 09:31:06 -0700
Message-Id: <20180808163107.12329-5-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.556.g1604670984
In-Reply-To: <20180808163107.12329-1-newren@gmail.com>
References: <20180807164905.3859-1-newren@gmail.com>
 <20180808163107.12329-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=379 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080167
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test -e, test -s, etc. do not provide nice error messages when we hit
test failures, so use the test_* helper functions from
test-lib-functions.sh.

Also, add test_path_exists() to test-lib-function.sh while at it, so
that we don't need to worry whether submodule/.git is a file or a
directory.  It currently is a file with contents of the form
   gitdir: ../.git/modules/submodule
but it could be changed in the future to be a directory; this test
only really cares that it exists.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7406-submodule-update.sh | 6 +++---
 t/test-lib-functions.sh     | 8 ++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 2463863a51..24aa732312 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -174,7 +174,7 @@ test_expect_success 'submodule update does not fetch =
already present commits' '
 	  git submodule update > ../actual 2> ../actual.err
 	) &&
 	test_i18ncmp expected actual &&
-	! test -s actual.err
+	test_must_be_empty actual.err
 '
=20
 test_expect_success 'submodule update should fail due to local changes' =
'
@@ -620,8 +620,8 @@ test_expect_success 'submodule update --init skips su=
bmodule with update=3Dnone' '
 	git clone super cloned &&
 	(cd cloned &&
 	 git submodule update --init &&
-	 test -e submodule/.git &&
-	 test_must_fail test -e none/.git
+	 test_path_exists submodule/.git &&
+	 test_path_is_missing none/.git
 	)
 '
=20
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2b2181dca0..4207af4077 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -565,6 +565,14 @@ test_path_is_dir () {
 	fi
 }
=20
+test_path_exists () {
+	if ! test -e "$1"
+	then
+		echo "Path $1 doesn't exist. $2"
+		false
+	fi
+}
+
 # Check if the directory exists and is empty as expected, barf otherwise=
.
 test_dir_is_empty () {
 	test_path_is_dir "$1" &&
--=20
2.18.0.556.g1604670984

