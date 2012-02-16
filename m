From: Jeff King <peff@peff.net>
Subject: [PATCH 6/8] config: stop using config_exclusive_filename
Date: Thu, 16 Feb 2012 03:07:32 -0500
Message-ID: <20120216080732.GF11843@sigill.intra.peff.net>
References: <20120216080102.GA11793@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 09:07:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxwNQ-0002iK-4Q
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 09:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467Ab2BPIHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 03:07:35 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38592
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753174Ab2BPIHe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 03:07:34 -0500
Received: (qmail 28086 invoked by uid 107); 16 Feb 2012 08:14:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Feb 2012 03:14:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2012 03:07:32 -0500
Content-Disposition: inline
In-Reply-To: <20120216080102.GA11793@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190881>

The git-config command sometimes operates on the default set
of config files (either reading from all, or writing to repo
config), and sometimes operates on a specific file. In the
latter case, we set the magic global config_exclusive_filename,
and the code in config.c does the right thing.

Instead, let's have git-config use the "advanced" variants
of config.c's functions which let it specify an individual
filename (or NULL for the default). This makes the code a
lot more obvious, and fixes two small bugs:

  1. A relative path specified by GIT_CONFIG=foo will look
     in the wrong directory if we have to chdir as part of
     repository setup. We already handle this properly for
     "git config -f foo", but the GIT_CONFIG lookup used
     config_exclusive_filename directly. By dropping to a
     single magic variable, the GIT_CONFIG case now just
     works.

  2. Calling "git config -f foo --edit" would not respect
     core.editor. This is because just before editing, we
     called git_config, which would respect the
     config_exclusive_filename setting, even though this
     particular git_config call was not about looking in the
     user's specified file, but rather about loading actual
     git config, just as any other git program would.

Signed-off-by: Jeff King <peff@peff.net>
---
The diffstat is slightly disappointing. It really is a one-for-one
conversion in almost every case, but the functions and variable names
are so bloody long that I had to wrap the calls to stay under 80
characters.

 builtin/config.c       |   61 ++++++++++++++++++++++++++++-------------------
 t/t1300-repo-config.sh |   25 +++++++++++++++++++
 2 files changed, 61 insertions(+), 25 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 5a43a3c..8901dd9 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -167,7 +167,7 @@ static int get_value(const char *key_, const char *regex_)
 	config_fn_t fn;
 	void *data;
 
