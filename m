From: Patrick Mauritz <oxygene@studentenbude.ath.cx>
Subject: patches
Date: Tue, 06 Sep 2005 01:24:03 +0200
Message-ID: <1125962642.15293.20.camel@divert>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-LJgEClwug7d1gjAg0niX"
X-From: git-owner@vger.kernel.org Tue Sep 06 01:24:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECQJJ-0007Dp-4a
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 01:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbVIEXXa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 19:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbVIEXXa
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 19:23:30 -0400
Received: from khepri.openbios.org ([80.190.231.112]:33497 "EHLO
	khepri.openbios.org") by vger.kernel.org with ESMTP id S964945AbVIEXX3
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 19:23:29 -0400
Received: from dsl-082-082-224-048.arcor-ip.net ([82.82.224.48] helo=t-stueck.streichelzoo)
	by khepri.openbios.org with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.50)
	id 1ECQJ8-0007QX-Kx
	for git@vger.kernel.org; Tue, 06 Sep 2005 01:23:23 +0200
Received: from 192.168.1.201 (divert.studentenbude.ath.cx [192.168.1.201])
	by t-stueck.streichelzoo (8.13.4+Sun/8.13.3) with ESMTP id j85NNGpL021390
	for <git@vger.kernel.org>; Tue, 6 Sep 2005 01:23:22 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: Ximian Evolution 1.4.6.316 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0 (t-stueck.streichelzoo [192.168.1.200]); Tue, 06 Sep 2005 01:23:22 +0200 (CEST)
X-Spam-Score: -1.4 (-)
X-Duff: Orig. Duff, Duff Lite, Duff Dry, Duff Dark,
	Raspberry Duff, Lady Duff, Red Duff, Tartar Control Duff
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8119>


--=-LJgEClwug7d1gjAg0niX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

attached are two patches:
the first fixes some build issues on solaris10/x86 with sunpro (and some
that also happen with gcc), while the second adds a simple way to add
additional search and link paths for curl library and headers.


patrick mauritz
(not on the list, please Cc:)

--=-LJgEClwug7d1gjAg0niX
Content-Disposition: attachment; filename=patch-20050817-1-build
Content-Type: text/x-patch; name=patch-20050817-1-build; charset=ASCII
Content-Transfer-Encoding: 7bit

diff -ur git-core-0.99.4.orig/convert-cache.c git-core-0.99.4/convert-cache.c
--- git-core-0.99.5.orig/convert-cache.c	Wed Aug 17 09:55:00 2005
+++ git-core-0.99.5/convert-cache.c	Wed Aug 17 09:58:48 2005
@@ -1,4 +1,5 @@
 #define _XOPEN_SOURCE /* glibc2 needs this */
+#define __EXTENSIONS__ /* solaris needs this */
 #include <time.h>
 #include <ctype.h>
 #include "cache.h"
diff -ur git-core-0.99.4.orig/ident.c git-core-0.99.4/ident.c
--- git-core-0.99.5.orig/ident.c	Wed Aug 17 09:55:00 2005
+++ git-core-0.99.5/ident.c	Wed Aug 17 09:57:54 2005
@@ -36,12 +36,13 @@
 	memcpy(real_email, pw->pw_name, len);
 	real_email[len++] = '@';
 	gethostname(real_email + len, sizeof(real_email) - len);
+#ifndef __sun
 	if (!strchr(real_email+len, '.')) {
 		len = strlen(real_email);
 		real_email[len++] = '.';
 		getdomainname(real_email+len, sizeof(real_email)-len);
 	}
-
+#endif
 	/* And set the default date */
 	datestamp(real_date, sizeof(real_date));
 	return 0;
--- git-core-0.99.5/Makefile~	Thu Aug 25 03:54:24 2005
+++ git-core-0.99.5/Makefile	Tue Sep  6 01:18:32 2005
@@ -146,7 +146,11 @@
 		endif
 	endif
 endif
+ifeq ($(shell uname -s),SunOS)
+  LIBS += -lsocket
+endif
 
+
 DEFINES += '-DSHA1_HEADER=$(SHA1_HEADER)'
 
 

--=-LJgEClwug7d1gjAg0niX
Content-Disposition: attachment; filename=patch-20050906-2-curl
Content-Type: text/plain; name=patch-20050906-2-curl; charset=ASCII
Content-Transfer-Encoding: 7bit

--- git-core-0.99.5/Makefile~	Tue Sep  6 01:13:29 2005
+++ git-core-0.99.5/Makefile	Tue Sep  6 01:15:40 2005
@@ -34,7 +34,14 @@
 
 GIT_VERSION = 0.99.5
 
-CFLAGS = -g -O2 -Wall
+ifndef COPTS
+COPTS = -g -O2 -Wall
+endif
+CFLAGS = $(COPTS)
+ifdef CURLDIR
+CFLAGS+=-I$(CURLDIR)/include
+endif
+
 ALL_CFLAGS = $(CFLAGS) $(DEFINES)
 
 prefix = $(HOME)
@@ -172,7 +179,11 @@
 git-ssh-pull: rsh.o pull.o
 git-ssh-push: rsh.o
 
+ifdef CURLDIR
+git-http-pull: LIBS += -lcurl -L$(CURLDIR)/lib -R$(CURLDIR)/lib
+else
 git-http-pull: LIBS += -lcurl
+endif
 git-rev-list: LIBS += $(OPENSSL_LIBSSL)
 
 init-db.o: init-db.c

--=-LJgEClwug7d1gjAg0niX--
