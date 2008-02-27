From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 27/40] Windows: Implement a custom spawnve().
Date: Wed, 27 Feb 2008 19:54:50 +0100
Message-ID: <1204138503-6126-28-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVR-00022R-MI
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756240AbYB0Szy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756073AbYB0Szw
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:52 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40437 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607AbYB0SzK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:10 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id F2F2C976F9;
	Wed, 27 Feb 2008 19:55:08 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The problem with Windows's own implementation is that it tries to be
clever when a console program is invoked from a GUI application: In this
case it sometimes automatically allocates a new console window. As a
consequence, the IO channels of the spawned program are directed to the
console, but the invoking application listens on channels that are now
directed to nowhere.

In this implementation we use the lowlevel facilities of CreateProcess(),
which offers a flag to tell the system not to open a console. As a side
effect, only stdin, stdout, and stderr channels will be accessible from
C programs that are spawned. Other channels (file handles, pipe handles,
etc.) are still inherited by the spawned program, but it doesn't get
enough information to access them.

Johannes Schindelin integrated path quoting and unified the various
*execv* and *spawnv* helpers.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 compat/mingw.c    |  203 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 git-compat-util.h |    1 +
 run-command.c     |    2 +-
 3 files changed, 199 insertions(+), 7 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 1260be8..146c170 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1,4 +1,5 @@
 #include "../git-compat-util.h"
+#include "../strbuf.h"
 
 unsigned int _CRT_fmode = _O_BINARY;
 
@@ -190,6 +191,65 @@ char *mingw_getcwd(char *pointer, int len)
 	return ret;
 }
 
+/*
+ * See http://msdn2.microsoft.com/en-us/library/17w5ykft(vs.71).aspx
+ * (Parsing C++ Command-Line Arguments)
+ */
+static const char *quote_arg(const char *arg)
+{
+	/* count chars to quote */
+	int len = 0, n = 0;
+	int force_quotes = 0;
+	char *q, *d;
+	const char *p = arg;
+	if (!*p) force_quotes = 1;
+	while (*p) {
+		if (isspace(*p) || *p == '*' || *p == '?')
+			force_quotes = 1;
+		else if (*p == '"')
+			n++;
+		else if (*p == '\\') {
+			int count = 0;
+			while (*p == '\\') {
+				count++;
+				p++;
+				len++;
+			}
+			if (*p == '"')
+				n += count*2 + 1;
+			continue;
+		}
+		len++;
+		p++;
+	}
+	if (!force_quotes && n == 0)
+		return arg;
+
+	/* insert \ where necessary */
+	d = q = xmalloc(len+n+3);
+	*d++ = '"';
+	while (*arg) {
+		if (*arg == '"')
+			*d++ = '\\';
+		else if (*arg == '\\') {
+			int count = 0;
+			while (*arg == '\\') {
+				count++;
+				*d++ = *arg++;
+			}
+			if (*arg == '"') {
+				while (count-- > 0)
+					*d++ = '\\';
+				*d++ = '\\';
+			}
+		}
+		*d++ = *arg++;
+	}
+	*d++ = '"';
+	*d++ = 0;
+	return q;
+}
+
 static const char *parse_interpreter(const char *cmd)
 {
 	static char buf[100];
@@ -311,6 +371,138 @@ static char *path_lookup(const char *cmd, char **path, int exe_only)
 	return prog;
 }
 
