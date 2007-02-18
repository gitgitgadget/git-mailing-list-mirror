From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH] New autoconf test for iconv
Date: Sun, 18 Feb 2007 09:44:42 +0100
Message-ID: <20070218084442.6418.73657.stgit@c165>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 18 10:05:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIhzG-00026x-99
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 10:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161197AbXBRJFd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 04:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161209AbXBRJFd
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 04:05:33 -0500
Received: from mxfep04.bredband.com ([195.54.107.79]:39368 "EHLO
	mxfep04.bredband.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161206AbXBRJF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 04:05:27 -0500
X-Greylist: delayed 1242 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Feb 2007 04:05:26 EST
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep04.bredband.com with ESMTP
          id <20070218084443.TGJA2732.mxfep04.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Sun, 18 Feb 2007 09:44:43 +0100
Received: from c-6466e455.09-360-6c6b701.cust.bredbandsbolaget.se (HELO c165) ([85.228.102.100])
  by ironport.bredband.com with ESMTP; 18 Feb 2007 09:44:43 +0100
Received: from c165 ([127.0.0.1])
	by c165 with esmtp (Exim 3.36 #1 (Debian))
	id 1HIhf0-0001fd-00
	for <git@vger.kernel.org>; Sun, 18 Feb 2007 09:44:42 +0100
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40066>


On a Solaris machine I have access to libc contains the symbol
"iconv" but, when compiling with gcc and including iconv.h we get
iconv.h from GNU libiconv. This header file define (among other
things) "iconv" to "libiconv" and so on. 

In order to link with GNU libiconv we need -liconv. Currently we
test if the symbol "iconv" is in libc (which is true), then we get
a undefined reference error because we don't have libiconv_open.

The solution this patch implements is to compile and link a
small test program, instead of just checking if the libraries
(libc and libiconv) contains the symbol "iconv".

Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>

---

 configure.ac |   31 +++++++++++++++++++++++++------
 1 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7cfb3a0..3a8e778 100644
--- a/configure.ac
+++ b/configure.ac
@@ -114,13 +114,32 @@ AC_CHECK_LIB([expat], [XML_ParserCreate],
 [NO_EXPAT=YesPlease])
 AC_SUBST(NO_EXPAT)
 #
-# Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
+# Define NEEDS_LIBICONV if linking with libc is not enough (Darwin and
+# some Solaris installations).
 # Define NO_ICONV if neither libc nor libiconv support iconv.
-AC_CHECK_LIB([c], [iconv],
-	[NEEDS_LIBICONV=],
-	AC_CHECK_LIB([iconv], [iconv],
-		[NEEDS_LIBICONV=YesPlease],
-		[NO_ICONV=YesPlease]))
+AC_DEFUN([ICONVTEST_SRC], [
+#include <iconv.h>
+
+int main(void)
+{
+	iconv_open("", "");
+	return 0;
+}
+])
+AC_MSG_CHECKING([for iconv in -lc])
+AC_LINK_IFELSE(ICONVTEST_SRC,
+	[AC_MSG_RESULT([yes])
+	NEEDS_LIBICONV=],
+	[AC_MSG_RESULT([no])
+	old_LIBS="$LIBS"
+	LIBS="$LIBS -liconv"
+	AC_MSG_CHECKING([for iconv in -liconv])
+	AC_LINK_IFELSE(ICONVTEST_SRC,
+		[AC_MSG_RESULT([yes])
+		NEEDS_LIBICONV=YesPlease],
+		[AC_MSG_RESULT([no])
+		NO_ICONV=YesPlease])
+	LIBS="$old_LIBS"])
 AC_SUBST(NEEDS_LIBICONV)
 AC_SUBST(NO_ICONV)
 test -n "$NEEDS_LIBICONV" && LIBS="$LIBS -liconv"
