From: Michal Ostrowski <mostrows@watson.ibm.com>
Subject: Re: [PATCH 2/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Tue, 10 Jan 2006 15:29:40 -0500
Message-ID: <1136924980.11717.603.camel@brick.watson.ibm.com>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>
	 <1136849810.11717.518.camel@brick.watson.ibm.com>
	 <7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>
	 <1136900174.11717.537.camel@brick.watson.ibm.com> <43C3CC4A.4030805@op5.se>
	 <1136910406.11717.579.camel@brick.watson.ibm.com> <43C4075E.4070407@op5.se>
	 <7vu0cb6f1n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 21:28:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwQ6d-00015f-0m
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 21:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWAJU2P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 15:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWAJU2O
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 15:28:14 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:30636 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S932355AbWAJU2M
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 15:28:12 -0500
Received: from sp1n293en1.watson.ibm.com (sp1n293en1.watson.ibm.com [129.34.20.41])
	by igw2.watson.ibm.com (8.12.11/8.13.1/8.13.1-2005-04-25 igw) with ESMTP id k0AKUKrV013875;
	Tue, 10 Jan 2006 15:30:20 -0500
Received: from sp1n293en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with ESMTP id k0AKS6k365504;
	Tue, 10 Jan 2006 15:28:06 -0500
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with ESMTP id k0AKS5u253638;
	Tue, 10 Jan 2006 15:28:06 -0500
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id k0ALOpSb029324;
	Tue, 10 Jan 2006 16:24:51 -0500
Received: from brick (brick.watson.ibm.com [9.2.216.48])
	by kitch0.watson.ibm.com (AIX5.1/8.11.6p2/8.11.0/03-06-2002) with ESMTP id k0AKS3m12356;
	Tue, 10 Jan 2006 15:28:03 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0cb6f1n.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.4.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14447>

On Tue, 2006-01-10 at 11:47 -0800, Junio C Hamano wrote:


> > No. git prepends whatever was passed in --exec-path=/some/path, what's
> > found in $GIT_EXEC_PATH or the GIT_EXEC_PATH pre-processor macro set
> > at compile-time, in that order of preference. There's a very big
> > difference.
> 
> True.
> 
> > Good point. Perhaps we should only prepend to path when the directory
> > isn't already in $PATH, or append rather than prepend.
> 
> I think appending not prepending would stop letting me say
> 
>  $ GIT_EXEC_PATH=/usr/libexec/git-core/0.99.9k git foo
> 
> to try out older version, if I have more recent git in my PATH.
> But I agree with Michal it is not nice to affect invocations of
> "diff" (and things spawned from hooks, which would inherit PATH
> from receive-pack).
> 
> 

How about searching for executables in the following places, and in this
order:

1. --exec-path setting, if any
2. GIT_EXEC_PATH env var, if set
3. PATH (never modified)
4. Value of ${bindir} at build time


To accomplish this I'd suggest reworking the logic the git c programs
use to exec another git program.  The patch I sent out this morning
attempts to do this.  (I'll append again to avoid confusion with
previous patches.)  But note that the patch below doesn't implement this
policy above; the point is that it provides for a single location where
it has to be implemented (in exec_cmd.c).  I'd be happy to clean it up
and submit it formally as a clean-up patch (one that doesn't change the
PATH/GIT_EXEC_PATH search behavior currently implemented).

Secondly, the shell scripts as is cannot utilize this search order as
long as they don't religiously use the git potty internally.  If we were
to "sed -e 's/git-/git /g' -i git*.sh" (grotesquely simplified of
course) then they would. 



-- 
Michal Ostrowski <mostrows@watson.ibm.com>

diff --git a/Makefile b/Makefile
index c9c15b5..db57858 100644
--- a/Makefile
+++ b/Makefile
@@ -173,7 +173,7 @@ DIFF_OBJS = \
 
 LIB_OBJS = \
 	blob.o commit.o connect.o count-delta.o csum-file.o \
-	date.o diff-delta.o entry.o ident.o index.o \
+	date.o diff-delta.o entry.o exec_cmd.o ident.o index.o \
 	object.o pack-check.o patch-delta.o path.o pkt-line.o \
 	quote.o read-cache.o refs.o run-command.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
@@ -184,6 +184,16 @@ LIB_OBJS = \
 LIBS = $(LIB_FILE)
 LIBS += -lz
 
+
+# .exec_cmd.bindir stores $(bindir) used to compile exec_cmd.o
+# If it has changed, store the new value and force exec_cmd.o to be
rebuilt
+ifneq ($(shell cat .exec_cmd.bindir 2>/dev/null),$(bindir))
+.PHONY: exec_cmd.c
+$(shell echo $(bindir) > .exec_cmd.bindir)
+endif
+
+exec_cmd.o: CFLAGS+=-DGIT_EXEC_PATH=\"$(bindir)\"
+
 # Shell quote;
 # Result of this needs to be placed inside ''
 shq = $(subst ','\'',$(1))
diff --git a/daemon.c b/daemon.c
index 3bd1426..ab793bd 100644
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
+	exec_git_cmd("upload-pack", "--strict", timeout_buf, ".");
 	return -1;
 }
 
