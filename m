From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/3] consolidate pathspec_prefix and common_prefix
Date: Sun,  4 Sep 2011 12:42:00 +0200
Message-ID: <1315132921-26949-3-git-send-email-drizzd@aon.at>
References: <7vbow7ebzw.fsf@alter.siamese.dyndns.org>
 <1315132921-26949-1-git-send-email-drizzd@aon.at>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 04 12:44:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0ABy-0004qP-LH
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 12:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153Ab1IDKon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 06:44:43 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:36886 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754129Ab1IDKok (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 06:44:40 -0400
Received: from localhost (p5B22E851.dip.t-dialin.net [91.34.232.81])
	by bsmtp.bon.at (Postfix) with ESMTP id 006E2A7EB2;
	Sun,  4 Sep 2011 12:44:37 +0200 (CEST)
X-Mailer: git-send-email 1.7.6.1
In-Reply-To: <1315132921-26949-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180677>

The implementation from pathspec_prefix (slightly modified)
replaces the current common_prefix, because it also respects glob
characters.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

I wonder if PATH_MAX is needed and respected everywhere. Do we have
any previous experience with very long paths?

Clemens

 dir.c   |   52 ++++++++++++++++++++++++++--------------------------
 dir.h   |    1 +
 setup.c |   29 ++---------------------------
 3 files changed, 29 insertions(+), 53 deletions(-)

diff --git a/dir.c b/dir.c
index 08281d2..7099fb3 100644
--- a/dir.c
+++ b/dir.c
@@ -34,37 +34,37 @@ int fnmatch_icase(const char *pattern, const char *string, int flags)
 	return fnmatch(pattern, string, flags | (ignore_case ? FNM_CASEFOLD : 0));
 }
 
-static int common_prefix(const char **pathspec)
+unsigned long common_prefix_len(const char **pathspec)
 {
-	const char *path, *slash, *next;
-	int prefix;
+	const char *n, *first;
+	unsigned long max;
 
 	if (!pathspec)
 		return 0;
 
-	path = *pathspec;
-	slash = strrchr(path, '/');
-	if (!slash)
-		return 0;
-
-	/*
-	 * The first 'prefix' characters of 'path' are common leading
-	 * path components among the pathspecs we have seen so far,
-	 * including the trailing slash.
-	 */
-	prefix = slash - path + 1;
-	while ((next = *++pathspec) != NULL) {
-		int len, last_matching_slash = -1;
-		for (len = 0; len < prefix && next[len] == path[len]; len++)
-			if (next[len] == '/')
-				last_matching_slash = len;
-		if (len == prefix)
-			continue;
-		if (last_matching_slash < 0)
-			return 0;
-		prefix = last_matching_slash + 1;
+	first = *pathspec;
+	max = PATH_MAX;
+	while ((n = *pathspec++)) {
+		int i, len = 0;
+		for (i = 0; i < max; i++) {
+			char c = n[i];
+			if (!c || c != first[i] || is_glob_special(c))
+				break;
+			if (c == '/')
+				len = i+1;
+		}
+		if (len < max) {
+			max = len;
+			if (!max)
+				break;
+		}
 	}
-	return prefix;
+
+	/* Nothing in the first PATH_MAX characters? */
+	if (max > 0 && first[max-1] != '/')
+		max = 0;
+
+	return max;
 }
 
 int fill_directory(struct dir_struct *dir, const char **pathspec)
@@ -76,7 +76,7 @@ int fill_directory(struct dir_struct *dir, const char **pathspec)
 	 * Calculate common prefix for the pathspec, and
 	 * use that to optimize the directory walk
 	 */
-	len = common_prefix(pathspec);
+	len = common_prefix_len(pathspec);
 	path = "";
 
 	if (len)
diff --git a/dir.h b/dir.h
index 433b5b4..0e55b71 100644
--- a/dir.h
+++ b/dir.h
@@ -64,6 +64,7 @@ struct dir_struct {
 #define MATCHED_RECURSIVELY 1
 #define MATCHED_FNMATCH 2
 #define MATCHED_EXACTLY 3
+extern unsigned long common_prefix_len(const char **pathspec);
 extern int match_pathspec(const char **pathspec, const char *name, int namelen, int prefix, char *seen);
 extern int match_pathspec_depth(const struct pathspec *pathspec,
 				const char *name, int namelen,
diff --git a/setup.c b/setup.c
index 0906790..0c60dbd 100644
--- a/setup.c
+++ b/setup.c
@@ -238,34 +238,9 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
 
 char *pathspec_prefix(const char **pathspec)
 {
-	const char **p, *n, *prev;
-	unsigned long max;
+	unsigned long len = common_prefix_len(pathspec);
 
-	if (!pathspec)
-		return NULL;
-
-	prev = NULL;
-	max = PATH_MAX;
-	for (p = pathspec; (n = *p) != NULL; p++) {
-		int i, len = 0;
-		for (i = 0; i < max; i++) {
-			char c = n[i];
-			if (prev && prev[i] != c)
-				break;
-			if (!c || c == '*' || c == '?')
-				break;
-			if (c == '/')
-				len = i+1;
-		}
-		prev = n;
-		if (len < max) {
-			max = len;
-			if (!max)
-				break;
-		}
-	}
-
-	return max ? xmemdupz(prev, max) : NULL;
+	return len ? xmemdupz(prefix, len) : NULL;
 }
 
 /*
-- 
1.7.6.1
