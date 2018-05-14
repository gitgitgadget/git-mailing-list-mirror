Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4CE1F42D
	for <e@80x24.org>; Mon, 14 May 2018 10:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeENK7P (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 06:59:15 -0400
Received: from ao2.it ([92.243.12.208]:53792 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752550AbeENK7D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 06:59:03 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fIBBq-000757-0y; Mon, 14 May 2018 12:58:50 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fIBC1-0002CE-10; Mon, 14 May 2018 12:59:01 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [RFC PATCH 06/10] submodule--helper: add a '--stage' option to the 'config' sub command
Date:   Mon, 14 May 2018 12:58:19 +0200
Message-Id: <20180514105823.8378-7-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514105823.8378-1-ao2@ao2.it>
References: <20180514105823.8378-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a --stage option to the 'submodule--helper config' command so that
the .gitmodules file can be staged without referring to it explicitly by
file path.

In practice the config will still be written to .gitmoudules, there are
no plans to change the file path, but having this level of indirection
makes it possible to perform possible additional checks before staging
the file.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 builtin/submodule--helper.c | 44 +++++++++++++++++++++++++++++++++++--
 t/t7411-submodule-config.sh | 35 +++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b32110e3b..de5caa776 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -5,6 +5,7 @@
 #include "parse-options.h"
 #include "quote.h"
 #include "pathspec.h"
+#include "lockfile.h"
 #include "dir.h"
 #include "submodule.h"
 #include "submodule-config.h"
@@ -1837,10 +1838,49 @@ static int config_print_callback(const char *key_, const char *value_, void *cb_
 
 static int module_config(int argc, const char **argv, const char *prefix)
 {
+	int stage_gitmodules = 0;
 	int ret;
 
-	if (argc < 2 || argc > 3)
-		die("submodule--helper config takes 1 or 2 arguments: name [value]");
+	struct option module_config_options[] = {
+		OPT_BOOL(0, "stage", &stage_gitmodules,
+			    N_("stage the .gitmodules file content")),
+		OPT_END()
+	};
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper config name [value]"),
+		N_("git submodule--helper config --stage"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_config_options,
+			     git_submodule_helper_usage, PARSE_OPT_KEEP_ARGV0);
+
+	if ((stage_gitmodules && argc > 1) ||
+	    (!stage_gitmodules && (argc < 2 || argc > 3)))
+		usage_with_options(git_submodule_helper_usage, module_config_options);
+
+	/*
+	 * Equivalent to "git add --force .gitmodules".
+	 *
+	 * Silently override already staged changes, to support consecutive
+	 * invocations of "git submodule add".
+	 */
+	if (stage_gitmodules) {
+		static struct lock_file lock_file;
+
+		hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+
+		if (read_cache() < 0)
+			die(_("index file corrupt"));
+
+		stage_updated_gitmodules(&the_index);
+
+		if (write_locked_index(&the_index, &lock_file,
+				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
+			die(_("Unable to write new index file"));
+
+		return 0;
+	}
 
 	/* Equivalent to ACTION_GET in builtin/config.c */
 	if (argc == 2) {
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index dfe019f05..a0b2f7cd6 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -165,4 +165,39 @@ test_expect_success 'overwriting unstaged submodules config with "submodule--hel
 	)
 '
 
+test_expect_success 'staging submodules config with "submodule--helper config"' '
+	(cd super &&
+		: >expected &&
+		git diff --name-only --cached >actual &&
+		test_cmp expected actual &&
+		git submodule--helper config --stage &&
+		echo ".gitmodules" >expected &&
+		git diff --name-only --cached >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'overwriting staged submodules config with "submodule--helper config"' '
+	(cd super &&
+		echo "even_newer_url" >expected &&
+		git submodule--helper config submodule.submodule.url "even_newer_url" &&
+		git submodule--helper config submodule.submodule.url >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 're-staging overridden submodule config with "submodule--helper config"' '
+	(cd super &&
+		echo ".gitmodules" >expected &&
+		git diff --name-only --cached >actual &&
+		test_cmp expected actual &&
+		echo "bogus config" >.gitmodules &&
+		git submodule--helper config --stage &&
+		git diff --name-only --cached >actual &&
+		test_cmp expected actual &&
+		git reset HEAD .gitmodules &&
+		git checkout .gitmodules
+	)
+'
+
 test_done
-- 
2.17.0