-	local = config_exclusive_filename;
+	local = given_config_file;
 	if (!local) {
 		const char *home = getenv("HOME");
 		local = repo_config = git_pathdup("config");
@@ -315,7 +315,8 @@ static void get_color(const char *def_color)
 {
 	get_color_found = 0;
 	parsed_color[0] = '\0';
-	git_config(git_get_color_config, NULL);
+	git_config_with_options(git_get_color_config, NULL,
+				given_config_file);
 
 	if (!get_color_found && def_color)
 		color_parse(def_color, "command line", parsed_color);
@@ -342,7 +343,8 @@ static int get_colorbool(int print)
 {
 	get_colorbool_found = -1;
 	get_diff_color_found = -1;
-	git_config(git_get_colorbool_config, NULL);
+	git_config_with_options(git_get_colorbool_config, NULL,
+				given_config_file);
 
 	if (get_colorbool_found < 0) {
 		if (!strcmp(get_colorbool_slot, "color.diff"))
@@ -365,7 +367,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	int nongit = !startup_info->have_repository;
 	char *value;
 
-	config_exclusive_filename = getenv(CONFIG_ENVIRONMENT);
+	given_config_file = getenv(CONFIG_ENVIRONMENT);
 
 	argc = parse_options(argc, argv, prefix, builtin_config_options,
 			     builtin_config_usage,
@@ -380,27 +382,27 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		char *home = getenv("HOME");
 		if (home) {
 			char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
-			config_exclusive_filename = user_config;
+			given_config_file = user_config;
 		} else {
 			die("$HOME not set");
 		}
 	}
 	else if (use_system_config)
-		config_exclusive_filename = git_etc_gitconfig();
+		given_config_file = git_etc_gitconfig();
 	else if (use_local_config)
-		config_exclusive_filename = git_pathdup("config");
+		given_config_file = git_pathdup("config");
 	else if (given_config_file) {
 		if (!is_absolute_path(given_config_file) && prefix)
-			config_exclusive_filename =
+			given_config_file =
 				xstrdup(prefix_filename(prefix,
 							strlen(prefix),
 							given_config_file));
 		else
-			config_exclusive_filename = given_config_file;
+			given_config_file = given_config_file;
 	}
 
 	if (respect_includes == -1)
-		respect_includes = !config_exclusive_filename;
+		respect_includes = !given_config_file;
 
 	if (end_null) {
 		term = '\0';
@@ -438,28 +440,29 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 	if (actions == ACTION_LIST) {
 		check_argc(argc, 0, 0);
-		if (git_config(show_all_config, NULL) < 0) {
-			if (config_exclusive_filename)
+		if (git_config_with_options(show_all_config, NULL,
+					    given_config_file) < 0) {
+			if (given_config_file)
 				die_errno("unable to read config file '%s'",
-					  config_exclusive_filename);
+					  given_config_file);
 			else
 				die("error processing config file(s)");
 		}
 	}
 	else if (actions == ACTION_EDIT) {
 		check_argc(argc, 0, 0);
-		if (!config_exclusive_filename && nongit)
+		if (!given_config_file && nongit)
 			die("not in a git directory");
 		git_config(git_default_config, NULL);
-		launch_editor(config_exclusive_filename ?
-			      config_exclusive_filename : git_path("config"),
+		launch_editor(given_config_file ?
+			      given_config_file : git_path("config"),
 			      NULL, NULL);
 	}
 	else if (actions == ACTION_SET) {
 		int ret;
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
-		ret = git_config_set(argv[0], value);
+		ret = git_config_set_in_file(given_config_file, argv[0], value);
 		if (ret == CONFIG_NOTHING_SET)
 			error("cannot overwrite multiple values with a single value\n"
 			"       Use a regexp, --add or --replace-all to change %s.", argv[0]);
@@ -468,17 +471,20 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	else if (actions == ACTION_SET_ALL) {
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set_multivar(argv[0], value, argv[2], 0);
+		return git_config_set_multivar_in_file(given_config_file,
+						       argv[0], value, argv[2], 0);
 	}
 	else if (actions == ACTION_ADD) {
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set_multivar(argv[0], value, "^$", 0);
+		return git_config_set_multivar_in_file(given_config_file,
+						       argv[0], value, "^$", 0);
 	}
 	else if (actions == ACTION_REPLACE_ALL) {
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set_multivar(argv[0], value, argv[2], 1);
+		return git_config_set_multivar_in_file(given_config_file,
+						       argv[0], value, argv[2], 1);
 	}
 	else if (actions == ACTION_GET) {
 		check_argc(argc, 1, 2);
@@ -499,18 +505,22 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	else if (actions == ACTION_UNSET) {
 		check_argc(argc, 1, 2);
 		if (argc == 2)
-			return git_config_set_multivar(argv[0], NULL, argv[1], 0);
+			return git_config_set_multivar_in_file(given_config_file,
+							       argv[0], NULL, argv[1], 0);
 		else
-			return git_config_set(argv[0], NULL);
+			return git_config_set_in_file(given_config_file,
+						      argv[0], NULL);
 	}
 	else if (actions == ACTION_UNSET_ALL) {
 		check_argc(argc, 1, 2);
-		return git_config_set_multivar(argv[0], NULL, argv[1], 1);
+		return git_config_set_multivar_in_file(given_config_file,
+						       argv[0], NULL, argv[1], 1);
 	}
 	else if (actions == ACTION_RENAME_SECTION) {
 		int ret;
 		check_argc(argc, 2, 2);
-		ret = git_config_rename_section(argv[0], argv[1]);
+		ret = git_config_rename_section_in_file(given_config_file,
+							argv[0], argv[1]);
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
@@ -519,7 +529,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	else if (actions == ACTION_REMOVE_SECTION) {
 		int ret;
 		check_argc(argc, 1, 1);
-		ret = git_config_rename_section(argv[0], NULL);
+		ret = git_config_rename_section_in_file(given_config_file,
+							argv[0], NULL);
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 6de46bb..5f249f6 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -458,6 +458,14 @@ test_expect_success 'refer config from subdirectory' '
 
 '
 
+test_expect_success 'refer config from subdirectory via GIT_CONFIG' '
+	(
+		cd x &&
+		GIT_CONFIG=../other-config git config --get ein.bahn >actual &&
+		test_cmp expect actual
+	)
+'
+
 cat > expect << EOF
 [ein]
 	bahn = strasse
@@ -960,4 +968,21 @@ test_expect_success 'git -c complains about empty key and value' '
 	test_must_fail git -c "" rev-parse
 '
 
+test_expect_success 'git config --edit works' '
+	git config -f tmp test.value no &&
+	echo test.value=yes >expect &&
+	GIT_EDITOR="echo [test]value=yes >" git config -f tmp --edit &&
+	git config -f tmp --list >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git config --edit respects core.editor' '
+	git config -f tmp test.value no &&
+	echo test.value=yes >expect &&
+	test_config core.editor "echo [test]value=yes >" &&
+	git config -f tmp --edit &&
+	git config -f tmp --list >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.9.1.4.g8ffed
