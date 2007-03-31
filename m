From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-add has gone lstat() mad
Date: Fri, 30 Mar 2007 20:39:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703302020510.6730@woody.linux-foundation.org>
References: <200703302055.13619.andyparkins@gmail.com>
 <200703302120.23713.andyparkins@gmail.com> <7vslbmxkcv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 31 05:39:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXURJ-00050I-5n
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 05:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933580AbXCaDjh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 23:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933583AbXCaDjh
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 23:39:37 -0400
Received: from smtp.osdl.org ([65.172.181.24]:36243 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933580AbXCaDjg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 23:39:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2V3dWod022174
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 30 Mar 2007 20:39:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2V3dUUn014965;
	Fri, 30 Mar 2007 20:39:31 -0700
In-Reply-To: <7vslbmxkcv.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3.461 required=5 tests=AWL,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43538>



On Fri, 30 Mar 2007, Junio C Hamano wrote:

> Andy Parkins <andyparkins@gmail.com> writes:
> 
> > I can't see why git feels that it has to recurse the entire subtree.  It 
> > seems to be something to do with the gitignore stuff.  Surely there is 
> > no need to use a recursive search when no directories are being added?
> 
> I do not think this is anything new.

Yeah, it's probably old. That said, it's still ugly.

> Patches are welcome, but applying them to 'master' needs to wait
> post 1.5.1.

Here's a patch. It passes all tests. It's not that complex. But people 
should double-check. ESPECIALLY the list of special characters (currently 
'?' '*' '\\' and '[').

Andy, does it work for you?

NOTE! It changes the "const char **pathspec" into an array of "struct 
path_simplify", because that way it doesn't need to check for the magic 
shell expansion characters over and over and over and over again, and can 
just do it once up-front. All the real meat of the patch is really that 
conversion, and somebody should double-check that I actually got all the 
special characters..

The way things are set up, you can now pass a "pathspec" to the 
"read_directory()" function. If you pass NULL, it acts exactly like it 
used to do (read everything). If you pass a non-NULL pointer, it will 
simplify it into a "these are the prefixes without any special 
characters", and stop any readdir() early if the path in question doesn't 
match any of the prefixes.

NOTE! This does *not* obviate the need for the caller to do the *exact* 
pathspec match later. It's a first-level filter on "read_directory()", but 
it does not do the full pathspec thing. Maybe it should. But in the 
meantime, builtin-add.c really does need to do first

	read_directory(dir, .., pathspec);
	if (pathspec)
		prune_directory(dir, pathspec, baselen);

ie the "prune_directory()" part will do the *exact* pathspec pruning, 
while the "read_directory()" will use the pathspec just to do some quick 
high-level pruning of the directories it will recurse into.

Does this matter? I can say that:

	git ls-files -o Makefile~

on the kernel took 0.110s for me before, and it now takes 0.014s. And 
maybe Andy's case more noticeable. Andy?

		Linus
---
 builtin-add.c      |    2 +-
 builtin-ls-files.c |    2 +-
 dir.c              |   96 +++++++++++++++++++++++++++++++++++++++++++++++++---
 dir.h              |    2 +-
 wt-status.c        |    2 +-
 5 files changed, 95 insertions(+), 9 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 9fcf514..871e23f 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -87,7 +87,7 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec)
 	}
 
 	/* Read the directory and prune it */
-	read_directory(dir, path, base, baselen);
+	read_directory(dir, path, base, baselen, pathspec);
 	if (pathspec)
 		prune_directory(dir, pathspec, baselen);
 }
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 4e1d5af..74a6aca 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -216,7 +216,7 @@ static void show_files(struct dir_struct *dir, const char *prefix)
 
 		if (baselen)
 			path = base = prefix;
-		read_directory(dir, path, base, baselen);
+		read_directory(dir, path, base, baselen, pathspec);
 		if (show_others)
 			show_other_files(dir);
 		if (show_killed)
diff --git a/dir.c b/dir.c
index b48e19d..f1cf278 100644
--- a/dir.c
+++ b/dir.c
@@ -8,6 +8,11 @@
 #include "cache.h"
 #include "dir.h"
 
+struct path_simplify {
+	int len;
+	const char *path;
+};
+
 int common_prefix(const char **pathspec)
 {
 	const char *path, *slash, *next;
@@ -293,6 +298,31 @@ static int dir_exists(const char *dirname, int len)
 }
 
 /*
+ * This is an inexact early pruning of any recursive directory
+ * reading - if the path cannot possibly be in the pathspec,
+ * return true, and we'll skip it early.
+ */
+static int simplify_away(const char *path, int pathlen, const struct path_simplify *simplify)
+{
+	if (simplify) {
+		for (;;) {
+			const char *match = simplify->path;
+			int len = simplify->len;
+
+			if (!match)
+				break;
+			if (len > pathlen)
+				len = pathlen;
+			if (!memcmp(path, match, len))
+				return 0;
+			simplify++;
+		}
+		return 1;
+	}
+	return 0;
+}
+
+/*
  * Read a directory tree. We currently ignore anything but
  * directories, regular files and symlinks. That's because git
  * doesn't handle them at all yet. Maybe that will change some
@@ -301,7 +331,7 @@ static int dir_exists(const char *dirname, int len)
  * Also, we ignore the name ".git" (even if it is not a directory).
  * That likely will not change.
  */
