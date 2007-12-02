From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] git-help: add -i|--info option to display info page.
Date: Sun, 2 Dec 2007 06:07:40 +0100
Message-ID: <20071202060740.269e54ad.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Wong <normalperson@yhbt.net>
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Dec 02 06:01:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IygxO-0003BV-TX
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 06:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbXLBFBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 00:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbXLBFBL
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 00:01:11 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:35054 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706AbXLBFBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 00:01:09 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id B8E8F1AB2B5;
	Sun,  2 Dec 2007 06:01:08 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 1FD621AB2B2;
	Sun,  2 Dec 2007 06:01:08 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66755>

"git help --info XXX" will now call "info git-XXX".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 help.c |   35 +++++++++++++++++++++++++++--------
 1 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/help.c b/help.c
index 37a9c25..0f1cb71 100644
--- a/help.c
+++ b/help.c
@@ -239,24 +239,32 @@ void list_common_cmds_help(void)
 	}
 }
 
-static void show_man_page(const char *git_cmd)
+static const char *cmd_to_page(const char *git_cmd)
 {
-	const char *page;
-
 	if (!prefixcmp(git_cmd, "git"))
-		page = git_cmd;
+		return git_cmd;
 	else {
 		int page_len = strlen(git_cmd) + 4;
 		char *p = xmalloc(page_len + 1);
 		strcpy(p, "git-");
 		strcpy(p + 4, git_cmd);
 		p[page_len] = 0;
-		page = p;
+		return p;
 	}
+}
 
+static void show_man_page(const char *git_cmd)
+{
+	const char *page = cmd_to_page(git_cmd);
 	execlp("man", "man", page, NULL);
 }
 
+static void show_info_page(const char *git_cmd)
+{
+	const char *page = cmd_to_page(git_cmd);
+	execlp("info", "info", page, NULL);
+}
+
 void help_unknown_cmd(const char *cmd)
 {
 	fprintf(stderr, "git: '%s' is not a git-command. See 'git --help'.\n", cmd);
@@ -269,10 +277,8 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-int cmd_help(int argc, const char **argv, const char *prefix)
+static void check_help_cmd(const char *help_cmd)
 {
-	const char *help_cmd = argc > 1 ? argv[1] : NULL;
-
 	if (!help_cmd) {
 		printf("usage: %s\n\n", git_usage_string);
 		list_common_cmds_help();
@@ -284,6 +290,19 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		list_commands();
 		exit(0);
 	}
+}
+
+int cmd_help(int argc, const char **argv, const char *prefix)
+{
+	const char *help_cmd = argc > 1 ? argv[1] : NULL;
+	check_help_cmd(help_cmd);
+
+	if (!strcmp(help_cmd, "--info") || !strcmp(help_cmd, "-i")) {
+		help_cmd = argc > 2 ? argv[2] : NULL;
+		check_help_cmd(help_cmd);
+
+		show_info_page(help_cmd);
+	}
 
 	else
 		show_man_page(help_cmd);
-- 
1.5.3.6.1993.g154f-dirty
