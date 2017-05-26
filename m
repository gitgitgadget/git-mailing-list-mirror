Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3024B1FA14
	for <e@80x24.org>; Fri, 26 May 2017 19:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944674AbdEZTLl (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 15:11:41 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36715 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935911AbdEZTKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 15:10:25 -0400
Received: by mail-pf0-f182.google.com with SMTP id m17so19302309pfg.3
        for <git@vger.kernel.org>; Fri, 26 May 2017 12:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lpez2jKzJMG+bo1bOguGrZw1s90VVhwxrfG7dFeyqug=;
        b=sb7JqX1Qh19STphRsIUff91h8Td+Gyzv+j5TmiTk/PKgWcAhMDEWcfQkejfsf1P7rJ
         pyNxdXNC/79dGM5a5woRHGpn8mJfiy2EbQWBhDr9KkSyDi6LTjCIaFkgCmPUYuGBKbvZ
         +fB+foMK5KrG7jIutZlAD2xEs6ImCwS4zWV+GyoO0X0shaMeuwx6eIt7NjkrLKpxpWcZ
         uVtzMnCIHXvgwmm9BaeBizXiqsxmKSvY4M9m3hgCe5EOsGeZ37mHSiIUR/E/5jG05hXn
         aRQnz+7MmfuXc+VR9fRgUCbSnZh/Tg93v1HVSyB32fAWPCm0jAoLi/ruPkrJ5d5D1MsG
         8tWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lpez2jKzJMG+bo1bOguGrZw1s90VVhwxrfG7dFeyqug=;
        b=ek+UHoIaD1gj5eu4+kIC+sQEf9dXZmSZ8mrL8Q8uZDab/RGu+/BF4SB1mljEnsytVW
         a1lj3fQSYuybBYuiWhOi0eB0Q0h2xoHoWKV1eNAybb5fhBvybu3I4UsH6QbOa4jXSiu2
         ymWDCM5gF2f266Pbkh+7h2OKGXTBPxcUAJZ9QPltsaXqB1UndTtpf0M+6sYJFRwCiD9I
         T19ZTLLTDiFT5IUDbg/5h0Aa1e1iGv9KQGOqUFddMTSpvGYp0/0JVrhqsKQ54DJd26ZU
         V4vxYo/3BONjP0AfMAupFF6d3DSikj6MB4NkYo2x5G1Y2gJRFOyt1ibLRAd+1sAH5Q06
         SvJQ==
X-Gm-Message-State: AODbwcB9JfVz0qeYM01ekXdI+xZYFpx61a2mgmqnB8LBGRDcHEyaPz6Y
        rVyeU4jxMM0afLYNfpgauQ==
X-Received: by 10.84.133.68 with SMTP id 62mr59285967plf.63.1495825824665;
        Fri, 26 May 2017 12:10:24 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:818a:1f3a:57c6:8d29])
        by smtp.gmail.com with ESMTPSA id y2sm3378515pfk.1.2017.05.26.12.10.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 May 2017 12:10:24 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/8] reset/checkout/read-tree: unify config callback for submodule recursion
Date:   Fri, 26 May 2017 12:10:12 -0700
Message-Id: <20170526191017.19155-4-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.g582985b1e4
In-Reply-To: <20170526191017.19155-1-sbeller@google.com>
References: <20170526191017.19155-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The callback function is essentially duplicated 3 times. Remove all
of them and offer a new callback function, that lives in submodule.c

By putting the callback function there, we no longer need the function
'set_config_update_recurse_submodules', nor duplicate the global variable
in each builtin as well as submodule.c

In the three builtins we have different 2 ways how to load the .gitmodules
and config file, which are slightly different. git-checkout has to load
the submodule config all the time due to 23b4c7bcc5 (checkout: Use
submodule.*.ignore settings from .git/config and .gitmodules, 2010-08-28)

