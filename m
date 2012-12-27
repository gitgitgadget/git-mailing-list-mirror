From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v3 06/19] dir.c: rename excluded() to is_excluded()
Date: Thu, 27 Dec 2012 02:32:25 +0000
Message-ID: <1356575558-2674-7-git-send-email-git@adamspiers.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 03:34:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To3IE-0006l1-Fz
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 03:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461Ab2L0Ccs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 21:32:48 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:53763 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab2L0Cco (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 21:32:44 -0500
Received: from localhost (host-2-103-56-128.as13285.net [2.103.56.128])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 3EEE32E5DB
	for <git@vger.kernel.org>; Thu, 27 Dec 2012 02:32:43 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.2.249.g31c7954
In-Reply-To: <1356575558-2674-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212182>

Continue adopting clearer names for exclude functions.  This is_*
naming pattern for functions returning booleans was discussed here:

http://thread.gmane.org/gmane.comp.version-control.git/204661/focus=204924

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 attr.c |  2 +-
 dir.c  | 10 +++++-----
 dir.h  |  4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/attr.c b/attr.c
index 2fc6353..5362563 100644
--- a/attr.c
+++ b/attr.c
@@ -284,7 +284,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
  * (reading the file from top to bottom), .gitattribute of the root
  * directory (again, reading the file from top to bottom) down to the
  * current directory, and then scan the list backwards to find the first match.
- * This is exactly the same as what excluded() does in dir.c to deal with
+ * This is exactly the same as what is_excluded() does in dir.c to deal with
  * .gitignore
  */
 
diff --git a/dir.c b/dir.c
index 0800491..8c99dc4 100644
--- a/dir.c
+++ b/dir.c
@@ -645,7 +645,7 @@ int is_excluded_from_list(const char *pathname,
 	return -1; /* undecided */
 }
 
-static int excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
+static int is_excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
 {
 	int pathlen = strlen(pathname);
 	int st;
@@ -695,7 +695,7 @@ int is_path_excluded(struct path_exclude_check *check,
 	/*
 	 * we allow the caller to pass namelen as an optimization; it
 	 * must match the length of the name, as we eventually call
-	 * excluded() on the whole name string.
+	 * is_excluded() on the whole name string.
 	 */
 	if (namelen < 0)
 		namelen = strlen(name);
@@ -712,7 +712,7 @@ int is_path_excluded(struct path_exclude_check *check,
 
 		if (ch == '/') {
 			int dt = DT_DIR;
-			if (excluded(check->dir, path->buf, &dt))
+			if (is_excluded(check->dir, path->buf, &dt))
 				return 1;
 		}
 		strbuf_addch(path, ch);
@@ -721,7 +721,7 @@ int is_path_excluded(struct path_exclude_check *check,
 	/* An entry in the index; cannot be a directory with subentries */
 	strbuf_setlen(path, 0);
 
-	return excluded(check->dir, name, dtype);
+	return is_excluded(check->dir, name, dtype);
 }
 
 static struct dir_entry *dir_entry_new(const char *pathname, int len)
@@ -1021,7 +1021,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  const struct path_simplify *simplify,
 					  int dtype, struct dirent *de)
 {
-	int exclude = excluded(dir, path->buf, &dtype);
+	int exclude = is_excluded(dir, path->buf, &dtype);
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
 	    && exclude_matches_pathspec(path->buf, path->len, simplify))
 		dir_add_ignored(dir, path->buf, path->len);
diff --git a/dir.h b/dir.h
index 554f87a..d68a997 100644
--- a/dir.h
+++ b/dir.h
@@ -113,8 +113,8 @@ extern int match_pathname(const char *, int,
 			  const char *, int, int, int);
 
 /*
- * The excluded() API is meant for callers that check each level of leading
- * directory hierarchies with excluded() to avoid recursing into excluded
+ * The is_excluded() API is meant for callers that check each level of leading
+ * directory hierarchies with is_excluded() to avoid recursing into excluded
  * directories.  Callers that do not do so should use this API instead.
  */
 struct path_exclude_check {
-- 
1.7.11.2.249.g31c7954
