Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 561721F404
	for <e@80x24.org>; Thu, 12 Apr 2018 22:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753042AbeDLW5I (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 18:57:08 -0400
Received: from ao2.it ([92.243.12.208]:51115 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752379AbeDLW5I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 18:57:08 -0400
X-Greylist: delayed 2154 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Apr 2018 18:57:07 EDT
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1f6kZd-0008Uw-CT; Fri, 13 Apr 2018 00:20:09 +0200
Received: from ao2 by jcn with local (Exim 4.90_1)
        (envelope-from <ao2@ao2.it>)
        id 1f6kad-0001VE-9v; Fri, 13 Apr 2018 00:21:11 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Richard Hartmann <richih.mailinglist@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [RFC 03/10] submodule: use the 'submodules_file' variable in output messages
Date:   Fri, 13 Apr 2018 00:20:40 +0200
Message-Id: <20180412222047.5716-4-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180412222047.5716-1-ao2@ao2.it>
References: <20180412222047.5716-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The gitmodules file path can be customized by setting the
'core.submodulesFile' config option.

Use the 'submodules_file' variable instead of the hardcoded
'.gitmodules' in output messages, to reflect the actual path of the
gitmodules file.

NOTE: the default git configuration has to be initialized in
'builtin/submodule--helper.c' to make the actual value of
'submodules_file', overridden by 'core.submodulesFile', available to the
helper command.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 builtin/mv.c                |  3 ++-
 builtin/rm.c                |  3 ++-
 builtin/submodule--helper.c | 18 ++++++++++--------
 submodule-config.c          |  4 ++--
 submodule.c                 | 14 +++++++-------
 5 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 6d141f7a5..ec8f139c4 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -82,7 +82,8 @@ static void prepare_move_submodule(const char *src, int first,
 	if (!S_ISGITLINK(active_cache[first]->ce_mode))
 		die(_("Directory %s is in index and no submodule?"), src);
 	if (!is_staging_gitmodules_ok(&the_index))
-		die(_("Please stage your changes to .gitmodules or stash them to proceed"));
+		die(_("Please stage your changes to %s or stash them to proceed"),
+		    submodules_file);
 	strbuf_addf(&submodule_dotgit, "%s/.git", src);
 	*submodule_gitfile = read_gitfile(submodule_dotgit.buf);
 	if (*submodule_gitfile)
diff --git a/builtin/rm.c b/builtin/rm.c
index 5b6fc7ee8..6fd015d86 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -286,7 +286,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		list.entry[list.nr].is_submodule = S_ISGITLINK(ce->ce_mode);
 		if (list.entry[list.nr++].is_submodule &&
 		    !is_staging_gitmodules_ok(&the_index))
-			die (_("Please stage your changes to .gitmodules or stash them to proceed"));
+			die (_("Please stage your changes to %s or stash them to proceed"),
+			     submodules_file);
 	}
 
 	if (pathspec.nr) {
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a404df3ea..72b95d27b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -458,8 +458,8 @@ static void init_submodule(const char *path, const char *prefix,
 	sub = submodule_from_path(&null_oid, path);
 
 	if (!sub)
-		die(_("No url found for submodule path '%s' in .gitmodules"),
-			displaypath);
+		die(_("No url found for submodule path '%s' in %s"),
+			displaypath, submodules_file);
 
 	/*
 	 * NEEDSWORK: In a multi-working-tree world, this needs to be
@@ -481,8 +481,8 @@ static void init_submodule(const char *path, const char *prefix,
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
 	if (git_config_get_string(sb.buf, &url)) {
 		if (!sub->url)
-			die(_("No url found for submodule path '%s' in .gitmodules"),
-				displaypath);
+			die(_("No url found for submodule path '%s' in %s"),
+				displaypath, submodules_file);
 
 		url = xstrdup(sub->url);
 
@@ -623,8 +623,8 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	int diff_files_result;
 
 	if (!submodule_from_path(&null_oid, path))
-		die(_("no submodule mapping found in .gitmodules for path '%s'"),
-		      path);
+		die(_("no submodule mapping found in %s for path '%s'"),
+		      submodules_file, path);
 
 	displaypath = get_submodule_displaypath(path, prefix);
 
@@ -749,8 +749,8 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	sub = submodule_from_path(&null_oid, argv[1]);
 
 	if (!sub)
-		die(_("no submodule mapping found in .gitmodules for path '%s'"),
-		    argv[1]);
+		die(_("no submodule mapping found in %s for path '%s'"),
+		    submodules_file, argv[1]);
 
 	printf("%s\n", sub->name);
 
@@ -1855,6 +1855,8 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 	if (argc < 2 || !strcmp(argv[1], "-h"))
 		usage("git submodule--helper <command>");
 
+	git_config(git_default_config, NULL);
+
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
 		if (!strcmp(argv[1], commands[i].cmd)) {
 			if (get_super_prefix() &&
diff --git a/submodule-config.c b/submodule-config.c
index 8a3396ade..620d522ee 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -347,9 +347,9 @@ static void warn_multiple_config(const unsigned char *treeish_name,
 	const char *commit_string = "WORKTREE";
 	if (treeish_name)
 		commit_string = sha1_to_hex(treeish_name);
-	warning("%s:.gitmodules, multiple configurations found for "
+	warning("%s:%s, multiple configurations found for "
 			"'submodule.%s.%s'. Skipping second one!",
-			commit_string, name, option);
+			commit_string, submodules_file, name, option);
 }
 
 struct parse_config_parameter {
diff --git a/submodule.c b/submodule.c
index 2afbdb644..97213b549 100644
--- a/submodule.c
+++ b/submodule.c
@@ -94,11 +94,11 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 		return -1;
 
 	if (is_gitmodules_unmerged(&the_index))
-		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
+		die(_("Cannot change unmerged %s, resolve merge conflicts first"), submodules_file);
 
 	submodule = submodule_from_path(&null_oid, oldpath);
 	if (!submodule || !submodule->name) {
-		warning(_("Could not find section in .gitmodules where path=%s"), oldpath);
+		warning(_("Could not find section in %s where path=%s"), submodules_file, oldpath);
 		return -1;
 	}
 	strbuf_addstr(&entry, "submodule.");
@@ -106,7 +106,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	strbuf_addstr(&entry, ".path");
 	if (git_config_set_in_file_gently(submodules_file, entry.buf, newpath) < 0) {
 		/* Maybe the user already did that, don't error out here */
-		warning(_("Could not update .gitmodules entry %s"), entry.buf);
+		warning(_("Could not update %s entry %s"), submodules_file, entry.buf);
 		strbuf_release(&entry);
 		return -1;
 	}
@@ -128,18 +128,18 @@ int remove_path_from_gitmodules(const char *path)
 		return -1;
 
 	if (is_gitmodules_unmerged(&the_index))
-		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
+		die(_("Cannot change unmerged %s, resolve merge conflicts first"), submodules_file);
 
 	submodule = submodule_from_path(&null_oid, path);
 	if (!submodule || !submodule->name) {
-		warning(_("Could not find section in .gitmodules where path=%s"), path);
+		warning(_("Could not find section in %s where path=%s"), submodules_file, path);
 		return -1;
 	}
 	strbuf_addstr(&sect, "submodule.");
 	strbuf_addstr(&sect, submodule->name);
 	if (git_config_rename_section_in_file(submodules_file, sect.buf, NULL) < 0) {
 		/* Maybe the user already did that, don't error out here */
-		warning(_("Could not remove .gitmodules entry for %s"), path);
+		warning(_("Could not remove %s entry for %s"), submodules_file, path);
 		strbuf_release(&sect);
 		return -1;
 	}
@@ -150,7 +150,7 @@ int remove_path_from_gitmodules(const char *path)
 void stage_updated_gitmodules(struct index_state *istate)
 {
 	if (add_file_to_index(istate, submodules_file, 0))
-		die(_("staging updated .gitmodules failed"));
+		die(_("staging updated %s failed"), submodules_file);
 }
 
 static int add_submodule_odb(const char *path)
-- 
2.17.0

