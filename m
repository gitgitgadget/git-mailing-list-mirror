From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/5] run-command: kill children on exit by default
Date: Sat,  7 Jan 2012 12:42:44 +0100
Message-ID: <1325936567-3136-3-git-send-email-drizzd@aon.at>
References: <7vipkoih0e.fsf@alter.siamese.dyndns.org>
 <1325936567-3136-1-git-send-email-drizzd@aon.at>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 07 12:51:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjUnv-0003AC-UY
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 12:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041Ab2AGLvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jan 2012 06:51:13 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:36559 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751366Ab2AGLvL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2012 06:51:11 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id EB1A110014;
	Sat,  7 Jan 2012 12:49:19 +0100 (CET)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1325936567-3136-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188068>

It feels natural for a user to view git commands as monolithic
commands with a single thread of execution. If the parent git
command dies, it should therefore clean up its child processes as
well. So enable the cleanup mechanism by default.

For dashed externals, this means that killing the git wrapper will
kill the command itself, just like what would happen in case of an
internal command. A notable exception is the credentials cache
daemon, which must stay alive after the store command has
completed.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

I considered squashing this into the previous commit. But it's a fairly
small change and may help with bisecting in case of problems.

 credential-cache.c |    1 +
 run-command.c      |    4 ++--
 run-command.h      |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/credential-cache.c b/credential-cache.c
index dc98372..15e7236 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -48,6 +48,7 @@ static void spawn_daemon(const char *socket)
 	daemon.argv = argv;
 	daemon.no_stdin = 1;
 	daemon.out = -1;
+	daemon.stay_alive_on_exit = 1;
 
 	if (start_command(&daemon))
 		die_errno("unable to start cache daemon");
diff --git a/run-command.c b/run-command.c
index 0204aaf..fe07b20 100644
--- a/run-command.c
+++ b/run-command.c
@@ -353,7 +353,7 @@ fail_pipe:
 	if (cmd->pid < 0)
 		error("cannot fork() for %s: %s", cmd->argv[0],
 			strerror(failed_errno = errno));
-	else if (cmd->clean_on_exit)
+	else if (!cmd->stay_alive_on_exit)
 		mark_child_for_cleanup(cmd->pid);
 
 	/*
@@ -420,7 +420,7 @@ fail_pipe:
 	failed_errno = errno;
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
 		error("cannot spawn %s: %s", cmd->argv[0], strerror(errno));
-	if (cmd->clean_on_exit && cmd->pid >= 0)
+	if (!cmd->stay_alive_on_exit && cmd->pid >= 0)
 		mark_child_for_cleanup(cmd->pid);
 
 	if (cmd->env)
diff --git a/run-command.h b/run-command.h
index 2a69466..69dbea1 100644
--- a/run-command.h
+++ b/run-command.h
@@ -38,7 +38,7 @@ struct child_process {
 	unsigned silent_exec_failure:1;
 	unsigned stdout_to_stderr:1;
 	unsigned use_shell:1;
-	unsigned clean_on_exit:1;
+	unsigned stay_alive_on_exit:1;
 	void (*preexec_cb)(void);
 };
 
-- 
1.7.8
