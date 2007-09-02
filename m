From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH] Add a new lstat implementation based on Win32 API, and make
 stat use that implementation too.
Date: Sun, 02 Sep 2007 16:51:57 +0200
Message-ID: <46DACE0D.5070501@trolltech.com>
References: <46DACD93.9000509@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 16:52:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRqoK-0002gf-1e
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 16:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757411AbXIBOwG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 10:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756944AbXIBOwG
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 10:52:06 -0400
Received: from esparsett.troll.no ([62.70.27.18]:56092 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756972AbXIBOwD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 10:52:03 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 0A3C374235; Sun,  2 Sep 2007 16:52:02 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	by esparsett.troll.no (Postfix) with ESMTP
	id BC1B274230; Sun,  2 Sep 2007 16:52:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <46DACD93.9000509@trolltech.com>
X-Enigmail-Version: 0.95.3
OpenPGP: id=34EB4437
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57334>

This gives us a significant speedup when adding, committing and stat'ing files.
(Also, since Windows doesn't really handle symlinks, it's fine that stat just uses lstat)

Signed-off-by: Marius Storm-Olsen <mstormo_git@storm-olsen.com>
---
The following patch will override the normal Posix implementation of stat and
lstat on Windows, and use normal Windows API to ensure we're stat'ing as fast
as possible. With this patch I get the performance increase to the far right.

Initially, I only replaced lstat, since that's what the MinGW port of Git had
implemented from before. But, since we don't really care about symlinks on
Windows, I decided to simply use the same implementation for stat as well. The
performance benefit is clearly indicated in the report below.


 With normal lstat & stat   lstat, based on Win32      lstat & stat, as Win32
 -------------------------  -------------------------  -------------------------
 Command: git init          Command: git init          Command: git init
 -------------------------  -------------------------  -------------------------

 real    0m0.047s           real      0m0.047s         real       0m0.078s
 user    0m0.031s           user      0m0.031s         user       0m0.031s
 sys     0m0.000s           sys       0m0.000s         sys        0m0.000s

 -------------------------  -------------------------  -------------------------
 Command: git add .         Command: git add .         Command: git add .
 -------------------------  -------------------------  -------------------------

 real    0m19.390s          real      0m19.390s        real       0m12.187s
 user    0m0.015s           user      0m0.015s         user       0m0.015s
 sys     0m0.030s           sys       0m0.030s         sys        0m0.015s

 -------------------------  -------------------------  -------------------------
 Command: git commit -a...  Command: git commit -a...  Command: git commit -a...
 -------------------------  -------------------------  -------------------------

 real    0m30.812s          real      0m22.547s        real       0m17.297s
 user    0m0.015s           user      0m0.031s         user       0m0.015s
 sys     0m0.000s           sys       0m0.000s         sys        0m0.015s

 -------------------------  -------------------------  -------------------------
 3x Command: git-status     3x Command: git-status     3x Command: git-status
 -------------------------  -------------------------  -------------------------

 real    0m11.860s          real      0m5.360s         real       0m5.344s
 user    0m0.015s           user      0m0.015s         user       0m0.015s
 sys     0m0.015s           sys       0m0.015s         sys        0m0.031s

 real    0m11.703s          real      0m5.312s         real       0m5.390s
 user    0m0.015s           user      0m0.015s         user       0m0.031s
 sys     0m0.000s           sys       0m0.000s         sys        0m0.000s

 real    0m11.672s          real      0m5.359s         real       0m5.344s
 user    0m0.031s           user      0m0.015s         user       0m0.015s
 sys     0m0.000s           sys       0m0.015s         sys        0m0.016s

 -------------------------  -------------------------  -------------------------
 Command: git commit...     Command: git commit...     Command: git commit...
 (single file)              (single file)              (single file)
 -------------------------  -------------------------  -------------------------

 real    0m14.234s          real      0m7.969s         real       0m7.875s
 user    0m0.015s           user      0m0.015s         user       0m0.015s
 sys     0m0.000s           sys       0m0.016s         sys        0m0.000s

 compat/mingw.c    |   52 ++++++++++++++++++++++++++++++++++++++++++++--------
 git-compat-util.h |    5 +++++
 2 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 7711a3f..207378c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -23,19 +23,52 @@ int fchmod(int fildes, mode_t mode)
 	return -1;
 }

-int lstat(const char *file_name, struct stat *buf)
+static inline time_t filetime_to_time_t(const FILETIME *ft)
+{
+	long long winTime = ((long long)ft->dwHighDateTime << 32) + ft->dwLowDateTime;
+	winTime -= 116444736000000000LL; /* Windows to Unix Epoch conversion */
+	winTime /= 10000000;		 /* Nano to seconds resolution */
+	return (time_t)winTime;
+}
+
+extern int _getdrive( void );
+int git_lstat(const char *file_name, struct stat *buf)
 {
 	int namelen;
 	static char alt_name[PATH_MAX];
-
-	if (!stat(file_name, buf))
+	char* ext;
+	WIN32_FILE_ATTRIBUTE_DATA fdata;
+
+	if (GetFileAttributesExA(file_name, GetFileExInfoStandard, &fdata)) {
+		int fMode = S_IREAD;
+		if (fdata.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
+			fMode |= S_IFDIR;
+		else {
+			fMode |= S_IFREG;
+		ext = strrchr(file_name, '.');
+		if (ext && (!_stricmp(ext, ".exe") ||
+			    !_stricmp(ext, ".com") ||
+			    !_stricmp(ext, ".bat") ||
+			    !_stricmp(ext, ".cmd")))
+			fMode |= S_IEXEC;
+		}
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
 		return 0;
+	}
+	errno = ENOENT;

-	/* if file_name ended in a '/', Windows returned ENOENT;
-	 * try again without trailing slashes
-	 */
-	if (errno != ENOENT)
-		return -1;
 	namelen = strlen(file_name);
 	if (namelen && file_name[namelen-1] != '/')
 		return -1;
@@ -47,6 +80,9 @@ int lstat(const char *file_name, struct stat *buf)
 	alt_name[namelen] = 0;
 	return stat(alt_name, buf);
 }
+int git_stat(const char *file_name, struct stat *buf) {
+    return git_lstat(file_name, buf);
+}

 /* missing: link, mkstemp, fchmod, getuid (?), gettimeofday */
 int socketpair(int d, int type, int protocol, int sv[2])
diff --git a/git-compat-util.h b/git-compat-util.h
index 1ba499f..de1f062 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -488,6 +488,11 @@ int mingw_rename(const char*, const char*);
 extern void quote_argv(const char **dst, const char **src);
 extern const char *parse_interpreter(const char *cmd);

+/* Make git on Windows use git_lstat and git_stat instead of lstat and stat */
+int git_lstat(const char *file_name, struct stat *buf);
+int git_stat(const char *file_name, struct stat *buf);
+#define lstat(x,y) git_lstat(x,y)
+#define stat(x,y) git_stat(x,y)
 #endif /* __MINGW32__ */

 #endif
--
mingw.v1.5.2.4.1311.g376df-dirty
