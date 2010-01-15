From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 4/7] Windows: avoid the "dup dance" when spawning a child process
Date: Fri, 15 Jan 2010 21:12:18 +0100
Message-ID: <35ff76cadd57787b2ff433abb44e6fdc7c115e85.1263584975.git.j6t@kdbg.org>
References: <cover.1262895936.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: msysgit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 21:13:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVsYN-0004sM-Ee
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 21:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758175Ab0AOUNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 15:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758152Ab0AOUNt
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 15:13:49 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:31621 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758169Ab0AOUNs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 15:13:48 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 19700A7EBA;
	Fri, 15 Jan 2010 21:13:47 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7A75819F60D;
	Fri, 15 Jan 2010 21:12:50 +0100 (CET)
X-Mailer: git-send-email 1.6.6.218.g3e6eb
In-Reply-To: <cover.1262895936.git.j6t@kdbg.org>
In-Reply-To: <cover.1263584975.git.j6t@kdbg.org>
References: <cover.1263584975.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137110>

When stdin, stdout, or stderr must be redirected for a child process that
on Windows is spawned using one of the spawn() functions of Microsoft's
C runtime, then there is no choice other than to

1. make a backup copy of fd 0,1,2 with dup
2. dup2 the redirection source fd into 0,1,2
3. spawn
4. dup2 the backup back into 0,1,2
5. close the backup copy and the redirection source

We used this idiom as well -- but we are not using the spawn() functions
anymore!

Instead, we have our own implementation. We had hardcoded that stdin,
stdout, and stderr of the child process were inherited from the parent's
fds 0, 1, and 2. But we can actually specify any fd.

With this patch, the fds to inherit are passed from start_command()'s
WIN32 section to our spawn implementation. This way, we can avoid the
backup copies of the fds.

The backup copies were a bug waiting to surface: The OS handles underlying
the dup()ed fds were inherited by the child process (but were not
associated with a file descriptor in the child). Consequently, the file or
pipe represented by the OS handle remained open even after the backup copy
was closed in the parent process until the child exited.

Since our implementation of pipe() creates non-inheritable OS handles, we
still dup() file descriptors in start_command() because dup() happens to
create inheritable duplicates. (A nice side effect is that the fd cleanup
in start_command is the same for Windows and Unix and remains unchanged.)

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Commit message slightly changed.

 compat/mingw.c |   25 +++++++++++++------
 compat/mingw.h |    3 +-
 run-command.c  |   71 ++++++++++++++++++++++++-------------------------------
 3 files changed, 50 insertions(+), 49 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 162d1ff..7376247 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -615,8 +615,8 @@ static int env_compare(const void *a, const void *b)
 	return strcasecmp(*ea, *eb);
 }
 
-static pid_t mingw_spawnve(const char *cmd, const char **argv, char **env,
-			   int prepend_cmd)
+static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
+			      int prepend_cmd, int fhin, int fhout, int fherr)
 {
 	STARTUPINFO si;
 	PROCESS_INFORMATION pi;
@@ -652,9 +652,9 @@ static pid_t mingw_spawnve(const char *cmd, const char **argv, char **env,
 	memset(&si, 0, sizeof(si));
 	si.cb = sizeof(si);
 	si.dwFlags = STARTF_USESTDHANDLES;
-	si.hStdInput = (HANDLE) _get_osfhandle(0);
-	si.hStdOutput = (HANDLE) _get_osfhandle(1);
-	si.hStdError = (HANDLE) _get_osfhandle(2);
+	si.hStdInput = (HANDLE) _get_osfhandle(fhin);
+	si.hStdOutput = (HANDLE) _get_osfhandle(fhout);
+	si.hStdError = (HANDLE) _get_osfhandle(fherr);
 
 	/* concatenate argv, quoting args as we go */
 	strbuf_init(&args, 0);
@@ -709,7 +709,14 @@ static pid_t mingw_spawnve(const char *cmd, const char **argv, char **env,
 	return (pid_t)pi.hProcess;
 }
 
-pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env)
+static pid_t mingw_spawnve(const char *cmd, const char **argv, char **env,
+			   int prepend_cmd)
+{
+	return mingw_spawnve_fd(cmd, argv, env, prepend_cmd, 0, 1, 2);
+}
+
+pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env,
+		     int fhin, int fhout, int fherr)
 {
 	pid_t pid;
 	char **path = get_path_split();
@@ -731,13 +738,15 @@ pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env)
 				pid = -1;
 			}
 			else {
-				pid = mingw_spawnve(iprog, argv, env, 1);
+				pid = mingw_spawnve_fd(iprog, argv, env, 1,
+						       fhin, fhout, fherr);
 				free(iprog);
 			}
 			argv[0] = argv0;
 		}
 		else
