From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 2/4] Integrate remote-svn into svn-fe/Makefile.
Date: Mon,  4 Jun 2012 19:20:53 +0200
Message-ID: <1338830455-3091-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1338830455-3091-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 19:21:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbayK-0003FD-85
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 19:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801Ab2FDRVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 13:21:35 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51121 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681Ab2FDRV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 13:21:26 -0400
Received: by mail-bk0-f46.google.com with SMTP id ji2so3818493bkc.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dTWLCCMJw2yrbvLRGPK9teZPaaruVjSmpo4Y4ncWtLo=;
        b=UOczk9/VF/F3+GwS3uRW3bqD1C2bhJyoJwb+RrT+yvrXicFSQ/pD0J7VEiVt00Rm4W
         iTYQqnnDKUhb/I11yfmB9zFtF9l4n+uoYI3+5jXXjJf1/0Icb3l+rfGoJAwNsIlEOvKE
         u2MzFoayJxVbqi2AgfsgSzrUtEQEGpRUqgMIcY3uqCnP1lGra0Wa0o8kbdfxub/Ej0+7
         FysRAhHEvLdn6Niu9nX4p9XExDS/mw1F0JAkzKisxoVc6eG91WGc6BgkTk+dYzP8FcEX
         TcqH654IRJfO+SOvR5IQbXLfkJvJiHMvfvgM7DDIUK82GnVB+PJSGlIn0SIig4GflNF4
         /Iwg==
Received: by 10.205.133.19 with SMTP id hw19mr7583860bkc.0.1338830485372;
        Mon, 04 Jun 2012 10:21:25 -0700 (PDT)
Received: from flobuntu.lan (m-149.vc-graz.ac.at. [193.170.224.149])
        by mx.google.com with ESMTPS id m2sm11224637bkm.2.2012.06.04.10.21.23
        (version=SSLv3 cipher=OTHER);
        Mon, 04 Jun 2012 10:21:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1338830455-3091-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199158>

Requires some sha.h to be used and the libraries
to be linked, this is currently hardcoded.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 contrib/svn-fe/Makefile |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index 360d8da..253324f 100644
--- a/contrib/svn-fe/Makefile
+++ b/contrib/svn-fe/Makefile
@@ -1,14 +1,14 @@
-all:: svn-fe$X
+all:: svn-fe$X remote-svn$X
 
 CC = gcc
 RM = rm -f
 MV = mv
 
-CFLAGS = -g -O2 -Wall
+CFLAGS = -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'
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
-- 
1.7.9.5
