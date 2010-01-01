From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [Updated PATCH 2/2] Improve transport helper exec failure reporting
Date: Fri, 1 Jan 2010 01:34:06 +0100
Message-ID: <201001010134.06740.j6t@kdbg.org>
References: <1262170338-11574-1-git-send-email-ilari.liusvaara@elisanet.fi> <20091231182436.GA1326@Knoppix> <4B3CF118.7080404@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Jan 01 01:35:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQVTp-0003QY-88
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 01:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399Ab0AAAey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 19:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374Ab0AAAex
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 19:34:53 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:32666 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751337Ab0AAAex (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 19:34:53 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 907C6CDF82;
	Fri,  1 Jan 2010 01:34:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id CD5B119F586;
	Fri,  1 Jan 2010 01:34:06 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <4B3CF118.7080404@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135993>

On Donnerstag, 31. Dezember 2009, Johannes Sixt wrote:
> Ilari Liusvaara schrieb:
> > The child process can't sanely print anything. Stderr would go to
> > who knows where.
>
> Wrong - because:
> > Parent process should have much better idea what to
> > do with errors.
>
> Very correct. For this reason, the parent process assigns a stderr channel
> to the child (or does not do so to inherit its own stderr), and the child
> is expected to use it. Errors due to execvp failures are no exception, IMO
> (except ENOENT, as always).

Actually, I changed my mind: execvp failures should go to the parent's stderr,
just as all errors before the exec happens.

How about this patch for a starter? Take it with a grain of salt - I coded it
after the New Year celebration ;) I was unable to find a case quickly that
exercises die_child().

--- 8< ---
From: Johannes Sixt <j6t@kdbg.org>
Date: Fri, 1 Jan 2010 01:22:05 +0100
Subject: [PATCH] start_command: report child process setup errors to the parent's stderr

When the child process's environment is set up in start_command(), error
messages were written to wherever the parent redirected the child's stderr
channel. However, even if the parent redirected the child's stderr, errors
during this setup process, including the exec itself, are usually an
indication of a problem in the parent's environment. Therefore, the error
messages should go to the parent's stderr.

Redirection of the child's error messages is usually only used to redirect
hook error messages during client-server exchanges such that stderr goes
to the client. In these cases, hook setup errors could be regarded as
information leak.

This patch makes a copy of stderr if necessary and uses a special
die routine that is used for all die() calls so that the errors are sent to
the parent's channel.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 run-command.c |   39 ++++++++++++++++++++++++++++++++++++---
 1 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index cf2d8f7..2480a8c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -15,6 +15,23 @@ static inline void dup_devnull(int to)
 	close(fd);
 }
 
+#ifndef WIN32
+static int child_err;
+
+static NORETURN void die_child(const char *err, va_list params)
+{
+	char msg[4096];
+	int len = vsnprintf(msg, sizeof(msg), err, params);
+	if (len > sizeof(msg))
+		len = sizeof(msg);
+
+	write(child_err, "fatal: ", 7);
+	write(child_err, msg, len);
+	write(child_err, "\n", 1);
+	exit(128);
+}
+#endif
+
 int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
@@ -79,6 +96,21 @@ fail_pipe:
 	fflush(NULL);
 	cmd->pid = fork();
 	if (!cmd->pid) {
+		/*
+		 * Redirect the channel to write syscall error messages to
+		 * before redirecting the process's stderr so that all die()
+		 * in subsequent call paths use the parent's stderr.
+		 */
+		if (cmd->no_stderr || need_err) {
+			int flags;
+			child_err = dup(2);
+			flags = fcntl(child_err, F_GETFL);
+			if (flags < 0)
+				flags = 0;
+			fcntl(child_err, F_SETFL, flags | FD_CLOEXEC);
+			set_die_routine(die_child);
+		}
+
 		if (cmd->no_stdin)
 			dup_devnull(0);
 		else if (need_in) {
@@ -126,9 +158,10 @@ fail_pipe:
 		} else {
 			execvp(cmd->argv[0], (char *const*) cmd->argv);
 		}
-		trace_printf("trace: exec '%s' failed: %s\n", cmd->argv[0],
-				strerror(errno));
-		exit(127);
+		if (errno == ENOENT)
+			exit(127);
+		else
+			die_errno("exec '%s'", cmd->argv[0]);
 	}
 	if (cmd->pid < 0)
 		error("cannot fork() for %s: %s", cmd->argv[0],
-- 
1.6.6.115.gd1ab3
