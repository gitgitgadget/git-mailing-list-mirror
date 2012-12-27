From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v3 16/19] pathspec.c: move reusable code from builtin/add.c
Date: Thu, 27 Dec 2012 02:32:35 +0000
Message-ID: <1356575558-2674-17-git-send-email-git@adamspiers.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 03:33:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To3Hq-0006Tl-1r
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 03:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889Ab2L0CdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 21:33:09 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:53771 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab2L0Ccy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 21:32:54 -0500
Received: from localhost (host-2-103-56-128.as13285.net [2.103.56.128])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 716C52E65D
	for <git@vger.kernel.org>; Thu, 27 Dec 2012 02:32:52 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.2.249.g31c7954
In-Reply-To: <1356575558-2674-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212179>

Extract the following functions from builtin/add.c to pathspec.c, in
preparation for reuse by a new git check-ignore command:

  - fill_pathspec_matches()
  - find_used_pathspec()
  - treat_gitlink()
  - treat_gitlinks()
  - validate_pathspec()

The functions being extracted are not changed in any way, except
removal of the 'static' qualifier.

Also add a comment documenting validate_pathspec().

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 Makefile      |  2 ++
 builtin/add.c | 92 +-----------------------------------------------------
 pathspec.c    | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pathspec.h    |  5 +++
 4 files changed, 107 insertions(+), 91 deletions(-)
 create mode 100644 pathspec.c
 create mode 100644 pathspec.h

diff --git a/Makefile b/Makefile
index 13293d3..48facad 100644
--- a/Makefile
+++ b/Makefile
@@ -645,6 +645,7 @@ LIB_H += pack-refs.h
 LIB_H += pack-revindex.h
 LIB_H += parse-options.h
 LIB_H += patch-ids.h
+LIB_H += pathspec.h
 LIB_H += pkt-line.h
 LIB_H += progress.h
 LIB_H += prompt.h
@@ -758,6 +759,7 @@ LIB_OBJS += parse-options-cb.o
 LIB_OBJS += patch-delta.o
 LIB_OBJS += patch-ids.o
 LIB_OBJS += path.o
+LIB_OBJS += pathspec.o
 LIB_OBJS += pkt-line.o
 LIB_OBJS += preload-index.o
 LIB_OBJS += pretty.o
diff --git a/builtin/add.c b/builtin/add.c
index 1ba2a86..d3bae78 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "dir.h"
+#include "pathspec.h"
 #include "exec_cmd.h"
 #include "cache-tree.h"
 #include "run-command.h"
@@ -97,39 +98,6 @@ int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
 	return !!data.add_errors;
 }
 
-static void fill_pathspec_matches(const char **pathspec, char *seen, int specs)
-{
-	int num_unmatched = 0, i;
-
-	/*
-	 * Since we are walking the index as if we were walking the directory,
-	 * we have to mark the matched pathspec as seen; otherwise we will
-	 * mistakenly think that the user gave a pathspec that did not match
-	 * anything.
-	 */
-	for (i = 0; i < specs; i++)
-		if (!seen[i])
-			num_unmatched++;
-	if (!num_unmatched)
-		return;
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen);
-	}
-}
-
-static char *find_used_pathspec(const char **pathspec)
-{
-	char *seen;
-	int i;
-
-	for (i = 0; pathspec[i];  i++)
-		; /* just counting */
-	seen = xcalloc(i, 1);
-	fill_pathspec_matches(pathspec, seen, i);
-	return seen;
-}
-
 static char *prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
 {
 	char *seen;
@@ -153,47 +121,6 @@ static char *prune_directory(struct dir_struct *dir, const char **pathspec, int
 	return seen;
 }
 
-/*
- * Check whether path refers to a submodule, or something inside a
- * submodule.  If the former, returns the path with any trailing slash
- * stripped.  If the latter, dies with an error message.
- */
-const char *treat_gitlink(const char *path)
-{
-	int i, path_len = strlen(path);
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		if (S_ISGITLINK(ce->ce_mode)) {
-			int ce_len = ce_namelen(ce);
-			if (path_len <= ce_len || path[ce_len] != '/' ||
-			    memcmp(ce->name, path, ce_len))
-				/* path does not refer to this
-				 * submodule or anything inside it */
-				continue;
-			if (path_len == ce_len + 1) {
-				/* path refers to submodule;
-				 * strip trailing slash */
-				return xstrndup(ce->name, ce_len);
-			} else {
-				die (_("Path '%s' is in submodule '%.*s'"),
-				     path, ce_len, ce->name);
-			}
-		}
-	}
-	return path;
-}
-
-void treat_gitlinks(const char **pathspec)
-{
-	int i;
-
-	if (!pathspec || !*pathspec)
-		return;
-
-	for (i = 0; pathspec[i]; i++)
-		pathspec[i] = treat_gitlink(pathspec[i]);
-}
-
 static void refresh(int verbose, const char **pathspec)
 {
 	char *seen;
@@ -211,23 +138,6 @@ static void refresh(int verbose, const char **pathspec)
         free(seen);
 }
 
