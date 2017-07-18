Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A33120387
	for <e@80x24.org>; Tue, 18 Jul 2017 19:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbdGRTFz (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 15:05:55 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34815 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbdGRTFw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 15:05:52 -0400
Received: by mail-pg0-f48.google.com with SMTP id 123so17589848pgj.1
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JcqQUxaCwg2JNdQDmWrUtEq3Vnh7mLvgjkMOst0rCxo=;
        b=VsEYPXwZTiFsIt6chfS/fKxc7FDhgi4BjrydPw5khkb8C3+NakYBI+KhqoXuYeYeEe
         vZwt0alv2+nVFcXnSMN7bH0Sfje83/xgTFHAitVzPN6o0q8xYfeihLMxM4Wf6AqdmgeU
         wrCE3IQqxCp82U1BJoWNtnKHbUkJjAhLzieux5tUROQuXSzddG1bIjFS2vyjO1kIoTqX
         ouG+TbfgENRpzPqgGRPZhdNRc9XMzTF4Txqzpu6hsMqCAs1HywjAmei7eVlrd9vgtD2p
         iJZQZmVL7G6iQuEzvxbSal4OvUPEpWzCADM+Of6+qMj6HIbH0YncoQK6YgWzsedsHRvl
         944w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JcqQUxaCwg2JNdQDmWrUtEq3Vnh7mLvgjkMOst0rCxo=;
        b=gPpgX1mPHsJWxJ7awUMUHQ5sJW6t9+AzWFE0LpoXeE6JYc8q+iWxomvacgPNVRtuYa
         FaHJ2m3uzIqUVVw+kt5KvpxVPsJk83TxJIYGxhCzoljj1PvvM9lM0zdNKaQfH7PVEH91
         qisGaYFEAr9d5EsQnxMtdxi8aCthOLvwD6zzGT4zHTnMqZz5oMfKNDZglKXSU9VbpgSg
         CP5fSoGi8p4e448cStyTkRl7kvfv5p4dPJEXqtLsaDjok4mVlEfqywUysVJIpBszS5sv
         3t6c4o0gi1P0FzySmSAHe8d0ds9JaFvgkDS9wiPy+e5YYHtyRK8MK2ocgd3Fm2waBShy
         UfHA==
X-Gm-Message-State: AIVw111BMLBrIrUlOXeZVsfKIabCn0wxLNp9KxeYL8NpJDY9Um5cglBC
        wzHe5wANnVPs2WYkt++9Uw==
X-Received: by 10.84.209.165 with SMTP id y34mr3346313plh.200.1500404751385;
        Tue, 18 Jul 2017 12:05:51 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t11sm6894649pfi.66.2017.07.18.12.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Jul 2017 12:05:50 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 08/10] submodule: check for unmerged .gitmodules outside of config parsing
Date:   Tue, 18 Jul 2017 12:05:25 -0700
Message-Id: <20170718190527.78049-9-bmwill@google.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c-goog
In-Reply-To: <20170718190527.78049-1-bmwill@google.com>
References: <20170714222826.81148-1-bmwill@google.com>
 <20170718190527.78049-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add 'is_gitmodules_unmerged()' function which can be used to determine
in the '.gitmodules' file is unmerged based on the passed in index
instead of relying on a global variable which is set during the
submodule-config parsing.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 47 +++++++++++++++++++++++------------------------
 submodule.h |  1 +
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/submodule.c b/submodule.c
index 46ec04d7c..a5f825e37 100644
--- a/submodule.c
+++ b/submodule.c
@@ -27,14 +27,25 @@ static struct oid_array ref_tips_before_fetch;
 static struct oid_array ref_tips_after_fetch;
 
 /*
- * The following flag is set if the .gitmodules file is unmerged. We then
- * disable recursion for all submodules where .git/config doesn't have a
- * matching config entry because we can't guess what might be configured in
- * .gitmodules unless the user resolves the conflict. When a command line
- * option is given (which always overrides configuration) this flag will be
- * ignored.
+ * Check if the .gitmodules file is unmerged. Parsing of the .gitmodules file
+ * will be disabled because we can't guess what might be configured in
+ * .gitmodules unless the user resolves the conflict.
  */
