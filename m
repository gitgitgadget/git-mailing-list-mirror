From: "Giovanni Funchal" <gafunchal@gmail.com>
Subject: Patch for NO_R_TO_GCC_LINKER
Date: Wed, 13 Aug 2008 12:42:30 +0200
Message-ID: <c475e2e60808130342r452fae1cm7d08d8d2206d0468@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 12:43:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTDpJ-0006as-Cd
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 12:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbYHMKmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 06:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752991AbYHMKmd
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 06:42:33 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:60872 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbYHMKmc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 06:42:32 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2670902fkq.5
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 03:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=01O+Bm9RB5WUe8pMg9UCXS4FRbVkroJnDo/rtv7pt84=;
        b=SolOGwh8twa37KZhwHxnuwAbjZJ1HmZdG7sHnb6W3qV00yG4iBJY9lKyO0ipL0UPW8
         QDF9gwdGCFtFRgHVGWpBh5nChcJraLUOyHUacqcosWi4BoVKI8fIp5d7MHy/fZJF1KuI
         yN26dcPz4y5QdYE/zpRDYmr6jnyzf9TFs3YTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=E5l+1u/uSAmWQJWtbJNCsKSSgZpSlTIUe607S+9rmBFcT1v90YwOoz9OrvQnZvqkBH
         qaGttNLqF5z1IAhZZoccq9UxfPmYlS7DemBoWsWRlDcFtGDMAcTylZ9QDxNVn3W6+xeP
         HeWfo1l3GM2tPvk8Hc/0bWE3r5Yjx5tYioRvU=
Received: by 10.187.179.4 with SMTP id g4mr1068657fap.25.1218624150393;
        Wed, 13 Aug 2008 03:42:30 -0700 (PDT)
Received: by 10.187.245.17 with HTTP; Wed, 13 Aug 2008 03:42:30 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92208>

Hi,

I'm proposing the patch below to add a check for linker's runtime
dynamic library patch switch in configure script.

What was broken? Try $ ./configure --prefix=/usr --with-curl=/usr and
you will see messages like "cc: unrecognized option '-R/usr/lib'. This
is just a message, it is NOT an error nor a warning. This can cause
wrong versions of curl and other libraries to be linked with git, and
produce very very strange results!

The patch include tests for "-R" and "-Wl,-rpath," switches in
configure script and an error message if tests fail. Makefile is
better, no more NO_R_TO_GCC_LINKER option. The default switch is now
"-Wl,-rpath," (which is the most common one).

I tested it on ubuntu gcc 4.2.3

-- Giovanni

diff --git a/Makefile b/Makefile
index 90c5a13..6e20b08 100644
--- a/Makefile
+++ b/Makefile
@@ -111,9 +111,8 @@ all::
 #
 # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
 #
-# Define NO_R_TO_GCC_LINKER if your gcc does not like "-R/path/lib"
-# that tells runtime paths to dynamic libraries;
-# "-Wl,-rpath=/path/lib" is used instead.
+# LD_RUNPATH_SWITCH specifies how to pass the runtime dynamic library paths
+# to the linker. The default is "-Wl,-rpath,".
 #
 # Define USE_NSEC below if you want git to care about sub-second file mtimes
 # and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
@@ -217,6 +216,7 @@ GITWEB_SITE_FOOTER =

 export prefix bindir sharedir htmldir sysconfdir

+# defaults, possibly overridden by config.mak.autogen
 CC = gcc
 AR = ar
 RM = rm -f
@@ -226,7 +226,8 @@ INSTALL = install
 RPMBUILD = rpmbuild
 TCL_PATH = tclsh
 TCLTK_PATH = wish
-
+LD_RUNPATH_SWITCH = -Wl,-rpath,
+
 export TCL_PATH TCLTK_PATH

 # sparse is architecture-neutral, which means that we need to tell it
@@ -689,7 +690,7 @@ ifeq ($(uname_S),NetBSD)
 	endif
 	BASIC_CFLAGS += -I/usr/pkg/include
 	BASIC_LDFLAGS += -L/usr/pkg/lib
-	ALL_LDFLAGS += -Wl,-rpath,/usr/pkg/lib
+	ALL_LDFLAGS += $(LD_RUNPATH_SWITCH)/usr/pkg/lib
 endif
 ifeq ($(uname_S),AIX)
 	NO_STRCASESTR=YesPlease
@@ -781,21 +782,13 @@ ifeq ($(uname_S),Darwin)
 	endif
 endif

