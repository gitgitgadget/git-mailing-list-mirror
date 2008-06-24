From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] help: check early if we have a command, if not try a
 documentation topic
Date: Tue, 24 Jun 2008 08:46:53 +0200
Message-ID: <20080624084653.8b181a0a.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 08:43:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB2Fl-0001hN-HB
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 08:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbYFXGmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 02:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbYFXGmu
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 02:42:50 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:37707 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495AbYFXGmt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 02:42:49 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 3F7011AB302;
	Tue, 24 Jun 2008 08:42:47 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id DB4331AB308;
	Tue, 24 Jun 2008 08:42:46 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85998>

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
 help.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/help.c b/help.c
index 8aff94c..ef2e6b7 100644
--- a/help.c
+++ b/help.c
@@ -527,20 +527,27 @@ static int is_git_command(const char *s)
 		is_in_cmdlist(&other_cmds, s);
 }
 
+static const char *add_prefix(const char *prefix, const char *cmd)
+{
+	size_t pre_len = strlen(prefix);
+	size_t cmd_len = strlen(cmd);
+	char *p = xmalloc(pre_len + cmd_len + 1);
+	strcpy(p, prefix);
+	strcpy(p + pre_len, cmd);
+	p[pre_len + cmd_len] = 0;
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
1.5.6.109.g4f927.dirty
