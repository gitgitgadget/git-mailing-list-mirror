From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 7] autoconf: Add support for setting CURLDIR, OPENSSLDIR, EXPATDIR
Date: Wed, 9 Aug 2006 02:15:10 +0200
Message-ID: <200608090215.10917.jnareb@gmail.com>
References: <200608081834.09271.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 09 02:15:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAbj7-0000n3-KV
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 02:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWHIAPI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 20:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbWHIAPH
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 20:15:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:34891 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030363AbWHIAPF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 20:15:05 -0400
Received: by nf-out-0910.google.com with SMTP id a4so20003nfc
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 17:14:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bx6HSlfJBJ5s9dpGcwnZaziHXOXSkcDVOVeF+V5Y7N3oD5ZxTn8zxpShkIUMF1bqd0MdSuTX1kMb7mbIzGMGmSFCddEeq/Gpmy7IPaEoGIm8BOmNqJhWHYg3wsoOlb36+NPHZMFC+DY7oGLn3mon0dfI8YvVzHDfwTAkZtG8MrI=
Received: by 10.49.8.1 with SMTP id l1mr772994nfi;
        Tue, 08 Aug 2006 17:14:58 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id c1sm568443nfe.2006.08.08.17.14.57;
        Tue, 08 Aug 2006 17:14:58 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608081834.09271.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25103>

Add support for --with-openssl=PATH and --without-openssl,
--with-curl=PATH and --without-curl, --with-expat=PATH and
--without-expat ./configure options, each setting or unsetting
appropriate NO_PACKAGE and if called with argument also PACKAGEDIR
(of which only CURLDIR is documented in Makefile)

All above options are supported as override to autodetection; more to
come in the same style (override to autodetection), so moved the bulk
of comments for site configuration down.

Needs review by someone well versed in autoconf and m4.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
With this patch current autoconf generated ./configure script can
do everything the first abandoned (rewritten) version could...
and much, much more.

 configure.ac |  158 +++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 101 insertions(+), 57 deletions(-)

diff --git a/configure.ac b/configure.ac
index bc2824b..ae56462 100644
--- a/configure.ac
+++ b/configure.ac
@@ -46,53 +46,29 @@ else \
 	fi; \
 fi; \
 ]) # GIT_CONF_APPEND_PATH
+#
+# GIT_PARSE_WITH(PACKAGE)
+# -----------------------
+# For use in AC_ARG_WITH action-if-found, for packages default ON.
+# * Set NO_PACKAGE=YesPlease for --without-PACKAGE
+# * Set PACKAGEDIR=PATH for --with-PACKAGE=PATH
+# * Unset NO_PACKAGE for --with-PACKAGE without ARG
+AC_DEFUN([GIT_PARSE_WITH],
+[PACKAGE=m4_toupper($1); \
+if test "$withval" = "no"; then \
+	m4_toupper(NO_$1)=YesPlease; \
+elif test "$withval" = "yes"; then \
+	m4_toupper(NO_$1)=; \
+else \
+	m4_toupper(NO_$1)=; \
+	GIT_CONF_APPEND_LINE(${PACKAGE}DIR=$withval); \
+fi \
+])# GIT_PARSE_WITH
 
 
-## Site configuration
+## Site configuration related to programs (before tests)
 ## --with-PACKAGE[=ARG] and --without-PACKAGE
 #
-# Define NO_SVN_TESTS if you want to skip time-consuming SVN interoperability
-# tests.  These tests take up a significant amount of the total test time
-# but are not needed unless you plan to talk to SVN repos.
-#
-# Define MOZILLA_SHA1 environment variable when running make to make use of
-# a bundled SHA1 routine coming from Mozilla. It is GPL'd and should be fast
-# on non-x86 architectures (e.g. PowerPC), while the OpenSSL version (default
-# choice) has very fast version optimized for i586.
-#
-# Define PPC_SHA1 environment variable when running make to make use of
-# a bundled SHA1 routine optimized for PowerPC.
-#
-# Define ARM_SHA1 environment variable when running make to make use of
-# a bundled SHA1 routine optimized for ARM.
-#
-# Define NO_OPENSSL environment variable if you do not have OpenSSL.
-# This also implies MOZILLA_SHA1.
-#
-# Define NO_CURL if you do not have curl installed.  git-http-pull and
-# git-http-push are not built, and you cannot use http:// and https://
-# transports.
-#
-# Define CURLDIR=/foo/bar if your curl header and library files are in
-# /foo/bar/include and /foo/bar/lib directories.
-#
-# Define NO_EXPAT if you do not have expat installed.  git-http-push is
-# not built, and you cannot push using http:// and https:// transports.
-#
-# Define NO_FINK if you are building on Darwin/Mac OS X, have Fink
-# installed in /sw, but don't want GIT to link against any libraries
-# installed there.  If defined you may specify your own (or Fink's)
-# include directories and library directories by defining CFLAGS
-# and LDFLAGS appropriately.
-#
-# Define NO_DARWIN_PORTS if you are building on Darwin/Mac OS X,
-# have DarwinPorts installed in /opt/local, but don't want GIT to
-# link against any libraries installed there.  If defined you may
-# specify your own (or DarwinPort's) include directories and
-# library directories by defining CFLAGS and LDFLAGS appropriately.
-#
-# Define NO_MMAP if you want to avoid mmap.
-#
 # Define SHELL_PATH to provide path to shell.
 GIT_ARG_SET_PATH(shell)
 #
