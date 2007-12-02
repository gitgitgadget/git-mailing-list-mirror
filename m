From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] git-shell: accept "git foo" form
Date: Sat,  1 Dec 2007 23:03:25 -0800
Message-ID: <1196579005-5662-3-git-send-email-gitster@pobox.com>
References: <1196579005-5662-1-git-send-email-gitster@pobox.com>
 <1196579005-5662-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 02 08:04:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyisB-00064Q-H1
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 08:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbXLBHDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 02:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbXLBHDg
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 02:03:36 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56663 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbXLBHDe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 02:03:34 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 154C52F0
	for <git@vger.kernel.org>; Sun,  2 Dec 2007 02:03:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 884DB9A10E
	for <git@vger.kernel.org>; Sun,  2 Dec 2007 02:03:55 -0500 (EST)
X-Mailer: git-send-email 1.5.3.6.2090.g4ece0
In-Reply-To: <1196579005-5662-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66765>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 shell.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/shell.c b/shell.c
index 9826109..729797c 100644
--- a/shell.c
+++ b/shell.c
@@ -19,17 +19,13 @@ static int do_generic_cmd(const char *me, char *arg)
 	return execv_git_cmd(my_argv);
 }
 
-static int do_cvs_cmd(const char *me, char *arg)
+static int do_cvs_cmd(void)
 {
 	const char *cvsserver_argv[3] = {
 		"cvsserver", "server", NULL
 	};
 
-	if (!arg || strcmp(arg, "server"))
-		die("git-cvsserver only handles server: %s", arg);
-
 	setup_path(NULL);
-
 	return execv_git_cmd(cvsserver_argv);
 }
 
@@ -40,7 +36,6 @@ static struct commands {
 } cmd_list[] = {
 	{ "git-receive-pack", do_generic_cmd },
 	{ "git-upload-pack", do_generic_cmd },
-	{ "cvs", do_cvs_cmd },
 	{ NULL },
 };
 
@@ -49,15 +44,24 @@ int main(int argc, char **argv)
 	char *prog;
 	struct commands *cmd;
 
+	/*
+	 * Special hack to pretend to be a CVS server
+	 */
 	if (argc == 2 && !strcmp(argv[1], "cvs server"))
-		argv--;
-	/* We want to see "-c cmd args", and nothing else */
-	else if (argc != 3 || strcmp(argv[1], "-c"))
+		exit(do_cvs_cmd());
+
+	/*
+	 * We do not accept anything but "-c" followed by "cmd arg",
+	 * where "cmd" is a very limited subset of git commands.
+	 */
+	if (argc != 3 || strcmp(argv[1], "-c"))
 		die("What do you think I am? A shell?");
 
 	prog = argv[2];
-	argv += 2;
-	argc -= 2;
+	if (!strncmp(prog, "git", 3) && isspace(prog[3]))
+		/* Accept "git foo" as if the caller said "git-foo". */
+		prog[3] = '-';
+
 	for (cmd = cmd_list ; cmd->name ; cmd++) {
 		int len = strlen(cmd->name);
 		char *arg;
-- 
1.5.3.6.2090.g4ece0
