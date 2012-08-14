From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v3 02/16] Integrate remote-svn into svn-fe/Makefile.
Date: Tue, 14 Aug 2012 21:13:04 +0200
Message-ID: <1344971598-8213-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 21:17:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Mbt-0002wf-Ai
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 21:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989Ab2HNTQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 15:16:55 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44490 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755740Ab2HNTQy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 15:16:54 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so265503bkw.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 12:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Xy4afZiaSJm9yotdqNoZbsgampJErMG8UtMFFgK0WS0=;
        b=C5mUAT/CMy/xhavfp2rfrvdaCgfiWDychQVJNqQkLZjDQUv242Mlx53Xc/WtRSK+lJ
         OcP5qFJNy4O0aQIHco2GHEqstCGsmP6NuIAYlE7YhoO0kMfJR7YhPgs7XQfVhFFWo9Wd
         YqyE29H1hrJF0NpmZTd3RCW21K62mU/onYHnOAG/dINI1+LUOyi/l3Ax7TTENdRInzNd
         lBKJWIOI92xHpn9IhTWtYElxVfYOQoNJOsuJ2LEOqgYptnjpCy9xqNDpMOGZ7RQkpHyw
         YW5u+oHOxLqYpK8qaoN2CUmXMPy/9jdulsHScWuKndMqd6F4YFP0HWW9Q+PsMxbtIwFJ
         b/uQ==
Received: by 10.204.130.209 with SMTP id u17mr6797699bks.35.1344971814214;
        Tue, 14 Aug 2012 12:16:54 -0700 (PDT)
Received: from localhost.localdomain (089144206125.atnat0015.highway.a1.net. [89.144.206.125])
        by mx.google.com with ESMTPS id fu8sm1681583bkc.5.2012.08.14.12.16.45
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Aug 2012 12:16:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203426>

Requires some sha.h to be used and the libraries
to be linked, this is currently hardcoded.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 contrib/svn-fe/Makefile |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index 360d8da..8f0eec2 100644
--- a/contrib/svn-fe/Makefile
+++ b/contrib/svn-fe/Makefile
@@ -1,14 +1,14 @@
-all:: svn-fe$X
+all:: svn-fe$X remote-svn$X
 
 CC = gcc
 RM = rm -f
 MV = mv
 
-CFLAGS = -g -O2 -Wall
+CFLAGS = -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>' -Wdeclaration-after-statement
 LDFLAGS =
 ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
-EXTLIBS =
+EXTLIBS = -lssl -lcrypto -lpthread ../../xdiff/lib.a
 
 GIT_LIB = ../../libgit.a
 VCSSVN_LIB = ../../vcs-svn/lib.a
@@ -37,8 +37,12 @@ svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(GIT_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ svn-fe.o \
 		$(ALL_LDFLAGS) $(LIBS)
 
-svn-fe.o: svn-fe.c ../../vcs-svn/svndump.h
-	$(QUIET_CC)$(CC) -I../../vcs-svn -o $*.o -c $(ALL_CFLAGS) $<
+remote-svn$X: remote-svn.o $(VCSSVN_LIB) $(GIT_LIB)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ remote-svn.o \
+		$(ALL_LDFLAGS) $(LIBS)
+		
+%.o: %.c ../../vcs-svn/svndump.h
+	$(QUIET_CC)$(CC) -I../../vcs-svn -I../../ -o $*.o -c $(ALL_CFLAGS) $<
 
 svn-fe.html: svn-fe.txt
 	$(QUIET_SUBDIR0)../../Documentation $(QUIET_SUBDIR1) \
@@ -58,6 +62,6 @@ svn-fe.1: svn-fe.txt
 	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) libgit.a
 
 clean:
-	$(RM) svn-fe$X svn-fe.o svn-fe.html svn-fe.xml svn-fe.1
+	$(RM) svn-fe$X svn-fe.o svn-fe.html svn-fe.xml svn-fe.1 remote-svn.o
 
 .PHONY: all clean FORCE
-- 
1.7.9.5
