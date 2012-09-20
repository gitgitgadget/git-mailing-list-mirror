From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v2 11/14] Refactor treat_gitlinks()
Date: Thu, 20 Sep 2012 20:46:20 +0100
Message-ID: <1348170383-15751-12-git-send-email-git@adamspiers.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 21:47:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEmiF-0000f4-6R
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 21:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755128Ab2ITTqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 15:46:42 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:46199 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754906Ab2ITTqf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 15:46:35 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 2426C2E5E7;
	Thu, 20 Sep 2012 20:46:34 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
In-Reply-To: <1348170383-15751-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206081>

Extract the body of the for loop in treat_gitlinks() into a separate
treat_gitlink() function so that it can be reused elsewhere.  This
paves the way for a new check-ignore sub-command.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 builtin/add.c | 49 +++++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 075312a..b4ec5cd 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -153,31 +153,44 @@ static char *prune_directory(struct dir_struct *dir, const char **pathspec, int
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
+	if (!pathspec || !*pathspec)
+		return;
+
+	int i;
+	for (i = 0; pathspec[i]; i++)
+		pathspec[i] = treat_gitlink(pathspec[i]);
 }
 
 static void refresh(int verbose, const char **pathspec)
-- 
1.7.12.147.g6d168f4