-static int read_directory_recursive(struct dir_struct *dir, const char *path, const char *base, int baselen, int check_only)
+static int read_directory_recursive(struct dir_struct *dir, const char *path, const char *base, int baselen, int check_only, const struct path_simplify *simplify)
 {
 	DIR *fdir = opendir(path);
 	int contents = 0;
@@ -324,6 +354,8 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 				continue;
 			len = strlen(de->d_name);
 			memcpy(fullname + baselen, de->d_name, len+1);
+			if (simplify_away(fullname, baselen + len, simplify))
+				continue;
 			if (excluded(dir, fullname) != dir->show_ignored) {
 				if (!dir->show_ignored || DTYPE(de) != DT_DIR) {
 					continue;
@@ -350,13 +382,13 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 					if (dir->hide_empty_directories &&
 					    !read_directory_recursive(dir,
 						    fullname, fullname,
-						    baselen + len, 1))
+						    baselen + len, 1, simplify))
 						continue;
 					break;
 				}
 
 				contents += read_directory_recursive(dir,
-					fullname, fullname, baselen + len, 0);
+					fullname, fullname, baselen + len, 0, simplify);
 				continue;
 			case DT_REG:
 			case DT_LNK:
@@ -386,8 +418,61 @@ static int cmp_name(const void *p1, const void *p2)
 				  e2->name, e2->len);
 }
 
-int read_directory(struct dir_struct *dir, const char *path, const char *base, int baselen)
+/*
+ * Return the length of the "simple" part of a path match limiter.
+ */
+static int simple_length(const char *match)
 {
+	const char special[256] = {
+		[0] = 1, ['?'] = 1,
+		['\\'] = 1, ['*'] = 1,
+		['['] = 1
+	};
+	int len = -1;
+
+	for (;;) {
+		unsigned char c = *match++;
+		len++;
+		if (special[c])
+			return len;
+	}
+}
+
+static struct path_simplify *create_simplify(const char **pathspec)
+{
+	int nr, alloc = 0;
+	struct path_simplify *simplify = NULL;
+
+	if (!pathspec)
+		return NULL;
+
+	for (nr = 0 ; ; nr++) {
+		const char *match;
+		if (nr >= alloc) {
+			alloc = alloc_nr(alloc);
+			simplify = xrealloc(simplify, alloc * sizeof(*simplify));
+		}
+		match = *pathspec++;
+		if (!match)
+			break;
+		simplify[nr].path = match;
+		simplify[nr].len = simple_length(match);
+	}
+	simplify[nr].path = NULL;
+	simplify[nr].len = 0;
+	return simplify;
+}
+
+static void free_simplify(struct path_simplify *simplify)
+{
+	if (simplify)
+		free(simplify);
+}
+
+int read_directory(struct dir_struct *dir, const char *path, const char *base, int baselen, const char **pathspec)
+{
+	struct path_simplify *simplify = create_simplify(pathspec);
+
 	/*
 	 * Make sure to do the per-directory exclude for all the
 	 * directories leading up to our base.
@@ -414,7 +499,8 @@ int read_directory(struct dir_struct *dir, const char *path, const char *base, i
 		}
 	}
 
-	read_directory_recursive(dir, path, base, baselen, 0);
+	read_directory_recursive(dir, path, base, baselen, 0, simplify);
+	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	return dir->nr;
 }
diff --git a/dir.h b/dir.h
index 7233d65..33c31f2 100644
--- a/dir.h
+++ b/dir.h
@@ -48,7 +48,7 @@ extern int common_prefix(const char **pathspec);
 #define MATCHED_EXACTLY 3
 extern int match_pathspec(const char **pathspec, const char *name, int namelen, int prefix, char *seen);
 
-extern int read_directory(struct dir_struct *, const char *path, const char *base, int baselen);
+extern int read_directory(struct dir_struct *, const char *path, const char *base, int baselen, const char **pathspec);
 extern int push_exclude_per_directory(struct dir_struct *, const char *, int);
 extern void pop_exclude_per_directory(struct dir_struct *, int);
 
diff --git a/wt-status.c b/wt-status.c
index a25632b..a055990 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -260,7 +260,7 @@ static void wt_status_print_untracked(struct wt_status *s)
 	if (file_exists(x))
 		add_excludes_from_file(&dir, x);
 
-	read_directory(&dir, ".", "", 0);
+	read_directory(&dir, ".", "", 0, NULL);
 	for(i = 0; i < dir.nr; i++) {
 		/* check for matching entry, which is unmerged; lifted from
 		 * builtin-ls-files:show_other_files */
