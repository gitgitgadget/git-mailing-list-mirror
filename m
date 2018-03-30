Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD30E1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 13:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbeC3NxS (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 09:53:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:48676 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750794AbeC3NxR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 09:53:17 -0400
Received: (qmail 11143 invoked by uid 109); 30 Mar 2018 13:53:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 13:53:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27760 invoked by uid 111); 30 Mar 2018 13:54:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 09:54:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 09:53:15 -0400
Date:   Fri, 30 Mar 2018 09:53:15 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] builtin/config.c: prefer `--type=bool` over `--bool`,
 etc.
Message-ID: <20180330135315.GE29568@sigill.intra.peff.net>
References: <20180328234719.595-1-me@ttaylorr.com>
 <20180329221122.GL2939@sigill.intra.peff.net>
 <20180330052719.GA6628@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180330052719.GA6628@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 01:27:19AM -0400, Taylor Blau wrote:

> > If you really want to go all-out, I think the ACTION flags could use the
> > same cleanup. We treat them as bitflags, and then issue an error when
> > you set more than one, which is just silly.
> 
> Agreed, and I think that this is a good candidate for a future patch.
> Thoughts? :-).

I actually worked this up for fun, though I had second thoughts while
writing the commit message.

Besides the cleanup, my primary motivation was following last-one-wins
rules as we often do elsewhere. But actually, last-one-wins applies only
to a _single_ option, not necessarily unrelated ones. Many other
multi-action commands actually have a series of separate boolean flags,
and then complain when more than one of the flags is set.

So maybe it's not such a good idea for the actions (I do still think
it's the right path for the types).

For reference, here's the patch I wrote:

 builtin/config.c | 137 +++++++++++++++++++++++++----------------------
 1 file changed, 72 insertions(+), 65 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 01169dd628..5581f48ac8 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -25,35 +25,36 @@ static char term = '\n';
 
 static int use_global_config, use_system_config, use_local_config;
 static struct git_config_source given_config_source;
-static int actions, types;
+static int types;
 static int end_null;
 static int respect_includes_opt = -1;
 static struct config_options config_options;
 static int show_origin;
 
-#define ACTION_GET (1<<0)
-#define ACTION_GET_ALL (1<<1)
-#define ACTION_GET_REGEXP (1<<2)
-#define ACTION_REPLACE_ALL (1<<3)
-#define ACTION_ADD (1<<4)
-#define ACTION_UNSET (1<<5)
-#define ACTION_UNSET_ALL (1<<6)
-#define ACTION_RENAME_SECTION (1<<7)
-#define ACTION_REMOVE_SECTION (1<<8)
-#define ACTION_LIST (1<<9)
-#define ACTION_EDIT (1<<10)
-#define ACTION_SET (1<<11)
-#define ACTION_SET_ALL (1<<12)
-#define ACTION_GET_COLOR (1<<13)
-#define ACTION_GET_COLORBOOL (1<<14)
-#define ACTION_GET_URLMATCH (1<<15)
-
+enum config_action {
+	ACTION_NONE = 0,
+	ACTION_GET,
+	ACTION_GET_ALL,
+	ACTION_GET_REGEXP,
+	ACTION_REPLACE_ALL,
+	ACTION_ADD,
+	ACTION_UNSET,
+	ACTION_UNSET_ALL,
+	ACTION_RENAME_SECTION,
+	ACTION_REMOVE_SECTION,
+	ACTION_LIST,
+	ACTION_EDIT,
+	ACTION_SET,
+	ACTION_SET_ALL,
+	ACTION_GET_COLOR,
+	ACTION_GET_COLORBOOL,
+	ACTION_GET_URLMATCH,
+};
 /*
- * The actions "ACTION_LIST | ACTION_GET_*" which may produce more than
- * one line of output and which should therefore be paged.
+ * This must be an int and not an enum because we pass it by address
+ * to OPT_SETINT.
  */
-#define PAGING_ACTIONS (ACTION_LIST | ACTION_GET_ALL | \
-			ACTION_GET_REGEXP | ACTION_GET_URLMATCH)
+static int action;
 
 #define TYPE_BOOL (1<<0)
 #define TYPE_INT (1<<1)
