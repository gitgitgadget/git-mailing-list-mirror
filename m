From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH] Replacing the system call pread() with real mmap().
Date: Sun, 7 Jan 2007 12:17:12 +0100
Organization: -no organization-
Message-ID: <20070107111712.GB9909@scotty.home>
References: <20070106170330.GA8041@scotty.home> <20070107060007.GA10351@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 07 12:17:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3W1h-0001G8-QM
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 12:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbXAGLRT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 06:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbXAGLRT
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 06:17:19 -0500
Received: from moutng.kundenserver.de ([212.227.126.179]:58797 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932502AbXAGLRS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 06:17:18 -0500
Received: from [84.134.15.225] (helo=scotty.home)
	by mrelayeu.kundenserver.de (node=mrelayeu6) with ESMTP (Nemesis),
	id 0ML29c-1H3W1a3iEC-0007tf; Sun, 07 Jan 2007 12:17:16 +0100
Received: from scotty.home (localhost [127.0.0.1])
	by scotty.home (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l07BHDI3015627;
	Sun, 7 Jan 2007 12:17:13 +0100
Received: (from hs@localhost)
	by scotty.home (8.13.4/8.13.4/Submit) id l07BHCrC015623;
	Sun, 7 Jan 2007 12:17:12 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070107060007.GA10351@spearce.org>
X-Mailer: Mutt 1.5.6 http://www.mutt.org/
X-Editor: GNU Emacs 21.4.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: http://www.s-hahn.de/gpg-public-stefan.asc
X-GPG-key-ID/Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C F986 E4FC D563
User-Agent: Mutt/1.5.9i
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on scotty.home
X-Virus-Scanned: ClamAV 0.88.7/2418/Sun Jan  7 10:42:41 2007 on scotty.home
X-Virus-Status: Clean
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:77aa76da759ebc9bab1cc524fc813130
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36156>

Using cygwin with cygwin.dll before 1.5.22 the system call pread() is buggy.
This patch introduces NO_PREAD. If NO_MMAP is not set and NO_PREAD is set
git uses real mmap instead of pread.

Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
---

I made a patch for this problem replacing pread().

 Makefile          |    9 +++++++++
 compat/pread.c    |   16 ++++++++++++++++
 git-compat-util.h |    5 +++++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 180e1e0..4f928fd 100644
--- a/Makefile
+++ b/Makefile
@@ -69,6 +69,10 @@ all:
 #
 # Define NO_MMAP if you want to avoid mmap.
 #
+# Define NO_PREAD if you have a problem with pread() system call (i.e.
+# cygwin.dll before v1.5.22). This needs NO_MMAP not to be set, because pread()
+# is emulated using mmap.
+#
 # Define NO_FAST_WORKING_DIRECTORY if accessing objects in pack files is
 # generally faster on your platform than accessing the working directory.
 #
@@ -521,6 +525,11 @@ endif
 ifdef NO_MMAP
 	COMPAT_CFLAGS += -DNO_MMAP
 	COMPAT_OBJS += compat/mmap.o
+else
+ifdef NO_PREAD
+	COMPAT_CFLAGS += -DNO_PREAD
+	COMPAT_OBJS += compat/pread.o
+endif
 endif
 ifdef NO_FAST_WORKING_DIRECTORY
 	BASIC_CFLAGS += -DNO_FAST_WORKING_DIRECTORY
diff --git a/compat/pread.c b/compat/pread.c
new file mode 100644
index 0000000..23e775d
--- /dev/null
+++ b/compat/pread.c
@@ -0,0 +1,16 @@
+#include "../git-compat-util.h"
+
+ssize_t git_pread(int fd,void *buf,size_t count,off_t offset)
+{
+        unsigned pg_offset = offset % getpagesize();
+        unsigned char *map;
+
+        map = mmap(NULL, count + pg_offset, PROT_READ, MAP_PRIVATE,
+                   fd, offset - pg_offset);
+        if (map == MAP_FAILED)
+                return -1;
+
+        memcpy(buf, map + pg_offset, count);
+        munmap(map, count + pg_offset);
+        return count;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index 5d9eb26..413e7e8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -96,6 +96,11 @@ extern int git_munmap(void *start, size_t length);
 
 #include <sys/mman.h>
 
+#ifdef NO_PREAD
+#define pread git_pread
+extern ssize_t git_pread(int fd,void *buf,size_t count,off_t offset);
+#endif
+
 #endif /* NO_MMAP */
 
 #ifdef NO_SETENV
-- 
1.5.0.rc0.g244a7
