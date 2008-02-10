From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] diff.c: guard config parser from value=NULL
Date: Sun, 10 Feb 2008 19:35:34 +0100
Message-ID: <20080210193534.d11d8b15.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Govind Salinas <blix@sophiasuchtig.com>,
	Martin Koegler <mkoegler@auto.tuw
X-From: git-owner@vger.kernel.org Sun Feb 10 19:30:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOGwP-0005O6-Uh
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 19:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbYBJS3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 13:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbYBJS3k
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 13:29:40 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:48047 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597AbYBJS3j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 13:29:39 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 64BE61AB37F;
	Sun, 10 Feb 2008 19:29:37 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 58DE21AB33C;
	Sun, 10 Feb 2008 19:29:36 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73387>

In fact we also guard for value="" as it doesn't make more sense
for the variables here.

We do that by using a new function 'xstrdup_confval' to avoid code
duplication.

By the way this changes a 'strdup' into 'xstrdup'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 diff.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index 5b8afdc..d51aecb 100644
--- a/diff.c
+++ b/diff.c
@@ -60,6 +60,14 @@ static struct ll_diff_driver {
 	char *cmd;
 } *user_diff, **user_diff_tail;
 
+static int xstrdup_confval(const char *dest, const char *var, const char *value)
+{
+	if (!value || !*value)
+		return error("%s: lacks value", var);
+	dest = xstrdup(value);
+	return 0;
+}
+
 /*
  * Currently there is only "diff.<drivername>.command" variable;
  * because there are "diff.color.<slot>" variables, we are parsing
@@ -86,10 +94,7 @@ static int parse_lldiff_command(const char *var, const char *ep, const char *val
 		user_diff_tail = &(drv->next);
 	}
 
-	if (!value)
-		return error("%s: lacks value", var);
-	drv->cmd = strdup(value);
-	return 0;
+	return xstrdup_confval(drv->cmd, var, value);
 }
 
 /*
@@ -123,8 +128,8 @@ static int parse_funcname_pattern(const char *var, const char *ep, const char *v
 	}
 	if (pp->pattern)
 		free(pp->pattern);
-	pp->pattern = xstrdup(value);
-	return 0;
+
+	return xstrdup_confval(pp->pattern, var, value);
 }
 
 /*
@@ -157,10 +162,8 @@ int git_diff_ui_config(const char *var, const char *value)
 		diff_auto_refresh_index = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "diff.external")) {
-		external_diff_cmd_cfg = xstrdup(value);
-		return 0;
-	}
+	if (!strcmp(var, "diff.external"))
+		return xstrdup_confval(external_diff_cmd_cfg, var, value);
 	if (!prefixcmp(var, "diff.")) {
 		const char *ep = strrchr(var, '.');
 
-- 
1.5.4.35.g3360
