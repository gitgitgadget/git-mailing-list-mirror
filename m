From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v4 07/11] pathspec.c: rename newly public functions for clarity
Date: Sun,  6 Jan 2013 16:58:09 +0000
Message-ID: <1357491493-11619-8-git-send-email-git@adamspiers.org>
References: <20130106161758.GC2396@pacific.linksys.moosehall>
 <1357491493-11619-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 17:59:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrtYu-0008A9-Gd
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 17:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756110Ab3AFQ6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 11:58:43 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45597 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756067Ab3AFQ6U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 11:58:20 -0500
Received: from localhost (f.4.d.7.f.d.e.f.f.f.3.7.3.0.a.1.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:1a03:73ff:fedf:7d4f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id AA3B42E65E
	for <git@vger.kernel.org>; Sun,  6 Jan 2013 16:58:19 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.7.33.gb8feba5
In-Reply-To: <1357491493-11619-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212822>

Perform the following function renames to make it explicit that these
pathspec handling functions are for matching against the index, rather
than against a tree or the working directory.

- fill_pathspec_matches() -> add_pathspec_matches_against_index()
- find_used_pathspec() -> find_pathspecs_matching_against_index()

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 builtin/add.c |  4 ++--
 pathspec.c    | 17 +++++++++--------
 pathspec.h    |  4 ++--
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index e51ba44..8c3fdf9 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -117,7 +117,7 @@ static char *prune_directory(struct dir_struct *dir, const char **pathspec, int
 			*dst++ = entry;
 	}
 	dir->nr = dst - dir->entries;
-	fill_pathspec_matches(pathspec, seen, specs);
+	add_pathspec_matches_against_index(pathspec, seen, specs);
 	return seen;
 }
 
@@ -415,7 +415,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 		path_exclude_check_init(&check, &dir);
 		if (!seen)
-			seen = find_used_pathspec(pathspec);
+			seen = find_pathspecs_matching_against_index(pathspec);
 		for (i = 0; pathspec[i]; i++) {
 			if (!seen[i] && pathspec[i][0]
 			    && !file_exists(pathspec[i])) {
diff --git a/pathspec.c b/pathspec.c
index 1472af8..b73b15c 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -13,9 +13,10 @@
  * altogether if seen[] already only contains non-zero entries.
  *
  * If seen[] has not already been written to, it may make sense
- * to use find_used_pathspec() instead.
+ * to use find_pathspecs_matching_against_index() instead.
  */
-void fill_pathspec_matches(const char **pathspec, char *seen, int specs)
+void add_pathspec_matches_against_index(const char **pathspec,
+					char *seen, int specs)
 {
 	int num_unmatched = 0, i;
 
@@ -39,12 +40,12 @@ void fill_pathspec_matches(const char **pathspec, char *seen, int specs)
 /*
  * Finds which of the given pathspecs match items in the index.
  *
- * This is a one-shot wrapper around fill_pathspec_matches() which
- * allocates, populates, and returns a seen[] array indicating the
- * nature of the "closest" (i.e. most specific) matches which each of
- * the given pathspecs achieves against all items in the index.
+ * This is a one-shot wrapper around add_pathspec_matches_against_index()
+ * which allocates, populates, and returns a seen[] array indicating the
+ * nature of the "closest" (i.e. most specific) matches which each of the
+ * given pathspecs achieves against all items in the index.
  */
-char *find_used_pathspec(const char **pathspec)
+char *find_pathspecs_matching_against_index(const char **pathspec)
 {
 	char *seen;
 	int i;
@@ -52,6 +53,6 @@ char *find_used_pathspec(const char **pathspec)
 	for (i = 0; pathspec[i];  i++)
 		; /* just counting */
 	seen = xcalloc(i, 1);
-	fill_pathspec_matches(pathspec, seen, i);
+	add_pathspec_matches_against_index(pathspec, seen, i);
 	return seen;
 }
diff --git a/pathspec.h b/pathspec.h
index 1cb1909..3852bc0 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -1,7 +1,7 @@
 #ifndef PATHSPEC_H
 #define PATHSPEC_H
 
-extern char *find_used_pathspec(const char **pathspec);
-extern void fill_pathspec_matches(const char **pathspec, char *seen, int specs);
+extern char *find_pathspecs_matching_against_index(const char **pathspec);
+extern void add_pathspec_matches_against_index(const char **pathspec, char *seen, int specs);
 
 #endif /* PATHSPEC_H */
-- 
1.7.11.7.33.gb8feba5
