From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 3/8] svn-fe: add EXTLIBS needed for parse-options
Date: Sun,  3 Jul 2011 23:57:52 +0600
Message-ID: <1309715877-13814-4-git-send-email-divanorama@gmail.com>
References: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 19:57:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdQut-00025S-80
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jul 2011 19:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab1GCR4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jul 2011 13:56:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40345 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664Ab1GCR4q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2011 13:56:46 -0400
Received: by bwd5 with SMTP id 5so3614757bwd.19
        for <git@vger.kernel.org>; Sun, 03 Jul 2011 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WDm6ENx8dBbp1xELZgdtIfYKpO6n4iMC7Tj0BUjyYQo=;
        b=cDzH5WzBi2iPF91Ls9OO0MxxajYBFo3xYmLjFDO2VN631p2VfBMj3VGe+1QaXjw2LT
         FZTvx2Vyw1ZZP2MarZw3Fg4CCR5rnCWIkgZHQnoyd+rVrpE0GTqGVaI61Zh0K+S5ryG1
         AYkozWT7Ff9BauZN7X/g+8uZbRf7zd47FoBf4=
Received: by 10.204.114.11 with SMTP id c11mr4832590bkq.54.1309715805425;
        Sun, 03 Jul 2011 10:56:45 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id af13sm4841383bkc.19.2011.07.03.10.56.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jul 2011 10:56:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176580>

Currently parse-options.o pull quite a big bunch of dependencies
that are neither pulled in by svn-fe Makefile nor included in libgit.a.

Use a temporary hack: put hardcoded EXTLIBS, this may not work in all
setups because /Makefile logic is not repeated.

For example, one may need -lcrypto instead of -lssl or no crypto library
if BLK_SHA1 is set, also an additional -lz or -lpcre could be required.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/Makefile |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index bc03a3e..bf1625c 100644
--- a/contrib/svn-fe/Makefile
+++ b/contrib/svn-fe/Makefile
@@ -8,11 +8,12 @@ CFLAGS = -g -O2 -Wall
 LDFLAGS =
 ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
-EXTLIBS =
+EXTLIBS = -lssl -lpthread
 
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
