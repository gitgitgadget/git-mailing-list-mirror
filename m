From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] Make builtin-config.c use parse-options. (FIRST)
Date: Sat, 29 Mar 2008 21:06:08 +0100
Message-ID: <47EEA130.2010406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Mar 29 21:07:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfhKc-0005lv-9B
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 21:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306AbYC2UGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 16:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754391AbYC2UGd
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 16:06:33 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:25940 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277AbYC2UGc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 16:06:32 -0400
Received: by fg-out-1718.google.com with SMTP id l27so935854fgb.17
        for <git@vger.kernel.org>; Sat, 29 Mar 2008 13:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=VMN+q/8Dc9RuWS71KGMvf7U8kaCFL2O0inYtjXPLM+s=;
        b=fIZTRKJPRAsk3vJ138ExvhIsv76oItmFGL0LmW3ryxEQXvPGVzv/IqjEb3yUqRcytboAe5I5xjv2glJP+do3Nuun2ogW8AAAaTjVyEk65kd1nAN2BQ/foIoRw1KQ7pp7e9+DAr3KD0e1QbPTm7dXDco8e2S5UY0Qd+JWTn3mCQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=rejFLynG1Om2C5wJIwnWmtvtJ4Wt0RgjRblwm8gi+E045lCCSevz2dxsofzjv0WVTc2hjeJ+4+OVMlBW6KLAtZKUF2lLLKTnODiXQwG9KL06Z17zYTqhuL2z8QS2FjOPLJJCXVnkEftitW0EWIy1FS1xNL+G9NRFSNqiRWymJxg=
Received: by 10.86.74.15 with SMTP id w15mr2949496fga.34.1206821190203;
        Sat, 29 Mar 2008 13:06:30 -0700 (PDT)
Received: from ?192.168.0.192? ( [212.145.102.186])
        by mx.google.com with ESMTPS id 4sm3718785fgg.4.2008.03.29.13.06.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Mar 2008 13:06:28 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78480>

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---

   Adding parse-options makes all parameters starting with "-" to
   be treated as options, so setting configure variables with
   values like "-2" or "-my-option" needs to add an explicit
   "--" to stop the arguments' parsing before it reach such value.

   In consequence, those tests setting variable values starting
   with a dash are currently failing with this patch.

   While the "--" solution, IMHO, is the right thing to do because
   this way is easy to discriminate between options and arguments,
   it has the problem of breaking existing code and habits related
   to setting configure variables.

   The parse-options use has some advantages over current solution:

   - Code is more readable, so adding or changing behaviour
     of one option now is easier (git config has too many). A
     possibly related problem was exposed while writing the patch:
     "git-config --replace-all haha" command is not properly
     managed because (I think) current code was distributed
     among many places in the code.

   - Options order is not significative anymore, so those
     weird boolean options "default" and "stdout-is-tty"
     in --get-color and --get-colorboll now could be properly
     called --default and --stdout-is-tty and added in any
     place in command line (I think that they are not options
     already because that reason).

   - Help message now is not only more complete, but makes
     documentation to be more in parallel with the options
     provided by the command, because the -h option shows
     all of them.

   Pierre was developing a way to process those arguments
   starting with a dash to be able to leave them in the argv
   array if you want without stop the parsing, so perhaps
   it could be a solution to support the old behaviour
   and also the new parse-options, but I'm not sure how
   this could be done. Any ideas?

 builtin-config.c |  271 ++++++++++++++++++++++++++++++------------------------
 1 files changed, 152 insertions(+), 119 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index c34bc8b..69d2036 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -1,6 +1,24 @@
 #include "builtin.h"
 #include "cache.h"
 #include "color.h"
+#include "parse-options.h"
+
+static const char * const git_config_usage[] = {
+	"git-config [file] [type] [-z|--null] name [value [value_regex]]",
+	"git-config [file] [type] --add name value",
+	"git-config [file] [type] --replace-all name [value [value_regex]]",
+	"git-config [file] [type] [-z|--null] --get name [value_regex]",
+	"git-config [file] [type] [-z|--null] --get-all name [value_regex]",
+	"git-config [file] [type] [-z|--null] --get-regexp name_regex [value_regex]",
+	"git-config [file] --unset name [value_regex]",
+	"git-config [file] --unset-all name [value_regex]",
+	"git-config [file] --rename-section old_name new_name",
+	"git-config [file] --remove-section name",
+	"git-config [file] [-z|--null] -l | --list",
+	"git-config [file] --get-color name [default]",
+	"git-config [file] --get-colorbool name [stdout-is-tty]",
+	NULL
+};

 static const char git_config_set_usage[] =
 "git-config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty]";
