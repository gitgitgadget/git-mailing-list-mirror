From: Paul Serice <paul@serice.net>
Subject: [PATCH] Fix race and deadlock when sending pack
Date: Sun, 18 Dec 2005 21:28:54 -0600
Message-ID: <43A628F6.1060807@serice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 04:28:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoBho-00063q-0i
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 04:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbVLSD2w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Dec 2005 22:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbVLSD2w
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Dec 2005 22:28:52 -0500
Received: from serice.org ([206.123.107.184]:13572 "EHLO serice.org")
	by vger.kernel.org with ESMTP id S1751278AbVLSD2v (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Dec 2005 22:28:51 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by serice.org (Postfix) with ESMTP id B5364584F8;
	Sun, 18 Dec 2005 21:28:50 -0600 (CST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.92.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13809>

Fix race and deadlock when sending pack.

The best way to reproduce the problem is to locally clone your
repository.  When you perform a push, git-send-pack will directly set
up pipes connected to stdin and stdout of git-receive-pack.  You
should then set up hook/post-update or hook/update to try to write
lots of text to stdout.  (You want to use the local protocol because
ssh is robust enough to mask the worst behavior.)

The first problem is that git-send-pack closes git-receive-pack's
stdout (which is inherited by the hooks) immediately after sending the
pack.  This almost always causes the hooks to receive SIGPIPE when
they try to write to stdout.

After fixing the SIGPIPE problem, you then run into a deadlock because
git-send-pack is blocked trying to reap git-receive-pack and
git-receive-pack (or one of its hooks) is blocked waiting for
git-send-pack to read its output.

I've also added an example a one-liner to both hooks demonstrating how
to redirect all subsequent output to stderr.  Because
git-receive-pack's stderr is not redirected, it has always been safe
to write to stderr.  Thus, all current status related output appears
on stderr.  This can lead to confusing ordering of messages if only
the hooks are using stdout.  The patch has the one-liner commented
out, but perhaps it should be enabled by default.

In addition, this commit reverts the work-around provided by
128aed684d0b3099092b7597c8644599b45b7503 which redirected both stdout
and stderr for the hooks to /dev/null.

Signed-off-by: Paul Serice <paul@serice.net>


---

 receive-pack.c               |    2 +
 run-command.c                |   27 +++++++++---------
 run-command.h                |    3 --
 send-pack.c                  |   64 +++++++++++++++++++++++++++++++++++++++++-
 templates/hooks--post-update |    4 +++
 templates/hooks--update      |    4 +++
 6 files changed, 85 insertions(+), 19 deletions(-)

36800ae8c6aa1427608a2d131b24986edba91bc9
diff --git a/receive-pack.c b/receive-pack.c
index cbe37e7..1873506 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -173,7 +173,7 @@ static void run_update_post_hook(struct 
 		argc++;
 	}
 	argv[argc] = NULL;
-	run_command_v_opt(argc, argv, RUN_COMMAND_NO_STDIO);
+	run_command_v(argc, argv);
 }
 
 /*
diff --git a/run-command.c b/run-command.c
index 8bf5922..38cd6cb 100644
--- a/run-command.c
+++ b/run-command.c
@@ -2,19 +2,23 @@
 #include "run-command.h"
 #include <sys/wait.h>
 
-int run_command_v_opt(int argc, char **argv, int flags)
+int run_command_v(int argc, char **argv)
 {
-	pid_t pid = fork();
+       
+	pid_t pid = (pid_t)-1;
+
+	/* Because each process has independent buffering, if you
+	 * don't flush before the fork, it can seem like the new
+	 * output for the child occurs before the old output of the
+	 * parent which can be confusing at times. */
+	fflush(stdout);
+	fflush(stderr);
+
+	pid = fork();
 
 	if (pid < 0)
 		return -ERR_RUN_COMMAND_FORK;
 	if (!pid) {
-		if (flags & RUN_COMMAND_NO_STDIO) {
-			int fd = open("/dev/null", O_RDWR);
-			dup2(fd, 0);
-			dup2(fd, 1);
-			close(fd);			
-		}
 		execvp(argv[0], (char *const*) argv);
 		die("exec %s failed.", argv[0]);
 	}
@@ -42,11 +46,6 @@ int run_command_v_opt(int argc, char **a
 	}
 }
 
