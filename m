From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] MinGW: 64-bit file offsets
Date: Thu, 5 Mar 2009 17:05:12 +0100 (CET)
Message-ID: <ae01b6dfcd430694dad008bbf201ee1490b071a1.1236268730u.git.johannes.schindelin@gmx.de>
References: <cover.1236268730u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, Sickboy <sb@dev-heaven.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 05 17:09:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfG63-0001lB-EA
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 17:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbZCEQFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 11:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752849AbZCEQFS
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 11:05:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:50902 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753304AbZCEQFR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 11:05:17 -0500
Received: (qmail invoked by alias); 05 Mar 2009 16:05:13 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp058) with SMTP; 05 Mar 2009 17:05:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+NtkkqLISNru6wRhEJnKI5KQNbNhnQIcc213qEcO
	HuzQSX8/rfwR+S
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1236268730u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112314>

The type 'off_t' should be used everywhere so that the bit-depth of that
type can be adjusted in the standard C library, and you just need to
recompile your program to benefit from the extended precision.

Only that it was not done that way in the MS runtime library.

This patch reroutes off_t to off64_t and provides the other necessary
changes so that finally, clones larger than 2 gigabyte work on Windows
(provided you are on a file system that allows files larger than 2gb).

Initial patch by Sickboy <sb@dev-heaven.net>.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c |    8 +++++---
 compat/mingw.h |    5 ++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 3dbe6a7..27bcf3f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -46,7 +46,8 @@ static int do_lstat(const char *file_name, struct stat *buf)
 		buf->st_uid = 0;
 		buf->st_nlink = 1;
 		buf->st_mode = file_attr_to_st_mode(fdata.dwFileAttributes);
-		buf->st_size = fdata.nFileSizeLow; /* Can't use nFileSizeHigh, since it's not a stat64 */
+		buf->st_size = fdata.nFileSizeLow |
+			(((off_t)fdata.nFileSizeHigh)<<32);
 		buf->st_dev = buf->st_rdev = 0; /* not used by Git */
 		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
 		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
@@ -101,7 +102,7 @@ int mingw_fstat(int fd, struct stat *buf)
 	}
 	/* direct non-file handles to MS's fstat() */
 	if (GetFileType(fh) != FILE_TYPE_DISK)
-		return fstat(fd, buf);
+		return _fstati64(fd, buf);
 
 	if (GetFileInformationByHandle(fh, &fdata)) {
 		buf->st_ino = 0;
@@ -109,7 +110,8 @@ int mingw_fstat(int fd, struct stat *buf)
 		buf->st_uid = 0;
 		buf->st_nlink = 1;
 		buf->st_mode = file_attr_to_st_mode(fdata.dwFileAttributes);
-		buf->st_size = fdata.nFileSizeLow; /* Can't use nFileSizeHigh, since it's not a stat64 */
+		buf->st_size = fdata.nFileSizeLow |
+			(((off_t)fdata.nFileSizeHigh)<<32);
 		buf->st_dev = buf->st_rdev = 0; /* not used by Git */
 		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
 		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
diff --git a/compat/mingw.h b/compat/mingw.h
index a255898..cb9c4d4 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -163,11 +163,14 @@ int mingw_rename(const char*, const char*);
 /* Use mingw_lstat() instead of lstat()/stat() and
  * mingw_fstat() instead of fstat() on Windows.
  */
+#define off_t off64_t
+#define stat _stati64
+#define lseek _lseeki64
 int mingw_lstat(const char *file_name, struct stat *buf);
 int mingw_fstat(int fd, struct stat *buf);
 #define fstat mingw_fstat
 #define lstat mingw_lstat
-#define stat(x,y) mingw_lstat(x,y)
+#define stat64(x,y) mingw_lstat(x,y)
 
 int mingw_utime(const char *file_name, const struct utimbuf *times);
 #define utime mingw_utime
-- 
1.6.2.rc1.493.g27ad8
