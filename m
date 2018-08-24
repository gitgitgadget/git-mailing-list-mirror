Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D56F1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 13:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeHXRFB (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 13:05:01 -0400
Received: from ao2.it ([92.243.12.208]:59512 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbeHXRFA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 13:05:00 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1ftC8c-0000hc-Qe; Fri, 24 Aug 2018 15:28:30 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1ftCAK-00026J-D2; Fri, 24 Aug 2018 15:30:16 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v4 9/9] submodule: support reading .gitmodules when it's not in the working tree
Date:   Fri, 24 Aug 2018 15:29:51 +0200
Message-Id: <20180824132951.8000-10-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824132951.8000-1-ao2@ao2.it>
References: <20180824132951.8000-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the .gitmodules file is not available in the working tree, try
using the content from the index and from the current branch. This
covers the case when the file is part of the repository but for some
reason it is not checked out, for example because of a sparse checkout.

This makes it possible to use at least the 'git submodule' commands
which *read* the gitmodules configuration file without fully populating
the working tree.

Writing to .gitmodules will still require that the file is checked out,
so check for that before calling config_set_in_gitmodules_file_gently.

Add a similar check also in git-submodule.sh::cmd_add() to anticipate
the eventual failure of the "git submodule add" command when .gitmodules
is not safely writeable; this prevents the command from leaving the
repository in a spurious state (e.g. the submodule repository was cloned
but .gitmodules was not updated because
config_set_in_gitmodules_file_gently failed).

Finally, add t7416-submodule-sparse-gitmodules.sh to verify that reading
from .gitmodules succeeds and that writing to it fails when the file is
not checked out.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 builtin/submodule--helper.c            |  6 +-
 git-submodule.sh                       |  5 ++
 submodule-config.c                     | 18 +++++-
 t/t7411-submodule-config.sh            | 26 ++++++++-
 t/t7416-submodule-sparse-gitmodules.sh | 78 ++++++++++++++++++++++++++
 5 files changed, 129 insertions(+), 4 deletions(-)
 create mode 100755 t/t7416-submodule-sparse-gitmodules.sh

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1bb168e814..6bc44d87dc 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2057,8 +2057,12 @@ static int module_config(int argc, const char **argv, const char *prefix)
 		return print_config_from_gitmodules(argv[1]);
 
 	/* Equivalent to ACTION_SET in builtin/config.c */
-	if (argc == 3)
+	if (argc == 3) {
+		if (!is_writing_gitmodules_ok())
+			die(_("please make sure that the .gitmodules file is in the working tree"));
+
 		return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
+	}
 
 	usage_with_options(git_submodule_helper_usage, module_config_options);
 }
diff --git a/git-submodule.sh b/git-submodule.sh
index 9e47dc9574..0e44487135 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -159,6 +159,11 @@ cmd_add()
 		shift
 	done
 
+	if ! git submodule--helper config --check-writeable >/dev/null 2>&1
+	then
+		 die "$(eval_gettext "please make sure that the .gitmodules file is in the working tree")"
+	fi
+
 	if test -n "$reference_path"
 	then
 		is_absolute_path "$reference_path" ||
diff --git a/submodule-config.c b/submodule-config.c
index b7ef055c63..edba68ac85 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "dir.h"
 #include "repository.h"
 #include "config.h"
 #include "submodule-config.h"
@@ -603,8 +604,21 @@ static void submodule_cache_check_init(struct repository *repo)
 static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
 {
 	if (repo->worktree) {
-		char *file = repo_worktree_path(repo, GITMODULES_FILE);
-		git_config_from_file(fn, file, data);
+		struct git_config_source config_source = { 0 };
+		const struct config_options opts = { 0 };
+		struct object_id oid;
+		char *file;
+
+		file = repo_worktree_path(repo, GITMODULES_FILE);
+		if (file_exists(file))
+			config_source.file = file;
+		else if (get_oid(GITMODULES_INDEX, &oid) >= 0)
+			config_source.blob = GITMODULES_INDEX;
+		else if (get_oid(GITMODULES_HEAD, &oid) >= 0)
+			config_source.blob = GITMODULES_HEAD;
+
+		config_with_options(fn, data, &config_source, &opts);
+
 		free(file);
 	}
 }
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 45953f9300..2cfabb18bc 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -134,7 +134,7 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
 	)
 '
 
