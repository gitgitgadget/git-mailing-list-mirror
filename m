From: Michal Ostrowski <mostrows@watson.ibm.com>
Subject: [PATCH] Exec git programs without using PATH.
Date: Tue, 10 Jan 2006 21:12:17 -0500
Message-ID: <1136945538.11717.643.camel@brick.watson.ibm.com>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>
	 <1136849810.11717.518.camel@brick.watson.ibm.com>
	 <7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>
	 <1136900174.11717.537.camel@brick.watson.ibm.com> <43C3CC4A.4030805@op5.se>
	 <1136910406.11717.579.camel@brick.watson.ibm.com> <43C4075E.4070407@op5.se>
	 <7vu0cb6f1n.fsf@assigned-by-dhcp.cox.net>
	 <1136924980.11717.603.camel@brick.watson.ibm.com>
	 <7vd5iz4mt7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 03:11:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwVRr-0003P3-Mc
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 03:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030685AbWAKCKt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 21:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030705AbWAKCKt
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 21:10:49 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:26578 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1030685AbWAKCKs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 21:10:48 -0500
Received: from sp1n293en1.watson.ibm.com (sp1n293en1.watson.ibm.com [129.34.20.41])
	by igw2.watson.ibm.com (8.12.11/8.13.1/8.13.1-2005-04-25 igw) with ESMTP id k0B2CufA028029;
	Tue, 10 Jan 2006 21:12:56 -0500
Received: from sp1n293en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with ESMTP id k0B2Agk395630;
	Tue, 10 Jan 2006 21:10:42 -0500
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with ESMTP id k0B2Afu403284;
	Tue, 10 Jan 2006 21:10:41 -0500
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id k0B37RYj015761;
	Tue, 10 Jan 2006 22:07:27 -0500
Received: from brick (brick.watson.ibm.com [9.2.216.48])
	by kitch0.watson.ibm.com (AIX5.1/8.11.6p2/8.11.0/03-06-2002) with ESMTP id k0B2Aem28412;
	Tue, 10 Jan 2006 21:10:40 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5iz4mt7.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.4.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14474>


The git suite may not be in PATH (and thus programs such as
git-send-pack could not exec git-rev-list).  Thus there is a need for
logic that will locate these programs.  Modifying PATH is not
desirable as it result in behavior differing from the user's
intentions, as we may end up prepending "/usr/bin" to PATH.

- git C programs will use exec*_git_cmd() APIs to exec sub-commands.
- exec*_git_cmd() will execute a git program by searching for it in
  the following directories:
	1. --exec-path (as used by "git")
	2. The GIT_EXEC_PATH environment variable.
	3. $(gitexecdir) as set in Makefile (default value $(bindir)).
- git potty will modify PATH as before to enable shell scripts to  
  invoke "git-foo" commands.

Ideally, shell scripts should use the git potty to become independent of
PATH, and then modifying PATH will not be necessary.

Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>

---

 Makefile       |   21 ++++++++--
 daemon.c       |    3 +
 exec_cmd.c     |  118
++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 exec_cmd.h     |   10 +++++
 fetch-clone.c  |    7 +--
 git.c          |   54 ++++++--------------------
 receive-pack.c |    2 -
 run-command.c  |    9 +++-
 run-command.h  |    2 -
 send-pack.c    |    8 ++--
 shell.c        |    2 -
 upload-pack.c  |    7 ++-
 12 files changed, 181 insertions(+), 62 deletions(-)
 create mode 100644 exec_cmd.c
 create mode 100644 exec_cmd.h

d6dbbb5b9b47c37f44c3494962b9fa534677729f
diff --git a/Makefile b/Makefile
index c9c15b5..912c223 100644
--- a/Makefile
+++ b/Makefile
@@ -68,6 +68,7 @@ ALL_LDFLAGS = $(LDFLAGS)
 
 prefix = $(HOME)
 bindir = $(prefix)/bin
+gitexecdir = $(prefix)/bin
 template_dir = $(prefix)/share/git-core/templates/
 GIT_PYTHON_DIR = $(prefix)/share/git-core/python
 # DESTDIR=
