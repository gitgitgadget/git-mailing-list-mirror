From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v4 02/16] Integrate remote-svn into svn-fe/Makefile.
Date: Fri, 17 Aug 2012 22:25:43 +0200
Message-ID: <1345235157-702-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 22:26:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2T87-0005Jc-Ov
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 22:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758882Ab2HQU0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 16:26:48 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33589 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758871Ab2HQU0p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 16:26:45 -0400
Received: by wgbdr13 with SMTP id dr13so3663336wgb.1
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 13:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SiQoeDKWCN4cXhDcPGlOz0BpuEmc4RRnuQwo8cll5pc=;
        b=eAxyegjwD9J6LsfRk0Upm1BdwUJYb3CQkVZmjgUfW23+jdQvnBiLso6xxzDfZRNYxY
         0t8PuwGJ1ALsHNyFrI3XbFI8rP1BKUEr8dlYFAxo8yKOa1yvcv/Yl6RrK9mjB2yeg6Pg
         5WNmSMM3CppZ9PqzHYMEoFqD3nntu43drsnjpjXLcmp8AI1l0uyF0QFYBpCFLOsD8Fng
         m6/hPEMS+Na7WJDf6SgNhZPX5Ghlpd68eLHMay0cQT3d9sXE6sX7eC1Yv8wJZb9MXfKO
         9YJBJb4qxvCS8G00OECa3TOVjucNrtFVoXq6p3Yo684rykw7DtokVwISwMypvBuiDZ0H
         919g==
Received: by 10.180.99.196 with SMTP id es4mr7617854wib.18.1345235204511;
        Fri, 17 Aug 2012 13:26:44 -0700 (PDT)
Received: from flobuntu.lan (91-115-81-15.adsl.highway.telekom.at. [91.115.81.15])
        by mx.google.com with ESMTPS id k2sm17372232wiz.7.2012.08.17.13.26.42
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 13:26:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345235157-702-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203644>

Requires some sha.h to be used and the libraries
to be linked, this is currently hardcoded, because
this makefile is only a temporary solution.

Also create a symbolic link in the toplevel dir named
'git-remote-svn' to allow git to find the remote helper.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 contrib/svn-fe/Makefile |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index 360d8da..9f37093 100644
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
@@ -37,8 +37,13 @@ svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(GIT_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ svn-fe.o \
 		$(ALL_LDFLAGS) $(LIBS)
 
-svn-fe.o: svn-fe.c ../../vcs-svn/svndump.h
-	$(QUIET_CC)$(CC) -I../../vcs-svn -o $*.o -c $(ALL_CFLAGS) $<
+remote-svn$X: remote-svn.o $(VCSSVN_LIB) $(GIT_LIB)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ remote-svn.o \
+		$(ALL_LDFLAGS) $(LIBS)
+	ln -sf contrib/svn-fe/$@ ../../git-remote-svn
+		
+%.o: %.c ../../vcs-svn/svndump.h
+	$(QUIET_CC)$(CC) -I../../vcs-svn -I../../ -o $*.o -c $(ALL_CFLAGS) $<
 
 svn-fe.html: svn-fe.txt
 	$(QUIET_SUBDIR0)../../Documentation $(QUIET_SUBDIR1) \
@@ -58,6 +63,7 @@ svn-fe.1: svn-fe.txt
 	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) libgit.a
 
 clean:
-	$(RM) svn-fe$X svn-fe.o svn-fe.html svn-fe.xml svn-fe.1
+	$(RM) svn-fe$X svn-fe.o svn-fe.html svn-fe.xml svn-fe.1 \
+	remote-svn.o ../../git-remote-svn
 
 .PHONY: all clean FORCE
-- 
1.7.9.5
