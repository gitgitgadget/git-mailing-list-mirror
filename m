From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v3 14/19] add.c: refactor treat_gitlinks()
Date: Thu, 27 Dec 2012 02:32:33 +0000
Message-ID: <1356575558-2674-15-git-send-email-git@adamspiers.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 03:33:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To3Hq-0006Tl-OG
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 03:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab2L0CdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 21:33:17 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:53769 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab2L0Ccw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 21:32:52 -0500
Received: from localhost (host-2-103-56-128.as13285.net [2.103.56.128])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 24BA02E5DB
	for <git@vger.kernel.org>; Thu, 27 Dec 2012 02:32:51 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.2.249.g31c7954
In-Reply-To: <1356575558-2674-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212181>

Extract the body of the for loop in treat_gitlinks() into a separate
treat_gitlink() function so that it can be reused elsewhere.  This
paves the way for a new check-ignore sub-command.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 builtin/add.c | 50 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index c689f37..856d232 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -153,31 +153,45 @@ static char *prune_directory(struct dir_struct *dir, const char **pathspec, int
 	return seen;
 }
 
-static void treat_gitlinks(const char **pathspec)
+/*
+ * Check whether path refers to a submodule, or something inside a
+ * submodule.  If the former, returns the path with any trailing slash
+ * stripped.  If the latter, dies with an error message.
+ */
+const char *treat_gitlink(const char *path)
 {
-	int i;
-
-	if (!pathspec || !*pathspec)
-		return;
-
+	int i, path_len = strlen(path);
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 		if (S_ISGITLINK(ce->ce_mode)) {
-			int len = ce_namelen(ce), j;
-			for (j = 0; pathspec[j]; j++) {
-				int len2 = strlen(pathspec[j]);
-				if (len2 <= len || pathspec[j][len] != '/' ||
-				    memcmp(ce->name, pathspec[j], len))
-					continue;
-				if (len2 == len + 1)
-					/* strip trailing slash */
-					pathspec[j] = xstrndup(ce->name, len);
-				else
-					die (_("Path '%s' is in submodule '%.*s'"),
-						pathspec[j], len, ce->name);
+			int ce_len = ce_namelen(ce);
+			if (path_len <= ce_len || path[ce_len] != '/' ||
+			    memcmp(ce->name, path, ce_len))
+				/* path does not refer to this
+				 * submodule or anything inside it */
+				continue;
+			if (path_len == ce_len + 1) {
+				/* path refers to submodule;
+				 * strip trailing slash */
+				return xstrndup(ce->name, ce_len);
+			} else {
+				die (_("Path '%s' is in submodule '%.*s'"),
+				     path, ce_len, ce->name);
 			}
 		}
 	}
+	return path;
+}
+
+void treat_gitlinks(const char **pathspec)
+{
+	int i;
+
+	if (!pathspec || !*pathspec)
+		return;
+
+	for (i = 0; pathspec[i]; i++)
+		pathspec[i] = treat_gitlink(pathspec[i]);
 }
 
 static void refresh(int verbose, const char **pathspec)
-- 
1.7.11.2.249.g31c7954
