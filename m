From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/3] remove prefix argument from pathspec_prefix
Date: Sun,  4 Sep 2011 12:41:59 +0200
Message-ID: <1315132921-26949-2-git-send-email-drizzd@aon.at>
References: <7vbow7ebzw.fsf@alter.siamese.dyndns.org>
 <1315132921-26949-1-git-send-email-drizzd@aon.at>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 04 12:44:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0ABx-0004qP-9L
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 12:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147Ab1IDKok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 06:44:40 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:36882 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754077Ab1IDKoi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 06:44:38 -0400
Received: from localhost (p5B22E851.dip.t-dialin.net [91.34.232.81])
	by bsmtp.bon.at (Postfix) with ESMTP id 45B0B13004B;
	Sun,  4 Sep 2011 12:44:36 +0200 (CEST)
X-Mailer: git-send-email 1.7.6.1
In-Reply-To: <1315132921-26949-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180675>

Passing a prefix to a function that is supposed to find the prefix
is strange. And it's really only used if the pathspec is NULL. Make
the callers handle this case instead.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 builtin/commit.c   |    5 +++--
 builtin/ls-files.c |    2 +-
 cache.h            |    2 +-
 setup.c            |    4 ++--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index cbc9613..64fe501 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -255,8 +255,9 @@ static int list_paths(struct string_list *list, const char *with_tree,
 	m = xcalloc(1, i);
 
 	if (with_tree) {
-		const char *max_prefix = pathspec_prefix(prefix, pattern);
-		overlay_tree_on_cache(with_tree, max_prefix);
+		char *max_prefix = pathspec_prefix(pattern);
+		overlay_tree_on_cache(with_tree, max_prefix ? max_prefix : prefix);
+		free(max_prefix);
 	}
 
 	for (i = 0; i < active_nr; i++) {
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e8a800d..a54c2a2 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -545,7 +545,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		strip_trailing_slash_from_submodules();
 
 	/* Find common prefix for all pathspec's */
-	max_prefix = pathspec_prefix(prefix, pathspec);
+	max_prefix = pathspec_prefix(pathspec);
 	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
 
 	/* Treat unmatching pathspec elements as errors */
diff --git a/cache.h b/cache.h
index 607c2ea..0ccc84d 100644
--- a/cache.h
+++ b/cache.h
@@ -444,7 +444,7 @@ extern void set_git_work_tree(const char *tree);
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
 extern const char **get_pathspec(const char *prefix, const char **pathspec);
-extern const char *pathspec_prefix(const char *prefix, const char **pathspec);
+extern char *pathspec_prefix(const char **pathspec);
 extern void setup_work_tree(void);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
diff --git a/setup.c b/setup.c
index 27c1d47..0906790 100644
--- a/setup.c
+++ b/setup.c
@@ -236,13 +236,13 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
 	return pathspec;
 }
 
-const char *pathspec_prefix(const char *prefix, const char **pathspec)
+char *pathspec_prefix(const char **pathspec)
 {
 	const char **p, *n, *prev;
 	unsigned long max;
 
 	if (!pathspec)
-		return prefix ? xmemdupz(prefix, strlen(prefix)) : NULL;
+		return NULL;
 
 	prev = NULL;
 	max = PATH_MAX;
-- 
1.7.6.1