-static const char **validate_pathspec(const char **argv, const char *prefix)
-{
-	const char **pathspec = get_pathspec(prefix, argv);
-
-	if (pathspec) {
-		const char **p;
-		for (p = pathspec; *p; p++) {
-			if (has_symlink_leading_path(*p, strlen(*p))) {
-				int len = prefix ? strlen(prefix) : 0;
-				die(_("'%s' is beyond a symbolic link"), *p + len);
-			}
-		}
-	}
-
-	return pathspec;
-}
-
 int run_add_interactive(const char *revision, const char *patch_mode,
 			const char **pathspec)
 {
diff --git a/pathspec.c b/pathspec.c
new file mode 100644
index 0000000..8aea0d2
--- /dev/null
+++ b/pathspec.c
@@ -0,0 +1,99 @@
+#include "cache.h"
+#include "dir.h"
+#include "pathspec.h"
+
+void fill_pathspec_matches(const char **pathspec, char *seen, int specs)
+{
+	int num_unmatched = 0, i;
+
+	/*
+	 * Since we are walking the index as if we were walking the directory,
+	 * we have to mark the matched pathspec as seen; otherwise we will
+	 * mistakenly think that the user gave a pathspec that did not match
+	 * anything.
+	 */
+	for (i = 0; i < specs; i++)
+		if (!seen[i])
+			num_unmatched++;
+	if (!num_unmatched)
+		return;
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen);
+	}
+}
+
+char *find_used_pathspec(const char **pathspec)
+{
+	char *seen;
+	int i;
+
+	for (i = 0; pathspec[i];  i++)
+		; /* just counting */
+	seen = xcalloc(i, 1);
+	fill_pathspec_matches(pathspec, seen, i);
+	return seen;
+}
+
+/*
+ * Check whether path refers to a submodule, or something inside a
+ * submodule.  If the former, returns the path with any trailing slash
+ * stripped.  If the latter, dies with an error message.
+ */
+const char *treat_gitlink(const char *path)
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
+}
+
+/*
+ * Normalizes argv relative to prefix, via get_pathspec(), and then
+ * dies if any path in the normalized list refers to a file inside a
+ * symlinked directory.
+ */
+const char **validate_pathspec(const char **argv, const char *prefix)
+{
+	const char **pathspec = get_pathspec(prefix, argv);
+
+	if (pathspec) {
+		const char **p;
+		for (p = pathspec; *p; p++) {
+			if (has_symlink_leading_path(*p, strlen(*p))) {
+				int len = prefix ? strlen(prefix) : 0;
+				die(_("'%s' is beyond a symbolic link"), *p + len);
+			}
+		}
+	}
+
+	return pathspec;
+}
diff --git a/pathspec.h b/pathspec.h
new file mode 100644
index 0000000..8bb670b
--- /dev/null
+++ b/pathspec.h
@@ -0,0 +1,5 @@
+extern char *find_used_pathspec(const char **pathspec);
+extern void fill_pathspec_matches(const char **pathspec, char *seen, int specs);
+extern const char *treat_gitlink(const char *path);
+extern void treat_gitlinks(const char **pathspec);
+extern const char **validate_pathspec(const char **argv, const char *prefix);
-- 
1.7.11.2.249.g31c7954
