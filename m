Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 309231F404
	for <e@80x24.org>; Mon, 17 Sep 2018 14:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbeIQThU (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 15:37:20 -0400
Received: from ao2.it ([92.243.12.208]:50106 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728728AbeIQThU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 15:37:20 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1g1uBX-0001bZ-L8; Mon, 17 Sep 2018 16:07:31 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1g1uDg-000113-QS; Mon, 17 Sep 2018 16:09:44 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v5 7/9] t7506: clean up .gitmodules properly before setting up new scenario
Date:   Mon, 17 Sep 2018 16:09:38 +0200
Message-Id: <20180917140940.3839-8-ao2@ao2.it>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917140940.3839-1-ao2@ao2.it>
References: <20180917140940.3839-1-ao2@ao2.it>
MIME-Version: 1.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t/t7506-status-submodule.sh at some point a new scenario is set up to
test different things, in particular new submodules are added which are
meant to completely replace the previous ones.

However before calling the "git submodule add" commands for the new
layout, the .gitmodules file is removed only from the working tree still
leaving the previous content in current branch.

This can break if, in the future, "git submodule add" starts
differentiating between the following two cases:

  - .gitmodules is not in the working tree but it is in the current
    branch (it may not be safe to add new submodules in this case);

  - .gitmodules is neither in the working tree nor anywhere in the
    current branch (it is safe to add new submodules).

Since the test intends to get rid of .gitmodules anyways, let's
completely remove it from the current branch, to actually start afresh
in the new scenario.

This is more future-proof and does not break current tests.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 t/t7506-status-submodule.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 943708fb04..08629a6e70 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -325,7 +325,8 @@ test_expect_success 'setup superproject with untracked file in nested submodule'
 	(
 		cd super &&
 		git clean -dfx &&
-		rm .gitmodules &&
+		git rm .gitmodules &&
+		git commit -m "remove .gitmodules" &&
 		git submodule add -f ./sub1 &&
 		git submodule add -f ./sub2 &&
 		git submodule add -f ./sub1 sub3 &&
-- 
2.19.0

