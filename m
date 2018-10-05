Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 497A81F453
	for <e@80x24.org>; Fri,  5 Oct 2018 13:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeJEUE5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 16:04:57 -0400
Received: from mail.ao2.it ([92.243.12.208]:44968 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbeJEUE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 16:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=/1d8lk1wohi23BO5nA1zJ6BD5ib1uItAjuJeTHM2LbM=;
        b=LPOmQ7leY/F6u2qbkkivoXsxjS8gIK7lf1bcQrzvIHWBTXu9182/FkmmZjBZ18+54QiTY+A0ggM9hW8+mjKvi7pwao9uW/zPStBBxCyfHiYKc8foSS7PS8IjUx3PxzEGKznptcTOMjNi3HjJnxV+FRtlBqfVpJUq35+7ol6brgkNJPsiVg6Q0Uc6+IBpVW6a/td5EobfzqeoZDcLj38RWpnApWL2S41N5DpmTwH24VzUdt01TQS21azUN5nVLYDYzZfMqK8d3QkwnCHbtZ71GhNbmanuZLQ3iZnqmw4i9APshO115x1Sy4VDeC1qsbFPXcz8/URj4ks88l/Cwz7z9g==;
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1g8PlU-0003BN-4S; Fri, 05 Oct 2018 15:03:32 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1g8Pnx-00049G-QL; Fri, 05 Oct 2018 15:06:05 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v6 08/10] submodule: add a helper to check if it is safe to write to .gitmodules
Date:   Fri,  5 Oct 2018 15:05:59 +0200
Message-Id: <20181005130601.15879-9-ao2@ao2.it>
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
index e1bdca8f0b..28f3ccca6d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2127,6 +2127,28 @@ static int check_name(int argc, const char **argv, const char *prefix)
 
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
@@ -2135,7 +2157,7 @@ static int module_config(int argc, const char **argv, const char *prefix)
 	if (argc == 3)
 		return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
 
-	die("submodule--helper config takes 1 or 2 arguments: name [value]");
+	usage_with_options(git_submodule_helper_usage, module_config_options);
 }
 
 #define SUPPORT_SUPER_PREFIX (1<<0)
diff --git a/cache.h b/cache.h
index d508f3d4f8..2d495fc800 100644
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
index 3b23e76e55..bd2506c5ba 100644
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
index e452919aa4..7a22f71cb9 100644
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
2.19.0

