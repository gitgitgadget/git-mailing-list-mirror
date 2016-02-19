From: Jeff King <peff@peff.net>
Subject: [PATCH 11/21] prepare_{git,shell}_cmd: use argv_array
Date: Fri, 19 Feb 2016 06:24:38 -0500
Message-ID: <20160219112438.GK9319@sigill.intra.peff.net>
References: <20160219111941.GA31906@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 12:24:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWjAy-0005V4-Qi
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 12:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426747AbcBSLYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 06:24:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:45269 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423104AbcBSLYk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 06:24:40 -0500
Received: (qmail 20442 invoked by uid 102); 19 Feb 2016 11:24:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 06:24:41 -0500
Received: (qmail 26648 invoked by uid 107); 19 Feb 2016 11:24:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 06:24:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Feb 2016 06:24:38 -0500
Content-Disposition: inline
In-Reply-To: <20160219111941.GA31906@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286695>

These functions transform an existing argv into one suitable
for exec-ing or spawning via git or a shell. We can use an
argv_array in each to avoid dealing with manual counting and
allocation.

This also makes the memory allocation more clear and fixes
some leaks. In prepare_shell_cmd, we would sometimes
allocate a new string with "$@" in it and sometimes not,
meaning the caller could not correctly free it. On the
non-Windows side, we are in a child process which will
exec() or exit() immediately, so the leak isn't a big deal.
On Windows, though, we use spawn() from the parent process,
and leak a string for each shell command we run. On top of
that, the Windows code did not free the allocated argv array
at all (but does for the prepare_git_cmd case!).

By switching both of these functions to write into an
argv_array, we can consistently free the result as
appropriate.

Signed-off-by: Jeff King <peff@peff.net>
---
Note that I had to touch the Windows run-command code here, but I don't
actually have a platform to test it on.

 exec_cmd.c    | 28 +++++++++++-----------------
 exec_cmd.h    |  4 +++-
 run-command.c | 60 +++++++++++++++++++++++++----------------------------------
 3 files changed, 39 insertions(+), 53 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index e85f0fd..cf442a9 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "quote.h"
+#include "argv-array.h"
 #define MAX_ARGS	32
 
 static const char *argv_exec_path;
@@ -107,32 +108,25 @@ void setup_path(void)
 	strbuf_release(&new_path);
 }
 
-const char **prepare_git_cmd(const char **argv)
+const char **prepare_git_cmd(struct argv_array *out, const char **argv)
 {
-	int argc;
-	const char **nargv;
-
-	for (argc = 0; argv[argc]; argc++)
-		; /* just counting */
-	nargv = xmalloc(sizeof(*nargv) * (argc + 2));
-
-	nargv[0] = "git";
-	for (argc = 0; argv[argc]; argc++)
-		nargv[argc + 1] = argv[argc];
-	nargv[argc + 1] = NULL;
-	return nargv;
+	argv_array_push(out, "git");
+	argv_array_pushv(out, argv);
+	return out->argv;
 }
 
 int execv_git_cmd(const char **argv) {
-	const char **nargv = prepare_git_cmd(argv);
-	trace_argv_printf(nargv, "trace: exec:");
+	struct argv_array nargv = ARGV_ARRAY_INIT;
+
+	prepare_git_cmd(&nargv, argv);
+	trace_argv_printf(nargv.argv, "trace: exec:");
 
 	/* execvp() can only ever return if it fails */
-	sane_execvp("git", (char **)nargv);
+	sane_execvp("git", (char **)nargv.argv);
 
 	trace_printf("trace: exec failed: %s\n", strerror(errno));
 
-	free(nargv);
+	argv_array_clear(&nargv);
 	return -1;
 }
 
diff --git a/exec_cmd.h b/exec_cmd.h
index 93b0c02..1f6b433 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -1,11 +1,13 @@
 #ifndef GIT_EXEC_CMD_H
 #define GIT_EXEC_CMD_H
 
+struct argv_array;
+
 extern void git_set_argv_exec_path(const char *exec_path);
 extern const char *git_extract_argv0_path(const char *path);
 extern const char *git_exec_path(void);
 extern void setup_path(void);
-extern const char **prepare_git_cmd(const char **argv);
+extern const char **prepare_git_cmd(struct argv_array *out, const char **argv);
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
 LAST_ARG_MUST_BE_NULL
 extern int execl_git_cmd(const char *cmd, ...);
