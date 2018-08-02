Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FE2A1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 14:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387586AbeHBQTK (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 12:19:10 -0400
Received: from ao2.it ([92.243.12.208]:54928 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387576AbeHBQTK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 12:19:10 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1flDv9-0006i5-0G; Thu, 02 Aug 2018 15:45:39 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1flDwR-0002hR-C1; Thu, 02 Aug 2018 15:46:59 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [RFC PATCH v2 09/12] submodule: support reading .gitmodules even when it's not checked out
Date:   Thu,  2 Aug 2018 15:46:31 +0200
Message-Id: <20180802134634.10300-10-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802134634.10300-1-ao2@ao2.it>
References: <20180802134634.10300-1-ao2@ao2.it>
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

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 builtin/submodule--helper.c | 17 ++++++++++++++++-
 cache.h                     |  1 +
 submodule-config.c          | 16 ++++++++++++++--
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c388f4ee6f..616d5de0a9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2089,8 +2089,23 @@ static int module_config(int argc, const char **argv, const char *prefix)
 		return print_config_from_gitmodules(argv[1]);
 
 	/* Equivalent to ACTION_SET in builtin/config.c */
-	if (argc == 3)
+	if (argc == 3) {
+		struct object_id oid;
+
+		/*
+		 * If the .gitmodules file is not in the working tree but it
+		 * is in the current branch, stop, as writing new values and
+		 * staging them would blindly overwrite ALL the old content.
+		 *
+		 * This still makes it possible to create a brand new
+		 * .gitmodules when neither GITMODULES_FILE nor
+		 * GITMODULES_HEAD exist.
+		 */
+		if (!file_exists(GITMODULES_FILE) && get_oid(GITMODULES_HEAD, &oid) >= 0)
+			die(_("please make sure that the .gitmodules file in the current branch is checked out"));
+
 		return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
+	}
 
 	return 0;
 }
diff --git a/cache.h b/cache.h
index 8b447652a7..8f75cafbb6 100644
--- a/cache.h
+++ b/cache.h
@@ -424,6 +424,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
 #define GITMODULES_FILE ".gitmodules"
+#define GITMODULES_HEAD "HEAD:.gitmodules"
 #define GIT_NOTES_REF_ENVIRONMENT "GIT_NOTES_REF"
 #define GIT_NOTES_DEFAULT_REF "refs/notes/commits"
 #define GIT_NOTES_DISPLAY_REF_ENVIRONMENT "GIT_NOTES_DISPLAY_REF"
diff --git a/submodule-config.c b/submodule-config.c
index 702d40dd6b..cf08264220 100644
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
-- 
2.18.0

