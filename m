Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 172D31F404
	for <e@80x24.org>; Tue, 14 Aug 2018 11:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbeHNNwd (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 09:52:33 -0400
Received: from ao2.it ([92.243.12.208]:42924 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728314AbeHNNwd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 09:52:33 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fpX7U-0007ZR-M4; Tue, 14 Aug 2018 13:04:12 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fpX90-0004e5-Nk; Tue, 14 Aug 2018 13:05:46 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v3 3/7] t7411: be nicer to future tests and really clean things up
Date:   Tue, 14 Aug 2018 13:05:21 +0200
Message-Id: <20180814110525.17801-4-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814110525.17801-1-ao2@ao2.it>
References: <20180814110525.17801-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests 5 and 8 in t/t7411-submodule-config.sh add two commits with
invalid lines in .gitmodules but then only the second commit is removed.

This may affect future subsequent tests if they assume that the
.gitmodules file has no errors.

Remove both the commits as soon as they are not needed anymore.

The error introduced in test 5 is also required by test 6, so the two
commits from above are removed respectively in tests 6 and 8.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 t/t7411-submodule-config.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 0bde5850ac..c6b6cf6fae 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -98,6 +98,9 @@ test_expect_success 'error in one submodule config lets continue' '
 '
 
 test_expect_success 'error message contains blob reference' '
+	# Remove the error introduced in the previous test.
+	# It is not needed in the following tests.
+	test_when_finished "git -C super reset --hard HEAD^" &&
 	(cd super &&
 		sha1=$(git rev-parse HEAD) &&
 		test-tool submodule-config \
@@ -123,6 +126,7 @@ test_expect_success 'using different treeishs works' '
 '
 
 test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
+	test_when_finished "git -C super reset --hard HEAD^" &&
 	(cd super &&
 		git config -f .gitmodules \
 			submodule.submodule.fetchrecursesubmodules blabla &&
@@ -134,8 +138,7 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
 			HEAD b \
 			HEAD submodule \
 				>actual &&
-		test_cmp expect_error actual  &&
-		git reset --hard HEAD^
+		test_cmp expect_error actual
 	)
 '
 
-- 
2.18.0