-			pid = mingw_spawnve(prog, argv, env, 0);
+			pid = mingw_spawnve_fd(prog, argv, env, 0,
+					       fhin, fhout, fherr);
 		free(prog);
 	}
 	free_path_split(path);
diff --git a/compat/mingw.h b/compat/mingw.h
index b3d299f..a105dc9 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -220,7 +220,8 @@ int mingw_fstat(int fd, struct stat *buf);
 int mingw_utime(const char *file_name, const struct utimbuf *times);
 #define utime mingw_utime
 
-pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env);
+pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env,
+		     int fhin, int fhout, int fherr);
 void mingw_execvp(const char *cmd, char *const *argv);
 #define execvp mingw_execvp
 
diff --git a/run-command.c b/run-command.c
index cf2d8f7..d270664 100644
--- a/run-command.c
+++ b/run-command.c
@@ -8,12 +8,14 @@ static inline void close_pair(int fd[2])
 	close(fd[1]);
 }
 
+#ifndef WIN32
 static inline void dup_devnull(int to)
 {
 	int fd = open("/dev/null", O_RDWR);
 	dup2(fd, to);
 	close(fd);
 }
+#endif
 
 int start_command(struct child_process *cmd)
 {
@@ -135,42 +137,30 @@ fail_pipe:
 			strerror(failed_errno = errno));
 #else
 {
-	int s0 = -1, s1 = -1, s2 = -1;	/* backups of stdin, stdout, stderr */
+	int fhin = 0, fhout = 1, fherr = 2;
 	const char **sargv = cmd->argv;
 	char **env = environ;
 
-	if (cmd->no_stdin) {
-		s0 = dup(0);
-		dup_devnull(0);
-	} else if (need_in) {
-		s0 = dup(0);
-		dup2(fdin[0], 0);
-	} else if (cmd->in) {
-		s0 = dup(0);
-		dup2(cmd->in, 0);
-	}
-
-	if (cmd->no_stderr) {
-		s2 = dup(2);
-		dup_devnull(2);
-	} else if (need_err) {
-		s2 = dup(2);
-		dup2(fderr[1], 2);
-	}
-
-	if (cmd->no_stdout) {
-		s1 = dup(1);
-		dup_devnull(1);
-	} else if (cmd->stdout_to_stderr) {
-		s1 = dup(1);
-		dup2(2, 1);
-	} else if (need_out) {
-		s1 = dup(1);
-		dup2(fdout[1], 1);
-	} else if (cmd->out > 1) {
-		s1 = dup(1);
-		dup2(cmd->out, 1);
-	}
+	if (cmd->no_stdin)
+		fhin = open("/dev/null", O_RDWR);
+	else if (need_in)
+		fhin = dup(fdin[0]);
+	else if (cmd->in)
+		fhin = dup(cmd->in);
+
+	if (cmd->no_stderr)
+		fherr = open("/dev/null", O_RDWR);
+	else if (need_err)
+		fherr = dup(fderr[1]);
+
+	if (cmd->no_stdout)
+		fhout = open("/dev/null", O_RDWR);
+	else if (cmd->stdout_to_stderr)
+		fhout = dup(fherr);
+	else if (need_out)
+		fhout = dup(fdout[1]);
+	else if (cmd->out > 1)
+		fhout = dup(cmd->out);
 
 	if (cmd->dir)
 		die("chdir in start_command() not implemented");
@@ -181,7 +171,8 @@ fail_pipe:
 		cmd->argv = prepare_git_cmd(cmd->argv);
 	}
 
-	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, env);
+	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, env,
+				  fhin, fhout, fherr);
 	failed_errno = errno;
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
 		error("cannot spawn %s: %s", cmd->argv[0], strerror(errno));
@@ -192,12 +183,12 @@ fail_pipe:
 		free(cmd->argv);
 
 	cmd->argv = sargv;
-	if (s0 >= 0)
-		dup2(s0, 0), close(s0);
-	if (s1 >= 0)
-		dup2(s1, 1), close(s1);
-	if (s2 >= 0)
-		dup2(s2, 2), close(s2);
+	if (fhin != 0)
+		close(fhin);
+	if (fhout != 1)
+		close(fhout);
+	if (fherr != 2)
+		close(fherr);
 }
 #endif
 
-- 
1.6.6.218.g3e6eb
