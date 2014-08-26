From: Maxim Bublis <satori@yandex-team.ru>
Subject: [PATCH] contrib/svn-fe: fix Makefile
Date: Tue, 26 Aug 2014 16:44:22 +0400
Message-ID: <1409057062-72857-1-git-send-email-satori@yandex-team.ru>
Cc: Maxim Bublis <satori@yandex-team.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 16:12:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMHU7-0002dH-Iu
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 16:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758472AbaHZOMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 10:12:22 -0400
Received: from 95.108.175.165-red.dhcp.yndx.net ([95.108.175.165]:61093 "EHLO
	95.108.175.165-red.dhcp.yndx.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758466AbaHZOMU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Aug 2014 10:12:20 -0400
X-Greylist: delayed 5133 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Aug 2014 10:12:19 EDT
Received: by 95.108.175.165-red.dhcp.yndx.net (Postfix, from userid 1533206276)
	id E1F3F2000B56; Tue, 26 Aug 2014 16:46:15 +0400 (MSK)
X-Mailer: git-send-email 1.8.5.2 (Apple Git-48)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255905>

Fixes several problems:
  * include config.mak.uname, config.mak.autogen and config.mak
    in order to use settings for prefix and other such things;
  * link xdiff/lib.a as it is a requirement for libgit.a;
  * fix CFLAGS and EXTLIBS for Linux and Mac OS X.
---
 contrib/svn-fe/Makefile | 47 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index 360d8da..8e1d622 100644
--- a/contrib/svn-fe/Makefile
+++ b/contrib/svn-fe/Makefile
@@ -1,18 +1,45 @@
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
+	CFLAGS += -I/opt/local/include
+	LDFLAGS += -L/opt/local/lib
+endif
+
+ifndef NO_OPENSSL
+	EXTLIBS += -lssl -lcrypto
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
@@ -33,12 +60,11 @@ ifndef V
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
@@ -54,6 +80,9 @@ svn-fe.1: svn-fe.txt
 ../../vcs-svn/lib.a: FORCE
 	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) vcs-svn/lib.a
 
+../../xdiff/lib.a: FORCE
+	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) xdiff/lib.a
+
 ../../libgit.a: FORCE
 	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) libgit.a
 
-- 
1.8.5.2 (Apple Git-48)
