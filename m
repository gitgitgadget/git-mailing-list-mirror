From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Actually support embedded Qt, make configuration code more robust
Date: Fri, 26 May 2006 22:27:35 -0400
Message-ID: <20060527022735.5879.58043.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 27 04:27:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjoWn-0003lh-7a
	for gcvg-git@gmane.org; Sat, 27 May 2006 04:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWE0C1j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 22:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWE0C1j
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 22:27:39 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:48312 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751768AbWE0C1i
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 22:27:38 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FjoWf-00066T-RC
	for git@vger.kernel.org; Fri, 26 May 2006 22:27:37 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.62)
	(envelope-from <proski@gnu.org>)
	id 1FjoWd-0001Ww-GY; Fri, 26 May 2006 22:27:35 -0400
To: Marco Costalba <mcostalba@gmail.com>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20829>

Add -DQWS and -fno-rtti flags for embedded Qt.

Don't add X11 flags for embedded Qt and threading specific flags for
non-multithreaded Qt.

Before checking for the Qt library, make sure it actually exists in the
Qt library path and not elsewhere.

Fix missing ";;" before "esac" (potentially non-portable).

Signed-off-by: Pavel Roskin <proski@gnu.org>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 config/gwqt.m4 |   40 ++++++++++++++++++++++++++--------------
 1 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/config/gwqt.m4 b/config/gwqt.m4
index 78bed1d..cccccfe 100644
--- a/config/gwqt.m4
+++ b/config/gwqt.m4
@@ -91,17 +91,19 @@ fi
 
 # Checking for possible dependencies of the Qt library
 gwqt_save_LDFLAGS="$LDFLAGS"
-QT_LIBS="$X_PRE_LIBS -lX11 $X_EXTRA_LIBS"
-AC_CHECK_LIB(pthread, pthread_exit, [QT_LIBS="-lpthread $QT_LIBS"])
+QT_LIBS_X="$X_PRE_LIBS -lX11 $X_EXTRA_LIBS"
+AC_CHECK_LIB(pthread, pthread_exit, [QT_LIBS_MT="-lpthread $QT_LIBS"])
 
 LDFLAGS="$LDFLAGS $X_LIBS"
-AC_CHECK_LIB(Xft, XftFontOpen, [QT_LIBS="-lXft $QT_LIBS"], , [$QT_LIBS])
+AC_CHECK_LIB(Xft, XftFontOpen, [QT_LIBS_X="-lXft $QT_LIBS_X"], , [$QT_LIBS_X])
 
 
 # Checking for the Qt library
 LDFLAGS="$LDFLAGS -L$QTLIBDIR"
 for i in qt-mt qt qte-mt qte qt-gl; do
-    AC_CHECK_LIB([$i], Get_Class, [qtlib="$i"; break], , [$QT_LIBS])
+    set X "$QTLIBDIR/lib$i."*
+    test "$[2]" = "$QTLIBDIR/lib$i.*" && continue
+    AC_CHECK_LIB([$i], main, [qtlib="$i"; break], , [$QT_LIBS_X $QT_LIBS_MT])
 done
 
 if test -z "$qtlib"; then
@@ -110,30 +112,40 @@ fi
 
 LDFLAGS="$gwqt_save_LDFLAGS"
 
-# Calculate QT_CPPFLAGS
+# Calculate QT_CPPFLAGS, QT_LDFLAGS and QT_LIBS
+QT_LIBS="-l$qtlib"
 case "$qtlib" in
-    *-mt) QT_CPPFLAGS="-D_REENTRANT -DQT_THREAD_SUPPORT";;
+    *-mt)
+	QT_CPPFLAGS="-D_REENTRANT -DQT_THREAD_SUPPORT"
+	QT_LIBS="$QT_LIBS $QT_LIBS_MT";;
 esac
 
+case "$qtlib" in
+    qte*)
+	QT_CPPFLAGS="-DQWS -fno-rtti";;
+    *)
+	QT_LIBS="$QT_LIBS $QT_LIBS_X"
+	QT_LDFLAGS="$X_LIBS";;
+esac
+
+# Add Qt include path
 if test "$QTINCDIR" != "/usr/include"; then
     QT_CPPFLAGS="-I$QTINCDIR $QT_CPPFLAGS"
 fi
-AC_MSG_NOTICE([QT_CPPFLAGS = $QT_CPPFLAGS])
-AC_SUBST(QT_CPPFLAGS)
 
-# Calculate QT_LDFLAGS
-QT_LDFLAGS="$X_LIBS"
+# Add Qt library path
 case "$QTLIBDIR" in
     /usr/lib) ;;
     /usr/lib64) ;;
     /usr/X11R6/lib) ;;
-    *) QT_LDFLAGS="$QT_LDFLAGS -L$QTLIBDIR";
+    *) QT_LDFLAGS="$QT_LDFLAGS -L$QTLIBDIR";;
 esac
+
+# Report the results
+AC_MSG_NOTICE([QT_CPPFLAGS = $QT_CPPFLAGS])
+AC_SUBST(QT_CPPFLAGS)
 AC_MSG_NOTICE([QT_LDFLAGS = $QT_LDFLAGS])
 AC_SUBST(QT_LDFLAGS)
-
-# Calculate QT_LIBS
-QT_LIBS="-l$qtlib $QT_LIBS"
 AC_MSG_NOTICE([QT_LIBS = $QT_LIBS])
 AC_SUBST(QT_LIBS)
 ])
