From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Set errno to EEXIST if mkdir returns EACCES or EPERM
Date: Mon, 30 Jan 2006 20:38:39 +0100
Message-ID: <20060130193839.GA6575@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 20:39:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3erd-0003Fb-L9
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 20:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWA3Ti7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 14:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWA3Ti7
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 14:38:59 -0500
Received: from devrace.com ([198.63.210.113]:62472 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S964805AbWA3Ti6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2006 14:38:58 -0500
Received: from tigra.home (p54A06F63.dip.t-dialin.net [84.160.111.99])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k0UJcf1d048167;
	Mon, 30 Jan 2006 13:38:42 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1F3erH-0006um-00; Mon, 30 Jan 2006 20:38:39 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1F3erH-0001wk-6y; Mon, 30 Jan 2006 20:38:39 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15293>

... and the directory already exists. I.E. Cygwin is such
a case: mkdir fail for mounts which reference directly
to windows mounts ("drives").

---

The discussion, which ended up with this patch can be read
here: http://www.cygwin.com/ml/cygwin/2006-01/msg01276.html

BTW, there is this:
http://www.cygwin.com/ml/cygwin/2006-01/msg01380.html
So this patch will probably be not needed soon.

Still I post it just for reference, or in case someone
can't afford an upgrade.

 Makefile          |    8 ++++++++
 checkout-index.c  |    2 +-
 compat/mkdir.c    |   23 +++++++++++++++++++++++
 git-compat-util.h |    6 ++++++
 4 files changed, 38 insertions(+), 1 deletions(-)
 create mode 100644 compat/mkdir.c

c9f480f5d1e777cc0f4861e94c2449bd8c7cf73a
diff --git a/Makefile b/Makefile
index 2e95353..596c2d8 100644
--- a/Makefile
+++ b/Makefile
@@ -66,6 +66,9 @@ all:
 # Define USE_STDEV below if you want git to care about the underlying device
 # change being considered an inode change from the update-cache perspective.
 
+# Define FIX_MKDIR_ERRNO if your mkdir(2) does not always set errno to EEXIST
+# if it failed because of existing directory (notably Cygwin).
+
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL) ./GIT-VERSION-GEN
 -include GIT-VERSION-FILE
@@ -249,6 +252,7 @@ ifeq ($(uname_O),Cygwin)
 	# Try uncommenting this if you see things break -- YMMV.
 	# NO_MMAP = YesPlease
 	NO_IPV6 = YesPlease
+	FIX_MKDIR_ERRNO = YesPlease
 	X = .exe
 endif
 ifeq ($(uname_S),OpenBSD)
@@ -392,6 +396,10 @@ else
 endif
 endif
 endif
+ifdef FIX_MKDIR_ERRNO
+	COMPAT_CFLAGS += -DFIX_MKDIR_ERRNO
+	COMPAT_OBJS += compat/mkdir.o
+endif
 
 ALL_CFLAGS += -DSHA1_HEADER=$(call shellquote,$(SHA1_HEADER)) $(COMPAT_CFLAGS)
 LIB_OBJS += $(COMPAT_OBJS)
diff --git a/checkout-index.c b/checkout-index.c
index 53dd8cb..c5a6d6e 100644
--- a/checkout-index.c
+++ b/checkout-index.c
@@ -199,6 +199,6 @@ int main(int argc, char **argv)
 	if (0 <= newfd &&
 	    (write_cache(newfd, active_cache, active_nr) ||
 	     commit_index_file(&cache_file)))
-		die("Unable to write new cachefile");
+		die("Unable to write new cachefile: %s", strerror(errno));
 	return 0;
 }
diff --git a/compat/mkdir.c b/compat/mkdir.c
new file mode 100644
index 0000000..1c2260c
--- /dev/null
+++ b/compat/mkdir.c
@@ -0,0 +1,23 @@
+#include <unistd.h>
+#include <errno.h>
+#include <sys/stat.h>
+#include "../git-compat-util.h"
+#undef mkdir
+
+int gitmkdir(const char *dir, mode_t mode)
+{
+	int rc = mkdir(dir, mode);
+	if ( rc < 0 ) {
+		int e  = errno;
+		if ( EACCES == e || EPERM == e )
+		{
+			struct stat st;
+			if ( stat(dir, &st) == 0 )
+				errno = EEXIST;
+			else
+				errno = e;
+		}
+	}
+	return rc;
+}
+
diff --git a/git-compat-util.h b/git-compat-util.h
index f982b8e..9cf3aab 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -154,4 +154,10 @@ static inline int sane_case(int x, int h
 #ifndef MAXPATHLEN
 #define MAXPATHLEN 256
 #endif
+
+#ifdef FIX_MKDIR_ERRNO
+#define mkdir gitmkdir
+int gitmkdir(const char *dir, mode_t mode);
+#endif
+
 #endif
-- 
1.1.4.g7397-dirty
