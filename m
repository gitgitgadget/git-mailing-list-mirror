Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 171ED1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 23:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753256AbeBIXPn (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 18:15:43 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:47748 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753233AbeBIXPl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Feb 2018 18:15:41 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w19NDc4E002217;
        Fri, 9 Feb 2018 15:13:38 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2fwbtpshbh-1;
        Fri, 09 Feb 2018 15:13:38 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id C55572244D04;
        Fri,  9 Feb 2018 15:13:30 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id BC5E92CDEED;
        Fri,  9 Feb 2018 15:13:30 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 2/3] t1450-fsck: Add tests for HEAD of other worktrees
Date:   Fri,  9 Feb 2018 15:13:29 -0800
Message-Id: <20180209231330.4457-3-newren@gmail.com>
X-Mailer: git-send-email 2.16.1.75.gc01c8fdd7d
In-Reply-To: <20180209231330.4457-1-newren@gmail.com>
References: <20180209231330.4457-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-09_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=958 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1802090293
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1450-fsck.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index cb4b66e29d..fa94c59458 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -102,6 +102,33 @@ test_expect_success 'HEAD link pointing at a funny p=
lace' '
 	grep "HEAD points to something strange" out
 '
=20
+test_expect_failure 'other worktree HEAD link pointing at a funny object=
' '
+	test_when_finished "rm -rf .git/worktrees" &&
+	mkdir -p .git/worktrees/other &&
+	echo 0000000000000000000000000000000000000000 >.git/worktrees/other/HEA=
D &&
+	test_must_fail git fsck 2>out &&
+	cat out &&
+	grep "worktrees/other/HEAD: detached HEAD points" out
+'
+
+test_expect_failure 'other worktree HEAD link pointing at missing object=
' '
+	test_when_finished "rm -rf .git/worktrees" &&
+	mkdir -p .git/worktrees/other &&
+	echo "Contents missing from repo" | git hash-object --stdin >.git/workt=
rees/other/HEAD &&
+	test_must_fail git fsck 2>out &&
+	cat out &&
+	grep "worktrees/other/HEAD: invalid sha1 pointer" out
+'
+
+test_expect_failure 'other worktree HEAD link pointing at a funny place'=
 '
+	test_when_finished "rm -rf .git/worktrees" &&
+	mkdir -p .git/worktrees/other &&
+	echo "ref: refs/funny/place" >.git/worktrees/other/HEAD &&
+	test_must_fail git fsck 2>out &&
+	cat out &&
+	grep "worktrees/other/HEAD points to something strange" out
+'
+
 test_expect_success 'email without @ is okay' '
 	git cat-file commit HEAD >basis &&
 	sed "s/@/AT/" basis >okay &&
--=20
2.16.1.75.gc01c8fdd7d

