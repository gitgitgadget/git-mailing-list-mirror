From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH] Add a new lstat implementation based on Win32 API, and make
 stat use that implementation too.
Date: Sun, 02 Sep 2007 21:31:40 +0200
Message-ID: <46DB0F9C.2090306@trolltech.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <200709022016.54262.johannes.sixt@telecom.at> <46DB0478.8050402@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 02 21:32:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRvB8-0006o7-MQ
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 21:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbXIBTbr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 15:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752431AbXIBTbr
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 15:31:47 -0400
Received: from esparsett.troll.no ([62.70.27.18]:46661 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbXIBTbq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 15:31:46 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id B944774226; Sun,  2 Sep 2007 21:31:44 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	by esparsett.troll.no (Postfix) with ESMTP
	id 811A67421D; Sun,  2 Sep 2007 21:31:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <46DB0478.8050402@trolltech.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57380>

This gives us a significant speedup when adding, committing and stat'ing files.
(Also, since Windows doesn't really handle symlinks, it's fine that stat just uses lstat)

Signed-off-by: Marius Storm-Olsen <mstormo_git@storm-olsen.com>
---
 Revision #2 of the patch.
 For this one I change the filetime_to_time_t function to do the
 timestamp conversion inline in the FILETIME struct. That way we
 also avoid one assignment, bitshifting and addition.
 Sneaky, huh? ;-)
 New stats:
    -------------------------
    Command: git init
    -------------------------

    real    0m0.047s
    user    0m0.031s
    sys     0m0.000s

    -------------------------
    Command: git add .
    -------------------------

    real    0m12.016s
    user    0m0.015s
    sys     0m0.000s

    -------------------------
    Command: git commit -a...
    -------------------------

    real    0m17.031s
    user    0m0.015s
    sys     0m0.030s

    -------------------------
    3x Command: git-status
    -------------------------

    real    0m5.265s
    user    0m0.015s
    sys     0m0.015s

    real    0m5.297s
    user    0m0.015s
    sys     0m0.000s

    real    0m5.250s
    user    0m0.015s
    sys     0m0.016s

    -------------------------
    Command: git commit...
    (single file)
    -------------------------

    real    0m7.859s
    user    0m0.015s
    sys     0m0.015s


 compat/mingw.c    |   41 +++++++++++++++++++++++++++++++++--------
 git-compat-util.h |    4 ++++
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 7711a3f..86a1419 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -23,19 +23,44 @@ int fchmod(int fildes, mode_t mode)
 	return -1;
 }

-int lstat(const char *file_name, struct stat *buf)
+static inline time_t filetime_to_time_t(const FILETIME *ft)
+{
+	long long *winTime = (long long*)ft;
+	*winTime -= 116444736000000000LL; /* Windows to Unix Epoch conversion */
+	*winTime /= 10000000;		  /* Nano to seconds resolution */
+	return (time_t)ft->dwLowDateTime;
+}
+
+extern int _getdrive( void );
+int git_lstat(const char *file_name, struct stat *buf)
 {
 	int namelen;
 	static char alt_name[PATH_MAX];
-
-	if (!stat(file_name, buf))
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
diff --git a/git-compat-util.h b/git-compat-util.h
index 1ba499f..4122465 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -488,6 +488,10 @@ int mingw_rename(const char*, const char*);
 extern void quote_argv(const char **dst, const char **src);
 extern const char *parse_interpreter(const char *cmd);

+/* Make git on Windows use git_lstat instead of lstat and stat */
+int git_lstat(const char *file_name, struct stat *buf);
+#define lstat(x,y) git_lstat(x,y)
+#define stat(x,y) git_lstat(x,y)
 #endif /* __MINGW32__ */

 #endif
--
1.5.3.GIT-dirty