-static int gitmodules_is_unmerged;
+int is_gitmodules_unmerged(const struct index_state *istate)
+{
+	int pos = index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
+	if (pos < 0) { /* .gitmodules not found or isn't merged */
+		pos = -1 - pos;
+		if (istate->cache_nr > pos) {  /* there is a .gitmodules */
+			const struct cache_entry *ce = istate->cache[pos];
+			if (ce_namelen(ce) == strlen(GITMODULES_FILE) &&
+			    !strcmp(ce->name, GITMODULES_FILE))
+				return 1;
+		}
+	}
+
+	return 0;
+}
 
 /*
  * Check if the .gitmodules file has unstaged modifications.  This must be
@@ -71,7 +82,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	if (!file_exists(".gitmodules")) /* Do nothing without .gitmodules */
 		return -1;
 
-	if (gitmodules_is_unmerged)
+	if (is_gitmodules_unmerged(&the_index))
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
 	submodule = submodule_from_path(null_sha1, oldpath);
@@ -105,7 +116,7 @@ int remove_path_from_gitmodules(const char *path)
 	if (!file_exists(".gitmodules")) /* Do nothing without .gitmodules */
 		return -1;
 
-	if (gitmodules_is_unmerged)
+	if (is_gitmodules_unmerged(&the_index))
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
 	submodule = submodule_from_path(null_sha1, path);
@@ -156,7 +167,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 	if (submodule) {
 		if (submodule->ignore)
 			handle_ignore_submodules_arg(diffopt, submodule->ignore);
-		else if (gitmodules_is_unmerged)
+		else if (is_gitmodules_unmerged(&the_index))
 			DIFF_OPT_SET(diffopt, IGNORE_SUBMODULES);
 	}
 }
@@ -224,23 +235,12 @@ void gitmodules_config(void)
 	const char *work_tree = get_git_work_tree();
 	if (work_tree) {
 		struct strbuf gitmodules_path = STRBUF_INIT;
-		int pos;
 		strbuf_addstr(&gitmodules_path, work_tree);
 		strbuf_addstr(&gitmodules_path, "/.gitmodules");
 		if (read_cache() < 0)
 			die("index file corrupt");
-		pos = cache_name_pos(".gitmodules", 11);
-		if (pos < 0) { /* .gitmodules not found or isn't merged */
-			pos = -1 - pos;
-			if (active_nr > pos) {  /* there is a .gitmodules */
-				const struct cache_entry *ce = active_cache[pos];
-				if (ce_namelen(ce) == 11 &&
-				    !memcmp(ce->name, ".gitmodules", 11))
-					gitmodules_is_unmerged = 1;
-			}
-		}
 
-		if (!gitmodules_is_unmerged)
+		if (!is_gitmodules_unmerged(&the_index))
 			git_config_from_file(git_modules_config,
 				gitmodules_path.buf, NULL);
 		strbuf_release(&gitmodules_path);
@@ -1198,8 +1198,7 @@ static int get_next_submodule(struct child_process *cp,
 					default_argv = "on-demand";
 				}
 			} else {
-				if ((spf->default_option == RECURSE_SUBMODULES_OFF) ||
-				    gitmodules_is_unmerged)
+				if (spf->default_option == RECURSE_SUBMODULES_OFF)
 					continue;
 				if (spf->default_option == RECURSE_SUBMODULES_ON_DEMAND) {
 					if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
diff --git a/submodule.h b/submodule.h
index b14660585..8022faa59 100644
--- a/submodule.h
+++ b/submodule.h
@@ -33,6 +33,7 @@ struct submodule_update_strategy {
 };
 #define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
 
+extern int is_gitmodules_unmerged(const struct index_state *istate);
 extern int is_staging_gitmodules_ok(const struct index_state *istate);
 extern int update_path_in_gitmodules(const char *oldpath, const char *newpath);
 extern int remove_path_from_gitmodules(const char *path);
-- 
2.13.2.932.g7449e964c-goog

