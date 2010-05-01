From: Alan Hourihane <alanh@fairlite.co.uk>
Subject: new platform & S_IFGITLINK problem
Date: Sun, 02 May 2010 00:29:15 +0100
Message-ID: <1272756555.13488.1314.camel@jetpack.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-wn13fhkQGB89aEuCrjdI"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 02 01:47:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8MOo-0004uD-MB
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 01:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550Ab0EAXqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 19:46:55 -0400
Received: from fairlite.demon.co.uk ([80.176.228.186]:39519 "EHLO
	fairlite.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711Ab0EAXqy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 19:46:54 -0400
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 May 2010 19:46:54 EDT
Received: from localhost (unknown [127.0.0.1])
	by fairlite.demon.co.uk (Postfix) with ESMTP id E80E03D5AF5
	for <git@vger.kernel.org>; Sat,  1 May 2010 23:29:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at demon.co.uk
Received: from fairlite.demon.co.uk ([127.0.0.1])
	by localhost (server.demon.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NwZ9YSp5lxQc for <git@vger.kernel.org>;
	Sun,  2 May 2010 00:29:16 +0100 (BST)
Received: from [192.168.0.226] (unknown [192.168.0.226])
	by fairlite.demon.co.uk (Postfix) with ESMTP id F252D3D4002
	for <git@vger.kernel.org>; Sun,  2 May 2010 00:29:15 +0100 (BST)
X-Mailer: Evolution 2.26.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146123>


--=-wn13fhkQGB89aEuCrjdI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

Just joined as I'm compiling git on a new platform and wondered if
someone can help solve a problem with the definition of S_IFGITLINK.

On my platform I have the following definitions....

#define __S_IFSOCK      0010000 /* Socket.  */
#define __S_IFCHR       0020000 /* Character device.  */
#define __S_IFDIR       0040000 /* Directory.  */
#define __S_IFBLK       0060000 /* Block device.  */
#define __S_IFREG       0100000 /* Regular file.  */
#define __S_IFIFO       0120000 /* FIFO.  */
#define __S_IFMEM       0140000 /* memory region or process */
#define __S_IFLNK       0160000 /* Symbolic link.  */

Yet, S_IFGITLINK in the git sources is defined as 0160000, so this
clashes with my platform.

There is a comment about the definition of S_IFGITLINK in cache.h that
it shouldn't be used like this and should use internal values.

So I'm wondering if this can be fixed to remove this assumption ?

Additionally, attached is a patch that I currently need to apply in
order to compile git successfully on the FreeMiNT platform (which is
m68k based).

Comments appreciated.

Thanks,

Alan.

--=-wn13fhkQGB89aEuCrjdI
Content-Disposition: attachment; filename="git-1.7.0.4-mint.patch"
Content-Type: text/x-patch; name="git-1.7.0.4-mint.patch"; charset="us-ascii"
Content-Transfer-Encoding: 7bit

--- git-compat-util.h	2008-12-22 18:35:58.000000000 +0000
+++ git-compat-util.h	2008-12-22 18:39:21.000000000 +0000
@@ -123,7 +123,9 @@
 #ifdef _MSC_VER
 #include "compat/msvc.h"
 #endif
-
+#ifdef __MINT__
+#include "compat/mint.h"
+#endif
 #ifndef NO_LIBGEN_H
 #include <libgen.h>
 #else
--- /dev/null	2008-12-07 20:01:52.000000000 +0000
+++ compat/mint.h	2008-12-23 11:52:10.000000000 +0000
@@ -0,0 +1,2 @@
+#define SA_RESTART 0
+#define ss_family sa_family
--- Makefile	2009-01-29 12:12:01.000000000 +0000
+++ Makefile	2009-01-29 12:13:39.000000000 +0000
@@ -1618,7 +1613,7 @@
 
 git-imap-send$X: imap-send.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
+		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 
 http.o http-walker.o http-push.o: http.h
 
@@ -1626,10 +1621,10 @@
 
 git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) $(CURL_LIBCURL)
+		$(LIBS) $(CURL_LIBCURL) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	$(QUIET_LNCP)$(RM) $@ && \
@@ -1639,7 +1634,7 @@
 
 $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(LIB_H) $(wildcard */*.h)

--=-wn13fhkQGB89aEuCrjdI--
