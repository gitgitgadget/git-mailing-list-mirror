From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [PATCH 3/4] config: change git_config_with_options() interface
Date: Wed, 19 Feb 2014 00:58:54 +0200
Message-ID: <1392764335-13274-3-git-send-email-kirill@shutemov.name>
References: <1392764335-13274-1-git-send-email-kirill@shutemov.name>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	"Kirill A. Shutemov" <kirill@shutemov.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 23:59:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFtda-0007wD-KW
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 23:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827AbaBRW7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 17:59:18 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:34720 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172AbaBRW7P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 17:59:15 -0500
Received: from node.shutemov.name (80.220.224.16) by jenni1.inet.fi (8.5.140.03)
        id 527750DA08F03665; Wed, 19 Feb 2014 00:59:10 +0200
Received: by node.shutemov.name (Postfix, from userid 1000)
	id 11C1741218; Wed, 19 Feb 2014 00:59:08 +0200 (EET)
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1392764335-13274-1-git-send-email-kirill@shutemov.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242369>

We're going to have more options for config source.

Let's alter git_config_with_options() interface to accept struct with
all source options.

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 builtin/config.c | 75 ++++++++++++++++++++++++++------------------------------
 cache.h          |  8 ++++--
 config.c         | 13 +++++-----
 3 files changed, 47 insertions(+), 49 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index a7c55e68883c..de41ba50e9ca 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -21,8 +21,7 @@ static char key_delim = ' ';
 static char term = '\n';
 
 static int use_global_config, use_system_config, use_local_config;
-static const char *given_config_file;
-static const char *given_config_blob;
+static struct git_config_source given_config_source;
 static int actions, types;
 static const char *get_color_slot, *get_colorbool_slot;
 static int end_null;
@@ -55,8 +54,8 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
 	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
 	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
-	OPT_STRING('f', "file", &given_config_file, N_("file"), N_("use given config file")),
-	OPT_STRING(0, "blob", &given_config_blob, N_("blob-id"), N_("read config from given blob object")),
+	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use given config file")),
+	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read config from given blob object")),
 	OPT_GROUP(N_("Action")),
 	OPT_BIT(0, "get", &actions, N_("get value: name [value-regex]"), ACTION_GET),
 	OPT_BIT(0, "get-all", &actions, N_("get all values: key [value-regex]"), ACTION_GET_ALL),
@@ -224,8 +223,7 @@ static int get_value(const char *key_, const char *regex_)
 	}
 
 	git_config_with_options(collect_config, &values,
-				given_config_file, given_config_blob,
-				respect_includes);
+				&given_config_source, respect_includes);
 
 	ret = !values.nr;
 
@@ -309,8 +307,7 @@ static void get_color(const char *def_color)
 	get_color_found = 0;
 	parsed_color[0] = '\0';
 	git_config_with_options(git_get_color_config, NULL,
-				given_config_file, given_config_blob,
-				respect_includes);
+				&given_config_source, respect_includes);
 
 	if (!get_color_found && def_color)
 		color_parse(def_color, "command line", parsed_color);
