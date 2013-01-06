From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v4 08/11] add.c: extract check_path_for_gitlink() from treat_gitlinks() for reuse
Date: Sun,  6 Jan 2013 16:58:10 +0000
Message-ID: <1357491493-11619-9-git-send-email-git@adamspiers.org>
References: <20130106161758.GC2396@pacific.linksys.moosehall>
 <1357491493-11619-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 17:59:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrtYu-0008A9-0u
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 17:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109Ab3AFQ6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 11:58:39 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45596 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756090Ab3AFQ6V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 11:58:21 -0500
Received: from localhost (f.4.d.7.f.d.e.f.f.f.3.7.3.0.a.1.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:1a03:73ff:fedf:7d4f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 56C302E5DE
	for <git@vger.kernel.org>; Sun,  6 Jan 2013 16:58:20 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.7.33.gb8feba5
In-Reply-To: <1357491493-11619-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212824>

Extract the body of the for loop in treat_gitlinks() into a separate
check_path_for_gitlink() function so that it can be reused elsewhere.
This paves the way for a new check-ignore sub-command.

Also document treat_gitlinks().

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
Unlike v3, this series doesn't make treat_gitlinks() public.

 builtin/add.c | 24 ++++++------------------
 pathspec.c    | 31 +++++++++++++++++++++++++++++++
 pathspec.h    |  1 +
 3 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 8c3fdf9..f95ded2 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -121,6 +121,10 @@ static char *prune_directory(struct dir_struct *dir, const char **pathspec, int
 	return seen;
 }
 
+/*
+ * Checks the index to see whether any path in pathspec refers to
+ * something inside a submodule.  If so, dies with an error message.
+ */
 static void treat_gitlinks(const char **pathspec)
 {
 	int i;
@@ -128,24 +132,8 @@ static void treat_gitlinks(const char **pathspec)
 	if (!pathspec || !*pathspec)
 		return;
 
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		if (S_ISGITLINK(ce->ce_mode)) {
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
-			}
-		}
-	}
+	for (i = 0; pathspec[i]; i++)
+		pathspec[i] = check_path_for_gitlink(pathspec[i]);
 }
 
 static void refresh(int verbose, const char **pathspec)
diff --git a/pathspec.c b/pathspec.c
index b73b15c..02d3344 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -56,3 +56,34 @@ char *find_pathspecs_matching_against_index(const char **pathspec)
 	add_pathspec_matches_against_index(pathspec, seen, i);
 	return seen;
 }
+
+/*
+ * Check the index to see whether path refers to a submodule, or
+ * something inside a submodule.  If the former, returns the path with
+ * any trailing slash stripped.  If the latter, dies with an error
+ * message.
+ */
+const char *check_path_for_gitlink(const char *path)
+{
+	int i, path_len = strlen(path);
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		if (S_ISGITLINK(ce->ce_mode)) {
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
+			}
+		}
+	}
+	return path;
+}
diff --git a/pathspec.h b/pathspec.h
index 3852bc0..bf8eb96 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -3,5 +3,6 @@
 
 extern char *find_pathspecs_matching_against_index(const char **pathspec);
 extern void add_pathspec_matches_against_index(const char **pathspec, char *seen, int specs);
+extern const char *check_path_for_gitlink(const char *path);
 
 #endif /* PATHSPEC_H */
-- 
1.7.11.7.33.gb8feba5
