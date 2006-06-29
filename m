From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] autoconf: Use autoconf to check for some types and library functions
Date: Thu, 29 Jun 2006 15:36:17 +0200
Message-ID: <200606291536.18667.jnareb@gmail.com>
References: <200606290301.51657.jnareb@gmail.com> <200606291359.43640.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 29 15:36:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fvwgv-0002Zk-W3
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 15:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWF2NgR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 09:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWF2NgR
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 09:36:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:9184 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750738AbWF2NgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 09:36:16 -0400
Received: by nf-out-0910.google.com with SMTP id a4so73334nfc
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 06:36:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qogdjgXBiAOKFH6ZzgncLPk01EutnNPVLRarCpn/srBILqaIVh0/obI4zDHhwgy99rRjce1yd3dGSPdKofMD2uC2DRj1tj+qglGOtle9WpEO6Met7iun2DoZKLj6oC0rI+rtUYj/6TLNNZKluK3MSpUURegtli2PuCYWQ8+4+/E=
Received: by 10.48.231.6 with SMTP id d6mr1625902nfh;
        Thu, 29 Jun 2006 06:36:15 -0700 (PDT)
Received: from host-81-190-27-124.torun.mm.pl ( [81.190.27.124])
        by mx.gmail.com with ESMTP id r34sm511703nfc.2006.06.29.06.36.14;
        Thu, 29 Jun 2006 06:36:15 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200606291359.43640.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22863>

./configure script checks now for existence of the following types
and structure members:
 * dirent.d_ino  in dirent.h (NO_D_INO_IN_DIRENT)
 * dirent.d_type in dirent.h (NO_D_TYPE_IN_DIRENT)
 * 'struct sockaddr_storage' in netinet/in.h (NO_SOCKADDR_STORAGE)

./configure script checks now for the following library functions:
 * strcasestr (NO_STRCASESTR)
 * strlcpy (NO_STRLCPY)
 * setenv (NO_SETENV)
in default C library and in libraries which have AC_CHECK_LIB done for
them (crypto, curl, expat).

NOTE: not all checks are implemented!

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

This patch needs review by someone better versed in compiling git on
different platforms, namely AC_CHECK_MEMBER and AC_CHECK_TYPE needs
checking if all header files where git search for specified structure
member or specified type.

I don't know (yet) how to implement checking for NEEDS_SSL_WITH_CRYPTO
(probably also checlking for crypto library needs correction),
NEEDS_LIBICONV, NEEDS_SOCKET, NO_IPV6, NO_ICONV, Python < 2.3 and
Python == 2.3, if to check for NO_MMAP, and for NO_ACCURATE_DIFF.

This patch is to be considered preliminary!

 configure.ac |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 55d7a9b..fbd46e2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -14,17 +14,41 @@ AC_CONFIG_SRCDIR([git.c])
 AC_DEFUN([MY_APPEND_LINE],
 [[echo "$1" >> config.mak.append]])# AC_APPEND_LINE
 
+
 # Checks for libraries.
-AC_MSG_NOTICE(CHECKS for libraries)
+AC_MSG_NOTICE([CHECKS for libraries])
 AC_CHECK_LIB([crypto], [SHA1_Init],,MY_APPEND_LINE(NO_OPENSSL=YesPlease))
 AC_CHECK_LIB([curl], [curl_easy_setopt],,MY_APPEND_LINE(NO_CURL=YesPlease))
 AC_CHECK_LIB([expat], [XML_ParserCreate],,MY_APPEND_LINE(NO_EXPAT=YesPlease))
 
+
+# Checks for typedefs, structures, and compiler characteristics.
+AC_MSG_NOTICE([CHECKS for typedefs, structures, and compiler characteristics])
+
+AC_CHECK_MEMBER(struct dirent.d_ino,,
+MY_APPEND_LINE(NO_D_INO_IN_DIRENT=YesPlease),
+[#include <dirent.h>])
+AC_CHECK_MEMBER(struct dirent.d_type,,
+MY_APPEND_LINE(NO_D_TYPE_IN_DIRENT=YesPlease),
+[#include <dirent.h>])
+
+AC_CHECK_TYPE(struct sockaddr_storage,,
+MY_APPEND_LINE(NO_SOCKADDR_STORAGE=YesPlease),
+[#include <netinet/in.h>])
+
+
+# Checks for library functions.
+AC_MSG_NOTICE([CHECKS for library functions])
+AC_CHECK_FUNC(strcasestr,,MY_APPEND_LINE(NO_STRCASESTR=YesPlease))
+AC_CHECK_FUNC(strlcpy,,MY_APPEND_LINE(NO_STRLCPY=YesPlease))
+AC_CHECK_FUNC(setenv,,MY_APPEND_LINE(NO_SETENV=YesPlease))
+
+
 # Output files
 AC_CONFIG_FILES([config.mak:config.mak.in:config.mak.append], 
 [rm -f config.mak.append], 
-- 
1.4.0
