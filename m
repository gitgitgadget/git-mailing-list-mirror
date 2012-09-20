From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v2 12/14] Extract some useful pathspec handling code from builtin/add.c into a library
Date: Thu, 20 Sep 2012 20:46:21 +0100
Message-ID: <1348170383-15751-13-git-send-email-git@adamspiers.org>
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
	id 1TEmiF-0000f4-Pe
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 21:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755496Ab2ITTqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 15:46:43 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:46201 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908Ab2ITTqg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 15:46:36 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 0B5AE2E5EB;
	Thu, 20 Sep 2012 20:46:35 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
In-Reply-To: <1348170383-15751-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206078>

This is in preparation for reuse by a new git check-ignore command.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 Makefile      |  2 ++
 builtin/add.c | 95 ++-------------------------------------------------------
 pathspec.c    | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pathspec.h    |  6 ++++
 4 files changed, 108 insertions(+), 92 deletions(-)
 create mode 100644 pathspec.c
 create mode 100644 pathspec.h

diff --git a/Makefile b/Makefile
index a49d1db..9a4bf9e 100644
--- a/Makefile
+++ b/Makefile
@@ -649,6 +649,7 @@ LIB_H += pack-revindex.h
 LIB_H += pack.h
 LIB_H += parse-options.h
 LIB_H += patch-ids.h
+LIB_H += pathspec.h
 LIB_H += pkt-line.h
 LIB_H += progress.h
 LIB_H += prompt.h
@@ -769,6 +770,7 @@ LIB_OBJS += parse-options-cb.o
 LIB_OBJS += patch-delta.o
 LIB_OBJS += patch-ids.o
 LIB_OBJS += path.o
+LIB_OBJS += pathspec.o
 LIB_OBJS += pkt-line.o
 LIB_OBJS += preload-index.o
 LIB_OBJS += pretty.o
diff --git a/builtin/add.c b/builtin/add.c
index b4ec5cd..c3def9c 100644
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
@@ -153,46 +121,6 @@ static char *prune_directory(struct dir_struct *dir, const char **pathspec, int
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
-	if (!pathspec || !*pathspec)
-		return;
-
-	int i;
-	for (i = 0; pathspec[i]; i++)
-		pathspec[i] = treat_gitlink(pathspec[i]);
-}
-
 static void refresh(int verbose, const char **pathspec)
 {
 	char *seen;
@@ -210,23 +138,6 @@ static void refresh(int verbose, const char **pathspec)
         free(seen);
 }
 
-static const char **validate_pathspec(int argc, const char **argv, const char *prefix)
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
@@ -261,7 +172,7 @@ int interactive_add(int argc, const char **argv, const char *prefix, int patch)
 	const char **pathspec = NULL;
 
 	if (argc) {
-		pathspec = validate_pathspec(argc, argv, prefix);
+		pathspec = validate_pathspec(prefix, argv);
 		if (!pathspec)
 			return -1;
 	}
@@ -428,7 +339,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
 		return 0;
 	}
-	pathspec = validate_pathspec(argc, argv, prefix);
+	pathspec = validate_pathspec(prefix, argv);
 
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
diff --git a/pathspec.c b/pathspec.c
new file mode 100644
index 0000000..10f6643
--- /dev/null
+++ b/pathspec.c
@@ -0,0 +1,97 @@
+#include "cache.h"
+#include "dir.h"
+
+void validate_path(const char *prefix, const char *path)
+{
+	if (has_symlink_leading_path(path, strlen(path))) {
+		int len = prefix ? strlen(prefix) : 0;
+		die(_("'%s' is beyond a symbolic link"), path + len);
+	}
+}
+
+const char **validate_pathspec(const char *prefix, const char **files)
+{
+	const char **pathspec = get_pathspec(prefix, files);
+
+	if (pathspec) {
+		const char **p;
+		for (p = pathspec; *p; p++) {
+			validate_path(prefix, *p);
+		}
+	}
+
+	return pathspec;
+}
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
+	if (!pathspec || !*pathspec)
+		return;
+
+	int i;
+	for (i = 0; pathspec[i]; i++)
+		pathspec[i] = treat_gitlink(pathspec[i]);
+}
diff --git a/pathspec.h b/pathspec.h
new file mode 100644
index 0000000..4ed40a5
--- /dev/null
+++ b/pathspec.h
@@ -0,0 +1,6 @@
+extern void validate_path(const char *prefix, const char *path);
+extern const char **validate_pathspec(const char *prefix, const char **files);
+extern char *find_used_pathspec(const char **pathspec);
+extern void fill_pathspec_matches(const char **pathspec, char *seen, int specs);
+extern const char *treat_gitlink(const char **path);
+extern void treat_gitlinks(const char **pathspec);
-- 
1.7.12.147.g6d168f4
