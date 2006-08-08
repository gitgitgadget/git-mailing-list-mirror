From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/4] autoconf: Move variables which we always set to config.mak.in
Date: Tue, 8 Aug 2006 18:39:06 +0200
Message-ID: <200608081839.07112.jnareb@gmail.com>
References: <200608081834.09271.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 08 18:39:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAUbp-0003Ns-Iz
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 18:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWHHQjA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 12:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWHHQi7
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 12:38:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:17796 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964986AbWHHQi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 12:38:58 -0400
Received: by nf-out-0910.google.com with SMTP id q29so224914nfc
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 09:38:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=X5I+Vgt6qXmhB0tFUuqZs36ON6HDpyAEUmv1ZtBBlQPMquVOMx3G/ezy+XjPSiW+KzD+wNERXGxXVFnB12W4iXrisy92zKhJaZX+7WmVDZXcNI69NA6VwG9Kyk4WcjoC0ZKe73Bo1mFxTCL4/EFcK/cRvxU7M5B52zq8+l5AKc0=
Received: by 10.48.210.20 with SMTP id i20mr498472nfg;
        Tue, 08 Aug 2006 09:38:57 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id x24sm1001701nfb.2006.08.08.09.38.56;
        Tue, 08 Aug 2006 09:38:57 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608081834.09271.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25076>

Move detected NO_STH and NEED_STH variables, which we always output,
either setting or unsetting (setting to empty string) to config.mak.in
and use setting appropriately named variables and doing AC_SUBST
instead of adding them via GIT_CONF_APPEND_LINE macro and
config.mak.append temporary file.

Variables which might and might not be set are still added via
config.mak.append; this include all STH_PATH variables.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This makes our configure.ac more typical.

 config.mak.in |   15 +++++++++++
 configure.ac  |   75 +++++++++++++++++++++++++++++++++------------------------
 2 files changed, 59 insertions(+), 31 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 04f508a..99b13a7 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -22,3 +22,18 @@ VPATH = @srcdir@
 export exec_prefix mandir
 export srcdir VPATH
 
+NO_PYTHON=@NO_PYTHON@
+NEEDS_SSL_WITH_CRYPTO=@NEEDS_SSL_WITH_CRYPTO@
+NO_CURL=@NO_CURL@
+NO_EXPAT=@NO_EXPAT@
+NEEDS_LIBICONV=@NEEDS_LIBICONV@
+NEEDS_SOCKET=@NEEDS_SOCKET@
+NO_D_INO_IN_DIRENT=@NO_D_INO_IN_DIRENT@
+NO_D_TYPE_IN_DIRENT=@NO_D_TYPE_IN_DIRENT@
+NO_SOCKADDR_STORAGE=@NO_SOCKADDR_STORAGE@
+NO_IPV6=@NO_IPV6@
+NO_C99_FORMAT=@NO_C99_FORMAT@
+NO_STRCASESTR=@NO_STRCASESTR@
+NO_STRLCPY=@NO_STRLCPY@
+NO_SETENV=@NO_SETENV@
+
diff --git a/configure.ac b/configure.ac
index c27a994..bc2824b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -149,7 +149,6 @@ if test -z "$NO_PYTHON"; then
 		NO_PYTHON=""
 	fi
 fi
-GIT_CONF_APPEND_LINE([NO_PYTHON=@NO_PYTHON@])
 
 
 ## Checks for libraries.
@@ -158,35 +157,41 @@ #
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lcrypto with -lssl (Darwin).
 AC_CHECK_LIB([crypto], [SHA1_Init],
-[GIT_CONF_APPEND_LINE(NEEDS_SSL_WITH_CRYPTO=)],
+[NEEDS_SSL_WITH_CRYPTO=],
 [AC_CHECK_LIB([ssl], [SHA1_Init],
- [GIT_CONF_APPEND_LINE(NEEDS_SSL_WITH_CRYPTO=YesPlease)
-  GIT_CONF_APPEND_LINE(NEEDS_SSL_WITH_CRYPTO=)],
- [GIT_CONF_APPEND_LINE(NO_OPENSSL=YesPlease)])])
+ [NEEDS_SSL_WITH_CRYPTO=YesPlease
+  NEEDS_SSL_WITH_CRYPTO=],
+ [NO_OPENSSL=YesPlease])])
+AC_SUBST(NEEDS_SSL_WITH_CRYPTO)
+AC_SUBST(NO_OPENSSL)
 #
 # Define NO_CURL if you do not have curl installed.  git-http-pull and
 # git-http-push are not built, and you cannot use http:// and https://
 # transports.
 AC_CHECK_LIB([curl], [curl_global_init],
-[GIT_CONF_APPEND_LINE(NO_CURL=)],
-[GIT_CONF_APPEND_LINE(NO_CURL=YesPlease)])
+[NO_CURL=],
+[NO_CURL=YesPlease])
+AC_SUBST(NO_CURL)
 #
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
 # not built, and you cannot push using http:// and https:// transports.
 AC_CHECK_LIB([expat], [XML_ParserCreate],
-[GIT_CONF_APPEND_LINE(NO_EXPAT=)],
-[GIT_CONF_APPEND_LINE(NO_EXPAT=YesPlease)])
+[NO_EXPAT=],
+[NO_EXPAT=YesPlease])
+AC_SUBST(NO_EXPAT)
 #
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
 AC_CHECK_LIB([c], [iconv],
-[GIT_CONF_APPEND_LINE(NEEDS_LIBICONV=)],
-[GIT_CONF_APPEND_LINE(NEEDS_LIBICONV=YesPlease)])
+[NEEDS_LIBICONV=],
+[NEEDS_LIBICONV=YesPlease])
+AC_SUBST(NEEDS_LIBICONV)
 #
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
 # Patrick Mauritz).
 AC_CHECK_LIB([c], [socket],
-[GIT_CONF_APPEND_LINE(NEEDS_SOCKET=)],
-[GIT_CONF_APPEND_LINE(NEEDS_SOCKET=YesPlease)])
+[NEEDS_SOCKET=],
+[NEEDS_SOCKET=YesPlease])
+AC_SUBST(NEEDS_SOCKET)
 
 
 ## Checks for header files.