git-reset and git-read-tree do not respect these diff settings, so loading
the submodule configuration is optional. Also put that into submodule.c
for code deduplication.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/checkout.c  | 27 +--------------------------
 builtin/read-tree.c | 28 +++-------------------------
 builtin/reset.c     | 27 ++-------------------------
 submodule.c         | 33 +++++++++++++++++++++++++++------
 submodule.h         |  6 +++++-
 5 files changed, 38 insertions(+), 83 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0fd57672cc..acff6039d6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -21,31 +21,12 @@
 #include "submodule-config.h"
 #include "submodule.h"
 
-static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
-
 static const char * const checkout_usage[] = {
 	N_("git checkout [<options>] <branch>"),
 	N_("git checkout [<options>] [<branch>] -- <file>..."),
 	NULL,
 };
 
-static int option_parse_recurse_submodules(const struct option *opt,
-					   const char *arg, int unset)
-{
-	if (unset) {
-		recurse_submodules = RECURSE_SUBMODULES_OFF;
-		return 0;
-	}
-	if (arg)
-		recurse_submodules =
-			parse_update_recurse_submodules_arg(opt->long_name,
-							    arg);
-	else
-		recurse_submodules = RECURSE_SUBMODULES_ON;
-
-	return 0;
-}
-
 struct checkout_opts {
 	int patch_mode;
 	int quiet;
@@ -1183,7 +1164,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			 N_("do not check if another worktree is holding the given ref")),
 		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
 			    "checkout", "control recursive updating of submodules",
-			    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
+			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
 		OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
 		OPT_END(),
 	};
@@ -1214,12 +1195,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
 	}
 
-	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
-		git_config(submodule_config, NULL);
-		if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
-			set_config_update_recurse_submodules(recurse_submodules);
-	}
-
 	if ((!!opts.new_branch + !!opts.new_branch_force + !!opts.new_orphan_branch) > 1)
 		die(_("-b, -B and --orphan are mutually exclusive"));
 
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 2a1b8a530e..8a889ef4c3 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -21,7 +21,6 @@
 static int nr_trees;
 static int read_empty;
 static struct tree *trees[MAX_UNPACK_TREES];
-static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 
 static int list_tree(unsigned char *sha1)
 {
@@ -99,23 +98,6 @@ static int debug_merge(const struct cache_entry * const *stages,
 	return 0;
 }
 
-static int option_parse_recurse_submodules(const struct option *opt,
-					   const char *arg, int unset)
-{
-	if (unset) {
-		recurse_submodules = RECURSE_SUBMODULES_OFF;
-		return 0;
-	}
-	if (arg)
-		recurse_submodules =
-			parse_update_recurse_submodules_arg(opt->long_name,
-							    arg);
-	else
-		recurse_submodules = RECURSE_SUBMODULES_ON;
-
-	return 0;
-}
-
 static struct lock_file lock_file;
 
 int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
@@ -159,7 +141,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			 N_("debug unpack-trees")),
 		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
 			    "checkout", "control recursive updating of submodules",
-			    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
+			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
 		OPT_END()
 	};
 
@@ -173,13 +155,9 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	argc = parse_options(argc, argv, unused_prefix, read_tree_options,
 			     read_tree_usage, 0);
 
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+	load_submodule_cache();
 
-	if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT) {
-		gitmodules_config();
-		git_config(submodule_config, NULL);
-		set_config_update_recurse_submodules(RECURSE_SUBMODULES_ON);
-	}
+	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
 	prefix_set = opts.prefix ? 1 : 0;
 	if (1 < opts.merge + opts.reset + prefix_set)
diff --git a/builtin/reset.c b/builtin/reset.c
index 1e5f85b1fb..6f89dc5494 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -24,25 +24,6 @@
 #include "submodule.h"
 #include "submodule-config.h"
 
