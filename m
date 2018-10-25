Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3A21F453
	for <e@80x24.org>; Thu, 25 Oct 2018 16:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeJZAwF (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 20:52:05 -0400
Received: from mail.ao2.it ([92.243.12.208]:44375 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727319AbeJZAwF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 20:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=AzEqVRV7gUkUhADgrwaV/i0GUUZRkCw+QqXxghFOx7g=;
        b=lwEfZISU8RzDTrkfQrMk4TEwkA8YvFg2K/drvoD0PeoZud97AZmUbI7X/6bBKdjI7y53+K+p4nyp/Yy3B/TlYyo2sMCryWKlw+umUuByEPBzoYp3SE5Bson9n4xKJJNiIUB5agAhwRssK+RJtKvkmGeiTA006GCpZzNomrWbLKL8FoKqh1XSskyPPrEpZYnE+Uep8HGrysG5wrGXGJ6khJ5fGKftU0TeNxdnhX86AhxZziL3tLFcSvt2vOXzaUv6lcp13i58Vvw7jJq/Lxc44xqkLLYwpjDTsFlowLaX6BCOSia2uvJR9pqBMFIoXBUVXWpEtQQtFKyUL4ErzdY1pg==;
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1gFiKo-0003L4-4o; Thu, 25 Oct 2018 18:18:10 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1gFiL5-0004VP-Kk; Thu, 25 Oct 2018 18:18:27 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v7 08/10] submodule: add a helper to check if it is safe to write to .gitmodules
Date:   Thu, 25 Oct 2018 18:18:11 +0200
Message-Id: <20181025161813.17252-9-ao2@ao2.it>
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

Introduce a helper function named is_writing_gitmodules_ok() to verify
that the .gitmodules file is safe to write.

The function name follows the scheme of is_staging_gitmodules_ok().

The two symbolic constants GITMODULES_INDEX and GITMODULES_HEAD are used
to get help from the C preprocessor in preventing typos, especially for
future users.

This is in preparation for a future change which teaches git how to read
.gitmodules from the index or from the current branch if the file is not
available in the working tree.

The rationale behind the check is that writing to .gitmodules requires
the file to be present in the working tree, unless a brand new
.gitmodules is being created (in which case the .gitmodules file would
not exist at all: neither in the working tree nor in the index or in the
current branch).

Expose the functionality also via a "submodule-helper config
--check-writeable" command, as git scripts may want to perform the check
before modifying submodules configuration.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 builtin/submodule--helper.c | 24 +++++++++++++++++++++++-
 cache.h                     |  2 ++
 submodule.c                 | 18 ++++++++++++++++++
 submodule.h                 |  1 +
 t/t7411-submodule-config.sh | 31 +++++++++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9af6626e32..b272a78801 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2128,6 +2128,28 @@ static int check_name(int argc, const char **argv, const char *prefix)
 
 static int module_config(int argc, const char **argv, const char *prefix)
 {
+	enum {
+		CHECK_WRITEABLE = 1
+	} command = 0;
+
+	struct option module_config_options[] = {
+		OPT_CMDMODE(0, "check-writeable", &command,
+			    N_("check if it is safe to write to the .gitmodules file"),
+			    CHECK_WRITEABLE),
+		OPT_END()
+	};
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper config name [value]"),
+		N_("git submodule--helper config --check-writeable"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_config_options,
+			     git_submodule_helper_usage, PARSE_OPT_KEEP_ARGV0);
+
+	if (argc == 1 && command == CHECK_WRITEABLE)
+		return is_writing_gitmodules_ok() ? 0 : -1;
+
 	/* Equivalent to ACTION_GET in builtin/config.c */
 	if (argc == 2)
 		return print_config_from_gitmodules(the_repository, argv[1]);
@@ -2136,7 +2158,7 @@ static int module_config(int argc, const char **argv, const char *prefix)
 	if (argc == 3)
 		return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
 
-	die("submodule--helper config takes 1 or 2 arguments: name [value]");
+	usage_with_options(git_submodule_helper_usage, module_config_options);
 }
 
 #define SUPPORT_SUPER_PREFIX (1<<0)
diff --git a/cache.h b/cache.h
index 59c8a93046..4c1f827c54 100644
--- a/cache.h
+++ b/cache.h
@@ -486,6 +486,8 @@ static inline enum object_type object_type(unsigned int mode)
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
 #define GITMODULES_FILE ".gitmodules"
+#define GITMODULES_INDEX ":.gitmodules"
+#define GITMODULES_HEAD "HEAD:.gitmodules"
 #define GIT_NOTES_REF_ENVIRONMENT "GIT_NOTES_REF"
 #define GIT_NOTES_DEFAULT_REF "refs/notes/commits"
 #define GIT_NOTES_DISPLAY_REF_ENVIRONMENT "GIT_NOTES_DISPLAY_REF"
diff --git a/submodule.c b/submodule.c
index 24a49eae61..9516685478 100644
--- a/submodule.c
+++ b/submodule.c
@@ -51,6 +51,24 @@ int is_gitmodules_unmerged(const struct index_state *istate)
 	return 0;
 }
 
