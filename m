From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v4 06/11] add.c: move pathspec matchers into new pathspec.c for reuse
Date: Sun,  6 Jan 2013 16:58:08 +0000
Message-ID: <1357491493-11619-7-git-send-email-git@adamspiers.org>
References: <20130106161758.GC2396@pacific.linksys.moosehall>
 <1357491493-11619-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 17:59:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrtYv-0008A9-00
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 17:59:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112Ab3AFQ6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 11:58:44 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45596 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756083Ab3AFQ6T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 11:58:19 -0500
Received: from localhost (f.4.d.7.f.d.e.f.f.f.3.7.3.0.a.1.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:1a03:73ff:fedf:7d4f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id E568A2E5D3
	for <git@vger.kernel.org>; Sun,  6 Jan 2013 16:58:18 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.7.33.gb8feba5
In-Reply-To: <1357491493-11619-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212821>

Extract the following functions from builtin/add.c to pathspec.c, in
preparation for reuse by a new git check-ignore command:

  - fill_pathspec_matches()
  - find_used_pathspec()

The functions being extracted are not changed in any way, except
removal of the 'static' qualifier.

Also add comments documenting these newly public functions,
including clarifications that they operate on the index.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
The v3 version of this patch extracted 5 functions from add.c to
pathspec.c, two of which did not need to be extracted.  Here we
use more fine-grained commits for extraction, and also wrap pathspec.h
in a PATHSPEC_H gate to avoid duplication.

 Makefile      |  2 ++
 builtin/add.c | 34 +---------------------------------
 pathspec.c    | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pathspec.h    |  7 +++++++
 4 files changed, 67 insertions(+), 33 deletions(-)
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
index 1f62ba3..e51ba44 100644
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
diff --git a/pathspec.c b/pathspec.c
new file mode 100644
index 0000000..1472af8
--- /dev/null
+++ b/pathspec.c
@@ -0,0 +1,57 @@
+#include "cache.h"
+#include "dir.h"
+#include "pathspec.h"
+
+/*
+ * Finds which of the given pathspecs match items in the index.
+ *
+ * For each pathspec, sets the corresponding entry in the seen[] array
+ * (which should be specs items long, i.e. the same size as pathspec)
+ * to the nature of the "closest" (i.e. most specific) match found for
+ * that pathspec in the index, if it was a closer type of match than
+ * the existing entry.  As an optimization, matching is skipped
+ * altogether if seen[] already only contains non-zero entries.
+ *
+ * If seen[] has not already been written to, it may make sense
+ * to use find_used_pathspec() instead.
+ */
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
+/*
+ * Finds which of the given pathspecs match items in the index.
+ *
+ * This is a one-shot wrapper around fill_pathspec_matches() which
+ * allocates, populates, and returns a seen[] array indicating the
+ * nature of the "closest" (i.e. most specific) matches which each of
+ * the given pathspecs achieves against all items in the index.
+ */
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
diff --git a/pathspec.h b/pathspec.h
new file mode 100644
index 0000000..1cb1909
--- /dev/null
+++ b/pathspec.h
@@ -0,0 +1,7 @@
+#ifndef PATHSPEC_H
+#define PATHSPEC_H
+
+extern char *find_used_pathspec(const char **pathspec);
+extern void fill_pathspec_matches(const char **pathspec, char *seen, int specs);
+
+#endif /* PATHSPEC_H */
-- 
1.7.11.7.33.gb8feba5
