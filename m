From: Paul Serice <paul@serice.net>
Subject: Re: [PATCH] Fix race and deadlock when sending pack
Date: Mon, 19 Dec 2005 10:52:27 -0600
Message-ID: <43A6E54B.3080708@serice.net>
References: <43A628F6.1060807@serice.net> <7vzmmxlkbq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 17:56:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoOFR-0007PB-EL
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 17:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbVLSQwY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 11:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbVLSQwY
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 11:52:24 -0500
Received: from serice.org ([206.123.107.184]:39428 "EHLO serice.org")
	by vger.kernel.org with ESMTP id S964839AbVLSQwX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Dec 2005 11:52:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by serice.org (Postfix) with ESMTP id C4256584F9;
	Mon, 19 Dec 2005 10:52:22 -0600 (CST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmmxlkbq.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.92.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13827>

> It appears cpfd() seems to mostly duplicate what is in copy.c;
> is there any particular reason?

No, I just wasn't aware of it.  I've made another patch to account for
it.  I wonder why copy_fd() (usually) closes ifd though.  I also
wonder why, if it is going to close ifd, doesn't it do so when there
an error is detected after the write() call.

I would also like to mention that I'm on the fence about all of this.
I think a lot of it is a matter of policy, and I'm just not sure what
the policy is regarding the hooks.  I wanted to submit the patch in it
full form to show that it is possible to redirect stdout of the hooks
to the terminal.  I also feel that, even if the patch is ultimately
rejected (no hard feelings :-), it would be interesting to know what's
the underlying problem.

Paul Serice

========================================================================

Subject: [PATCH] Fix race and deadlock when sending pack.

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
128aed684d0b3099092b7597c8644599b45b7503 which redirected stdin and
stdout to /dev/null.

Signed-off-by: Paul Serice <paul@serice.net>


---

 receive-pack.c               |    2 +-
 run-command.c                |   27 +++++++++++++--------------
 run-command.h                |    3 ---
 send-pack.c                  |    9 ++++++++-
 templates/hooks--post-update |    4 ++++
 templates/hooks--update      |    4 ++++
 6 files changed, 30 insertions(+), 19 deletions(-)

87b7ee91cbe1b90bbd0937a85595de3933fc9459
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
index 6ce0d9f..5a99ba9 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -319,8 +319,15 @@ int main(int argc, char **argv)
 	if (pid < 0)
 		return 1;
 	ret = send_pack(fd[0], fd[1], nr_heads, heads);
-	close(fd[0]);
+
+	/* Close our side of the conversation.	Wait for the child to
+	 * close its side of the conversation (copying the remainder
+	 * to our stdout).  Note that copy_fd() has the side effect of
+	 * closing fd[0]. */
 	close(fd[1]);
+	copy_fd(fd[0], fileno(stdout));
+
 	finish_connect(pid);
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
