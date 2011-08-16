From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v3 02/10] svn-fe: add EXTLIBS needed for parse-options
Date: Tue, 16 Aug 2011 15:54:47 +0600
Message-ID: <1313488495-2203-3-git-send-email-divanorama@gmail.com>
References: <1313488495-2203-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 11:54:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtGLf-00089W-K1
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 11:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025Ab1HPJyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 05:54:01 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61184 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab1HPJx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 05:53:58 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3585259bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 02:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JxcTjB45j8gy/rx6lUG405nqIk2AWNIORfTwngjSGyY=;
        b=BWMZ6xWo/DpjJc082f/HnN2AIneCLn7Ou8zv4URsOHhdu3HvraTxs7RoU/D1KU9B/T
         fG/+vgV+ZKGJHkZvQyJNyd9KdDyQj+xhgUGJkAil7uM2HpX2K+VhtkvSx1/i7r3wbAdX
         x3SebZINYLwuLCbFnoLvGfb9oC3OEJhxEsIEY=
Received: by 10.205.64.81 with SMTP id xh17mr909563bkb.343.1313488437724;
        Tue, 16 Aug 2011 02:53:57 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id zx9sm1841723bkb.61.2011.08.16.02.53.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 02:53:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313488495-2203-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179415>

Currently parse-options.o pull quite a big bunch of dependencies
that are neither pulled in by svn-fe Makefile nor included in libgit.a.

Use a temporary hack: put hardcoded EXTLIBS, this may not work in all
setups because /Makefile logic is not repeated. The list of extlibs
is likely to be exhaustive, but one may need to adjust it.

-lcrypto is needed for SHA-1 routines unless NO_OPENSSL or BLK_SHA1
is set, -lpcre is for grep if USE_LIBPCRE is set, and -lz is needed
throughout.

In the future, none of these should be needed, after a little
rearranging to ensure that parse-options.o has no references to
translation units that need to access the object db.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/svn-fe/Makefile |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index bc03a3e..8b12df1 100644
--- a/contrib/svn-fe/Makefile
+++ b/contrib/svn-fe/Makefile
@@ -8,11 +8,12 @@ CFLAGS = -g -O2 -Wall
 LDFLAGS =
 ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
-EXTLIBS =
+EXTLIBS = -lssl -lcrypto -lpcre -lz -lpthread
 
 GIT_LIB = ../../libgit.a
 VCSSVN_LIB = ../../vcs-svn/lib.a
-LIBS = $(VCSSVN_LIB) $(GIT_LIB) $(EXTLIBS)
+XDIFF_LIB = ../../xdiff/lib.a
+LIBS = $(VCSSVN_LIB) $(GIT_LIB) $(XDIFF_LIB) $(EXTLIBS)
 
 QUIET_SUBDIR0 = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1 =
@@ -53,11 +54,8 @@ svn-fe.1: svn-fe.txt
 		../contrib/svn-fe/$@
 	$(MV) ../../Documentation/svn-fe.1 .
 
-../../vcs-svn/lib.a: FORCE
-	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) vcs-svn/lib.a
-
-../../libgit.a: FORCE
-	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) libgit.a
+$(VCSSVN_LIB) $(GIT_LIB) $(XDIFF_LIB): ../../%.a: FORCE
+	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $*.a
 
 clean:
 	$(RM) svn-fe$X svn-fe.o svn-fe.html svn-fe.xml svn-fe.1
-- 
1.7.3.4
