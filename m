From: Scott R Parish <sRp@srparish.net>
Subject: [PATCH] allow git to use the PATH for finding subcommands and help
	docs
Date: Thu, 18 Oct 2007 23:59:31 -0700
Message-ID: <20071019065931.GB1463@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 09:30:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IimJl-0007fN-Ki
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 09:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762469AbXJSH3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 03:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755627AbXJSH3p
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 03:29:45 -0400
Received: from smtp-gw3.mailanyone.net ([208.101.54.178]:33860 "EHLO
	smtp-gw3.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbXJSH3o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 03:29:44 -0400
X-Greylist: delayed 1399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Oct 2007 03:29:44 EDT
Received: from mailanyone.net
	by smtp-gw3.mailanyone.net with esmtp (MailAnyone extSMTP)
	id 1Iilw9-0005TW-C4
	for git@vger.kernel.org; Fri, 19 Oct 2007 02:06:25 -0500
Received: from mailanyone.net
	by smtp-gw5.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1Iilpb-0002KK-1F
	for git@vger.kernel.org; Fri, 19 Oct 2007 01:59:39 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Thu, 18 Oct 2007 23:59:32 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61662>

 + check PATH for git_exec_path after other locations but before builtin
 + prepend MANPATH and PERL5LIB in addition to PATH

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 exec_cmd.c |   50 ++++++++++++++++++++++++++++++++++++++-
 git.c      |   76 +++++++++++++++++++++++++++++++++++++++++------------------
 2 files changed, 102 insertions(+), 24 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 9b74ed2..c6ecca9 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -13,19 +13,67 @@ void git_set_exec_path(const char *exec_path)
 }
 
 
+/* Return the first path in PATH that git is found in or NULL if not found */
+char *git_path_from_env(void)
+{
+	const char *env_paths = getenv("PATH");
+	const char *git = "/git";
+	int git_len = strlen(git);
+	char *paths, *path, *colon, *git_path;
+	int path_len;
+	struct stat st;
+
+	if (!env_paths)
+		return NULL;
+
+	path_len = strlen(env_paths);
+	path = paths = xmalloc(path_len + 1);
+	memcpy(paths, env_paths, path_len + 1);
+
+	while ((char *)1 != path) {
+		if ((colon = strchr(path, ':')))
+		    *colon = 0;
+
+		path_len = strlen(path);
+		git_path = xmalloc(path_len + git_len + 1);
+		memcpy(git_path, path, path_len);
+		memcpy(git_path + path_len, git, git_len + 1);
+
+		if (!stat(git_path, &st)) { /* found */
+			free(paths);
+			git_path[path_len] = 0;
+			return git_path;
+		}
+
+		free(git_path);
+		path = colon + 1;
+	}
+
+	free(paths);
+	return NULL;
+}
+
+
 /* Returns the highest-priority, location to look for git programs. */
 const char *git_exec_path(void)
 {
-	const char *env;
+	const char *env, *path;
 
 	if (current_exec_path)
 		return current_exec_path;
 
 	env = getenv(EXEC_PATH_ENVIRONMENT);
 	if (env && *env) {
+		current_exec_path = env;
 		return env;
 	}
 
+	if ((path = git_path_from_env())) {
+		current_exec_path = path;
+		return path;
+	}
+
+	current_exec_path = builtin_exec_path;
 	return builtin_exec_path;
 }
 
diff --git a/git.c b/git.c
index 9eaca1d..252ee7c 100644
--- a/git.c
+++ b/git.c
@@ -6,26 +6,56 @@
 const char git_usage_string[] =
 	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
 
-static void prepend_to_path(const char *dir, int len)
+static void prepend_to_env(const char *env, const char *basedir,
+			   const char *subdir, const char *env_default)
 {
-	const char *old_path = getenv("PATH");
-	char *path;
-	int path_len = len;
-
-	if (!old_path)
-		old_path = "/usr/local/bin:/usr/bin:/bin";
-
-	path_len = len + strlen(old_path) + 1;
-
-	path = xmalloc(path_len + 1);
+	const char *old = getenv(env);
+	int basedir_len = strlen(basedir);
+	int subdir_len = strlen(subdir);
+	char *new;
+	int old_len;
+	
+	if (!old)
+		old = env_default;
+
+	old_len = strlen(old);
+
+	new = xmalloc(basedir_len + subdir_len + old_len + 1);
+	
+	memcpy(new, basedir, basedir_len);
+	memcpy(new + basedir_len, subdir, subdir_len);
+	memcpy(new + basedir_len + subdir_len, old, old_len + 1);
+	
+	if (setenv(env, new, 1))
+		fprintf(stderr, "Setenv failed: %s\n", strerror(errno));
+
+	free(new);
+}
 
-	memcpy(path, dir, len);
-	path[len] = ':';
-	memcpy(path + len + 1, old_path, path_len - len);
+static void prepend_to_envs(const char *dir, int len)
+{
+	char *slash;
+	char *basedir;
+
+	/* basedir is dir with "/bin" stripped off */
+	basedir = xmalloc(len + 1);
+	memcpy(basedir, dir, len + 1);
+	
+	if ((slash = strrchr(basedir, '/'))) {
+		*slash = 0;
+		while (slash == basedir + --len) /* found trailing slash */
+			if ((slash = strrchr(basedir, '/')))
+				*slash = 0;
+	}
 
-	setenv("PATH", path, 1);
+	prepend_to_env("PATH", basedir, "/bin:",
+		       "/usr/local/bin:/usr/bin:/bin");
+	prepend_to_env("MANPATH", basedir, "/share/man:",
+		       "/usr/local/share/man:/usr/share/man");
+	prepend_to_env("PERL5LIB", basedir, "/lib/perl5:",
+		       "/usr/lib/perl5");
 
-	free(path);
+	free(basedir);
 }
 
 static int handle_options(const char*** argv, int* argc, int* envchanged)
@@ -414,8 +444,7 @@ int main(int argc, const char **argv)
 	 */
 	if (slash) {
 		*slash++ = 0;
-		if (*cmd == '/')
-			exec_path = cmd;
+		exec_path = cmd;
 		cmd = slash;
 	}
 
@@ -453,14 +482,15 @@ int main(int argc, const char **argv)
 	/*
 	 * We execute external git command via execv_git_cmd(),
 	 * which looks at "--exec-path" option, GIT_EXEC_PATH
-	 * environment, and $(gitexecdir) in Makefile while built,
-	 * in this order.  For scripted commands, we prepend
-	 * the value of the exec_path variable to the PATH.
+	 * environment, PATH environment, and $(gitexecdir) in
+	 * Makefile while built, in this order.  For scripted
+	 * commands, we prepend the value of the exec_path
+	 * variable to the PATH.
 	 */
 	if (exec_path)
-		prepend_to_path(exec_path, strlen(exec_path));
+		prepend_to_envs(exec_path, strlen(exec_path));
 	exec_path = git_exec_path();
-	prepend_to_path(exec_path, strlen(exec_path));
+	prepend_to_envs(exec_path, strlen(exec_path));
 
 	while (1) {
 		/* See if it's an internal command */
-- 
1.5.3.4.206.g58ba4-dirty
