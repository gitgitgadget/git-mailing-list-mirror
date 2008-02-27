From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 16/40] Windows: Wrap execve so that shell scripts can be invoked.
Date: Wed, 27 Feb 2008 19:54:39 +0100
Message-ID: <1204138503-6126-17-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVM-00022R-EY
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261AbYB0Sze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755972AbYB0Szc
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:32 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40427 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371AbYB0SzI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:08 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id AB206974D9;
	Wed, 27 Feb 2008 19:55:06 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75260>

When an external git command is invoked, it can be a Bourne shell script.
This patch looks into the command file to see whether it is one.
In this case, the command line is rearranged to invoke the shell
with the proper arguments.

With this change, scripted git commands work. Command line arguments
to those scripts cannot be complex (contain spaces or double-quotes), yet.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 compat/mingw.c    |  246 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h |    3 +
 2 files changed, 249 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 77e4b83..9d03ea5 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -90,6 +90,252 @@ char *mingw_getcwd(char *pointer, int len)
 	return ret;
 }
 
+static const char *parse_interpreter(const char *cmd)
+{
+	static char buf[100];
+	char *p, *opt;
+	int n, fd;
+
+	/* don't even try a .exe */
+	n = strlen(cmd);
+	if (n >= 4 && !strcasecmp(cmd+n-4, ".exe"))
+		return NULL;
+
+	fd = open(cmd, O_RDONLY);
+	if (fd < 0)
+		return NULL;
+	n = read(fd, buf, sizeof(buf)-1);
+	close(fd);
+	if (n < 4)	/* at least '#!/x' and not error */
+		return NULL;
+
+	if (buf[0] != '#' || buf[1] != '!')
+		return NULL;
+	buf[n] = '\0';
+	p = strchr(buf, '\n');
+	if (!p)
+		return NULL;
+
+	*p = '\0';
+	if (!(p = strrchr(buf+2, '/')) && !(p = strrchr(buf+2, '\\')))
+		return NULL;
+	/* strip options */
+	if ((opt = strchr(p+1, ' ')))
+		*opt = '\0';
+	return p+1;
+}
+
+/*
+ * Splits the PATH into parts.
+ */
+static char **get_path_split(void)
+{
+	char *p, **path, *envpath = getenv("PATH");
+	int i, n = 0;
+
+	if (!envpath || !*envpath)
+		return NULL;
+
+	envpath = xstrdup(envpath);
+	p = envpath;
+	while (p) {
+		char *dir = p;
+		p = strchr(p, ';');
+		if (p) *p++ = '\0';
+		if (*dir) {	/* not earlier, catches series of ; */
+			++n;
+		}
+	}
+	if (!n)
+		return NULL;
+
+	path = xmalloc((n+1)*sizeof(char*));
+	p = envpath;
+	i = 0;
+	do {
+		if (*p)
+			path[i++] = xstrdup(p);
+		p = p+strlen(p)+1;
+	} while (i < n);
+	path[i] = NULL;
+
+	free(envpath);
+
+	return path;
+}
+
+static void free_path_split(char **path)
+{
+	if (!path)
+		return;
+
+	char **p = path;
+	while (*p)
+		free(*p++);
+	free(path);
+}
+
+/*
+ * exe_only means that we only want to detect .exe files, but not scripts
+ * (which do not have an extension)
+ */
+static char *lookup_prog(const char *dir, const char *cmd, int isexe, int exe_only)
+{
+	char path[MAX_PATH];
+	snprintf(path, sizeof(path), "%s/%s.exe", dir, cmd);
+
+	if (!isexe && access(path, F_OK) == 0)
+		return xstrdup(path);
+	path[strlen(path)-4] = '\0';
+	if ((!exe_only || isexe) && access(path, F_OK) == 0)
+		return xstrdup(path);
+	return NULL;
+}
+
+/*
+ * Determines the absolute path of cmd using the the split path in path.
+ * If cmd contains a slash or backslash, no lookup is performed.
+ */
+static char *path_lookup(const char *cmd, char **path, int exe_only)
+{
+	char *prog = NULL;
+	int len = strlen(cmd);
+	int isexe = len >= 4 && !strcasecmp(cmd+len-4, ".exe");
+
+	if (strchr(cmd, '/') || strchr(cmd, '\\'))
+		prog = xstrdup(cmd);
+
+	while (!prog && *path)
+		prog = lookup_prog(*path++, cmd, isexe, exe_only);
+
+	return prog;
+}
+
+static int try_shell_exec(const char *cmd, char *const *argv, char **env)
+{
+	const char *interpr = parse_interpreter(cmd);
+	char **path;
+	char *prog;
+	int pid = 0;
+
+	if (!interpr)
+		return 0;
+	path = get_path_split();
+	prog = path_lookup(interpr, path, 1);
+	if (prog) {
+		int argc = 0;
+		const char **argv2;
+		while (argv[argc]) argc++;
+		argv2 = xmalloc(sizeof(*argv) * (argc+2));
+		argv2[0] = (char *)interpr;
+		argv2[1] = (char *)cmd;	/* full path to the script file */
+		memcpy(&argv2[2], &argv[1], sizeof(*argv) * argc);
+		pid = spawnve(_P_NOWAIT, prog, argv2, (const char **)env);
+		if (pid >= 0) {
+			int status;
+			if (waitpid(pid, &status, 0) < 0)
+				status = 255;
+			exit(status);
+		}
+		pid = 1;	/* indicate that we tried but failed */
+		free(prog);
+		free(argv2);
+	}
+	free_path_split(path);
+	return pid;
+}
+
+static void mingw_execve(const char *cmd, char *const *argv, char *const *env)
+{
+	/* check if git_command is a shell script */
+	if (!try_shell_exec(cmd, argv, (char **)env)) {
+		int pid, status;
+
+		pid = spawnve(_P_NOWAIT, cmd, (const char **)argv, (const char **)env);
+		if (pid < 0)
+			return;
+		if (waitpid(pid, &status, 0) < 0)
+			status = 255;
+		exit(status);
+	}
+}
+
+void mingw_execvp(const char *cmd, char *const *argv)
+{
+	char **path = get_path_split();
+	char *prog = path_lookup(cmd, path, 0);
+
+	if (prog) {
+		mingw_execve(prog, argv, environ);
+		free(prog);
+	} else
+		errno = ENOENT;
+
+	free_path_split(path);
+}
+
+char **copy_environ()
+{
+	char **env;
+	int i = 0;
+	while (environ[i])
+		i++;
+	env = xmalloc((i+1)*sizeof(*env));
+	for (i = 0; environ[i]; i++)
+		env[i] = xstrdup(environ[i]);
+	env[i] = NULL;
+	return env;
+}
+
+void free_environ(char **env)
+{
+	int i;
+	for (i = 0; env[i]; i++)
+		free(env[i]);
+	free(env);
+}
+
+static int lookup_env(char **env, const char *name, size_t nmln)
+{
+	int i;
+
+	for (i = 0; env[i]; i++) {
+		if (0 == strncmp(env[i], name, nmln)
+		    && '=' == env[i][nmln])
+			/* matches */
+			return i;
+	}
+	return -1;
+}
+
+/*
+ * If name contains '=', then sets the variable, otherwise it unsets it
+ */
+char **env_setenv(char **env, const char *name)
+{
+	char *eq = strchrnul(name, '=');
+	int i = lookup_env(env, name, eq-name);
+
+	if (i < 0) {
+		if (*eq) {
+			for (i = 0; env[i]; i++)
+				;
+			env = xrealloc(env, (i+2)*sizeof(*env));
+			env[i] = xstrdup(name);
+			env[i+1] = NULL;
+		}
+	}
+	else {
+		free(env[i]);
+		if (*eq)
+			env[i] = xstrdup(name);
+		else
+			for (; env[i]; i++)
+				env[i] = env[i+1];
+	}
+	return env;
+}
+
 #undef rename
 int mingw_rename(const char *pold, const char *pnew)
 {
diff --git a/git-compat-util.h b/git-compat-util.h
index 6fa93b6..e191a46 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -605,6 +605,9 @@ int mingw_rename(const char*, const char*);
 int mingw_vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
 #define vsnprintf mingw_vsnprintf
 
+void mingw_execvp(const char *cmd, char *const *argv);
+#define execvp mingw_execvp
+
 sig_handler_t mingw_signal(int sig, sig_handler_t handler);
 #define signal mingw_signal
 
-- 
1.5.4.1.126.ge5a7d
