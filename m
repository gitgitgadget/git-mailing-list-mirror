From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] git-help: simplify and fix option parsing.
Date: Sat, 8 Dec 2007 13:18:27 +0100
Message-ID: <20071208131827.65e842c2.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Dec 08 13:17:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0ycu-00043t-Jm
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 13:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbXLHMMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 07:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbXLHMMJ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 07:12:09 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:37196 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203AbXLHMMI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 07:12:08 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 949151AB303;
	Sat,  8 Dec 2007 13:12:04 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 57A9F1AB2F5;
	Sat,  8 Dec 2007 13:12:04 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67549>

Also use "execl_git_cmd" to launch "git-browse-help".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 help.c |   33 ++++++++++++---------------------
 1 files changed, 12 insertions(+), 21 deletions(-)

	Junio wrote:
	> This should be execl_git_cmd() to honor GIT_TRACE and to help
	> transition to bindir != gitexecdir layout, I think.

	Here it is.

diff --git a/help.c b/help.c
index ecc8c66..9d7fc8a 100644
--- a/help.c
+++ b/help.c
@@ -241,7 +241,9 @@ void list_common_cmds_help(void)
 
 static const char *cmd_to_page(const char *git_cmd)
 {
-	if (!prefixcmp(git_cmd, "git"))
+	if (!git_cmd)
+		return "git";
+	else if (!prefixcmp(git_cmd, "git"))
 		return git_cmd;
 	else {
 		int page_len = strlen(git_cmd) + 4;
@@ -268,7 +270,7 @@ static void show_info_page(const char *git_cmd)
 static void show_html_page(const char *git_cmd)
 {
 	const char *page = cmd_to_page(git_cmd);
-	execlp("git-browse-help", "git-browse-help", page, NULL);
+	execl_git_cmd("browse-help", page, NULL);
 }
 
 void help_unknown_cmd(const char *cmd)
@@ -283,38 +285,27 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static void check_help_cmd(const char *help_cmd)
+int cmd_help(int argc, const char **argv, const char *prefix)
 {
-	if (!help_cmd) {
+	if (argc < 2) {
 		printf("usage: %s\n\n", git_usage_string);
 		list_common_cmds_help();
 		exit(0);
 	}
 
-	else if (!strcmp(help_cmd, "--all") || !strcmp(help_cmd, "-a")) {
+	const char *help_cmd = argv[1];
+
+	if (!strcmp(help_cmd, "--all") || !strcmp(help_cmd, "-a")) {
 		printf("usage: %s\n\n", git_usage_string);
 		list_commands();
-		exit(0);
 	}
-}
 
-int cmd_help(int argc, const char **argv, const char *prefix)
-{
-	const char *help_cmd = argc > 1 ? argv[1] : NULL;
-	check_help_cmd(help_cmd);
-
-	if (!strcmp(help_cmd, "--web") || !strcmp(help_cmd, "-w")) {
-		help_cmd = argc > 2 ? argv[2] : NULL;
-		check_help_cmd(help_cmd);
-
-		show_html_page(help_cmd);
+	else if (!strcmp(help_cmd, "--web") || !strcmp(help_cmd, "-w")) {
+		show_html_page(argc > 2 ? argv[2] : NULL);
 	}
 
 	else if (!strcmp(help_cmd, "--info") || !strcmp(help_cmd, "-i")) {
-		help_cmd = argc > 2 ? argv[2] : NULL;
-		check_help_cmd(help_cmd);
-
-		show_info_page(help_cmd);
+		show_info_page(argc > 2 ? argv[2] : NULL);
 	}
 
 	else
-- 
1.5.3.7.2200.g9275-dirty
