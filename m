From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 04:05:42 +0200
Message-ID: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 03:07:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY9w4-00030F-IV
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 03:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbZBNCFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 21:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752466AbZBNCFs
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 21:05:48 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:59541 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbZBNCFr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 21:05:47 -0500
Received: by fk-out-0910.google.com with SMTP id f33so735786fkf.5
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 18:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=FZLeMIhq8RNhQSBsQeTf8sXp+xBXNbmZZmaMnY/SlNc=;
        b=vuIeTjHWwsMIP5yg4PvElMzg27Fv3bqO3BqZKAvd7fdCKtwO0U/cV6Ef9kJshFhZUy
         E3syTpCNcqKb1OwJlbf+qfLh/v8+K5Tif6nUhgmdcJ9DS2Hci7NQIa+9JxfPald8vQUm
         WC490HrwGpiSjxo/py7yx078X1VcWMxBNqhIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=lJ6MZxGiIp02KdBR0/bQCKMK0gV/eD946U0nAcUQqgIFQ/Nl1p4SySYXeV6q+My/rz
         E5/biVWvB0AkRN5R2J8uOs/nbfj+1WbuWLzEsKy0qkU1n8cSVzHlI42YvCiuv5dRxNtP
         a304TYtbYin40ISQL46E5L5OgkGQimGUM+6+w=
Received: by 10.223.109.148 with SMTP id j20mr137038fap.43.1234577145262;
        Fri, 13 Feb 2009 18:05:45 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id f31sm1926746fkf.15.2009.02.13.18.05.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 18:05:44 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109800>

Reorganizing the code to use parseopt as suggested by Johannes
Schindelin.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |  422 +++++++++++++++++++++++++++---------------------------
 1 files changed, 210 insertions(+), 212 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index afc4393..f774902 100644
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
@@ -18,6 +21,42 @@ static char key_delim = ' ';
 static char term = '\n';
 static enum { T_RAW, T_INT, T_BOOL, T_BOOL_OR_INT } type = T_RAW;
 
+static int use_global_config, use_system_config;
+static const char *given_config_file;
+static int do_list, do_edit, do_add, do_get, do_get_all, do_get_regexp, do_replace_all;
+static int do_unset, do_unset_all, do_rename_section, do_remove_section;
+static int type_int, type_bool, type_bool_or_int;
+static const char *get_color_name, *get_colorbool_name;
+static int end_null;
+
+static struct option builtin_config_options[] = {
+	OPT_GROUP("Config file location"),
+	OPT_BOOLEAN(0, "global", &use_global_config, "use global config file"),
+	OPT_BOOLEAN(0, "system", &use_system_config, "use system config file"),
+	OPT_STRING('f', "file", &given_config_file, "FILE", "use given config file"),
+	OPT_GROUP("Action"),
+	OPT_BOOLEAN(0, "get", &do_get, "get value: name [value-regex]"),
+	OPT_BOOLEAN(0, "get-all", &do_get_all, "get all values: key [value-regex]"),
+	OPT_BOOLEAN(0, "get-regexp", &do_get_regexp, "get values for regexp: name-regex [value-regex]"),
+	OPT_BOOLEAN(0, "replace-all", &do_replace_all, "replace all options: name [value [value_regex]"),
+	OPT_BOOLEAN(0, "add", &do_add, "adds a new option: name value"),
+	OPT_BOOLEAN(0, "unset", &do_unset, "removes an option: name [value-regex]"),
+	OPT_BOOLEAN(0, "unset-all", &do_unset_all, "removes all matches: name [value-regex]"),
+	OPT_BOOLEAN(0, "rename-section", &do_rename_section, "rename section: old-name new-name"),
+	OPT_BOOLEAN(0, "remove-section", &do_remove_section, "remove a section: name"),
+	OPT_BOOLEAN('l', "list", &do_list, "list all"),
+	OPT_STRING(0, "get-color", &get_color_name, "name", "find the color configured: [default]"),
+	OPT_STRING(0, "get-colorbool", &get_colorbool_name, "name", "find the color setting: [stdout-is-tty]"),
+	OPT_BOOLEAN('e', "edit", &do_edit, "opens an editor"),
+	OPT_GROUP("Type"),
+	OPT_BOOLEAN(0, "bool", &type_bool, "value is \"true\" or \"false\""),
+	OPT_BOOLEAN(0, "int", &type_int, "value is decimal number"),
+	OPT_BOOLEAN(0, "bool-or-int", &type_bool_or_int, NULL),
+	OPT_GROUP("Other"),
+	OPT_BOOLEAN('z', "null", &end_null, "end values with null character"),
+	OPT_END(),
+};
+
 static int show_all_config(const char *key_, const char *value_, void *cb)
 {
 	if (value_)
@@ -177,12 +216,11 @@ static char *normalize_value(const char *key, const char *value)
 }
 
 static int get_color_found;
