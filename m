From: David Barr <david.barr@cordelta.com>
Subject: [PATCH] RFC: help.autocorrect prompt
Date: Mon,  6 Sep 2010 12:28:26 +1000
Message-ID: <1283740106-11411-1-git-send-email-david.barr@cordelta.com>
Cc: David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 06 04:41:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsReV-0005Uo-7m
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 04:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923Ab0IFClb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 22:41:31 -0400
Received: from static-198-196.grapevine.transact.net.au ([121.127.198.196]:55957
	"EHLO mailhost.cordelta" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753972Ab0IFCla (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 22:41:30 -0400
X-Greylist: delayed 598 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Sep 2010 22:41:30 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id B1CE7C051;
	Mon,  6 Sep 2010 12:31:29 +1000 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PLV1FJYoC9m7; Mon,  6 Sep 2010 12:31:26 +1000 (EST)
Received: from localhost.localdomain (unknown [192.168.123.57])
	by mailhost.cordelta (Postfix) with ESMTP id 87349C04F;
	Mon,  6 Sep 2010 12:31:26 +1000 (EST)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155515>

Added a new configuration value for help.autocorrect.
A value of 'prompt' causes git to wait for confirmation
before executing the assumed command.
---
 help.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/help.c b/help.c
index 7f4928e..924ce60 100644
--- a/help.c
+++ b/help.c
@@ -267,8 +267,12 @@ static struct cmdnames aliases;
 
 static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "help.autocorrect"))
-		autocorrect = git_config_int(var,value);
+	if (!strcmp(var, "help.autocorrect")) {
+		if (!strcmp(value, "prompt"))
+			autocorrect = INT_MAX;
+		else
+			autocorrect = git_config_int(var,value);
+	}
 	/* Also use aliases for command lookup */
 	if (!prefixcmp(var, "alias."))
 		add_cmdname(&aliases, var + 6, strlen(var + 6));
@@ -342,7 +346,10 @@ const char *help_unknown_cmd(const char *cmd)
 			"which does not exist.\n"
 			"Continuing under the assumption that you meant '%s'\n",
 			cmd, assumed);
-		if (autocorrect > 0) {
+		if (autocorrect == INT_MAX) {
+			if (strcmp("y", git_getpass("Continue? (y/n) ")))
+				exit(1);
+		} else if (autocorrect > 0) {
 			fprintf(stderr, "in %0.1f seconds automatically...\n",
 				(float)autocorrect/10.0);
 			poll(NULL, 0, autocorrect * 100);
-- 
1.7.0.4
