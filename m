From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/4] run-command: add new check_command helper
Date: Tue,  2 Apr 2013 04:31:46 -0600
Message-ID: <1364898709-21583-2-git-send-email-felipe.contreras@gmail.com>
References: <1364898709-21583-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 12:33:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMyWl-0002P4-Ak
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 12:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762010Ab3DBKct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 06:32:49 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:42226 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761062Ab3DBKcs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 06:32:48 -0400
Received: by mail-yh0-f51.google.com with SMTP id q1so21924yhf.10
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 03:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=/H99x1CF67L/kxtYmIhiQQGwczD3MjB0nWqOes9XaBA=;
        b=v1FmaK1Z5GkY7M4TUTQvxRb/Gm5I6Lmg8gSEU1qWhck5Daa3aUzx3cYZFRIb9KW/xl
         eUy7uqDo3XZAjVPLpHKsBftKpAlcJcNcp56KpDYOFBRE9PW+LkYa924FR+RoPZo/lGH4
         zlat/CQ+SCZABA8Ffqhio+MF2uvoyeljdV/fMbJynDGFJ3gttIkC/8k9D11zuhDnTfvB
         NEwVySSwcSj7ulpCH0WfA/2HMVk2ZwC2/AY5v1FQYS1T2yosMR64oH9aTMNsM/VBd7uP
         mt2fF60Q7mnNKj+UpKOHheLt+71bE+l37099CbDxl9oM0N19ENa6OYDFY1d1oB5KjAMj
         5Mwg==
X-Received: by 10.236.162.39 with SMTP id x27mr13643428yhk.50.1364898767617;
        Tue, 02 Apr 2013 03:32:47 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id t27sm1929690yhm.20.2013.04.02.03.32.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 03:32:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364898709-21583-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219763>

And persistent_waitpid() to recover the information from the last run.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 run-command.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++------
 run-command.h |  5 +++++
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/run-command.c b/run-command.c
index 07e27ff..b900c6e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -226,14 +226,27 @@ static inline void set_cloexec(int fd)
 		fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
 }
 
-static int wait_or_whine(pid_t pid, const char *argv0)
+static pid_t persistent_waitpid(struct child_process *cmd, pid_t pid, int *status)
+{
+	pid_t waiting;
+
+	if (cmd->last_status.valid) {
+		*status = cmd->last_status.status;
+		return pid;
+	}
+
+	while ((waiting = waitpid(pid, status, 0)) < 0 && errno == EINTR)
+		;	/* nothing */
+	return waiting;
+}
+
+static int wait_or_whine(struct child_process *cmd, pid_t pid, const char *argv0)
 {
 	int status, code = -1;
 	pid_t waiting;
 	int failed_errno = 0;
 
-	while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
-		;	/* nothing */
+	waiting = persistent_waitpid(cmd, pid, &status);
 
 	if (waiting < 0) {
 		failed_errno = errno;
@@ -276,6 +289,8 @@ int start_command(struct child_process *cmd)
 	int failed_errno = failed_errno;
 	char *str;
 
+	cmd->last_status.valid = 0;
+
 	/*
 	 * In case of errors we must keep the promise to close FDs
 	 * that have been passed in via ->in and ->out.
@@ -437,7 +452,7 @@ fail_pipe:
 		 * At this point we know that fork() succeeded, but execvp()
 		 * failed. Errors have been reported to our stderr.
 		 */
-		wait_or_whine(cmd->pid, cmd->argv[0]);
+		wait_or_whine(cmd, cmd->pid, cmd->argv[0]);
 		failed_errno = errno;
 		cmd->pid = -1;
 	}
@@ -542,7 +557,7 @@ fail_pipe:
 
 int finish_command(struct child_process *cmd)
 {
-	return wait_or_whine(cmd->pid, cmd->argv[0]);
+	return wait_or_whine(cmd, cmd->pid, cmd->argv[0]);
 }
 
 int run_command(struct child_process *cmd)
@@ -553,6 +568,32 @@ int run_command(struct child_process *cmd)
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
@@ -729,7 +770,7 @@ error:
 int finish_async(struct async *async)
 {
 #ifdef NO_PTHREADS
-	return wait_or_whine(async->pid, "child process");
+	return wait_or_whine(cmd, async->pid, "child process");
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
