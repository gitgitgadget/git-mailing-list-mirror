Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB7A11F424
	for <e@80x24.org>; Fri, 13 Apr 2018 08:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeDMIIB (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 04:08:01 -0400
Received: from ao2.it ([92.243.12.208]:53706 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752955AbeDMIHw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 04:07:52 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1f6tjL-0007hx-QP; Fri, 13 Apr 2018 10:06:47 +0200
Received: from ao2 by jcn with local (Exim 4.90_1)
        (envelope-from <ao2@ao2.it>)
        id 1f6tkM-0001fj-Ab; Fri, 13 Apr 2018 10:07:50 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Richard Hartmann <richih.mailinglist@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [RFC 08/10] FIXME: submodule: fix t1300-repo-config.sh to take into account the new config
Date:   Fri, 13 Apr 2018 10:07:31 +0200
Message-Id: <20180413080733.6380-2-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180413080733.6380-1-ao2@ao2.it>
References: <20180412222047.5716-1-ao2@ao2.it>
 <20180413080733.6380-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests are run with the 'core.submodulesfile' config set, so
't/t1300-repo-config.sh' needs to be fixed to account for that.

The changes to the HEREDOC lines are temporary and only needed to
support the environmental variable expansion, they could go away
eventually is using a fixed value is good enough.
---
 t/t1300-repo-config.sh | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index e95b1e67d..f672a6c37 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -338,6 +338,7 @@ beta.noindent=sillyValue
 nextsection.nonewline=wow2 for me
 123456.a123=987
 version.1.2.3eX.alpha=beta
+core.submodulesfile=${GITMODULES_FILE:-.gitmodules}
 EOF
 
 test_expect_success 'working --list' '
@@ -345,6 +346,7 @@ test_expect_success 'working --list' '
 	test_cmp expect output
 '
 cat > expect << EOF
+core.submodulesfile=${GITMODULES_FILE:-.gitmodules}
 EOF
 
 test_expect_success '--list without repo produces empty output' '
@@ -357,6 +359,7 @@ beta.noindent
 nextsection.nonewline
 123456.a123
 version.1.2.3eX.alpha
+core.submodulesfile
 EOF
 
 test_expect_success '--name-only --list' '
@@ -964,10 +967,11 @@ inued
 inued"
 EOF
 
-cat > expect <<\EOF
+cat > expect << EOF
 section.continued=continued
 section.noncont=not continued
 section.quotecont=cont;inued
+core.submodulesfile=${GITMODULES_FILE:-.gitmodules}
 EOF
 
 test_expect_success 'value continued on next line' '
@@ -984,7 +988,7 @@ cat > .git/config <<\EOF
 	val5
 EOF
 
-cat > expect <<\EOF
+cat > expect << EOF
 section.sub=section.val1
 foo=barQsection.sub=section.val2
 foo
@@ -992,7 +996,8 @@ barQsection.sub=section.val3
 
 
 Qsection.sub=section.val4
-Qsection.sub=section.val5Q
+Qsection.sub=section.val5Qcore.submodulesfile
+${GITMODULES_FILE:-.gitmodules}Q
 EOF
 test_expect_success '--null --list' '
 	git config --null --list >result.raw &&
@@ -1001,6 +1006,17 @@ test_expect_success '--null --list' '
 	test_cmp expect result
 '
 
+cat > expect << EOF
+section.sub=section.val1
+foo=barQsection.sub=section.val2
+foo
+barQsection.sub=section.val3
+
+
+Qsection.sub=section.val4
+Qsection.sub=section.val5Q
+EOF
+
 test_expect_success '--null --get-regexp' '
 	git config --null --get-regexp "val[0-9]" >result.raw &&
 	nul_to_q <result.raw >result &&
@@ -1495,6 +1511,7 @@ test_expect_success '--show-origin with --list' '
 		file:.git/config	user.override=local
 		file:.git/config	include.path=../include/relative.include
 		file:.git/../include/relative.include	user.relative=include
+		command line:	core.submodulesfile=${GITMODULES_FILE:-.gitmodules}
 		command line:	user.cmdline=true
 	EOF
 	git -c user.cmdline=true config --list --show-origin >output &&
@@ -1511,7 +1528,8 @@ test_expect_success '--show-origin with --list --null' '
 		trueQfile:.git/configQuser.override
 		localQfile:.git/configQinclude.path
 		../include/relative.includeQfile:.git/../include/relative.includeQuser.relative
-		includeQcommand line:Quser.cmdline
+		includeQcommand line:Qcore.submodulesfile
+		${GITMODULES_FILE:-.gitmodules}Qcommand line:Quser.cmdline
 		trueQ
 	EOF
 	git -c user.cmdline=true config --null --list --show-origin >output.raw &&
-- 
2.17.0