@@ -69,20 +70,20 @@ static struct option builtin_config_options[] = {
 	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use given config file")),
 	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read config from given blob object")),
 	OPT_GROUP(N_("Action")),
-	OPT_BIT(0, "get", &actions, N_("get value: name [value-regex]"), ACTION_GET),
-	OPT_BIT(0, "get-all", &actions, N_("get all values: key [value-regex]"), ACTION_GET_ALL),
-	OPT_BIT(0, "get-regexp", &actions, N_("get values for regexp: name-regex [value-regex]"), ACTION_GET_REGEXP),
-	OPT_BIT(0, "get-urlmatch", &actions, N_("get value specific for the URL: section[.var] URL"), ACTION_GET_URLMATCH),
-	OPT_BIT(0, "replace-all", &actions, N_("replace all matching variables: name value [value_regex]"), ACTION_REPLACE_ALL),
-	OPT_BIT(0, "add", &actions, N_("add a new variable: name value"), ACTION_ADD),
-	OPT_BIT(0, "unset", &actions, N_("remove a variable: name [value-regex]"), ACTION_UNSET),
-	OPT_BIT(0, "unset-all", &actions, N_("remove all matches: name [value-regex]"), ACTION_UNSET_ALL),
-	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-name"), ACTION_RENAME_SECTION),
-	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTION_REMOVE_SECTION),
-	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
-	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
-	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
-	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
+	OPT_SET_INT(0, "get", &action, N_("get value: name [value-regex]"), ACTION_GET),
+	OPT_SET_INT(0, "get-all", &action, N_("get all values: key [value-regex]"), ACTION_GET_ALL),
+	OPT_SET_INT(0, "get-regexp", &action, N_("get values for regexp: name-regex [value-regex]"), ACTION_GET_REGEXP),
+	OPT_SET_INT(0, "get-urlmatch", &action, N_("get value specific for the URL: section[.var] URL"), ACTION_GET_URLMATCH),
+	OPT_SET_INT(0, "replace-all", &action, N_("replace all matching variables: name value [value_regex]"), ACTION_REPLACE_ALL),
+	OPT_SET_INT(0, "add", &action, N_("add a new variable: name value"), ACTION_ADD),
+	OPT_SET_INT(0, "unset", &action, N_("remove a variable: name [value-regex]"), ACTION_UNSET),
+	OPT_SET_INT(0, "unset-all", &action, N_("remove all matches: name [value-regex]"), ACTION_UNSET_ALL),
+	OPT_SET_INT(0, "rename-section", &action, N_("rename section: old-name new-name"), ACTION_RENAME_SECTION),
+	OPT_SET_INT(0, "remove-section", &action, N_("remove a section: name"), ACTION_REMOVE_SECTION),
+	OPT_SET_INT('l', "list", &action, N_("list all"), ACTION_LIST),
+	OPT_SET_INT('e', "edit", &action, N_("open an editor"), ACTION_EDIT),
+	OPT_SET_INT(0, "get-color", &action, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
+	OPT_SET_INT(0, "get-colorbool", &action, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
 	OPT_GROUP(N_("Type")),
 	OPT_BIT(0, "bool", &types, N_("value is \"true\" or \"false\""), TYPE_BOOL),
 	OPT_BIT(0, "int", &types, N_("value is decimal number"), TYPE_INT),
@@ -571,40 +572,46 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
-	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && types) {
+	if (types &&
+	    (action == ACTION_GET_COLOR ||
+	     action == ACTION_GET_COLORBOOL)) {
 		error("--get-color and variable type are incoherent");
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
-	if (HAS_MULTI_BITS(actions)) {
-		error("only one action at a time.");
-		usage_with_options(builtin_config_usage, builtin_config_options);
-	}
-	if (actions == 0)
+	if (action == ACTION_NONE) {
 		switch (argc) {
-		case 1: actions = ACTION_GET; break;
-		case 2: actions = ACTION_SET; break;
-		case 3: actions = ACTION_SET_ALL; break;
+		case 1: action = ACTION_GET; break;
+		case 2: action = ACTION_SET; break;
+		case 3: action = ACTION_SET_ALL; break;
 		default:
 			usage_with_options(builtin_config_usage, builtin_config_options);
 		}
+	}
 	if (omit_values &&
-	    !(actions == ACTION_LIST || actions == ACTION_GET_REGEXP)) {
+	    !(action == ACTION_LIST ||
+	      action == ACTION_GET_REGEXP)) {
 		error("--name-only is only applicable to --list or --get-regexp");
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
-	if (show_origin && !(actions &
-		(ACTION_GET|ACTION_GET_ALL|ACTION_GET_REGEXP|ACTION_LIST))) {
+	if (show_origin &&
+	    !(action == ACTION_GET ||
+	      action == ACTION_GET_ALL ||
+	      action == ACTION_GET_REGEXP ||
+	      action == ACTION_LIST)) {
 		error("--show-origin is only applicable to --get, --get-all, "
 			  "--get-regexp, and --list.");
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
-	if (actions & PAGING_ACTIONS)
+	if (action == ACTION_LIST ||
+	    action == ACTION_GET_ALL ||
+	    action == ACTION_GET_REGEXP ||
+	    action == ACTION_GET_URLMATCH)
 		setup_auto_pager("config", 1);
 
-	if (actions == ACTION_LIST) {
+	if (action == ACTION_LIST) {
 		check_argc(argc, 0, 0);
 		if (config_with_options(show_all_config, NULL,
 					&given_config_source,
@@ -616,7 +623,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 				die("error processing config file(s)");
 		}
 	}
-	else if (actions == ACTION_EDIT) {
+	else if (action == ACTION_EDIT) {
 		char *config_file;
 
 		check_argc(argc, 0, 0);
@@ -644,7 +651,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		launch_editor(config_file, NULL, NULL);
 		free(config_file);
 	}
-	else if (actions == ACTION_SET) {
+	else if (action == ACTION_SET) {
 		int ret;
 		check_write();
 		check_argc(argc, 2, 2);
@@ -656,7 +663,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			"       Use a regexp, --add or --replace-all to change %s."), argv[0]);
 		return ret;
 	}
-	else if (actions == ACTION_SET_ALL) {
+	else if (action == ACTION_SET_ALL) {
 		check_write();
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
@@ -664,7 +671,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
 							      argv[0], value, argv[2], 0);
 	}
-	else if (actions == ACTION_ADD) {
+	else if (action == ACTION_ADD) {
 		check_write();
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
@@ -673,7 +680,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 							      argv[0], value,
 							      CONFIG_REGEX_NONE, 0);
 	}
-	else if (actions == ACTION_REPLACE_ALL) {
+	else if (action == ACTION_REPLACE_ALL) {
 		check_write();
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
@@ -681,27 +688,27 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
 							      argv[0], value, argv[2], 1);
 	}
-	else if (actions == ACTION_GET) {
+	else if (action == ACTION_GET) {
 		check_argc(argc, 1, 2);
 		return get_value(argv[0], argv[1]);
 	}
-	else if (actions == ACTION_GET_ALL) {
+	else if (action == ACTION_GET_ALL) {
 		do_all = 1;
 		check_argc(argc, 1, 2);
 		return get_value(argv[0], argv[1]);
 	}
-	else if (actions == ACTION_GET_REGEXP) {
+	else if (action == ACTION_GET_REGEXP) {
 		show_keys = 1;
 		use_key_regexp = 1;
 		do_all = 1;
 		check_argc(argc, 1, 2);
 		return get_value(argv[0], argv[1]);
 	}
-	else if (actions == ACTION_GET_URLMATCH) {
+	else if (action == ACTION_GET_URLMATCH) {
 		check_argc(argc, 2, 2);
 		return get_urlmatch(argv[0], argv[1]);
 	}
-	else if (actions == ACTION_UNSET) {
+	else if (action == ACTION_UNSET) {
 		check_write();
 		check_argc(argc, 1, 2);
 		if (argc == 2)
@@ -711,13 +718,13 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			return git_config_set_in_file_gently(given_config_source.file,
 							     argv[0], NULL);
 	}
-	else if (actions == ACTION_UNSET_ALL) {
+	else if (action == ACTION_UNSET_ALL) {
 		check_write();
 		check_argc(argc, 1, 2);
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
 							      argv[0], NULL, argv[1], 1);
 	}
-	else if (actions == ACTION_RENAME_SECTION) {
+	else if (action == ACTION_RENAME_SECTION) {
 		int ret;
 		check_write();
 		check_argc(argc, 2, 2);
@@ -728,7 +735,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (ret == 0)
 			die("No such section!");
 	}
-	else if (actions == ACTION_REMOVE_SECTION) {
+	else if (action == ACTION_REMOVE_SECTION) {
 		int ret;
 		check_write();
 		check_argc(argc, 1, 1);
@@ -739,11 +746,11 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (ret == 0)
 			die("No such section!");
 	}
-	else if (actions == ACTION_GET_COLOR) {
+	else if (action == ACTION_GET_COLOR) {
 		check_argc(argc, 1, 2);
 		get_color(argv[0], argv[1]);
 	}
-	else if (actions == ACTION_GET_COLORBOOL) {
+	else if (action == ACTION_GET_COLORBOOL) {
 		check_argc(argc, 1, 2);
 		if (argc == 2)
 			color_stdout_is_tty = git_config_bool("command line", argv[1]);
-- 
2.17.0.rc2.594.gdb94a0ce02

