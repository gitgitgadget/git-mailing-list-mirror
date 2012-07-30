From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC v2 02/16] Integrate remote-svn into svn-fe/Makefile.
Date: Mon, 30 Jul 2012 16:31:09 +0200
Message-ID: <1343658683-10713-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 16:39:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svr84-0007vB-07
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 16:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725Ab2G3OjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 10:39:16 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39226 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720Ab2G3OjO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 10:39:14 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so2859087bkw.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 07:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Xy4afZiaSJm9yotdqNoZbsgampJErMG8UtMFFgK0WS0=;
        b=V4OD6XJ85O1oV2L/c9/vlwAh7N43xpNGpZml5fKh7+qGHEyuuhKlkNV5ALoHLsCQXv
         ncMoDY0c30FS/F6WrSYr+w00dlJbv1Z+FC4YxL9KKxv/8+mVftQsPg1wuiMRP10CkqXS
         arbDwYp+nM3I2Rl0z+IpzgH5LDD9NRP9zEmgnHM/K2cagc4OOH9RcQP/ahVheiAnWv4K
         DeRb+i9vg2HW+Imph2L3dxap4XFpAnmK4j/eeOgBaNHjqPRc6d1fCnJQ+9vluka6nEt8
         VyMZ71AlUVbo+AWSf8Rg36lRS1/EVCwVo+7y77eg8mm5+eHHuSr9KibMdqXXNXk3b50e
         N+Uw==
Received: by 10.204.145.82 with SMTP id c18mr3900035bkv.133.1343659153722;
        Mon, 30 Jul 2012 07:39:13 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id fu8sm3945866bkc.5.2012.07.30.07.39.11
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 07:39:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343658683-10713-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202546>

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
