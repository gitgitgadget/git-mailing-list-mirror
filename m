From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [RFC 8/8] UTF-8 in non-SHA1-objects
Date: Wed, 13 May 2009 00:50:31 +0200
Message-ID: <1242168631-30753-9-git-send-email-robin.rosenberg@dewire.com>
References: <1242168631-30753-1-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-2-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-3-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-4-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-5-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-6-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-7-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-8-git-send-email-robin.rosenberg@dewire.com>
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 00:51:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M40oy-0000ir-Mq
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 00:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159AbZELWvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 18:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754801AbZELWvB
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 18:51:01 -0400
Received: from mail.dewire.com ([83.140.172.130]:19408 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754587AbZELWux (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 18:50:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 4F31D145A58F;
	Wed, 13 May 2009 00:50:53 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZCqlpPtbay9p; Wed, 13 May 2009 00:50:51 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id EA580145A58A;
	Wed, 13 May 2009 00:50:35 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <1242168631-30753-8-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118966>

---
 dir.c |   22 ++++++++++++++------
 utf.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/dir.c b/dir.c
index 96389b3..043df50 100644
--- a/dir.c
+++ b/dir.c
@@ -114,22 +114,26 @@ static int add_excludes_from_file_1(const char *fname,
 {
 	struct stat st;
 	int fd, i;
-	long size;
-	char *buf, *entry;
+	long insize, size;
+	char *inbuf, *entry, *buf;
 
 	fd = open(fname, O_RDONLY);
 	if (fd < 0 || fstat(fd, &st) < 0)
 		goto err;
-	size = st.st_size;
-	if (size == 0) {
+	insize = st.st_size;
+	if (insize == 0) {
 		close(fd);
 		return 0;
 	}
-	buf = xmalloc(size+1);
-	if (read(fd, buf, size) != size)
+	inbuf = xmalloc(insize+1);
+	if (read(fd, inbuf, insize) != insize)
 		goto err;
 	close(fd);
 
+	size = utflen(inbuf, insize+1);
+	buf = xmalloc(size);
+	utfcpy(buf, inbuf, insize+1);
+
 	buf[size++] = '\n';
 	entry = buf;
 	for (i = 0; i < size; i++) {
@@ -141,9 +145,11 @@ static int add_excludes_from_file_1(const char *fname,
 			entry = buf + i + 1;
 		}
 	}
+	free(inbuf);
 	return 0;
 
  err:
+	// bug: not freeing inbuf...
 	if (0 <= fd)
 		close(fd);
 	return -1;
@@ -185,6 +191,7 @@ static int excluded_1(const char *pathname,
 		      int pathlen,
 		      struct exclude_list *el)
 {
+	P(("excluded_1(\"%0.*s\") = ", pathlen, pathname));
 	int i;
 
 	if (el->nr) {
@@ -202,6 +209,7 @@ static int excluded_1(const char *pathname,
 				/* match basename */
 				const char *basename = strrchr(pathname, '/');
 				basename = (basename) ? basename+1 : pathname;
+				P(("fnmatch(\"%s\",\"%s\")", exclude, basename));
 				if (fnmatch(exclude, basename, 0) == 0)
 					return to_exclude;
 			}
@@ -218,7 +226,7 @@ static int excluded_1(const char *pathname,
 				    (baselen && pathname[baselen-1] != '/') ||
 				    strncmp(pathname, x->base, baselen))
 				    continue;
-
+				P(("fnmatch(\"%s\",\"%s\")", exclude, pathname+baselen));
 				if (fnmatch(exclude, pathname+baselen,
 					    FNM_PATHNAME) == 0)
 					return to_exclude;
diff --git a/utf.c b/utf.c
index 7c44cac..cca64dc 100644
--- a/utf.c
+++ b/utf.c
@@ -228,9 +228,28 @@ static void zfree(void *ret)
     free(ret);
 }
 
+int isgitpath(char *path)
+{
+  char *gitdir=getenv("GIT_DIR");
+  if (!gitdir)
+    gitdir=".git";
+
+  P(("gitdir=%s\n",gitdir));
+  if (strncmp(path, gitdir, strlen(gitdir)) == 0) {
+    P(("gitdir:YES\n"));
+    return 1;
+  } else {
+    P(("gitdir:NO\n"));
+  }
+  
+  return 0;
+}
+
 int utf_lstat(char *path, struct stat *buf)
 {
   P(("utf_lstat(\"%s\",buf)[",path));
+  if (isgitpath(path))
+    return lstat(path, buf);
   char localpath[MAXPATHLEN];
   localcpy(localpath, path, strlen(path)+1);
   P(("\"%s\"]\n",localpath));
@@ -248,6 +267,8 @@ int utf_lstat(char *path, struct stat *buf)
 int utf_stat(char *path, struct stat *buf)
 {
   P(("utf_stat(\"%s\",buf)[",path));
+  if (isgitpath(path))
+    return stat(path, buf);
   char localpath[MAXPATHLEN];
   localcpy(localpath, path, strlen(path)+1);
   P(("\"%s\"]\n",localpath));
@@ -257,19 +278,27 @@ int utf_stat(char *path, struct stat *buf)
 DIR *utf_opendir(char *path)
 {
   P(("utf_opendir(\"%s\")\n",path));
+  if (isgitpath(path)) {
+    P(("not transforming dir"));
+    return opendir(path);
+  }
   char localpath[MAXPATHLEN];
   DIR *ret = NULL;
   localcpy(localpath, path, strlen(path)+1);
   P(("\"%s\"]\n",localpath));
   ret = opendir(localpath);
   if (ret)
-    put(ret, NULL);
+    put(ret, xmalloc(1));
   return ret;
 }
 
 struct dirent* utf_readdir(DIR *dir)
 {
   P(("utf_readdir(\"%p\")",dir));
+  if (!get(dir)) {
+    P(("Skipping\n"));
+    return readdir(dir);
+  }
   struct dirent *ret;
   int len;
   char utfpath[256];
@@ -294,6 +323,9 @@ struct dirent* utf_readdir(DIR *dir)
 int utf_closedir(DIR *dir)
 {
   P(("utf_closedir(%p)\n",dir));
+  if (!get(dir))
+    return closedir(dir);
+
   zfree(getandremove(dir));
   return closedir(dir);
 }
@@ -301,6 +333,9 @@ int utf_closedir(DIR *dir)
 FILE *utf_fopen(char *path, char *mode)
 {
   P(("utf_fopen(\"%s\",\"%s\")[",path,mode));
+  if (isgitpath(path))
+    return fopen(path,mode);
+
   char localpath[MAXPATHLEN];
   localcpy(localpath, path, strlen(path)+1);
   P(("\"%s\"]\n",localpath));
@@ -310,6 +345,9 @@ FILE *utf_fopen(char *path, char *mode)
 FILE *utf_freopen(char *path, char *mode, FILE *stream)
 {
   P(("utf_freopen(\"%s\",\"%s\",%p)[",path,mode,stream));
+  if (isgitpath(path))
+    return utf_freopen(path, mode, stream);
+
   char localpath[MAXPATHLEN];
   localcpy(localpath, path, strlen(path)+1);
   P(("\"%s\"]\n",localpath));
@@ -319,6 +357,9 @@ FILE *utf_freopen(char *path, char *mode, FILE *stream)
 int utf_unlink(char *path)
 {
   P(("utf_unlink(\"%s\")[",path));
+  if (isgitpath(path))
+    return unlink(path);
+
   char localpath[MAXPATHLEN];
   localcpy(localpath, path, strlen(path)+1);
   P(("\"%s\"]\n",localpath));
@@ -328,6 +369,9 @@ int utf_unlink(char *path)
 int utf_rmdir(char *path)
 {
   P(("utf_rmdir(\"%s\")[",path));
+  if (isgitpath(path))
+    return rmdir(path);
+
   char localpath[MAXPATHLEN];
   localcpy(localpath, path, strlen(path)+1);
   P(("\"%s\"]\n",localpath));
@@ -342,6 +386,9 @@ int utf_open(char *path, int flags,...)
   mode = va_arg(va,int);
   va_end(va);
   P(("utf_open(\"%s\",%d,%d)[",path,flags,mode));
+  if (isgitpath(path))
+    return open(path, flags, mode);
+
   char localpath[MAXPATHLEN];
   localcpy(localpath, path, strlen(path)+1);
   P(("\"%s\"]\n",localpath));
@@ -351,6 +398,9 @@ int utf_open(char *path, int flags,...)
 int utf_access(char *path, int mode)
 {
   P(("utf_access(\"%s\",%d)[",path,mode));
+  if (isgitpath(path))
+    return access(path, mode);
+
   char localpath[MAXPATHLEN];
   localcpy(localpath, path, strlen(path)+1);
   P(("\"%s\"]\n",localpath));
@@ -369,6 +419,11 @@ char *utf_getcwd(char *buf,int bufsize)
 	buf = malloc(utflen(localbuf,strlen(localbuf)) + 1);
       }
     }
+    if (isgitpath(localbuf)) {
+      strcpy(buf, localbuf);
+      return buf;
+    }
+
     utfcpy(buf, localbuf, strlen(localbuf) + 1);
     return buf;
   } else {
@@ -379,6 +434,9 @@ char *utf_getcwd(char *buf,int bufsize)
 int utf_creat(const char *path,int mode)
 {
   P(("utf_creat(\"%s\",%d)[",path,mode));
+  if (isgitpath(path))
+    return creat(path, mode);
+
   char localpath[MAXPATHLEN];
   localcpy(localpath, path, strlen(path)+1);
   P(("\"%s\"]\n",localpath));
@@ -388,6 +446,9 @@ int utf_creat(const char *path,int mode)
 int utf_mkdir(const char *path,int mode)
 {
   P(("utf_mkdir(\"%s\",%d)[",path,mode));
+  if (isgitpath(path))
+    return mkdir(path,mode);
+
   char localpath[MAXPATHLEN];
   localcpy(localpath, path, strlen(path)+1);
   P(("\"%s\"]\n",localpath));
@@ -397,6 +458,9 @@ int utf_mkdir(const char *path,int mode)
 ssize_t utf_readlink(const char *path,char *buf,size_t bufsiz)
 {
   P(("utf_readlink(\"%s\",BUF,%d)[",path,bufsiz));
+  if (isgitpath(path))
+    return readlink(path, buf, bufsiz);
+
   char localpath[MAXPATHLEN];
   localcpy(localpath, path, strlen(path)+1);
   P(("readlink(%s)\n", localpath));
-- 
1.6.3.dirty