-static const char *get_color_slot;
+static const char *get_color_name;
 static char parsed_color[COLOR_MAXLEN];
-
 static int git_get_color_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, get_color_slot)) {
+	if (!strcmp(var, get_color_name)) {
 		if (!value)
 			config_error_nonbool(var);
 		color_parse(value, var, parsed_color);
@@ -191,47 +229,13 @@ static int git_get_color_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static int get_color(int argc, const char **argv)
-{
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
-	get_color_found = 0;
-	parsed_color[0] = '\0';
-	git_config(git_get_color_config, NULL);
-
-	if (!get_color_found && def_color)
-		color_parse(def_color, "command line", parsed_color);
-
-	fputs(parsed_color, stdout);
-	return 0;
-}
-
 static int stdout_is_tty;
 static int get_colorbool_found;
 static int get_diff_color_found;
 static int git_get_colorbool_config(const char *var, const char *value,
 		void *cb)
 {
-	if (!strcmp(var, get_color_slot)) {
+	if (!strcmp(var, get_colorbool_name)) {
 		get_colorbool_found =
 			git_config_colorbool(var, value, stdout_is_tty);
 	}
@@ -246,41 +250,6 @@ static int git_get_colorbool_config(const char *var, const char *value,
 	return 0;
 }
 
-static int get_colorbool(int argc, const char **argv)
-{
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
-	get_colorbool_found = -1;
-	get_diff_color_found = -1;
-	get_color_slot = argv[0];
-	git_config(git_get_colorbool_config, NULL);
-
-	if (get_colorbool_found < 0) {
-		if (!strcmp(get_color_slot, "color.diff"))
-			get_colorbool_found = get_diff_color_found;
-		if (get_colorbool_found < 0)
-			get_colorbool_found = git_use_color_default;
-	}
-
-	if (argc == 1) {
-		return get_colorbool_found ? 0 : 1;
-	} else {
-		printf("%s\n", get_colorbool_found ? "true" : "false");
-		return 0;
-	}
-}
-
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit;
@@ -289,151 +258,180 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
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
+	argc = parse_options(argc, argv, builtin_config_options, builtin_config_usage, 0);
+
+	if (use_global_config) {
+		char *home = getenv("HOME");
+		if (home) {
+			char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
+			config_exclusive_filename = user_config;
+		} else {
+			die("$HOME not set");
 		}
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
+	if (type_int)
+		type = T_INT;
+	else if (type_bool)
+		type = T_BOOL;
+	else if (type_bool_or_int)
+		type = T_BOOL_OR_INT;
+
+	if (end_null) {
+		term = '\0';
+		delim = '\n';
+		key_delim = '\n';
+	}
+
+	{
+		int action_sum;
+		action_sum = do_unset + do_unset_all + do_get + do_get_all + \
+			     do_get_regexp + do_add + do_list + do_edit + \
+			     do_rename_section + do_remove_section + do_replace_all;
+		if (action_sum > 1)
+			die ("Can't execute two actions at the same time.");
+		else if (action_sum == 0)
+			switch (argc)
+			{
+				case 1: do_get = 1; break;
+				case 2: do_add = 1; break;
+				case 3: do_replace_all = 1; break;
+				default:
+					usage_with_options(builtin_config_usage, builtin_config_options);
 			}
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
+	}
+
+	if (do_list) {
+		if (git_config(show_all_config, NULL) < 0 &&
+		    file && errno)
+			die("unable to read config file %s: %s", file,
+			    strerror(errno));
+	}
+	else if (do_edit) {
+		const char *config_filename;
+		if (config_exclusive_filename)
+			config_filename = config_exclusive_filename;
+		else
+			config_filename = git_path("config");
+		git_config(git_default_config, NULL);
+		launch_editor(config_filename, NULL, NULL);
+	}
+	else if (do_add) {
+		if (argc > 2)
+			die("Too many arguments.");
+		if (argc != 2)
+			die("Need name value.");
+		value = normalize_value(argv[0], argv[1]);
+		return git_config_set_multivar(argv[0], value, "^$", 0);
+	}
+	else if (do_replace_all) {
+		value = normalize_value(argv[0], argv[1]);
+		return git_config_set_multivar(argv[0], value, (argc == 3 ? argv[2] : NULL), 1);
+	}
+	else if (do_get)
+		return get_value(argv[0], (argc == 2 ? argv[1] : NULL));
+	else if (do_get_all) {
+		do_all = 1;
+		return get_value(argv[0], (argc == 2 ? argv[1] : NULL));
+	}
+	else if (do_get_regexp) {
+		show_keys = 1;
+		use_key_regexp = 1;
+		do_all = 1;
+		return get_value(argv[0], (argc == 2 ? argv[1] : NULL));
+	}
+	else if (do_unset) {
+		if (argc == 2)
+			return git_config_set_multivar(argv[0], NULL, argv[1], 0);
+		else
+			return git_config_set(argv[0], NULL);
+	}
+	else if (do_unset_all) {
+		return git_config_set_multivar(argv[0], NULL, (argc == 2 ? argv[1] : NULL), 1);
+	}
+	else if (do_rename_section) {
+		int ret;
+		if (argc > 2)
+			die("Too many arguments.");
+		if (argc != 2)
+			die("Need old_name new_name.");
+		ret = git_config_rename_section(argv[0], argv[1]);
+		if (ret < 0)
+			return ret;
+		if (ret == 0)
+			die("No such section!");
+	}
+	else if (do_remove_section) {
+		int ret;
+		if (argc > 1)
+			die("Too many arguments.");
+		if (argc != 1)
+			die("Need section name.");
+		ret = git_config_rename_section(argv[0], NULL);
+		if (ret < 0)
+			return ret;
+		if (ret == 0)
+			die("No such section!");
+	}
+	else if (get_color_name) {
+		const char *def_color = NULL;
+
+		switch (argc) {
+		case 2:
+			def_color = argv[1];
+			/* fallthru */
+		case 1:
+			get_color_name = argv[0];
 			break;
-		argc--;
-		argv++;
+		default:
+			die("Too many arguments.");
+		}
+
+		get_color_found = 0;
+		parsed_color[0] = '\0';
+		git_config(git_get_color_config, NULL);
+
+		if (!get_color_found && def_color)
+			color_parse(def_color, "command line", parsed_color);
+
+		fputs(parsed_color, stdout);
 	}
+	else if (get_colorbool_name) {
+		if (argc == 1)
+			stdout_is_tty = git_config_bool("command line", argv[0]);
+		else if (argc == 0)
+			stdout_is_tty = isatty(1);
+		else
+			die("Too many options.");
 
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
-		} else {
-			value = normalize_value(argv[1], argv[2]);
-			return git_config_set(argv[1], value);
+		get_colorbool_found = -1;
+		get_diff_color_found = -1;
+		git_config(git_get_colorbool_config, NULL);
+
+		if (get_colorbool_found < 0) {
+			if (!strcmp(get_colorbool_name, "color.diff"))
+				get_colorbool_found = get_diff_color_found;
+			if (get_colorbool_found < 0)
+				get_colorbool_found = git_use_color_default;
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
+
+		if (argc == 0) {
+			return get_colorbool_found ? 0 : 1;
 		} else {
-			value = normalize_value(argv[1], argv[2]);
-			return git_config_set_multivar(argv[1], value, argv[3], 0);
-		}
-	case 5:
-		if (!strcmp(argv[1], "--replace-all")) {
-			value = normalize_value(argv[2], argv[3]);
-			return git_config_set_multivar(argv[2], value, argv[4], 1);
+			printf("%s\n", get_colorbool_found ? "true" : "false");
+			return 0;
 		}
-	case 1:
-	default:
-		usage(git_config_set_usage);
 	}
+
 	return 0;
 }
-- 
1.6.1.3
