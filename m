From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v2 4/4] run-command: inline prepare_run_command_v_opt()
Date: Tue, 19 Aug 2014 21:11:43 +0200
Message-ID: <53F3A16F.10303@web.de>
References: <53EFE15B.7030805@web.de> <53F05DE2.5080806@kdbg.org>	<20140817084832.GL23808@peff.net> <xmqq61hpybs9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 21:12:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJopO-0005dP-Vn
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 21:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbaHSTMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 15:12:15 -0400
Received: from mout.web.de ([212.227.15.3]:56993 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753624AbaHSTMO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 15:12:14 -0400
Received: from [192.168.178.27] ([79.250.174.3]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MfqC4-1Wz0j13aaa-00NBEw; Tue, 19 Aug 2014 21:12:11
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqq61hpybs9.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:MzY+NtDaZafoPG7z47s5yszCK/NYna5mCc6M9kakgxTlWqeZma9
 mw6lhlDefIRo9uR6fODiIx+61920cgbDYsT45GETSaAtRUNB/GWag3ZRxNQAuFK8yMY7oUE
 ldr8nj+gNNuzP+7b7Dxih7bVqSmTw4lGZ1HM8uNyrFpouBNUrxJhUCIQRZOgYeGeQGhyklE
 hMTNGtf1qM0j05KwUUIlA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255511>

Merge prepare_run_command_v_opt() and its only caller.  This removes a
pointer indirection and allows to initialize the struct child_process
using CHILD_PROCESS_INIT.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 run-command.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/run-command.c b/run-command.c
index 9196ee0..761f0fd 100644
--- a/run-command.c
+++ b/run-command.c
@@ -561,20 +561,6 @@ int run_command(struct child_process *cmd)
 	return finish_command(cmd);
 }
 
-static void prepare_run_command_v_opt(struct child_process *cmd,
-				      const char **argv,
-				      int opt)
-{
-	memset(cmd, 0, sizeof(*cmd));
-	cmd->argv = argv;
-	cmd->no_stdin = opt & RUN_COMMAND_NO_STDIN ? 1 : 0;
-	cmd->git_cmd = opt & RUN_GIT_CMD ? 1 : 0;
-	cmd->stdout_to_stderr = opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
-	cmd->silent_exec_failure = opt & RUN_SILENT_EXEC_FAILURE ? 1 : 0;
-	cmd->use_shell = opt & RUN_USING_SHELL ? 1 : 0;
-	cmd->clean_on_exit = opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
-}
-
 int run_command_v_opt(const char **argv, int opt)
 {
 	return run_command_v_opt_cd_env(argv, opt, NULL, NULL);
@@ -582,8 +568,14 @@ int run_command_v_opt(const char **argv, int opt)
 
 int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const char *const *env)
 {
-	struct child_process cmd;
-	prepare_run_command_v_opt(&cmd, argv, opt);
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	cmd.argv = argv;
+	cmd.no_stdin = opt & RUN_COMMAND_NO_STDIN ? 1 : 0;
+	cmd.git_cmd = opt & RUN_GIT_CMD ? 1 : 0;
+	cmd.stdout_to_stderr = opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
+	cmd.silent_exec_failure = opt & RUN_SILENT_EXEC_FAILURE ? 1 : 0;
+	cmd.use_shell = opt & RUN_USING_SHELL ? 1 : 0;
+	cmd.clean_on_exit = opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
 	cmd.dir = dir;
 	cmd.env = env;
 	return run_command(&cmd);
-- 
2.1.0
