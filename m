From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH] Replacing the system call pread() with lseek()/xread()/lseek() sequence.
Date: Tue,  9 Jan 2007 22:04:12 +0100
Message-ID: <13884.2552820735$1168376671@news.gmane.org>
References: 7v1wm4kl24.fsf@assigned-by-dhcp.cox.net <11683766523955-git-send-email->
X-From: git-owner@vger.kernel.org Tue Jan 09 22:04:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4O8q-0005IZ-6N
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 22:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbXAIVES (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 16:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbXAIVES
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 16:04:18 -0500
Received: from moutng.kundenserver.de ([212.227.126.174]:53096 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270AbXAIVER (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 16:04:17 -0500
Received: from [84.134.14.63] (helo=scotty.home)
	by mrelayeu.kundenserver.de (node=mrelayeu0) with ESMTP (Nemesis),
	id 0MKwh2-1H4O8j30c7-0004yt; Tue, 09 Jan 2007 22:04:14 +0100
Received: from scotty.home (localhost [127.0.0.1])
	by scotty.home (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l09L4CsB022652
	for <git@vger.kernel.org>; Tue, 9 Jan 2007 22:04:12 +0100
Received: (from hs@localhost)
	by scotty.home (8.13.4/8.13.4/Submit) id l09L4C3W022649
	for git@vger.kernel.org; Tue, 9 Jan 2007 22:04:12 +0100
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.4.gfa432
In-Reply-To: <11683766523955-git-send-email->
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED,INVALID_MSGID 
	autolearn=failed version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on scotty.home
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:77aa76da759ebc9bab1cc524fc813130
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36399>

From: Stefan-W. Hahn <stefan.hahn@s-hahn.de>

Using cygwin with cygwin.dll before 1.5.22 the system call pread() is buggy.
This patch introduces NO_PREAD. If NO_PREAD is set git uses a sequence of
lseek()/xread()/lseek() to emulate pread.

Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
---
 Makefile          |    7 +++++++
 compat/pread.c    |   18 ++++++++++++++++++
 git-compat-util.h |    5 +++++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 6c12bc6..43113e9 100644
--- a/Makefile
+++ b/Makefile
@@ -69,6 +69,9 @@ all:
 #
 # Define NO_MMAP if you want to avoid mmap.
 #
+# Define NO_PREAD if you have a problem with pread() system call (e.g.
+# cygwin.dll before v1.5.22).
+#
 # Define NO_FAST_WORKING_DIRECTORY if accessing objects in pack files is
 # generally faster on your platform than accessing the working directory.
 #
@@ -523,6 +526,10 @@ ifdef NO_MMAP
 	COMPAT_CFLAGS += -DNO_MMAP
 	COMPAT_OBJS += compat/mmap.o
 endif
+ifdef NO_PREAD
+	COMPAT_CFLAGS += -DNO_PREAD
+	COMPAT_OBJS += compat/pread.o
+endif
 ifdef NO_FAST_WORKING_DIRECTORY
 	BASIC_CFLAGS += -DNO_FAST_WORKING_DIRECTORY
 endif
diff --git a/compat/pread.c b/compat/pread.c
new file mode 100644
index 0000000..9183c05
--- /dev/null
+++ b/compat/pread.c
@@ -0,0 +1,18 @@
+#include "../git-compat-util.h"
+
+ssize_t git_pread(int fd, void *buf, size_t count, off_t offset)
+{
+        off_t current_offset;
+        ssize_t rc;
+
+        current_offset = lseek(fd, 0, SEEK_CUR);
+
+        if (lseek(fd, offset, SEEK_SET) < 0)
+                return -1;
+
+        rc=read_in_full(fd, buf, count);
+
+        if (current_offset != lseek(fd, current_offset, SEEK_SET))
+                return -1;
+        return rc;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index e023bf1..f8d46d5 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -107,6 +107,11 @@ extern int git_munmap(void *start, size_t length);
 #define DEFAULT_PACKED_GIT_LIMIT \
 	((1024L * 1024L) * (sizeof(void*) >= 8 ? 8192 : 256))
 
+#ifdef NO_PREAD
+#define pread git_pread
+extern ssize_t git_pread(int fd, void *buf, size_t count, off_t offset);
+#endif
+
 #ifdef NO_SETENV
 #define setenv gitsetenv
 extern int gitsetenv(const char *, const char *, int);
-- 
1.4.4.4.gfa432