+/*
+ * Check if the .gitmodules file is safe to write.
+ *
+ * Writing to the .gitmodules file requires that the file exists in the
+ * working tree or, if it doesn't, that a brand new .gitmodules file is going
+ * to be created (i.e. it's neither in the index nor in the current branch).
+ *
+ * It is not safe to write to .gitmodules if it's not in the working tree but
+ * it is in the index or in the current branch, because writing new values
+ * (and staging them) would blindly overwrite ALL the old content.
+ */
+int is_writing_gitmodules_ok(void)
+{
+	struct object_id oid;
+	return file_exists(GITMODULES_FILE) ||
+		(get_oid(GITMODULES_INDEX, &oid) < 0 && get_oid(GITMODULES_HEAD, &oid) < 0);
+}
+
 /*
  * Check if the .gitmodules file has unstaged modifications.  This must be
  * checked before allowing modifications to the .gitmodules file with the
diff --git a/submodule.h b/submodule.h
index 4826601ff2..ea6e115f16 100644
--- a/submodule.h
+++ b/submodule.h
@@ -40,6 +40,7 @@ struct submodule_update_strategy {
 #define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
 
 int is_gitmodules_unmerged(const struct index_state *istate);
+int is_writing_gitmodules_ok(void);
 int is_staging_gitmodules_ok(struct index_state *istate);
 int update_path_in_gitmodules(const char *oldpath, const char *newpath);
 int remove_path_from_gitmodules(const char *path);
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 791245f18d..45953f9300 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -161,4 +161,35 @@ test_expect_success 'overwriting unstaged submodules config with "submodule--hel
 	)
 '
 
+test_expect_success 'writeable .gitmodules when it is in the working tree' '
+	git -C super submodule--helper config --check-writeable
+'
+
+test_expect_success 'writeable .gitmodules when it is nowhere in the repository' '
+	ORIG=$(git -C super rev-parse HEAD) &&
+	test_when_finished "git -C super reset --hard $ORIG" &&
+	(cd super &&
+		git rm .gitmodules &&
+		git commit -m "remove .gitmodules from the current branch" &&
+		git submodule--helper config --check-writeable
+	)
+'
+
+test_expect_success 'non-writeable .gitmodules when it is in the index but not in the working tree' '
+	test_when_finished "git -C super checkout .gitmodules" &&
+	(cd super &&
+		rm -f .gitmodules &&
+		test_must_fail git submodule--helper config --check-writeable
+	)
+'
+
+test_expect_success 'non-writeable .gitmodules when it is in the current branch but not in the index' '
+	ORIG=$(git -C super rev-parse HEAD) &&
+	test_when_finished "git -C super reset --hard $ORIG" &&
+	(cd super &&
+		git rm .gitmodules &&
+		test_must_fail git submodule--helper config --check-writeable
+	)
+'
+
 test_done
-- 
2.19.1

