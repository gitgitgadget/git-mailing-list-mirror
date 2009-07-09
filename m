From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/3] Simplify read_directory[_recursive]() arguments
Date: Wed, 8 Jul 2009 19:42:33 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain> <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 04:43:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOjbW-0005Sc-5s
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 04:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757169AbZGICnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 22:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756545AbZGICnP
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 22:43:15 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50197 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756398AbZGICnO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2009 22:43:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n692gYvY024529
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 8 Jul 2009 19:42:35 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n692gYqs008268;
	Wed, 8 Jul 2009 19:42:34 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122932>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Jul 2009 19:24:39 -0700
Subject: [PATCH 2/3] Simplify read_directory[_recursive]() arguments

Stop the insanity with separate 'path' and 'base' arguments that must
match.  We don't need that crazy interface any more, since we cleaned up
handling of 'path' in commit da4b3e8c28b1dc2b856d2555ac7bb47ab712598c.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

The diffstat says it only removes a single line, but it _simplifies_ a lot 
of them, and gets rid of the horrible confusion about what 'path' vs 
'base' means.

 dir.c          |   57 +++++++++++++++++++++++++++----------------------------
 dir.h          |    2 +-
 unpack-trees.c |    2 +-
 3 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/dir.c b/dir.c
index 0c8553b..b0671f5 100644
--- a/dir.c
+++ b/dir.c
@@ -14,8 +14,7 @@ struct path_simplify {
 	const char *path;
 };
 
-static int read_directory_recursive(struct dir_struct *dir,
-	const char *path, const char *base, int baselen,
+static int read_directory_recursive(struct dir_struct *dir, const char *path, int len,
 	int check_only, const struct path_simplify *simplify);
 static int get_dtype(struct dirent *de, const char *path);
 
@@ -54,23 +53,22 @@ static int common_prefix(const char **pathspec)
 
 int fill_directory(struct dir_struct *dir, const char **pathspec)
 {
-	const char *path, *base;
-	int baselen;
+	const char *path;
+	int len;
 
 	/*
 	 * Calculate common prefix for the pathspec, and
 	 * use that to optimize the directory walk
 	 */
-	baselen = common_prefix(pathspec);
+	len = common_prefix(pathspec);
 	path = "";
-	base = "";
 
-	if (baselen)
-		path = base = xmemdupz(*pathspec, baselen);
+	if (len)
+		path = xmemdupz(*pathspec, len);
 
 	/* Read the directory and prune it */
-	read_directory(dir, path, base, baselen, pathspec);
-	return baselen;
+	read_directory(dir, path, len, pathspec);
+	return len;
 }
 
 /*
@@ -526,7 +524,7 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
 	/* This is the "show_other_directories" case */
 	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
 		return show_directory;
-	if (!read_directory_recursive(dir, dirname, dirname, len, 1, simplify))
+	if (!read_directory_recursive(dir, dirname, len, 1, simplify))
 		return ignore_directory;
 	return show_directory;
 }
@@ -595,15 +593,15 @@ static int get_dtype(struct dirent *de, const char *path)
  * Also, we ignore the name ".git" (even if it is not a directory).
  * That likely will not change.
  */
