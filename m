From: Giovanni Funchal <gafunchal@gmail.com>
Subject: [PATCH 1/2] Allow configure to override CC_LD_DYNPATH
Date: Sat, 16 Aug 2008 15:01:07 +0200
Message-ID: <1218891667-6014-1-git-send-email-gafunchal@gmail.com>
Cc: Giovanni Funchal <gafunchal@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 16 15:02:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KULQQ-0001fa-Qs
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 15:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbYHPNBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 09:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbYHPNBK
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 09:01:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:25648 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbYHPNBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 09:01:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1162787fgg.17
        for <git@vger.kernel.org>; Sat, 16 Aug 2008 06:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=1YvwTwU9LVoE26lh2PJK7gFJ0GT4wXVoCiuJcOZJVLg=;
        b=Gd9eC/XUMIrP2xreELR7QqPARn72top8pxOr4RD7E9XiXJxrB21zeX4xb/rABuk6ts
         Rt12qcm92ODfOR1CkBX9Mdpbno7txsW/rfOTdyKMZRoK/yR+fPilog/go51L4M7Sfo01
         7HXRLn8XVpFlPDhyRbgVXWEMabv3TWJQ7DT2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TcS5W+wHWT0GImIM52xxDjd+ar4cV+7VXPp6Pqfg43jzdCP2pZ5n2qbHfOHGAQEbOA
         mfSH+BJopJL6S1+3qNKii7cfstVMvjvj2mx+XI590cdZmgT/eMOszOtSVV1DXWn65I+a
         +HGmpPDkvgHj3tdw0bvkROBWJtSOafk6/iPZg=
Received: by 10.86.52.6 with SMTP id z6mr2943955fgz.48.1218891667612;
        Sat, 16 Aug 2008 06:01:07 -0700 (PDT)
Received: from localhost.localdomain ( [85.69.129.210])
        by mx.google.com with ESMTPS id 3sm275347fge.3.2008.08.16.06.01.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Aug 2008 06:01:06 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc3.19.g4db473
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92545>

Current Makefile does not allow configure to override CC_LD_DYNPATH because
"-include config.mak" comes after the "ifdef NO_R_TO_GCC_LINKER". This patch
moves the referred ifdef.

In addition, another piece of code was moved because the CC_LD_DYNPATH should
be also used by ALL_LDFLAGS on NetBSD.

Signed-Off-By: Giovanni Funchal <gafunchal@gmail.com>
---

Ok, this is my third try... I have split the patch into two parts this time.
This first one concerns only the minimal support needed on the Makefile side.
The next one is the one that does the interesting thing. Sorry for my
newbieness and hope it is up to Git coding standards this time :)

I have also changed some comments and replaced "-Wl,-rpath=" by
"-Wl,-rpath," for the sake of homogeneity. This should be equivalent
everywhere. Thanks Matthieu and Junio for the help.

 Makefile |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 53ab4b5..2572b4b 100644
--- a/Makefile
+++ b/Makefile
@@ -113,7 +113,7 @@ all::
 #
 # Define NO_R_TO_GCC_LINKER if your gcc does not like "-R/path/lib"
 # that tells runtime paths to dynamic libraries;
-# "-Wl,-rpath=/path/lib" is used instead.
+# "-Wl,-rpath,/path/lib" is used instead.
 #
 # Define USE_NSEC below if you want git to care about sub-second file mtimes
 # and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
@@ -689,7 +689,6 @@ ifeq ($(uname_S),NetBSD)
 	endif
 	BASIC_CFLAGS += -I/usr/pkg/include
 	BASIC_LDFLAGS += -L/usr/pkg/lib
-	ALL_LDFLAGS += -Wl,-rpath,/usr/pkg/lib
 endif
 ifeq ($(uname_S),AIX)
 	NO_STRCASESTR=YesPlease
@@ -763,9 +762,21 @@ ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
 endif
 
+# Runtime dynamic library path switch
+ifdef NO_R_TO_GCC_LINKER
+	# Some linkers use -Wl,-rpath,
+	CC_LD_DYNPATH = -Wl,-rpath,
+else
+	# Some others need -R
+	CC_LD_DYNPATH = -R
+endif
+
 -include config.mak.autogen
 -include config.mak
 
+ifeq ($(uname_S),NetBSD)
+	ALL_LDFLAGS += $(CC_LD_DYNPATH)/usr/pkg/lib
+endif
 ifeq ($(uname_S),Darwin)
 	ifndef NO_FINK
 		ifeq ($(shell test -d /sw/lib && echo y),y)
@@ -781,19 +792,11 @@ ifeq ($(uname_S),Darwin)
 	endif
 endif
 
-ifdef NO_R_TO_GCC_LINKER
-	# Some gcc does not accept and pass -R to the linker to specify
-	# the runtime dynamic library path.
-	CC_LD_DYNPATH = -Wl,-rpath=
-else
-	CC_LD_DYNPATH = -R
-endif
-
 ifdef NO_CURL
 	BASIC_CFLAGS += -DNO_CURL
 else
 	ifdef CURLDIR
-		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
+		# Try specifying runtime dynamic library path in such a case.
 		BASIC_CFLAGS += -I$(CURLDIR)/include
 		CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -lcurl
 	else
-- 
1.5.4.3
