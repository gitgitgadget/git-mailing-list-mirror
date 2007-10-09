From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] exec_git_cmd: fix executing commands if path contains spaces
Date: Tue,  9 Oct 2007 23:39:37 +0200
Message-ID: <11919659771056-git-send-email-prohaska@zib.de>
References: <470BB44B.3030500@viscovery.net>
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>
To: j.sixt@viscovery.net
X-From: git-owner@vger.kernel.org Tue Oct 09 23:40:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfMnt-0002fn-7q
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 23:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915AbXJIVjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 17:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754786AbXJIVjk
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 17:39:40 -0400
Received: from mailer.zib.de ([130.73.108.11]:59453 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754678AbXJIVjj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 17:39:39 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l99Ldbv9027982;
	Tue, 9 Oct 2007 23:39:37 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l99LdbKt016093;
	Tue, 9 Oct 2007 23:39:37 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <470BB44B.3030500@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60448>

This patch fixed executing of non-builtins if installation
dir contains spaces. That is 'git var' works now.

The original patch is by Johannes Sixt <j.sixt@viscovery.net>.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 compat/mingw.c    |    2 +-
 exec_cmd.c        |    2 +-
 git-compat-util.h |    1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

Ok, this is what I created from the quick-fix. It works for
me in msysgit. 

Should the patch be polished that it can be applied to git.git
or will we only apply it to 4msysgit?

If it should be polished, what would be the right way?
ifdef in exec_cmd.c?

	Steffen


diff --git a/compat/mingw.c b/compat/mingw.c
index 6632192..0dd0cb0 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -196,7 +196,7 @@ void openlog(const char *ident, int option, int facility)
 {
 }
 
-static const char *quote_arg(const char *arg)
+const char *quote_arg(const char *arg)
 {
 	/* count chars to quote */
 	int len = 0, n = 0;
diff --git a/exec_cmd.c b/exec_cmd.c
index 2a8e48b..4c7c7ca 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -132,7 +132,7 @@ int execv_git_cmd(const char **argv)
 		 */
 
 		tmp = argv[0];
-		argv[0] = git_command;
+		argv[0] = quote_arg(git_command);
 
 		trace_argv_printf(argv, -1, "trace: exec:");
 
diff --git a/git-compat-util.h b/git-compat-util.h
index ba5a1a1..5276221 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -482,6 +482,7 @@ int mingw_socket(int domain, int type, int protocol);
 #define fsync(x) 0
 
 extern void quote_argv(const char **dst, const char **src);
+extern const char *quote_arg(const char *arg);
 extern const char *parse_interpreter(const char *cmd);
 
 extern __attribute__((noreturn)) int git_exit(int code);
-- 
1.5.3.mingw.1.13.g70ed-dirty