diff --git a/fetch-clone.c b/fetch-clone.c
index f46fe6e..5ae9bda 100644
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
+		exec_git_cmd("index-pack", "-o", idx, pack_tmp_name);
 		error("cannot exec git-index-pack <%s> <%s>",
 		      idx, pack_tmp_name);
 		exit(1);
@@ -105,8 +105,7 @@ int receive_unpack_pack(int fd[2], const
 		dup2(fd[0], 0);
 		close(fd[0]);
 		close(fd[1]);
-		execlp("git-unpack-objects", "git-unpack-objects",
-		       quiet ? "-q" : NULL, NULL);
+		exec_git_cmd("unpack-objects", quiet ? "-q" : NULL);
 		die("git-unpack-objects exec failed");
 	}
 	close(fd[0]);
diff --git a/git.c b/git.c
index 5e7da74..a45dc54 100644
--- a/git.c
+++ b/git.c
@@ -10,6 +10,7 @@
 #include <stdarg.h>
 #include <sys/ioctl.h>
 #include "git-compat-util.h"
+#include "exec_cmd.h"
 
 #ifndef PATH_MAX
 # define PATH_MAX 4096
@@ -192,25 +193,6 @@ static void cmd_usage(const char *exec_p
 	exit(1);
 }
 
-static void prepend_to_path(const char *dir, int len)
-{
-	char *path, *old_path = getenv("PATH");
-	int path_len = len;
-
-	if (!old_path)
-		old_path = "/usr/local/bin:/usr/bin:/bin";
-
-	path_len = len + strlen(old_path) + 1;
-
-	path = malloc(path_len + 1);
-
-	memcpy(path, dir, len);
-	path[len] = ':';
-	memcpy(path + len + 1, old_path, path_len - len);
-
-	setenv("PATH", path, 1);
-}
-
 static void show_man_page(char *git_cmd)
 {
 	char *page;
@@ -233,14 +215,10 @@ int main(int argc, char **argv, char **e
 {
 	char git_command[PATH_MAX + 1];
 	char wd[PATH_MAX + 1];
-	int i, len, show_help = 0;
-	char *exec_path = getenv("GIT_EXEC_PATH");
+	int i, show_help = 0;
 
 	getcwd(wd, PATH_MAX);
 
-	if (!exec_path)
-		exec_path = GIT_EXEC_PATH;
-
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 
@@ -257,9 +235,9 @@ int main(int argc, char **argv, char **e
 		if (!strncmp(arg, "exec-path", 9)) {
 			arg += 9;
 			if (*arg == '=')
-				exec_path = arg + 1;
+				git_set_exec_path(arg + 1);
 			else {
-				puts(exec_path);
+				puts(git_exec_path());
 				exit(0);
 			}
 		}
@@ -275,48 +253,18 @@ int main(int argc, char **argv, char **e
 
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
-
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
index 1834b6b..6602d68 100644
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
+	exec_git_cmd("pack-objects", "--stdout");
 	die("git-upload-pack: unable to exec git-pack-objects");
 }
 
