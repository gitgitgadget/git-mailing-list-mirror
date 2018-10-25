Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271A71F453
	for <e@80x24.org>; Thu, 25 Oct 2018 16:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeJZAwC (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 20:52:02 -0400
Received: from mail.ao2.it ([92.243.12.208]:44360 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727319AbeJZAwB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 20:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=a8cnjWhuWCj5e2w5sU7OjESADXdNXFZjUr9pwmReIb0=;
        b=HG2tpH/rZtpXSUDubX1A4JeUofQK1IFMI+cuICdLUn70uM28VNtnlJPy1bywiAJiBPRp8IGceLfYNofmSsgwtQSOCqDBqY0/MqwZiPkkHPc/LpvHRUmNF+FpVk9OzJ9NDFWabziwdM/fKnIkEwEI7xRNKCWNBXv3nbFBZnvikSobl6LAhQ6D6ygJ9HeobPWBOeFyDgzDmBXSfM/NOuQMMYcDNd1iPyyM6jTP9UxqwR8icPowHfSnaXsojBNOnJbIoP4ePDdsRGOesKrnZQZvId9hxJZu+Ff4AcQdTjiyy739m6hqHc4IyuOrz/93tJJ69U+39J+q/JKHGcVTvgr4YQ==;
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1gFiKo-0003L1-1a; Thu, 25 Oct 2018 18:18:10 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1gFiL5-0004VN-I9; Thu, 25 Oct 2018 18:18:27 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v7 07/10] t7506: clean up .gitmodules properly before setting up new scenario
Date:   Thu, 25 Oct 2018 18:18:10 +0200
Message-Id: <20181025161813.17252-8-ao2@ao2.it>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181025161813.17252-1-ao2@ao2.it>
References: <20181025161813.17252-1-ao2@ao2.it>
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
2.19.1