@@ -267,139 +285,154 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	int nongit;
 	char* value;
 	const char *file = setup_git_directory_gently(&nongit);
+	const char *file_arg = NULL;
+	int null = 0, global = 0, system = 0;
+	int ret;
+	enum { A_DEFAULT, A_LIST, A_RENAME_SECT, A_REMOVE_SECT,
+		A_ADD, A_REPLACE_ALL, A_UNSET, A_UNSET_ALL, A_GET,
+		A_GET_ALL, A_GET_REGEXP, A_GET_COLOR, A_GET_COLORBOOL
+	} action = A_DEFAULT;
+	struct option options[] = {
+		OPT_BOOLEAN('z', "null", &null, "secure output format ending values with null"),
+		OPT_SET_INT('l', "list", &action, "list all variables", A_LIST),
+		OPT_SET_INT(0, "rename-section", &action, "rename the given section to a new name", A_RENAME_SECT),
+		OPT_SET_INT(0, "remove-section", &action, "remove the given section from the file", A_REMOVE_SECT),
+		OPT_SET_INT(0, "add", &action, "add a new line to the value of the given key", A_ADD),
+		OPT_SET_INT(0, "replace-all", &action, "replace all variables matching", A_REPLACE_ALL),
+		OPT_SET_INT(0, "get", &action, "show the value for the given key", A_GET),
+		OPT_SET_INT(0, "get-all", &action, "show values of a multivalued key", A_GET_ALL),
+		OPT_SET_INT(0, "get-regexp", &action, "find keys using a regular expression", A_GET_REGEXP),
+		OPT_SET_INT(0, "unset", &action, "remove the given variable", A_UNSET),
+		OPT_SET_INT(0, "unset-all", &action, "remove all variables matching", A_UNSET_ALL),
+		OPT_SET_INT(0, "get-color", &action, "ANSI color escape sequence of given color", A_GET_COLOR),
+		OPT_SET_INT(0, "get-colorbool", &action, "show if given color is set", A_GET_COLORBOOL),
+		OPT_GROUP("file and type options"),
+		OPT_BOOLEAN(0, "global", &global, "use only the user-specific configuration file"),
+		OPT_BOOLEAN(0, "system", &system, "use only the system-wide configuration file"),
+		OPT_STRING('f', "file", &file_arg, "config-file", "use only the given file instead of the others"),
+		OPT_SET_INT(0, "bool", &type, "convert values to type boolean", T_BOOL),
+		OPT_SET_INT(0, "int", &type, "convert values to type integer", T_INT),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, options, git_config_usage, 0);
+
+	if (null) {
+		term = '\0';
+		delim = '\n';
+		key_delim = '\n';
+	}
+
+	if (global) {
+		char *home = getenv("HOME");
+		if (home) {
+			char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
+			setenv(CONFIG_ENVIRONMENT, user_config, 1);
+			free(user_config);
+		} else {
+			die("$HOME not set");
+		}
+	}
+	else if (system)
+		setenv(CONFIG_ENVIRONMENT, git_etc_gitconfig(), 1);
+	else if (file_arg) {
+		if (!is_absolute_path(file_arg) && file)
+			file = prefix_filename(file, strlen(file), file_arg);
+		else
+			file = file_arg;
+		setenv(CONFIG_ENVIRONMENT, file, 1);
+	}

