From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v2 09/14] Refactor is_path_excluded()
Date: Thu, 20 Sep 2012 20:46:18 +0100
Message-ID: <1348170383-15751-10-git-send-email-git@adamspiers.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 21:47:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEmiY-0000ut-Hh
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 21:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755071Ab2ITTqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 15:46:39 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:46193 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754836Ab2ITTqd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 15:46:33 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 45BB52E5E9;
	Thu, 20 Sep 2012 20:46:32 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
In-Reply-To: <1348170383-15751-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206083>

In a similar way to the previous commit, this extracts a new helper
function last_exclude_matching_path() which return the last
exclude_list element which matched, or NULL if no match was found.
is_path_excluded() becomes a wrapper around this, and just returns 0
or 1 depending on whether any matching exclude_list element was found.

This allows callers to find out _why_ a given path was excluded,
rather than just whether it was or not, paving the way for a new git
sub-command which allows users to test their exclude lists from the
command line.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 dir.c | 47 ++++++++++++++++++++++++++++++++++++++---------
 dir.h |  3 +++
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/dir.c b/dir.c
index 3e2161e..904a7f3 100644
--- a/dir.c
+++ b/dir.c
@@ -651,6 +651,7 @@ void path_exclude_check_init(struct path_exclude_check *check,
 			     struct dir_struct *dir)
 {
 	check->dir = dir;
+	check->exclude = NULL;
 	strbuf_init(&check->path, 256);
 }
 
@@ -660,18 +661,21 @@ void path_exclude_check_clear(struct path_exclude_check *check)
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
-int is_path_excluded(struct path_exclude_check *check,
-		     const char *name, int namelen, int *dtype)
+struct exclude *last_exclude_matching_path(struct path_exclude_check *check,
+					   const char *name, int namelen,
+					   int *dtype)
 {
 	int i;
 	struct strbuf *path = &check->path;
+	struct exclude *exclude;
 
 	/*
 	 * we allow the caller to pass namelen as an optimization; it
@@ -681,11 +685,17 @@ int is_path_excluded(struct path_exclude_check *check,
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
 	    (!name[path->len] || name[path->len] == '/'))
-		return 1;
+		return check->exclude;
 
 	strbuf_setlen(path, 0);
 	for (i = 0; name[i]; i++) {
@@ -693,8 +703,12 @@ int is_path_excluded(struct path_exclude_check *check,
 
 		if (ch == '/') {
 			int dt = DT_DIR;
-			if (is_excluded(check->dir, path->buf, &dt))
-				return 1;
+			exclude = last_exclude_matching(check->dir,
+							path->buf, &dt);
+			if (exclude) {
+				check->exclude = exclude;
+				return exclude;
+			}
 		}
 		strbuf_addch(path, ch);
 	}
@@ -702,7 +716,22 @@ int is_path_excluded(struct path_exclude_check *check,
 	/* An entry in the index; cannot be a directory with subentries */
 	strbuf_setlen(path, 0);
 
-	return is_excluded(check->dir, name, dtype);
+	return last_exclude_matching(check->dir, name, dtype);
+}
+
+/*
+ * Is this name excluded?  This is for a caller like show_files() that
+ * do not honor directory hierarchy and iterate through paths that are
+ * possibly in an ignored directory.
+ */
+int is_path_excluded(struct path_exclude_check *check,
+		  const char *name, int namelen, int *dtype)
+{
+	struct exclude *exclude =
+		last_exclude_matching_path(check, name, namelen, dtype);
+	if (exclude)
+		return exclude->to_exclude;
+	return 0;
 }
 
 static struct dir_entry *dir_entry_new(const char *pathname, int len)
diff --git a/dir.h b/dir.h
index 009c9df..19beddb 100644
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
+extern struct exclude *last_exclude_matching_path(struct path_exclude_check *, const char *,
+						  int namelen, int *dtype);
 extern int is_path_excluded(struct path_exclude_check *, const char *, int namelen, int *dtype);
 
 
-- 
1.7.12.147.g6d168f4
