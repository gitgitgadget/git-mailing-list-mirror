From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH resend] help: check early if we have a command, if not try a
 documentation topic
Date: Sat, 28 Jun 2008 06:35:03 +0200
Message-ID: <20080628063503.4dee6230.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 06:32:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCS6c-0001be-00
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 06:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbYF1EbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 00:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbYF1EbI
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 00:31:08 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:50679 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753790AbYF1EbF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 00:31:05 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id F065E1AB2B3;
	Sat, 28 Jun 2008 06:31:01 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 5A9401AB2AC;
	Sat, 28 Jun 2008 06:31:00 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before this patch, something like "git help tutorial" did not work,
people had to use "git help gittutorial" which is not very intuitive.

This patch uses the "is_git_command" function to test early if the
argument passed to "git help" is a git command, and if this is not the
case then we prefix the argument with "git" instead of "git-".

This way, things like "git help tutorial" or "git help glossary" will
work fine.

The little downside of this patch is that the "is_git_command" is a
little bit slow.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 help.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

	The only change since the previous patch is that I removed
	the following line after the 2 strcpy:

	p[pre_len + cmd_len] = 0;
	
	because it is useless.

diff --git a/help.c b/help.c
index 6c16fb4..1f990b9 100644
--- a/help.c
+++ b/help.c
@@ -550,20 +550,26 @@ static int is_git_command(const char *s)
 		is_in_cmdlist(&other_cmds, s);
 }
 
+static const char *add_prefix(const char *prefix, const char *cmd)
+{
+	size_t pre_len = strlen(prefix);
+	size_t cmd_len = strlen(cmd);
+	char *p = xmalloc(pre_len + cmd_len + 1);
+	strcpy(p, prefix);
+	strcpy(p + pre_len, cmd);
+	return p;
+}
+
 static const char *cmd_to_page(const char *git_cmd)
 {
 	if (!git_cmd)
 		return "git";
 	else if (!prefixcmp(git_cmd, "git"))
 		return git_cmd;
-	else {
-		int page_len = strlen(git_cmd) + 4;
-		char *p = xmalloc(page_len + 1);
-		strcpy(p, "git-");
-		strcpy(p + 4, git_cmd);
-		p[page_len] = 0;
-		return p;
-	}
+	else if (is_git_command(git_cmd))
+		return add_prefix("git-", git_cmd);
+	else
+		return add_prefix("git", git_cmd);
 }
 
 static void setup_man_path(void)
-- 
1.5.6.1.202.g316c4.dirty
