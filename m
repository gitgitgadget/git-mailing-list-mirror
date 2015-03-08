From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH 1/2] configure: support HAVE_BSD_SYSCTL option
Date: Sat,  7 Mar 2015 23:14:36 -0800
Message-ID: <e85cd4def375e8247ab210983e44e75@74d39fa044aa309eaea14b9f57fe79c>
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 08:14:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUVQO-0004vc-SZ
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 08:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbbCHHOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 03:14:46 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:38691 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbbCHHOq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 03:14:46 -0400
Received: by pdbfl12 with SMTP id fl12so55563276pdb.5
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 23:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ejY72DGN3wjNZbCia8f5grVp1Thh/gkULf0jQRBF5Qk=;
        b=SRNt4uzaq+gZIGsfPEw1j8UTYQD5Y/xPfV4uLMdA0xGpc6PHSSq+WAvtEnSWsfaTN8
         mUd2JQXd6/VXybLyHSpbuWR2LBKd4IfL3WeEi1Y6eyWG26Zpc7LA+S/5AZVPUQkDxgHK
         WMMci+aI9c68XLo/x7/870YoNKPyGaC3x99AcpL5S6t8alBm29xMLXweoDOPsT1Pxjum
         zKz9jIECb6jw3bhBarasWYuKIXHqqOVncm9Z8fFUY36mBLj5ET/hmjqrZJ+g3ygHXIpG
         gGeqe0gzYUzWYZIKLtZcDU6O2PICzHEDcyw1yPH+fj/j583GI8XVVH81J90CrHvRh702
         HLyg==
X-Received: by 10.68.69.75 with SMTP id c11mr39527784pbu.137.1425798885344;
        Sat, 07 Mar 2015 23:14:45 -0800 (PST)
Received: from localhost.localdomain ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id rx1sm14067028pbc.5.2015.03.07.23.14.44
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 07 Mar 2015 23:14:44 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265033>

On BSD-compatible systems some information such as the number
of available CPUs may only be available via the sysctl function.

Add support for a HAVE_BSD_SYSCTL option complete with autoconf
support and include the sys/syctl.h header when the option is
enabled to make the sysctl function available.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 Makefile          |  6 ++++++
 config.mak.uname  |  5 +++++
 configure.ac      | 23 +++++++++++++++++++++++
 git-compat-util.h |  3 +++
 4 files changed, 37 insertions(+)

diff --git a/Makefile b/Makefile
index 44f1dd10..5f3987fe 100644
--- a/Makefile
+++ b/Makefile
@@ -357,6 +357,8 @@ all::
 # and define it to "no" if you need to remove the parentheses () around the
 # constant.  The default is "auto", which means to use parentheses if your
 # compiler is detected to support it.
+#
+# Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl function.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1431,6 +1433,10 @@ ifdef HAVE_CLOCK_MONOTONIC
 	BASIC_CFLAGS += -DHAVE_CLOCK_MONOTONIC
 endif
 
+ifdef HAVE_BSD_SYSCTL
+	BASIC_CFLAGS += -DHAVE_BSD_SYSCTL
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
diff --git a/config.mak.uname b/config.mak.uname
index b64b63c3..f4e77cb9 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -107,6 +107,7 @@ ifeq ($(uname_S),Darwin)
 	COMPAT_OBJS += compat/precompose_utf8.o
 	BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
 	BASIC_CFLAGS += -DPROTECT_HFS_DEFAULT=1
+	HAVE_BSD_SYSCTL = YesPlease
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
@@ -199,6 +200,7 @@ ifeq ($(uname_S),FreeBSD)
 	PYTHON_PATH = /usr/local/bin/python
 	HAVE_PATHS_H = YesPlease
 	GMTIME_UNRELIABLE_ERRORS = UnfortunatelyYes
+	HAVE_BSD_SYSCTL = YesPlease
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
@@ -208,6 +210,7 @@ ifeq ($(uname_S),OpenBSD)
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
 	HAVE_PATHS_H = YesPlease
+	HAVE_BSD_SYSCTL = YesPlease
 endif
 ifeq ($(uname_S),MirBSD)
 	NO_STRCASESTR = YesPlease
@@ -215,6 +218,7 @@ ifeq ($(uname_S),MirBSD)
 	USE_ST_TIMESPEC = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	HAVE_PATHS_H = YesPlease
+	HAVE_BSD_SYSCTL = YesPlease
 endif
 ifeq ($(uname_S),NetBSD)
 	ifeq ($(shell expr "$(uname_R)" : '[01]\.'),2)
@@ -225,6 +229,7 @@ ifeq ($(uname_S),NetBSD)
 	USE_ST_TIMESPEC = YesPlease
 	NO_MKSTEMPS = YesPlease
 	HAVE_PATHS_H = YesPlease
+	HAVE_BSD_SYSCTL = YesPlease
 endif
 ifeq ($(uname_S),AIX)
 	DEFAULT_PAGER = more
diff --git a/configure.ac b/configure.ac
index 55e5a9b3..bbdde85c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1046,6 +1046,29 @@ GIT_CONF_SUBST([NO_INITGROUPS])
 #
 # Define NO_ICONV if your libc does not properly support iconv.
 
+AC_DEFUN([BSD_SYSCTL_SRC], [
+AC_LANG_PROGRAM([[
+#include <stddef.h>
+#include <sys/types.h>
+#include <sys/sysctl.h>
+]],[[
+int val, mib[2];
+size_t len;
+mib[0] = CTL_HW;
+mib[1] = 1;
+len = sizeof(val);
+return sysctl(mib, 2, &val, &len, NULL, 0) ? 1 : 0;
+]])])
+
+#
+# Define HAVE_BSD_SYSCTL=YesPlease if a BSD-compatible sysctl function is available.
+AC_MSG_CHECKING([for BSD sysctl])
+AC_COMPILE_IFELSE([BSD_SYSCTL_SRC],
+	[AC_MSG_RESULT([yes])
+	HAVE_BSD_SYSCTL=YesPlease],
+	[AC_MSG_RESULT([no])
+	HAVE_BSD_SYSCTL=])
+GIT_CONF_SUBST([HAVE_BSD_SYSCTL])
 
 ## Other checks.
 # Define USE_PIC if you need the main git objects to be built with -fPIC
diff --git a/git-compat-util.h b/git-compat-util.h
index a3095be9..50691d3c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -127,6 +127,9 @@
 #else
 #include <poll.h>
 #endif
+#ifdef HAVE_BSD_SYSCTL
+#include <sys/sysctl.h>
+#endif
 
 #if defined(__MINGW32__)
 /* pull in Windows compatibility stuff */
---
