From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/3] read_directory(): infrastructure for pathname character
 set conversion
Date: Thu, 14 May 2009 13:54:41 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905141346440.3343@localhost.localdomain>
References: <alpine.LFD.2.01.0905141341470.3343@localhost.localdomain> <alpine.LFD.2.01.0905141342520.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 22:55:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4hxE-0001vW-W5
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 22:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbZENUyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 16:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753229AbZENUyu
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 16:54:50 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34302 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753144AbZENUyt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 16:54:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4EKsf9X031711
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 May 2009 13:54:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4EKsf88003403;
	Thu, 14 May 2009 13:54:41 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0905141342520.3343@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.962 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119224>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 May 2009 13:31:59 -0700

This is some early first infrastructure to make it much easier for
read_directory() to recursively traversing a filesystem directory
structure, while at the same time doing a character set or naming
conversion during traversal.

In particular, this allows:

 - the filesystem path component separator to be set to something
   different than the normal UNIX '/' character.

   Nobody may care (even windows tends to handle '/' well), but it also
   happens to be a good way to test the feature, and this patch makes
   the filesystem separator be "//" (_two_ slashes) just to verify that
   the code correctly keeps the "filesystem representation" from the
   "git internal filename representation".

 - We could - for example - read filesystems that have pathnames in
   a Latin1 encoding, and use this to convert such filesystem character
   set details into a git format (where UTF-8 would be the default, the
   same way we default to UTF-8 in commit messages without actually
   _forcing_ it)

 - On OS X, we can make the read_directory() conversion convert the
   native (and odd/crazy) UTF-8 NFD representation into the more normal
   cross-platform NFC representation.

But please note that this is just preliminary, and not only doesn't
actually have any explicit character set convrsion code, it still lacks
some other infrastructure.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Ok, so this adds many more lines than I just removed, but at least several 
of them are comments about what the difference between 'path' and 'base' 
is, and it all works.

The use of "//" as the filesystem path component separator may be odd, but 
it's a useful hack: from 'strace', you can now see how different 
operations now use the "filesystem pathname" and others use the "native 
git pathname", because one will have two slashes between components and 
the other will not.

So you can literally -visually- see the places that aren't converted, and 
that use the git internal paths for filesystem operations. Example strace 
output:

  ...
  open("compat//fnmatch//", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 6
  getdents(6, /* 4 entries */, 32768) = 112
  open("compat/fnmatch/.gitignore", O_RDONLY) = -1 ENOENT (No such file or directory)
  ...

iow, here we see how the directory traversal itself uses the "filesystem 
pathname", but then the ignore-file handling does not.

Now imagine if one of them needs to do some UTF-8 -> EUC-JP translation or 
something like that, rather than having the (purely visual) extra '/'.

So it's currently just a cheezy hack, but it was useful for testing, and I 
think this series is worth thinking seriously about. The two first patches 
were plain cleanups, and this one isn't _that_ complex, but adds some 
potentially interesting infrastructure, even if it's not complete yet.

 dir.c          |   80 ++++++++++++++++++++++++++++++++++++++++++++-----------
 unpack-trees.c |    4 ++-
 2 files changed, 67 insertions(+), 17 deletions(-)

diff --git a/dir.c b/dir.c
index c667d38..ae1ae61 100644
--- a/dir.c
+++ b/dir.c
@@ -22,6 +22,7 @@ int fill_directory(struct dir_struct *dir, const char **pathspec)
 	path = "";
 	base = "";
 
+	/* FIXME! Filesystem character set vs git internal character set! */
 	if (baselen)
 		path = base = xmemdupz(*pathspec, baselen);
 
@@ -586,6 +587,21 @@ static int get_dtype(struct dirent *de, const char *path)
 	return dtype;
 }
 
+/* No actual conversion yet */
+static int convert_path_to_git(const char *path, int plen, char *result)
+{
+	memcpy(result, path, plen+1);
+	return plen;
+}
+
+/*
+ * For testing!
+ *
+ * On Windows, maybe we want FS_PATH_SEP being "\\"?
+ */
+#define FS_PATH_SEP "//"
+#define FS_PATH_SEP_LEN 2
+
 /*
  * Read a directory tree. We currently ignore anything but
  * directories, regular files and symlinks. That's because git
@@ -594,37 +610,62 @@ static int get_dtype(struct dirent *de, const char *path)
  *
  * Also, we ignore the name ".git" (even if it is not a directory).
  * That likely will not change.
+ *
+ * 'path' is the filesystem name of directory, in the filesystem
+ * namespace, while 'base' is the internal git path (converted
+ * into the standard git namespace).
  */
