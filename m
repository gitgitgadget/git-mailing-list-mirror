From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 06/10] config: Use parseopt.
Date: Tue, 17 Feb 2009 15:52:52 +0200
Message-ID: <1234878776-13250-6-git-send-email-felipe.contreras@gmail.com>
References: <1234878776-13250-1-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-2-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-3-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-4-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-5-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 14:55:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQPn-0001sQ-PW
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 14:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbZBQNx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 08:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbZBQNxZ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 08:53:25 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:51922 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbZBQNxX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 08:53:23 -0500
Received: by mail-bw0-f161.google.com with SMTP id 5so4067593bwz.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 05:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=r/AggsLnjGqpkuOZwLzd0c/2x2jcIFIxXCWsnqDLPgc=;
        b=gOjj2kmg0TNVyE3oNZOKz7E0tdoO0op3XmDHdCY4LmYigogwbirkISCjVwnJPHKfJ3
         hZF2BV46jiCRRVsIRfIUNh3e/XDp2KHLn9bKPzPC/rhjk8/4aB5TgR/UF9FXXC9+hd6P
         rGmKRtzg5OrokyV3tCw7a1/rWKNN0EJ1PJ+Tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LDbFGaJOakAJdm639qFGy8D2qezx3KAvPGTGESzGdjeApPMlbr/fkbWUOEW7lmm4gw
         JD0LcYsvHIcahH75JcZM/uff1yJC3TOHqJ+WJrJnHLON4YRMxtNf6O6tvMHh1BbDQ4Jp
         OJkauhWQjqNq85C+NnSetnv9X3SQEBQ00ohqo=
Received: by 10.223.110.3 with SMTP id l3mr1023579fap.48.1234878802364;
        Tue, 17 Feb 2009 05:53:22 -0800 (PST)
Received: from localhost (net-63.nrpn.net [192.89.6.63])
        by mx.google.com with ESMTPS id q9sm3291320gve.27.2009.02.17.05.53.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 05:53:21 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1234878776-13250-5-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110373>

Reorganizing the code to use parseopt as suggested by Johannes
Schindelin.

This patch has benefited from comments by Johannes
Schindelin and Junio C Hamano.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |  342 ++++++++++++++++++++++++++++++------------------------
 1 files changed, 188 insertions(+), 154 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 0836880..45b4a9f 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -1,9 +1,12 @@
 #include "builtin.h"
 #include "cache.h"
 #include "color.h"
+#include "parse-options.h"
 
-static const char git_config_set_usage[] =
-"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty] | --edit | -e ]";
+static const char *const builtin_config_usage[] = {
+	"git config [options]",
+	NULL
+};
 
 static char *key;
 static regex_t *key_regexp;
@@ -18,6 +21,61 @@ static char key_delim = ' ';
 static char term = '\n';
 static enum { T_RAW, T_INT, T_BOOL, T_BOOL_OR_INT } type = T_RAW;
 