@@ -197,33 +202,38 @@ AC_MSG_NOTICE([CHECKS for typedefs, stru
 #
 # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
 AC_CHECK_MEMBER(struct dirent.d_ino,
-[GIT_CONF_APPEND_LINE(NO_D_INO_IN_DIRENT=)],
-[GIT_CONF_APPEND_LINE(NO_D_INO_IN_DIRENT=YesPlease)],
+[NO_D_INO_IN_DIRENT=],
+[NO_D_INO_IN_DIRENT=YesPlease],
 [#include <dirent.h>])
+AC_SUBST(NO_D_INO_IN_DIRENT)
 #
 # Define NO_D_TYPE_IN_DIRENT if your platform defines DT_UNKNOWN but lacks
 # d_type in struct dirent (latest Cygwin -- will be fixed soonish).
 AC_CHECK_MEMBER(struct dirent.d_type,
-[GIT_CONF_APPEND_LINE(NO_D_TYPE_IN_DIRENT=)],
-[GIT_CONF_APPEND_LINE(NO_D_TYPE_IN_DIRENT=YesPlease)],
+[NO_D_TYPE_IN_DIRENT=],
+[NO_D_TYPE_IN_DIRENT=YesPlease],
 [#include <dirent.h>])
+AC_SUBST(NO_D_TYPE_IN_DIRENT)
 #
 # Define NO_SOCKADDR_STORAGE if your platform does not have struct
 # sockaddr_storage.
 AC_CHECK_TYPE(struct sockaddr_storage,
-[GIT_CONF_APPEND_LINE(NO_SOCKADDR_STORAGE=)],
-[GIT_CONF_APPEND_LINE(NO_SOCKADDR_STORAGE=YesPlease)],
+[NO_SOCKADDR_STORAGE=],
+[NO_SOCKADDR_STORAGE=YesPlease],
 [#include <netinet/in.h>])
+AC_SUBST(NO_SOCKADDR_STORAGE)
+#
 # Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
 AC_CHECK_TYPE([struct addrinfo],[
  AC_CHECK_FUNC([getaddrinfo],
-  [GIT_CONF_APPEND_LINE(NO_IPV6=)],
-  [GIT_CONF_APPEND_LINE(NO_IPV6=YesPlease)])
-],[GIT_CONF_APPEND_LINE(NO_IPV6=YesPlease)],[
+  [NO_IPV6=],
+  [NO_IPV6=YesPlease])
+],[NO_IPV6=YesPlease],[
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <netdb.h>
 ])
+AC_SUBST(NO_IPV6)
 #
 # Define NO_C99_FORMAT if your formatted IO functions (printf/scanf et.al.)
 # do not support the 'size specifiers' introduced by C99, namely ll, hh,
@@ -243,11 +253,11 @@ AC_RUN_IFELSE(
 	[ac_cv_c_c99_format=no])
 ])
 if test $ac_cv_c_c99_format = no; then
-	GIT_CONF_APPEND_LINE(NO_C99_FORMAT=YesPlease)
+	NO_C99_FORMAT=YesPlease
 else
-	GIT_CONF_APPEND_LINE(NO_C99_FORMAT=)
+	NO_C99_FORMAT=
 fi
-
+AC_SUBST(NO_C99_FORMAT)
 
 ## Checks for library functions.
 ## (in default C library and libraries checked by AC_CHECK_LIB)
@@ -255,18 +265,21 @@ AC_MSG_NOTICE([CHECKS for library functi
 #
 # Define NO_STRCASESTR if you don't have strcasestr.
 AC_CHECK_FUNC(strcasestr,
-[GIT_CONF_APPEND_LINE(NO_STRCASESTR=)],
-[GIT_CONF_APPEND_LINE(NO_STRCASESTR=YesPlease)])
+[NO_STRCASESTR=],
+[NO_STRCASESTR=YesPlease])
+AC_SUBST(NO_STRCASESTR)
 #
 # Define NO_STRLCPY if you don't have strlcpy.
 AC_CHECK_FUNC(strlcpy,
-[GIT_CONF_APPEND_LINE(NO_STRLCPY=)],
-[GIT_CONF_APPEND_LINE(NO_STRLCPY=YesPlease)])
+[NO_STRLCPY=],
+[NO_STRLCPY=YesPlease])
+AC_SUBST(NO_STRLCPY)
 #
 # Define NO_SETENV if you don't have setenv in the C library.
 AC_CHECK_FUNC(setenv,
-[GIT_CONF_APPEND_LINE(NO_SETENV=)],
-[GIT_CONF_APPEND_LINE(NO_SETENV=YesPlease)])
+[NO_SETENV=],
+[NO_SETENV=YesPlease])
+AC_SUBST(NO_SETENV)
 #
 # Define NO_MMAP if you want to avoid mmap.
 #
-- 
1.4.1.1
