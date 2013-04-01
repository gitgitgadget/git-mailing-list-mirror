From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/4] run-command: add new check_command helper
Date: Mon,  1 Apr 2013 15:46:41 -0600
Message-ID: <1364852804-31875-2-git-send-email-felipe.contreras@gmail.com>
References: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 01 23:48:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMmaJ-0003hJ-Df
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 23:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758813Ab3DAVrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 17:47:42 -0400
Received: from mail-gg0-f176.google.com ([209.85.161.176]:62791 "EHLO
	mail-gg0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758256Ab3DAVrl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 17:47:41 -0400
X-Greylist: delayed 1936 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Apr 2013 17:47:41 EDT
Received: by mail-gg0-f176.google.com with SMTP id c4so452447ggn.35
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 14:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=UdNxb4jgPosZf3FpwlhLKGnM+s6PeElEry5xEJcSmRg=;
        b=cgTXCRxQFafThY9LIEvRMrbP0gkd8rmE+bGz2ePsGMWZ8DWtwC7XLJ6FEeWYN2iBM4
         vdu4dll+ud2LheZ02wd2UEFNFxjxl5WEkZD0m1IHyN8wRAc+EbI6erxm90w+bRvRc9Kg
         1b5BEUCHKN9Ov7ns8LCMiqUbIhEt7ZIwuB/Ikm/8yJ7hf2wdnuFNXOxowQtCouylTFHU
         CBU7Ml30/1kkkU45jR+aSiws4Fq+Orj8iEToX4rZFIF8fXP/+IEDlDoCC4NQFeIICUm8
         HsPYkEgmo0tPH7EWw61OSE3S711VOn5d04Chn6d50NfB47tTWhC4csYLZ7F/O5LMzlte
         Jdkw==
X-Received: by 10.236.182.229 with SMTP id o65mr11687054yhm.160.1364852861241;
        Mon, 01 Apr 2013 14:47:41 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id z64sm30086939yhc.24.2013.04.01.14.47.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Apr 2013 14:47:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219713>

And persistent_waitpid() to recover the information from the last run.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 run-command.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 run-command.h |  6 ++++++
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/run-command.c b/run-command.c
index 07e27ff..16833df 100644
--- a/run-command.c
+++ b/run-command.c
@@ -226,14 +226,27 @@ static inline void set_cloexec(int fd)
 		fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
 }
 
-static int wait_or_whine(pid_t pid, const char *argv0)
+static pid_t persistent_waitpid(struct child_process *cmd, pid_t pid, int *stat_loc)
+{
+	if (cmd->last_wait.code) {
+		errno = cmd->last_wait.failed_errno;
+		*stat_loc = cmd->last_wait.status;
+		return errno ? -1 : pid;
+	} else {
+		pid_t waiting;
+		while ((waiting = waitpid(pid, stat_loc, 0)) < 0 && errno == EINTR)
+			;	/* nothing */
+		return waiting;
+	}
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
@@ -437,7 +450,7 @@ fail_pipe:
 		 * At this point we know that fork() succeeded, but execvp()
 		 * failed. Errors have been reported to our stderr.
 		 */
-		wait_or_whine(cmd->pid, cmd->argv[0]);
+		wait_or_whine(cmd, cmd->pid, cmd->argv[0]);
 		failed_errno = errno;
 		cmd->pid = -1;
 	}
@@ -542,7 +555,7 @@ fail_pipe:
 
 int finish_command(struct child_process *cmd)
 {
-	return wait_or_whine(cmd->pid, cmd->argv[0]);
+	return wait_or_whine(cmd, cmd->pid, cmd->argv[0]);
 }
 
 int run_command(struct child_process *cmd)
@@ -553,6 +566,27 @@ int run_command(struct child_process *cmd)
 	return finish_command(cmd);
 }
 
+int check_command(struct child_process *cmd)
+{
+	int status;
+	pid_t waiting;
+	int failed_errno = 0;
+
+	waiting = waitpid(cmd->pid, &status, WNOHANG);
+
+	if (waiting != cmd->pid)
+		return 1;
+
+	if (waiting < 0)
+		failed_errno = errno;
+
+	cmd->last_wait.code = -1;
+	cmd->last_wait.failed_errno = failed_errno;
+	cmd->last_wait.status = status;
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
+	return wait_or_whine(cmd, async->pid, "child process");
 #else
 	void *ret = (void *)(intptr_t)(-1);
 
diff --git a/run-command.h b/run-command.h
index 221ce33..66aaac7 100644
--- a/run-command.h
+++ b/run-command.h
@@ -39,11 +39,17 @@ struct child_process {
 	unsigned stdout_to_stderr:1;
 	unsigned use_shell:1;
 	unsigned clean_on_exit:1;
+	struct last_wait {
+		int code;
+		int failed_errno;
+		int status;
+	} last_wait;
 };
 
 int start_command(struct child_process *);
 int finish_command(struct child_process *);
 int run_command(struct child_process *);
+int check_command(struct child_process *);
 
 extern char *find_hook(const char *name);
 extern int run_hook(const char *index_file, const char *name, ...);
-- 
1.8.2
