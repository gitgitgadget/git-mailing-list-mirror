Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 559D81F42D
	for <e@80x24.org>; Mon, 14 May 2018 10:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbeENK7I (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 06:59:08 -0400
Received: from ao2.it ([92.243.12.208]:53809 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752548AbeENK7G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 06:59:06 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fIBBq-00075F-7X; Mon, 14 May 2018 12:58:50 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fIBC0-0002C9-P2; Mon, 14 May 2018 12:59:00 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [RFC PATCH 04/10] submodule--helper: add a new 'config' subcommand
Date:   Mon, 14 May 2018 12:58:17 +0200
Message-Id: <20180514105823.8378-5-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514105823.8378-1-ao2@ao2.it>
References: <20180514105823.8378-1-ao2@ao2.it>
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
 builtin/submodule--helper.c | 39 +++++++++++++++++++++++++++++++++++++
 t/t7411-submodule-config.sh | 26 +++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9e8f2acd5..b32110e3b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1825,6 +1825,44 @@ static int is_active(int argc, const char **argv, const char *prefix)
 	return !is_submodule_active(the_repository, argv[1]);
 }
 
+static int config_print_callback(const char *key_, const char *value_, void *cb_data)
+{
+	char *key = cb_data;
+
+	if (!strcmp(key, key_))
+		printf("%s\n", value_);
+
+	return 0;
+}
+
+static int module_config(int argc, const char **argv, const char *prefix)
+{
+	int ret;
+
+	if (argc < 2 || argc > 3)
+		die("submodule--helper config takes 1 or 2 arguments: name [value]");
+
+	/* Equivalent to ACTION_GET in builtin/config.c */
+	if (argc == 2) {
+		char *key;
+
+		ret = git_config_parse_key(argv[1], &key, NULL);
+		if (ret < 0)
+			return CONFIG_INVALID_KEY;
+
+		config_from_gitmodules(config_print_callback, the_repository, key);
+
+		free(key);
+		return 0;
+	}
+
+	/* Equivalent to ACTION_SET in builtin/config.c */
+	if (argc == 3)
+		return config_gitmodules_set(argv[1], argv[2]);
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -1850,6 +1888,7 @@ static struct cmd_struct commands[] = {
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
 	{"is-active", is_active, 0},
+	{"config", module_config, 0},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index a648de6a9..dfe019f05 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -139,4 +139,30 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
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
2.17.0

