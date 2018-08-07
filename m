Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4A70208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 16:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389119AbeHGTE1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 15:04:27 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:37070 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389012AbeHGTE1 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Aug 2018 15:04:27 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w77GmpJq014485;
        Tue, 7 Aug 2018 09:49:07 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kna0jdagm-1;
        Tue, 07 Aug 2018 09:49:07 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 5485522FCFB9;
        Tue,  7 Aug 2018 09:49:07 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 49A602CDEF0;
        Tue,  7 Aug 2018 09:49:07 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com, martin.agren@gmail.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 3/5] t7406: prefer test_* helper functions to test -[feds]
Date:   Tue,  7 Aug 2018 09:49:03 -0700
Message-Id: <20180807164905.3859-4-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.550.geb414df874.dirty
In-Reply-To: <20180807164905.3859-1-newren@gmail.com>
References: <20180806152524.27516-1-newren@gmail.com>
 <20180807164905.3859-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=4 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=4
 clxscore=1034 lowpriorityscore=0 mlxscore=4 impostorscore=0
 mlxlogscore=143 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808070167
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test -e, test -s, etc. do not provide nice error messages when we hit
test failures, so use the test_* helper functions from
test-lib-functions.sh.

Note: The use of 'test_path_is_file submodule/.git' may look odd, but
it is a file which is populated with a
   gitdir: ../.git/modules/submodule
directive.  If, in the future, handling of the submodule is changed and
submodule/.git becomes a directory we can change this to
test_path_is_dir (or perhaps write a test_path_exists helper function
that doesn't care whether the path is a file or a directory).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7406-submodule-update.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index c6b7b59350..ab67e373c5 100755
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
@@ -619,8 +619,8 @@ test_expect_success 'submodule update --init skips su=
bmodule with update=3Dnone' '
 	git clone super cloned &&
 	(cd cloned &&
 	 git submodule update --init &&
-	 test -e submodule/.git &&
-	 test_must_fail test -e none/.git
+	 test_path_is_file submodule/.git &&
+	 test_path_is_missing none/.git
 	)
 '
=20
--=20
2.18.0.550.geb414df874.dirty

