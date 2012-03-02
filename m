From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [RFC/PATCH] build: avoid possible confusion between GNU/XPG4 make on Solaris
Date: Fri,  2 Mar 2012 10:13:00 +0100
Message-ID: <df98ed215324f521f3aaff7fa4ba41ba2a1894dc.1330679536.git.stefano.lattarini@gmail.com>
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 10:13:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3OYB-0006Ts-P7
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 10:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757804Ab2CBJNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 04:13:13 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41972 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757703Ab2CBJNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 04:13:09 -0500
Received: by eaaq12 with SMTP id q12so521463eaa.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 01:13:08 -0800 (PST)
Received-SPF: pass (google.com: domain of stefano.lattarini@gmail.com designates 10.14.186.12 as permitted sender) client-ip=10.14.186.12;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of stefano.lattarini@gmail.com designates 10.14.186.12 as permitted sender) smtp.mail=stefano.lattarini@gmail.com; dkim=pass header.i=stefano.lattarini@gmail.com
Received: from mr.google.com ([10.14.186.12])
        by 10.14.186.12 with SMTP id v12mr5385036eem.31.1330679588685 (num_hops = 1);
        Fri, 02 Mar 2012 01:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=guGAHmY3OVYA99fbKp2uVCWOLzz5Me/7yZLO9EPhZZo=;
        b=0+ciPVDUPdJxwqh1E8ed7BnAk5jyfggnyP4vPTx847bSE7smhDex9uTKEoUtd1KEF9
         ZH8sh5sP5MlRCjJ/6hr+PjuylBKQyJV1La+ihszDuMZiC2jqUwDS0w6i4jBgeJZ+zHej
         Gy81n9kyD1VFaxk5pk7AcMMJDctMMOIU/Phfkoxx54wRG1qEFUJ7pe7xihvb26hUW++2
         9D6a1B3APD7cuW+JBzo2VEs6+IFajH3OEDEtmB8AOHyhmh+PXCZPe06Zg2bVjSC88tcT
         RRqcroEoiS4WHeN26BHLsyxHSxxoI5IExtQFzT685cxo5gkRih/9xZNvzQ4jfNXeHjr4
         F2Sg==
Received: by 10.14.186.12 with SMTP id v12mr4145559eem.31.1330679588588;
        Fri, 02 Mar 2012 01:13:08 -0800 (PST)
Received: from localhost.localdomain (host115-100-dynamic.0-79-r.retail.telecomitalia.it. [79.0.100.115])
        by mx.google.com with ESMTPS id n17sm18142922eei.3.2012.03.02.01.13.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 01:13:07 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192015>

On a Solaris 10 system with Solaris XPG4 make installed as /usr/xpg4/bin/make,
GNU make installed as /usr/local/bin/make, and with /usr/local/bin appearing
in $PATH *before* /usr/xpg4/bin, I was seeing errors like this upon invoking
"make all":

        SUBDIR perl
    make: Warning: Ignoring DistributedMake -o option
    Usage : make [ -f makefile ][ -K statefile ]...
    make: Fatal error: Unknown option `-C'

This happens because the Git's Makefiles, when running on Solaris, sanitize
$PATH by prepending /usr/xpg6/bin and /usr/xpg4/bin to it, but in the setup
described above such a behaviour has the unintended consequence of forcing
the use of Solaris make in recursive make invocations, even if the $(MAKE)
macro is being correctly used in them; this happens because, in that setup,
the original GNU make process was invoked simply as "make".

To avoid such an issue, we instruct our Makefile to redefine $(MAKE) to
point to the absolute path of the originally-invoked make program.
---

 The implementation is still rough and not completely portable, but before
 investing more time in refining it I'd like to know if you gitsters think
 the idea behind it is sound.

 Regards,
   Stefano

 Makefile |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index e4f8e0e..8cba6e8 100644
--- a/Makefile
+++ b/Makefile
@@ -303,6 +303,19 @@ ifdef MSVC
 	uname_O := Windows
 endif
 
+# This Makefile will possibly sanitize PATH by prepending system-specific
+# directories to it (e.g., /usr/xpg4/bin on Solaris).  This can become
+# problematic for recursive make invocations, if one of those directories
+# contains a "make" program and the user has called GNU make by simply
+# invoking "make" (this can happen e.g. when GNU make has been installed
+# as /usr/local/bin/make).  To avoid such issues, we redefine $(MAKE) to
+# point to the absolute path of the originally-invoked make program.
+# FIXME: this is ugly, and which(1) is quite unportable.  Find a better
+# 	 way to obtain the same effect.
+MAKE := $(shell set $(MAKE); m1=$$1; shift; \
+                m2=`which $$m1 2>/dev/null` && test -n "$$m2" || m2=$$m1; \
+                echo "$$m2 $$*")
+
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
 CFLAGS = -g -O2 -Wall
-- 
1.7.9
