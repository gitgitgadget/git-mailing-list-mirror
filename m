Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C06BB1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 11:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbeHNNwf (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 09:52:35 -0400
Received: from ao2.it ([92.243.12.208]:42926 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731168AbeHNNwd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 09:52:33 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fpX7V-0007ZX-0H; Tue, 14 Aug 2018 13:04:13 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fpX90-0004e7-QI; Tue, 14 Aug 2018 13:05:46 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v3 4/7] submodule--helper: add a new 'config' subcommand
Date:   Tue, 14 Aug 2018 13:05:22 +0200
Message-Id: <20180814110525.17801-5-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814110525.17801-1-ao2@ao2.it>
References: <20180814110525.17801-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new 'config' subcommand to 'submodule--helper', this extra level
of indirection makes it possible to add some flexibility to how the
submodules configuration is handled.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 builtin/submodule--helper.c | 14 ++++++++++++++
 new                         |  0
 t/t7411-submodule-config.sh | 26 ++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 new

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a3c4564c6c..7481d03b63 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2029,6 +2029,19 @@ static int connect_gitdir_workingtree(int argc, const char **argv, const char *p
 	return 0;
 }
 
+static int module_config(int argc, const char **argv, const char *prefix)
+{
+	/* Equivalent to ACTION_GET in builtin/config.c */
+	if (argc == 2)
+		return print_config_from_gitmodules(argv[1]);
+
+	/* Equivalent to ACTION_SET in builtin/config.c */
+	if (argc == 3)
+		return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
+
+	die("submodule--helper config takes 1 or 2 arguments: name [value]");
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -2057,6 +2070,7 @@ static struct cmd_struct commands[] = {
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
 	{"is-active", is_active, 0},
 	{"check-name", check_name, 0},
+	{"config", module_config, 0},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/new b/new
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index c6b6cf6fae..4afb6f152e 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -142,4 +142,30 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
 	)
 '
 
+test_expect_success 'reading submodules config with "submodule--helper config"' '
+	(cd super &&
+		echo "../submodule" >expected &&
+		git submodule--helper config submodule.submodule.url >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'writing submodules config with "submodule--helper config"' '
+	(cd super &&
+		echo "new_url" >expected &&
+		git submodule--helper config submodule.submodule.url "new_url" &&
+		git submodule--helper config submodule.submodule.url >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'overwriting unstaged submodules config with "submodule--helper config"' '
+	(cd super &&
+		echo "newer_url" >expected &&
+		git submodule--helper config submodule.submodule.url "newer_url" &&
+		git submodule--helper config submodule.submodule.url >actual &&
+		test_cmp expected actual
+	)
+'
+
 test_done
-- 
2.18.0

