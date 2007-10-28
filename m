From: Scott R Parish <srp@srparish.net>
Subject: [PATCH 5/7] use only the $PATH for exec'ing git commands
Date: Sun, 28 Oct 2007 04:17:20 -0700
Message-ID: <1193570240-11629-1-git-send-email-srp@srparish.net>
References: <1193474215-6728-5-git-send-email-srp@srparish.net>
Cc: Scott R Parish <srp@srparish.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 12:17:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im69B-00031W-FC
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 12:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbXJ1LRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 07:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbXJ1LRX
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 07:17:23 -0400
Received: from smtp-gw51.mailanyone.net ([208.70.128.77]:53416 "EHLO
	smtp-gw51.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbXJ1LRW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 07:17:22 -0400
Received: from mailanyone.net
	by smtp-gw51.mailanyone.net with esmtp (MailAnyone extSMTP srp)
	id 1Im68u-0000XK-HI; Sun, 28 Oct 2007 06:17:21 -0500
Received: by maple.srparish.net (Postfix, from userid 501)
	id 98FFF4F26ED; Sun, 28 Oct 2007 04:17:20 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.401.g19778-dirty
In-Reply-To: <1193474215-6728-5-git-send-email-srp@srparish.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62555>

We need to correctly set up $PATH for non-c based git commands.
Since we already do this, we can just use that $PATH and execvp,
instead of looping over the paths with execve.

This patch adds a setup_path() function to exec_cmd.c, which sets
the $PATH order correctly for our search order. execv_git_cmd() is
stripped down to setting up argv and calling execvp(). git.c's
main() only only needs to call setup_path().

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 exec_cmd.c |  121 ++++++++++++++++++++++++++----------------------------------
 exec_cmd.h |    1 +
 git.c      |   43 +++------------------
 3 files changed, 60 insertions(+), 105 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 8b681d0..53d0f3c 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -29,85 +29,68 @@ const char *git_exec_path(void)
 	return builtin_exec_path;
 }
 
+static void add_path(struct strbuf *out, const char *path)
+{
+	if (path && *path) {
+		if (is_absolute_path(path))
+			strbuf_addstr(out, path);
+		else
+			strbuf_addstr(out, make_absolute_path(path));
+
+		strbuf_addch(out, ':');
+	}
+}
+
+void setup_path(const char *cmd_path)
+{
+	const char *old_path = getenv("PATH");
+	struct strbuf new_path;
+
+	strbuf_init(&new_path, 0);
+
+	add_path(&new_path, argv_exec_path);
+	add_path(&new_path, getenv(EXEC_PATH_ENVIRONMENT));
+	add_path(&new_path, builtin_exec_path);
+	add_path(&new_path, cmd_path);
+
+	if (old_path)
+		strbuf_addstr(&new_path, old_path);
+	else
+		strbuf_addstr(&new_path, "/usr/local/bin:/usr/bin:/bin");
+
+	setenv("PATH", new_path.buf, 1);
+
+	strbuf_release(&new_path);
+}
 
 int execv_git_cmd(const char **argv)
 {
-	char git_command[PATH_MAX + 1];
-	int i;
-	const char *paths[] = { argv_exec_path,
-				getenv(EXEC_PATH_ENVIRONMENT),
-				builtin_exec_path };
-
-	for (i = 0; i < ARRAY_SIZE(paths); ++i) {
-		size_t len;
-		int rc;
-		const char *exec_dir = paths[i];
-		const char *tmp;
-
-		if (!exec_dir || !*exec_dir) continue;
-
-		if (*exec_dir != '/') {
-			if (!getcwd(git_command, sizeof(git_command))) {
-				fprintf(stderr, "git: cannot determine "
-					"current directory: %s\n",
-					strerror(errno));
-				break;
-			}
-			len = strlen(git_command);
-
-			/* Trivial cleanup */
-			while (!prefixcmp(exec_dir, "./")) {
-				exec_dir += 2;
-				while (*exec_dir == '/')
-					exec_dir++;
-			}
-
-			rc = snprintf(git_command + len,
-				      sizeof(git_command) - len, "/%s",
-				      exec_dir);
-			if (rc < 0 || rc >= sizeof(git_command) - len) {
-				fprintf(stderr, "git: command name given "
-					"is too long.\n");
-				break;
-			}
-		} else {
-			if (strlen(exec_dir) + 1 > sizeof(git_command)) {
-				fprintf(stderr, "git: command name given "
-					"is too long.\n");
-				break;
-			}
-			strcpy(git_command, exec_dir);
-		}
-
-		len = strlen(git_command);
-		rc = snprintf(git_command + len, sizeof(git_command) - len,
-			      "/git-%s", argv[0]);
-		if (rc < 0 || rc >= sizeof(git_command) - len) {
-			fprintf(stderr,
-				"git: command name given is too long.\n");
-			break;
-		}
+	struct strbuf cmd;
+	const char *tmp;
 
-		/* argv[0] must be the git command, but the argv array
-		 * belongs to the caller, and my be reused in
-		 * subsequent loop iterations. Save argv[0] and
-		 * restore it on error.
-		 */
+	strbuf_init(&cmd, 0);
+	strbuf_addf(&cmd, "git-%s", argv[0]);
 
-		tmp = argv[0];
-		argv[0] = git_command;
+	/* argv[0] must be the git command, but the argv array
+	 * belongs to the caller, and my be reused in
+	 * subsequent loop iterations. Save argv[0] and
+	 * restore it on error.
+	 */
+	tmp = argv[0];
+	argv[0] = cmd.buf;
 
-		trace_argv_printf(argv, -1, "trace: exec:");
+	trace_argv_printf(argv, -1, "trace: exec:");
 
-		/* execve() can only ever return if it fails */
-		execve(git_command, (char **)argv, environ);
+	/* execvp() can only ever return if it fails */
+	execvp(cmd.buf, (char **)argv);
 
-		trace_printf("trace: exec failed: %s\n", strerror(errno));
+	trace_printf("trace: exec failed: %s\n", strerror(errno));
 
-		argv[0] = tmp;
-	}
-	return -1;
+	argv[0] = tmp;
 
+	strbuf_release(&cmd);
+
+	return -1;
 }
 
 
