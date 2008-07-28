From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 1/2] Refactor, adding prepare_git_cmd(const char **argv)
Date: Mon, 28 Jul 2008 07:50:27 +0200
Message-ID: <1217224228-31303-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Jul 28 07:51:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNLeC-0001JH-EZ
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 07:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbYG1Fup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 01:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752762AbYG1Fuo
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 01:50:44 -0400
Received: from mailer.zib.de ([130.73.108.11]:33551 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752646AbYG1Fun (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 01:50:43 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6S5oT45017479;
	Mon, 28 Jul 2008 07:50:34 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6S5oSL2009748;
	Mon, 28 Jul 2008 07:50:28 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90409>

prepare_git_cmd(const char **argv) adds a first entry "git" to
the array argv.  The new array is allocated on the heap.  It's
the caller's responsibility to release it with free().  The code
was already present in execv_git_cmd() but could not be used from
outside.  Now it can also be called for preparing the command list
in the MinGW codepath in run-command.c.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 exec_cmd.c |    7 ++++++-
 exec_cmd.h |    1 +
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 0ed768d..ce6741e 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -78,7 +78,7 @@ void setup_path(void)
 	strbuf_release(&new_path);
 }
 
-int execv_git_cmd(const char **argv)
+const char **prepare_git_cmd(const char **argv)
 {
 	int argc;
 	const char **nargv;
@@ -91,6 +91,11 @@ int execv_git_cmd(const char **argv)
 	for (argc = 0; argv[argc]; argc++)
 		nargv[argc + 1] = argv[argc];
 	nargv[argc + 1] = NULL;
+	return nargv;
+}
+
+int execv_git_cmd(const char **argv) {
+	const char **nargv = prepare_git_cmd(argv);
 	trace_argv_printf(nargv, "trace: exec:");
 
 	/* execvp() can only ever return if it fails */
diff --git a/exec_cmd.h b/exec_cmd.h
index 0c46cd5..594f961 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -5,6 +5,7 @@ extern void git_set_argv_exec_path(const char *exec_path);
 extern void git_set_argv0_path(const char *path);
 extern const char* git_exec_path(void);
 extern void setup_path(void);
+extern const char **prepare_git_cmd(const char **argv);
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
 extern int execl_git_cmd(const char *cmd, ...);
 extern const char *system_path(const char *path);
-- 
1.6.0.rc0.79.gb0320
