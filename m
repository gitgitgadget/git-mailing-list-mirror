Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1992C1F453
	for <e@80x24.org>; Fri,  5 Oct 2018 13:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeJEUEv (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 16:04:51 -0400
Received: from mail.ao2.it ([92.243.12.208]:44936 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728278AbeJEUEu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 16:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=Va1U5VkeNhAgJEIwNEGecCt6l5b914QyDoal8eEZ6Sc=;
        b=ChzFkONPGR5iHC9BmF6bcKfHkn9Ymmxk2ioxsxFeDIU0BePR+PzKT0GqJSSEk8g/JHzxoVYW0a4dDrqG2x6bgK7oCTRwUvK5ORqWMFvDf3ZG+cupdaqJh+Fqm6HL0t3Xg8VfFLhoPnFjfaIfgvFBd81wkYW0QNixh5AMimepEwzxo7AwypI7Mpdmp6pN/1GMRirCWyRVGHqULHwd9gj85Hp/55E1Hz4qZ+6Qas50pjLe84C06nBZknj34bi7nlhqKy1uz73tNgq+xP89jTgnKMIw7WTO0y0sOXaLckeQOs/A45FCon4J8biJeou6tcqao8BFcf0k3W5e8Om2Wc/XTQ==;
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1g8PlT-0003BI-Tv; Fri, 05 Oct 2018 15:03:31 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1g8Pnx-00049A-IX; Fri, 05 Oct 2018 15:06:05 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v6 05/10] submodule--helper: add a new 'config' subcommand
Date:   Fri,  5 Oct 2018 15:05:56 +0200
Message-Id: <20181005130601.15879-6-ao2@ao2.it>
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

Add a new 'config' subcommand to 'submodule--helper', this extra level
of indirection makes it possible to add some flexibility to how the
submodules configuration is handled.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 builtin/submodule--helper.c | 14 ++++++++++++++
 t/t7411-submodule-config.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 40844870cf..e1bdca8f0b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2125,6 +2125,19 @@ static int check_name(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int module_config(int argc, const char **argv, const char *prefix)
+{
+	/* Equivalent to ACTION_GET in builtin/config.c */
+	if (argc == 2)
+		return print_config_from_gitmodules(the_repository, argv[1]);
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
@@ -2154,6 +2167,7 @@ static struct cmd_struct commands[] = {
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
2.19.0