@@ -141,7 +142,7 @@ PROGRAMS = \
 	git-describe$X
 
 # what 'all' will build and 'install' will install.
-ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS) git$X
+ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
 
 # Backward compatibility -- to be removed after 1.0
 PROGRAMS += git-ssh-pull$X git-ssh-push$X
@@ -173,7 +174,7 @@ DIFF_OBJS = \
 
 LIB_OBJS = \
 	blob.o commit.o connect.o count-delta.o csum-file.o \
-	date.o diff-delta.o entry.o ident.o index.o \
+	date.o diff-delta.o entry.o exec_cmd.o ident.o index.o \
 	object.o pack-check.o patch-delta.o path.o pkt-line.o \
 	quote.o read-cache.o refs.o run-command.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
@@ -184,6 +185,16 @@ LIB_OBJS = \
 LIBS = $(LIB_FILE)
 LIBS += -lz
 
+
+# .exec_cmd.gitexecdir stores $(gitexecir) used to compile exec_cmd.o
+# If it has changed, store the new value and force exec_cmd.o to be
rebuilt
+ifneq ($(shell cat .exec_cmd.gitexecdir 2>/dev/null),$(gitexecdir))
+.PHONY: exec_cmd.c
+$(shell echo $(gitexecdir) > .exec_cmd.gitexecdir)
+endif
+
+exec_cmd.o: CFLAGS+=-DGIT_EXEC_PATH=\"$(gitexecdir)\"
+
 # Shell quote;
 # Result of this needs to be placed inside ''
 shq = $(subst ','\'',$(1))
@@ -366,13 +377,13 @@ LIB_OBJS += $(COMPAT_OBJS)
 export prefix TAR INSTALL DESTDIR SHELL_PATH template_dir
 ### Build rules
 
-all: $(ALL_PROGRAMS)
+all: $(ALL_PROGRAMS) git$X
 
 all:
 	$(MAKE) -C templates
 
 git$X: git.c $(LIB_FILE)
-	$(CC) -DGIT_EXEC_PATH='"$(bindir)"' -DGIT_VERSION='"$(GIT_VERSION)"' \
+	$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
 		$(CFLAGS) $(COMPAT_CFLAGS) -o $@ $(filter %.c,$^) $(LIB_FILE)
 
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
@@ -468,7 +479,9 @@ check:
 
 install: all
 	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(bindir))
+	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(gitexecdir))
 	$(INSTALL) $(ALL_PROGRAMS) $(call shellquote,$(DESTDIR)$(bindir))
+	$(INSTALL) git$X $(call shellquote,$(DESTDIR)$(gitexecdir))
 	$(MAKE) -C templates install
 	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
 	$(INSTALL) $(PYMODULES) $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
diff --git a/daemon.c b/daemon.c
index 3bd1426..bb014fa 100644
--- a/daemon.c
+++ b/daemon.c
@@ -9,6 +9,7 @@
 #include <syslog.h>
 #include "pkt-line.h"
 #include "cache.h"
+#include "exec_cmd.h"
 
 static int log_syslog;
 static int verbose;
@@ -227,7 +228,7 @@ static int upload(char *dir)
 	snprintf(timeout_buf, sizeof timeout_buf, "--timeout=%u", timeout);
 
 	/* git-upload-pack only ever reads stuff, so this is safe */
-	execlp("git-upload-pack", "git-upload-pack", "--strict", timeout_buf,
".", NULL);
+	execl_git_cmd("upload-pack", "--strict", timeout_buf, ".", NULL);
 	return -1;
 }
 
