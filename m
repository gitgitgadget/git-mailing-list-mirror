Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53A0D1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 16:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeJZAwB (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 20:52:01 -0400
Received: from mail.ao2.it ([92.243.12.208]:44347 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbeJZAwA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 20:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=xXgtWbWxL0aF+XPPgIhkBvGUb5YZ+Ud+7BFXjQIOLYE=;
        b=fumK2JSV13duNxdWfsYRGJSq5VhUPtFDjkR4rHuD4vHx6+ABp8ITs7AvQpbdMfC2YFpoMLWVtoOD1UxFTUdCZeaKCOg5A9zpb3K1tj7QL6r/HLz8JfuTYxS/VSppcIuo+5kZ8KZqU1rNKU0crNQaoXqsQYeyy61PR+0Rp/WgxHOWhQ9uWTVk1+I0rC2i9mPDKUemAzU4MWDEQiC0XoSNQcJbgIejFJSwVOpqJNTQ7mEkFXnjIz5XGXAGFhybV4XvqlYly0vzXKO+bMqruaHTeynF3I+iNnXyVEkIspFl0U+7gLfZQkIyRrq/FTAUkgdKt3EbVQ0B7QnC7B3Pxkm1NA==;
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1gFiKo-0003L7-9w; Thu, 25 Oct 2018 18:18:10 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1gFiL5-0004VT-NH; Thu, 25 Oct 2018 18:18:27 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v7 09/10] submodule: support reading .gitmodules when it's not in the working tree
Date:   Thu, 25 Oct 2018 18:18:12 +0200
Message-Id: <20181025161813.17252-10-ao2@ao2.it>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181025161813.17252-1-ao2@ao2.it>
References: <20181025161813.17252-1-ao2@ao2.it>
MIME-Version: 1.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Content-Transfer-Encoding: 8bit
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

Moreover, since config_from_gitmodules() now accesses the global object
store, it is necessary to protect all code paths which call the function
against concurrent access to the global object store. Currently this
only happens in builtin/grep.c::grep_submodules(), so call
grep_read_lock() before invoking code involving
config_from_gitmodules().

Finally, add t7418-submodule-sparse-gitmodules.sh to verify that reading
from .gitmodules succeeds and that writing to it fails when the file is
not checked out.

NOTE: there is one rare case where this new feature does not work
properly yet: nested submodules without .gitmodules in their working
tree.  This has been documented with a warning and a test_expect_failure
item in t7814, and in this case the current behavior is not altered: no
config is read.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 builtin/grep.c                         |  17 +++-
 builtin/submodule--helper.c            |   6 +-
 git-submodule.sh                       |   5 +
 submodule-config.c                     |  31 ++++++-
 t/t7411-submodule-config.sh            |  26 +++++-
 t/t7418-submodule-sparse-gitmodules.sh | 122 +++++++++++++++++++++++++
 t/t7814-grep-recurse-submodules.sh     |  16 ++++
 7 files changed, 216 insertions(+), 7 deletions(-)
 create mode 100755 t/t7418-submodule-sparse-gitmodules.sh

diff --git a/builtin/grep.c b/builtin/grep.c
index d8508ddf79..56e4a11052 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -422,11 +422,23 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 	struct repository submodule;
 	int hit;
 
-	if (!is_submodule_active(superproject, path))
+	/*
+	 * NEEDSWORK: submodules functions need to be protected because they
+	 * access the object store via config_from_gitmodules(): the latter
+	 * uses get_oid() which, for now, relies on the global the_repository
+	 * object.
+	 */
+	grep_read_lock();
+
+	if (!is_submodule_active(superproject, path)) {
+		grep_read_unlock();
 		return 0;
+	}
 
-	if (repo_submodule_init(&submodule, superproject, path))
+	if (repo_submodule_init(&submodule, superproject, path)) {
+		grep_read_unlock();
 		return 0;
+	}
 
 	repo_read_gitmodules(&submodule);
 
@@ -440,7 +452,6 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 	 * store is no longer global and instead is a member of the repository
 	 * object.
 	 */
-	grep_read_lock();
 	add_to_alternates_memory(submodule.objects->objectdir);
 	grep_read_unlock();
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b272a78801..05ce666142 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2155,8 +2155,12 @@ static int module_config(int argc, const char **argv, const char *prefix)
 		return print_config_from_gitmodules(the_repository, argv[1]);
 
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
index 0805fadf47..f5124bbf23 100755
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
index 329c0b44f6..52702c62d9 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "dir.h"
 #include "repository.h"
 #include "config.h"
 #include "submodule-config.h"
@@ -613,8 +614,34 @@ static void submodule_cache_check_init(struct repository *repo)
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
+		if (file_exists(file)) {
+			config_source.file = file;
+		} else if (repo->submodule_prefix) {
+			/*
+			 * When get_oid and config_with_options, used below,
+			 * become able to work on a specific repository, this
+			 * warning branch can be removed.
+			 */
+			warning("nested submodules without %s in the working tree are not supported yet",
+				GITMODULES_FILE);
+			goto out;
+		} else if (get_oid(GITMODULES_INDEX, &oid) >= 0) {
+			config_source.blob = GITMODULES_INDEX;
+		} else if (get_oid(GITMODULES_HEAD, &oid) >= 0) {
+			config_source.blob = GITMODULES_HEAD;
+		} else {
+			goto out;
+		}
+
+		config_with_options(fn, data, &config_source, &opts);
+
+out:
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
diff --git a/t/t7418-submodule-sparse-gitmodules.sh b/t/t7418-submodule-sparse-gitmodules.sh
new file mode 100755
index 0000000000..21a86b89c6
--- /dev/null
+++ b/t/t7418-submodule-sparse-gitmodules.sh
@@ -0,0 +1,122 @@
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
+	git init upstream &&
+	git init submodule &&
+	(cd submodule &&
+		echo file >file &&
+		git add file &&
+		test_tick &&
+		git commit -m "Add file"
+	) &&
+	(cd upstream &&
+		git submodule add ../submodule &&
+		test_tick &&
+		git commit -m "Add submodule"
+	) &&
+	git clone upstream super &&
+	(cd super &&
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
+	echo "../submodule" >expect &&
+	git -C super submodule--helper config submodule.submodule.url >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'not writing gitmodules config file when it is not checked out' '
+	test_must_fail git -C super submodule--helper config submodule.submodule.url newurl &&
+	test_path_is_missing super/.gitmodules
+'
+
+test_expect_success 'initialising submodule when the gitmodules config is not checked out' '
+	test_must_fail git -C super config submodule.submodule.url &&
+	git -C super submodule init &&
+	git -C super config submodule.submodule.url >actual &&
+	echo "$PWD/submodule" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'updating submodule when the gitmodules config is not checked out' '
+	test_path_is_missing super/submodule/file &&
+	git -C super submodule update &&
+	test_cmp submodule/file super/submodule/file
+'
+
+ORIG_SUBMODULE=$(git -C submodule rev-parse HEAD)
+ORIG_UPSTREAM=$(git -C upstream rev-parse HEAD)
+ORIG_SUPER=$(git -C super rev-parse HEAD)
+
+test_expect_success 're-updating submodule when the gitmodules config is not checked out' '
+	test_when_finished "git -C submodule reset --hard $ORIG_SUBMODULE;
+			    git -C upstream reset --hard $ORIG_UPSTREAM;
+			    git -C super reset --hard $ORIG_SUPER;
+			    git -C upstream submodule update --remote;
+			    git -C super pull;
+			    git -C super submodule update --remote" &&
+	(cd submodule &&
+		echo file2 >file2 &&
+		git add file2 &&
+		test_tick &&
+		git commit -m "Add file2 to submodule"
+	) &&
+	(cd upstream &&
+		git submodule update --remote &&
+		git add submodule &&
+		test_tick &&
+		git commit -m "Update submodule"
+	) &&
+	git -C super pull &&
+	# The --for-status options reads the gitmodules config
+	git -C super submodule summary --for-status >actual &&
+	rev1=$(git -C submodule rev-parse --short HEAD) &&
+	rev2=$(git -C submodule rev-parse --short HEAD^) &&
+	cat >expect <<-EOF &&
+	* submodule ${rev1}...${rev2} (1):
+	  < Add file2 to submodule
+
+	EOF
+	test_cmp expect actual &&
+	# Test that the update actually succeeds
+	test_path_is_missing super/submodule/file2 &&
+	git -C super submodule update &&
+	test_cmp submodule/file2 super/submodule/file2 &&
+	git -C super status --short >output &&
+	test_must_be_empty output
+'
+
+test_expect_success 'not adding submodules when the gitmodules config is not checked out' '
+	git clone submodule new_submodule &&
+	test_must_fail git -C super submodule add ../new_submodule &&
+	test_path_is_missing .gitmodules
+'
+
+# This test checks that the previous "git submodule add" did not leave the
+# repository in a spurious state when it failed.
+test_expect_success 'init submodule still works even after the previous add failed' '
+	git -C super submodule init
+'
+
+test_done
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 7184113b9b..fa475d52fa 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -380,4 +380,20 @@ test_expect_success 'grep --recurse-submodules should pass the pattern type alon
 	fi
 '
 
+# Recursing down into nested submodules which do not have .gitmodules in their
+# working tree does not work yet. This is because config_from_gitmodules()
+# uses get_oid() and the latter is still not able to get objects from an
+# arbitrary repository (the nested submodule, in this case).
+test_expect_failure 'grep --recurse-submodules with submodules without .gitmodules in the working tree' '
+	test_when_finished "git -C submodule checkout .gitmodules" &&
+	rm submodule/.gitmodules &&
+	git grep --recurse-submodules -e "(.|.)[\d]" >actual &&
+	cat >expect <<-\EOF &&
+	a:(1|2)d(3|4)
+	submodule/a:(1|2)d(3|4)
+	submodule/sub/a:(1|2)d(3|4)
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.19.1

