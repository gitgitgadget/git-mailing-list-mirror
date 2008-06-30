From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Only use GIT_CONFIG in "git config", not other programs
Date: Mon, 30 Jun 2008 03:37:47 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806300328380.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 09:38:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDDyJ-00008q-65
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 09:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbYF3Hhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 03:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752544AbYF3Hhu
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 03:37:50 -0400
Received: from iabervon.org ([66.92.72.58]:43482 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752333AbYF3Hht (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 03:37:49 -0400
Received: (qmail 24305 invoked by uid 1000); 30 Jun 2008 07:37:47 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jun 2008 07:37:47 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86888>

For everything other than using "git config" to read or write a
git-style config file that isn't the current repo's config file,
GIT_CONFIG was actively detrimental. Rather than argue over which
programs are important enough to have work anyway, just fix all of
them at the root.

Also removes GIT_LOCAL_CONFIG, which would only be useful for programs
that do want to use global git-specific config, but not the repo's own
git-specific config, and want to use some other, presumably
git-specific config. Despite being documented, I can't find any sign that 
it was ever used.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
This passes all of the tests, including the git-svn ones. It seems that, 
in fact, GIT_CONFIG was only used to control "git config" in scripts and 
tests are protected with GIT_CONFIG_NOSYSTEM and GIT_CONFIG_NOGLOBAL.

Along with this, my clone patch makes most sense, because the environment 
variable won't do anything anyway, so we don't have to change it at all.

 Documentation/git-config.txt |    9 --------
 builtin-config.c             |   15 ++++++-------
 cache.h                      |    2 +-
 config.c                     |   47 +++++++++++++++++------------------------
 4 files changed, 28 insertions(+), 45 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index c90421e..30c8432 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -191,11 +191,6 @@ variables. The '--global' and the '--system' options will limit the file used
 to the global or system-wide file respectively. The GIT_CONFIG environment
 variable has a similar effect, but you can specify any filename you want.
 
-The GIT_CONFIG_LOCAL environment variable on the other hand only changes
-the name used instead of the repository configuration file. The global and
-the system-wide configuration files will still be read. (For writing options
-this will obviously result in the same behavior as using GIT_CONFIG.)
-
 
 ENVIRONMENT
 -----------
@@ -205,10 +200,6 @@ GIT_CONFIG::
 	Using the "--global" option forces this to ~/.gitconfig. Using the
 	"--system" option forces this to $(prefix)/etc/gitconfig.
 
-GIT_CONFIG_LOCAL::
-	Take the configuration from the given file instead if .git/config.
-	Still read the global and the system-wide configuration files, though.
-
 See also <<FILES>>.
 
 
diff --git a/builtin-config.c b/builtin-config.c
index 3a441ef..39f63d7 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -81,12 +81,10 @@ static int get_value(const char* key_, const char* regex_)
 	char *global = NULL, *repo_config = NULL;
 	const char *system_wide = NULL, *local;
 
-	local = getenv(CONFIG_ENVIRONMENT);
+	local = config_exclusive_filename;
 	if (!local) {
 		const char *home = getenv("HOME");
-		local = getenv(CONFIG_LOCAL_ENVIRONMENT);
-		if (!local)
-			local = repo_config = xstrdup(git_path("config"));
+		local = repo_config = xstrdup(git_path("config"));
 		if (git_config_global() && home)
 			global = xstrdup(mkpath("%s/.gitconfig", home));
 		if (git_config_system())
@@ -289,6 +287,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	char* value;
 	const char *file = setup_git_directory_gently(&nongit);
 
+	config_exclusive_filename = getenv(CONFIG_ENVIRONMENT);
+
 	while (1 < argc) {
 		if (!strcmp(argv[1], "--int"))
 			type = T_INT;
@@ -309,14 +309,13 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			char *home = getenv("HOME");
 			if (home) {
 				char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
-				setenv(CONFIG_ENVIRONMENT, user_config, 1);
-				free(user_config);
+				config_exclusive_filename = user_config;
 			} else {
 				die("$HOME not set");
 			}
 		}
 		else if (!strcmp(argv[1], "--system"))
-			setenv(CONFIG_ENVIRONMENT, git_etc_gitconfig(), 1);
+			config_exclusive_filename = git_etc_gitconfig();
 		else if (!strcmp(argv[1], "--file") || !strcmp(argv[1], "-f")) {
 			if (argc < 3)
 				usage(git_config_set_usage);
@@ -325,7 +324,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 						       argv[2]);
 			else
 				file = argv[2];
-			setenv(CONFIG_ENVIRONMENT, file, 1);
+			config_exclusive_filename = file;
 			argc--;
 			argv++;
 		}
diff --git a/cache.h b/cache.h
index 64ef86e..bab0115 100644
--- a/cache.h
+++ b/cache.h
@@ -298,7 +298,6 @@ static inline enum object_type object_type(unsigned int mode)
 #define GRAFT_ENVIRONMENT "GIT_GRAFT_FILE"
 #define TEMPLATE_DIR_ENVIRONMENT "GIT_TEMPLATE_DIR"
 #define CONFIG_ENVIRONMENT "GIT_CONFIG"
-#define CONFIG_LOCAL_ENVIRONMENT "GIT_CONFIG_LOCAL"
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
@@ -743,6 +742,7 @@ extern int check_repository_format_version(const char *var, const char *value, v
 extern int git_config_system(void);
 extern int git_config_global(void);
 extern int config_error_nonbool(const char *);
+extern const char *config_exclusive_filename;
 
 #define MAX_GITNAME (1000)
 extern char git_default_email[MAX_GITNAME];
diff --git a/config.c b/config.c
index 58749bf..2862cc4 100644
--- a/config.c
+++ b/config.c
@@ -16,6 +16,8 @@ static int config_linenr;
 static int config_file_eof;
 static int zlib_compression_seen;
 
+const char *config_exclusive_filename = NULL;
+
 static int get_next_char(void)
 {
 	int c;
@@ -611,31 +613,28 @@ int git_config(config_fn_t fn, void *data)
 {
 	int ret = 0;
 	char *repo_config = NULL;
-	const char *home = NULL, *filename;
+	const char *home = NULL;
 
 	/* $GIT_CONFIG makes git read _only_ the given config file,
 	 * $GIT_CONFIG_LOCAL will make it process it in addition to the
 	 * global config file, the same way it would the per-repository
 	 * config file otherwise. */
-	filename = getenv(CONFIG_ENVIRONMENT);
-	if (!filename) {
-		if (git_config_system() && !access(git_etc_gitconfig(), R_OK))
-			ret += git_config_from_file(fn, git_etc_gitconfig(),
-				data);
-		home = getenv("HOME");
-		filename = getenv(CONFIG_LOCAL_ENVIRONMENT);
-		if (!filename)
-			filename = repo_config = xstrdup(git_path("config"));
-	}
+	if (config_exclusive_filename)
+		return git_config_from_file(fn, config_exclusive_filename, data);
+	if (git_config_system() && !access(git_etc_gitconfig(), R_OK))
+		ret += git_config_from_file(fn, git_etc_gitconfig(),
+					    data);
 
+	home = getenv("HOME");
 	if (git_config_global() && home) {
 		char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
 		if (!access(user_config, R_OK))
-			ret = git_config_from_file(fn, user_config, data);
+			ret += git_config_from_file(fn, user_config, data);
 		free(user_config);
 	}
 
-	ret += git_config_from_file(fn, filename, data);
+	repo_config = xstrdup(git_path("config"));
+	ret += git_config_from_file(fn, repo_config, data);
 	free(repo_config);
 	return ret;
 }
@@ -873,13 +872,10 @@ int git_config_set_multivar(const char* key, const char* value,
 	struct lock_file *lock = NULL;
 	const char* last_dot = strrchr(key, '.');
 
-	config_filename = getenv(CONFIG_ENVIRONMENT);
-	if (!config_filename) {
-		config_filename = getenv(CONFIG_LOCAL_ENVIRONMENT);
-		if (!config_filename)
-			config_filename  = git_path("config");
-	}
-	config_filename = xstrdup(config_filename);
+	if (config_exclusive_filename)
+		config_filename = xstrdup(config_exclusive_filename);
+	else
+		config_filename = xstrdup(git_path("config"));
 
 	/*
 	 * Since "key" actually contains the section name and the real
@@ -1136,13 +1132,10 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 	int out_fd;
 	char buf[1024];
 
-	config_filename = getenv(CONFIG_ENVIRONMENT);
-	if (!config_filename) {
-		config_filename = getenv(CONFIG_LOCAL_ENVIRONMENT);
-		if (!config_filename)
-			config_filename  = git_path("config");
-	}
-	config_filename = xstrdup(config_filename);
+	if (config_exclusive_filename)
+		config_filename = xstrdup(config_exclusive_filename);
+	else
+		config_filename = xstrdup(git_path("config"));
 	out_fd = hold_lock_file_for_update(lock, config_filename, 0);
 	if (out_fd < 0) {
 		ret = error("could not lock config file %s", config_filename);
-- 
1.5.6.1.103.g1c643