+static int env_compare(const void *a, const void *b)
+{
+	char *const *ea = a;
+	char *const *eb = b;
+	return strcasecmp(*ea, *eb);
+}
+
+static pid_t mingw_spawnve(const char *cmd, const char **argv, char **env,
+			   int prepend_cmd)
+{
+	STARTUPINFO si;
+	PROCESS_INFORMATION pi;
+	struct strbuf envblk, args;
+	unsigned flags;
+	BOOL ret;
+
+	/* Determine whether or not we are associated to a console */
+	HANDLE cons = CreateFile("CONOUT$", GENERIC_WRITE,
+			FILE_SHARE_WRITE, NULL, OPEN_EXISTING,
+			FILE_ATTRIBUTE_NORMAL, NULL);
+	if (cons == INVALID_HANDLE_VALUE) {
+		/* There is no console associated with this process.
+		 * Since the child is a console process, Windows
+		 * would normally create a console window. But
+		 * since we'll be redirecting std streams, we do
+		 * not need the console.
+		 */
+		flags = CREATE_NO_WINDOW;
+	} else {
+		/* There is already a console. If we specified
+		 * CREATE_NO_WINDOW here, too, Windows would
+		 * disassociate the child from the console.
+		 * Go figure!
+		 */
+		flags = 0;
+		CloseHandle(cons);
+	}
+	memset(&si, 0, sizeof(si));
+	si.cb = sizeof(si);
+	si.dwFlags = STARTF_USESTDHANDLES;
+	si.hStdInput = (HANDLE) _get_osfhandle(0);
+	si.hStdOutput = (HANDLE) _get_osfhandle(1);
+	si.hStdError = (HANDLE) _get_osfhandle(2);
+
+	/* concatenate argv, quoting args as we go */
+	strbuf_init(&args, 0);
+	if (prepend_cmd) {
+		char *quoted = (char *)quote_arg(cmd);
+		strbuf_addstr(&args, quoted);
+		if (quoted != cmd)
+			free(quoted);
+	}
+	for (; *argv; argv++) {
+		char *quoted = (char *)quote_arg(*argv);
+		if (*args.buf)
+			strbuf_addch(&args, ' ');
+		strbuf_addstr(&args, quoted);
+		if (quoted != *argv)
+			free(quoted);
+	}
+
+	if (env) {
+		int count = 0;
+		char **e, **sorted_env;
+
+		for (e = env; *e; e++)
+			count++;
+
+		/* environment must be sorted */
+		sorted_env = xmalloc(sizeof(*sorted_env) * (count + 1));
+		memcpy(sorted_env, env, sizeof(*sorted_env) * (count + 1));
+		qsort(sorted_env, count, sizeof(*sorted_env), env_compare);
+
+		strbuf_init(&envblk, 0);
+		for (e = sorted_env; *e; e++) {
+			strbuf_addstr(&envblk, *e);
+			strbuf_addch(&envblk, '\0');
+		}
+		free(sorted_env);
+	}
+
+	memset(&pi, 0, sizeof(pi));
+	ret = CreateProcess(cmd, args.buf, NULL, NULL, TRUE, flags,
+		env ? envblk.buf : NULL, NULL, &si, &pi);
+
+	if (env)
+		strbuf_release(&envblk);
+	strbuf_release(&args);
+
+	if (!ret) {
+		errno = ENOENT;
+		return -1;
+	}
+	CloseHandle(pi.hThread);
+	return (pid_t)pi.hProcess;
+}
+
+pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env)
+{
+	pid_t pid;
+	char **path = get_path_split();
+	char *prog = path_lookup(cmd, path, 0);
+
+	if (!prog) {
+		errno = ENOENT;
+		pid = -1;
+	}
+	else {
+		const char *interpr = parse_interpreter(prog);
+
+		if (interpr) {
+			const char *argv0 = argv[0];
+			char *iprog = path_lookup(interpr, path, 1);
+			argv[0] = prog;
+			if (!iprog) {
+				errno = ENOENT;
+				pid = -1;
+			}
+			else {
+				pid = mingw_spawnve(iprog, argv, env, 1);
+				free(iprog);
+			}
+			argv[0] = argv0;
+		}
+		else
+			pid = mingw_spawnve(prog, argv, env, 0);
+		free(prog);
+	}
+	free_path_split(path);
+	return pid;
+}
+
 static int try_shell_exec(const char *cmd, char *const *argv, char **env)
 {
 	const char *interpr = parse_interpreter(cmd);
@@ -326,11 +518,10 @@ static int try_shell_exec(const char *cmd, char *const *argv, char **env)
 		int argc = 0;
 		const char **argv2;
 		while (argv[argc]) argc++;
-		argv2 = xmalloc(sizeof(*argv) * (argc+2));
-		argv2[0] = (char *)interpr;
-		argv2[1] = (char *)cmd;	/* full path to the script file */
-		memcpy(&argv2[2], &argv[1], sizeof(*argv) * argc);
-		pid = spawnve(_P_NOWAIT, prog, argv2, (const char **)env);
+		argv2 = xmalloc(sizeof(*argv) * (argc+1));
+		argv2[0] = (char *)cmd;	/* full path to the script file */
+		memcpy(&argv2[1], &argv[1], sizeof(*argv) * argc);
+		pid = mingw_spawnve(prog, argv2, env, 1);
 		if (pid >= 0) {
 			int status;
 			if (waitpid(pid, &status, 0) < 0)
@@ -351,7 +542,7 @@ static void mingw_execve(const char *cmd, char *const *argv, char *const *env)
 	if (!try_shell_exec(cmd, argv, (char **)env)) {
 		int pid, status;
 
-		pid = spawnve(_P_NOWAIT, cmd, (const char **)argv, (const char **)env);
+		pid = mingw_spawnve(cmd, (const char **)argv, (char **)env, 0);
 		if (pid < 0)
 			return;
 		if (waitpid(pid, &status, 0) < 0)
diff --git a/git-compat-util.h b/git-compat-util.h
index 0324789..570eb10 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -611,6 +611,7 @@ int mingw_rename(const char*, const char*);
 int mingw_vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
 #define vsnprintf mingw_vsnprintf
 
+pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env);
 void mingw_execvp(const char *cmd, char *const *argv);
 #define execvp mingw_execvp
 
diff --git a/run-command.c b/run-command.c
index 3834f86..5ed338c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -156,7 +156,7 @@ int start_command(struct child_process *cmd)
 		cmd->argv[0] = git_cmd.buf;
 	}
 
-	cmd->pid = spawnvpe(_P_NOWAIT, cmd->argv[0], cmd->argv, (const char **)env);
+	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, env);
 
 	if (cmd->env)
 		free_environ(env);
-- 
1.5.4.1.126.ge5a7d
