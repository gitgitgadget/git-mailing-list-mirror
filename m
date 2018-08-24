Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14CB61F404
	for <e@80x24.org>; Fri, 24 Aug 2018 13:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeHXRFE (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 13:05:04 -0400
Received: from ao2.it ([92.243.12.208]:59524 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbeHXRFD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 13:05:03 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1ftC8c-0000hW-I6; Fri, 24 Aug 2018 15:28:30 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1ftCAK-000266-0z; Fri, 24 Aug 2018 15:30:16 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v4 5/9] submodule--helper: add a new 'config' subcommand
Date:   Fri, 24 Aug 2018 15:29:47 +0200
Message-Id: <20180824132951.8000-6-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824132951.8000-1-ao2@ao2.it>
References: <20180824132951.8000-1-ao2@ao2.it>
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
 t/t7411-submodule-config.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2bcc70fdfe..a461a1107c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2028,6 +2028,19 @@ static int connect_gitdir_workingtree(int argc, const char **argv, const char *p
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
@@ -2056,6 +2069,7 @@ static struct cmd_struct commands[] = {
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
 	{"is-active", is_active, 0},
 	{"check-name", check_name, 0},
+	{"config", module_config, 0},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index b1f3c6489b..791245f18d 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -134,4 +134,31 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
 	)
 '
 
+test_expect_success 'reading submodules config with "submodule--helper config"' '
+	(cd super &&
+		echo "../submodule" >expect &&
+		git submodule--helper config submodule.submodule.url >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'writing submodules config with "submodule--helper config"' '
+	(cd super &&
+		echo "new_url" >expect &&
+		git submodule--helper config submodule.submodule.url "new_url" &&
+		git submodule--helper config submodule.submodule.url >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'overwriting unstaged submodules config with "submodule--helper config"' '
+	test_when_finished "git -C super checkout .gitmodules" &&
+	(cd super &&
+		echo "newer_url" >expect &&
+		git submodule--helper config submodule.submodule.url "newer_url" &&
+		git submodule--helper config submodule.submodule.url >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.18.0

