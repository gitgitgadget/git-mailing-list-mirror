From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] config: Use parseopt.
Date: Sat, 14 Feb 2009 14:03:09 +0200
Message-ID: <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com>
References: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 13:06:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYJHz-0007bI-Pz
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 13:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbZBNMDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 07:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbZBNMDQ
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 07:03:16 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:44484 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbZBNMDP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 07:03:15 -0500
Received: by fxm13 with SMTP id 13so4344664fxm.13
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 04:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9/lRyquwY2Pxh3F9X5Yo9HnihB+eU7j/HWDwCGJp0U0=;
        b=FTt1kHnOW4mOOGUzpkmkhZIr+UxKx8ZAg3jprOeetRa9KzYHgFX5N+9OF0uZwbnnT3
         Czclz9EsquyJ/p0gQSOf6eZgU8BAeos9PQeCdGZ3BYL6KDQ85kgCQ0iq/CsZITt685RH
         99xNyZ31ts9gdgLTDfQ2IVzEcbsj89hrC+iqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VpILDztMFxSGZfkixi0y1EQK+eIl+oM6rf0SzWPVr+j30Jt9cJVvcMkCaxFWoDQkRF
         tuQ5YQpgJVELuDFMkv+7FC2ffgqg2wuqZj/7aUl0aOaJnIMeZQmuCRe1GLWpqIvtlU58
         RiALcuONROE8rlCcVDbPDqIiHhyFyMph1HRc0=
Received: by 10.181.58.9 with SMTP id l9mr221423bkk.214.1234612992473;
        Sat, 14 Feb 2009 04:03:12 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id y15sm4350502fkd.32.2009.02.14.04.03.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Feb 2009 04:03:11 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109865>

