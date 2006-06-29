From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] autoconf: Use autoconf to check for libraries: openssl/crypto, curl, expat
Date: Thu, 29 Jun 2006 13:59:41 +0200
Message-ID: <200606291359.43640.jnareb@gmail.com>
References: <200606290301.51657.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 29 13:59:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvvBV-00024B-8i
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 13:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbWF2L7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 07:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbWF2L7q
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 07:59:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:2581 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751872AbWF2L7p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 07:59:45 -0400
Received: by nf-out-0910.google.com with SMTP id l24so36367nfc
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 04:59:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rIft5TZip5I3IOWfdBbiJpu9PuOmT6k1fKu2Ng3kM1qmCqzrNrKf+Elbqx1iy5oV782O5RMBMF2yF+qWFkk/BCB/0XFL9SmZLHAgGUEg456BVD+dnTLRcSRRL4AglcEYi74ylUxUA86skUOqKkOyWsE4A+MBV0+xdDwFSbjHOM4=
Received: by 10.49.41.17 with SMTP id t17mr305049nfj;
        Thu, 29 Jun 2006 04:59:43 -0700 (PDT)
Received: from host-81-190-27-124.torun.mm.pl ( [81.190.27.124])
        by mx.gmail.com with ESMTP id l21sm483142nfc.2006.06.29.04.59.42;
        Thu, 29 Jun 2006 04:59:43 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200606290301.51657.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22856>

./configure script checks now if the following libraries are present:
 * -lcrypto (checks for SHA1_Init, sets NO_OPENSSL=YesPlease if not found)
 * -lcurl   (checks for curl_easy_setopt, sets NO_CURL=YesPlease if not found)
 * -lexpat  (checks for XML_ParserCreate, sets NO_EXPAT=YesPlease if not found)

Appropriate lines in config.mak are generated using MY_APPEND_LINE macro by adding
lines to temporary file config.mak.append

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

Second patch in series introducing nonintrusive autoconf support to
git build process.

I'm not that sure about -lcrypto equals openssl.

 configure.ac |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4003ff6..55d7a9b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -6,6 +6,21 @@ AC_INIT([git], [1.4.0], [git@vger.kernel
 
 AC_CONFIG_SRCDIR([git.c])
 
+# Definitions of macros
+# MY_APPEND_LINE(LINE)
+# --------------------
+# Append LINE to file config.mak.append
+AC_DEFUN([MY_APPEND_LINE],
+[[echo "$1" >> config.mak.append]])# AC_APPEND_LINE
+
+# Checks for libraries.
+AC_MSG_NOTICE(CHECKS for libraries)
+AC_CHECK_LIB([crypto], [SHA1_Init],,MY_APPEND_LINE(NO_OPENSSL=YesPlease))
+AC_CHECK_LIB([curl], [curl_easy_setopt],,MY_APPEND_LINE(NO_CURL=YesPlease))
+AC_CHECK_LIB([expat], [XML_ParserCreate],,MY_APPEND_LINE(NO_EXPAT=YesPlease))
+
 # Output files
-AC_CONFIG_FILES([config.mak])
+AC_CONFIG_FILES([config.mak:config.mak.in:config.mak.append], 
+[rm -f config.mak.append], 
+[echo >> config.mak.append])
 AC_OUTPUT
-- 
1.4.0
