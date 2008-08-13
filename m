From: Giovanni Funchal <gafunchal@gmail.com>
Subject: [PATCH] Add tests for "-R" and "-Wl,-rpath," switches in configure script.
Date: Wed, 13 Aug 2008 17:16:14 +0200
Message-ID: <1218640574-13181-1-git-send-email-gafunchal@gmail.com>
Cc: gafunchal@gmail.com, matthieu.moy@imag.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 17:17:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTI6C-0005rP-He
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 17:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbYHMPQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 11:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752788AbYHMPQR
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 11:16:17 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:62954 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbYHMPQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 11:16:16 -0400
Received: by fg-out-1718.google.com with SMTP id 19so46071fgg.17
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=3BwRlY914pZdRMu4JsfT6sOe7UyXKYoXx2akdYbeLx8=;
        b=XkvUCCHWvhzMS8XQeuf7ygOLcYG3hx9Jz35iWir1Q1ShL7JNkpnfTg1NvYafhmNUxr
         LSoIz/2qsjxqiSpENugqETdR+ckgmsBxdY3KliWGYVAGnVbC1mwh+khDhjkJgWRjqJ+0
         2vYH5vBatiOb78tyxZ3yqITiXvbv2bMD63BP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=apsWVoHXMRPuI1KQj9Hjc0THlxUXvUDKp1c7mpqvYriNqf23bE96hrrCJsWDRzpMMN
         aLa6Pa3e6hBf/VWEVSOejxY93pgjIFqhqpGpM2NzFqctrubK6NuwWQeM3qWh7Bx7mHz+
         IZ14GyGi+HCYDHwfjCPfTsJwjUKmuW6XVlib0=
Received: by 10.86.70.3 with SMTP id s3mr110086fga.51.1218640574538;
        Wed, 13 Aug 2008 08:16:14 -0700 (PDT)
Received: from localhost.localdomain ( [85.69.129.210])
        by mx.google.com with ESMTPS id 4sm1182413fge.5.2008.08.13.08.16.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Aug 2008 08:16:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc2.36.g4b1b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92228>

Add tests for "-R" and "-Wl,-rpath," switches in configure script.
Replace NO_R_TO_GCC_LINKER and CC_LD_DYNPATH by USE_RUNPATH and RUNPATH_SWITCH which have different semantics.
Add a warning if user must set LD_LIBRARY_PATH manually.

Signed-Off-By: Giovanni Funchal <gafunchal@gmail.com>
---
 Makefile      |   66 ++++++++++++++++++++++++++++++++++++++++----------------
 config.mak.in |    2 +
 configure.ac  |   28 ++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 90c5a13..aa9a6a5 100644
--- a/Makefile
+++ b/Makefile
@@ -111,9 +111,10 @@ all::
 #
 # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
 #
-# Define NO_R_TO_GCC_LINKER if your gcc does not like "-R/path/lib"
-# that tells runtime paths to dynamic libraries;
-# "-Wl,-rpath=/path/lib" is used instead.
+# USE_RUNPATH and RUNPATH_SWITCH define if and how to pass the runtime
+# dynamic library paths to the linker. The default is "-Wl,-rpath,". If
+# you don't use runpath, you will always need to set LD_LIBRARY_PATH
+# manually before running git.
 #
 # Define USE_NSEC below if you want git to care about sub-second file mtimes
 # and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
@@ -217,6 +218,7 @@ GITWEB_SITE_FOOTER =
 
 export prefix bindir sharedir htmldir sysconfdir
 
+# defaults, possibly overridden by config.mak.autogen
 CC = gcc
 AR = ar
 RM = rm -f
@@ -226,6 +228,8 @@ INSTALL = install
 RPMBUILD = rpmbuild
 TCL_PATH = tclsh
 TCLTK_PATH = wish
+USE_RUNPATH = yes
+RUNPATH_SWITCH = -Wl,-rpath,
 
 export TCL_PATH TCLTK_PATH
 
@@ -689,7 +693,6 @@ ifeq ($(uname_S),NetBSD)
 	endif
 	BASIC_CFLAGS += -I/usr/pkg/include
 	BASIC_LDFLAGS += -L/usr/pkg/lib
-	ALL_LDFLAGS += -Wl,-rpath,/usr/pkg/lib
 endif
 ifeq ($(uname_S),AIX)
 	NO_STRCASESTR=YesPlease
@@ -766,6 +769,13 @@ endif
 -include config.mak.autogen
 -include config.mak
 
+ifeq ($(uname_S),NetBSD) # must go after the 'include'
+	ifeq ($(USE_RUNPATH),no)
+		ADD_RUNPATH += /usr/pkg/lib
+	else
+		ALL_LDFLAGS += $(RUNPATH_SWITCH)/usr/pkg/lib
+	endif
+endif
 ifeq ($(uname_S),Darwin)
 	ifndef NO_FINK
 		ifeq ($(shell test -d /sw/lib && echo y),y)
@@ -781,24 +791,19 @@ ifeq ($(uname_S),Darwin)
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
-		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
 		BASIC_CFLAGS += -I$(CURLDIR)/include
-		CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -lcurl
-	else
-		CURL_LIBCURL = -lcurl
+		CURL_LIBCURL = -L$(CURLDIR)/$(lib)
+		ifeq ($(USE_RUNPATH),no)
+			ADD_RUNPATH += $(CURLDIR)/$(lib)
+		else
+			CURL_LIBCURL += $(RUNPATH_SWITCH)$(CURLDIR)/$(lib)
+		endif
 	endif