Reorganizing the code to use parseopt as suggested by Johannes
Schindelin.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |  370 ++++++++++++++++++++++++++---------------------------
 1 files changed, 182 insertions(+), 188 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 6937eaf..aefec0d 100644
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
@@ -18,6 +21,59 @@ static char key_delim = ' ';
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
+
+static struct option builtin_config_options[] = {
+	OPT_GROUP("Config file location"),
+	OPT_BOOLEAN(0, "global", &use_global_config, "use global config file"),
+	OPT_BOOLEAN(0, "system", &use_system_config, "use system config file"),
+	OPT_STRING('f', "file", &given_config_file, "FILE", "use given config file"),
+	OPT_GROUP("Action"),
+	OPT_BIT(0, "get", &actions, "get value: name [value-regex]", ACTION_GET),
+	OPT_BIT(0, "get-all", &actions, "get all values: key [value-regex]", ACTION_GET),
+	OPT_BIT(0, "get-regexp", &actions, "get values for regexp: name-regex [value-regex]", ACTION_GET_REGEXP),
+	OPT_BIT(0, "replace-all", &actions, "replace all matching variables: name [value [value_regex]", ACTION_REPLACE_ALL),
+	OPT_BIT(0, "add", &actions, "adds a new variable: name value", ACTION_ADD),
+	OPT_BIT(0, "unset", &actions, "removes a variable: name [value-regex]", ACTION_UNSET),
+	OPT_BIT(0, "unset-all", &actions, "removes all matches: name [value-regex]", ACTION_UNSET_ALL),
+	OPT_BIT(0, "rename-section", &actions, "rename section: old-name new-name", ACTION_RENAME_SECTION),
+	OPT_BIT(0, "remove-section", &actions, "remove a section: name", ACTION_REMOVE_SECTION),
+	OPT_BIT('l', "list", &actions, "list all", ACTION_LIST),
+	OPT_BIT('e', "edit", &actions, "opens an editor", ACTION_EDIT),
+	OPT_GROUP("Type"),
+	OPT_SET_INT(0, "bool", &type, "value is \"true\" or \"false\"", T_BOOL),
+	OPT_SET_INT(0, "int", &type, "value is decimal number", T_INT),
+	OPT_SET_INT(0, "bool-or-int", &type, NULL, T_BOOL_OR_INT),
+	OPT_STRING(0, "get-color", &get_color_slot, "slot", "find the color configured: [default]"),
+	OPT_STRING(0, "get-colorbool", &get_colorbool_slot, "slot", "find the color setting: [stdout-is-tty]"),
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
@@ -179,7 +235,6 @@ static char *normalize_value(const char *key, const char *value)
 static int get_color_found;
 static const char *get_color_slot;
 static char parsed_color[COLOR_MAXLEN];
-
 static int git_get_color_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, get_color_slot)) {
@@ -191,29 +246,8 @@ static int git_get_color_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static int get_color(int argc, const char **argv)
+static void get_color(const char *def_color)
 {
-	/*
-	 * grab the color setting for the given slot from the configuration,
-	 * or parse the default value if missing, and return ANSI color
-	 * escape sequence.
-	 *
-	 * e.g.
-	 * git config --get-color color.diff.whitespace "blue reverse"
-	 */
-	const char *def_color = NULL;
-
-	switch (argc) {
-	default:
-		usage(git_config_set_usage);
-	case 2:
-		def_color = argv[1];
-		/* fallthru */
-	case 1:
-		get_color_slot = argv[0];
-		break;
-	}
-
 	get_color_found = 0;
 	parsed_color[0] = '\0';
 	git_config(git_get_color_config, NULL);
@@ -222,7 +256,6 @@ static int get_color(int argc, const char **argv)
 		color_parse(def_color, "command line", parsed_color);
 
 	fputs(parsed_color, stdout);
-	return 0;
 }
 
 static int stdout_is_tty;
@@ -231,7 +264,7 @@ static int get_diff_color_found;
 static int git_get_colorbool_config(const char *var, const char *value,
 		void *cb)
 {
-	if (!strcmp(var, get_color_slot)) {
+	if (!strcmp(var, get_colorbool_slot)) {
 		get_colorbool_found =
 			git_config_colorbool(var, value, stdout_is_tty);
 	}
@@ -246,39 +279,24 @@ static int git_get_colorbool_config(const char *var, const char *value,
 	return 0;
 }
 
-static int get_colorbool(int argc, const char **argv)
+static int get_colorbool(int print)
 {
-	/*
-	 * git config --get-colorbool <slot> [<stdout-is-tty>]
-	 *
-	 * returns "true" or "false" depending on how <slot>
-	 * is configured.
-	 */
-
-	if (argc == 2)
-		stdout_is_tty = git_config_bool("command line", argv[1]);
-	else if (argc == 1)
-		stdout_is_tty = isatty(1);
-	else
-		usage(git_config_set_usage);
 	get_colorbool_found = -1;
 	get_diff_color_found = -1;
-	get_color_slot = argv[0];
 	git_config(git_get_colorbool_config, NULL);
 
 	if (get_colorbool_found < 0) {
-		if (!strcmp(get_color_slot, "color.diff"))
+		if (!strcmp(get_colorbool_slot, "color.diff"))
 			get_colorbool_found = get_diff_color_found;
 		if (get_colorbool_found < 0)
 			get_colorbool_found = git_use_color_default;
 	}
 
-	if (argc == 1) {
-		return get_colorbool_found ? 0 : 1;
-	} else {
+	if (print) {
 		printf("%s\n", get_colorbool_found ? "true" : "false");
 		return 0;
-	}
+	} else
+		return get_colorbool_found ? 0 : 1;
 }
 
 int cmd_config(int argc, const char **argv, const char *prefix)
@@ -289,151 +307,127 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
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
-			if (git_config(show_all_config, NULL) < 0 &&
-					file && errno)
-				die("unable to read config file %s: %s", file,
-				    strerror(errno));
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
-			if (!is_absolute_path(argv[2]) && file)
-				file = prefix_filename(file, strlen(file),
-						       argv[2]);
-			else
-				file = argv[2];
-			config_exclusive_filename = file;
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
-			return get_color(argc-2, argv+2);
-		} else if (!strcmp(argv[1], "--get-colorbool")) {
-			return get_colorbool(argc-2, argv+2);
-		} else if (!strcmp(argv[1], "--edit") || !strcmp(argv[1], "-e")) {
-			const char *config_filename;
-			if (argc != 2)
-				usage(git_config_set_usage);
-			if (config_exclusive_filename)
-				config_filename = config_exclusive_filename;
-			else
-				config_filename = git_path("config");
-			git_config(git_default_config, NULL);
-			launch_editor(config_filename, NULL, NULL);
-			return 0;
-		} else
-			break;
-		argc--;
-		argv++;
-	}
+	argc = parse_options(argc, argv, builtin_config_options, builtin_config_usage, 0);
 
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
-		}
-	case 5:
-		if (!strcmp(argv[1], "--replace-all")) {
-			value = normalize_value(argv[2], argv[3]);
-			return git_config_set_multivar(argv[2], value, argv[4], 1);
+	}
+	else if (use_system_config)
+		config_exclusive_filename = git_etc_gitconfig();
+	else if (given_config_file) {
+		if (!is_absolute_path(given_config_file) && file)
+			file = prefix_filename(file, strlen(file),
+					       given_config_file);
+		else
+			file = given_config_file;
+		config_exclusive_filename = file;
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
+		case 1: actions |= ACTION_GET; break;
+		case 2: actions |= ACTION_ADD; break;
+		case 3: actions |= ACTION_REPLACE_ALL; break;
+		default:
+			usage_with_options(builtin_config_usage, builtin_config_options);
 		}
