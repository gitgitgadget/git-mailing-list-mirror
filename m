From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] Makefile: Add NEEDS_CRYPTO_WITH_SSL
Date: Sat, 15 Aug 2009 12:46:53 -0400
Message-ID: <1250354813-81349-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 15 18:54:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McMWi-0001j3-N9
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 18:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbZHOQyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 12:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbZHOQyf
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 12:54:35 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:55819 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932268AbZHOQyd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 12:54:33 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Aug 2009 12:54:33 EDT
Received: by silverinsanity.com (Postfix, from userid 5001)
	id C41CE1FFC03E; Sat, 15 Aug 2009 16:47:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-67-86-217.stny.res.rr.com [74.67.86.217])
	by silverinsanity.com (Postfix) with ESMTPA id 55B321FFC001;
	Sat, 15 Aug 2009 16:47:02 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.244.ge5cd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126011>

The Makefile comment for NEEDS_SSL_WITH_CRYPTO says to define it "if
you need -lcrypto with -lssl (Darwin)."  However, what it actually
does is add -lssl when you use -lcrypto and not the other way around.
However, libcrypto contains a majority of the ERR_* functions from
OpenSSL (at least on OS X) so we need it both ways.

So, add NEEDS_CRYPTO_WITH_SSL which adds -lcrypto to the OpenSSL link
flags and clarify the difference between it and NEEDS_SSL_WITH_CRYPTO.
---

 After adding BLK_SHA1 to my config.mak, git-imap-send started giving me link
 errors:

  Undefined symbols:
    "_ERR_get_error", referenced from:
        _ssl_socket_perror in imap-send.o
    "_ERR_error_string", referenced from:
        _ssl_socket_perror in imap-send.o

 Some investigation led me to the fact that BLK_SHA1 removes LIB_4_CRYPTO from
 EXTLIBS.  That let me find the missing functions in libcrypto.  At first I
 considered making NEEDS_SSL_WITH_CRYPTO add -lcrypto to the SSL build flags
 but decided to go this route in case there are platforms that need it one way
 around and not the other.

 I've enabled this build option by default on Darwin but nowhere else.  If you
 can't build git-imap-send (with SSL) after enabling BLK_SHA1, your platform
 may need this flag as well.

 Makefile |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index f94fe05..bc745fb 100644
--- a/Makefile
+++ b/Makefile
@@ -99,7 +99,9 @@ all::
 # on non-x86 architectures (e.g. PowerPC), while the OpenSSL version (default
 # choice) has very fast version optimized for i586.
 #
-# Define NEEDS_SSL_WITH_CRYPTO if you need -lcrypto with -lssl (Darwin).
+# Define NEEDS_CRYPTO_WITH_SSL if you need -lcrypto when using -lssl (Darwin).
+#
+# Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darwin).
 #
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
 #
@@ -714,6 +716,7 @@ ifeq ($(uname_S),SCO_SV)
 	TAR = gtar
 endif
 ifeq ($(uname_S),Darwin)
+	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	ifeq ($(shell expr "$(uname_R)" : '[15678]\.'),2)
@@ -1023,6 +1026,9 @@ ifndef NO_OPENSSL
 	else
 		OPENSSL_LINK =
 	endif
+	ifdef NEEDS_CRYPTO_WITH_SSL
+		OPENSSL_LINK += -lcrypto
+	endif
 else
 	BASIC_CFLAGS += -DNO_OPENSSL
 	MOZILLA_SHA1 = 1
-- 
1.6.4.244.ge5cd0
