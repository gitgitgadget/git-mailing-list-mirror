From: Chris Webb <chris@arachsys.com>
Subject: [PATCH v3] Replace hard-coded path with one from <paths.h>
Date: Tue, 13 Apr 2010 10:07:13 +0100
Message-ID: <20100413090713.GC770@arachsys.com>
References: <20100404222801.GB31315@arachsys.com>
 <20100406163525.GF15306@arachsys.com>
 <20100406163643.GG15306@arachsys.com>
 <n2u40aa078e1004070357m143cfaccvdc754a3bc5fe1ae1@mail.gmail.com>
 <20100408105850.GD2146@arachsys.com>
 <m2x40aa078e1004080426u98fbe6b2zfa9a2726172f725@mail.gmail.com>
 <20100408115706.GE2077@arachsys.com>
 <z2o40aa078e1004080508z17c5e71by371bbe6e1cdb8c50@mail.gmail.com>
 <20100409054536.GB2151@arachsys.com>
 <20100413090604.GB770@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 13 11:07:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1c5d-0000ub-59
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 11:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307Ab0DMJHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 05:07:19 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:40346 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab0DMJHR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 05:07:17 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1O1c5R-0000d2-Mn; Tue, 13 Apr 2010 10:07:14 +0100
Content-Disposition: inline
In-Reply-To: <20100413090604.GB770@arachsys.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144799>

In exec_cmd.c, git hard-codes a default path of /usr/local/bin:/usr/bin:/bin.
Get an appropriate value for the system from <paths.h> if possible instead. We
only try to include <paths.h> on Linux, FreeBSD, NetBSD, OpenBSD and GNU where
it is known to exist.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 Makefile          |   10 ++++++++++
 exec_cmd.c        |    2 +-
 git-compat-util.h |    6 ++++++
 3 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 910f471..f4fe941 100644
--- a/Makefile
+++ b/Makefile
@@ -735,10 +735,12 @@ EXTLIBS =
 ifeq ($(uname_S),Linux)
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease
+	HAVE_PATHS_H = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease
+	HAVE_PATHS_H = YesPlease
 endif
 ifeq ($(uname_S),UnixWare)
 	CC = cc
@@ -867,6 +869,7 @@ ifeq ($(uname_S),FreeBSD)
 		NO_STRTOUMAX = YesPlease
 	endif
 	PYTHON_PATH = /usr/local/bin/python
+	HAVE_PATHS_H = YesPlease
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
@@ -875,6 +878,7 @@ ifeq ($(uname_S),OpenBSD)
 	NEEDS_LIBICONV = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
+	HAVE_PATHS_H = YesPlease
 endif
 ifeq ($(uname_S),NetBSD)
 	ifeq ($(shell expr "$(uname_R)" : '[01]\.'),2)
@@ -884,6 +888,7 @@ ifeq ($(uname_S),NetBSD)
 	BASIC_LDFLAGS += -L/usr/pkg/lib $(CC_LD_DYNPATH)/usr/pkg/lib
 	USE_ST_TIMESPEC = YesPlease
 	NO_MKSTEMPS = YesPlease
+	HAVE_PATHS_H = YesPlease
 endif
 ifeq ($(uname_S),AIX)
 	NO_STRCASESTR=YesPlease
@@ -904,6 +909,7 @@ ifeq ($(uname_S),GNU)
 	# GNU/Hurd
 	NO_STRLCPY=YesPlease
 	NO_MKSTEMPS = YesPlease
+	HAVE_PATHS_H = YesPlease
 endif
 ifeq ($(uname_S),IRIX)
 	NO_SETENV = YesPlease
@@ -1353,6 +1359,10 @@ else
 	LIB_OBJS += thread-utils.o
 endif
 
+ifdef HAVE_PATHS_H
+	BASIC_CFLAGS += -DHAVE_PATHS_H
+endif
+
 ifdef DIR_HAS_BSD_GROUP_SEMANTICS
 	COMPAT_CFLAGS += -DDIR_HAS_BSD_GROUP_SEMANTICS
 endif
diff --git a/exec_cmd.c b/exec_cmd.c
index b2c07c7..bf22570 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -107,7 +107,7 @@ void setup_path(void)
 	if (old_path)
 		strbuf_addstr(&new_path, old_path);
 	else
-		strbuf_addstr(&new_path, "/usr/local/bin:/usr/bin:/bin");
+		strbuf_addstr(&new_path, _PATH_DEFPATH);
 
 	setenv("PATH", new_path.buf, 1);
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 7e62b55..ed1accc 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -164,6 +164,12 @@ extern char *gitbasename(char *);
 #define PATH_SEP ':'
 #endif
 
+#ifdef HAVE_PATHS_H
+#include <paths.h>
+#else
+#define _PATH_DEFPATH "/usr/local/bin:/usr/bin:/bin"
+#endif
+
 #ifndef STRIP_EXTENSION
 #define STRIP_EXTENSION ""
 #endif
-- 
1.7.0.3