-	case 1:
-	default:
-		usage(git_config_set_usage);
+
+	if (actions & ACTION_LIST) {
+		if (git_config(show_all_config, NULL) < 0 &&
+		    file && errno)
+			die("unable to read config file %s: %s", file,
+			    strerror(errno));
+	}
+	else if (actions & ACTION_EDIT) {
+		const char *config_filename;
+		if (config_exclusive_filename)
+			config_filename = config_exclusive_filename;
+		else
+			config_filename = git_path("config");
+		git_config(git_default_config, NULL);
+		launch_editor(config_filename, NULL, NULL);
+	}
+	else if (actions & ACTION_ADD) {
+		check_argc(argc, 2, 2);
+		value = normalize_value(argv[0], argv[1]);
+		return git_config_set_multivar(argv[0], value, "^$", 0);
+	}
+	else if (actions & ACTION_REPLACE_ALL) {
+		check_argc(argc, 2, 3);
+		value = normalize_value(argv[0], argv[1]);
+		return git_config_set_multivar(argv[0], value, argv[2], 1);
 	}
+	else if (actions & ACTION_GET) {
+		check_argc(argc, 1, 2);
+		return get_value(argv[0], argv[1]);
+	}
+	else if (actions & ACTION_GET_ALL) {
+		do_all = 1;
+		check_argc(argc, 1, 2);
+		return get_value(argv[0], argv[1]);
+	}
+	else if (actions & ACTION_GET_REGEXP) {
+		show_keys = 1;
+		use_key_regexp = 1;
+		do_all = 1;
+		check_argc(argc, 1, 2);
+		return get_value(argv[0], argv[1]);
+	}
+	else if (actions & ACTION_UNSET) {
+		check_argc(argc, 1, 2);
+		if (argc == 2)
+			return git_config_set_multivar(argv[0], NULL, argv[1], 0);
+		else
+			return git_config_set(argv[0], NULL);
+	}
+	else if (actions & ACTION_UNSET_ALL) {
+		check_argc(argc, 1, 2);
+		return git_config_set_multivar(argv[0], NULL, argv[1], 1);
+	}
+	else if (actions & ACTION_RENAME_SECTION) {
+		int ret;
+		check_argc(argc, 2, 2);
+		ret = git_config_rename_section(argv[0], argv[1]);
+		if (ret < 0)
+			return ret;
+		if (ret == 0)
+			die("No such section!");
+	}
+	else if (actions & ACTION_REMOVE_SECTION) {
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
