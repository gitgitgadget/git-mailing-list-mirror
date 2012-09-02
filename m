From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH 5/9] Refactor excluded and path_excluded
Date: Sun,  2 Sep 2012 01:12:07 +0100
Message-ID: <1346544731-938-6-git-send-email-git@adamspiers.org>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 02:20:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7xvB-0001VH-RB
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 02:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908Ab2IBATx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 20:19:53 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:55525 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754546Ab2IBATA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 20:19:00 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 0A5812E5E9;
	Sun,  2 Sep 2012 01:12:18 +0100 (BST)
X-Mailer: git-send-email 1.7.12.155.ge5750d5.dirty
In-Reply-To: <1346544731-938-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204656>

In a similar way to the previous commit, this extracts new helper
functions excluded_1() and path_excluded_1() which return the last
exclude_list element which matched, or NULL if no match was found.
excluded() and path_excluded() become wrappers around these, and just
return 0 or 1 depending on whether any matching exclude_list element
was found.

This allows callers to find out _why_ a given path was excluded,
rather than just whether it was or not, paving the way for a new git
sub-command which allows users to test their exclude lists from the
command line.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 dir.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 dir.h |  3 +++
 2 files changed, 67 insertions(+), 17 deletions(-)

diff --git a/dir.c b/dir.c
index 3a532d5..3d438c3 100644
--- a/dir.c
+++ b/dir.c
@@ -603,23 +603,42 @@ int excluded_from_list(const char *pathname,
 	return -1; /* undecided */
 }
 
-static int excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
+/*
+ * Loads the exclude lists for the directory containing pathname, then
+ * scans all exclude lists to determine whether pathname is excluded.
+ * Returns the exclude_list element which matched, or NULL for
+ * undecided.
+ */
+static struct exclude *excluded_1(struct dir_struct *dir, const char *pathname, int *dtype_p)
 {
 	int pathlen = strlen(pathname);
 	int st;
+	struct exclude *exclude;
 	const char *basename = strrchr(pathname, '/');
 	basename = (basename) ? basename+1 : pathname;
 
 	prep_exclude(dir, pathname, basename-pathname);
 	for (st = EXC_CMDL; st <= EXC_FILE; st++) {
-		switch (excluded_from_list(pathname, pathlen, basename,
-					   dtype_p, &dir->exclude_list[st])) {
-		case 0:
-			return 0;
-		case 1:
-			return 1;
+		exclude = excluded_from_list_1(pathname, pathlen, basename,
+					       dtype_p, &dir->exclude_list[st]);
+		if (exclude) {
+			return exclude;
 		}
 	}
+	return NULL;
+}
+
+/*
+ * Loads the exclude lists for the directory containing pathname, then
+ * scans all exclude lists to determine whether pathname is excluded.
+ * Returns 1 if true, otherwise 0.
+ */
+static int excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
+{
+	struct exclude *exclude = excluded_1(dir, pathname, dtype_p);
+	if (exclude) {
+		return exclude->to_exclude;
+	}
 	return 0;
 }
 
@@ -627,6 +646,7 @@ void path_exclude_check_init(struct path_exclude_check *check,
 			     struct dir_struct *dir)
 {
 	check->dir = dir;
+	check->exclude = NULL;
 	strbuf_init(&check->path, 256);
 }
 
@@ -636,18 +656,20 @@ void path_exclude_check_clear(struct path_exclude_check *check)
 }
 
 /*
- * Is this name excluded?  This is for a caller like show_files() that
- * do not honor directory hierarchy and iterate through paths that are
- * possibly in an ignored directory.
+ * For each subdirectory in name, starting with the top-most, checks
+ * to see if that subdirectory is excluded, and if so, returns the
+ * corresponding exclude structure.  Otherwise, checks whether name
+ * itself (which is presumably a file) is excluded.
  *
  * A path to a directory known to be excluded is left in check->path to
  * optimize for repeated checks for files in the same excluded directory.
  */
-int path_excluded(struct path_exclude_check *check,
-		  const char *name, int namelen, int *dtype)
+struct exclude *path_excluded_1(struct path_exclude_check *check,
+				const char *name, int namelen, int *dtype)
 {
 	int i;
 	struct strbuf *path = &check->path;
+	struct exclude *exclude;
 
 	/*
 	 * we allow the caller to pass namelen as an optimization; it
@@ -657,11 +679,18 @@ int path_excluded(struct path_exclude_check *check,
 	if (namelen < 0)
 		namelen = strlen(name);
 
+	/*
+	 * If path is non-empty, and name is equal to path or a
+	 * subdirectory of path, name should be excluded, because
+	 * it's inside a directory which is already known to be
+	 * excluded and was previously left in check->path.
+	 */
 	if (path->len &&
 	    path->len <= namelen &&
 	    !memcmp(name, path->buf, path->len) &&
-	    (!name[path->len] || name[path->len] == '/'))
-		return 1;
+	    (!name[path->len] || name[path->len] == '/')) {
+		return check->exclude;
+	}
 
 	strbuf_setlen(path, 0);
 	for (i = 0; name[i]; i++) {
@@ -669,8 +698,11 @@ int path_excluded(struct path_exclude_check *check,
 
 		if (ch == '/') {
 			int dt = DT_DIR;
-			if (excluded(check->dir, path->buf, &dt))
-				return 1;
+			exclude = excluded_1(check->dir, path->buf, &dt);
+			if (exclude) {
+				check->exclude = exclude;
+				return exclude;
+			}
 		}
 		strbuf_addch(path, ch);
 	}
@@ -678,7 +710,22 @@ int path_excluded(struct path_exclude_check *check,
 	/* An entry in the index; cannot be a directory with subentries */
 	strbuf_setlen(path, 0);
 
-	return excluded(check->dir, name, dtype);
+	return excluded_1(check->dir, name, dtype);
+}
+
+/*
+ * Is this name excluded?  This is for a caller like show_files() that
+ * do not honor directory hierarchy and iterate through paths that are
+ * possibly in an ignored directory.
+ */
+int path_excluded(struct path_exclude_check *check,
+		  const char *name, int namelen, int *dtype)
+{
+	struct exclude *exclude = path_excluded_1(check, name, namelen, dtype);
+	if (exclude) {
+		return exclude->to_exclude;
+	}
+	return 0;
 }
 
 static struct dir_entry *dir_entry_new(const char *pathname, int len)
diff --git a/dir.h b/dir.h
index 549a187..1b4f9dc 100644
--- a/dir.h
+++ b/dir.h
@@ -109,10 +109,13 @@ struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname,
  */
 struct path_exclude_check {
 	struct dir_struct *dir;
+	struct exclude *exclude;
 	struct strbuf path;
 };
 extern void path_exclude_check_init(struct path_exclude_check *, struct dir_struct *);
 extern void path_exclude_check_clear(struct path_exclude_check *);
+extern struct exclude *path_excluded_1(struct path_exclude_check *, const char *,
+				       int namelen, int *dtype);
 extern int path_excluded(struct path_exclude_check *, const char *, int namelen, int *dtype);
 
 
-- 
1.7.12.155.ge5750d5.dirty
