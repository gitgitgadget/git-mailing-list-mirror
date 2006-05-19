From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 1/2] Move pathspec matching from builtin-add.c into dir.c
Date: Fri, 19 May 2006 16:07:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605191607010.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat May 20 01:08:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhE4e-0008Ar-B4
	for gcvg-git@gmane.org; Sat, 20 May 2006 01:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWESXH5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 19:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWESXH5
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 19:07:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5843 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751420AbWESXH5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 May 2006 19:07:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4JN7qtH026616
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 19 May 2006 16:07:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4JN7pRs008965;
	Fri, 19 May 2006 16:07:52 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20364>


I'll use it for builtin-rm.c too.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

diff --git a/builtin-add.c b/builtin-add.c
index 2afb82d..02fe38b 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -13,86 +13,6 @@ #include "cache-tree.h"
 static const char builtin_add_usage[] =
 "git-add [-n] [-v] <filepattern>...";
 
-static int common_prefix(const char **pathspec)
-{
-	const char *path, *slash, *next;
-	int prefix;
-
-	if (!pathspec)
-		return 0;
-
-	path = *pathspec;
-	slash = strrchr(path, '/');
-	if (!slash)
-		return 0;
-
-	prefix = slash - path + 1;
-	while ((next = *++pathspec) != NULL) {
-		int len = strlen(next);
-		if (len >= prefix && !memcmp(path, next, len))
-			continue;
-		for (;;) {
-			if (!len)
-				return 0;
-			if (next[--len] != '/')
-				continue;
-			if (memcmp(path, next, len+1))
-				continue;
-			prefix = len + 1;
-			break;
-		}
-	}
-	return prefix;
-}
-
-static int match_one(const char *match, const char *name, int namelen)
-{
-	int matchlen;
-
-	/* If the match was just the prefix, we matched */
-	matchlen = strlen(match);
-	if (!matchlen)
-		return 1;
-
-	/*
-	 * If we don't match the matchstring exactly,
-	 * we need to match by fnmatch
-	 */
-	if (strncmp(match, name, matchlen))
-		return !fnmatch(match, name, 0);
-
-	/*
-	 * If we did match the string exactly, we still
-	 * need to make sure that it happened on a path
-	 * component boundary (ie either the last character
-	 * of the match was '/', or the next character of
-	 * the name was '/' or the terminating NUL.
-	 */
-	return	match[matchlen-1] == '/' ||
-		name[matchlen] == '/' ||
-		!name[matchlen];
-}
-
-static int match(const char **pathspec, const char *name, int namelen, int prefix, char *seen)
-{
-	int retval;
-	const char *match;
-
-	name += prefix;
-	namelen -= prefix;
-
-	for (retval = 0; (match = *pathspec++) != NULL; seen++) {
-		if (retval & *seen)
-			continue;
-		match += prefix;
-		if (match_one(match, name, namelen)) {
-			retval = 1;
-			*seen = 1;
-		}
-	}
-	return retval;
-}
-
 static void prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
 {
 	char *seen;
@@ -108,7 +28,7 @@ static void prune_directory(struct dir_s
 	i = dir->nr;
 	while (--i >= 0) {
 		struct dir_entry *entry = *src++;
-		if (!match(pathspec, entry->name, entry->len, prefix, seen)) {
+		if (!match_pathspec(pathspec, entry->name, entry->len, prefix, seen)) {
 			free(entry);
 			continue;
 		}
diff --git a/dir.c b/dir.c
index d40b62e..d778ecd 100644
--- a/dir.c
+++ b/dir.c
@@ -11,6 +11,86 @@ #include <fnmatch.h>
 #include "cache.h"
 #include "dir.h"
 
+int common_prefix(const char **pathspec)
+{
+	const char *path, *slash, *next;
+	int prefix;
+
+	if (!pathspec)
+		return 0;
+
+	path = *pathspec;
+	slash = strrchr(path, '/');
+	if (!slash)
+		return 0;
+
+	prefix = slash - path + 1;
+	while ((next = *++pathspec) != NULL) {
+		int len = strlen(next);
+		if (len >= prefix && !memcmp(path, next, len))
+			continue;
+		for (;;) {
+			if (!len)
+				return 0;
+			if (next[--len] != '/')
+				continue;
+			if (memcmp(path, next, len+1))
+				continue;
+			prefix = len + 1;
+			break;
+		}
+	}
+	return prefix;
+}
+
+static int match_one(const char *match, const char *name, int namelen)
+{
+	int matchlen;
+
+	/* If the match was just the prefix, we matched */
+	matchlen = strlen(match);
+	if (!matchlen)
+		return 1;
+
+	/*
+	 * If we don't match the matchstring exactly,
+	 * we need to match by fnmatch
+	 */
+	if (strncmp(match, name, matchlen))
+		return !fnmatch(match, name, 0);
+
+	/*
+	 * If we did match the string exactly, we still
+	 * need to make sure that it happened on a path
+	 * component boundary (ie either the last character
+	 * of the match was '/', or the next character of
+	 * the name was '/' or the terminating NUL.
+	 */
+	return	match[matchlen-1] == '/' ||
+		name[matchlen] == '/' ||
+		!name[matchlen];
+}
+
+int match_pathspec(const char **pathspec, const char *name, int namelen, int prefix, char *seen)
+{
+	int retval;
+	const char *match;
+
+	name += prefix;
+	namelen -= prefix;
+
+	for (retval = 0; (match = *pathspec++) != NULL; seen++) {
+		if (retval & *seen)
+			continue;
+		match += prefix;
+		if (match_one(match, name, namelen)) {
+			retval = 1;
+			*seen = 1;
+		}
+	}
+	return retval;
+}
+
 void add_exclude(const char *string, const char *base,
 		 int baselen, struct exclude_list *which)
 {
diff --git a/dir.h b/dir.h
index 4f65f57..56a1b7f 100644
--- a/dir.h
+++ b/dir.h
@@ -39,6 +39,9 @@ struct dir_struct {
 	struct exclude_list exclude_list[3];
 };
 
+extern int common_prefix(const char **pathspec);
+extern int match_pathspec(const char **pathspec, const char *name, int namelen, int prefix, char *seen);
+
 extern int read_directory(struct dir_struct *, const char *path, const char *base, int baselen);
 extern int excluded(struct dir_struct *, const char *);
 extern void add_excludes_from_file(struct dir_struct *, const char *fname);