diff --git a/exec_cmd.c b/exec_cmd.c
new file mode 100644
index 0000000..a3bd40a
--- /dev/null
+++ b/exec_cmd.c
@@ -0,0 +1,118 @@
+#include "cache.h"
+#include "exec_cmd.h"
+#define MAX_ARGS	32
+
+extern char **environ;
+static const char *builtin_exec_path = GIT_EXEC_PATH;
+static const char *current_exec_path = NULL;
+
+void git_set_exec_path(const char *exec_path)
+{
+	current_exec_path = exec_path;
+}
+
+
+/* Returns the highest-priority, location to look for git programs. */
+const char *git_exec_path()
+{
+	const char *env;
+
+	if (current_exec_path)
+		return current_exec_path;
+
+	env = getenv("GIT_EXEC_PATH");
+	if (env) {
+		return env;
+	}
+
+	return builtin_exec_path;
+}
+
+
+int execv_git_cmd(char **argv)
+{
+	char git_command[PATH_MAX + 1];
+	char *tmp;
+	int len, err, i;
+	const char *paths[] = { current_exec_path,
+				getenv("GIT_EXEC_PATH"),
+				builtin_exec_path,
+				NULL };
+
+	for (i = 0; i < 4; ++i) {
+		const char *exec_dir = paths[i];
+		if (!exec_dir) continue;
+
+		if (*exec_dir != '/') {
+			if (!getcwd(git_command, sizeof(git_command))) {
+				fprintf(stderr, "git: cannot determine "
+					"current directory\n");
+				exit(1);
+			}
+			len = strlen(git_command);
+
+			/* Trivial cleanup */
+			while (!strncmp(exec_dir, "./", 2)) {
+				exec_dir += 2;
+				while (*exec_dir == '/')
+					exec_dir++;
+			}
+			snprintf(git_command + len, sizeof(git_command) - len,
+				 "/%s", exec_dir);
+		} else {
+			strcpy(git_command, exec_dir);
+		}
+
+		len = strlen(git_command);
+		len += snprintf(git_command + len, sizeof(git_command) - len,
+				"/git-%s", argv[0]);
+
+		if (sizeof(git_command) <= len) {
+			fprintf(stderr,
+				"git: command name given is too long.\n");
+			break;
+		}
+
+		/* argv[0] must be the git command, but the argv array
+		 * belongs to the caller, and my be reused in
+		 * subsequent loop iterations. Save argv[0] and
+		 * restore it on error.
+		 */
+
+		tmp = argv[0];
+		argv[0] = git_command;
+
+		/* execve() can only ever return if it fails */
+		execve(git_command, argv, environ);
+
+		err = errno;
+
+		argv[0] = tmp;
+	}
+	return -1;
+
+}
+
+
+int execl_git_cmd(char *cmd,...)
+{
+	int argc;
+	char *argv[MAX_ARGS + 1];
+	char *arg;
+	va_list param;
+
+	va_start(param, cmd);
+	argv[0] = cmd;
+	argc = 1;
+	while (argc < MAX_ARGS) {
+		arg = argv[argc++] = va_arg(param, char *);
+		if (!arg)
+			break;
+	}
+	va_end(param);
+	if (MAX_ARGS <= argc)
+		return error("too many args to run %s", cmd);
+
+	argv[argc] = NULL;
+	return execv_git_cmd(argv);
+}
diff --git a/exec_cmd.h b/exec_cmd.h
new file mode 100644
index 0000000..06d5ec3
--- /dev/null
+++ b/exec_cmd.h
@@ -0,0 +1,10 @@
+#ifndef __GIT_EXEC_CMD_H_
+#define __GIT_EXEC_CMD_H_
+
+extern void git_set_exec_path(const char *exec_path);
+extern const char* git_exec_path();
+extern int execv_git_cmd(char **argv); /* NULL terminated */
+extern int execl_git_cmd(char *cmd, ...);
+
+
+#endif /* __GIT_EXEC_CMD_H_ */
diff --git a/fetch-clone.c b/fetch-clone.c
index f46fe6e..859f400 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "exec_cmd.h"
 #include <sys/wait.h>
 
 static int finish_pack(const char *pack_tmp_name, const char *me)
