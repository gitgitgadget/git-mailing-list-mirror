Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FB5A1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 14:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387615AbeHBQTU (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 12:19:20 -0400
Received: from ao2.it ([92.243.12.208]:54932 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387576AbeHBQTU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 12:19:20 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1flDv8-0006hw-LT; Thu, 02 Aug 2018 15:45:38 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1flDwQ-0002hD-UP; Thu, 02 Aug 2018 15:46:58 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [RFC PATCH v2 04/12] submodule--helper: add a new 'config' subcommand
Date:   Thu,  2 Aug 2018 15:46:26 +0200
Message-Id: <20180802134634.10300-5-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802134634.10300-1-ao2@ao2.it>
References: <20180802134634.10300-1-ao2@ao2.it>
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

Note that the tests follow the predominant style in the file: subshell and cd
right at the start of the sub-shell opening.

 builtin/submodule--helper.c | 17 +++++++++++++++++
 t/t7411-submodule-config.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a3c4564c6c..14f0845d30 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2029,6 +2029,22 @@ static int connect_gitdir_workingtree(int argc, const char **argv, const char *p
 	return 0;
 }
 
+static int module_config(int argc, const char **argv, const char *prefix)
+{
+	if (argc < 2 || argc > 3)
+		die("submodule--helper config takes 1 or 2 arguments: name [value]");
+
+	/* Equivalent to ACTION_GET in builtin/config.c */
+	if (argc == 2)
+		return print_config_from_gitmodules(argv[1]);
+
+	/* Equivalent to ACTION_SET in builtin/config.c */
+	if (argc == 3)
+		return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -2057,6 +2073,7 @@ static struct cmd_struct commands[] = {
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
 	{"is-active", is_active, 0},
 	{"check-name", check_name, 0},
+	{"config", module_config, 0},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 248da0bc4f..bbca4b421d 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -141,4 +141,30 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
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

