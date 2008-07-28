From: Steffen Prohaska <prohaska@zib.de>
Subject: [Fundamental problem with relative system paths] [PATCH 2/2] run-command (Windows): Run dashless "git <cmd>"
Date: Mon, 28 Jul 2008 07:50:28 +0200
Message-ID: <1217224228-31303-2-git-send-email-prohaska@zib.de>
References: <1217224228-31303-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Jul 28 07:52:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNLev-0001U3-L2
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 07:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbYG1FvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 01:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbYG1FvQ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 01:51:16 -0400
Received: from mailer.zib.de ([130.73.108.11]:33610 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819AbYG1FvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 01:51:16 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6S5oT5s017480;
	Mon, 28 Jul 2008 07:50:34 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6S5oSL3009748;
	Mon, 28 Jul 2008 07:50:28 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1217224228-31303-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90410>

This might solve a fundamental problem we have with the
computation of system directories based on relative paths
in combination with the new gitexecpath 'libexec/git-core'.
The problem is that the program 'git' is hardlinked to
directories with different depth.  It is either used as
'bin/git' (1 directory) or as 'libexec/git-core/git-*'
(2 directories).  Thus, using the same relative path
in system_path() yields different results when starting from the
two locations.  I recognized the problem because /etc/gitconfig
is no longer be read.

The patch below might fix the problem by always calling 'bin/git'
for builtin commands.  The computation in system_path() would
always start from 'bin' and thus yields predictable results.  I
am not sure however if it fully solves the problem because other
code paths might run the dashed forms directly.

I think the only way to verify correctness would be to stop
installing the dashed forms for builtins.  If they were not
installed they could not be called.  The only entry point for all
builtins would be 'bin/git'.  I don't think we want to stop
installing the dashed forms right away.

So what shall we do?

	Steffen

-- 8< --
We prefer running the dashless form, so we should use it in
MinGW's start_command(), too.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
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
