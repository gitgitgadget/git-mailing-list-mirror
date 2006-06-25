From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Git.pm: Support for perl/ being built by a different compiler
Date: Sun, 25 Jun 2006 03:47:03 +0200
Message-ID: <20060625014703.29304.12715.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 25 03:47:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJiQ-00056b-2z
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWFYBrH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWFYBrH
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:47:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:30938 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751290AbWFYBrF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 21:47:05 -0400
Received: (qmail 29314 invoked from network); 25 Jun 2006 03:47:03 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 25 Jun 2006 03:47:03 +0200
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22565>

dst_ on #git reported that on Solaris 9, Perl was built by Sun CC
and perl/ is therefore being built with it as well, while the rest
of Git is built with gcc. The problem (the first one visible, anyway)
is that we passed perl/ even various gcc-specific options. This
separates those to a special variable.

This is not really meant for an application yet since it's not clear
if it will alone help anything.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Makefile |   66 ++++++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/Makefile b/Makefile
index 4f0a501..6755f26 100644
--- a/Makefile
+++ b/Makefile
@@ -115,6 +115,11 @@ SPARSE_FLAGS = -D__BIG_ENDIAN__ -D__powe
 
 ### --- END CONFIGURATION SECTION ---
 
+# Those must not be GNU-specific; they are shared with perl/ which may
+# be built by a different compiler.
+BASIC_CFLAGS =
+BASIC_LDFLAGS =
+
 SCRIPT_SH = \
 	git-bisect.sh git-branch.sh git-checkout.sh \
 	git-cherry.sh git-clean.sh git-clone.sh git-commit.sh \
@@ -249,13 +254,13 @@ ifeq ($(uname_S),Darwin)
 	NEEDS_LIBICONV = YesPlease
 	## fink
 	ifeq ($(shell test -d /sw/lib && echo y),y)
-		ALL_CFLAGS += -I/sw/include
-		ALL_LDFLAGS += -L/sw/lib
+		BASIC_CFLAGS += -I/sw/include
+		BASIC_LDFLAGS += -L/sw/lib
 	endif
 	## darwinports
 	ifeq ($(shell test -d /opt/local/lib && echo y),y)
-		ALL_CFLAGS += -I/opt/local/include
-		ALL_LDFLAGS += -L/opt/local/lib
+		BASIC_CFLAGS += -I/opt/local/include
+		BASIC_LDFLAGS += -L/opt/local/lib
 	endif
 endif
 ifeq ($(uname_S),SunOS)
@@ -274,7 +279,7 @@ ifeq ($(uname_S),SunOS)
 	endif
 	INSTALL = ginstall
 	TAR = gtar
-	ALL_CFLAGS += -D__EXTENSIONS__
+	BASIC_CFLAGS += -D__EXTENSIONS__
 endif
 ifeq ($(uname_O),Cygwin)
 	NO_D_TYPE_IN_DIRENT = YesPlease
@@ -291,21 +296,22 @@ ifeq ($(uname_O),Cygwin)
 endif
 ifeq ($(uname_S),FreeBSD)
 	NEEDS_LIBICONV = YesPlease
-	ALL_CFLAGS += -I/usr/local/include
-	ALL_LDFLAGS += -L/usr/local/lib
+	BASIC_CFLAGS += -I/usr/local/include
+	BASIC_LDFLAGS += -L/usr/local/lib
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
 	NEEDS_LIBICONV = YesPlease
-	ALL_CFLAGS += -I/usr/local/include
-	ALL_LDFLAGS += -L/usr/local/lib
+	BASIC_CFLAGS += -I/usr/local/include
+	BASIC_LDFLAGS += -L/usr/local/lib
 endif
 ifeq ($(uname_S),NetBSD)
 	ifeq ($(shell expr "$(uname_R)" : '[01]\.'),2)
 		NEEDS_LIBICONV = YesPlease
 	endif
-	ALL_CFLAGS += -I/usr/pkg/include
-	ALL_LDFLAGS += -L/usr/pkg/lib -Wl,-rpath,/usr/pkg/lib
+	BASIC_CFLAGS += -I/usr/pkg/include
+	BASIC_LDFLAGS += -L/usr/pkg/lib
+	ALL_LDFLAGS += -Wl,-rpath,/usr/pkg/lib
 endif
 ifeq ($(uname_S),AIX)
 	NO_STRCASESTR=YesPlease
@@ -317,9 +323,9 @@ ifeq ($(uname_S),IRIX64)
 	NO_STRCASESTR=YesPlease
 	NO_SOCKADDR_STORAGE=YesPlease
 	SHELL_PATH=/usr/gnu/bin/bash
-	ALL_CFLAGS += -DPATH_MAX=1024
+	BASIC_CFLAGS += -DPATH_MAX=1024
 	# for now, build 32-bit version
-	ALL_LDFLAGS += -L/usr/lib32
+	BASIC_LDFLAGS += -L/usr/lib32
 endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
@@ -340,7 +346,7 @@ endif
 ifndef NO_CURL
 	ifdef CURLDIR
 		# This is still problematic -- gcc does not always want -R.
-		ALL_CFLAGS += -I$(CURLDIR)/include
+		BASIC_CFLAGS += -I$(CURLDIR)/include
 		CURL_LIBCURL = -L$(CURLDIR)/lib -R$(CURLDIR)/lib -lcurl
 	else
 		CURL_LIBCURL = -lcurl
