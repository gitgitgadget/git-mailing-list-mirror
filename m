From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 1/2] fix mingw stat() and lstat() implementations for handling symlinks
Date: Wed, 17 Mar 2010 15:17:34 +0000
Message-ID: <87eijjdkqj.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 16:35:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrvHd-0006aq-S0
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 16:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773Ab0CQPfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 11:35:36 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:52538 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752298Ab0CQPff (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Mar 2010 11:35:35 -0400
Received: from [172.23.170.137] (helo=anti-virus01-08)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1NrvHR-0006FW-U3; Wed, 17 Mar 2010 15:35:33 +0000
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out5.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1NrvHR-000878-8y; Wed, 17 Mar 2010 15:35:33 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id ADDC4217A8; Wed, 17 Mar 2010 15:35:32 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142400>

In msysGit the stat() function has been implemented using mingw_lstat
which sets the st_mode member to S_IFLNK when a symbolic links is found.
This causes the is_executable function to return when git attempts to
build a list of available commands in the help code and we end up missing
most git commands. (msysGit issue #445)

This patch modifies the implementation so that lstat() will return the link
flag but if we are called as stat() we read the size of the target and set
the mode to that of a regular file.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 compat/mingw.c |   31 ++++++++++++++++++++++++-------
 compat/mingw.h |    3 ++-
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 0df1a3d..9c10a4c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -334,8 +334,11 @@ static inline time_t filetime_to_time_t(const FILETIME *ft)
  * We keep the do_lstat code in a separate function to avoid recursion.
  * When a path ends with a slash, the stat will fail with ENOENT. In
  * this case, we strip the trailing slashes and stat again.
+ *
+ * If follow is true then act like stat() and report on the link
+ * target. Otherwise report on the link itself.
  */
-static int do_lstat(const char *file_name, struct stat *buf)
+static int do_lstat(int follow, const char *file_name, struct stat *buf)
 {
 	WIN32_FILE_ATTRIBUTE_DATA fdata;
 
@@ -357,11 +360,16 @@ static int do_lstat(const char *file_name, struct stat *buf)
 			if (handle != INVALID_HANDLE_VALUE) {
 				if ((findbuf.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) &&
 						(findbuf.dwReserved0 == IO_REPARSE_TAG_SYMLINK)) {
-					char buffer[MAXIMUM_REPARSE_DATA_BUFFER_SIZE];
-					buf->st_mode = S_IREAD | S_IFLNK;
+					if (follow) {
+						char buffer[MAXIMUM_REPARSE_DATA_BUFFER_SIZE];
+						buf->st_size = readlink(file_name, buffer, MAXIMUM_REPARSE_DATA_BUFFER_SIZE);
+						buf->st_mode = S_IFREG;
+					} else {
+						buf->st_mode = S_IFLNK;
+					}
+					buf->st_mode |= S_IREAD;
 					if (!(findbuf.dwFileAttributes & FILE_ATTRIBUTE_READONLY))
 						buf->st_mode |= S_IWRITE;
-					buf->st_size = readlink(file_name, buffer, MAXIMUM_REPARSE_DATA_BUFFER_SIZE);
 				}
 				FindClose(handle);
 			}
@@ -378,12 +386,12 @@ static int do_lstat(const char *file_name, struct stat *buf)
  * complete. Note that Git stat()s are redirected to mingw_lstat()
  * too, since Windows doesn't really handle symlinks that well.
  */
-int mingw_lstat(const char *file_name, struct stat *buf)
+static int do_stat_internal(int follow, const char *file_name, struct stat *buf)
 {
 	int namelen;
 	static char alt_name[PATH_MAX];
 
-	if (!do_lstat(file_name, buf))
+	if (!do_lstat(follow, file_name, buf))
 		return 0;
 
 	/*
@@ -403,7 +411,16 @@ int mingw_lstat(const char *file_name, struct stat *buf)
 
 	memcpy(alt_name, file_name, namelen);
 	alt_name[namelen] = 0;
-	return do_lstat(alt_name, buf);
+	return do_lstat(follow, alt_name, buf);
+}
+
+int mingw_lstat(const char *file_name, struct stat *buf)
+{
+	return do_stat_internal(0, file_name, buf);
+}
+int mingw_stat(const char *file_name, struct stat *buf)
+{
+	return do_stat_internal(1, file_name, buf);
 }
 
 #undef fstat
diff --git a/compat/mingw.h b/compat/mingw.h
index 4650d8a..ff5477b 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -222,10 +222,11 @@ int mingw_getpagesize(void);
 #ifndef ALREADY_DECLARED_STAT_FUNCS
 #define stat _stati64
 int mingw_lstat(const char *file_name, struct stat *buf);
+int mingw_stat(const char *file_name, struct stat *buf);
 int mingw_fstat(int fd, struct stat *buf);
 #define fstat mingw_fstat
 #define lstat mingw_lstat
-#define _stati64(x,y) mingw_lstat(x,y)
+#define _stati64(x,y) mingw_stat(x,y)
 #endif
 
 int mingw_utime(const char *file_name, const struct utimbuf *times);
-- 
1.7.0.2.msysgit.0.3.g3c992.dirty
