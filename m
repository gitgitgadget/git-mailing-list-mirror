From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH v2] Allow commit (and tag) messages to be edited when $EDITOR has arguments
Date: Sat, 15 Dec 2007 23:34:08 -0800
Message-ID: <20071216073408.GA5343@midwinter.com>
References: <Pine.LNX.4.64.0712160139580.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 16 08:34:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3o1F-0007mx-66
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 08:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111AbXLPHeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 02:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753662AbXLPHeK
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 02:34:10 -0500
Received: from tater.midwinter.com ([216.32.86.90]:53402 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753394AbXLPHeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 02:34:09 -0500
Received: (qmail 5490 invoked by uid 1001); 16 Dec 2007 07:34:08 -0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712160139580.27959@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68444>

Users who do EDITOR="/usr/bin/emacs -nw" or similar were left unable to
edit commit messages once commit became a builtin, because the editor
launch code assumed that $EDITOR was a single pathname.

This patch makes split_cmdline() a public function as suggested by
Johannes Schindelin, and renames an internal function in git.c to avoid
a name collision.

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
 builtin-tag.c |   14 +++++++++++-
 git.c         |   60 +++-------------------------------------------------
 run-command.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 run-command.h |    2 +
 4 files changed, 84 insertions(+), 57 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 274901a..0a38724 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -47,10 +47,22 @@ void launch_editor(const char *path, struct strbuf *buffer, const char *const *e
 		editor = "vi";
 
 	if (strcmp(editor, ":")) {
-		const char *args[] = { editor, path, NULL };
+		char *editor_copy = xstrdup(editor);
+		char **args;
+		int args_pos;
+
+		args_pos = split_cmdline(editor_copy, &args, 2);
+		if (args_pos < 0)
+			die("Couldn't parse the editor command %s.", editor);
+
+		args[args_pos++] = path;
+		args[args_pos++] = NULL;
 
 		if (run_command_v_opt_cd_env(args, 0, NULL, env))
 			die("There was a problem with the editor %s.", editor);
+
+		free(args);
+		free(editor_copy);
 	}
 
 	if (!buffer)
diff --git a/git.c b/git.c
index 15fec89..3d095ee 100644
--- a/git.c
+++ b/git.c
@@ -2,6 +2,7 @@
 #include "exec_cmd.h"
 #include "cache.h"
 #include "quote.h"
+#include "run-command.h"
 
 const char git_usage_string[] =
 	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
@@ -98,59 +99,6 @@ static int git_alias_config(const char *var, const char *value)
 	return 0;
 }
 
-static int split_cmdline(char *cmdline, const char ***argv)
-{
-	int src, dst, count = 0, size = 16;
-	char quoted = 0;
-
-	*argv = xmalloc(sizeof(char*) * size);
-
-	/* split alias_string */
-	(*argv)[count++] = cmdline;
-	for (src = dst = 0; cmdline[src];) {
-		char c = cmdline[src];
-		if (!quoted && isspace(c)) {
-			cmdline[dst++] = 0;
-			while (cmdline[++src]
-					&& isspace(cmdline[src]))
-				; /* skip */
-			if (count >= size) {
-				size += 16;
-				*argv = xrealloc(*argv, sizeof(char*) * size);
-			}
-			(*argv)[count++] = cmdline + dst;
-		} else if(!quoted && (c == '\'' || c == '"')) {
-			quoted = c;
-			src++;
-		} else if (c == quoted) {
-			quoted = 0;
-			src++;
-		} else {
-			if (c == '\\' && quoted != '\'') {
-				src++;
-				c = cmdline[src];
-				if (!c) {
-					free(*argv);
-					*argv = NULL;
-					return error("cmdline ends with \\");
-				}
-			}
-			cmdline[dst++] = c;
-			src++;
-		}
-	}
-
-	cmdline[dst] = 0;
-
-	if (quoted) {
-		free(*argv);
-		*argv = NULL;
-		return error("unclosed quote");
-	}
-
-	return count;
-}
-
 static int handle_alias(int *argcp, const char ***argv)
 {
 	int nongit = 0, envchanged = 0, ret = 0, saved_errno = errno;
@@ -182,7 +130,7 @@ static int handle_alias(int *argcp, const char ***argv)
 			die("Failed to run '%s' when expanding alias '%s'\n",
 			    alias_string + 1, alias_command);
 		}
-		count = split_cmdline(alias_string, &new_argv);
+		count = split_cmdline(alias_string, &new_argv, 0);
 		option_count = handle_options(&new_argv, &count, &envchanged);
 		if (envchanged)
 			die("alias '%s' changes environment variables\n"
@@ -238,7 +186,7 @@ struct cmd_struct {
 	int option;
 };
 
-static int run_command(struct cmd_struct *p, int argc, const char **argv)
+static int run_git_command(struct cmd_struct *p, int argc, const char **argv)
 {
 	int status;
 	struct stat st;
@@ -380,7 +328,7 @@ static void handle_internal_command(int argc, const char **argv)
 		struct cmd_struct *p = commands+i;
 		if (strcmp(p->cmd, cmd))
 			continue;
-		exit(run_command(p, argc, argv));
+		exit(run_git_command(p, argc, argv));
 	}
 }
 
diff --git a/run-command.c b/run-command.c
index 476d00c..3ae55ec 100644
--- a/run-command.c
+++ b/run-command.c
@@ -237,3 +237,68 @@ int finish_async(struct async *async)
 		ret = error("waitpid (async) failed");
 	return ret;
 }