-static int read_directory_recursive(struct dir_struct *dir, const char *path, const char *base, int baselen, int check_only, const struct path_simplify *simplify)
+static int read_directory_recursive(struct dir_struct *dir, const char *base, int baselen, int check_only, const struct path_simplify *simplify)
 {
-	DIR *fdir = opendir(*path ? path : ".");
+	DIR *fdir = opendir(*base ? base : ".");
 	int contents = 0;
 
 	if (fdir) {
 		struct dirent *de;
-		char fullname[PATH_MAX + 1];
-		memcpy(fullname, base, baselen);
+		char path[PATH_MAX + 1];
+		memcpy(path, base, baselen);
 
 		while ((de = readdir(fdir)) != NULL) {
 			int len, dtype;
@@ -614,17 +612,18 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 				continue;
 			len = strlen(de->d_name);
 			/* Ignore overly long pathnames! */
-			if (len + baselen + 8 > sizeof(fullname))
+			if (len + baselen + 8 > sizeof(path))
 				continue;
-			memcpy(fullname + baselen, de->d_name, len+1);
-			if (simplify_away(fullname, baselen + len, simplify))
+			memcpy(path + baselen, de->d_name, len+1);
+			len = baselen + len;
+			if (simplify_away(path, len, simplify))
 				continue;
 
 			dtype = DTYPE(de);
-			exclude = excluded(dir, fullname, &dtype);
+			exclude = excluded(dir, path, &dtype);
 			if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
-			    && in_pathspec(fullname, baselen + len, simplify))
-				dir_add_ignored(dir, fullname, baselen + len);
+			    && in_pathspec(path, len, simplify))
+				dir_add_ignored(dir, path,len);
 
 			/*
 			 * Excluded? If we don't explicitly want to show
@@ -634,7 +633,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 				continue;
 
 			if (dtype == DT_UNKNOWN)
-				dtype = get_dtype(de, fullname);
+				dtype = get_dtype(de, path);
 
 			/*
 			 * Do we want to see just the ignored files?
@@ -651,9 +650,9 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			default:
 				continue;
 			case DT_DIR:
-				memcpy(fullname + baselen + len, "/", 2);
+				memcpy(path + len, "/", 2);
 				len++;
-				switch (treat_directory(dir, fullname, baselen + len, simplify)) {
+				switch (treat_directory(dir, path, len, simplify)) {
 				case show_directory:
 					if (exclude != !!(dir->flags
 							& DIR_SHOW_IGNORED))
@@ -661,7 +660,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 					break;
 				case recurse_into_directory:
 					contents += read_directory_recursive(dir,
-						fullname, fullname, baselen + len, 0, simplify);
+						path, len, 0, simplify);
 					continue;
 				case ignore_directory:
 					continue;
@@ -675,7 +674,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			if (check_only)
 				goto exit_early;
 			else
-				dir_add_name(dir, fullname, baselen + len);
+				dir_add_name(dir, path, len);
 		}
 exit_early:
 		closedir(fdir);
@@ -738,15 +737,15 @@ static void free_simplify(struct path_simplify *simplify)
 	free(simplify);
 }
 
-int read_directory(struct dir_struct *dir, const char *path, const char *base, int baselen, const char **pathspec)
+int read_directory(struct dir_struct *dir, const char *path, int len, const char **pathspec)
 {
 	struct path_simplify *simplify;
 
-	if (has_symlink_leading_path(path, strlen(path)))
+	if (has_symlink_leading_path(path, len))
 		return dir->nr;
 
 	simplify = create_simplify(pathspec);
-	read_directory_recursive(dir, path, base, baselen, 0, simplify);
+	read_directory_recursive(dir, path, len, 0, simplify);
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_name);
diff --git a/dir.h b/dir.h
index f9d69dd..a631446 100644
--- a/dir.h
+++ b/dir.h
@@ -67,7 +67,7 @@ struct dir_struct {
 extern int match_pathspec(const char **pathspec, const char *name, int namelen, int prefix, char *seen);
 
 extern int fill_directory(struct dir_struct *dir, const char **pathspec);
-extern int read_directory(struct dir_struct *, const char *path, const char *base, int baselen, const char **pathspec);
+extern int read_directory(struct dir_struct *, const char *path, int len, const char **pathspec);
 
 extern int excluded(struct dir_struct *, const char *, int *);
 extern void add_excludes_from_file(struct dir_struct *, const char *fname);
diff --git a/unpack-trees.c b/unpack-trees.c
index 05d0bb1..42c7d7d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -551,7 +551,7 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 	memset(&d, 0, sizeof(d));
 	if (o->dir)
 		d.exclude_per_dir = o->dir->exclude_per_dir;
-	i = read_directory(&d, ce->name, pathbuf, namelen+1, NULL);
+	i = read_directory(&d, pathbuf, namelen+1, NULL);
 	if (i)
 		return o->gently ? -1 :
 			error(ERRORMSG(o, not_uptodate_dir), ce->name);
-- 
1.6.3.3.412.gf581d
