From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v4 09/11] add.c: extract new die_if_path_beyond_symlink() for reuse
Date: Sun,  6 Jan 2013 16:58:11 +0000
Message-ID: <1357491493-11619-10-git-send-email-git@adamspiers.org>
References: <20130106161758.GC2396@pacific.linksys.moosehall>
 <1357491493-11619-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 17:59:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrtYt-0008A9-GD
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 17:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756056Ab3AFQ6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 11:58:34 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45597 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756099Ab3AFQ6V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 11:58:21 -0500
Received: from localhost (f.4.d.7.f.d.e.f.f.f.3.7.3.0.a.1.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:1a03:73ff:fedf:7d4f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 0CF392E65E
	for <git@vger.kernel.org>; Sun,  6 Jan 2013 16:58:20 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.7.33.gb8feba5
In-Reply-To: <1357491493-11619-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212823>

This will be reused by a new git check-ignore command.

Also document validate_pathspec().

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
Unlike v3, this series doesn't make validate_pathspec() public.

 builtin/add.c | 10 ++++++----
 pathspec.c    | 12 ++++++++++++
 pathspec.h    |  1 +
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index f95ded2..3716617 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -153,6 +153,11 @@ static void refresh(int verbose, const char **pathspec)
         free(seen);
 }
 
+/*
+ * Normalizes argv relative to prefix, via get_pathspec(), and then
+ * runs die_if_path_beyond_symlink() on each path in the normalized
+ * list.
+ */
 static const char **validate_pathspec(const char **argv, const char *prefix)
 {
 	const char **pathspec = get_pathspec(prefix, argv);
@@ -160,10 +165,7 @@ static const char **validate_pathspec(const char **argv, const char *prefix)
 	if (pathspec) {
 		const char **p;
 		for (p = pathspec; *p; p++) {
-			if (has_symlink_leading_path(*p, strlen(*p))) {
-				int len = prefix ? strlen(prefix) : 0;
-				die(_("'%s' is beyond a symbolic link"), *p + len);
-			}
+			die_if_path_beyond_symlink(*p, prefix);
 		}
 	}
 
diff --git a/pathspec.c b/pathspec.c
index 02d3344..284f397 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -87,3 +87,15 @@ const char *check_path_for_gitlink(const char *path)
 	}
 	return path;
 }
+
+/*
+ * Dies if the given path refers to a file inside a symlinked
+ * directory in the index.
+ */
+void die_if_path_beyond_symlink(const char *path, const char *prefix)
+{
+	if (has_symlink_leading_path(path, strlen(path))) {
+		int len = prefix ? strlen(prefix) : 0;
+		die(_("'%s' is beyond a symbolic link"), path + len);
+	}
+}
diff --git a/pathspec.h b/pathspec.h
index bf8eb96..db0184a 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -4,5 +4,6 @@
 extern char *find_pathspecs_matching_against_index(const char **pathspec);
 extern void add_pathspec_matches_against_index(const char **pathspec, char *seen, int specs);
 extern const char *check_path_for_gitlink(const char *path);
+extern void die_if_path_beyond_symlink(const char *path, const char *prefix);
 
 #endif /* PATHSPEC_H */
-- 
1.7.11.7.33.gb8feba5