@@ -27,8 +28,7 @@ static int finish_pack(const char *pack_
 		dup2(pipe_fd[1], 1);
 		close(pipe_fd[0]);
 		close(pipe_fd[1]);
-		execlp("git-index-pack","git-index-pack",
-		       "-o", idx, pack_tmp_name, NULL);
+		execl_git_cmd("index-pack", "-o", idx, pack_tmp_name, NULL);
 		error("cannot exec git-index-pack <%s> <%s>",
 		      idx, pack_tmp_name);
 		exit(1);
@@ -105,8 +105,7 @@ int receive_unpack_pack(int fd[2], const
 		dup2(fd[0], 0);
 		close(fd[0]);
 		close(fd[1]);
-		execlp("git-unpack-objects", "git-unpack-objects",
-		       quiet ? "-q" : NULL, NULL);
+		execl_git_cmd("unpack-objects", quiet ? "-q" : NULL, NULL);
 		die("git-unpack-objects exec failed");
 	}
 	close(fd[0]);
diff --git a/git.c b/git.c
index 5e7da74..fdd02ed 100644
--- a/git.c
+++ b/git.c
@@ -10,6 +10,7 @@
 #include <stdarg.h>
 #include <sys/ioctl.h>
 #include "git-compat-util.h"
+#include "exec_cmd.h"
 
 #ifndef PATH_MAX
 # define PATH_MAX 4096
@@ -233,14 +234,11 @@ int main(int argc, char **argv, char **e
 {
 	char git_command[PATH_MAX + 1];
 	char wd[PATH_MAX + 1];
-	int i, len, show_help = 0;
-	char *exec_path = getenv("GIT_EXEC_PATH");
+	int i, show_help = 0;
+	char *exec_path;
 
 	getcwd(wd, PATH_MAX);
 
-	if (!exec_path)
-		exec_path = GIT_EXEC_PATH;
-
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 
@@ -256,10 +254,11 @@ int main(int argc, char **argv, char **e
 
 		if (!strncmp(arg, "exec-path", 9)) {
 			arg += 9;
-			if (*arg == '=')
+			if (*arg == '=') {
 				exec_path = arg + 1;
-			else {
-				puts(exec_path);
+				git_set_exec_path(exec_path);
+			} else {
+				puts(git_exec_path());
 				exit(0);
 			}
 		}
@@ -275,48 +274,21 @@ int main(int argc, char **argv, char **e
 
 	if (i >= argc || show_help) {
 		if (i >= argc)
-			cmd_usage(exec_path, NULL);
+			cmd_usage(git_exec_path(), NULL);
 
 		show_man_page(argv[i]);
 	}
 
-	if (*exec_path != '/') {
-		if (!getcwd(git_command, sizeof(git_command))) {
-			fprintf(stderr,
-				"git: cannot determine current directory\n");
-			exit(1);
-		}
-		len = strlen(git_command);
+	exec_path = git_exec_path();
+	prepend_to_path(exec_path, strlen(exec_path));
 
-		/* Trivial cleanup */
-		while (!strncmp(exec_path, "./", 2)) {
-			exec_path += 2;
-			while (*exec_path == '/')
-				exec_path++;
-		}
-		snprintf(git_command + len, sizeof(git_command) - len,
-			 "/%s", exec_path);
-	}
-	else
-		strcpy(git_command, exec_path);
-	len = strlen(git_command);
-	prepend_to_path(git_command, len);
-
-	len += snprintf(git_command + len, sizeof(git_command) - len,
-			"/git-%s", argv[i]);
-	if (sizeof(git_command) <= len) {
-		fprintf(stderr, "git: command name given is too long.\n");
-		exit(1);
-	}
-
-	/* execve() can only ever return if it fails */
-	execve(git_command, &argv[i], envp);
+	execv_git_cmd(argv + i);
 
 	if (errno == ENOENT)
-		cmd_usage(exec_path, "'%s' is not a git-command", argv[i]);
+		cmd_usage(git_exec_path(), "'%s' is not a git-command",
+			  argv[i]);
 
 	fprintf(stderr, "Failed to run command '%s': %s\n",
 		git_command, strerror(errno));
-
 	return 1;
 }
diff --git a/receive-pack.c b/receive-pack.c
index f847ec2..8e78e32 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -257,7 +257,7 @@ static void read_head_info(void)
 
 static const char *unpack(int *error_code)
 {
-	int code = run_command(unpacker, NULL);
+	int code = run_command_v_opt(1, &unpacker, RUN_GIT_CMD);
 
 	*error_code = 0;
 	switch (code) {
diff --git a/run-command.c b/run-command.c
index 8bf5922..b3d287e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "run-command.h"
 #include <sys/wait.h>
+#include "exec_cmd.h"
 
 int run_command_v_opt(int argc, char **argv, int flags)
 {
@@ -13,9 +14,13 @@ int run_command_v_opt(int argc, char **a
 			int fd = open("/dev/null", O_RDWR);
 			dup2(fd, 0);
 			dup2(fd, 1);
-			close(fd);			
+			close(fd);
+		}
+		if (flags & RUN_GIT_CMD) {
+			execv_git_cmd(argv);
+		} else {
+			execvp(argv[0], (char *const*) argv);
 		}
-		execvp(argv[0], (char *const*) argv);
 		die("exec %s failed.", argv[0]);
 	}
 	for (;;) {
diff --git a/run-command.h b/run-command.h
index 2469eea..ef3ee05 100644
--- a/run-command.h
+++ b/run-command.h
@@ -12,7 +12,7 @@ enum {
 };
 
 #define RUN_COMMAND_NO_STDIO 1
-
+#define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
 int run_command_v_opt(int argc, char **argv, int opt);
 int run_command_v(int argc, char **argv);
 int run_command(const char *cmd, ...);
diff --git a/send-pack.c b/send-pack.c
index cd36193..4a420a6 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -26,11 +26,11 @@ static int is_zero_sha1(const unsigned c
 static void exec_pack_objects(void)
 {
 	static char *args[] = {
-		"git-pack-objects",
+		"pack-objects",
 		"--stdout",
 		NULL
 	};
-	execvp("git-pack-objects", args);
+	execv_git_cmd(args);
 	die("git-pack-objects exec failed (%s)", strerror(errno));
 }
 
@@ -39,7 +39,7 @@ static void exec_rev_list(struct ref *re
 	static char *args[1000];
 	int i = 0;
 
-	args[i++] = "git-rev-list";	/* 0 */
+	args[i++] = "rev-list";	/* 0 */
 	args[i++] = "--objects";	/* 1 */
 	while (refs) {
 		char *buf = malloc(100);
@@ -58,7 +58,7 @@ static void exec_rev_list(struct ref *re
 		refs = refs->next;
 	}
 	args[i] = NULL;
-	execvp("git-rev-list", args);
+	execv_git_cmd(args);
 	die("git-rev-list exec failed (%s)", strerror(errno));
 }
 
diff --git a/shell.c b/shell.c
index cd31618..0d4891f 100644
--- a/shell.c
+++ b/shell.c
@@ -12,7 +12,7 @@ static int do_generic_cmd(const char *me
 	my_argv[1] = arg;
 	my_argv[2] = NULL;
 
-	return execvp(me, (char**) my_argv);
+	return execv_git_cmd((char**) my_argv);
 }
 
 static struct commands {
diff --git a/upload-pack.c b/upload-pack.c
index 1834b6b..d198055 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -4,6 +4,7 @@
 #include "tag.h"
 #include "object.h"
 #include "commit.h"
+#include "exec_cmd.h"
 
 static const char upload_pack_usage[] = "git-upload-pack [--strict]
[--timeout=nn] <dir>";
 
@@ -60,7 +61,7 @@ static void create_pack_file(void)
 		close(0);
 		close(fd[0]);
 		close(fd[1]);
-		*p++ = "git-rev-list";
+		*p++ = "rev-list";
 		*p++ = "--objects";
 		if (create_full_pack || MAX_NEEDS <= nr_needs)
 			*p++ = "--all";
@@ -79,13 +80,13 @@ static void create_pack_file(void)
 				buf += 41;
 			}
 		*p++ = NULL;
-		execvp("git-rev-list", argv);
+		execv_git_cmd(argv);
 		die("git-upload-pack: unable to exec git-rev-list");
 	}
 	dup2(fd[0], 0);
 	close(fd[0]);
 	close(fd[1]);
-	execlp("git-pack-objects", "git-pack-objects", "--stdout", NULL);
+	execl_git_cmd("pack-objects", "--stdout", NULL);
 	die("git-upload-pack: unable to exec git-pack-objects");
 }
 
-- 
0.99.9m-g5a22
