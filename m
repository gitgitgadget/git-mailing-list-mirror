From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/2] run-command: add new check_command helper
Date: Sun,  7 Apr 2013 01:45:05 -0600
Message-ID: <1365320706-13539-2-git-send-email-felipe.contreras@gmail.com>
References: <1365320706-13539-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 09:46:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOkIs-0000uU-0S
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 09:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161156Ab3DGHqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 03:46:10 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:45638 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932923Ab3DGHqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 03:46:08 -0400
Received: by mail-oa0-f45.google.com with SMTP id o6so5284884oag.18
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 00:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Ry4eGki4x2OMqgHKpQdTRY9mEUrZ43l91dUhjRO+6Eo=;
        b=GWGrhhLVUmaDuI7pzubZEYxaZG8RQHCngLb2qBQPWZKUbzM3rtEuv3cN1cr05vRmyY
         +Pp9/PHIrjHjrvOPGM+pd3IAHXWuY4KB53XUWcjkRW4hTKDv8a9jWJWCR8JrGTjMzuc6
         x13Mx+4E0aQjVFFdMS2cekkHKCohjQN537v1l6zcCtxZppjDCNJ0zwL54aRe9FzmgL//
         gd7igxuy5CAUvD636B5W5I0yuJHN5nXeuCNW5dB2F0NmIQmCYGQT8YHvSCLe60SIcJcG
         sa7mkzileeddzQtAIWEIYjPbt9T8+U0qF1Kyv8cexL2ubI55V0czQGErnkRdesbMUVsy
         mOpg==
X-Received: by 10.60.96.200 with SMTP id du8mr12255243oeb.69.1365320768179;
        Sun, 07 Apr 2013 00:46:08 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id d10sm19988630oeh.7.2013.04.07.00.46.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 00:46:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365320706-13539-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220291>

And to recover the information from the last run when running
wait_or_whine().

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 run-command.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 run-command.h |  5 +++++
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/run-command.c b/run-command.c
index 07e27ff..5cb5114 100644
--- a/run-command.c
+++ b/run-command.c
@@ -226,14 +226,20 @@ static inline void set_cloexec(int fd)
 		fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
 }
 
-static int wait_or_whine(pid_t pid, const char *argv0)
+static int wait_or_whine(struct child_process *cmd, pid_t pid, const char *argv0)
 {
 	int status, code = -1;
 	pid_t waiting;
 	int failed_errno = 0;
 
-	while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
-		;	/* nothing */
+	/* First try the last status from check_command() */
+	if (cmd && cmd->last_status.valid) {
+		status = cmd->last_status.status;
+		waiting = pid;
+	} else {
+		while ((waiting = waitpid(pid, status, 0)) < 0 && errno == EINTR)
+			;	/* nothing */
+	}
 
 	if (waiting < 0) {
 		failed_errno = errno;
@@ -276,6 +282,8 @@ int start_command(struct child_process *cmd)
 	int failed_errno = failed_errno;
 	char *str;
 
+	cmd->last_status.valid = 0;
+
 	/*
 	 * In case of errors we must keep the promise to close FDs
 	 * that have been passed in via ->in and ->out.
@@ -437,7 +445,7 @@ fail_pipe:
 		 * At this point we know that fork() succeeded, but execvp()
 		 * failed. Errors have been reported to our stderr.
 		 */
-		wait_or_whine(cmd->pid, cmd->argv[0]);
+		wait_or_whine(cmd, cmd->pid, cmd->argv[0]);
 		failed_errno = errno;
 		cmd->pid = -1;
 	}
@@ -542,7 +550,7 @@ fail_pipe:
 
 int finish_command(struct child_process *cmd)
 {
-	return wait_or_whine(cmd->pid, cmd->argv[0]);
+	return wait_or_whine(cmd, cmd->pid, cmd->argv[0]);
 }
 
 int run_command(struct child_process *cmd)
@@ -553,6 +561,32 @@ int run_command(struct child_process *cmd)
 	return finish_command(cmd);
 }
 
+int check_command(struct child_process *cmd)
+{
+	int status;
+	pid_t waiting;
+
+	if (cmd->last_status.valid)
+		return 0;
+
+	while ((waiting = waitpid(cmd->pid, &status, WNOHANG)) < 0 && errno == EINTR)
+		; /* nothing */
+
+	if (!waiting)
+		return 1;
+
+	if (waiting == cmd->pid) {
+		cmd->last_status.valid = 1;
+		cmd->last_status.status = status;
+		return 0;
+	}
+
+	if (waiting > 0)
+		die("BUG: waitpid reported a random pid?");
+
+	return 0;
+}
+
 static void prepare_run_command_v_opt(struct child_process *cmd,
 				      const char **argv,
 				      int opt)
@@ -729,7 +763,7 @@ error:
 int finish_async(struct async *async)
 {
 #ifdef NO_PTHREADS
-	return wait_or_whine(async->pid, "child process");
+	return wait_or_whine(NULL, async->pid, "child process");
 #else
 	void *ret = (void *)(intptr_t)(-1);
 
diff --git a/run-command.h b/run-command.h
index 221ce33..74a733d 100644
--- a/run-command.h
+++ b/run-command.h
@@ -39,11 +39,16 @@ struct child_process {
 	unsigned stdout_to_stderr:1;
 	unsigned use_shell:1;
 	unsigned clean_on_exit:1;
+	struct last_status {
+		unsigned valid:1;
+		int status;
+	} last_status;
 };
 
 int start_command(struct child_process *);
 int finish_command(struct child_process *);
 int run_command(struct child_process *);
+int check_command(struct child_process *);
 
 extern char *find_hook(const char *name);
 extern int run_hook(const char *index_file, const char *name, ...);
-- 
1.8.2