@@ -114,20 +90,6 @@ AS_HELP_STRING([--no-python], [don't use
  ])
 AC_SUBST(NO_PYTHON)
 AC_SUBST(PYTHON_PATH)
-#
-## --enable-FEATURE[=ARG] and --disable-FEATURE
-# Define COLLISION_CHECK below if you believe that SHA1's
-# 1461501637330902918203684832716283019655932542976 hashes do not give you
-# sufficient guarantee that no collisions between objects will ever happen.
-#
-# Define USE_NSEC below if you want git to care about sub-second file mtimes
-# and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
-# it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
-# randomly break unless your underlying filesystem supports those sub-second
-# times (my ext3 doesn't).
-#
-# Define USE_STDEV below if you want git to care about the underlying device
-# change being considered an inode change from the update-cache perspective.
 
 
 ## Checks for programs.
@@ -259,6 +221,7 @@ else
 fi
 AC_SUBST(NO_C99_FORMAT)
 
+
 ## Checks for library functions.
 ## (in default C library and libraries checked by AC_CHECK_LIB)
 AC_MSG_NOTICE([CHECKS for library functions])
@@ -299,6 +262,87 @@ # Define NO_ACCURATE_DIFF if your diff p
 # a missing newline at the end of the file.
 
 
+## Site configuration (override autodetection)
+## --with-PACKAGE[=ARG] and --without-PACKAGE
+AC_MSG_NOTICE([CHECKS for site configuration])
+#
+# Define NO_SVN_TESTS if you want to skip time-consuming SVN interoperability
+# tests.  These tests take up a significant amount of the total test time
+# but are not needed unless you plan to talk to SVN repos.
+#
+# Define MOZILLA_SHA1 environment variable when running make to make use of
+# a bundled SHA1 routine coming from Mozilla. It is GPL'd and should be fast
+# on non-x86 architectures (e.g. PowerPC), while the OpenSSL version (default
+# choice) has very fast version optimized for i586.
+#
+# Define PPC_SHA1 environment variable when running make to make use of
+# a bundled SHA1 routine optimized for PowerPC.
+#
+# Define ARM_SHA1 environment variable when running make to make use of
+# a bundled SHA1 routine optimized for ARM.
+#
+# Define NO_OPENSSL environment variable if you do not have OpenSSL.
+# This also implies MOZILLA_SHA1.
+#
+# Define OPENSSLDIR=/foo/bar if your openssl header and library files are in
+# /foo/bar/include and /foo/bar/lib directories.
+AC_ARG_WITH(openssl,
+AS_HELP_STRING([--with-openssl],[use OpenSSL library (default is YES)])
+AS_HELP_STRING([],              [ARG can be prefix for openssl library and headers]),\
+GIT_PARSE_WITH(openssl))
+#
+# Define NO_CURL if you do not have curl installed.  git-http-pull and
+# git-http-push are not built, and you cannot use http:// and https://
+# transports.
+#
+# Define CURLDIR=/foo/bar if your curl header and library files are in
+# /foo/bar/include and /foo/bar/lib directories.
+AC_ARG_WITH(curl,
+AS_HELP_STRING([--with-curl],[support http(s):// transports (default is YES)])
+AS_HELP_STRING([],           [ARG can be also prefix for curl library and headers]),
+GIT_PARSE_WITH(curl))
+#
+# Define NO_EXPAT if you do not have expat installed.  git-http-push is
+# not built, and you cannot push using http:// and https:// transports.
+#
+# Define EXPATDIR=/foo/bar if your expat header and library files are in
+# /foo/bar/include and /foo/bar/lib directories.
+AC_ARG_WITH(expat,
+AS_HELP_STRING([--with-expat],
+[support git-push using http:// and https:// transports via WebDAV (default is YES)])
+AS_HELP_STRING([],            [ARG can be also prefix for expat library and headers]),
+GIT_PARSE_WITH(expat))
+#
+# Define NO_FINK if you are building on Darwin/Mac OS X, have Fink
+# installed in /sw, but don't want GIT to link against any libraries
+# installed there.  If defined you may specify your own (or Fink's)
+# include directories and library directories by defining CFLAGS
+# and LDFLAGS appropriately.
+#
+# Define NO_DARWIN_PORTS if you are building on Darwin/Mac OS X,
+# have DarwinPorts installed in /opt/local, but don't want GIT to
+# link against any libraries installed there.  If defined you may
+# specify your own (or DarwinPort's) include directories and
+# library directories by defining CFLAGS and LDFLAGS appropriately.
+#
+# Define NO_MMAP if you want to avoid mmap.
+
+## --enable-FEATURE[=ARG] and --disable-FEATURE
+#
+# Define COLLISION_CHECK below if you believe that SHA1's
+# 1461501637330902918203684832716283019655932542976 hashes do not give you
+# sufficient guarantee that no collisions between objects will ever happen.
+#
+# Define USE_NSEC below if you want git to care about sub-second file mtimes
+# and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
+# it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
+# randomly break unless your underlying filesystem supports those sub-second
+# times (my ext3 doesn't).
+#
+# Define USE_STDEV below if you want git to care about the underlying device
+# change being considered an inode change from the update-cache perspective.
+
+
 ## Output files
 AC_CONFIG_FILES(["${config_file}":"${config_in}":"${config_append}"])
 AC_OUTPUT
-- 
1.4.1.1
