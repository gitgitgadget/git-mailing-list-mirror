From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [updated patch v3 1/2] Report exec errors from run-command
Date: Thu, 31 Dec 2009 20:26:42 +0200
Message-ID: <1262284003-1417-2-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1262284003-1417-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 31 19:27:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQPjh-0006KS-0d
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 19:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714AbZLaS0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 13:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752594AbZLaS0s
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 13:26:48 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:59412 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbZLaS0q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 13:26:46 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id A127CC8011
	for <git@vger.kernel.org>; Thu, 31 Dec 2009 20:26:45 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A002969E2AD; Thu, 31 Dec 2009 20:26:45 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 76A6C41BF3
	for <git@vger.kernel.org>; Thu, 31 Dec 2009 20:26:44 +0200 (EET)
X-Mailer: git-send-email 1.6.6.3.gaa2e1
In-Reply-To: <1262284003-1417-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135962>

Previously run-command was unable to report errors happening in exec
call. Change it to pass errno from failed exec to errno value at
return.

The errno value passing can be done by opening close-on-exec pipe and
piping the error code through in case of failure. In case of success,
close-on-exec closes the pipe on successful exec and parent process
gets end of file on read.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 Makefile               |    1 +
 run-command.c          |   97 ++++++++++++++++++++++++++++++++++++++++++++++--
 t/t0061-run-command.sh |   13 ++++++
 test-run-command.c     |   35 +++++++++++++++++
 4 files changed, 142 insertions(+), 4 deletions(-)
 create mode 100755 t/t0061-run-command.sh
 create mode 100644 test-run-command.c

diff --git a/Makefile b/Makefile
index 4a1e5bc..452ad50 100644
--- a/Makefile
+++ b/Makefile
@@ -1725,6 +1725,7 @@ TEST_PROGRAMS += test-parse-options$X
 TEST_PROGRAMS += test-path-utils$X
 TEST_PROGRAMS += test-sha1$X
 TEST_PROGRAMS += test-sigchain$X
+TEST_PROGRAMS += test-run-command$X
 
 all:: $(TEST_PROGRAMS)
 
diff --git a/run-command.c b/run-command.c
index cf2d8f7..1086c6d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -15,6 +15,18 @@ static inline void dup_devnull(int to)
 	close(fd);
 }
 
+static inline void force_close(int fd)
+{
+	/*
+	 * The close is deemed success or failed in non-transient way if
+	 * close() suceeds, returns EBADF or error other than EINTR or
+	 * EAGAIN.
+	 */
+	while (close(fd) < 0 && errno != EBADF)
+		if(errno != EINTR && errno != EAGAIN)
+			break;
+}
+
 int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
@@ -76,9 +88,62 @@ fail_pipe:
 	trace_argv_printf(cmd->argv, "trace: run_command:");
 
 #ifndef WIN32
+{
+	int report_pipe[2] = {-1, -1};
+
+	if (pipe(report_pipe) < 0) {
+		report_pipe[0] = -1;
+		report_pipe[1] = -1;
+		warning("Can't open pipe for exec status report: %s\n",
+			strerror(errno));
+	}
+
 	fflush(NULL);
 	cmd->pid = fork();
-	if (!cmd->pid) {
+	if (cmd->pid > 0) {
+		int r = 0, ret;
+		force_close(report_pipe[1]);
+read_again:
+		if (report_pipe[0] >= 0)
+			r = read(report_pipe[0], &ret, sizeof(ret));
+		if (r < 0 && (errno == EAGAIN || errno == EINTR ||
+			errno == EWOULDBLOCK))
+			goto read_again;
+		else if (r < 0)
+			warning("Can't read exec status report: %s\n",
+				strerror(errno));
+		else if (r == 0)
+			;
+		else if (r < sizeof(ret)) {
+			warning("Received incomplete exec status report.\n");
+			errno = EBADMSG;
+		} else {
+			failed_errno = ret;
+			/*
+			 * Clean up the process that did the failed execution
+			 * so no zombies remain.
+			 */
+			if(waitpid(cmd->pid, &ret, 0) < 0 && errno == EINTR)
+				/* Nothing. */ ;
+			cmd->pid = -1;
+		}
+	} else if (!cmd->pid) {
+		int r = 0;
+		int flags;
+		force_close(report_pipe[0]);
+
+		flags = fcntl(report_pipe[1], F_GETFD);
+		if (flags < 0)
+			r = -1;
+		flags |= FD_CLOEXEC;
+		r = (r || fcntl(report_pipe[1], F_SETFD, flags));
+		if (r) {
+			warning("Can't FD_CLOEXEC pipe for exec status "
+				"report: %s\n", strerror(errno));
+			force_close(report_pipe[1]);
+			report_pipe[1] = -1;
+		}
+
 		if (cmd->no_stdin)
 			dup_devnull(0);
 		else if (need_in) {
@@ -119,20 +184,44 @@ fail_pipe:
 					unsetenv(*cmd->env);
 			}
 		}
-		if (cmd->preexec_cb)
+		if (cmd->preexec_cb) {
+			/*
+			 * We don't know what pre-exec callbacks do, and they
+			 * may do something that causes deadlock with exec
+			 * reporting. The sole user of this hook seems to
+			 * be pager, and it is run through shell, so one
+			 * wouldn't get useful error from exec reporting
+			 * and would get useful error from shell anyway. So
+			 * just disable exec reporting for such comamnds.
+			 */
+			force_close(report_pipe[1]);
+			report_pipe[1] = -1;
 			cmd->preexec_cb();
+		}
 		if (cmd->git_cmd) {
 			execv_git_cmd(cmd->argv);
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
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
new file mode 100755
index 0000000..1d9e82a
--- /dev/null
+++ b/t/t0061-run-command.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Ilari Liusvaara
+#
+
+test_description='Test run command'
+
+. ./test-lib.sh
+
+test_expect_success "reporting ENOENT" \
+"test-run-command 1"
+
+test_done
diff --git a/test-run-command.c b/test-run-command.c
new file mode 100644
index 0000000..4716033
--- /dev/null
+++ b/test-run-command.c
@@ -0,0 +1,35 @@
+/*
+ * test-run-command.c: test run command API.
+ *
+ * (C) 2009 Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "git-compat-util.h"
+#include "run-command.h"
+#include <string.h>
+#include <errno.h>
+
+int main(int argc, char **argv)
+{
+	char* procs[2];
+	struct child_process proc;
+	memset(&proc, 0, sizeof(proc));
+
+	if(argc < 2)
+		return 1;
+
+	if (argv[1][0] == '1')
+		procs[0] = "does-not-exist-62896869286";
+	procs[1] = NULL;
+	proc.argv = (const char **)procs;
+
+	if (!start_command(&proc))
+		return 1;
+	if (argv[1][0] == '1' && errno == ENOENT)
+		return 0;
+	return 1;
+}
-- 
1.6.6.3.gaa2e1
