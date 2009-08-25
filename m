From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH/RFC] make the new block-sha1 the default
Date: Mon, 24 Aug 2009 23:04:37 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908242249420.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 05:04:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfmL4-0007E2-MV
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 05:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306AbZHYDEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 23:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754304AbZHYDEm
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 23:04:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35225 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302AbZHYDEl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 23:04:41 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOW00HQAWJP3PD0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 24 Aug 2009 23:04:38 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126994>

... and remove support for linking against the openssl SHA1 code.

The block-sha1 implementation is not significantly worse and sometimes 
even faster than the openssl SHA1 implementation.  This allows for
getting rid of the dependency and runtime linking to openssl which is
a relatively important source of latency when executing git commands.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

OK... So here it is.  After all, wanting to get rid of openssl is what 
started it all in the first place.

diff --git a/INSTALL b/INSTALL
index ae7f750..55eb962 100644
--- a/INSTALL
+++ b/INSTALL
@@ -52,13 +52,6 @@ Issues of note:
 
 	- "zlib", the compression library. Git won't build without it.
 
-	- "openssl".  Unless you specify otherwise, you'll get the SHA1
-	  library from here.
-
-	  If you don't have openssl, you can use one of the SHA1 libraries
-	  that come with git (git includes the one from Mozilla, and has
-	  its own PowerPC and ARM optimized ones too - see the Makefile).
-
 	- libcurl library; git-http-fetch and git-fetch use them.  You
 	  might also want the "curl" executable for debugging purposes.
 	  If you do not use http transfer, you are probably OK if you
diff --git a/Makefile b/Makefile
index 4190a5d..8f28b09 100644
--- a/Makefile
+++ b/Makefile
@@ -16,7 +16,6 @@ all::
 # when attempting to read from an fopen'ed directory.
 #
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
-# This also implies BLK_SHA1.
 #
 # Define NO_CURL if you do not have libcurl installed.  git-http-pull and
 # git-http-push are not built, and you cannot use http:// and https://
@@ -84,10 +83,6 @@ all::
 # specify your own (or DarwinPort's) include directories and
 # library directories by defining CFLAGS and LDFLAGS appropriately.
 #
-# Define BLK_SHA1 environment variable if you want the C version
-# of the SHA1 that assumes you can do unaligned 32-bit loads and
-# have a fast htonl() function.
-#
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
@@ -1013,7 +1008,6 @@ ifndef NO_OPENSSL
 	endif
 else
 	BASIC_CFLAGS += -DNO_OPENSSL
-	BLK_SHA1 = 1
 	OPENSSL_LIBSSL =
 endif
 ifdef NEEDS_SSL_WITH_CRYPTO
@@ -1162,18 +1156,14 @@ ifdef NO_DEFLATE_BOUND
 	BASIC_CFLAGS += -DNO_DEFLATE_BOUND
 endif
 
-ifdef BLK_SHA1
-	SHA1_HEADER = "block-sha1/sha1.h"
-	LIB_OBJS += block-sha1/sha1.o
-else
 ifdef PPC_SHA1
 	SHA1_HEADER = "ppc/sha1.h"
 	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
 else
-	SHA1_HEADER = <openssl/sha.h>
-	EXTLIBS += $(LIB_4_CRYPTO)
-endif
+	SHA1_HEADER = "block-sha1/sha1.h"
+	LIB_OBJS += block-sha1/sha1.o
 endif
+
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
diff --git a/cache.h b/cache.h
index dd7f71e..39a4edd 100644
--- a/cache.h
+++ b/cache.h
@@ -6,12 +6,6 @@
 #include "hash.h"
 
 #include SHA1_HEADER
-#ifndef git_SHA_CTX
-#define git_SHA_CTX	SHA_CTX
-#define git_SHA1_Init	SHA1_Init
-#define git_SHA1_Update	SHA1_Update
-#define git_SHA1_Final	SHA1_Final
-#endif
 
 #include <zlib.h>
 #if defined(NO_DEFLATE_BOUND) || ZLIB_VERNUM < 0x1200
diff --git a/configure.ac b/configure.ac
index b09b8e4..634186c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -160,7 +160,6 @@ AC_MSG_NOTICE([CHECKS for site configuration])
 # a bundled SHA1 routine optimized for PowerPC.
 #
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
-# This also implies BLK_SHA1.
 #
 # Define OPENSSLDIR=/foo/bar if your openssl header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
