From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] configure: wrap some library tests with GIT_STASH_FLAGS
Date: Thu, 12 Mar 2009 15:20:09 -0400
Message-ID: <1236885612-22575-5-git-send-email-bwalton@artsci.utoronto.ca>
References: <1236885612-22575-1-git-send-email-bwalton@artsci.utoronto.ca>
 <1236885612-22575-2-git-send-email-bwalton@artsci.utoronto.ca>
 <1236885612-22575-3-git-send-email-bwalton@artsci.utoronto.ca>
 <1236885612-22575-4-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 20:22:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhqTe-0007sz-4h
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 20:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756454AbZCLTU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 15:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755524AbZCLTUY
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 15:20:24 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:36882 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756454AbZCLTUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 15:20:16 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253] ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1LhqRx-0004Sj-VM; Thu, 12 Mar 2009 15:20:14 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1LhqRx-0005u7-SO; Thu, 12 Mar 2009 15:20:13 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n2CJKDYr022695;
	Thu, 12 Mar 2009 15:20:13 -0400
X-Mailer: git-send-email 1.5.5.6
In-Reply-To: <1236885612-22575-4-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113109>

Libraries that can have user specificed base paths are wrapped with
GIT_STASH_FLAGS/GIT_UNSTASH_FLAGS to ensure that the proper versions
on the system are tested.  This ensures, for example, that the zlib
tests for deflateUnbound are done with the version of zlib requested
by the user.  This is most useful in the absence of good settings for
CPPFLAGS and/or LDFLAGS.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 configure.ac |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 469c9a9..fe9d7eb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -315,33 +315,57 @@ AC_MSG_NOTICE([CHECKS for libraries])
 #
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lcrypto with -lssl (Darwin).
+
+GIT_STASH_FLAGS($OPENSSLDIR)
+
 AC_CHECK_LIB([crypto], [SHA1_Init],
 [NEEDS_SSL_WITH_CRYPTO=],
 [AC_CHECK_LIB([ssl], [SHA1_Init],
  [NEEDS_SSL_WITH_CRYPTO=YesPlease
   NEEDS_SSL_WITH_CRYPTO=],
  [NO_OPENSSL=YesPlease])])
+
+GIT_UNSTASH_FLAGS($OPENSSLDIR)
+
 AC_SUBST(NEEDS_SSL_WITH_CRYPTO)
 AC_SUBST(NO_OPENSSL)
+
 #
 # Define NO_CURL if you do not have libcurl installed.  git-http-pull and
 # git-http-push are not built, and you cannot use http:// and https://
 # transports.
+
+GIT_STASH_FLAGS($CURLDIR)
+
 AC_CHECK_LIB([curl], [curl_global_init],
 [NO_CURL=],
 [NO_CURL=YesPlease])
+
+GIT_UNSTASH_FLAGS($CURLDIR)
+
 AC_SUBST(NO_CURL)
+
 #
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
 # not built, and you cannot push using http:// and https:// transports.
+
+GIT_STASH_FLAGS($EXPATDIR)
+
 AC_CHECK_LIB([expat], [XML_ParserCreate],
 [NO_EXPAT=],
 [NO_EXPAT=YesPlease])
+
+GIT_UNSTASH_FLAGS($EXPATDIR)
+
 AC_SUBST(NO_EXPAT)
+
 #
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin and
 # some Solaris installations).
 # Define NO_ICONV if neither libc nor libiconv support iconv.
+
+GIT_STASH_FLAGS($ICONVDIR)
+
 AC_DEFUN([ICONVTEST_SRC], [
 #include <iconv.h>
 
@@ -365,11 +389,17 @@ AC_LINK_IFELSE(ICONVTEST_SRC,
 		[AC_MSG_RESULT([no])
 		NO_ICONV=YesPlease])
 	LIBS="$old_LIBS"])
+
+GIT_UNSTASH_FLAGS($ICONVDIR)
+
 AC_SUBST(NEEDS_LIBICONV)
 AC_SUBST(NO_ICONV)
-test -n "$NEEDS_LIBICONV" && LIBS="$LIBS -liconv"
+
 #
 # Define NO_DEFLATE_BOUND if deflateBound is missing from zlib.
+
+GIT_STASH_FLAGS($ZLIB_PATH)
+
 AC_DEFUN([ZLIBTEST_SRC], [
 #include <zlib.h>
 
@@ -387,7 +417,11 @@ AC_LINK_IFELSE(ZLIBTEST_SRC,
 	[AC_MSG_RESULT([no])
 	NO_DEFLATE_BOUND=yes])
 LIBS="$old_LIBS"
+
+GIT_UNSTASH_FLAGS($ZLIB_PATH)
+
 AC_SUBST(NO_DEFLATE_BOUND)
+
 #
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
 # Patrick Mauritz).
-- 
1.6.0.5
