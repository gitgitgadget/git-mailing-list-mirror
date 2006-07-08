From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 7] autoconf: Checks for libraries
Date: Sat,  8 Jul 2006 23:07:12 +0200
Message-ID: <11523928373299-git-send-email-jnareb@gmail.com>
References: <200607030156.50455.jnareb@gmail.com> <1152392835436-git-send-email-jnareb@gmail.com> <11523928361444-git-send-email-jnareb@gmail.com> <1152392836910-git-send-email-jnareb@gmail.com> <1152392837823-git-send-email-jnareb@gmail.com> <11523928373026-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 08 23:07:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzK1j-0003ja-2p
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 23:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbWGHVHg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 17:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWGHVHf
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 17:07:35 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:62657 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1030385AbWGHVH3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 17:07:29 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k68L6o00021763
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 Jul 2006 23:06:53 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k68L7HZn015597;
	Sat, 8 Jul 2006 23:07:17 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k68L7HgP015596;
	Sat, 8 Jul 2006 23:07:17 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11523928373026-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23506>

./configure script checks now if the following libraries are present:
 * -lssl    for SHA1_Init (NO_OPENSSL)
 * -lcurl   for curl_easy_setopt (NO_CURL)
 * -lexpat  for XML_ParserCreate (NO_EXPAT)
It also checks if adding the following libraries are needed:
 * -lcrypto for SHA1_Init (NEEDS_SSL_WITH_CRYPTO)
 * -liconv  for iconv (NEEDS_LIBICONV)
 * -lsocket for socket (NEEDS_SOCKET)

Policy: we check also if NEEDS_LIBRARY libraries are present, even if
there is no NO_LIBRARY variable.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Needs checking if correct functions are used for checks.

Policy might need to be changed, too.

 configure.ac |   28 +++++++++++++++++++++-------
 1 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index ab6a77a..d938546 100644
--- a/configure.ac
+++ b/configure.ac
@@ -26,22 +26,36 @@ # Define NO_PYTHON if you want to loose 
 
 
 ## Checks for libraries.
+AC_MSG_NOTICE([CHECKS for libraries])
+
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
-# This also implies MOZILLA_SHA1.
-#
+# Define NEEDS_SSL_WITH_CRYPTO if you need -lcrypto with -lssl (Darwin).
+AC_CHECK_LIB([ssl], [SHA1_Init],[],
+[AC_CHECK_LIB([crypto], [SHA1_INIT],
+ GIT_CONF_APPEND_LINE(NEEDS_SSL_WITH_CRYPTO=YesPlease),
+ GIT_CONF_APPEND_LINE(NO_OPENSSL=YesPlease))])
+
 # Define NO_CURL if you do not have curl installed.  git-http-pull and
 # git-http-push are not built, and you cannot use http:// and https://
 # transports.
-#
+AC_CHECK_LIB([curl], [curl_global_init],[],
+GIT_CONF_APPEND_LINE(NO_CURL=YesPlease))
+
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
 # not built, and you cannot push using http:// and https:// transports.
-#
-# Define NEEDS_SSL_WITH_CRYPTO if you need -lcrypto with -lssl (Darwin).
-#
+AC_CHECK_LIB([expat], [XML_ParserCreate],[],
+GIT_CONF_APPEND_LINE(NO_EXPAT=YesPlease))
+
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
-#
+AC_CHECK_LIB([c], [iconv],[],
+[AC_CHECK_LIB([iconv],[iconv],
+ GIT_CONF_APPEND_LINE(NEEDS_LIBICONV=YesPlease),[])])
+
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
 # Patrick Mauritz).
+AC_CHECK_LIB([c], [socket],[],
+[AC_CHECK_LIB([socket],[socket],
+ GIT_CONF_APPEND_LINE(NEEDS_SOCKET=YesPlease),[])])
 
 
 ## Checks for header files.
-- 
1.4.0
