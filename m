From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Clean up file descriptors when calling hooks.
Date: Wed, 7 Dec 2005 21:04:38 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512072052560.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Dec 08 03:05:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkB8Y-0006MK-86
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 03:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVLHCDz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 21:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbVLHCDz
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 21:03:55 -0500
Received: from iabervon.org ([66.92.72.58]:54021 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932462AbVLHCDy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2005 21:03:54 -0500
Received: (qmail 26456 invoked by uid 1000); 7 Dec 2005 21:04:38 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Dec 2005 21:04:38 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13353>

When calling post-update hook, don't leave stdin and stdout connected to 
the pushing connection.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

---

Someone who's got a better idea of what they should be instead should 
revise this to make it not just use /dev/null. This does fix my particular 
test, though; it doesn't cause a post-update hook to crash if it writes to 
stdout when pushing locally.

 receive-pack.c |    2 +-
 run-command.c  |   15 +++++++++++++--
 run-command.h  |    3 +++
 3 files changed, 17 insertions(+), 3 deletions(-)

ca48629563058ba62b97b6d4cd3776ca7b7242d3
diff --git a/receive-pack.c b/receive-pack.c
index 1873506..cbe37e7 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -173,7 +173,7 @@ static void run_update_post_hook(struct 
 		argc++;
 	}
 	argv[argc] = NULL;
-	run_command_v(argc, argv);
+	run_command_v_opt(argc, argv, RUN_COMMAND_NO_STDIO);
 }
 
 /*
diff --git a/run-command.c b/run-command.c
index 5787a50..8bf5922 100644
--- a/run-command.c
+++ b/run-command.c
@@ -2,13 +2,19 @@
 #include "run-command.h"
 #include <sys/wait.h>
 
-int run_command_v(int argc, char **argv)
+int run_command_v_opt(int argc, char **argv, int flags)
 {
 	pid_t pid = fork();
 
 	if (pid < 0)
 		return -ERR_RUN_COMMAND_FORK;
 	if (!pid) {
+		if (flags & RUN_COMMAND_NO_STDIO) {
+			int fd = open("/dev/null", O_RDWR);
+			dup2(fd, 0);
+			dup2(fd, 1);
+			close(fd);			
+		}
 		execvp(argv[0], (char *const*) argv);
 		die("exec %s failed.", argv[0]);
 	}
@@ -36,6 +42,11 @@ int run_command_v(int argc, char **argv)
 	}
 }
 
+int run_command_v(int argc, char **argv)
+{
+	return run_command_v_opt(argc, argv, 0);
+}
+
 int run_command(const char *cmd, ...)
 {
 	int argc;
@@ -54,5 +65,5 @@ int run_command(const char *cmd, ...)
 	va_end(param);
 	if (MAX_RUN_COMMAND_ARGS <= argc)
 		return error("too many args to run %s", cmd);
-	return run_command_v(argc, argv);
+	return run_command_v_opt(argc, argv, 0);
 }
diff --git a/run-command.h b/run-command.h
index 5ee0972..2469eea 100644
--- a/run-command.h
+++ b/run-command.h
@@ -11,6 +11,9 @@ enum {
 	ERR_RUN_COMMAND_WAITPID_NOEXIT,
 };
 
+#define RUN_COMMAND_NO_STDIO 1
+
+int run_command_v_opt(int argc, char **argv, int opt);
 int run_command_v(int argc, char **argv);
 int run_command(const char *cmd, ...);
 
-- 
0.99.9.GIT
