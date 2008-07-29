From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 2/2 v2] run-command (Windows): Run dashless "git <cmd>" (solves part of problem with system_path)
Date: Tue, 29 Jul 2008 07:17:26 +0200
Message-ID: <1217308647-23673-1-git-send-email-prohaska@zib.de>
References: <BF5B7CBE-ACA8-4D81-8FC0-8A7901205854@zib.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Jul 29 07:19:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNhc6-0003zG-MH
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 07:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbYG2FSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 01:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbYG2FSI
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 01:18:08 -0400
Received: from mailer.zib.de ([130.73.108.11]:37353 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbYG2FSH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 01:18:07 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6T5HS2A027288;
	Tue, 29 Jul 2008 07:17:33 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6T5HShZ025345;
	Tue, 29 Jul 2008 07:17:28 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <BF5B7CBE-ACA8-4D81-8FC0-8A7901205854@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90570>

We prefer running the dashless form, so we should use it in MinGW's
start_command(), too.

This solves a fundamental problem we have with the computation of system
directories based on relative paths in combination with the new
gitexecpath 'libexec/git-core'.  The problem is that the program 'git'
is hardlinked to directories with different depth.  It is either used as
'bin/git' (1 directory) or as 'libexec/git-core/git-*' (2 directories).
Thus, using the same relative path in system_path() yields different
results when starting from the two locations.  I recognized the problem
because /etc/gitconfig is no longer read.

This commit fixes the problem by always calling 'bin/git' for builtin
commands.  The computation in system_path() thus always starts from
'bin' and yields predictable results.  This is however only part of a
full solution to the problem outlined above.  Remaining problems are:

 - Other code paths might run the dashed forms directly.

 - We have non-builtins that are implemented in C, e.g. fast-import.c.
   These non-builtins will still compute wrong paths.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
Acked-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 run-command.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/run-command.c b/run-command.c
index 6e29fdf..a3b28a6 100644
--- a/run-command.c
+++ b/run-command.c
@@ -119,9 +119,8 @@ int start_command(struct child_process *cmd)
 	}
 #else
 	int s0 = -1, s1 = -1, s2 = -1;	/* backups of stdin, stdout, stderr */
-	const char *sargv0 = cmd->argv[0];
+	const char **sargv = cmd->argv;
 	char **env = environ;
-	struct strbuf git_cmd;
 
 	if (cmd->no_stdin) {
 		s0 = dup(0);
@@ -165,9 +164,7 @@ int start_command(struct child_process *cmd)
 	}
 
 	if (cmd->git_cmd) {
-		strbuf_init(&git_cmd, 0);
-		strbuf_addf(&git_cmd, "git-%s", cmd->argv[0]);
-		cmd->argv[0] = git_cmd.buf;
+		cmd->argv = prepare_git_cmd(cmd->argv);
 	}
 
 	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, env);
@@ -175,9 +172,9 @@ int start_command(struct child_process *cmd)
 	if (cmd->env)
 		free_environ(env);
 	if (cmd->git_cmd)
-		strbuf_release(&git_cmd);
+		free(cmd->argv);
 
-	cmd->argv[0] = sargv0;
+	cmd->argv = sargv;
 	if (s0 >= 0)
 		dup2(s0, 0), close(s0);
 	if (s1 >= 0)
-- 
1.6.0.rc0.79.gb0320
