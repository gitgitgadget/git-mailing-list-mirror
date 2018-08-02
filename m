Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25F5A1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 14:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387618AbeHBQTW (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 12:19:22 -0400
Received: from ao2.it ([92.243.12.208]:54933 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387576AbeHBQTW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 12:19:22 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1flDv8-0006hy-P9; Thu, 02 Aug 2018 15:45:39 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1flDwR-0002hH-32; Thu, 02 Aug 2018 15:46:59 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [RFC PATCH v2 06/12] submodule--helper: add a '--stage' option to the 'config' sub command
Date:   Thu,  2 Aug 2018 15:46:28 +0200
Message-Id: <20180802134634.10300-7-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802134634.10300-1-ao2@ao2.it>
References: <20180802134634.10300-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a --stage option to the 'submodule--helper config' command so that
the .gitmodules file can be staged without referring to it explicitly by
its file path.

In practice the config will still be written to .gitmodules, there are
no plans to change the file path, but having this level of indirection
makes it possible to perform additional checks before staging the file.

Note that "git submodule--helper config --stage" will fail when
.gitmodules does not exist, this is to be consistent with how "git add"
and "git rm" work: if the file to be staged does not exist they will
complain.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 builtin/submodule--helper.c | 54 +++++++++++++++++++++++++++++++++++--
 t/t7411-submodule-config.sh | 35 ++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 14f0845d30..c388f4ee6f 100644
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
@@ -2031,8 +2032,57 @@ static int connect_gitdir_workingtree(int argc, const char **argv, const char *p
 
 static int module_config(int argc, const char **argv, const char *prefix)
 {
-	if (argc < 2 || argc > 3)
-		die("submodule--helper config takes 1 or 2 arguments: name [value]");
+	int stage_gitmodules = 0;
+
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
+		/*
+		 * Do not use is_staging_gitmodules_ok() here to make it
+		 * possible to stage multiple changes before committing them,
+		 * in particular this covers the case of consecutive calls of
+		 * "git submodule add".
+		 */
+		if (!file_exists(GITMODULES_FILE))
+			die(_("%s does not exists"), GITMODULES_FILE);
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
 	if (argc == 2)
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index bbca4b421d..8ff6ed444a 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -167,4 +167,39 @@ test_expect_success 'overwriting unstaged submodules config with "submodule--hel
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
2.18.0

