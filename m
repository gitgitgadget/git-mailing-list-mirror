From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH, resent] fix openssl headers conflicting with custom SHA1
 implementations
Date: Tue, 30 Sep 2008 16:22:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0809301621091.3635@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 22:24:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkllW-0002e8-LC
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 22:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbYI3UWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 16:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbYI3UWw
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 16:22:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11876 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbYI3UWv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 16:22:51 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K8000ATRZ90YXI0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 30 Sep 2008 16:22:12 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97156>

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