@@ -361,13 +367,13 @@ ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
 	ifdef OPENSSLDIR
 		# Again this may be problematic -- gcc does not always want -R.
-		ALL_CFLAGS += -I$(OPENSSLDIR)/include
+		BASIC_CFLAGS += -I$(OPENSSLDIR)/include
 		OPENSSL_LINK = -L$(OPENSSLDIR)/lib -R$(OPENSSLDIR)/lib
 	else
 		OPENSSL_LINK =
 	endif
 else
-	ALL_CFLAGS += -DNO_OPENSSL
+	BASIC_CFLAGS += -DNO_OPENSSL
 	MOZILLA_SHA1 = 1
 	OPENSSL_LIBSSL =
 endif
@@ -379,7 +385,7 @@ endif
 ifdef NEEDS_LIBICONV
 	ifdef ICONVDIR
 		# Again this may be problematic -- gcc does not always want -R.
-		ALL_CFLAGS += -I$(ICONVDIR)/include
+		BASIC_CFLAGS += -I$(ICONVDIR)/include
 		ICONV_LINK = -L$(ICONVDIR)/lib -R$(ICONVDIR)/lib
 	else
 		ICONV_LINK =
@@ -395,13 +401,13 @@ ifdef NEEDS_NSL
 	SIMPLE_LIB += -lnsl
 endif
 ifdef NO_D_TYPE_IN_DIRENT
-	ALL_CFLAGS += -DNO_D_TYPE_IN_DIRENT
+	BASIC_CFLAGS += -DNO_D_TYPE_IN_DIRENT
 endif
 ifdef NO_D_INO_IN_DIRENT
-	ALL_CFLAGS += -DNO_D_INO_IN_DIRENT
+	BASIC_CFLAGS += -DNO_D_INO_IN_DIRENT
 endif
 ifdef NO_SYMLINK_HEAD
-	ALL_CFLAGS += -DNO_SYMLINK_HEAD
+	BASIC_CFLAGS += -DNO_SYMLINK_HEAD
 endif
 ifdef NO_STRCASESTR
 	COMPAT_CFLAGS += -DNO_STRCASESTR
@@ -420,13 +426,13 @@ ifdef NO_MMAP
 	COMPAT_OBJS += compat/mmap.o
 endif
 ifdef NO_IPV6
-	ALL_CFLAGS += -DNO_IPV6
+	BASIC_CFLAGS += -DNO_IPV6
 endif
 ifdef NO_SOCKADDR_STORAGE
 ifdef NO_IPV6
-	ALL_CFLAGS += -Dsockaddr_storage=sockaddr_in
+	BASIC_CFLAGS += -Dsockaddr_storage=sockaddr_in
 else
-	ALL_CFLAGS += -Dsockaddr_storage=sockaddr_in6
+	BASIC_CFLAGS += -Dsockaddr_storage=sockaddr_in6
 endif
 endif
 ifdef NO_INET_NTOP
@@ -434,7 +440,7 @@ ifdef NO_INET_NTOP
 endif
 
 ifdef NO_ICONV
-	ALL_CFLAGS += -DNO_ICONV
+	BASIC_CFLAGS += -DNO_ICONV
 endif
 
 ifdef PPC_SHA1
@@ -458,7 +464,7 @@ ifdef USE_PIC
 	ALL_CFLAGS += -fPIC
 endif
 ifdef NO_ACCURATE_DIFF
-	ALL_CFLAGS += -DNO_ACCURATE_DIFF
+	BASIC_CFLAGS += -DNO_ACCURATE_DIFF
 endif
 
 # Shell quote (do not use $(call) to accomodate ancient setups);
@@ -478,8 +484,12 @@ GIT_PYTHON_DIR_SQ = $(subst ','\'',$(GIT
 
 LIBS = $(GITLIBS) $(EXTLIBS)
 
-ALL_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' $(COMPAT_CFLAGS)
+BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' $(COMPAT_CFLAGS)
 LIB_OBJS += $(COMPAT_OBJS)
+
+ALL_CFLAGS += $(BASIC_CFLAGS)
+ALL_LDFLAGS += $(BASIC_LDFLAGS)
+
 export prefix TAR INSTALL DESTDIR SHELL_PATH template_dir
 
 
@@ -608,9 +618,9 @@ XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare
 	rm -f $@ && $(AR) rcs $@ $(XDIFF_OBJS)
 
 
-PERL_DEFINE = $(ALL_CFLAGS) -DGIT_VERSION='"$(GIT_VERSION)"'
+PERL_DEFINE = $(BASIC_CFLAGS) -DGIT_VERSION='"$(GIT_VERSION)"'
 PERL_DEFINE_SQ = $(subst ','\'',$(PERL_DEFINE))
-PERL_LIBS = $(EXTLIBS)
+PERL_LIBS = $(BASIC_LDFLAGS) $(EXTLIBS)
 PERL_LIBS_SQ = $(subst ','\'',$(PERL_LIBS))
 perl/Makefile:	perl/Git.pm perl/Makefile.PL GIT-CFLAGS
 	(cd perl && $(PERL_PATH) Makefile.PL \