-static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
-
-static int option_parse_recurse_submodules(const struct option *opt,
-					   const char *arg, int unset)
-{
-	if (unset) {
-		recurse_submodules = RECURSE_SUBMODULES_OFF;
-		return 0;
-	}
-	if (arg)
-		recurse_submodules =
-			parse_update_recurse_submodules_arg(opt->long_name,
-							    arg);
-	else
-		recurse_submodules = RECURSE_SUBMODULES_ON;
-
-	return 0;
-}
-
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
 	N_("git reset [-q] [<tree-ish>] [--] <paths>..."),
@@ -306,7 +287,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				N_("reset HEAD but keep local changes"), KEEP),
 		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
 			    "reset", "control recursive updating of submodules",
-			    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
+			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
 		OPT_BOOL('N', "intent-to-add", &intent_to_add,
 				N_("record only the fact that removed paths will be added later")),
@@ -319,11 +300,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 						PARSE_OPT_KEEP_DASHDASH);
 	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
 
-	if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT) {
-		gitmodules_config();
-		git_config(submodule_config, NULL);
-		set_config_update_recurse_submodules(RECURSE_SUBMODULES_ON);
-	}
+	load_submodule_cache();
 
 	unborn = !strcmp(rev, "HEAD") && get_sha1("HEAD", oid.hash);
 	if (unborn) {
diff --git a/submodule.c b/submodule.c
index 54825100b2..c9e764b519 100644
--- a/submodule.c
+++ b/submodule.c
@@ -18,7 +18,7 @@
 #include "worktree.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
-static int config_update_recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
 static int parallel_jobs = 1;
 static struct string_list changed_submodule_paths = STRING_LIST_INIT_DUP;
 static int initialized_fetch_ref_tips;
@@ -169,6 +169,32 @@ int submodule_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
+						     const char *arg, int unset)
+{
+	if (unset) {
+		config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
+		return 0;
+	}
+	if (arg)
+		config_update_recurse_submodules =
+			parse_update_recurse_submodules_arg(opt->long_name,
+							    arg);
+	else
+		config_update_recurse_submodules = RECURSE_SUBMODULES_ON;
+
+	return 0;
+}
+
+void load_submodule_cache(void)
+{
+	if (config_update_recurse_submodules == RECURSE_SUBMODULES_OFF)
+		return;
+
+	gitmodules_config();
+	git_config(submodule_config, NULL);
+}
+
 void gitmodules_config(void)
 {
 	const char *work_tree = get_git_work_tree();
@@ -596,11 +622,6 @@ void set_config_fetch_recurse_submodules(int value)
 	config_fetch_recurse_submodules = value;
 }
 
-void set_config_update_recurse_submodules(int value)
-{
-	config_update_recurse_submodules = value;
-}
-
 int should_update_submodules(void)
 {
 	return config_update_recurse_submodules == RECURSE_SUBMODULES_ON;
diff --git a/submodule.h b/submodule.h
index 1277480add..b13f120f76 100644
--- a/submodule.h
+++ b/submodule.h
@@ -39,6 +39,11 @@ extern void stage_updated_gitmodules(void);
 extern void set_diffopt_flags_from_submodule_config(struct diff_options *,
 		const char *path);
 extern int submodule_config(const char *var, const char *value, void *cb);
+
+struct option;
+int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
+						     const char *arg, int unset);
+void load_submodule_cache(void);
 extern void gitmodules_config(void);
 extern void gitmodules_config_sha1(const unsigned char *commit_sha1);
 extern int is_submodule_initialized(const char *path);
@@ -65,7 +70,6 @@ extern void show_submodule_inline_diff(FILE *f, const char *path,
 		const char *del, const char *add, const char *reset,
 		const struct diff_options *opt);
 extern void set_config_fetch_recurse_submodules(int value);
-extern void set_config_update_recurse_submodules(int value);
 /* Check if we want to update any submodule.*/
 extern int should_update_submodules(void);
 /*
-- 
2.13.0.17.g582985b1e4

