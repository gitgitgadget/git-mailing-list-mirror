From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Allow environment variables to be unset in the processes started by run_command
Date: Tue, 22 May 2007 23:49:21 +0200
Message-ID: <20070522214921.GG30871@steel.home>
References: <20070520153908.GF5412@admingilde.org> <20070520181433.GA19668@steel.home> <20070521090339.GH942MdfPADPa@greensroom.kotnet.org> <20070521224828.GA10890@steel.home> <7v7ir1dbl9.fsf@assigned-by-dhcp.cox.net> <20070522214754.GD30871@steel.home> <20070522214823.GE30871@steel.home> <20070522214847.GF30871@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sven Verdoolaege <skimo@kotnet.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 22 23:49:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqcER-0002eZ-Hb
	for gcvg-git@gmane.org; Tue, 22 May 2007 23:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757991AbXEVVtY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 17:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759019AbXEVVtY
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 17:49:24 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:55059 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757991AbXEVVtX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 17:49:23 -0400
Received: from tigra.home (Fc8ee.f.strato-dslnet.de [195.4.200.238])
	by post.webmailer.de (klopstock mo22) (RZmta 6.5)
	with ESMTP id A046eaj4MIaNEp ; Tue, 22 May 2007 23:49:21 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 979B0277BD;
	Tue, 22 May 2007 23:49:21 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 892A9D195; Tue, 22 May 2007 23:49:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070522214847.GF30871@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow37lQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48121>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 run-command.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index 605aa1e..3a5f737 100644
--- a/run-command.c
+++ b/run-command.c
@@ -77,8 +77,18 @@ int start_command(struct child_process *cmd)
 			die("exec %s: cd to %s failed (%s)", cmd->argv[0],
 			    cmd->dir, strerror(errno));
 		if (cmd->env) {
-			for (; *cmd->env; cmd->env++)
-				putenv((char*)*cmd->env);
+			char *unsetbuf = NULL;
+			for (; *cmd->env; cmd->env++) {
+				size_t n = strlen(*cmd->env);
+				if (n && (*cmd->env)[n-1] == '=') {
+					unsetbuf = xrealloc(unsetbuf, n);
+					memcpy(unsetbuf, *cmd->env, --n);
+					unsetbuf[n] = '\0';
+					unsetenv(unsetbuf);
+				} else
+					putenv((char*)*cmd->env);
+			}
+			free(unsetbuf);
 		}
 		if (cmd->git_cmd) {
 			execv_git_cmd(cmd->argv);
-- 
1.5.2.51.g16099
