From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Deb Packaging fixes: Build against Mozilla libs for Debian, conflict with "git"
Date: Sat, 23 Jul 2005 03:37:07 -0400
Message-ID: <20050723073707.GA3255@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Sebastian Kuzminsky <seb@highlab.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 09:38:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwEa4-00021O-EY
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 09:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVGWHhL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 03:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVGWHhL
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 03:37:11 -0400
Received: from mail.autoweb.net ([198.172.237.26]:23213 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261456AbVGWHhJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2005 03:37:09 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DwEZI-0004ty-0K; Sat, 23 Jul 2005 03:37:08 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DwEhZ-0003p5-00; Sat, 23 Jul 2005 03:45:41 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DwEZH-0000tE-Az; Sat, 23 Jul 2005 03:37:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch includes two fixes to the git-core Debian package:

    * Conflict with the GNU Interactive Tools package, which _also_
      wants to install /usr/bin/git.

    * Compile against the unencumbered Mozilla SHA1 code, instead of
      the iffy OpenSSL code.  This makes it easier to get the package
      included for distribution with Debian.

Note: Assumes that Ryan Anderson's patch "Deb packages should include
the binaries" has been applied.

(Note - I fixed up the conflicts against my earlier packaging fixes -- Ryan)

Signed-off-by: Sebastian Kuzminsky <seb@highlab.com>
Signed-off-by: Ryan Anderson <ryan@michonline.com>
---

 debian/changelog |   11 +++++++++++
 debian/control   |    3 ++-
 debian/rules     |   14 ++++++++++++++
 3 files changed, 27 insertions(+), 1 deletions(-)

c651cdc175712c26d4b9c8b75b44a89eb1b74752
diff --git a/debian/changelog b/debian/changelog
--- a/debian/changelog
+++ b/debian/changelog
@@ -1,3 +1,14 @@
+git-core (0.99.1-1) unstable; urgency=low
+
+  * Conflict with the GNU Interactive Tools package, which also installs
+    /usr/bin/git.
+  * Dont compile against the OpenSSL SHA1 code, it's problematically
+    licensed.  Instead use the PPC assembly on PPC, and the code ripped
+    from Mozilla everywhere else.
+  * Minor tweaks to the Build-Depends.
+
+ -- Sebastian Kuzminsky <seb@highlab.com>  Thu, 21 Jul 2005 01:28:35 -0600
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
+Depends: ${misc:Depends}, patch, diff, rsync, rcs, wget, rsh-client
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