diff --git a/run-command.c b/run-command.c
index cdf0184..019f6d1 100644
--- a/run-command.c
+++ b/run-command.c
@@ -160,50 +160,41 @@ int sane_execvp(const char *file, char * const argv[])
 	return -1;
 }
 
-static const char **prepare_shell_cmd(const char **argv)
+static const char **prepare_shell_cmd(struct argv_array *out, const char **argv)
 {
-	int argc, nargc = 0;
-	const char **nargv;
-
-	for (argc = 0; argv[argc]; argc++)
-		; /* just counting */
-	/* +1 for NULL, +3 for "sh -c" plus extra $0 */
-	nargv = xmalloc(sizeof(*nargv) * (argc + 1 + 3));
-
-	if (argc < 1)
+	if (!argv[0])
 		die("BUG: shell command is empty");
 
 	if (strcspn(argv[0], "|&;<>()$`\\\"' \t\n*?[#~=%") != strlen(argv[0])) {
 #ifndef GIT_WINDOWS_NATIVE
-		nargv[nargc++] = SHELL_PATH;
+		argv_array_push(out, SHELL_PATH);
 #else
-		nargv[nargc++] = "sh";
+		argv_array_push(out, "sh");
 #endif
-		nargv[nargc++] = "-c";
-
-		if (argc < 2)
-			nargv[nargc++] = argv[0];
-		else {
-			struct strbuf arg0 = STRBUF_INIT;
-			strbuf_addf(&arg0, "%s \"$@\"", argv[0]);
-			nargv[nargc++] = strbuf_detach(&arg0, NULL);
-		}
-	}
+		argv_array_push(out, "-c");
 
-	for (argc = 0; argv[argc]; argc++)
-		nargv[nargc++] = argv[argc];
-	nargv[nargc] = NULL;
+		/*
+		 * If we have no extra arguments, we do not even need to
+		 * bother with the "$@" magic.
+		 */
+		if (!argv[1])
+			argv_array_push(out, argv[0]);
+		else
+			argv_array_pushf(out, "%s \"$@\"", argv[0]);
+	}
 
-	return nargv;
+	argv_array_pushv(out, argv);
+	return out->argv;
 }
 
 #ifndef GIT_WINDOWS_NATIVE
 static int execv_shell_cmd(const char **argv)
 {
-	const char **nargv = prepare_shell_cmd(argv);
-	trace_argv_printf(nargv, "trace: exec:");
-	sane_execvp(nargv[0], (char **)nargv);
-	free(nargv);
+	struct argv_array nargv = ARGV_ARRAY_INIT;
+	prepare_shell_cmd(&nargv, argv);
+	trace_argv_printf(nargv.argv, "trace: exec:");
+	sane_execvp(nargv.argv[0], (char **)nargv.argv);
+	argv_array_clear(&nargv);
 	return -1;
 }
 #endif
@@ -457,6 +448,7 @@ fail_pipe:
 {
 	int fhin = 0, fhout = 1, fherr = 2;
 	const char **sargv = cmd->argv;
+	struct argv_array nargv = ARGV_ARRAY_INIT;
 
 	if (cmd->no_stdin)
 		fhin = open("/dev/null", O_RDWR);
@@ -482,9 +474,9 @@ fail_pipe:
 		fhout = dup(cmd->out);
 
 	if (cmd->git_cmd)
-		cmd->argv = prepare_git_cmd(cmd->argv);
+		cmd->argv = prepare_git_cmd(&nargv, cmd->argv);
 	else if (cmd->use_shell)
-		cmd->argv = prepare_shell_cmd(cmd->argv);
+		cmd->argv = prepare_shell_cmd(&nargv, cmd->argv);
 
 	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, (char**) cmd->env,
 			cmd->dir, fhin, fhout, fherr);
@@ -494,9 +486,7 @@ fail_pipe:
 	if (cmd->clean_on_exit && cmd->pid >= 0)
 		mark_child_for_cleanup(cmd->pid);
 
-	if (cmd->git_cmd)
-		free(cmd->argv);
-
+	argv_array_clear(&nargv);
 	cmd->argv = sargv;
 	if (fhin != 0)
 		close(fhin);
-- 
2.7.1.577.gfed91b8