-test_expect_success 'reading submodules config with "submodule--helper config"' '
+test_expect_success 'reading submodules config from the working tree with "submodule--helper config"' '
 	(cd super &&
 		echo "../submodule" >expect &&
 		git submodule--helper config submodule.submodule.url >actual &&
@@ -192,4 +192,28 @@ test_expect_success 'non-writeable .gitmodules when it is in the current branch
 	)
 '
 
+test_expect_success 'reading submodules config from the index when .gitmodules is not in the working tree' '
+	ORIG=$(git -C super rev-parse HEAD) &&
+	test_when_finished "git -C super reset --hard $ORIG" &&
+	(cd super &&
+		git submodule--helper config submodule.submodule.url "staged_url" &&
+		git add .gitmodules &&
+		rm -f .gitmodules &&
+		echo "staged_url" >expect &&
+		git submodule--helper config submodule.submodule.url >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'reading submodules config from the current branch when .gitmodules is not in the index' '
+	ORIG=$(git -C super rev-parse HEAD) &&
+	test_when_finished "git -C super reset --hard $ORIG" &&
+	(cd super &&
+		git rm .gitmodules &&
+		echo "../submodule" >expect &&
+		git submodule--helper config submodule.submodule.url >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
diff --git a/t/t7416-submodule-sparse-gitmodules.sh b/t/t7416-submodule-sparse-gitmodules.sh
new file mode 100755
index 0000000000..908a4e6958
--- /dev/null
+++ b/t/t7416-submodule-sparse-gitmodules.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+#
+# Copyright (C) 2018  Antonio Ospite <ao2@ao2.it>
+#
+
+test_description='Test reading/writing .gitmodules when not in the working tree
+
+This test verifies that, when .gitmodules is in the current branch but is not
+in the working tree reading from it still works but writing to it does not.
+
+The test setup uses a sparse checkout, however the same scenario can be set up
+also by committing .gitmodules and then just removing it from the filesystem.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'sparse checkout setup which hides .gitmodules' '
+	echo file >file &&
+	git add file &&
+	test_tick &&
+	git commit -m upstream &&
+	git clone . super &&
+	git clone super submodule &&
+	git clone super new_submodule &&
+	(cd super &&
+		git submodule add ../submodule &&
+		test_tick &&
+		git commit -m submodule &&
+		cat >.git/info/sparse-checkout <<-\EOF &&
+		/*
+		!/.gitmodules
+		EOF
+		git config core.sparsecheckout true &&
+		git read-tree -m -u HEAD &&
+		test_path_is_missing .gitmodules
+	)
+'
+
+test_expect_success 'reading gitmodules config file when it is not checked out' '
+	(cd super &&
+		echo "../submodule" >expect &&
+		git submodule--helper config submodule.submodule.url >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'not writing gitmodules config file when it is not checked out' '
+	 test_must_fail git -C super submodule--helper config submodule.submodule.url newurl
+'
+
+test_expect_success 'initialising submodule when the gitmodules config is not checked out' '
+	git -C super submodule init
+'
+
+test_expect_success 'showing submodule summary when the gitmodules config is not checked out' '
+	git -C super submodule summary
+'
+
+test_expect_success 'updating submodule when the gitmodules config is not checked out' '
+	(cd submodule &&
+		echo file2 >file2 &&
+		git add file2 &&
+		git commit -m "add file2 to submodule"
+	) &&
+	git -C super submodule update
+'
+
+test_expect_success 'not adding submodules when the gitmodules config is not checked out' '
+	test_must_fail git -C super submodule add ../new_submodule
+'
+
+# This test checks that the previous "git submodule add" did not leave the
+# repository in a spurious state when it failed.
+test_expect_success 'init submodule still works even after the previous add failed' '
+	git -C super submodule init
+'
+
+test_done
-- 
2.18.0

