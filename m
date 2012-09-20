From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v2 06/14] Rename excluded() to is_excluded()
Date: Thu, 20 Sep 2012 20:46:15 +0100
Message-ID: <1348170383-15751-7-git-send-email-git@adamspiers.org>
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
	id 1TEmiI-0000f4-8u
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 21:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097Ab2ITTql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 15:46:41 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:46179 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab2ITTqa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 15:46:30 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id ADBD52E5E1;
	Thu, 20 Sep 2012 20:46:29 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
In-Reply-To: <1348170383-15751-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206077>

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
index 887a9ae..fd33ff9 100644
--- a/attr.c
+++ b/attr.c
@@ -270,7 +270,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
  * (reading the file from top to bottom), .gitattribute of the root
  * directory (again, reading the file from top to bottom) down to the
  * current directory, and then scan the list backwards to find the first match.
- * This is exactly the same as what excluded() does in dir.c to deal with
+ * This is exactly the same as what is_excluded() does in dir.c to deal with
  * .gitignore
  */
 
diff --git a/dir.c b/dir.c
index 8f262f6..b381b1b 100644
--- a/dir.c
+++ b/dir.c
@@ -587,7 +587,7 @@ int is_excluded_from_list(const char *pathname,
 	return -1; /* undecided */
 }
 
-static int excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
+static int is_excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
 {
 	int pathlen = strlen(pathname);
 	int st;
@@ -637,7 +637,7 @@ int is_path_excluded(struct path_exclude_check *check,
 	/*
 	 * we allow the caller to pass namelen as an optimization; it
 	 * must match the length of the name, as we eventually call
-	 * excluded() on the whole name string.
+	 * is_excluded() on the whole name string.
 	 */
 	if (namelen < 0)
 		namelen = strlen(name);
@@ -654,7 +654,7 @@ int is_path_excluded(struct path_exclude_check *check,
 
 		if (ch == '/') {
 			int dt = DT_DIR;
-			if (excluded(check->dir, path->buf, &dt))
+			if (is_excluded(check->dir, path->buf, &dt))
 				return 1;
 		}
 		strbuf_addch(path, ch);
@@ -663,7 +663,7 @@ int is_path_excluded(struct path_exclude_check *check,
 	/* An entry in the index; cannot be a directory with subentries */
 	strbuf_setlen(path, 0);
 
-	return excluded(check->dir, name, dtype);
+	return is_excluded(check->dir, name, dtype);
 }
 
 static struct dir_entry *dir_entry_new(const char *pathname, int len)
@@ -963,7 +963,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  const struct path_simplify *simplify,
 					  int dtype, struct dirent *de)
 {
-	int exclude = excluded(dir, path->buf, &dtype);
+	int exclude = is_excluded(dir, path->buf, &dtype);
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
 	    && exclude_matches_pathspec(path->buf, path->len, simplify))
 		dir_add_ignored(dir, path->buf, path->len);
diff --git a/dir.h b/dir.h
index 6904a35..009c9df 100644
--- a/dir.h
+++ b/dir.h
@@ -103,8 +103,8 @@ extern int is_excluded_from_list(const char *pathname, int pathlen, const char *
 struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len);
 
 /*
- * The excluded() API is meant for callers that check each level of leading
- * directory hierarchies with excluded() to avoid recursing into excluded
+ * The is_excluded() API is meant for callers that check each level of leading
+ * directory hierarchies with is_excluded() to avoid recursing into excluded
  * directories.  Callers that do not do so should use this API instead.
  */
 struct path_exclude_check {
-- 
1.7.12.147.g6d168f4
