Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 016561F859
	for <e@80x24.org>; Fri, 12 Aug 2016 16:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbcHLQlw (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 12:41:52 -0400
Received: from mout.web.de ([212.227.15.4]:55082 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591AbcHLQlt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 12:41:49 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0LsyOA-1b5xFN1QAU-012ZGp; Fri, 12 Aug 2016 18:41:43
 +0200
From:	tboegi@web.de
To:	git@vger.kernel.org
Cc:	peff@peff.net, Johannes.Schindelin@gmx.de,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 1/2] t0027: Correct raciness in NNO test
Date:	Fri, 12 Aug 2016 18:51:02 +0200
Message-Id: <1471020662-20746-1-git-send-email-tboegi@web.de>
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
MIME-Version: 1.0
In-Reply-To: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:PLbsFgpUh66pWLABCBnCdsIFjmDrOr1Q3dGQ5e/G+Oat0rRemw9
 aYpDnqUGnj6rXN/Rz6s5WS9fLvSsYYsUtJYNwZLIdJCc9sRNybQC7oAxSKZIH0I+PazbJSv
 Zi7CfFxV1sgWOuqCGXAak8EwLNf9QV+wlqdOv0BzGbEH09cC7Ew5pgKs/9A5biwS3g7ksHe
 4jsitZmYXJ81pIPkri6xw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:icxKHn5chJM=:8uV7AfttprLHoW87UexSEn
 RQP+eqCSq2JEjLXYDPZ5ENnt9ikXp6TQ8TBYNYNmRZL5d5JxCzuoLillPXgMBWp7xMkuBrA6d
 5+kFU/KAM9/s13T81m0txnzJRFvxIGa0QTNKBM7gc1f1KYoAhjrVwL1fvVIN8nTsLBqpqdHVf
 eo3b3mNh1wcxMF7VSxa64D3AiXh1k4KvPgQK+smzWd1aczQf1MfvBsUQy5Qw8i1cFefUOOgnF
 3KP3hj4jW+wzF1flNjMAuOPe+sxIigrudstv+dDVhDfT0puK0dK2VfIIr0vJMd1T3xWd4SHyi
 35FeDb9QR5cykVfltoZxFtzQzEuXotkUAw86lM4y0OwsSaAW36dBGw3uz3lWcyocmmKP3d9HO
 jJ9qzGDyRtbNYTYNNggW/08ZkL1okxBUmYE+3QjbIAdThFXgiTH+aUiUjs5kb5RvjBI13PW+y
 IzOubOK2y5Tx5xq04oOEuLc35VboCbAzrkGmrABmgbaEFIn2aEqUfzT+GkNJQN75TAjj6XU81
 F/6MMTqeWmc6CuN95uSt8AiuYhx6ygTSy3Po1Nw72gpE2UxUINmTcRiLwwKHLmjw4tC4MJo5s
 wwzqe7hvdtekKs+IbVFbpZ9HCP8TcaD23//UuufrgT1Ohqp/CEjMtN567BjWj/ChWRkGyjEsg
 ODB//Nv6WXeZEaj4TcbSN+GNtT9RadrghOByE12cPzMfbG2BamAByHG3GaqVBkwq+eOQ+R6pk
 V095c2Cx3q+dqd22HRHRECwQmx8O6dxjC1Po9s53iAhXgMUitW+HOg32C3lZzZqvseFSKvWHX
 grCJZat
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

When a non-reversible CRLF conversion is done in "git add",
a warning is printed on stderr (or Git dies, depending on checksafe)

The function commit_chk_wrnNNO() in t0027 was written to test this,
but did the wrong thing: Instead of looking at the warning
from "git add", it looked at the warning from "git commit".

This is racy because "git commit" may not have to do CRLF conversion
at all if it can use the sha1 value from the index (which depends on
whether "add" and "commit" run in a single second).

Correct this and replace the commit for each and every file with a commit
of all files in one go.

The function commit_chk_wrnNNO() will to be renamed in a separate commit.
Thanks to Jeff King <peff@peff.net> for analyzing t0027.

Reported-By: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 t/t0027-auto-crlf.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 2860d2d..ab6e962 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -119,8 +119,7 @@ commit_chk_wrnNNO () {
 		fname=${pfx}_$f.txt &&
 		cp $f $fname &&
 		printf Z >>"$fname" &&
-		git -c core.autocrlf=$crlf add $fname 2>/dev/null &&
-		git -c core.autocrlf=$crlf commit -m "commit_$fname" $fname >"${pfx}_$f.err" 2>&1
+		git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err"
 	done
 
 	test_expect_success "commit NNO files crlf=$crlf attr=$attr LF" '
@@ -394,11 +393,11 @@ test_expect_success 'commit files attr=crlf' '
 
 #                 attr                    LF        CRLF      CRLFmixLF   LF_mix_CR   CRLFNUL
 commit_chk_wrnNNO ""      ""      false   ""        ""        ""          ""          ""
-commit_chk_wrnNNO ""      ""      true    LF_CRLF   ""        ""          ""          ""
+commit_chk_wrnNNO ""      ""      true    ""        ""        ""          ""          ""
 commit_chk_wrnNNO ""      ""      input   ""        ""        ""          ""          ""
 
-commit_chk_wrnNNO "auto"  ""      false   "$WILC"   ""        ""          ""          ""
-commit_chk_wrnNNO "auto"  ""      true    LF_CRLF   ""        ""          ""          ""
+commit_chk_wrnNNO "auto"  ""      false   ""        ""        ""          ""          ""
+commit_chk_wrnNNO "auto"  ""      true    ""        ""        ""          ""          ""
 commit_chk_wrnNNO "auto"  ""      input   ""        ""        ""          ""          ""
 for crlf in true false input
 do
@@ -408,7 +407,7 @@ do
 	commit_chk_wrnNNO ""    lf      $crlf   ""       CRLF_LF    CRLF_LF      ""         CRLF_LF
 	commit_chk_wrnNNO ""    crlf    $crlf   LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
 	commit_chk_wrnNNO auto  lf    	$crlf   ""        ""        ""          ""          ""
-	commit_chk_wrnNNO auto  crlf  	$crlf   LF_CRLF   ""        ""          ""          ""
+	commit_chk_wrnNNO auto  crlf  	$crlf   ""        ""        ""          ""          ""
 	commit_chk_wrnNNO text  lf    	$crlf   ""       CRLF_LF    CRLF_LF     ""          CRLF_LF
 	commit_chk_wrnNNO text  crlf  	$crlf   LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
 done
@@ -417,7 +416,8 @@ commit_chk_wrnNNO "text"  ""      false   "$WILC"   "$WICL"   "$WAMIX"    "$WILC
 commit_chk_wrnNNO "text"  ""      true    LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
 commit_chk_wrnNNO "text"  ""      input   ""        CRLF_LF   CRLF_LF     ""          CRLF_LF
 
-test_expect_success 'create files cleanup' '
+test_expect_success 'commit NNO and cleanup' '
+	git commit -m "commit files on top of NNO" &&
 	rm -f *.txt &&
 	git -c core.autocrlf=false reset --hard
 '
-- 
2.0.0.rc1.6318.g0c2c796

