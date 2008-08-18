From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 2/2] Revert "Windows: Use a customized struct stat that also has the st_blocks member."
Date: Mon, 18 Aug 2008 22:01:06 +0200
Message-ID: <200808182201.06114.johannes.sixt@telecom.at>
References: <273481A4-0BB2-4A58-83AD-604B425DE824@web.de> <7vy72w6kiv.fsf@gitster.siamese.dyndns.org> <200808182157.16392.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Andreas =?iso-8859-1?q?F=E4rber?= <andreas.faerber@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 22:02:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVAvt-00080s-GS
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 22:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757091AbYHRUBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 16:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756384AbYHRUBL
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 16:01:11 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:33614 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757062AbYHRUBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 16:01:09 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 471BB971D6;
	Mon, 18 Aug 2008 22:01:06 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 368F51D3EC;
	Mon, 18 Aug 2008 22:01:06 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <200808182157.16392.johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92733>

This reverts commit fc2ded5b08e071beed974117c0148781b1acc94a.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
And this is the follow-up to revert to the regular struct stat on MinGW.

BTW, do we sign-off reverts?

 compat/mingw.c |   28 ++++++++--------------------
 compat/mingw.h |   15 +++------------
 2 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 798fb61..ccfa2a0 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -52,9 +52,10 @@ static int do_lstat(const char *file_name, struct stat *buf)
 		buf->st_ino = 0;
 		buf->st_gid = 0;
 		buf->st_uid = 0;
+		buf->st_nlink = 1;
 		buf->st_mode = fMode;
 		buf->st_size = fdata.nFileSizeLow; /* Can't use nFileSizeHigh, since it's not 
a stat64 */
-		buf->st_dev = _getdrive() - 1;
+		buf->st_dev = buf->st_rdev = (_getdrive() - 1);
 		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
 		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
 		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
@@ -88,7 +89,7 @@ static int do_lstat(const char *file_name, struct stat *buf)
  * complete. Note that Git stat()s are redirected to mingw_lstat()
  * too, since Windows doesn't really handle symlinks that well.
  */
-int mingw_lstat(const char *file_name, struct mingw_stat *buf)
+int mingw_lstat(const char *file_name, struct stat *buf)
 {
 	int namelen;
 	static char alt_name[PATH_MAX];
@@ -116,8 +117,7 @@ int mingw_lstat(const char *file_name, struct mingw_stat *buf)
 }
 
 #undef fstat
-#undef stat
-int mingw_fstat(int fd, struct mingw_stat *buf)
+int mingw_fstat(int fd, struct stat *buf)
 {
 	HANDLE fh = (HANDLE)_get_osfhandle(fd);
 	BY_HANDLE_FILE_INFORMATION fdata;
@@ -127,21 +127,8 @@ int mingw_fstat(int fd, struct mingw_stat *buf)
 		return -1;
 	}
 	/* direct non-file handles to MS's fstat() */
-	if (GetFileType(fh) != FILE_TYPE_DISK) {
-		struct stat st;
-		if (fstat(fd, &st))
-			return -1;
-		buf->st_ino = st.st_ino;
-		buf->st_gid = st.st_gid;
-		buf->st_uid = st.st_uid;
-		buf->st_mode = st.st_mode;
-		buf->st_size = st.st_size;
-		buf->st_dev = st.st_dev;
-		buf->st_atime = st.st_atime;
-		buf->st_mtime = st.st_mtime;
-		buf->st_ctime = st.st_ctime;
-		return 0;
-	}
+	if (GetFileType(fh) != FILE_TYPE_DISK)
+		return fstat(fd, buf);
 
 	if (GetFileInformationByHandle(fh, &fdata)) {
 		int fMode = S_IREAD;
@@ -155,9 +142,10 @@ int mingw_fstat(int fd, struct mingw_stat *buf)
 		buf->st_ino = 0;
 		buf->st_gid = 0;
 		buf->st_uid = 0;
+		buf->st_nlink = 1;
 		buf->st_mode = fMode;
 		buf->st_size = fdata.nFileSizeLow; /* Can't use nFileSizeHigh, since it's not 
a stat64 */
-		buf->st_dev = _getdrive() - 1;
+		buf->st_dev = buf->st_rdev = (_getdrive() - 1);
 		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
 		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
 		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
diff --git a/compat/mingw.h b/compat/mingw.h
index 1472d59..4f275cb 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -162,21 +162,12 @@ int mingw_rename(const char*, const char*);
 
 /* Use mingw_lstat() instead of lstat()/stat() and
  * mingw_fstat() instead of fstat() on Windows.
- * struct stat is redefined because it lacks the st_blocks member.
  */
-struct mingw_stat {
-	unsigned st_mode;
-	time_t st_mtime, st_atime, st_ctime;
-	unsigned st_dev, st_ino, st_uid, st_gid;
-	size_t st_size;
-};
-int mingw_lstat(const char *file_name, struct mingw_stat *buf);
-int mingw_fstat(int fd, struct mingw_stat *buf);
+int mingw_lstat(const char *file_name, struct stat *buf);
+int mingw_fstat(int fd, struct stat *buf);
 #define fstat mingw_fstat
 #define lstat mingw_lstat
-#define stat mingw_stat
-static inline int mingw_stat(const char *file_name, struct mingw_stat *buf)
-{ return mingw_lstat(file_name, buf); }
+#define stat(x,y) mingw_lstat(x,y)
 
 int mingw_utime(const char *file_name, const struct utimbuf *times);
 #define utime mingw_utime
-- 
1.6.0.rc2.4.g07fd3