+	CURL_LIBCURL += -lcurl
 	BUILTIN_OBJS += builtin-http-fetch.o
 	EXTLIBS += $(CURL_LIBCURL)
 	LIB_OBJS += http.o http-walker.o
@@ -815,7 +820,12 @@ endif
 
 ifdef ZLIB_PATH
 	BASIC_CFLAGS += -I$(ZLIB_PATH)/include
-	EXTLIBS += -L$(ZLIB_PATH)/$(lib) $(CC_LD_DYNPATH)$(ZLIB_PATH)/$(lib)
+	ifeq ($(USE_RUNPATH),no)
+		ADD_RUNPATH += $(ZLIB_PATH)/$(lib)
+		EXTLIBS += -L$(ZLIB_PATH)/$(lib)
+	else
+		EXTLIBS += -L$(ZLIB_PATH)/$(lib) $(RUNPATH_SWITCH)$(ZLIB_PATH)/$(lib)
+	endif
 endif
 EXTLIBS += -lz
 
@@ -828,7 +838,12 @@ ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
 	ifdef OPENSSLDIR
 		BASIC_CFLAGS += -I$(OPENSSLDIR)/include
-		OPENSSL_LINK = -L$(OPENSSLDIR)/$(lib) $(CC_LD_DYNPATH)$(OPENSSLDIR)/$(lib)
+		OPENSSL_LINK = -L$(OPENSSLDIR)/$(lib)
+		ifeq ($(USE_RUNPATH),no)
+			ADD_RUNPATH += $(OPENSSLDIR)/$(lib)
+		else
+			OPENSSL_LINK += $(RUNPATH_SWITCH)$(OPENSSLDIR)/$(lib)
+		endif
 	else
 		OPENSSL_LINK =
 	endif
@@ -845,7 +860,12 @@ endif
 ifdef NEEDS_LIBICONV
 	ifdef ICONVDIR
 		BASIC_CFLAGS += -I$(ICONVDIR)/include
-		ICONV_LINK = -L$(ICONVDIR)/$(lib) $(CC_LD_DYNPATH)$(ICONVDIR)/$(lib)
+		ICONV_LINK = -L$(ICONVDIR)/$(lib)
+		ifeq ($(USE_RUNPATH),no)
+			ADD_RUNPATH += $(ICONVDIR)/$(lib)
+		else
+			ICONV_LINK = $(RUNPATH_SWITCH)$(ICONVDIR)/$(lib)
+		endif
 	else
 		ICONV_LINK =
 	endif
@@ -1027,6 +1047,9 @@ endif
 ifdef ASCIIDOC8
 	export ASCIIDOC8
 endif
+ifdef ADD_RUNPATH
+	export ADD_RUNPATH
+endif
 
 # Shell quote (do not use $(call) to accommodate ancient setups);
 
@@ -1075,6 +1098,11 @@ endif
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' all
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1)
 
+ifeq ($(USE_RUNPATH),no)
+all::
+	@echo WARNING: Remember to add $(ADD_RUNPATH) to your LD_LIBRARY_PATH before execution!
+endif
+
 please_set_SHELL_PATH_to_a_more_modern_shell:
 	@$$(:)
 
diff --git a/config.mak.in b/config.mak.in
index b776149..f01be45 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -7,6 +7,8 @@ AR = @AR@
 TAR = @TAR@
 #INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
 TCLTK_PATH = @TCLTK_PATH@
+USE_RUNPATH = @USE_RUNPATH@
+RUNPATH_SWITCH = @RUNPATH_SWITCH@
 
 prefix = @prefix@
 exec_prefix = @exec_prefix@
diff --git a/configure.ac b/configure.ac
index 7c2856e..c589cbc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -103,6 +103,34 @@ GIT_PARSE_WITH(tcltk))
 AC_MSG_NOTICE([CHECKS for programs])
 #
 AC_PROG_CC([cc gcc])
+# linker support for setting runtime path to dynamic libraries
+AC_CACHE_VAL(git_cv_use_runpath, [
+   AC_CACHE_CHECK([[if linker supports -R]], git_cv_ld_dashr, [
+      SAVE_LDFLAGS="${LDFLAGS}"
+      LDFLAGS="${SAVE_LDFLAGS} -R /"
+      AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [git_cv_ld_dashr=yes], [git_cv_ld_dashr=no])
+      LDFLAGS="${SAVE_LDFLAGS}"
+   ])
+   if test "$git_cv_ld_dashr" = "yes"; then
+      git_cv_use_runpath=yes
+      AC_SUBST(RUNPATH_SWITCH, [-R])
+   else
+      AC_CACHE_CHECK([[if linker supports -Wl,rpath,]], git_cv_ld_wl_rpath, [
+         SAVE_LDFLAGS="${LDFLAGS}"
+         LDFLAGS="${SAVE_LDFLAGS} -Wl,-rpath,/"
+         AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [git_cv_ld_wl_rpath=yes], [git_cv_ld_wl_rpath=no])
+         LDFLAGS="${SAVE_LD_FLAGS}"
+      ])
+      if test "$ld_wl_rpath" = "yes"; then
+         git_cv_use_runpath=yes
+         AC_SUBST(RUNPATH_SWITCH, [-Wl,-rpath,])
+      else
+         git_cv_use_runpath=no
+         AC_MSG_WARN([linker does not support runtime path to dynamic libraries])
+      fi
+   fi
+])
+AC_SUBST(USE_RUNPATH, $git_cv_use_runpath)
 #AC_PROG_INSTALL		# needs install-sh or install.sh in sources
 AC_CHECK_TOOLS(AR, [gar ar], :)
 AC_CHECK_PROGS(TAR, [gtar tar])
-- 
1.5.4.3
