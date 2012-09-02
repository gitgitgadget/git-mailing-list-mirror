From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH 7/9] Extract some useful pathspec handling code from builtin/add.c into a library
Date: Sun,  2 Sep 2012 01:12:09 +0100
Message-ID: <1346544731-938-8-git-send-email-git@adamspiers.org>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 02:19:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7xuv-00016s-5f
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 02:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777Ab2IBAS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 20:18:57 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:55516 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab2IBAS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 20:18:56 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Sep 2012 20:18:55 EDT
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 5FF052E5ED;
	Sun,  2 Sep 2012 01:12:20 +0100 (BST)
X-Mailer: git-send-email 1.7.12.155.ge5750d5.dirty
In-Reply-To: <1346544731-938-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204654>

This is in preparation for reuse by a new git check-ignore command.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 Makefile      |  2 ++
 builtin/add.c | 82 +++----------------------------------------------------
 pathspec.c    | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pathspec.h    |  6 +++++
 4 files changed, 98 insertions(+), 79 deletions(-)
 create mode 100644 pathspec.c
 create mode 100644 pathspec.h

diff --git a/Makefile b/Makefile
index 66e8216..272ab69 100644
--- a/Makefile
+++ b/Makefile
@@ -640,6 +640,7 @@ LIB_H += pack-revindex.h
 LIB_H += pack.h
 LIB_H += parse-options.h
 LIB_H += patch-ids.h
+LIB_H += pathspec.h
 LIB_H += pkt-line.h
 LIB_H += progress.h
 LIB_H += prompt.h
@@ -760,6 +761,7 @@ LIB_OBJS += parse-options-cb.o
 LIB_OBJS += patch-delta.o
 LIB_OBJS += patch-ids.o
 LIB_OBJS += path.o
+LIB_OBJS += pathspec.o
 LIB_OBJS += pkt-line.o
 LIB_OBJS += preload-index.o
 LIB_OBJS += pretty.o
diff --git a/builtin/add.c b/builtin/add.c
index 89dce56..a7ed2ad 100644
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
@@ -153,33 +121,6 @@ static char *prune_directory(struct dir_struct *dir, const char **pathspec, int
 	return seen;
 }
 
-static void treat_gitlinks(const char **pathspec)
-{
-	int i;
-
-	if (!pathspec || !*pathspec)
-		return;
-
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
-}
-
 static void refresh(int verbose, const char **pathspec)
 {
 	char *seen;
@@ -197,23 +138,6 @@ static void refresh(int verbose, const char **pathspec)
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
@@ -248,7 +172,7 @@ int interactive_add(int argc, const char **argv, const char *prefix, int patch)
 	const char **pathspec = NULL;
 
 	if (argc) {
-		pathspec = validate_pathspec(argc, argv, prefix);
+		pathspec = validate_pathspec(prefix, argv);
 		if (!pathspec)
 			return -1;
 	}
@@ -414,7 +338,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
 		return 0;
 	}
-	pathspec = validate_pathspec(argc, argv, prefix);
+	pathspec = validate_pathspec(prefix, argv);
 
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
diff --git a/pathspec.c b/pathspec.c
new file mode 100644
index 0000000..51cb8ce
--- /dev/null
+++ b/pathspec.c
@@ -0,0 +1,87 @@
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
+void treat_gitlink(const char *path)
+{
+	int i, len = strlen(path);
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		if (S_ISGITLINK(ce->ce_mode)) {
+			int len2 = ce_namelen(ce);
+			if (len <= len2 || path[len2] != '/' ||
+			    memcmp(ce->name, path, len2))
+				continue;
+			if (len == len2 + 1)
+				/* strip trailing slash */
+				path = xstrndup(ce->name, len2);
+			else
+				die (_("Path '%s' is in submodule '%.*s'"),
+				     path, len2, ce->name);
+		}
+	}
+}
+
+void treat_gitlinks(const char **pathspec)
+{
+	if (!pathspec || !*pathspec)
+		return;
+
+	int i;
+	for (i = 0; pathspec[i]; i++)
+		treat_gitlink(pathspec[i]);
+}
diff --git a/pathspec.h b/pathspec.h
new file mode 100644
index 0000000..87e4296
--- /dev/null
+++ b/pathspec.h
@@ -0,0 +1,6 @@
+extern void validate_path(const char *prefix, const char *path);
+extern const char **validate_pathspec(const char *prefix, const char **files);
+extern char *find_used_pathspec(const char **pathspec);
+extern void fill_pathspec_matches(const char **pathspec, char *seen, int specs);
+extern void treat_gitlink(const char *path);
+extern void treat_gitlinks(const char **pathspec);
-- 
1.7.12.155.ge5750d5.dirty
