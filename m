From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] Makefile: Add NEEDS_CRYPTO_WITH_SSL
Date: Tue,  8 Sep 2009 09:54:38 -0400
Message-ID: <1252418078-68650-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 08 15:55:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml19z-00071N-GQ
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 15:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754509AbZIHNyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 09:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754492AbZIHNyx
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 09:54:53 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:42381 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461AbZIHNyw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 09:54:52 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 47C9A1FFC087; Tue,  8 Sep 2009 13:54:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (nmd.sbx07360.rocheny.wayport.net [98.98.50.102])
	by silverinsanity.com (Postfix) with ESMTPA id 4ADE71FFC06B;
	Tue,  8 Sep 2009 13:54:40 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.2.420.g30ecf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128007>

The Makefile comment for NEEDS_SSL_WITH_CRYPTO says to define it "if
you need -lcrypto with -lssl (Darwin)."  However, what it actually
does is add -lssl when you use -lcrypto and not the other way around.
However, libcrypto contains a majority of the ERR_* functions from
OpenSSL (at least on OS X) so we need it both ways.

So, add NEEDS_CRYPTO_WITH_SSL which adds -lcrypto to the OpenSSL link
flags and clarify the difference between it and NEEDS_SSL_WITH_CRYPTO.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---

 Compilation using BLK_SHA1 on OS X 10.5 and 10.6 (at least) is still
 broken without this patch.

 Alex Riesen <raa.lkml@gmail.com> pointed out that just adding LIB_4_CRYPTO
 to git-imap-send is simpler, but judging from the fact that nobody else
 has complained about this issue, I'm guessing that the need for -lcrypto
 when using -lssl is not widespread.  (Or BLK_SHA1 isn't getting used much
 or those who do don't compile git-imap-send with SSL.)

 Makefile |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index ce882d0..121be04 100644
--- a/Makefile
+++ b/Makefile
@@ -91,7 +91,9 @@ all::
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
-# Define NEEDS_SSL_WITH_CRYPTO if you need -lcrypto with -lssl (Darwin).
+# Define NEEDS_CRYPTO_WITH_SSL if you need -lcrypto when using -lssl (Darwin).
+#
+# Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darwin).
 #
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
 #
@@ -707,6 +709,7 @@ ifeq ($(uname_S),SCO_SV)
 	TAR = gtar
 endif
 ifeq ($(uname_S),Darwin)
+	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	ifeq ($(shell expr "$(uname_R)" : '[15678]\.'),2)
@@ -1009,6 +1012,9 @@ ifndef NO_OPENSSL
 	else
 		OPENSSL_LINK =
 	endif
+	ifdef NEEDS_CRYPTO_WITH_SSL
+		OPENSSL_LINK += -lcrypto
+	endif
 else
 	BASIC_CFLAGS += -DNO_OPENSSL
 	BLK_SHA1 = 1
-- 
1.6.4.2.420.g30ecf
