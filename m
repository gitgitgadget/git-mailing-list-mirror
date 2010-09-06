From: David Barr <david.barr@cordelta.com>
Subject: [PATCH] help.autocorrect prompt
Date: Mon,  6 Sep 2010 17:27:10 +1000
Message-ID: <1283758030-13345-1-git-send-email-david.barr@cordelta.com>
References: <20100906025949.GA23594@burratino>
Cc: David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 06 09:26:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsW5q-0007LW-Co
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 09:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299Ab0IFH0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 03:26:13 -0400
Received: from static-198-196.grapevine.transact.net.au ([121.127.198.196]:56505
	"EHLO mailhost.cordelta" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751052Ab0IFH0M (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 03:26:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 6CEF2C051;
	Mon,  6 Sep 2010 17:26:07 +1000 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vc5HY6T0PaVe; Mon,  6 Sep 2010 17:26:05 +1000 (EST)
Received: from dba.cordelta (unknown [192.168.123.57])
	by mailhost.cordelta (Postfix) with ESMTP id 3B738C04F;
	Mon,  6 Sep 2010 17:26:05 +1000 (EST)
X-Mailer: git-send-email 1.7.2.3.392.g02377.dirty
In-Reply-To: <20100906025949.GA23594@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155541>

Added a new configuration value for help.autocorrect.
A value of 'prompt' causes git to wait for confirmation
before executing the assumed command.

Signed-off-by: David Barr <david.barr@cordelta.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 help.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/help.c b/help.c
index 7f4928e..2282885 100644
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
@@ -342,7 +346,16 @@ const char *help_unknown_cmd(const char *cmd)
 			"which does not exist.\n"
 			"Continuing under the assumption that you meant '%s'\n",
 			cmd, assumed);
-		if (autocorrect > 0) {
+		if (autocorrect == INT_MAX) {
+			char answer[3];
+			if (!isatty(STDIN_FILENO) || !isatty(STDERR_FILENO))
+				exit(1);
+			fprintf(stderr, "Continue? (y/n) ");
+			if (!fgets(answer, sizeof(answer), stdin))
+				exit(1);
+			if (*answer != 'y' && *answer != 'Y')
+				exit(1);
+		} else if (autocorrect > 0) {
 			fprintf(stderr, "in %0.1f seconds automatically...\n",
 				(float)autocorrect/10.0);
 			poll(NULL, 0, autocorrect * 100);
-- 
1.7.2.3.392.g02377.dirty
