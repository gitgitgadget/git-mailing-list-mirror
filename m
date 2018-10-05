Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C5481F453
	for <e@80x24.org>; Fri,  5 Oct 2018 13:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbeJEUEv (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 16:04:51 -0400
Received: from mail.ao2.it ([92.243.12.208]:44937 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728539AbeJEUEu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 16:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=HaNzKZyIE4WEBg0nznvEQj4Rxh0qlzmLb2uEDH4/Jog=;
        b=Al73WNbzhati1RyiNChl51TrbeczEyx9PiHVCGk5uDqO83UkFQ2lW9vIux0dsc7Lc5tCaC/5AJzps5AyIToT4ItSMh7bWSH5VXRDtnE6PemplO5RHB/IrqkIaBwvYmK86A7QQ1m21JkyWpSCcqlfZZxTxEYc1VE2wR7C6rrYDgLaQSvsUXbwI+B5TDjZTcWvamx4x3+ak0vtHmZNUgTHyVnheXpMVKFcXPdQEtX3CXmLWRf43eRC30UbjLqQ4loEG2TgXSLO4N4KU3QrVqIqeZVOnppAFmb1Si6mg2tmCrnXjltHVvltmbFFE6/OP9c3uC4ycnXwWTS259WofU328g==;
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1g8PlT-0003BJ-Uq; Fri, 05 Oct 2018 15:03:32 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1g8Pnx-000498-G8; Fri, 05 Oct 2018 15:06:05 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v6 04/10] t7411: be nicer to future tests and really clean things up
Date:   Fri,  5 Oct 2018 15:05:55 +0200
Message-Id: <20181005130601.15879-5-ao2@ao2.it>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005130601.15879-1-ao2@ao2.it>
References: <20181005130601.15879-1-ao2@ao2.it>
MIME-Version: 1.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests 5 and 7 in t/t7411-submodule-config.sh add two commits with
invalid lines in .gitmodules but then only the second commit is removed.

This may affect future subsequent tests if they assume that the
.gitmodules file has no errors.

Remove both the commits as soon as they are not needed anymore.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 t/t7411-submodule-config.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index f2cd1f4a2c..b1f3c6489b 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -83,6 +83,8 @@ Submodule name: 'submodule' for path 'submodule'
 EOF
 
 test_expect_success 'error in history of one submodule config lets continue, stderr message contains blob ref' '
+	ORIG=$(git -C super rev-parse HEAD) &&
+	test_when_finished "git -C super reset --hard $ORIG" &&
 	(cd super &&
 		cp .gitmodules .gitmodules.bak &&
 		echo "	value = \"" >>.gitmodules &&
@@ -115,6 +117,8 @@ test_expect_success 'using different treeishs works' '
 '
 
 test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
+	ORIG=$(git -C super rev-parse HEAD) &&
+	test_when_finished "git -C super reset --hard $ORIG" &&
 	(cd super &&
 		git config -f .gitmodules \
 			submodule.submodule.fetchrecursesubmodules blabla &&
@@ -126,8 +130,7 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
 			HEAD b \
 			HEAD submodule \
 				>actual &&
-		test_cmp expect_error actual  &&
-		git reset --hard HEAD^
+		test_cmp expect_error actual
 	)
 '
 
-- 
2.19.0