-ifdef NO_R_TO_GCC_LINKER
-	# Some gcc does not accept and pass -R to the linker to specify
-	# the runtime dynamic library path.
-	CC_LD_DYNPATH = -Wl,-rpath=
-else
-	CC_LD_DYNPATH = -R
-endif
-
 ifdef NO_CURL
 	BASIC_CFLAGS += -DNO_CURL
 else
 	ifdef CURLDIR
 		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
 		BASIC_CFLAGS += -I$(CURLDIR)/include
-		CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -lcurl
+		CURL_LIBCURL = -L$(CURLDIR)/$(lib)
$(LD_RUNPATH_SWITCH)$(CURLDIR)/$(lib) -lcurl
 	else
 		CURL_LIBCURL = -lcurl
 	endif
@@ -815,7 +808,7 @@ endif

 ifdef ZLIB_PATH
 	BASIC_CFLAGS += -I$(ZLIB_PATH)/include
-	EXTLIBS += -L$(ZLIB_PATH)/$(lib) $(CC_LD_DYNPATH)$(ZLIB_PATH)/$(lib)
+	EXTLIBS += -L$(ZLIB_PATH)/$(lib) $(LD_RUNPATH_SWITCH)$(ZLIB_PATH)/$(lib)
 endif
 EXTLIBS += -lz

@@ -828,7 +821,7 @@ ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
 	ifdef OPENSSLDIR
 		BASIC_CFLAGS += -I$(OPENSSLDIR)/include
-		OPENSSL_LINK = -L$(OPENSSLDIR)/$(lib) $(CC_LD_DYNPATH)$(OPENSSLDIR)/$(lib)
+		OPENSSL_LINK = -L$(OPENSSLDIR)/$(lib)
$(LD_RUNPATH_SWITCH)$(OPENSSLDIR)/$(lib)
 	else
 		OPENSSL_LINK =
 	endif
@@ -845,7 +838,7 @@ endif
 ifdef NEEDS_LIBICONV
 	ifdef ICONVDIR
 		BASIC_CFLAGS += -I$(ICONVDIR)/include
-		ICONV_LINK = -L$(ICONVDIR)/$(lib) $(CC_LD_DYNPATH)$(ICONVDIR)/$(lib)
+		ICONV_LINK = -L$(ICONVDIR)/$(lib) $(LD_RUNPATH_SWITCH)$(ICONVDIR)/$(lib)
 	else
 		ICONV_LINK =
 	endif
diff --git a/config.mak.in b/config.mak.in
index b776149..8a20ffe 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -7,6 +7,7 @@ AR = @AR@
 TAR = @TAR@
 #INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
 TCLTK_PATH = @TCLTK_PATH@
+LD_RUNPATH_SWITCH = @ld_runpath_switch@

 prefix = @prefix@
 exec_prefix = @exec_prefix@
diff --git a/configure.ac b/configure.ac
index 7c2856e..5debbbf 100644
--- a/configure.ac
+++ b/configure.ac
@@ -103,6 +103,28 @@ GIT_PARSE_WITH(tcltk))
 AC_MSG_NOTICE([CHECKS for programs])
 #
 AC_PROG_CC([cc gcc])
+# which switch to pass runtime path to dynamic libraries to the linker
+AC_CACHE_CHECK([if linker supports -R], ld_dashr, [
+   SAVE_LDFLAGS="${LDFLAGS}"
+   LDFLAGS="${SAVE_LDFLAGS} -R /"
+   AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [ld_dashr=yes], [ld_dashr=no])
+   LDFLAGS="${SAVE_LDFLAGS}"
+])
+if test "$ld_dashr" = "yes"; then
+   AC_SUBST(ld_runpath_switch, [-R])
+else
+   AC_CACHE_CHECK([if linker supports -Wl,rpath,], ld_wl_rpath, [
+      SAVE_LDFLAGS="${LDFLAGS}"
+      LDFLAGS="${SAVE_LDFLAGS} -Wl,-rpath,/"
+      AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [ld_wl_rpath=yes],
[ld_wl_rpath=no])
+      LDFLAGS="${SAVE_LD_FLAGS}"
+   ])
+   if test "$ld_wl_rpath" = "yes"; then
+      AC_SUBST(ld_runpath_switch, [-Wl,-rpath,])
+   else
+      AC_MSG_ERROR([no linker support for runtime path to dynamic libraries])
+   fi
+fi
 #AC_PROG_INSTALL		# needs install-sh or install.sh in sources
 AC_CHECK_TOOLS(AR, [gar ar], :)
 AC_CHECK_PROGS(TAR, [gtar tar])