-int run_command_v(int argc, char **argv)
-{
-	return run_command_v_opt(argc, argv, 0);
-}
-
 int run_command(const char *cmd, ...)
 {
 	int argc;
@@ -65,5 +64,5 @@ int run_command(const char *cmd, ...)
 	va_end(param);
 	if (MAX_RUN_COMMAND_ARGS <= argc)
 		return error("too many args to run %s", cmd);
-	return run_command_v_opt(argc, argv, 0);
+	return run_command_v(argc, argv);
 }
diff --git a/run-command.h b/run-command.h
index 2469eea..5ee0972 100644
--- a/run-command.h
+++ b/run-command.h
@@ -11,9 +11,6 @@ enum {
 	ERR_RUN_COMMAND_WAITPID_NOEXIT,
 };
 
-#define RUN_COMMAND_NO_STDIO 1
-
-int run_command_v_opt(int argc, char **argv, int opt);
 int run_command_v(int argc, char **argv);
 int run_command(const char *cmd, ...);
 
diff --git a/send-pack.c b/send-pack.c
index 6ce0d9f..efc66ca 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -274,6 +274,55 @@ static int send_pack(int in, int out, in
 	return ret;
 }
 
+/* This function copies the data from in_fd to out_fd. It returns 1 if
+ * all data was successfully copied; otherwise, it returns 0, and
+ * errno will be set depending on how read() or write() failed. */
+static int cpfd(int in_fd, int out_fd)
+{
+	int rv = 0;
+	ssize_t rcount = -1;
+	ssize_t wcount = 0;
+	ssize_t wtmp = -1;
+	static char cpfd_buf[4096];
+
+	for (;;) {
+
+		/* Read buffer. */
+		rcount = read(in_fd, cpfd_buf, sizeof(cpfd_buf));
+
+		/* Done. */
+		if (rcount == 0) {
+			rv = 1;
+			goto out;
+		}
+
+		/* Error. */
+		if (rcount < 0) {
+			if (errno == EINTR) {
+				continue;
+			}
+			goto out;
+		}
+
+		/* Write buffer. */
+		wcount = 0;
+		while (wcount < rcount) {
+			wtmp = write(out_fd,
+			             cpfd_buf + wcount,
+			             rcount - wcount);
+			if (wtmp < 0) {
+				if (errno == EINTR) {
+					continue;
+				}
+				goto out;
+			}
+			wcount += wtmp;
+		}
+	}
+
+ out:
+	return rv;
+}
 
 int main(int argc, char **argv)
 {
@@ -319,8 +368,21 @@ int main(int argc, char **argv)
 	if (pid < 0)
 		return 1;
 	ret = send_pack(fd[0], fd[1], nr_heads, heads);
-	close(fd[0]);
+
+	/* git_connect() sets up a pipe between this program and
+	 * "exec" (typically git-receive-pack).	 The git-receive-pack
+	 * program in turn executes the "update" and "post-update"
+	 * hooks which might write to this program's fd[0].  To avoid
+	 * deadlock, this program must consume all of the data on
+	 * fd[0].  (The hooks are called after the pack has been
+	 * transfered so it should it should be safe to allow them to
+	 * write to stdout because it should not interfere with the
+	 * transfer protocol which also occurs on stdout).  */
+	cpfd(fd[0], fileno(stdout));
+
 	close(fd[1]);
 	finish_connect(pid);
+	close(fd[0]);
+
 	return ret;
 }
diff --git a/templates/hooks--post-update b/templates/hooks--post-update
index bcba893..d470dcc 100644
--- a/templates/hooks--post-update
+++ b/templates/hooks--post-update
@@ -5,4 +5,8 @@
 #
 # To enable this hook, make this file executable by "chmod +x post-update".
 
+# If your stdout and stderr messages are interleaved, uncomment the
+# following line.
+#exec 1>&2
+
 exec git-update-server-info
diff --git a/templates/hooks--update b/templates/hooks--update
index 6db555f..6199deb 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -8,6 +8,10 @@
 # (2) make this file executable by "chmod +x update".
 #
 
+# If your stdout and stderr messages are interleaved, uncomment the
+# following line.
+#exec 1>&2
+
 recipient="commit-list@example.com"
 
 if expr "$2" : '0*$' >/dev/null
-- 
0.99.9.GIT