diff --git a/exec_cmd.h b/exec_cmd.h
index da99287..a892355 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -3,6 +3,7 @@
 
 extern void git_set_argv_exec_path(const char *exec_path);
 extern const char* git_exec_path(void);
+extern void setup_path(const char *);
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
 extern int execl_git_cmd(const char *cmd, ...);
 
diff --git a/git.c b/git.c
index c7cabf5..4e10581 100644
--- a/git.c
+++ b/git.c
@@ -6,28 +6,6 @@
 const char git_usage_string[] =
 	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
 
-static void prepend_to_path(const char *dir, int len)
-{
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
-
-	memcpy(path, dir, len);
-	path[len] = ':';
-	memcpy(path + len + 1, old_path, path_len - len);
-
-	setenv("PATH", path, 1);
-
-	free(path);
-}
-
 static int handle_options(const char*** argv, int* argc, int* envchanged)
 {
 	int handled = 0;
@@ -408,7 +386,7 @@ int main(int argc, const char **argv)
 {
 	const char *cmd = argv[0] ? argv[0] : "git-help";
 	char *slash = strrchr(cmd, '/');
-	const char *exec_path = NULL;
+	const char *cmd_path = NULL;
 	int done_alias = 0;
 
 	/*
@@ -418,10 +396,7 @@ int main(int argc, const char **argv)
 	 */
 	if (slash) {
 		*slash++ = 0;
-		if (*cmd == '/')
-			exec_path = cmd;
-		else
-			exec_path = xstrdup(make_absolute_path(cmd));
+		cmd_path = cmd;
 		cmd = slash;
 	}
 
@@ -458,16 +433,12 @@ int main(int argc, const char **argv)
 	cmd = argv[0];
 
 	/*
-	 * We execute external git command via execv_git_cmd(),
-	 * which looks at "--exec-path" option, GIT_EXEC_PATH
-	 * environment, and $(gitexecdir) in Makefile while built,
-	 * in this order.  For scripted commands, we prepend
-	 * the value of the exec_path variable to the PATH.
+	 * We use PATH to find git commands, but we prepend some higher
+	 * precidence paths: the "--exec-path" option, the GIT_EXEC_PATH
+	 * environment, and the $(gitexecdir) from the Makefile at build
+	 * time.
 	 */
-	if (exec_path)
-		prepend_to_path(exec_path, strlen(exec_path));
-	exec_path = git_exec_path();
-	prepend_to_path(exec_path, strlen(exec_path));
+	setup_path(cmd_path);
 
 	while (1) {
 		/* See if it's an internal command */
-- 
1.5.3.4.401.g19778-dirty
