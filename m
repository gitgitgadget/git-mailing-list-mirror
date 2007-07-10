From: Matt McCutchen <hashproduct@gmail.com>
Subject: [PATCH] Makefile: rebuild git.o on version change, clean up git$X
	flags
Date: Mon, 09 Jul 2007 21:30:39 -0400
Message-ID: <1184031039.14364.11.camel@mattlaptop2>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 03:31:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I84ZI-0004q6-Ot
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 03:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760612AbXGJBap (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 21:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761346AbXGJBap
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 21:30:45 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:46836 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760612AbXGJBao (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 21:30:44 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1048418wxd
        for <git@vger.kernel.org>; Mon, 09 Jul 2007 18:30:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=NWrNXdWV0SLVZJw+/DRBuVyXpaWipYMOkERdq7RiM3RHqmgcLgyPPkZDe86P8VL2iTPaQSHK6+BJWKKXbc8NMlaJgS7Vvj82YA7eLXc7T9V1A4/B1lX06vchZDqkws5Z/MEYYYXdcVvlcIfd41j70K+gzMOP70+h5FJxHQvWEjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=bD179uHr/0RzSa5Cp0aMbZjWHOQHM1NhsXZZOtr+J4HCAi9zR8BN2MmB8BAUmiV1LZmk0XL/FOAh6H+sYT08u/f4n6hXcqpa8qtmMQPPq5YvaVFyW0AgPci44BVHgDhvxj5Tl5yZe/EZT5qFWaKEXKDPzVriI4URj8GalKM3U1I=
Received: by 10.70.59.20 with SMTP id h20mr6758606wxa.1184031043665;
        Mon, 09 Jul 2007 18:30:43 -0700 (PDT)
Received: from ?192.168.1.10? ( [69.234.35.98])
        by mx.google.com with ESMTP id s30sm16453445elf.2007.07.09.18.30.42
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Jul 2007 18:30:42 -0700 (PDT)
X-Mailer: Evolution 2.10.2 (2.10.2-3.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52030>

Commit 334d28ae factored out git.o as an intermediate stage between
git.c and git$X.  However:

- It left some no-longer-relevant flags in the rule for git$X.

- It failed to replace git$X with git.o in the list of files that
  record GIT_VERSION.  This broke incorporation of a changed
  GIT_VERSION into git$X because, when GIT_VERSION changes, git.o isn't
  remade and git$X is relinked from the git.o that still contains the
  old GIT_VERSION.

This patch removes the irrelevant flags and fixes incorporation of a
changed GIT_VERSION into git$X.

Signed-off-by: Matt McCutchen <hashproduct@gmail.com>
---
Amusingly, I found this because, when I formatted my previous patch for
submission, I noticed that the "-dirty" in the version at the bottom
wouldn't go away even though I had committed my changes to my
git-development repository.  (I was actually using the git tools from
that repository.)

 Makefile |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 5b30e5c..d7541b4 100644
--- a/Makefile
+++ b/Makefile
@@ -753,8 +753,7 @@ git.o: git.c common-cmds.h GIT-CFLAGS
 		$(ALL_CFLAGS) -c $(filter %.c,$^)
 
 git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
-	$(QUIET_LINK)$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
-		$(ALL_CFLAGS) -o $@ $(filter %.c,$^) git.o \
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
 help.o: common-cmds.h
@@ -857,7 +856,7 @@ configure: configure.ac
 	rm -f $<+
 
 # These can record GIT_VERSION
-git$X git.spec \
+git.o git.spec \
 	$(patsubst %.sh,%,$(SCRIPT_SH)) \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
-- 
1.5.3.rc0.83.gb18a6
