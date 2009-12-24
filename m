From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH 1/2] Report exec errors from run-command
Date: Thu, 24 Dec 2009 19:49:30 +0200
Message-ID: <1261676971-3285-2-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1261676971-3285-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 24 18:49:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNrol-0000Y9-6a
	for gcvg-git-2@lo.gmane.org; Thu, 24 Dec 2009 18:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755960AbZLXRtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 12:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754325AbZLXRth
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 12:49:37 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:39827 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921AbZLXRtf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 12:49:35 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 3D4BFEB414
	for <git@vger.kernel.org>; Thu, 24 Dec 2009 19:49:34 +0200 (EET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A01B493B6F9; Thu, 24 Dec 2009 19:49:34 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 16EE92BD52
	for <git@vger.kernel.org>; Thu, 24 Dec 2009 19:49:33 +0200 (EET)
X-Mailer: git-send-email 1.6.6.3.gaa2e1
In-Reply-To: <1261676971-3285-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135658>

Previously run-command was unable to report errors happening in exec
call. Change it to pass errno from failed exec to errno value at
return.

The errno value passing can be done by opening close-on-exec pipe and
piping the error code through in case of failure. In case of success,
close-on-exec closes the pipe on successful exec and parent process
gets end of file on read.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 run-command.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index cf2d8f7..d334d0f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -76,9 +76,60 @@ fail_pipe:
 	trace_argv_printf(cmd->argv, "trace: run_command:");
 
 #ifndef WIN32
+{
+	int report_pipe[2] = {-1, -1};
+
+	if (pipe(report_pipe) < 0)
+		warning("Can't open pipe for exec status report: %s\n",
+			strerror(errno));
+
 	fflush(NULL);
 	cmd->pid = fork();
-	if (!cmd->pid) {
+	if (cmd->pid > 0) {
+		int r = 0, ret;
+		while(close(report_pipe[1]) < 0 && errno != EBADF);
+read_again:
+		if (report_pipe[0] > 0)
+			r = read(report_pipe[0], &ret, sizeof(ret));
+		if (r < 0 && (errno == EAGAIN || errno == EINTR ||
+			errno == EWOULDBLOCK))
+			goto read_again;
+		else if (r < 0)
+			warning("Can't read exec status report: %s\n",
+				strerror(errno));
+		else if (r == 0)
+			;
+		else if (r < sizeof(ret))
+			warning("Received incomplete exec status report.\n");
+		else {
+			failed_errno = ret;
+			/*
+			 * Clean up the process that did the failed execution
+			 * so no zombies remain.
+			 */
+wait_again:
+			r = waitpid(cmd->pid, &ret, 0);
+			if (r < 0 && errno != ECHILD)
+				goto wait_again;
+			cmd->pid = -1;
+		}
+	} else if (!cmd->pid) {
+		int r = 0;
+		int flags;
+		while(close(report_pipe[0]) < 0 && errno != EBADF);
+
+		flags = fcntl(report_pipe[1], F_GETFD);
+		if (flags < 0)
+			r = -1;
+		flags |= FD_CLOEXEC;
+		r = (r || fcntl(report_pipe[1], F_SETFD, flags));
+		if (r) {
+			warning("Can't FD_CLOEXEC pipe for exec status "
+				"report: %s\n", strerror(errno));
+			while(close(report_pipe[1]) < 0 && errno != EBADF);
+			report_pipe[1] = -1;
+		}
+
 		if (cmd->no_stdin)
 			dup_devnull(0);
 		else if (need_in) {
@@ -126,13 +177,28 @@ fail_pipe:
 		} else {
 			execvp(cmd->argv[0], (char *const*) cmd->argv);
 		}
+		failed_errno = errno;
+
 		trace_printf("trace: exec '%s' failed: %s\n", cmd->argv[0],
 				strerror(errno));
+
+		r = 0;
+write_again:
+		if (report_pipe[1] >= 0)
+			r = write(report_pipe[1], &failed_errno,
+				sizeof(failed_errno));
+		if (r < 0 && (errno == EAGAIN || errno == EINTR ||
+			errno == EWOULDBLOCK))
+			goto write_again;
+		else if (r < 0)
+			warning("Can't write exec status report: %s\n",
+				strerror(errno));
+
 		exit(127);
-	}
-	if (cmd->pid < 0)
+	} else if (cmd->pid < 0)
 		error("cannot fork() for %s: %s", cmd->argv[0],
 			strerror(failed_errno = errno));
+}
 #else
 {
 	int s0 = -1, s1 = -1, s2 = -1;	/* backups of stdin, stdout, stderr */
-- 
1.6.6.3.gaa2e1
