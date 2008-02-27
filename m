From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 28/40] Windows: Add a new lstat and fstat implementation based on Win32 API.
Date: Wed, 27 Feb 2008 19:54:51 +0100
Message-ID: <1204138503-6126-29-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Marius Storm-Olsen <mstormo_git@storm-olsen.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVU-00022R-Ti
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755849AbYB0S4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755700AbYB0S4B
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:56:01 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40454 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645AbYB0SzL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:11 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 459B497558;
	Wed, 27 Feb 2008 19:55:09 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75277>

From: Marius Storm-Olsen <mstormo_git@storm-olsen.com>

From: Marius Storm-Olsen <mstormo_git@storm-olsen.com>

This gives us a significant speedup when adding, committing and stat'ing files.
Also, since Windows doesn't really handle symlinks, we let stat just uses lstat.
We also need to replace fstat, since our implementation and the standard stat()
functions report slightly different timestamps, possibly due to timezones.

We simply report UTC in our implementation, and do our FILETIME to time_t
conversion based on the document at http://support.microsoft.com/kb/167296.

With Moe's repo structure (100K files in 100 dirs, containing 2-4 bytes)
    mkdir bummer && cd bummer; for ((i=0;i<100;i++)); do
      mkdir $i && pushd $i;
        for ((j=0;j<1000;j++)); do echo "$j" >$j; done;
      popd;
    done

We get the following performance boost:

    With normal lstat & stat  Custom lstat/fstat
    ------------------------  ------------------------
    Command: git init         Command: git init
    ------------------------  ------------------------
    real    0m 0.047s          real   0m 0.063s
    user    0m 0.031s          user   0m 0.015s
    sys     0m 0.000s          sys    0m 0.015s
    ------------------------  ------------------------
    Command: git add .        Command: git add .
    ------------------------  ------------------------
    real    0m19.390s         real    0m12.031s       1.6x
    user    0m 0.015s         user    0m 0.031s
    sys     0m 0.030s         sys     0m 0.000s
    ------------------------  ------------------------
    Command: git commit -a..  Command: git commit -a..
    ------------------------  ------------------------
    real    0m30.812s         real    0m16.875s       1.8x
    user    0m 0.015s         user    0m 0.015s
    sys     0m 0.000s         sys     0m 0.015s
    ------------------------  ------------------------
    3x Command: git-status    3x Command: git-status
    ------------------------  ------------------------
    real    0m11.860s         real    0m 5.266s       2.2x
    user    0m 0.015s         user    0m 0.015s
    sys     0m 0.015s         sys     0m 0.015s

    real    0m11.703s         real    0m 5.234s
    user    0m 0.015s         user    0m 0.015s
    sys     0m 0.000s         sys     0m 0.000s

    real    0m11.672s         real    0m 5.250s
    user    0m 0.031s         user    0m 0.015s
    sys     0m 0.000s         sys     0m 0.000s
    ------------------------  ------------------------
    Command: git commit...    Command: git commit...
    (single file)             (single file)
    ------------------------  ------------------------
    real    0m14.234s         real    0m 7.735s       1.8x
    user    0m 0.015s         user    0m 0.031s
    sys     0m 0.000s         sys     0m 0.000s

Signed-off-by: Marius Storm-Olsen <mstormo_git@storm-olsen.com>
Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 compat/mingw.c    |  132 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h |   10 ++++-
 2 files changed, 141 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 146c170..d44fbb3 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -23,6 +23,138 @@ int mingw_open (const char *filename, int oflags, ...)
 	return fd;
 }
 