+
+/*
+ * Parses a command line into an array of char* representing the tokens
+ * on the command line.  Pass in a count to reserve some number of additional
+ * slots in the allocated array, e.g., so the caller can add a filename
+ * argument without having to reallocate the array.
+ *
+ * Returns the number of items in the array or -1 if an error occurred.
+ *
+ * Note that the command line will be altered (nulls will be inserted
+ * where the original had argument-delimiting whitespace.)
+ */
+int split_cmdline(char *cmdline, const char ***argv, int extra_slots)
+{
+	int src, dst, count = 0, size = extra_slots + 16;
+	char quoted = 0;
+
+	*argv = xmalloc(sizeof(char*) * size);
+
+	/* split alias_string */
+	(*argv)[count++] = cmdline;
+	for (src = dst = 0; cmdline[src];) {
+		char c = cmdline[src];
+		if (!quoted && isspace(c)) {
+			cmdline[dst++] = 0;
+			while (cmdline[++src]
+					&& isspace(cmdline[src]))
+				; /* skip */
+			if (count >= size) {
+				size += 16;
+				*argv = xrealloc(*argv, sizeof(char*) * size);
+			}
+			(*argv)[count++] = cmdline + dst;
+		} else if(!quoted && (c == '\'' || c == '"')) {
+			quoted = c;
+			src++;
+		} else if (c == quoted) {
+			quoted = 0;
+			src++;
+		} else {
+			if (c == '\\' && quoted != '\'') {
+				src++;
+				c = cmdline[src];
+				if (!c) {
+					free(*argv);
+					*argv = NULL;
+					return error("cmdline ends with \\");
+				}
+			}
+			cmdline[dst++] = c;
+			src++;
+		}
+	}
+
+	cmdline[dst] = 0;
+
+	if (quoted) {
+		free(*argv);
+		*argv = NULL;
+		return error("unclosed quote");
+	}
+
+	return count;
+}
+
diff --git a/run-command.h b/run-command.h
index 1fc781d..e2b5dea 100644
--- a/run-command.h
+++ b/run-command.h
@@ -66,4 +66,6 @@ struct async {
 int start_async(struct async *async);
 int finish_async(struct async *async);
 
+int split_cmdline(char *cmdline, const char ***argv, int extra_slots);
+
 #endif
-- 
1.5.4.rc0.37.g176bc
