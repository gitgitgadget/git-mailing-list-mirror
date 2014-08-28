From: Maxim Bublis <satori@yandex-team.ru>
Subject: [PATCH v2] contrib/svn-fe: fix Makefile
Date: Thu, 28 Aug 2014 21:00:49 +0400
Message-ID: <1409245249-78610-1-git-send-email-satori@yandex-team.ru>
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Maxim Bublis <satori@yandex-team.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 19:02:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN35q-0004YI-Qr
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 19:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbaH1RCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 13:02:34 -0400
Received: from 95.108.175.165-red.dhcp.yndx.net ([95.108.175.165]:57499 "EHLO
	95.108.175.165-red.dhcp.yndx.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751409AbaH1RCe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2014 13:02:34 -0400
Received: by 95.108.175.165-red.dhcp.yndx.net (Postfix, from userid 1533206276)
	id 2BCB9204A310; Thu, 28 Aug 2014 21:02:25 +0400 (MSK)
X-Mailer: git-send-email 1.8.5.2 (Apple Git-48)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256102>

Fixes several problems:
  * include config.mak.uname, config.mak.autogen and config.mak
    in order to use settings for prefix and other such things;
  * link xdiff/lib.a as it is a requirement for libgit.a;
  * fix CFLAGS, LDFLAGS and EXTLIBS for Linux and Mac OS X.

Signed-off-by: Maxim Bublis <satori@yandex-team.ru>
---
Changes from previous version:
  * added possibility to disable MacPorts and Fink;
  * respecting NEEDS_CRYPTO_WITH_SSL.
 contrib/svn-fe/Makefile | 60 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index 360d8da..e8651aa 100644
--- a/contrib/svn-fe/Makefile
+++ b/contrib/svn-fe/Makefile
@@ -1,18 +1,58 @@
 all:: svn-fe$X
 
-CC = gcc
+CC = cc
 RM = rm -f
 MV = mv
 
 CFLAGS = -g -O2 -Wall
 LDFLAGS =
-ALL_CFLAGS = $(CFLAGS)
-ALL_LDFLAGS = $(LDFLAGS)
-EXTLIBS =
+EXTLIBS = -lz
+
+include ../../config.mak.uname
+-include ../../config.mak.autogen
+-include ../../config.mak
+
+ifeq ($(uname_S),Darwin)
+	ifndef NO_FINK
+		ifeq ($(shell test -d /sw/lib && echo y),y)
+			CFLAGS += -I/sw/include
+			LDFLAGS += -L/sw/lib
+		endif
+	endif
+	ifndef NO_DARWIN_PORTS
+		ifeq ($(shell test -d /opt/local/lib && echo y),y)
+			CFLAGS += -I/opt/local/include
+			LDFLAGS += -L/opt/local/lib
+		endif
+	endif
+endif
+
+ifndef NO_OPENSSL
+	EXTLIBS += -lssl
+	ifdef NEEDS_CRYPTO_WITH_SSL
+		EXTLIBS += -lcrypto
+	endif
+endif
+
+ifndef NO_PTHREADS
+	CFLAGS += $(PTHREADS_CFLAGS)
+	EXTLIBS += $(PTHREAD_LIBS)
+endif
+
+ifdef HAVE_CLOCK_GETTIME
+	CFLAGS += -DHAVE_CLOCK_GETTIME
+	EXTLIBS += -lrt
+endif
+
+ifdef NEEDS_LIBICONV
+	EXTLIBS += -liconv
+endif
 
 GIT_LIB = ../../libgit.a
 VCSSVN_LIB = ../../vcs-svn/lib.a
-LIBS = $(VCSSVN_LIB) $(GIT_LIB) $(EXTLIBS)
+XDIFF_LIB = ../../xdiff/lib.a
+
+LIBS = $(VCSSVN_LIB) $(GIT_LIB) $(XDIFF_LIB)
 
 QUIET_SUBDIR0 = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1 =
@@ -33,12 +73,11 @@ ifndef V
 endif
 endif
 
-svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(GIT_LIB)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ svn-fe.o \
-		$(ALL_LDFLAGS) $(LIBS)
+svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(XDIFF_LIB) $(GIT_LIB)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(EXTLIBS) -o $@ svn-fe.o $(LIBS)
 
 svn-fe.o: svn-fe.c ../../vcs-svn/svndump.h
-	$(QUIET_CC)$(CC) -I../../vcs-svn -o $*.o -c $(ALL_CFLAGS) $<
+	$(QUIET_CC)$(CC) $(CFLAGS) -I../../vcs-svn -o $*.o -c $<
 
 svn-fe.html: svn-fe.txt
 	$(QUIET_SUBDIR0)../../Documentation $(QUIET_SUBDIR1) \
@@ -54,6 +93,9 @@ svn-fe.1: svn-fe.txt
 ../../vcs-svn/lib.a: FORCE
 	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) vcs-svn/lib.a
 
+../../xdiff/lib.a: FORCE
+	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) xdiff/lib.a
+
 ../../libgit.a: FORCE
 	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) libgit.a
 
-- 
1.8.5.2 (Apple Git-48)
