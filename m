From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/5] run-command: optionally kill children on exit
Date: Sat,  7 Jan 2012 12:42:43 +0100
Message-ID: <1325936567-3136-2-git-send-email-drizzd@aon.at>
References: <7vipkoih0e.fsf@alter.siamese.dyndns.org>
 <1325936567-3136-1-git-send-email-drizzd@aon.at>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 07 12:51:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjUoF-0003Hb-41
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 12:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486Ab2AGLvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jan 2012 06:51:22 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:36247 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751599Ab2AGLvM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2012 06:51:12 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 7C03F10011;
	Sat,  7 Jan 2012 12:49:18 +0100 (CET)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1325936567-3136-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188072>

From: Jeff King <peff@peff.net>

When we spawn a helper process, it should generally be done
and finish_command called before we exit. However, if we
exit abnormally due to an early return or a signal, the
helper may continue to run in our absence.

In the best case, this may simply be wasted CPU cycles or a
few stray messages on a terminal. But it could also mean a
process that the user thought was aborted continues to run
to completion (e.g., a push's pack-objects helper will
complete the push, even though you killed the push process).

This patch provides infrastructure for run-command to keep
track of PIDs to be killed, and clean them on signal
reception or input, just as we do with tempfiles. PIDs can
be added in two ways:

  1. If NO_PTHREADS is defined, async helper processes are
     automatically marked. By definition this code must be
     ready to die when the parent dies, since it may be
     implemented as a thread of the parent process.

  2. If the run-command caller specifies the "clean_on_exit"
     option. This is not the default, as there are cases
     where it is OK for the child to outlive us (e.g., when
     spawning a pager).

PIDs are cleared from the kill-list automatically during
wait_or_whine, which is called from finish_command and
finish_async.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Not sure if I can sign off without your sign-off. Should I have
replaced this with Acked-by?

 run-command.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 run-command.h |    1 +
 2 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/run-command.c b/run-command.c
index 1c51043..0204aaf 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1,8 +1,66 @@
 #include "cache.h"
 #include "run-command.h"
 #include "exec_cmd.h"
+#include "sigchain.h"
 #include "argv-array.h"
 
+struct child_to_clean {
+	pid_t pid;
+	struct child_to_clean *next;
+};
+static struct child_to_clean *children_to_clean;
+static int installed_child_cleanup_handler;
+
+static void cleanup_children(int sig)
+{
+	while (children_to_clean) {
+		struct child_to_clean *p = children_to_clean;
+		children_to_clean = p->next;
+		kill(p->pid, sig);
+		free(p);
+	}
+}
+
+static void cleanup_children_on_signal(int sig)
+{
+	cleanup_children(sig);
+	sigchain_pop(sig);
+	raise(sig);
+}
+
+static void cleanup_children_on_exit(void)
+{
+	cleanup_children(SIGTERM);
+}
+
+static void mark_child_for_cleanup(pid_t pid)
+{
+	struct child_to_clean *p = xmalloc(sizeof(*p));
+	p->pid = pid;
+	p->next = children_to_clean;
+	children_to_clean = p;
+
+	if (!installed_child_cleanup_handler) {
+		atexit(cleanup_children_on_exit);
+		sigchain_push_common(cleanup_children_on_signal);
+		installed_child_cleanup_handler = 1;
+	}
+}
+
+static void clear_child_for_cleanup(pid_t pid)
+{
+	struct child_to_clean **last, *p;
+
+	last = &children_to_clean;
+	for (p = children_to_clean; p; p = p->next) {
+		if (p->pid == pid) {
+			*last = p->next;
+			free(p);
+			return;
+		}
+	}
+}
+
 static inline void close_pair(int fd[2])
 {
 	close(fd[0]);
@@ -130,6 +188,9 @@ static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
 	} else {
 		error("waitpid is confused (%s)", argv0);
 	}
+
+	clear_child_for_cleanup(pid);
+
 	errno = failed_errno;
 	return code;
 }
@@ -292,6 +353,8 @@ fail_pipe:
 	if (cmd->pid < 0)
 		error("cannot fork() for %s: %s", cmd->argv[0],
 			strerror(failed_errno = errno));
+	else if (cmd->clean_on_exit)
+		mark_child_for_cleanup(cmd->pid);
 
 	/*
 	 * Wait for child's execvp. If the execvp succeeds (or if fork()
@@ -312,6 +375,7 @@ fail_pipe:
 		cmd->pid = -1;
 	}
 	close(notify_pipe[0]);
+
 }
 #else
 {
@@ -356,6 +420,8 @@ fail_pipe:
 	failed_errno = errno;
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
 		error("cannot spawn %s: %s", cmd->argv[0], strerror(errno));
+	if (cmd->clean_on_exit && cmd->pid >= 0)
+		mark_child_for_cleanup(cmd->pid);
 
 	if (cmd->env)
 		free_environ(env);
@@ -540,6 +606,8 @@ int start_async(struct async *async)
 		exit(!!async->proc(proc_in, proc_out, async->data));
 	}
 
+	mark_child_for_cleanup(async->pid);
+
 	if (need_in)
 		close(fdin[0]);
 	else if (async->in)
diff --git a/run-command.h b/run-command.h
index 56491b9..2a69466 100644
--- a/run-command.h
+++ b/run-command.h
@@ -38,6 +38,7 @@ struct child_process {
 	unsigned silent_exec_failure:1;
 	unsigned stdout_to_stderr:1;
 	unsigned use_shell:1;
+	unsigned clean_on_exit:1;
 	void (*preexec_cb)(void);
 };
 
-- 
1.7.8
