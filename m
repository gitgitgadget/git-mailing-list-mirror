From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Deb Packaging fixes: Build against Mozilla libs for Debian, conflict with "git"
Date: Sat, 23 Jul 2005 15:26:32 -0400
Message-ID: <20050723192632.GB24071@mythryan2.michonline.com>
References: <20050723073707.GA3255@mythryan2.michonline.com> <Pine.LNX.4.58.0507230921320.6074@g5.osdl.org> <20050723192335.GA24071@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Sebastian Kuzminsky <seb@highlab.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 21:26:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwPdu-00079Z-DF
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 21:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVGWT0e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 15:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVGWT0e
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 15:26:34 -0400
Received: from mail.autoweb.net ([198.172.237.26]:60596 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261453AbVGWT0d (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2005 15:26:33 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DwPdp-0003Ch-5U; Sat, 23 Jul 2005 15:26:33 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DwPmE-0000qp-00; Sat, 23 Jul 2005 15:35:14 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DwPdo-0000pH-5a; Sat, 23 Jul 2005 15:26:32 -0400
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <20050723192335.GA24071@mythryan2.michonline.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch includes two fixes to the git-core Debian package:

    * Conflict with the GNU Interactive Tools package, which _also_
      wants to install /usr/bin/git.

    * Compile against the unencumbered Mozilla SHA1 code, instead of
      the iffy OpenSSL code, as much as possible.  This makes it easier to get
      the package included for distribution with Debian.

This has been based upon the original patch by Sebastian Kuzminsky
<seb@highlab.com>, but has been fixed up based upon feedback.

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---

 changelog |   10 ++++++++++
 control   |    3 ++-
 rules     |   14 ++++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/debian/changelog b/debian/changelog
--- a/debian/changelog
+++ b/debian/changelog
@@ -1,3 +1,13 @@
+git-core (0.99-2) unstable; urgency=low
+
+  * Conflict with the GNU Interactive Tools package, which also installs
+    /usr/bin/git.
+  * Use the Mozilla SHA1 code and/or the PPC assembly in preference to
+    OpenSSL.  This is only a partial fix for the license issues with OpenSSL.
+  * Minor tweaks to the Depends.
+
+ -- Ryan Anderson <ryan@michonline.com>  Sat, 23 Jul 2005 14:15:00 -0400
+
 git-core (0.99-1) unstable; urgency=low
 
   * Update deb package support to build correctly. 
diff --git a/debian/control b/debian/control
--- a/debian/control
+++ b/debian/control
@@ -7,7 +7,8 @@ Standards-Version: 3.6.1
 
 Package: git-core
 Architecture: any
-Depends: ${misc:Depends}, shellutils, diff, rsync, rcs
+Depends: ${misc:Depends}, patch, diff, rsync, rcs, ssh
+Conflicts: git
 Description: The git content addressable filesystem
  GIT comes in two layers. The bottom layer is merely an extremely fast
  and flexible filesystem-based database designed to store directory trees
diff --git a/debian/rules b/debian/rules
--- a/debian/rules
+++ b/debian/rules
@@ -12,6 +12,20 @@ else
 endif
 export CFLAGS
 
+#
+# On PowerPC we compile against the hand-crafted assembly, on all
+# other architectures we compile against GPL'ed sha1 code lifted
+# from Mozilla.  OpenSSL is strangely licensed and best avoided
+# in Debian.
+#
+HOST_ARCH=$(shell dpkg-architecture -qDEB_HOST_ARCH)
+ifeq (${HOST_ARCH},powerpc)
+	export PPC_SHA1=YesPlease
+else
+	export MOZILLA_SHA1=YesPlease
+endif
+
+
 PREFIX := /usr
 MANDIR := /usr/share/man/
 

-- 

Ryan Anderson
  sometimes Pug Majere
