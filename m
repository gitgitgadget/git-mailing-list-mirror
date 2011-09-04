From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 3/3] rename pathspec_prefix -> common_prefix and move to dir.[ch]
Date: Sun,  4 Sep 2011 12:42:01 +0200
Message-ID: <1315132921-26949-4-git-send-email-drizzd@aon.at>
References: <7vbow7ebzw.fsf@alter.siamese.dyndns.org>
 <1315132921-26949-1-git-send-email-drizzd@aon.at>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 04 12:45:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0ACB-0004uo-Vf
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 12:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196Ab1IDKop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 06:44:45 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:36895 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754151Ab1IDKom (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 06:44:42 -0400
Received: from localhost (p5B22E851.dip.t-dialin.net [91.34.232.81])
	by bsmtp.bon.at (Postfix) with ESMTP id 243CB130047;
	Sun,  4 Sep 2011 12:44:40 +0200 (CEST)
X-Mailer: git-send-email 1.7.6.1
In-Reply-To: <1315132921-26949-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180678>


Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 builtin/commit.c   |    2 +-
 builtin/ls-files.c |    2 +-
 cache.h            |    1 -
 dir.c              |   11 +++++++++++
 dir.h              |    1 +
 setup.c            |    7 -------
 6 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 64fe501..b9ab5ef 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -255,7 +255,7 @@ static int list_paths(struct string_list *list, const char *with_tree,
 	m = xcalloc(1, i);
 
 	if (with_tree) {
-		char *max_prefix = pathspec_prefix(pattern);
+		char *max_prefix = common_prefix(pattern);
 		overlay_tree_on_cache(with_tree, max_prefix ? max_prefix : prefix);
 		free(max_prefix);
 	}
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a54c2a2..7cff175 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -545,7 +545,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		strip_trailing_slash_from_submodules();
 
 	/* Find common prefix for all pathspec's */
-	max_prefix = pathspec_prefix(pathspec);
+	max_prefix = common_prefix(pathspec);
 	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
 
 	/* Treat unmatching pathspec elements as errors */
diff --git a/cache.h b/cache.h
index 0ccc84d..586b987 100644
--- a/cache.h
+++ b/cache.h
@@ -444,7 +444,6 @@ extern void set_git_work_tree(const char *tree);
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
 extern const char **get_pathspec(const char *prefix, const char **pathspec);
-extern char *pathspec_prefix(const char **pathspec);
 extern void setup_work_tree(void);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
diff --git a/dir.c b/dir.c
index 7099fb3..f606da9 100644
--- a/dir.c
+++ b/dir.c
@@ -67,6 +67,17 @@ unsigned long common_prefix_len(const char **pathspec)
 	return max;
 }
 
+/*
+ * Returns a copy of the longest leading path common among all
+ * pathspecs.
+ */
+char *common_prefix(const char **pathspec)
+{
+	unsigned long len = common_prefix_len(pathspec);
+
+	return len ? xmemdupz(*pathspec, len) : NULL;
+}
+
 int fill_directory(struct dir_struct *dir, const char **pathspec)
 {
 	const char *path;
diff --git a/dir.h b/dir.h
index 0e55b71..9a33d23 100644
--- a/dir.h
+++ b/dir.h
@@ -65,6 +65,7 @@ struct dir_struct {
 #define MATCHED_FNMATCH 2
 #define MATCHED_EXACTLY 3
 extern unsigned long common_prefix_len(const char **pathspec);
+extern char *common_prefix(const char **pathspec);
 extern int match_pathspec(const char **pathspec, const char *name, int namelen, int prefix, char *seen);
 extern int match_pathspec_depth(const struct pathspec *pathspec,
 				const char *name, int namelen,
diff --git a/setup.c b/setup.c
index 0c60dbd..52bbb70 100644
--- a/setup.c
+++ b/setup.c
@@ -236,13 +236,6 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
 	return pathspec;
 }
 
-char *pathspec_prefix(const char **pathspec)
-{
-	unsigned long len = common_prefix_len(pathspec);
-
-	return len ? xmemdupz(prefix, len) : NULL;
-}
-
 /*
  * Test if it looks like we're at a git directory.
  * We want to see:
-- 
1.7.6.1