-	while (1 < argc) {
-		if (!strcmp(argv[1], "--int"))
-			type = T_INT;
-		else if (!strcmp(argv[1], "--bool"))
-			type = T_BOOL;
-		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l")) {
-			if (argc != 2)
-				usage(git_config_set_usage);
-			if (git_config(show_all_config) < 0 && file && errno)
-				die("unable to read config file %s: %s", file,
+	switch (action) {
+	case A_LIST:
+		if (argc)
+			usage(git_config_set_usage);
+		if (git_config(show_all_config) < 0 && file && errno)
+			die("unable to read config file %s: %s", file,
 				    strerror(errno));
-			return 0;
+		return 0;
+	case A_RENAME_SECT:
+		if (argc != 2)
+			usage(git_config_set_usage);
+		ret = git_config_rename_section(argv[0], argv[1]);
+		if (ret < 0)
+			return ret;
+		if (ret == 0) {
+			fprintf(stderr, "No such section!\n");
+			return 1;
 		}
-		else if (!strcmp(argv[1], "--global")) {
-			char *home = getenv("HOME");
-			if (home) {
-				char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
-				setenv(CONFIG_ENVIRONMENT, user_config, 1);
-				free(user_config);
-			} else {
-				die("$HOME not set");
-			}
+		return 0;
+	case A_REMOVE_SECT:
+		if (argc != 1)
+			usage(git_config_set_usage);
+		ret = git_config_rename_section(argv[0], NULL);
+		if (ret < 0)
+			return ret;
+		if (ret == 0) {
+			fprintf(stderr, "No such section!\n");
+			return 1;
 		}
-		else if (!strcmp(argv[1], "--system"))
-			setenv(CONFIG_ENVIRONMENT, git_etc_gitconfig(), 1);
-		else if (!strcmp(argv[1], "--file") || !strcmp(argv[1], "-f")) {
-			if (argc < 3)
-				usage(git_config_set_usage);
-			if (!is_absolute_path(argv[2]) && file)
-				file = prefix_filename(file, strlen(file),
-						       argv[2]);
-			else
-				file = argv[2];
-			setenv(CONFIG_ENVIRONMENT, file, 1);
-			argc--;
-			argv++;
+		return 0;
+	case A_ADD:
+		if (argc == 2) {
+			value = normalize_value(argv[0], argv[1]);
+			return git_config_set_multivar(argv[0], value, "^$", 0);
 		}
-		else if (!strcmp(argv[1], "--null") || !strcmp(argv[1], "-z")) {
-			term = '\0';
-			delim = '\n';
-			key_delim = '\n';
+		usage(git_config_set_usage);
+	case A_DEFAULT:
+		if (argc == 1)
+			return get_value(argv[0], NULL);
+		else if (argc == 2) {
+			value = normalize_value(argv[0], argv[1]);
+			return git_config_set(argv[0], value);
 		}
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
+		else if (argc == 3) {
+			value = normalize_value(argv[0], argv[1]);
+			return git_config_set_multivar(argv[0], value, argv[2], 0);
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
-			}
-			return 0;
-		} else if (!strcmp(argv[1], "--get-color")) {
-			return get_color(argc-2, argv+2);
-		} else if (!strcmp(argv[1], "--get-colorbool")) {
-			return get_colorbool(argc-2, argv+2);
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
-		} else {
-			value = normalize_value(argv[1], argv[2]);
-			return git_config_set(argv[1], value);
+		usage(git_config_set_usage);
+	case A_REPLACE_ALL:
+		if (argc == 2) {
+			value = normalize_value(argv[0], argv[1]);
+			return git_config_set_multivar(argv[0], value, NULL, 1);
+		}
+		else if (argc == 3) {
+			value = normalize_value(argv[0], argv[1]);
+			return git_config_set_multivar(argv[0], value, argv[2], 1);
 		}
-	case 4:
-		if (!strcmp(argv[1], "--unset"))
-			return git_config_set_multivar(argv[2], NULL, argv[3], 0);
-		else if (!strcmp(argv[1], "--unset-all"))
-			return git_config_set_multivar(argv[2], NULL, argv[3], 1);
-		else if (!strcmp(argv[1], "--get"))
-			return get_value(argv[2], argv[3]);
-		else if (!strcmp(argv[1], "--get-all")) {
+		usage(git_config_set_usage);
+	case A_UNSET:
+		if (argc == 1)
+			return git_config_set(argv[0], NULL);
+		else if (argc == 2)
+			return git_config_set_multivar(argv[0], NULL, argv[1], 0);
+		usage(git_config_set_usage);
+	case A_UNSET_ALL:
+		if (argc == 1)
+			return git_config_set_multivar(argv[0], NULL, NULL, 1);
+		else if (argc == 2)
+			return git_config_set_multivar(argv[0], NULL, argv[1], 1);
+		usage(git_config_set_usage);
+	case A_GET:
+	case A_GET_ALL:
+	case A_GET_REGEXP:
+		if (action == A_GET_ALL)
 			do_all = 1;
-			return get_value(argv[2], argv[3]);
-		} else if (!strcmp(argv[1], "--get-regexp")) {
+		else if (action == A_GET_REGEXP) {
 			show_keys = 1;
 			use_key_regexp = 1;
 			do_all = 1;
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
 		}
-	case 5:
-		if (!strcmp(argv[1], "--replace-all")) {
-			value = normalize_value(argv[2], argv[3]);
-			return git_config_set_multivar(argv[2], value, argv[4], 1);
-		}
-	case 1:
-	default:
+		if (argc == 1)
+			return get_value(argv[0], NULL);
+		else if (argc == 2)
+			return get_value(argv[0], argv[1]);
 		usage(git_config_set_usage);
+	case A_GET_COLOR:
+		return get_color(argc, argv);
+	case A_GET_COLORBOOL:
+		return get_colorbool(argc, argv);
 	}
+	usage(git_config_set_usage);
 	return 0;
 }
-- 
1.5.3.4