@@ -339,8 +336,7 @@ static int get_colorbool(int print)
 	get_diff_color_found = -1;
 	get_color_ui_found = -1;
 	git_config_with_options(git_get_colorbool_config, NULL,
-				given_config_file, given_config_blob,
-				respect_includes);
+				&given_config_source, respect_includes);
 
 	if (get_colorbool_found < 0) {
 		if (!strcmp(get_colorbool_slot, "color.diff"))
@@ -364,7 +360,7 @@ static int get_colorbool(int print)
 
 static void check_write(void)
 {
-	if (given_config_blob)
+	if (given_config_source.blob)
 		die("writing config blobs is not supported");
 }
 
@@ -435,7 +431,7 @@ static int get_urlmatch(const char *var, const char *url)
 	}
 
 	git_config_with_options(urlmatch_config_entry, &config,
-				given_config_file, NULL, respect_includes);
+				&given_config_source, respect_includes);
 
 	for_each_string_list_item(item, &values) {
 		struct urlmatch_current_candidate_value *matched = item->util;
@@ -464,14 +460,14 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	int nongit = !startup_info->have_repository;
 	char *value;
 
-	given_config_file = getenv(CONFIG_ENVIRONMENT);
+	given_config_source.file = getenv(CONFIG_ENVIRONMENT);
 
 	argc = parse_options(argc, argv, prefix, builtin_config_options,
 			     builtin_config_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (use_global_config + use_system_config + use_local_config +
-	    !!given_config_file + !!given_config_blob > 1) {
+	    !!given_config_source.file + !!given_config_source.blob > 1) {
 		error("only one config file at a time.");
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
@@ -493,24 +489,24 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 		if (access_or_warn(user_config, R_OK, 0) &&
 		    xdg_config && !access_or_warn(xdg_config, R_OK, 0))
-			given_config_file = xdg_config;
+			given_config_source.file = xdg_config;
 		else
-			given_config_file = user_config;
+			given_config_source.file = user_config;
 	}
 	else if (use_system_config)
-		given_config_file = git_etc_gitconfig();
+		given_config_source.file = git_etc_gitconfig();
 	else if (use_local_config)
-		given_config_file = git_pathdup("config");
-	else if (given_config_file) {
-		if (!is_absolute_path(given_config_file) && prefix)
-			given_config_file =
+		given_config_source.file = git_pathdup("config");
+	else if (given_config_source.file) {
+		if (!is_absolute_path(given_config_source.file) && prefix)
+			given_config_source.file =
 				xstrdup(prefix_filename(prefix,
 							strlen(prefix),
-							given_config_file));
+							given_config_source.file));
 	}
 
 	if (respect_includes == -1)
-		respect_includes = !given_config_file;
+		respect_includes = !given_config_source.file;
 
 	if (end_null) {
 		term = '\0';
@@ -549,25 +545,24 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	if (actions == ACTION_LIST) {
 		check_argc(argc, 0, 0);
 		if (git_config_with_options(show_all_config, NULL,
-					    given_config_file,
-					    given_config_blob,
+					    &given_config_source,
 					    respect_includes) < 0) {
-			if (given_config_file)
+			if (given_config_source.file)
 				die_errno("unable to read config file '%s'",
-					  given_config_file);
+					  given_config_source.file);
 			else
 				die("error processing config file(s)");
 		}
 	}
 	else if (actions == ACTION_EDIT) {
 		check_argc(argc, 0, 0);
-		if (!given_config_file && nongit)
+		if (!given_config_source.file && nongit)
 			die("not in a git directory");
-		if (given_config_blob)
+		if (given_config_source.blob)
 			die("editing blobs is not supported");
 		git_config(git_default_config, NULL);
-		launch_editor(given_config_file ?
-			      given_config_file : git_path("config"),
+		launch_editor(given_config_source.file ?
+			      given_config_source.file : git_path("config"),
 			      NULL, NULL);
 	}
 	else if (actions == ACTION_SET) {
@@ -575,7 +570,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_write();
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
-		ret = git_config_set_in_file(given_config_file, argv[0], value);
+		ret = git_config_set_in_file(given_config_source.file, argv[0], value);
 		if (ret == CONFIG_NOTHING_SET)
 			error("cannot overwrite multiple values with a single value\n"
 			"       Use a regexp, --add or --replace-all to change %s.", argv[0]);
@@ -585,21 +580,21 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_write();
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set_multivar_in_file(given_config_file,
+		return git_config_set_multivar_in_file(given_config_source.file,
 						       argv[0], value, argv[2], 0);
 	}
 	else if (actions == ACTION_ADD) {
 		check_write();
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set_multivar_in_file(given_config_file,
+		return git_config_set_multivar_in_file(given_config_source.file,
 						       argv[0], value, "^$", 0);
 	}
 	else if (actions == ACTION_REPLACE_ALL) {
 		check_write();
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set_multivar_in_file(given_config_file,
+		return git_config_set_multivar_in_file(given_config_source.file,
 						       argv[0], value, argv[2], 1);
 	}
 	else if (actions == ACTION_GET) {
@@ -626,23 +621,23 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_write();
 		check_argc(argc, 1, 2);
 		if (argc == 2)
-			return git_config_set_multivar_in_file(given_config_file,
+			return git_config_set_multivar_in_file(given_config_source.file,
 							       argv[0], NULL, argv[1], 0);
 		else
-			return git_config_set_in_file(given_config_file,
+			return git_config_set_in_file(given_config_source.file,
 						      argv[0], NULL);
 	}
 	else if (actions == ACTION_UNSET_ALL) {
 		check_write();
 		check_argc(argc, 1, 2);
-		return git_config_set_multivar_in_file(given_config_file,
+		return git_config_set_multivar_in_file(given_config_source.file,
 						       argv[0], NULL, argv[1], 1);
 	}
 	else if (actions == ACTION_RENAME_SECTION) {
 		int ret;
 		check_write();
 		check_argc(argc, 2, 2);
-		ret = git_config_rename_section_in_file(given_config_file,
+		ret = git_config_rename_section_in_file(given_config_source.file,
 							argv[0], argv[1]);
 		if (ret < 0)
 			return ret;
@@ -653,7 +648,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		int ret;
 		check_write();
 		check_argc(argc, 1, 1);
-		ret = git_config_rename_section_in_file(given_config_file,
+		ret = git_config_rename_section_in_file(given_config_source.file,
 							argv[0], NULL);
 		if (ret < 0)
 			return ret;
diff --git a/cache.h b/cache.h
index dc040fb1aa99..9d94bd69f7db 100644
--- a/cache.h
+++ b/cache.h
@@ -1146,6 +1146,11 @@ extern int update_server_info(int);
 #define CONFIG_INVALID_PATTERN 6
 #define CONFIG_GENERIC_ERROR 7
 
+struct git_config_source {
+	const char *file;
+	const char *blob;
+};
+
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
@@ -1155,8 +1160,7 @@ extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern int git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
-				   const char *filename,
-				   const char *blob_ref,
+				   struct git_config_source *config_source,
 				   int respect_includes);
 extern int git_config_early(config_fn_t fn, void *, const char *repo_config);
 extern int git_parse_ulong(const char *, unsigned long *);
diff --git a/config.c b/config.c
index b295310d3c22..a21b0ddadecc 100644
--- a/config.c
+++ b/config.c
@@ -1172,8 +1172,7 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 }
 
 int git_config_with_options(config_fn_t fn, void *data,
-			    const char *filename,
-			    const char *blob_ref,
+			    struct git_config_source *config_source,
 			    int respect_includes)
 {
 	char *repo_config = NULL;
@@ -1191,10 +1190,10 @@ int git_config_with_options(config_fn_t fn, void *data,
 	 * If we have a specific filename, use it. Otherwise, follow the
 	 * regular lookup sequence.
 	 */
-	if (filename)
-		return git_config_from_file(fn, filename, data);
-	else if (blob_ref)
-		return git_config_from_blob_ref(fn, blob_ref, data);
+	if (config_source && config_source->file)
+		return git_config_from_file(fn, config_source->file, data);
+	else if (config_source && config_source->blob)
+		return git_config_from_blob_ref(fn, config_source->blob, data);
 
 	repo_config = git_pathdup("config");
 	ret = git_config_early(fn, data, repo_config);
@@ -1205,7 +1204,7 @@ int git_config_with_options(config_fn_t fn, void *data,
 
 int git_config(config_fn_t fn, void *data)
 {
-	return git_config_with_options(fn, data, NULL, NULL, 1);
+	return git_config_with_options(fn, data, NULL, 1);
 }
 
 /*
-- 
1.9.0.rc3
