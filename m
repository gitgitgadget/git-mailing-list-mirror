From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] Simplify "external diff from attributes" logic
Date: Sat, 7 Jul 2007 18:21:34 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707071821170.4093@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 07 19:28:50 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7E5P-0006OU-Ai
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 19:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbXGGR2p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 13:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752558AbXGGR2p
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 13:28:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:40298 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752547AbXGGR2o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 13:28:44 -0400
Received: (qmail invoked by alias); 07 Jul 2007 17:28:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 07 Jul 2007 19:28:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SM5ds5mES45DaCDxTddl6fNqD8Fsu8En42iYm5N
	aJRhEPy7zaxa97
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51829>


Since we already store the given diff attribute in the filespec,
we can just as well reuse that, instead of going through the whole
attributes checking process again, when checking for an external
diff program.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c |   39 +++++++++++++++++----------------------
 1 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/diff.c b/diff.c
index a5444df..121524e 100644
--- a/diff.c
+++ b/diff.c
@@ -1195,6 +1195,20 @@ int diff_filespec_is_binary(struct diff_filespec *one)
 	return one->is_binary;
 }
 
+static const char *external_diff_attr(struct diff_filespec *one)
+{
+	diff_filespec_check_attr(one);
+	if (one->diff_attr) {
+		struct ll_diff_driver *drv;
+
+		read_config_if_needed();
+		for (drv = user_diff; drv; drv = drv->next)
+			if (!strcmp(drv->name, one->diff_attr))
+				return drv->cmd;
+	}
+	return NULL;
+}
+
 static const char *funcname_pattern(const char *ident)
 {
 	struct funcname_pattern *pp;
@@ -1860,27 +1874,6 @@ static void run_external_diff(const char *pgm,
 	}
 }
 
-static const char *external_diff_attr(const char *name)
-{
-	struct git_attr_check attr_diff_check;
-
-	setup_diff_attr_check(&attr_diff_check);
-	if (!git_checkattr(name, 1, &attr_diff_check)) {
-		const char *value = attr_diff_check.value;
-		if (!ATTR_TRUE(value) &&
-		    !ATTR_FALSE(value) &&
-		    !ATTR_UNSET(value)) {
-			struct ll_diff_driver *drv;
-
-			read_config_if_needed();
-			for (drv = user_diff; drv; drv = drv->next)
-				if (!strcmp(drv->name, value))
-					return drv->cmd;
-		}
-	}
-	return NULL;
-}
-
 static void run_diff_cmd(const char *pgm,
 			 const char *name,
 			 const char *other,
@@ -1893,7 +1886,9 @@ static void run_diff_cmd(const char *pgm,
 	if (!o->allow_external)
 		pgm = NULL;
 	else {
-		const char *cmd = external_diff_attr(name);
+		const char *cmd = external_diff_attr(one);
+		if (!cmd)
+			cmd = external_diff_attr(two);
 		if (cmd)
 			pgm = cmd;
 	}
-- 
1.5.3.rc0.2712.g125b7f
