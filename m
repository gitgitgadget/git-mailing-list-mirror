Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D691F404
	for <e@80x24.org>; Tue, 14 Aug 2018 11:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbeHNNwc (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 09:52:32 -0400
Received: from ao2.it ([92.243.12.208]:42915 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729536AbeHNNwb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 09:52:31 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fpX7V-0007ZW-0B; Tue, 14 Aug 2018 13:04:13 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fpX91-0004eD-1C; Tue, 14 Aug 2018 13:05:47 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v3 7/7] submodule: support reading .gitmodules even when it's not checked out
Date:   Tue, 14 Aug 2018 13:05:25 +0200
Message-Id: <20180814110525.17801-8-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814110525.17801-1-ao2@ao2.it>
References: <20180814110525.17801-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the .gitmodules file is not available in the working tree, try
using HEAD:.gitmodules from the current branch. This covers the case
when the file is part of the repository but for some reason it is not
checked out, for example because of a sparse checkout.

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

Maybe the check in config_set_in_gitmodules_file_gently and
git-submodule.sh::cmd_add() can share some code:

  - add an is_gitmodules_safely_writeable() helper
  - expose a "submodule--helper config --is-safely-writeable" subcommand

But for now I preferred to keep the changes with v2 to a minimum to avoid
blocking the series.

If adding a new helper is preferred I can do a v4 or send a follow-up patch.

Thank you,
   Antonio


 builtin/submodule--helper.c            | 17 ++++-
 cache.h                                |  1 +
 git-submodule.sh                       |  7 ++
 submodule-config.c                     | 16 ++++-
 t/t7416-submodule-sparse-gitmodules.sh | 90 ++++++++++++++++++++++++++
 5 files changed, 128 insertions(+), 3 deletions(-)
 create mode 100755 t/t7416-submodule-sparse-gitmodules.sh

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7481d03b63..c0370a756b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2036,8 +2036,23 @@ static int module_config(int argc, const char **argv, const char *prefix)
 		return print_config_from_gitmodules(argv[1]);
 
 	/* Equivalent to ACTION_SET in builtin/config.c */
-	if (argc == 3)
+	if (argc == 3) {
+		struct object_id oid;
+
+		/*
+		 * If the .gitmodules file is not in the working tree but it
+		 * is in the current branch, stop, as writing new values (and
+		 * staging them) would blindly overwrite ALL the old content.
+		 *
+		 * This check still makes it possible to create a brand new
+		 * .gitmodules when it is safe to do so: when neither
+		 * GITMODULES_FILE nor GITMODULES_HEAD exist.
+		 */
+		if (!file_exists(GITMODULES_FILE) && get_oid(GITMODULES_HEAD, &oid) >= 0)
+			die(_("please make sure that the .gitmodules file in the current branch is checked out"));
+
 		return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
+	}
 
 	die("submodule--helper config takes 1 or 2 arguments: name [value]");
 }
diff --git a/cache.h b/cache.h
index 8dc7134f00..900f9e09e5 100644
--- a/cache.h
+++ b/cache.h
@@ -486,6 +486,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
 #define GITMODULES_FILE ".gitmodules"
+#define GITMODULES_HEAD "HEAD:.gitmodules"
 #define GIT_NOTES_REF_ENVIRONMENT "GIT_NOTES_REF"
 #define GIT_NOTES_DEFAULT_REF "refs/notes/commits"
 #define GIT_NOTES_DISPLAY_REF_ENVIRONMENT "GIT_NOTES_DISPLAY_REF"
diff --git a/git-submodule.sh b/git-submodule.sh
index ff258e2e8c..b1cb187227 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -159,6 +159,13 @@ cmd_add()
 		shift
 	done
 
+	# For more details about this check, see
+	# builtin/submodule--helper.c::module_config()
+	if test ! -e .gitmodules && git cat-file -e HEAD:.gitmodules > /dev/null 2>&1
+	then
+		 die "$(eval_gettext "please make sure that the .gitmodules file in the current branch is checked out")"
+	fi
+
 	if test -n "$reference_path"
 	then
 		is_absolute_path "$reference_path" ||
diff --git a/submodule-config.c b/submodule-config.c
index b7ef055c63..088dabb56f 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "dir.h"
 #include "repository.h"
 #include "config.h"
 #include "submodule-config.h"
@@ -603,8 +604,19 @@ static void submodule_cache_check_init(struct repository *repo)
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
+		else if (get_oid(GITMODULES_HEAD, &oid) >= 0)
+			config_source.blob = GITMODULES_HEAD;
+
+		config_with_options(fn, data, &config_source, &opts);
+
 		free(file);
 	}
 }
diff --git a/t/t7416-submodule-sparse-gitmodules.sh b/t/t7416-submodule-sparse-gitmodules.sh
new file mode 100755
index 0000000000..5341e9b012
--- /dev/null
+++ b/t/t7416-submodule-sparse-gitmodules.sh
@@ -0,0 +1,90 @@
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
+	echo file > file &&
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
+		cat >.git/info/sparse-checkout <<\EOF &&
+/*
+!/.gitmodules
+EOF
+		git config core.sparsecheckout true &&
+		git read-tree -m -u HEAD &&
+		test_path_is_missing .gitmodules
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
+test_expect_success 'not adding submodules when the gitmodules config is not checked out' '
+	(cd super &&
+		test_must_fail git submodule add ../new_submodule
+	)
+'
+
+# This test checks that the previous "git submodule add" did not leave the
+# repository in a spurious state when it failed.
+test_expect_success 'init submodule still works even after the previous add failed' '
+	(cd super &&
+		git submodule init
+	)
+'
+
+test_done
-- 
2.18.0

