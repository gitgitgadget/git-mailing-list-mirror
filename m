From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix openssl headers conflicting with custom SHA1
 implementations
Date: Fri, 19 Sep 2008 16:11:20 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809191414000.6279@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Robert Shearman <robertshearman@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 22:12:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgmLE-0000a8-Sc
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 22:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbYISUL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 16:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754009AbYISUL2
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 16:11:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60602 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbYISUL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 16:11:27 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K7G0090PLDZNLC0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 19 Sep 2008 16:10:48 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96308>

On ARM I have the following compilation errors:

    CC fast-import.o
In file included from cache.h:8,
                 from builtin.h:6,
                 from fast-import.c:142:
arm/sha1.h:14: error: conflicting types for 'SHA_CTX'
/usr/include/openssl/sha.h:105: error: previous declaration of 'SHA_CTX' was here
arm/sha1.h:16: error: conflicting types for 'SHA1_Init'
/usr/include/openssl/sha.h:115: error: previous declaration of 'SHA1_Init' was here
arm/sha1.h:17: error: conflicting types for 'SHA1_Update'
/usr/include/openssl/sha.h:116: error: previous declaration of 'SHA1_Update' was here
arm/sha1.h:18: error: conflicting types for 'SHA1_Final'
/usr/include/openssl/sha.h:117: error: previous declaration of 'SHA1_Final' was here
make: *** [fast-import.o] Error 1

This is because openssl header files are always included in 
git-compat-util.h since commit 684ec6c63c whenever NO_OPENSSL is not 
set, which somehow brings in <openssl/sha1.h> clashing with the custom 
ARM version.  Compilation of git is probably broken on PPC too for the 
same reason.

Turns out that the only file requiring openssl/ssl.h and openssl/err.h 
is imap-send.c.  But only moving those problematic includes there 
doesn't solve the issue as it also includes cache.h which brings in the 
conflicting header.  So also conditionally including SHA1_HEADER allows 
for not including it when compiling imap-send.c.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

This is a bit ugly but given the rat nest of system includes we have I 
don't know how to solve this any better.

diff --git a/Makefile b/Makefile
index 3c0664a..a0f86dd 100644
--- a/Makefile
+++ b/Makefile
@@ -1242,6 +1242,9 @@ endif
 git-%$X: %.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
+imap-send.o: imap-send.c GIT-CFLAGS
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -USHA1_HEADER $<
+
 git-imap-send$X: imap-send.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
diff --git a/cache.h b/cache.h
index de8c2b6..d93e086 100644
--- a/cache.h
+++ b/cache.h
@@ -5,7 +5,10 @@
 #include "strbuf.h"
 #include "hash.h"
 
+#ifdef SHA1_HEADER
 #include SHA1_HEADER
+#endif
+
 #include <zlib.h>
 
 #if defined(NO_DEFLATE_BOUND) || ZLIB_VERNUM < 0x1200
diff --git a/git-compat-util.h b/git-compat-util.h
index db2836f..044f62b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -99,11 +99,6 @@
 #include <iconv.h>
 #endif
 
-#ifndef NO_OPENSSL
-#include <openssl/ssl.h>
-#include <openssl/err.h>
-#endif
-
 /* On most systems <limits.h> would have given us this, but
  * not on some systems (e.g. GNU/Hurd).
  */
diff --git a/imap-send.c b/imap-send.c
index af7e08c..01f1c9a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -22,11 +22,15 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include "cache.h"
 #ifdef NO_OPENSSL
 typedef void *SSL;
+#else
+#include <openssl/ssl.h>
+#include <openssl/err.h>
 #endif
 
+#include "cache.h"
+
 struct store_conf {
 	char *name;
 	const char *path; /* should this be here? its interpretation is driver-specific */




Nicolas
