From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: [PATCH] Be nice with compilers that do not support runtime paths at all.
Date: Thu,  4 Oct 2007 00:20:52 +0200
Message-ID: <1191450052-23619-1-git-send-email-tsuna@lrde.epita.fr>
References: <7vsl4rdgf4.fsf@gitster.siamese.dyndns.org>
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 04 00:40:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdCtC-0000i0-Qm
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 00:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbXJCWkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 18:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752509AbXJCWkO
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 18:40:14 -0400
Received: from quanta.tsunanet.net ([82.229.223.213]:49272 "EHLO
	quanta.tsunanet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbXJCWkN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 18:40:13 -0400
X-Greylist: delayed 1134 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Oct 2007 18:40:13 EDT
Received: by quanta.tsunanet.net (Postfix, from userid 501)
	id 4869CAB983E; Thu,  4 Oct 2007 00:20:52 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.209.g9e417
In-Reply-To: <7vsl4rdgf4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59902>

On Darwin for instance, there is no -R or -Wl,-rpath thing to fiddle with,
it's simply not supported by the dynamic loader.  This patch introduces a
NO_RPATH define which is enabled by default for Darwin.
---
 Makefile |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index a1fe443..7c6c453 100644
--- a/Makefile
+++ b/Makefile
@@ -100,6 +100,9 @@ all::
 # that tells runtime paths to dynamic libraries;
 # "-Wl,-rpath=/path/lib" is used instead.
 #
+# Define NO_RPATH if your dynamic loader doesn't support runtime paths at
+# all.
+#
 # Define USE_NSEC below if you want git to care about sub-second file mtimes
 # and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
 # it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
@@ -507,6 +510,7 @@ ifeq ($(uname_S),Darwin)
 			BASIC_LDFLAGS += -L/opt/local/lib
 		endif
 	endif
+        NO_RPATH = YesPlease
 endif
 
 ifdef NO_R_TO_GCC_LINKER
@@ -521,7 +525,10 @@ ifndef NO_CURL
 	ifdef CURLDIR
 		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
 		BASIC_CFLAGS += -I$(CURLDIR)/include
-		CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -lcurl
+		CURL_LIBCURL = -L$(CURLDIR)/$(lib) -lcurl
+ifndef NO_RPATH
+		CURL_LIBCURL += $(CC_LD_DYNPATH)$(CURLDIR)/$(lib)
+endif
 	else
 		CURL_LIBCURL = -lcurl
 	endif
@@ -539,7 +546,10 @@ endif
 
 ifdef ZLIB_PATH
 	BASIC_CFLAGS += -I$(ZLIB_PATH)/include
-	EXTLIBS += -L$(ZLIB_PATH)/$(lib) $(CC_LD_DYNPATH)$(ZLIB_PATH)/$(lib)
+	EXTLIBS += -L$(ZLIB_PATH)/$(lib)
+ifndef NO_RPATH
+	EXTLIBS += $(CC_LD_DYNPATH)$(ZLIB_PATH)/$(lib)
+endif
 endif
 EXTLIBS += -lz
 
@@ -547,7 +557,10 @@ ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
 	ifdef OPENSSLDIR
 		BASIC_CFLAGS += -I$(OPENSSLDIR)/include
-		OPENSSL_LINK = -L$(OPENSSLDIR)/$(lib) $(CC_LD_DYNPATH)$(OPENSSLDIR)/$(lib)
+		OPENSSL_LINK = -L$(OPENSSLDIR)/$(lib)
+ifndef NO_RPATH
+		OPENSSL_LINK = $(CC_LD_DYNPATH)$(OPENSSLDIR)/$(lib)
+endif
 	else
 		OPENSSL_LINK =
 	endif
@@ -564,7 +577,10 @@ endif
 ifdef NEEDS_LIBICONV
 	ifdef ICONVDIR
 		BASIC_CFLAGS += -I$(ICONVDIR)/include
-		ICONV_LINK = -L$(ICONVDIR)/$(lib) $(CC_LD_DYNPATH)$(ICONVDIR)/$(lib)
+		ICONV_LINK = -L$(ICONVDIR)/$(lib)
+ifndef NO_RPATH
+		ICONV_LINK = $(CC_LD_DYNPATH)$(ICONVDIR)/$(lib)
+endif
 	else
 		ICONV_LINK =
 	endif
-- 
1.5.3.4.209.g9e417
