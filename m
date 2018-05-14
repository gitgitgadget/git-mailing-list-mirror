Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC121F42D
	for <e@80x24.org>; Mon, 14 May 2018 10:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeENK7N (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 06:59:13 -0400
Received: from ao2.it ([92.243.12.208]:53802 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752555AbeENK7D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 06:59:03 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fIBBq-00075V-IG; Mon, 14 May 2018 12:58:50 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fIBC1-0002CQ-HU; Mon, 14 May 2018 12:59:01 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [RFC PATCH 10/10] t7415: add new test about using HEAD:.gitmodules from the index
Date:   Mon, 14 May 2018 12:58:23 +0200
Message-Id: <20180514105823.8378-11-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514105823.8378-1-ao2@ao2.it>
References: <20180514105823.8378-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git submodule commands can now access .gitmodules from the index when
it's not checked out in the work tree, add some tests for that scenario.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 t/t7415-submodule-sparse-gitmodules.sh | 124 +++++++++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100755 t/t7415-submodule-sparse-gitmodules.sh

diff --git a/t/t7415-submodule-sparse-gitmodules.sh b/t/t7415-submodule-sparse-gitmodules.sh
new file mode 100755
index 000000000..3ae269b3a
--- /dev/null
+++ b/t/t7415-submodule-sparse-gitmodules.sh
@@ -0,0 +1,124 @@
+#!/bin/sh
+#
+# Copyright (C) 2018  Antonio Ospite <ao2@ao2.it>
+#
+
+test_description=' Test reading/writing the gitmodules config file when not checked out
+
+This test verifies that reading the gitmodules config file from the index when
+it is not checked out works, and that writing to it does not.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'sparse checkout setup which hides .gitmodules' '
+	echo file > file &&
+	git add file &&
+	test_tick &&
+	git commit -m upstream &&
+	git clone . super &&
+	git clone super submodule &&
+	git clone super new_submodule &&
+	(cd super &&
+		git submodule add ../submodule
+		test_tick &&
+		git commit -m submodule &&
+		cat >.git/info/sparse-checkout <<\EOF &&
+/*
+!/.gitmodules
+EOF
+		git config core.sparsecheckout true &&
+		git read-tree -m -u HEAD &&
+		test ! -e .gitmodules
+	)
+'
+
+test_expect_success 'reading gitmodules config file when it is not checked out' '
+	(cd super &&
+		echo "../submodule" >expected &&
+		git submodule--helper config submodule.submodule.url >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'not writing gitmodules config file when it is not checked out' '
+	(cd super &&
+		test_must_fail git submodule--helper config submodule.submodule.url newurl
+	)
+'
+
+test_expect_success 'not staging gitmodules config when it is not checked out' '
+	(cd super &&
+		test_must_fail git submodule--helper config --stage
+	)
+'
+
+test_expect_success 'not even staging manually crafted .gitmodules when it is not supposed to be checked out' '
+	(cd super &&
+		echo "bogus content" > .gitmodules &&
+		test_must_fail git submodule--helper config --stage &&
+		rm .gitmodules
+	)
+'
+
+test_expect_success 'initialising submodule when the gitmodules config is not checked out' '
+	(cd super &&
+		git submodule init
+	)
+'
+
+test_expect_success 'showing submodule summary when the gitmodules config is not checked out' '
+	(cd super &&
+		git submodule summary
+	)
+'
+
+test_expect_success 'updating submodule when the gitmodules config is not checked out' '
+	(cd submodule &&
+		echo file2 >file2 &&
+		git add file2 &&
+		git commit -m "add file2 to submodule"
+	) &&
+	(cd super &&
+		git submodule update
+	)
+'
+
+test_expect_success 'not moving submodule when the gitmodules config is not checked out' '
+	(cd super &&
+		test_must_fail git mv submodule moved_submodule
+	)
+'
+
+test_expect_success 'not removing submodule when the gitmodules config is not checked out' '
+	(cd super &&
+		test_must_fail git rm -r submodule
+	)
+'
+
+test_expect_success 'not adding submodules when the gitmodules config is not checked out' '
+	(cd super &&
+		test_must_fail git submodule add ../new_submodule
+	)
+'
+
+# "git add" in the test above fails as expected, however it still leaves the
+# cloned directory there and adds a config entry to .git/config. This is
+# because no cleanup is done by cmd_add in git-submodule.sh when "git
+# submodule--helper config" fails to add a new config setting.
+#
+# If we added the following commands to the test above:
+#
+#   rm -rf .git/modules/new_submodule &&
+#   git reset HEAD new_submodule &&
+#   rm -rf new_submodule
+#
+# then the repository would be in a clean status and the test below would
+# pass, but maybe cmd_add should do that.
+test_expect_failure 'init submodule after adding failed when the gitmodules config is not checked out' '
+	(cd super &&
+		git submodule init
+	)
+'
+
+test_done
-- 
2.17.0