+static inline time_t filetime_to_time_t(const FILETIME *ft)
+{
+	long long winTime = ((long long)ft->dwHighDateTime << 32) + ft->dwLowDateTime;
+	winTime -= 116444736000000000LL; /* Windows to Unix Epoch conversion */
+	winTime /= 10000000;		 /* Nano to seconds resolution */
+	return (time_t)winTime;
+}
+
+extern int _getdrive( void );
+/* We keep the do_lstat code in a separate function to avoid recursion.
+ * When a path ends with a slash, the stat will fail with ENOENT. In
+ * this case, we strip the trailing slashes and stat again.
+ */
+static int do_lstat(const char *file_name, struct stat *buf)
+{
+	WIN32_FILE_ATTRIBUTE_DATA fdata;
+
+	if (GetFileAttributesExA(file_name, GetFileExInfoStandard, &fdata)) {
+		int fMode = S_IREAD;
+		if (fdata.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
+			fMode |= S_IFDIR;
+		else
+			fMode |= S_IFREG;
+		if (!(fdata.dwFileAttributes & FILE_ATTRIBUTE_READONLY))
+			fMode |= S_IWRITE;
+
+		buf->st_ino = 0;
+		buf->st_gid = 0;
+		buf->st_uid = 0;
+		buf->st_nlink = 1;
+		buf->st_mode = fMode;
+		buf->st_size = fdata.nFileSizeLow; /* Can't use nFileSizeHigh, since it's not a stat64 */
+		buf->st_dev = buf->st_rdev = (_getdrive() - 1);
+		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
+		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
+		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
+		errno = 0;
+		return 0;
+	}
+
+	switch (GetLastError()) {
+	case ERROR_ACCESS_DENIED:
+	case ERROR_SHARING_VIOLATION:
+	case ERROR_LOCK_VIOLATION:
+	case ERROR_SHARING_BUFFER_EXCEEDED:
+		errno = EACCES;
+		break;
+	case ERROR_BUFFER_OVERFLOW:
+		errno = ENAMETOOLONG;
+		break;
+	case ERROR_NOT_ENOUGH_MEMORY:
+		errno = ENOMEM;
+		break;
+	default:
+		errno = ENOENT;
+		break;
+	}
+	return -1;
+}
+
+/* We provide our own lstat/fstat functions, since the provided
+ * lstat/fstat functions are so slow. These stat functions are
+ * tailored for Git's usage (read: fast), and are not meant to be
+ * complete. Note that Git stat()s are redirected to mingw_lstat()
+ * too, since Windows doesn't really handle symlinks that well.
+ */
+int mingw_lstat(const char *file_name, struct stat *buf)
+{
+	int namelen;
+	static char alt_name[PATH_MAX];
+
+	if (!do_lstat(file_name, buf))
+		return 0;
+
+	/* if file_name ended in a '/', Windows returned ENOENT;
+	 * try again without trailing slashes
+	 */
+	if (errno != ENOENT)
+		return -1;
+
+	namelen = strlen(file_name);
+	if (namelen && file_name[namelen-1] != '/')
+		return -1;
+	while (namelen && file_name[namelen-1] == '/')
+		--namelen;
+	if (!namelen || namelen >= PATH_MAX)
+		return -1;
+
+	memcpy(alt_name, file_name, namelen);
+	alt_name[namelen] = 0;
+	return do_lstat(alt_name, buf);
+}
+
+#undef fstat
+int mingw_fstat(int fd, struct stat *buf)
+{
+	HANDLE fh = (HANDLE)_get_osfhandle(fd);
+	BY_HANDLE_FILE_INFORMATION fdata;
+
+	if (fh == INVALID_HANDLE_VALUE) {
+		errno = EBADF;
+		return -1;
+	}
+	/* direct non-file handles to MS's fstat() */
+	if (GetFileType(fh) != FILE_TYPE_DISK)
+		return fstat(fd, buf);
+
+	if (GetFileInformationByHandle(fh, &fdata)) {
+		int fMode = S_IREAD;
+		if (fdata.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
+			fMode |= S_IFDIR;
+		else
+			fMode |= S_IFREG;
+		if (!(fdata.dwFileAttributes & FILE_ATTRIBUTE_READONLY))
+			fMode |= S_IWRITE;
+
+		buf->st_ino = 0;
+		buf->st_gid = 0;
+		buf->st_uid = 0;
+		buf->st_nlink = 1;
+		buf->st_mode = fMode;
+		buf->st_size = fdata.nFileSizeLow; /* Can't use nFileSizeHigh, since it's not a stat64 */
+		buf->st_dev = buf->st_rdev = (_getdrive() - 1);
+		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
+		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
+		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
+		return 0;
+	}
+	errno = EBADF;
+	return -1;
+}
+
 unsigned int sleep (unsigned int seconds)
 {
 	Sleep(seconds*1000);
diff --git a/git-compat-util.h b/git-compat-util.h
index 570eb10..0583a1f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -509,7 +509,6 @@ struct itimerval {
 #define ITIMER_REAL 0
 
 #define st_blocks st_size/512	/* will be cleaned up later */
-#define lstat stat
 
 /*
  * trivial stubs
@@ -608,6 +607,15 @@ int mingw_connect(int sockfd, struct sockaddr *sa, size_t sz);
 int mingw_rename(const char*, const char*);
 #define rename mingw_rename
 
+/* Use mingw_lstat() instead of lstat()/stat() and
+ * mingw_fstat() instead of fstat() on Windows.
+ */
+int mingw_lstat(const char *file_name, struct stat *buf);
+int mingw_fstat(int fd, struct stat *buf);
+#define fstat mingw_fstat
+#define lstat mingw_lstat
+#define stat(x,y) mingw_lstat(x,y)
+
 int mingw_vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
 #define vsnprintf mingw_vsnprintf
 
-- 
1.5.4.1.126.ge5a7d
