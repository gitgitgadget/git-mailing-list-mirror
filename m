From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 29/40] Windows: Use a customized struct stat that also has the st_blocks member.
Date: Wed, 27 Feb 2008 19:54:52 +0100
Message-ID: <1204138503-6126-30-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVU-00022R-8o
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756459AbYB0S4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756342AbYB0Sz7
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:59 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40432 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755642AbYB0SzL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:11 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id ABFDC97571;
	Wed, 27 Feb 2008 19:55:09 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75267>

Windows's struct stat does not have a st_blocks member. Since we already
have our own stat/lstat/fstat implementations, we can just as well use
a customized struct stat. This patch introduces just that, and also fills
in the st_blocks member. On the other hand, we don't provide members that
are never used.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 compat/mingw.c    |   36 ++++++++++++++++++++++++++++--------
 git-compat-util.h |   18 +++++++++++++-----
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index d44fbb3..0888288 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -31,6 +31,11 @@ static inline time_t filetime_to_time_t(const FILETIME *ft)
 	return (time_t)winTime;
 }
 
+static inline size_t size_to_blocks(size_t s)
+{
+	return (s+511)/512;
+}
+
 extern int _getdrive( void );
 /* We keep the do_lstat code in a separate function to avoid recursion.
  * When a path ends with a slash, the stat will fail with ENOENT. In
@@ -52,10 +57,10 @@ static int do_lstat(const char *file_name, struct stat *buf)
 		buf->st_ino = 0;
 		buf->st_gid = 0;
 		buf->st_uid = 0;
-		buf->st_nlink = 1;
 		buf->st_mode = fMode;
 		buf->st_size = fdata.nFileSizeLow; /* Can't use nFileSizeHigh, since it's not a stat64 */
-		buf->st_dev = buf->st_rdev = (_getdrive() - 1);
+		buf->st_blocks = size_to_blocks(buf->st_size);
+		buf->st_dev = _getdrive() - 1;
 		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
 		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
 		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
@@ -89,7 +94,7 @@ static int do_lstat(const char *file_name, struct stat *buf)
  * complete. Note that Git stat()s are redirected to mingw_lstat()
  * too, since Windows doesn't really handle symlinks that well.
  */
-int mingw_lstat(const char *file_name, struct stat *buf)
+int mingw_lstat(const char *file_name, struct mingw_stat *buf)
 {
 	int namelen;
 	static char alt_name[PATH_MAX];
@@ -117,7 +122,8 @@ int mingw_lstat(const char *file_name, struct stat *buf)
 }
 
 #undef fstat
-int mingw_fstat(int fd, struct stat *buf)
+#undef stat
+int mingw_fstat(int fd, struct mingw_stat *buf)
 {
 	HANDLE fh = (HANDLE)_get_osfhandle(fd);
 	BY_HANDLE_FILE_INFORMATION fdata;
@@ -127,8 +133,22 @@ int mingw_fstat(int fd, struct stat *buf)
 		return -1;
 	}
 	/* direct non-file handles to MS's fstat() */
-	if (GetFileType(fh) != FILE_TYPE_DISK)
-		return fstat(fd, buf);
+	if (GetFileType(fh) != FILE_TYPE_DISK) {
+		struct stat st;
+		if (fstat(fd, &st))
+			return -1;
+		buf->st_ino = st.st_ino;
+		buf->st_gid = st.st_gid;
+		buf->st_uid = st.st_uid;
+		buf->st_mode = st.st_mode;
+		buf->st_size = st.st_size;
+		buf->st_blocks = size_to_blocks(buf->st_size);
+		buf->st_dev = st.st_dev;
+		buf->st_atime = st.st_atime;
+		buf->st_mtime = st.st_mtime;
+		buf->st_ctime = st.st_ctime;
+		return 0;
+	}
 
 	if (GetFileInformationByHandle(fh, &fdata)) {
 		int fMode = S_IREAD;
@@ -142,10 +162,10 @@ int mingw_fstat(int fd, struct stat *buf)
 		buf->st_ino = 0;
 		buf->st_gid = 0;
 		buf->st_uid = 0;
-		buf->st_nlink = 1;
 		buf->st_mode = fMode;
 		buf->st_size = fdata.nFileSizeLow; /* Can't use nFileSizeHigh, since it's not a stat64 */
-		buf->st_dev = buf->st_rdev = (_getdrive() - 1);
+		buf->st_blocks = size_to_blocks(buf->st_size);
+		buf->st_dev = _getdrive() - 1;
 		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
 		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
 		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
diff --git a/git-compat-util.h b/git-compat-util.h
index 0583a1f..4a53b3b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -508,8 +508,6 @@ struct itimerval {
 };
 #define ITIMER_REAL 0
 
-#define st_blocks st_size/512	/* will be cleaned up later */
-
 /*
  * trivial stubs
  */
@@ -609,12 +607,22 @@ int mingw_rename(const char*, const char*);
 
 /* Use mingw_lstat() instead of lstat()/stat() and
  * mingw_fstat() instead of fstat() on Windows.
+ * struct stat is redefined because it lacks the st_blocks member.
  */
-int mingw_lstat(const char *file_name, struct stat *buf);
-int mingw_fstat(int fd, struct stat *buf);
+struct mingw_stat {
+	unsigned st_mode;
+	time_t st_mtime, st_atime, st_ctime;
+	unsigned st_dev, st_ino, st_uid, st_gid;
+	size_t st_size;
+	size_t st_blocks;
+};
+int mingw_lstat(const char *file_name, struct mingw_stat *buf);
+int mingw_fstat(int fd, struct mingw_stat *buf);
 #define fstat mingw_fstat
 #define lstat mingw_lstat
-#define stat(x,y) mingw_lstat(x,y)
+#define stat mingw_stat
+static inline int mingw_stat(const char *file_name, struct mingw_stat *buf)
+{ return mingw_lstat(file_name, buf); }
 
 int mingw_vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
 #define vsnprintf mingw_vsnprintf
-- 
1.5.4.1.126.ge5a7d
