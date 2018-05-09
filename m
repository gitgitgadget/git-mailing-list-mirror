Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5293E1F424
	for <e@80x24.org>; Wed,  9 May 2018 13:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934606AbeEIN3P (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 09:29:15 -0400
Received: from ao2.it ([92.243.12.208]:37172 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932875AbeEIN3O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 09:29:14 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fGP9Y-0005CP-S9; Wed, 09 May 2018 15:29:08 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fGP9c-0005iX-9n; Wed, 09 May 2018 15:29:12 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH] wrap-for-bin.sh: facilitate running Git executables under valgrind
Date:   Wed,  9 May 2018 15:28:58 +0200
Message-Id: <20180509132858.21936-1-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Testing locally built git executables under valgrind is not immediate.

Something like the following does not work:

  $ valgrind ./bin-wrappers/git

because the wrapper script forks and execs the command and valgrind does
not track children processes by default.

Something like the following may work:

  $ valgrind --trace-children=yes ./bin-wrappers/git

However it's counterintuitive and not ideal anyways because valgrind is
supposed to be called on the actual executable, not on wrapper scripts.

So, following the idea from commit 6a94088cc ("test: facilitate
debugging Git executables in tests with gdb", 2015-10-30) provide
a mechanism in the wrapper script to call valgrind directly on the
actual executable.

This mechanism could even be used by the test infrastructure in the
future, but it is already useful by its own on the command line:

  $ GIT_TEST_VALGRIND=1 \
    GIT_VALGRIND_OPTIONS="--leak-check=full" \
    ./bin-wrappers/git

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 wrap-for-bin.sh | 4 ++++
 1 file changed, 4 insertions(+)
 mode change 100644 => 100755 wrap-for-bin.sh

diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
old mode 100644
new mode 100755
index 584240881..502d567bd
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -24,6 +24,10 @@ if test -n "$GIT_TEST_GDB"
 then
 	unset GIT_TEST_GDB
 	exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
+elif test -n "$GIT_TEST_VALGRIND"
+then
+	unset GIT_TEST_VALGRIND
+	exec valgrind $GIT_VALGRIND_OPTIONS "${GIT_EXEC_PATH}/@@PROG@@" "$@"
 else
 	exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
 fi
-- 
2.17.0

