From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH] Improve accuracy of check for presence of deflateBound.
Date: Wed,  7 Nov 2007 14:11:49 +1100
Message-ID: <11944051093111-git-send-email-dsymonds@gmail.com>
Cc: git@vger.kernel.org,
	"Symonds; David Alan" <dasymond@nlp2.cs.usyd.edu.au>,
	David Symonds <dsymonds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 04:12:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpbL9-0004LB-EZ
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 04:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227AbXKGDMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 22:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754995AbXKGDMK
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 22:12:10 -0500
Received: from staff.cs.usyd.edu.au ([129.78.8.1]:59918 "helo
	staff.cs.usyd.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754880AbXKGDMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 22:12:09 -0500
Received: from serf10.cs.usyd.edu.au. [129.78.8.85] by serf8.cs.usyd.edu.au.; Wed, 07 Nov 2007 14:11:51 +0000
Received: from localhost.localdomain (laptop-dasymond-2.cs.usyd.edu.au [129.78.115.28])
	by serf10.cs.usyd.edu.au (8.12.8/8.12.8) with ESMTP id lA73BohU029823;
	Wed, 7 Nov 2007 14:11:50 +1100
X-Mailer: git-send-email 1.5.3.1
X-Spam-Checker-Version: SpamAssassin 3.0.1 (2004-10-22) on 
	serf8.cs.usyd.edu.au
X-Spam-Report-SoIT: * -2.8 ALL_TRUSTED Did not pass through any untrusted hosts
	*  0.2 UPPERCASE_25_50 message body is 25-50% uppercase
X-Spam-Flag-SoIT: No (Score=-2.6, required: 5.0)
X-Spam-Level-SoIT: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63768>

From: Symonds; David Alan <dasymond@nlp2.cs.usyd.edu.au>

ZLIB_VERNUM isn't defined in some zlib versions, so this patch does a proper
linking test in autoconf to see whether deflateBound exists in zlib.

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 Makefile      |    6 ++++++
 cache.h       |    2 +-
 config.mak.in |    1 +
 configure.ac  |   20 ++++++++++++++++++++
 4 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 1a81ef1..c8bcd1d 100644
--- a/Makefile
+++ b/Makefile
@@ -98,6 +98,8 @@ all::
 # Define OLD_ICONV if your library has an old iconv(), where the second
 # (input buffer pointer) parameter is declared with type (const char **).
 #
+# Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
+#
 # Define NO_R_TO_GCC_LINKER if your gcc does not like "-R/path/lib"
 # that tells runtime paths to dynamic libraries;
 # "-Wl,-rpath=/path/lib" is used instead.
@@ -663,6 +665,10 @@ ifdef OLD_ICONV
 	BASIC_CFLAGS += -DOLD_ICONV
 endif
 
+ifdef NO_DEFLATE_BOUND
+	BASIC_CFLAGS += -DNO_DEFLATE_BOUND
+endif
+
 ifdef PPC_SHA1
 	SHA1_HEADER = "ppc/sha1.h"
 	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
diff --git a/cache.h b/cache.h
index 830d2e0..a3b1a26 100644
--- a/cache.h
+++ b/cache.h
@@ -7,7 +7,7 @@
 #include SHA1_HEADER
 #include <zlib.h>
 
-#if ZLIB_VERNUM < 0x1200
+#if defined(NO_DEFLATE_BOUND)
 #define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
 #endif
 
diff --git a/config.mak.in b/config.mak.in
index a3032e3..776b805 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -38,3 +38,4 @@ NO_STRCASESTR=@NO_STRCASESTR@
 NO_STRLCPY=@NO_STRLCPY@
 NO_SETENV=@NO_SETENV@
 NO_ICONV=@NO_ICONV@
+NO_DEFLATE_BOUND=@NO_DEFLATE_BOUND@
diff --git a/configure.ac b/configure.ac
index ed7cc89..ab516db 100644
--- a/configure.ac
+++ b/configure.ac
@@ -182,6 +182,26 @@ AC_SUBST(NEEDS_LIBICONV)
 AC_SUBST(NO_ICONV)
 test -n "$NEEDS_LIBICONV" && LIBS="$LIBS -liconv"
 #
+# Define NO_DEFLATE_BOUND if deflateBound is missing from zlib.
+AC_DEFUN([ZLIBTEST_SRC], [
+#include <zlib.h>
+
+int main(void)
+{
+	deflateBound(0, 0);
+	return 0;
+}
+])
+AC_MSG_CHECKING([for deflateBound in -lz])
+old_LIBS="$LIBS"
+LIBS="$LIBS -lz"
+AC_LINK_IFELSE(ZLIBTEST_SRC,
+	[AC_MSG_RESULT([yes])],
+	[AC_MSG_RESULT([no])
+	NO_DEFLATE_BOUND=yes])
+LIBS="$old_LIBS"
+AC_SUBST(NO_DEFLATE_BOUND)
+#
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
 # Patrick Mauritz).
 AC_CHECK_LIB([c], [socket],
-- 
1.5.3.1
