From: Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Subject: [PATCHv7 1/4] Read (but not write) from $XDG_CONFIG_HOME/git/config file
Date: Tue, 12 Jun 2012 04:49:53 +0200
Message-ID: <1339469396-29677-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
References: <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Cc: Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 04:50:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeHBK-0003Vn-36
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 04:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836Ab2FLCuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 22:50:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58341 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740Ab2FLCuE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 22:50:04 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5C2f1M7024200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Jun 2012 04:41:01 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5C2numj024468;
	Tue, 12 Jun 2012 04:49:56 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q5C2nupa029861;
	Tue, 12 Jun 2012 04:49:56 +0200
Received: (from nguyenhu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q5C2nuEh029860;
	Tue, 12 Jun 2012 04:49:56 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 12 Jun 2012 04:41:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5C2f1M7024200
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: huynh-khoi-nguyen.nguyen@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1340073663.97735@OZIJRkmEnuD2dPAlmW6fjg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199760>

Git will be able to read from $XDG_CONFIG_HOME/git/config, a new
configuration file following XDG specification. In the order of
reading, this file is between global configuration file and system
wide configuration file. Git currently does not write to this new
configuration file. If $XDG_CONFIG_HOME is either not set or empty,
$HOME/.config/git/config will be used.

Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 Documentation/git-config.txt |   12 +++++--
 builtin/config.c             |   28 +++++++++++-----
 cache.h                      |    3 ++
 config.c                     |   23 ++++++++-----
 path.c                       |   41 ++++++++++++++++++++++++
 t/t1306-xdg-files.sh         |   70 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 156 insertions(+), 21 deletions(-)
 create mode 100755 t/t1306-xdg-files.sh

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index d9463cb..7e344a2 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -99,8 +99,8 @@ OPTIONS
 	For writing options: write to global ~/.gitconfig file rather than
 	the repository .git/config.
 +
-For reading options: read only from global ~/.gitconfig rather than
-from all available files.
+For reading options: read only from global ~/.gitconfig and from
+$XDG_CONFIG_HOME/git/config rather than from all available files.
 +
 See also <<FILES>>.
 
@@ -194,7 +194,7 @@ See also <<FILES>>.
 FILES
 -----
 
-If not set explicitly with '--file', there are three files where
+If not set explicitly with '--file', there are four files where
 'git config' will search for configuration options:
 
 $GIT_DIR/config::
@@ -204,6 +204,12 @@ $GIT_DIR/config::
 	User-specific configuration file. Also called "global"
 	configuration file.
 
+$XDG_CONFIG_HOME/git/config::
+	Second user-specific configuration file. If $XDG_CONFIG_HOME is not set
+	or empty, $HOME/.config/git/config will be used. Any single-valued
+	variable set in this file will be overwritten by whatever is in
+	~/.gitconfig.
+
 $(prefix)/etc/gitconfig::
 	System-wide configuration file.
 
diff --git a/builtin/config.c b/builtin/config.c
index 33c8820..da54fd1 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -161,7 +161,7 @@ static int show_config(const char *key_, const char *value_, void *cb)
 static int get_value(const char *key_, const char *regex_)
 {
 	int ret = -1;
-	char *global = NULL, *repo_config = NULL;
+	char *global = NULL, *xdg = NULL, *repo_config = NULL;
 	const char *system_wide = NULL, *local;
 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
 	config_fn_t fn;
@@ -169,12 +169,10 @@ static int get_value(const char *key_, const char *regex_)
 
 	local = given_config_file;
 	if (!local) {
-		const char *home = getenv("HOME");
 		local = repo_config = git_pathdup("config");
-		if (home)
-			global = xstrdup(mkpath("%s/.gitconfig", home));
 		if (git_config_system())
 			system_wide = git_etc_gitconfig();
+		home_config_paths(&global, &xdg, "config");
 	}
 
 	if (use_key_regexp) {
@@ -229,6 +227,8 @@ static int get_value(const char *key_, const char *regex_)
 
 	if (do_all && system_wide)
 		git_config_from_file(fn, system_wide, data);
+	if (do_all && xdg)
+		git_config_from_file(fn, xdg, data);
 	if (do_all && global)
 		git_config_from_file(fn, global, data);
 	if (do_all)
@@ -238,6 +238,8 @@ static int get_value(const char *key_, const char *regex_)
 		git_config_from_file(fn, local, data);
 	if (!do_all && !seen && global)
 		git_config_from_file(fn, global, data);
+	if (!do_all && !seen && xdg)
+		git_config_from_file(fn, xdg, data);
 	if (!do_all && !seen && system_wide)
 		git_config_from_file(fn, system_wide, data);
 
@@ -255,6 +257,7 @@ static int get_value(const char *key_, const char *regex_)
 free_strings:
 	free(repo_config);
 	free(global);
+	free(xdg);
 	return ret;
 }
 
@@ -379,13 +382,20 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 
 	if (use_global_config) {
-		char *home = getenv("HOME");
-		if (home) {
-			char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
+		char *user_config = NULL;
+		char *xdg_config = NULL;
+
+		home_config_paths(&user_config, &xdg_config, "config");
+
+		if (access(user_config, R_OK) && !access(xdg_config, R_OK) &&
+		    (actions == ACTION_LIST ||
+		     actions == ACTION_GET_COLOR ||
+		     actions == ACTION_GET_COLORBOOL))
+			given_config_file = xdg_config;
+		else if (user_config)
 			given_config_file = user_config;
-		} else {
+		else
 			die("$HOME not set");
-		}
 	}
 	else if (use_system_config)
 		given_config_file = git_etc_gitconfig();
diff --git a/cache.h b/cache.h
index 06413e1..fbba2d6 100644
--- a/cache.h
+++ b/cache.h
@@ -619,6 +619,8 @@ extern char *git_snpath(char *buf, size_t n, const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 extern char *git_pathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
+extern char *mkpathdup(const char *fmt, ...)
+	__attribute__((format (printf, 1, 2)));
 
 /* Return a statically allocated filename matching the sha1 signature */
 extern char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
@@ -708,6 +710,7 @@ int set_shared_perm(const char *path, int mode);
 int safe_create_leading_directories(char *path);
 int safe_create_leading_directories_const(const char *path);
 int mkdir_in_gitdir(const char *path);
+extern void home_config_paths(char **global, char **xdg, char *file);
 extern char *expand_user_path(const char *path);
 const char *enter_repo(const char *path, int strict);
 static inline int is_absolute_path(const char *path)
diff --git a/config.c b/config.c
index 71ef171..d28a499 100644
--- a/config.c
+++ b/config.c
@@ -929,7 +929,10 @@ int git_config_system(void)
 int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 {
 	int ret = 0, found = 0;
-	const char *home = NULL;
+	char *xdg_config = NULL;
+	char *user_config = NULL;
+
+	home_config_paths(&user_config, &xdg_config, "config");
 
 	if (git_config_system() && !access(git_etc_gitconfig(), R_OK)) {
 		ret += git_config_from_file(fn, git_etc_gitconfig(),
@@ -937,14 +940,14 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 		found += 1;
 	}
 
-	home = getenv("HOME");
-	if (home) {
-		char buf[PATH_MAX];
-		char *user_config = mksnpath(buf, sizeof(buf), "%s/.gitconfig", home);
-		if (!access(user_config, R_OK)) {
-			ret += git_config_from_file(fn, user_config, data);
-			found += 1;
-		}
+	if (!access(xdg_config, R_OK)) {
+		ret += git_config_from_file(fn, xdg_config, data);
+		found += 1;
+	}
+
+	if (!access(user_config, R_OK)) {
+		ret += git_config_from_file(fn, user_config, data);
+		found += 1;
 	}
 
 	if (repo_config && !access(repo_config, R_OK)) {
@@ -963,6 +966,8 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 		break;
 	}
 
+	free(xdg_config);
+	free(user_config);
 	return ret == 0 ? found : ret;
 }
 
diff --git a/path.c b/path.c
index 6f2aa69..66acd24 100644
--- a/path.c
+++ b/path.c
@@ -87,6 +87,21 @@ char *git_pathdup(const char *fmt, ...)
 	return xstrdup(path);
 }
 
+char *mkpathdup(const char *fmt, ...)
+{
+	char *path;
+	struct strbuf sb = STRBUF_INIT;
+	va_list args;
+
+	va_start(args, fmt);
+	strbuf_vaddf(&sb, fmt, args);
+	va_end(args);
+	path = xstrdup(cleanup_path(sb.buf));
+
+	strbuf_release(&sb);
+	return path;
+}
+
 char *mkpath(const char *fmt, ...)
 {
 	va_list args;
@@ -122,6 +137,32 @@ char *git_path(const char *fmt, ...)
 	return cleanup_path(pathname);
 }
 
+void home_config_paths(char **global, char **xdg, char *file)
+{
+	char *xdg_home = getenv("XDG_CONFIG_HOME");
+	char *home = getenv("HOME");
+	char *to_free = NULL;
+
+	if (!home) {
+		if (global)
+			*global = NULL;
+	} else {
+		if (!xdg_home) {
+			to_free = mkpathdup("%s/.config", home);
+			xdg_home = to_free;
+		}
+		if (global)
+			*global = mkpathdup("%s/.gitconfig", home);
+	}
+
+	if (!xdg_home)
+		*xdg = NULL;
+	else
+		*xdg = mkpathdup("%s/git/%s", xdg_home, file);
+
+	free(to_free);
+}
+
 char *git_path_submodule(const char *path, const char *fmt, ...)
 {
 	char *pathname = get_pathname();
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
new file mode 100755
index 0000000..5b971d9
--- /dev/null
+++ b/t/t1306-xdg-files.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Valentin Duperray, Lucien Kong, Franck Jonas,
+#		     Thomas Nguy, Khoi Nguyen
+#		     Grenoble INP Ensimag
+#
+
+test_description='Compatibility with $XDG_CONFIG_HOME/git/ files'
+
+. ./test-lib.sh
+
+test_expect_success 'read config: xdg file exists and ~/.gitconfig doesn'\''t' '
+	mkdir -p .config/git &&
+	echo "[alias]" >.config/git/config &&
+	echo "	myalias = !echo in_config" >>.config/git/config &&
+	echo in_config >expected &&
+	git myalias >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'read config: xdg file exists and ~/.gitconfig exists' '
+	>.gitconfig &&
+	echo "[alias]" >.gitconfig &&
+	echo "	myalias = !echo in_gitconfig" >>.gitconfig &&
+	echo in_gitconfig >expected &&
+	git myalias >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'read with --get: xdg file exists and ~/.gitconfig doesn'\''t' '
+	rm .gitconfig &&
+	echo "[user]" >.config/git/config &&
+	echo "	name = read_config" >>.config/git/config &&
+	echo read_config >expected &&
+	git config --get user.name >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'read with --get: xdg file exists and ~/.gitconfig exists' '
+	>.gitconfig &&
+	echo "[user]" >.gitconfig &&
+	echo "	name = read_gitconfig" >>.gitconfig &&
+	echo read_gitconfig >expected &&
+	git config --get user.name >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'read with --list: xdg file exists and ~/.gitconfig doesn'\''t' '
+	rm .gitconfig &&
+	echo user.name=read_config >expected &&
+	git config --global --list >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'read with --list: xdg file exists and ~/.gitconfig exists' '
+	>.gitconfig &&
+	echo "[user]" >.gitconfig &&
+	echo "	name = read_gitconfig" >>.gitconfig &&
+	echo user.name=read_gitconfig >expected &&
+	git config --global --list >actual &&
+	test_cmp expected actual
+'
+
+
+test_done
-- 
1.7.8
