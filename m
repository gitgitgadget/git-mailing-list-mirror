From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v3 17/19] pathspec.c: extract new validate_path() for reuse
Date: Thu, 27 Dec 2012 02:32:36 +0000
Message-ID: <1356575558-2674-18-git-send-email-git@adamspiers.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 03:33:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To3Hm-0006Tl-D0
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 03:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512Ab2L0Cc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 21:32:57 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:53770 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491Ab2L0Ccy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 21:32:54 -0500
Received: from localhost (host-2-103-56-128.as13285.net [2.103.56.128])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 7D1E855637
	for <git@vger.kernel.org>; Thu, 27 Dec 2012 02:32:53 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.2.249.g31c7954
In-Reply-To: <1356575558-2674-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212177>

This will be reused by a new git check-ignore command.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 pathspec.c | 20 ++++++++++++++------
 pathspec.h |  1 +
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 8aea0d2..6724121 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -77,9 +77,20 @@ void treat_gitlinks(const char **pathspec)
 }
 
 /*
+ * Dies if the given path refers to a file inside a symlinked
+ * directory.
+ */
+void validate_path(const char *path, const char *prefix)
+{
+	if (has_symlink_leading_path(path, strlen(path))) {
+		int len = prefix ? strlen(prefix) : 0;
+		die(_("'%s' is beyond a symbolic link"), path + len);
+	}
+}
+
+/*
  * Normalizes argv relative to prefix, via get_pathspec(), and then
- * dies if any path in the normalized list refers to a file inside a
- * symlinked directory.
+ * runs validate_path() on each path in the normalized list.
  */
 const char **validate_pathspec(const char **argv, const char *prefix)
 {
@@ -88,10 +99,7 @@ const char **validate_pathspec(const char **argv, const char *prefix)
 	if (pathspec) {
 		const char **p;
 		for (p = pathspec; *p; p++) {
-			if (has_symlink_leading_path(*p, strlen(*p))) {
-				int len = prefix ? strlen(prefix) : 0;
-				die(_("'%s' is beyond a symbolic link"), *p + len);
-			}
+			validate_path(*p, prefix);
 		}
 	}
 
diff --git a/pathspec.h b/pathspec.h
index 8bb670b..c251441 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -2,4 +2,5 @@ extern char *find_used_pathspec(const char **pathspec);
 extern void fill_pathspec_matches(const char **pathspec, char *seen, int specs);
 extern const char *treat_gitlink(const char *path);
 extern void treat_gitlinks(const char **pathspec);
+extern void validate_path(const char *path, const char *prefix);
 extern const char **validate_pathspec(const char **argv, const char *prefix);
-- 
1.7.11.2.249.g31c7954
