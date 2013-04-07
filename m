From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/2] run-command: new check_command helper
Date: Sun,  7 Apr 2013 01:45:04 -0600
Message-ID: <1365320706-13539-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 09:46:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOkIm-0000oy-Fh
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 09:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932712Ab3DGHqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 03:46:07 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:42548 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932923Ab3DGHqF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 03:46:05 -0400
Received: by mail-ob0-f181.google.com with SMTP id wo10so494625obc.26
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 00:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=oACThRCTYb24xqGHR/dTyMxVmcD1QtIKLWIkvnMydlo=;
        b=e4FSHCJluTAhrNkuFkJPuDG01FkinOcjBUgHFfwREwLpt8u/Alk24gb9cXaF8NtZQd
         tgqKEQsj7wxIHiOt0rqZfbJdUXc3omidN3MCyCe3p8IOak4bdIu6IpOt7Vyo5U+hJfDW
         GPtzutNNCpxkxiIlCKB4gOBo/rWtJShe4yKthBBgMxGBiWYiRVyZ97ZGAGmd5uNPK0xF
         N1+TdxueovSdrAb8eQfZeDOdgbHFwS9zfoOZ1HGDW+l8kILQ7sjQzh0B3iAdMKivMER+
         d7oDjFbARDFFs2AYgUmeBxFoQjk4Hs2Lwgf8a6T7Jtfh8Jf7vykpi7xIXluhBedyKzU3
         jbZQ==
X-Received: by 10.60.102.73 with SMTP id fm9mr408oeb.110.1365320765173;
        Sun, 07 Apr 2013 00:46:05 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id ri7sm19987024oeb.6.2013.04.07.00.46.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 00:46:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220290>

Hi,

This is a reroll to fix the build with NO_PTHREADS, and also a bit of cleanup.

The interdiff:

--- b/run-command.c
+++ a/run-command.c
@@ -226,27 +226,20 @@ static inline void set_cloexec(int fd)
 		fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
 }
 
-static pid_t persistent_waitpid(struct child_process *cmd, pid_t pid, int *status)
-{
-	pid_t waiting;
-
-	if (cmd->last_status.valid) {
-		*status = cmd->last_status.status;
-		return pid;
-	}
-
-	while ((waiting = waitpid(pid, status, 0)) < 0 && errno == EINTR)
-		;	/* nothing */
-	return waiting;
-}
-
 static int wait_or_whine(struct child_process *cmd, pid_t pid, const char *argv0)
 {
 	int status, code = -1;
 	pid_t waiting;
 	int failed_errno = 0;
 
-	waiting = persistent_waitpid(cmd, pid, &status);
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
@@ -770,7 +763,7 @@ error:
 int finish_async(struct async *async)
 {
 #ifdef NO_PTHREADS
-	return wait_or_whine(cmd, async->pid, "child process");
+	return wait_or_whine(NULL, async->pid, "child process");
 #else
 	void *ret = (void *)(intptr_t)(-1);
 
Felipe Contreras (2):
  run-command: add new check_command helper
  transport-helper: check if remote helper is alive

 git-remote-testgit        | 11 +++++++++++
 run-command.c             | 46 ++++++++++++++++++++++++++++++++++++++++------
 run-command.h             |  5 +++++
 t/t5801-remote-helpers.sh | 19 +++++++++++++++++++
 transport-helper.c        |  8 ++++++++
 5 files changed, 83 insertions(+), 6 deletions(-)

-- 
1.8.2
