From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] Prepare execv_git_cmd() for removal of builtins from the filesystem
Date: Sat,  1 Dec 2007 23:03:23 -0800
Message-ID: <1196579005-5662-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 02 08:03:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iyirm-0005zf-Hh
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 08:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbXLBHDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 02:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbXLBHDa
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 02:03:30 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56656 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbXLBHD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 02:03:29 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 534552F0
	for <git@vger.kernel.org>; Sun,  2 Dec 2007 02:03:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id AFE009A0F0
	for <git@vger.kernel.org>; Sun,  2 Dec 2007 02:03:49 -0500 (EST)
X-Mailer: git-send-email 1.5.3.6.2090.g4ece0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66763>

Currently, execv_git_cmd() always try running the dashed form, which
means we cannot easily remove the git-foo hardlinks for built-in
commands.  This updates the function to always exec "git foo" form, and
makes sure "git" potty does not infinitely recurse to itself.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 exec_cmd.c |   31 ++++++++++++-------------------
 git.c      |   32 +++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 2d0a758..10b2908 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -65,32 +65,25 @@ void setup_path(const char *cmd_path)
 
 int execv_git_cmd(const char **argv)
 {
-	struct strbuf cmd;
-	const char *tmp;
-
-	strbuf_init(&cmd, 0);
-	strbuf_addf(&cmd, "git-%s", argv[0]);
+	int argc;
+	const char **nargv;
 
-	/*
-	 * argv[0] must be the git command, but the argv array
-	 * belongs to the caller, and may be reused in
-	 * subsequent loop iterations. Save argv[0] and
-	 * restore it on error.
-	 */
-	tmp = argv[0];
-	argv[0] = cmd.buf;
+	for (argc = 0; argv[argc]; argc++)
+		; /* just counting */
+	nargv = xmalloc(sizeof(*nargv) * (argc + 2));
 
-	trace_argv_printf(argv, -1, "trace: exec:");
+	nargv[0] = "git";
+	for (argc = 0; argv[argc]; argc++)
+		nargv[argc + 1] = argv[argc];
+	nargv[argc + 1] = NULL;
+	trace_argv_printf(nargv, -1, "trace: exec:");
 
 	/* execvp() can only ever return if it fails */
-	execvp(cmd.buf, (char **)argv);
+	execvp("git", (char **)nargv);
 
 	trace_printf("trace: exec failed: %s\n", strerror(errno));
 
-	argv[0] = tmp;
-
-	strbuf_release(&cmd);
-
+	free(nargv);
 	return -1;
 }
 
diff --git a/git.c b/git.c
index 01bbbc7..d690426 100644
--- a/git.c
+++ b/git.c
@@ -382,6 +382,36 @@ static void handle_internal_command(int argc, const char **argv)
 	}
 }
 
+static void execv_dashed_external(const char **argv)
+{
+	struct strbuf cmd;
+	const char *tmp;
+
+	strbuf_init(&cmd, 0);
+	strbuf_addf(&cmd, "git-%s", argv[0]);
+
+	/*
+	 * argv[0] must be the git command, but the argv array
+	 * belongs to the caller, and may be reused in
+	 * subsequent loop iterations. Save argv[0] and
+	 * restore it on error.
+	 */
+	tmp = argv[0];
+	argv[0] = cmd.buf;
+
+	trace_argv_printf(argv, -1, "trace: exec:");
+
+	/* execvp() can only ever return if it fails */
+	execvp(cmd.buf, (char **)argv);
+
+	trace_printf("trace: exec failed: %s\n", strerror(errno));
+
+	argv[0] = tmp;
+
+	strbuf_release(&cmd);
+}
+
+
 int main(int argc, const char **argv)
 {
 	const char *cmd = argv[0] ? argv[0] : "git-help";
@@ -445,7 +475,7 @@ int main(int argc, const char **argv)
 		handle_internal_command(argc, argv);
 
 		/* .. then try the external ones */
-		execv_git_cmd(argv);
+		execv_dashed_external(argv);
 
 		/* It could be an alias -- this works around the insanity
 		 * of overriding "git log" with "git show" by having
-- 
1.5.3.6.2090.g4ece0