-static int read_directory_recursive(struct dir_struct *dir, const char *path, const char *base, int baselen, int check_only, const struct path_simplify *simplify)
+static int read_directory_recursive(struct dir_struct *dir,
+	const char *path,
+	const char *base, int baselen,
+	int check_only, const struct path_simplify *simplify)
 {
 	DIR *fdir = opendir(*path ? path : ".");
 	int contents = 0;
 
 	if (fdir) {
+		int pathlen = strlen(path);
 		struct dirent *de;
-		char fullname[PATH_MAX + 1];
-		memcpy(fullname, base, baselen);
+		char newpath[PATH_MAX + 1];
+		char newbase[PATH_MAX + 1];
+
+		memcpy(newpath, path, pathlen);
+		memcpy(newbase, base, baselen);
 
 		while ((de = readdir(fdir)) != NULL) {
-			int len, dtype;
+			char converted[256];
+			int len, dtype, nlen;
 			int exclude;
 
 			if (is_dot_or_dotdot(de->d_name) ||
 			     !strcmp(de->d_name, ".git"))
 				continue;
+
 			len = strlen(de->d_name);
+
 			/* Ignore overly long pathnames! */
-			if (len + baselen + 8 > sizeof(fullname))
+			if (len + pathlen + 8 > sizeof(newpath))
 				continue;
-			memcpy(fullname + baselen, de->d_name, len+1);
-			if (simplify_away(fullname, baselen + len, simplify))
+			memcpy(newpath + pathlen, de->d_name, len+1);
+
+			nlen = convert_path_to_git(de->d_name, len, converted);
+			if (nlen + baselen + 8 > sizeof(newbase))
 				continue;
+			memcpy(newbase + baselen, converted, nlen+1);
 
+			len = pathlen + len;
+			nlen = baselen + nlen;
+
+			/* We simplify by the git internal pathname (newbase) */
+			if (simplify_away(newbase, nlen, simplify))
+				continue;
+
+			/* Similarly, exclude rules work on the git pathname */
 			dtype = DTYPE(de);
-			exclude = excluded(dir, fullname, &dtype);
+			exclude = excluded(dir, newbase, &dtype);
 			if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
-			    && in_pathspec(fullname, baselen + len, simplify))
-				dir_add_ignored(dir, fullname, baselen + len);
+			    && in_pathspec(newbase, nlen, simplify))
+				dir_add_ignored(dir, newbase, nlen);
 
 			/*
 			 * Excluded? If we don't explicitly want to show
@@ -633,8 +674,12 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			if (exclude && !(dir->flags & DIR_SHOW_IGNORED))
 				continue;
 
+			/*
+			 * The 'dtype' information comes from the filesystem,
+			 * and we use the filesystem pathname for that (newpath)
+			 */
 			if (dtype == DT_UNKNOWN)
-				dtype = get_dtype(de, fullname);
+				dtype = get_dtype(de, newpath);
 
 			/*
 			 * Do we want to see just the ignored files?
@@ -651,9 +696,12 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			default:
 				continue;
 			case DT_DIR:
-				memcpy(fullname + baselen + len, "/", 2);
-				len++;
-				switch (treat_directory(dir, fullname, baselen + len, simplify)) {
+				memcpy(newpath + len, FS_PATH_SEP, FS_PATH_SEP_LEN+1);
+				len += FS_PATH_SEP_LEN;
+				memcpy(newbase + nlen, "/", 2);
+				nlen++;
+
+				switch (treat_directory(dir, newbase, nlen, simplify)) {
 				case show_directory:
 					if (exclude != !!(dir->flags
 							& DIR_SHOW_IGNORED))
@@ -661,7 +709,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 					break;
 				case recurse_into_directory:
 					contents += read_directory_recursive(dir,
-						fullname, fullname, baselen + len, 0, simplify);
+						newpath, newbase, nlen, 0, simplify);
 					continue;
 				case ignore_directory:
 					continue;
@@ -675,7 +723,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			if (check_only)
 				goto exit_early;
 			else
-				dir_add_name(dir, fullname, baselen + len);
+				dir_add_name(dir, newbase, nlen);
 		}
 exit_early:
 		closedir(fdir);
diff --git a/unpack-trees.c b/unpack-trees.c
index e4eb8fa..457b529 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -534,7 +534,9 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 	memset(&d, 0, sizeof(d));
 	if (o->dir)
 		d.exclude_per_dir = o->dir->exclude_per_dir;
-	i = read_directory(&d, ce->name, pathbuf, namelen+1, NULL);
+
+	/* FIXME! Filesystem pathname vs internal git pathname! */
+	i = read_directory(&d, pathbuf, pathbuf, namelen+1, NULL);
 	if (i)
 		return o->gently ? -1 :
 			error(ERRORMSG(o, not_uptodate_dir), ce->name);
-- 
1.6.3.1.11.g97114