+static int use_global_config, use_system_config;
+static const char *given_config_file;
+static int actions;
+static const char *get_color_slot, *get_colorbool_slot;
+static int end_null;
+
+#define ACTION_GET (1<<0)
+#define ACTION_GET_ALL (1<<1)
+#define ACTION_GET_REGEXP (1<<2)
+#define ACTION_REPLACE_ALL (1<<3)
+#define ACTION_ADD (1<<4)
+#define ACTION_UNSET (1<<5)
+#define ACTION_UNSET_ALL (1<<6)
+#define ACTION_RENAME_SECTION (1<<7)
+#define ACTION_REMOVE_SECTION (1<<8)
+#define ACTION_LIST (1<<9)
+#define ACTION_EDIT (1<<10)
+#define ACTION_SET (1<<11)
+#define ACTION_SET_ALL (1<<12)
+
+static struct option builtin_config_options[] = {
+	OPT_GROUP("Config file location"),
+	OPT_BOOLEAN(0, "global", &use_global_config, "use global config file"),
+	OPT_BOOLEAN(0, "system", &use_system_config, "use system config file"),
+	OPT_STRING('f', "file", &given_config_file, "FILE", "use given config file"),
+	OPT_GROUP("Action"),
+	OPT_BIT(0, "get", &actions, "get value: name [value-regex]", ACTION_GET),
+	OPT_BIT(0, "get-all", &actions, "get all values: key [value-regex]", ACTION_GET_ALL),
+	OPT_BIT(0, "get-regexp", &actions, "get values for regexp: name-regex [value-regex]", ACTION_GET_REGEXP),
+	OPT_BIT(0, "replace-all", &actions, "replace all matching variables: name [value [value_regex]", ACTION_REPLACE_ALL),
+	OPT_BIT(0, "add", &actions, "adds a new variable: name value", ACTION_ADD),
+	OPT_BIT(0, "unset", &actions, "removes a variable: name [value-regex]", ACTION_UNSET),
+	OPT_BIT(0, "unset-all", &actions, "removes all matches: name [value-regex]", ACTION_UNSET_ALL),
+	OPT_BIT(0, "rename-section", &actions, "rename section: old-name new-name", ACTION_RENAME_SECTION),
+	OPT_BIT(0, "remove-section", &actions, "remove a section: name", ACTION_REMOVE_SECTION),
+	OPT_BIT('l', "list", &actions, "list all", ACTION_LIST),
+	OPT_BIT('e', "edit", &actions, "opens an editor", ACTION_EDIT),
+	OPT_STRING(0, "get-color", &get_color_slot, "slot", "find the color configured: [default]"),
+	OPT_STRING(0, "get-colorbool", &get_colorbool_slot, "slot", "find the color setting: [stdout-is-tty]"),
+	OPT_GROUP("Type"),
+	OPT_SET_INT(0, "bool", &type, "value is \"true\" or \"false\"", T_BOOL),
+	OPT_SET_INT(0, "int", &type, "value is decimal number", T_INT),
+	OPT_SET_INT(0, "bool-or-int", &type, NULL, T_BOOL_OR_INT),
+	OPT_GROUP("Other"),
+	OPT_BOOLEAN('z', "null", &end_null, "terminate values with NUL byte"),
+	OPT_END(),
+};
+
+static void check_argc(int argc, int min, int max) {
+	if (argc >= min && argc <= max)
+		return;
+	error("wrong number of arguments");
+	usage_with_options(builtin_config_usage, builtin_config_options);
+}
+
 static int show_all_config(const char *key_, const char *value_, void *cb)
 {
 	if (value_)
@@ -252,162 +310,138 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 
 	config_exclusive_filename = getenv(CONFIG_ENVIRONMENT);
 
-	while (1 < argc) {
-		if (!strcmp(argv[1], "--int"))
-			type = T_INT;
-		else if (!strcmp(argv[1], "--bool"))
-			type = T_BOOL;
-		else if (!strcmp(argv[1], "--bool-or-int"))
-			type = T_BOOL_OR_INT;
-		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l")) {
-			if (argc != 2)
-				usage(git_config_set_usage);
-			if (git_config(show_all_config, NULL) < 0) {
-				if (config_exclusive_filename)
-					die("unable to read config file %s: %s",
-					    config_exclusive_filename, strerror(errno));
-				else
-					die("error processing config file(s)");
-			}
-			return 0;
-		}
-		else if (!strcmp(argv[1], "--global")) {
-			char *home = getenv("HOME");
-			if (home) {
-				char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
-				config_exclusive_filename = user_config;
-			} else {
-				die("$HOME not set");
-			}
-		}
-		else if (!strcmp(argv[1], "--system"))
-			config_exclusive_filename = git_etc_gitconfig();
-		else if (!strcmp(argv[1], "--file") || !strcmp(argv[1], "-f")) {
-			if (argc < 3)
-				usage(git_config_set_usage);
-			if (!is_absolute_path(argv[2]) && prefix)
-				config_exclusive_filename = prefix_filename(prefix,
-									    strlen(prefix),
-									    argv[2]);
-			else
-				config_exclusive_filename = argv[2];
-			argc--;
-			argv++;
-		}
-		else if (!strcmp(argv[1], "--null") || !strcmp(argv[1], "-z")) {
-			term = '\0';
-			delim = '\n';
-			key_delim = '\n';
-		}
-		else if (!strcmp(argv[1], "--rename-section")) {
-			int ret;
-			if (argc != 4)
-				usage(git_config_set_usage);
-			ret = git_config_rename_section(argv[2], argv[3]);
-			if (ret < 0)
-				return ret;
-			if (ret == 0) {
-				fprintf(stderr, "No such section!\n");
-				return 1;
-			}
-			return 0;
-		}
-		else if (!strcmp(argv[1], "--remove-section")) {
-			int ret;
-			if (argc != 3)
-				usage(git_config_set_usage);
-			ret = git_config_rename_section(argv[2], NULL);
-			if (ret < 0)
-				return ret;
-			if (ret == 0) {
-				fprintf(stderr, "No such section!\n");
-				return 1;
-			}
-			return 0;
-		} else if (!strcmp(argv[1], "--get-color")) {
-			if (argc > 4 || argc < 3)
-				usage(git_config_set_usage);
-			get_color_slot = argv[2];
-			get_color(argv[3]);
-			return 0;
-		} else if (!strcmp(argv[1], "--get-colorbool")) {
-			if (argc == 4)
-				stdout_is_tty = git_config_bool("command line", argv[3]);
-			else if (argc == 3)
-				stdout_is_tty = isatty(1);
-			else
-				usage(git_config_set_usage);
-			get_colorbool_slot = argv[2];
-			return get_colorbool(argc != 3);
-		} else if (!strcmp(argv[1], "--edit") || !strcmp(argv[1], "-e")) {
-			if (argc != 2)
-				usage(git_config_set_usage);
-			git_config(git_default_config, NULL);
-			launch_editor(config_exclusive_filename ?
-				      config_exclusive_filename : git_path("config"),
-				      NULL, NULL);
-			return 0;
-		} else
-			break;
-		argc--;
-		argv++;
-	}
-
-	switch (argc) {
-	case 2:
-		return get_value(argv[1], NULL);
-	case 3:
-		if (!strcmp(argv[1], "--unset"))
-			return git_config_set(argv[2], NULL);
-		else if (!strcmp(argv[1], "--unset-all"))
-			return git_config_set_multivar(argv[2], NULL, NULL, 1);
-		else if (!strcmp(argv[1], "--get"))
-			return get_value(argv[2], NULL);
-		else if (!strcmp(argv[1], "--get-all")) {
-			do_all = 1;
-			return get_value(argv[2], NULL);
-		} else if (!strcmp(argv[1], "--get-regexp")) {
-			show_keys = 1;
-			use_key_regexp = 1;
-			do_all = 1;
-			return get_value(argv[2], NULL);
+	argc = parse_options(argc, argv, builtin_config_options, builtin_config_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (use_global_config) {
+		char *home = getenv("HOME");
+		if (home) {
+			char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
+			config_exclusive_filename = user_config;
 		} else {
-			value = normalize_value(argv[1], argv[2]);
-			return git_config_set(argv[1], value);
+			die("$HOME not set");
 		}
-	case 4:
-		if (!strcmp(argv[1], "--unset"))
-			return git_config_set_multivar(argv[2], NULL, argv[3], 0);
-		else if (!strcmp(argv[1], "--unset-all"))
-			return git_config_set_multivar(argv[2], NULL, argv[3], 1);
-		else if (!strcmp(argv[1], "--get"))
-			return get_value(argv[2], argv[3]);
-		else if (!strcmp(argv[1], "--get-all")) {
-			do_all = 1;
-			return get_value(argv[2], argv[3]);
-		} else if (!strcmp(argv[1], "--get-regexp")) {
-			show_keys = 1;
-			use_key_regexp = 1;
-			do_all = 1;
-			return get_value(argv[2], argv[3]);
-		} else if (!strcmp(argv[1], "--add")) {
-			value = normalize_value(argv[2], argv[3]);
-			return git_config_set_multivar(argv[2], value, "^$", 0);
-		} else if (!strcmp(argv[1], "--replace-all")) {
-			value = normalize_value(argv[2], argv[3]);
-			return git_config_set_multivar(argv[2], value, NULL, 1);
-		} else {
-			value = normalize_value(argv[1], argv[2]);
-			return git_config_set_multivar(argv[1], value, argv[3], 0);
+	}
+	else if (use_system_config)
+		config_exclusive_filename = git_etc_gitconfig();
+	else if (given_config_file) {
+		if (!is_absolute_path(given_config_file) && prefix)
+			config_exclusive_filename = prefix_filename(prefix,
+								    strlen(prefix),
+								    argv[2]);
+		else
+			config_exclusive_filename = given_config_file;
+	}
+
+	if (end_null) {
+		term = '\0';
+		delim = '\n';
+		key_delim = '\n';
+	}
+
+	if (HAS_MULTI_BITS(actions)) {
+		error("only one action at a time.");
+		usage_with_options(builtin_config_usage, builtin_config_options);
+	}
+	if (actions == 0)
+		switch (argc) {
+		case 1: actions = ACTION_GET; break;
+		case 2: actions = ACTION_SET; break;
+		case 3: actions = ACTION_SET_ALL; break;
+		default:
+			usage_with_options(builtin_config_usage, builtin_config_options);
 		}
-	case 5:
-		if (!strcmp(argv[1], "--replace-all")) {
-			value = normalize_value(argv[2], argv[3]);
-			return git_config_set_multivar(argv[2], value, argv[4], 1);
+
+	if (actions == ACTION_LIST) {
+		if (git_config(show_all_config, NULL) < 0) {
+			if (config_exclusive_filename)
+				die("unable to read config file %s: %s",
+				    config_exclusive_filename, strerror(errno));
+			else
+				die("error processing config file(s)");
 		}
-	case 1:
-	default:
-		usage(git_config_set_usage);
 	}
+	else if (actions == ACTION_EDIT) {
+		git_config(git_default_config, NULL);
+		launch_editor(config_exclusive_filename ?
+			      config_exclusive_filename : git_path("config"),
+			      NULL, NULL);
+	}
+	else if (actions == ACTION_SET) {
+		check_argc(argc, 2, 2);
+		value = normalize_value(argv[0], argv[1]);
+		return git_config_set(argv[0], value);
+	}
+	else if (actions == ACTION_SET_ALL) {
+		check_argc(argc, 2, 3);
+		value = normalize_value(argv[0], argv[1]);
+		return git_config_set_multivar(argv[0], value, argv[2], 0);
+	}
+	else if (actions == ACTION_ADD) {
+		check_argc(argc, 2, 2);
+		value = normalize_value(argv[0], argv[1]);
+		return git_config_set_multivar(argv[0], value, "^$", 0);
+	}
+	else if (actions == ACTION_REPLACE_ALL) {
+		check_argc(argc, 2, 3);
+		value = normalize_value(argv[0], argv[1]);
+		return git_config_set_multivar(argv[0], value, argv[2], 1);
+	}
+	else if (actions == ACTION_GET) {
+		check_argc(argc, 1, 2);
+		return get_value(argv[0], argv[1]);
+	}
+	else if (actions == ACTION_GET_ALL) {
+		do_all = 1;
+		check_argc(argc, 1, 2);
+		return get_value(argv[0], argv[1]);
+	}
+	else if (actions == ACTION_GET_REGEXP) {
+		show_keys = 1;
+		use_key_regexp = 1;
+		do_all = 1;
+		check_argc(argc, 1, 2);
+		return get_value(argv[0], argv[1]);
+	}
+	else if (actions == ACTION_UNSET) {
+		check_argc(argc, 1, 2);
+		if (argc == 2)
+			return git_config_set_multivar(argv[0], NULL, argv[1], 0);
+		else
+			return git_config_set(argv[0], NULL);
+	}
+	else if (actions == ACTION_UNSET_ALL) {
+		check_argc(argc, 1, 2);
+		return git_config_set_multivar(argv[0], NULL, argv[1], 1);
+	}
+	else if (actions == ACTION_RENAME_SECTION) {
+		int ret;
+		check_argc(argc, 2, 2);
+		ret = git_config_rename_section(argv[0], argv[1]);
+		if (ret < 0)
+			return ret;
+		if (ret == 0)
+			die("No such section!");
+	}
+	else if (actions == ACTION_REMOVE_SECTION) {
+		int ret;
+		check_argc(argc, 1, 1);
+		ret = git_config_rename_section(argv[0], NULL);
+		if (ret < 0)
+			return ret;
+		if (ret == 0)
+			die("No such section!");
+	}
+	else if (get_color_slot) {
+		get_color(argv[0]);
+	}
+	else if (get_colorbool_slot) {
+		if (argc == 1)
+			stdout_is_tty = git_config_bool("command line", argv[0]);
+		else if (argc == 0)
+			stdout_is_tty = isatty(1);
+		return get_colorbool(argc != 1);
+	}
+
 	return 0;
 }
-- 
1.6.1.3
