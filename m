From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] configure: reorganize flow of argument checks
Date: Thu, 12 Mar 2009 15:20:07 -0400
Message-ID: <1236885612-22575-3-git-send-email-bwalton@artsci.utoronto.ca>
References: <1236885612-22575-1-git-send-email-bwalton@artsci.utoronto.ca>
 <1236885612-22575-2-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 20:22:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhqTd-0007sz-FA
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 20:21:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874AbZCLTUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 15:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754683AbZCLTUW
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 15:20:22 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:36878 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254AbZCLTUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 15:20:16 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253] ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1LhqRx-0004Sf-Mg; Thu, 12 Mar 2009 15:20:13 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1LhqRx-0005tp-K0; Thu, 12 Mar 2009 15:20:13 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n2CJKDPY022675;
	Thu, 12 Mar 2009 15:20:13 -0400
X-Mailer: git-send-email 1.5.5.6
In-Reply-To: <1236885612-22575-2-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113108>

Move the argument tests from the 'site overrides' so that they are
ahead of any library tests.  This allows for library tests to take
user specified paths into account.  The intent here is to avoid things
like NO_DEFLATE_BOUND being set due to finding old zlib when the user
has specified an alternate location for zlib.  (Ignore the fact that
properly set *FLAGS can avoid solve this issue.)

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 configure.ac |  174 +++++++++++++++++++++++++++++-----------------------------
 1 files changed, 87 insertions(+), 87 deletions(-)

diff --git a/configure.ac b/configure.ac
index 0b314d7..0bff480 100644
--- a/configure.ac
+++ b/configure.ac
@@ -100,6 +100,93 @@ if test -z "$lib"; then
    AC_MSG_NOTICE([Setting lib to 'lib' (the default)])
    lib=lib
 fi
+
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
+#
+# Define NO_ICONV if your libc does not properly support iconv.
+AC_ARG_WITH(iconv,
+AS_HELP_STRING([--without-iconv],
+[if your architecture doesn't properly support iconv])
+AS_HELP_STRING([--with-iconv=PATH],
+[PATH is prefix for libiconv library and headers])
+AS_HELP_STRING([],
+[used only if you need linking with libiconv]),
+GIT_PARSE_WITH(iconv))
+
+## --enable-FEATURE[=ARG] and --disable-FEATURE
+#
+# Define USE_NSEC below if you want git to care about sub-second file mtimes
+# and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
+# it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
+# randomly break unless your underlying filesystem supports those sub-second
+# times (my ext3 doesn't).
+#
+# Define USE_STDEV below if you want git to care about the underlying device
+# change being considered an inode change from the update-index perspective.
+
 #
 # Define SHELL_PATH to provide path to shell.
 GIT_ARG_SET_PATH(shell)
@@ -526,93 +613,6 @@ AC_SUBST(PTHREAD_LIBS)
 AC_SUBST(NO_PTHREADS)
 AC_SUBST(THREADED_DELTA_SEARCH)
 
-## Site configuration (override autodetection)
-## --with-PACKAGE[=ARG] and --without-PACKAGE
-AC_MSG_NOTICE([CHECKS for site configuration])
-#
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
-# Define OPENSSLDIR=/foo/bar if your openssl header and library files are in
-# /foo/bar/include and /foo/bar/lib directories.
-AC_ARG_WITH(openssl,
-AS_HELP_STRING([--with-openssl],[use OpenSSL library (default is YES)])
-AS_HELP_STRING([],              [ARG can be prefix for openssl library and headers]),\
-GIT_PARSE_WITH(openssl))
-#
-# Define NO_CURL if you do not have curl installed.  git-http-pull and
-# git-http-push are not built, and you cannot use http:// and https://
-# transports.
-#
-# Define CURLDIR=/foo/bar if your curl header and library files are in
-# /foo/bar/include and /foo/bar/lib directories.
-AC_ARG_WITH(curl,
-AS_HELP_STRING([--with-curl],[support http(s):// transports (default is YES)])
-AS_HELP_STRING([],           [ARG can be also prefix for curl library and headers]),
-GIT_PARSE_WITH(curl))
-#
-# Define NO_EXPAT if you do not have expat installed.  git-http-push is
-# not built, and you cannot push using http:// and https:// transports.
-#
-# Define EXPATDIR=/foo/bar if your expat header and library files are in
-# /foo/bar/include and /foo/bar/lib directories.
-AC_ARG_WITH(expat,
-AS_HELP_STRING([--with-expat],
-[support git-push using http:// and https:// transports via WebDAV (default is YES)])
-AS_HELP_STRING([],            [ARG can be also prefix for expat library and headers]),
-GIT_PARSE_WITH(expat))
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
-# Define NO_ICONV if your libc does not properly support iconv.
-AC_ARG_WITH(iconv,
-AS_HELP_STRING([--without-iconv],
-[if your architecture doesn't properly support iconv])
-AS_HELP_STRING([--with-iconv=PATH],
-[PATH is prefix for libiconv library and headers])
-AS_HELP_STRING([],
-[used only if you need linking with libiconv]),
-GIT_PARSE_WITH(iconv))
-
-## --enable-FEATURE[=ARG] and --disable-FEATURE
-#
-# Define USE_NSEC below if you want git to care about sub-second file mtimes
-# and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
-# it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
-# randomly break unless your underlying filesystem supports those sub-second
-# times (my ext3 doesn't).
-#
-# Define USE_STDEV below if you want git to care about the underlying device
-# change being considered an inode change from the update-index perspective.
-
-
 ## Output files
 AC_CONFIG_FILES(["${config_file}":"${config_in}":"${config_append}"])
 AC_OUTPUT
-- 
1.6.0.5
