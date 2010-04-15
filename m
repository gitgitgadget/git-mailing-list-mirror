From: Chris Webb <chris@arachsys.com>
Subject: [PATCH v4] Replace hard-coded path with one from <paths.h>
Date: Thu, 15 Apr 2010 14:21:45 +0100
Message-ID: <81fdf71bae0e4d2abdae5740056b7fffb7683c54.1271337404.git.chris@arachsys.com>
References: <20100406163643.GG15306@arachsys.com>
 <m3hbncgaxu.fsf@localhost.localdomain>
 <20100415124043.GH12365@arachsys.com>
 <201004151458.02156.jnareb@gmail.com>
 <20100415130101.GJ12365@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, kusmabite@gmail.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 15:21:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2P13-0001Oh-2Y
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 15:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab0DONVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 09:21:51 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:51755 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab0DONVu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 09:21:50 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1O2P0t-0003LR-Ar; Thu, 15 Apr 2010 14:21:48 +0100
Content-Disposition: inline
In-Reply-To: <20100415130101.GJ12365@arachsys.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144984>

In exec_cmd.c, git hard-codes a default path of /usr/local/bin:/usr/bin:/bin.
Get an appropriate value for the system from <paths.h> if possible instead. We
only try to include <paths.h> on Linux, FreeBSD, NetBSD, OpenBSD and GNU where
it is known to exist.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 Makefile          |   13 +++++++++++++
 exec_cmd.c        |    2 +-
 git-compat-util.h |    7 +++++++
 3 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 910f471..81aa2ba 100644
--- a/Makefile
+++ b/Makefile
@@ -31,6 +31,9 @@ all::
 # Define EXPATDIR=/foo/bar if your expat header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
 #
+# Define HAVE_PATHS_H if you have paths.h and want to use the default PATH
+# it specifies.
+#
 # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
 #
 # Define NO_D_TYPE_IN_DIRENT if your platform defines DT_UNKNOWN but lacks
@@ -735,10 +738,12 @@ EXTLIBS =
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
@@ -867,6 +872,7 @@ ifeq ($(uname_S),FreeBSD)
 		NO_STRTOUMAX = YesPlease
 	endif
 	PYTHON_PATH = /usr/local/bin/python
+	HAVE_PATHS_H = YesPlease
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
@@ -875,6 +881,7 @@ ifeq ($(uname_S),OpenBSD)
 	NEEDS_LIBICONV = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
+	HAVE_PATHS_H = YesPlease
 endif
 ifeq ($(uname_S),NetBSD)
 	ifeq ($(shell expr "$(uname_R)" : '[01]\.'),2)
@@ -884,6 +891,7 @@ ifeq ($(uname_S),NetBSD)
 	BASIC_LDFLAGS += -L/usr/pkg/lib $(CC_LD_DYNPATH)/usr/pkg/lib
 	USE_ST_TIMESPEC = YesPlease
 	NO_MKSTEMPS = YesPlease
+	HAVE_PATHS_H = YesPlease
 endif
 ifeq ($(uname_S),AIX)
 	NO_STRCASESTR=YesPlease
@@ -904,6 +912,7 @@ ifeq ($(uname_S),GNU)
 	# GNU/Hurd
 	NO_STRLCPY=YesPlease
 	NO_MKSTEMPS = YesPlease
+	HAVE_PATHS_H = YesPlease
 endif
 ifeq ($(uname_S),IRIX)
 	NO_SETENV = YesPlease
@@ -1353,6 +1362,10 @@ else
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
index 7e62b55..92c2182 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -164,6 +164,13 @@ extern char *gitbasename(char *);
 #define PATH_SEP ':'
 #endif
 
+#ifdef HAVE_PATHS_H
+#include <paths.h>
+#endif
+#ifndef _PATH_DEFPATH
+#define _PATH_DEFPATH "/usr/local/bin:/usr/bin:/bin"
+#endif
+
 #ifndef STRIP_EXTENSION
 #define STRIP_EXTENSION ""
 #endif
-- 
1.7.0.3
