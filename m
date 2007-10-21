From: Scott R Parish <srp@srparish.net>
Subject: [PATCH] "git help -a" should search all exec_paths and PATH
Date: Sun, 21 Oct 2007 14:48:46 -0700
Message-ID: <20071021214846.GI16291@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 21 23:49:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjifN-00083p-Oo
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 23:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbXJUVsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 17:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbXJUVsu
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 17:48:50 -0400
Received: from smtp-gw7.mailanyone.net ([208.70.128.55]:46065 "EHLO
	smtp-gw7.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbXJUVst (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 17:48:49 -0400
Received: from mailanyone.net
	by smtp-gw7.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1IjifA-00015I-9x
	for git@vger.kernel.org; Sun, 21 Oct 2007 16:48:48 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Sun, 21 Oct 2007 14:48:47 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61911>

Currently "git help -a" only searches in the highest priority exec_path,
meaning at worst, nothing is listed if the git commands are only available
from the PATH. It also makes git slightly less extensible.

To fix this, help.c is modified to search in all the exec_paths and PATH
for potential git commands. So that it has access to all the exec_paths,
exec_cmd.c now exposes the various paths. "current_exec_path" is renamed
as its name is misleading.

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 exec_cmd.c |   26 +++++++++++---
 exec_cmd.h |    3 ++
 git.c      |    2 +-
 help.c     |  103 +++++++++++++++++++++++++++++++++++++++++++-----------------
 4 files changed, 98 insertions(+), 36 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 374ffc9..2c787a4 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -5,21 +5,35 @@
 
 extern char **environ;
 static const char *builtin_exec_path = GIT_EXEC_PATH;
-static const char *current_exec_path;
+static const char *argv_exec_path;
 
-void git_set_exec_path(const char *exec_path)
+void git_set_argv_exec_path(const char *exec_path)
 {
-	current_exec_path = exec_path;
+	argv_exec_path = exec_path;
 }
 
+const char *git_argv_exec_path(void)
+{
+	return argv_exec_path;
+}
+
+const char *git_builtin_exec_path(void)
+{
+	return builtin_exec_path;
+}
+
+const char *git_env_exec_path(void)
+{
+	return getenv(EXEC_PATH_ENVIRONMENT); 
+}
 
 /* Returns the highest-priority, location to look for git programs. */
 const char *git_exec_path(void)
 {
 	const char *env;
 
-	if (current_exec_path)
-		return current_exec_path;
+	if (argv_exec_path)
+		return argv_exec_path;
 
 	env = getenv(EXEC_PATH_ENVIRONMENT);
 	if (env && *env) {
@@ -34,7 +48,7 @@ int execv_git_cmd(const char **argv)
 {
 	char git_command[PATH_MAX + 1];
 	int i;
-	const char *paths[] = { current_exec_path,
+	const char *paths[] = { argv_exec_path,
 				getenv(EXEC_PATH_ENVIRONMENT),
 				builtin_exec_path,
 				"" };
diff --git a/exec_cmd.h b/exec_cmd.h
index 849a839..315fe83 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -3,6 +3,9 @@
 
 extern void git_set_exec_path(const char *exec_path);
 extern const char* git_exec_path(void);
+extern const char* git_argv_exec_path(void);
+extern const char* git_builtin_exec_path(void);
+extern const char* git_env_exec_path(void);
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
 extern int execl_git_cmd(const char *cmd, ...);
 
diff --git a/git.c b/git.c
index 853e66c..b67fb17 100644
--- a/git.c
+++ b/git.c
@@ -51,7 +51,7 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
 		if (!prefixcmp(cmd, "--exec-path")) {
 			cmd += 11;
 			if (*cmd == '=')
-				git_set_exec_path(cmd + 1);
+				git_set_argv_exec_path(cmd + 1);
 			else {
 				puts(git_exec_path());
 				exit(0);
diff --git a/help.c b/help.c
index b0d2dd4..85b2853 100644
--- a/help.c
+++ b/help.c
@@ -93,37 +93,27 @@ static void pretty_print_string_list(struct cmdname **cmdname, int longest)
 	}
 }
 
-static void list_commands(const char *exec_path, const char *pattern)
+static unsigned int list_commands_in_dir(const char *dir, const char *prefix)
 {
 	unsigned int longest = 0;
-	char path[PATH_MAX];
-	int dirlen;
-	DIR *dir = opendir(exec_path);
+	int start_dir = open(".", O_RDONLY, 0);
+	DIR *dirp = opendir(dir);
 	struct dirent *de;
 
-	if (!dir) {
-		fprintf(stderr, "git: '%s': %s\n", exec_path, strerror(errno));
-		exit(1);
+	if (!dirp || chdir(dir)) {
+		fchdir(start_dir);
+		close(start_dir);
+		return 0;
 	}
 
-	dirlen = strlen(exec_path);
-	if (PATH_MAX - 20 < dirlen) {
-		fprintf(stderr, "git: insanely long exec-path '%s'\n",
-			exec_path);
-		exit(1);
-	}
-
-	memcpy(path, exec_path, dirlen);
-	path[dirlen++] = '/';
-
-	while ((de = readdir(dir)) != NULL) {
+	while ((de = readdir(dirp)) != NULL) {
 		struct stat st;
 		int entlen;
-
-		if (prefixcmp(de->d_name, "git-"))
+			
+		if (prefixcmp(de->d_name, prefix))
 			continue;
-		strcpy(path+dirlen, de->d_name);
-		if (stat(path, &st) || /* stat, not lstat */
+
+		if (stat(de->d_name, &st) || /* stat, not lstat */
 		    !S_ISREG(st.st_mode) ||
 		    !(st.st_mode & S_IXUSR))
 			continue;
@@ -137,12 +127,67 @@ static void list_commands(const char *exec_path, const char *pattern)
 
 		add_cmdname(de->d_name + 4, entlen-4);
 	}
-	closedir(dir);
 
-	printf("git commands available in '%s'\n", exec_path);
-	printf("----------------------------");
-	mput_char('-', strlen(exec_path));
-	putchar('\n');
+	closedir(dirp);
+	fchdir(start_dir);
+	close(start_dir);
+
+	return longest;
+}
+
+static unsigned int list_commands_in_PATH(const char *prefix)
+{
+	unsigned int longest = 0;
+	unsigned int len;
+	const char *env_path = getenv("PATH");
+	char *paths, *path, *colon;
+       
+	if (!env_path)
+		return longest;
+
+	path = paths = xstrdup(env_path);
+
+	while ((char *)1 != path) {
+		if ((colon = strchr(path, ':')))
+			*colon = 0;
+
+		len = list_commands_in_dir(path, prefix);
+		longest = MAX(longest, len);
+
+		path = colon + 1;
+	}
+
+	free(paths);
+	return longest;
+}
+
+static void list_commands(const char *prefix)
+{
+	unsigned int longest = 0;
+	unsigned int len;
+	const char *paths[] = { git_argv_exec_path(),
+				git_env_exec_path(),
+				git_builtin_exec_path(),
+				"" };
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(paths); i++) {
+		if (!paths[i])
+			continue;
+
+		if (!*paths[i]) {
+			/* try PATH */
+			len = list_commands_in_PATH(prefix);
+			longest = MAX(longest, len);
+		}
+		else {
+			len = list_commands_in_dir(paths[i], prefix);
+			longest = MAX(longest, len);
+		}
+	}
+
+	printf("available git commands\n");
+	printf("----------------------\n");
 	pretty_print_string_list(cmdname, longest - 4);
 	putchar('\n');
 }
@@ -158,7 +203,7 @@ static void list_common_cmds_help(void)
 
 	puts("The most commonly used git commands are:");
 	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		printf("   %s   ", common_cmds[i].name);
+		printf("   %s	", common_cmds[i].name);
 		mput_char(' ', longest - strlen(common_cmds[i].name));
 		puts(common_cmds[i].help);
 	}
@@ -210,7 +255,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	else if (!strcmp(help_cmd, "--all") || !strcmp(help_cmd, "-a")) {
 		printf("usage: %s\n\n", git_usage_string);
 		if(exec_path)
-			list_commands(exec_path, "git-*");
+			list_commands("git-");
 		exit(0);
 	}
 
-- 
1.5.3.4.209.g5d1ce-dirty
