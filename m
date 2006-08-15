From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH 5/6] On Solaris nanosleep() is not in libc but in librt
Date: Tue, 15 Aug 2006 11:01:29 +0200
Message-ID: <20060815090129.5223.17174.stgit@leonov.stosberg.net>
References: <20060815090031.5223.27458.stgit@leonov.stosberg.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Aug 15 11:01:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCunr-0001xX-51
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 11:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965304AbWHOJBf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 05:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965308AbWHOJBe
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 05:01:34 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:63423 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S932771AbWHOJBc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 05:01:32 -0400
Received: from leonov.stosberg.net (p213.54.74.221.tisdip.tiscali.de [213.54.74.221])
	by ncs.stosberg.net (Postfix) with ESMTP id 1C201AEBA002
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 11:01:27 +0200 (CEST)
Received: from leonov.stosberg.net (leonov.stosberg.net [127.0.0.1])
	by leonov.stosberg.net (Postfix) with ESMTP id C0101121739
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 11:01:29 +0200 (CEST)
To: git@vger.kernel.org
In-Reply-To: <20060815090031.5223.27458.stgit@leonov.stosberg.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25446>

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---

 Makefile      |   11 +++++++++--
 config.mak.in |    1 +
 configure.ac  |   10 ++++++++--
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 3cb6531..d352901 100644
--- a/Makefile
+++ b/Makefile
@@ -67,8 +67,10 @@ # Define NEEDS_SSL_WITH_CRYPTO if you ne
 #
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
 #
-# Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
-# Patrick Mauritz).
+# Define NEEDS_SOCKET if linking with libc is not enough for socket()
+# (SunOS, Patrick Mauritz).
+#
+# Define NEEDS_RT if linking with libc is not enough for nanosleep() (SunOS)
 #
 # Define NO_MMAP if you want to avoid mmap.
 #
@@ -336,6 +338,7 @@ endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
 	NEEDS_NSL = YesPlease
+	NEEDS_RT = YesPlease
 	SHELL_PATH = /bin/bash
 	NO_STRCASESTR = YesPlease
 	ifeq ($(uname_R),5.8)
@@ -479,6 +482,10 @@ ifdef NEEDS_NSL
 	EXTLIBS += -lnsl
 	SIMPLE_LIB += -lnsl
 endif
+ifdef NEEDS_RT
+	EXTLIBS += -lrt
+	SIMPLE_LIB += -lrt
+endif
 ifdef NO_D_TYPE_IN_DIRENT
 	BASIC_CFLAGS += -DNO_D_TYPE_IN_DIRENT
 endif
diff --git a/config.mak.in b/config.mak.in
index 369e611..038767e 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -29,6 +29,7 @@ NO_CURL=@NO_CURL@
 NO_EXPAT=@NO_EXPAT@
 NEEDS_LIBICONV=@NEEDS_LIBICONV@
 NEEDS_SOCKET=@NEEDS_SOCKET@
+NEEDS_RT=@NEEDS_RT@
 NO_D_INO_IN_DIRENT=@NO_D_INO_IN_DIRENT@
 NO_D_TYPE_IN_DIRENT=@NO_D_TYPE_IN_DIRENT@
 NO_SOCKADDR_STORAGE=@NO_SOCKADDR_STORAGE@
diff --git a/configure.ac b/configure.ac
index 36f9cd9..6f1d87a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -148,13 +148,19 @@ AC_CHECK_LIB([c], [iconv],
 [NEEDS_LIBICONV=YesPlease])
 AC_SUBST(NEEDS_LIBICONV)
 #
-# Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
-# Patrick Mauritz).
+# Define NEEDS_SOCKET if linking with libc is not enough for socket()
+# (SunOS, Patrick Mauritz).
 AC_CHECK_LIB([c], [socket],
 [NEEDS_SOCKET=],
 [NEEDS_SOCKET=YesPlease])
 AC_SUBST(NEEDS_SOCKET)
 test -n "$NEEDS_SOCKET" && LIBS="$LIBS -lsocket"
+#
+# Define NEEDS_RT if linking with libc is not enough for nanosleep (SunOS)
+AC_CHECK_LIB([c], [nanosleep],
+[NEEDS_RT=],
+[NEEDS_RT=YesPlease])
+AC_SUBST(NEEDS_RT)
 
 
 ## Checks for header files.
