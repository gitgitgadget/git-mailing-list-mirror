From: Sebastian Kuzminsky <seb@highlab.com>
Subject: [PATCH] debian packaging fixes
Date: Thu, 21 Jul 2005 01:56:07 -0600
Message-ID: <E1DvVuZ-0008QX-8N@highlab.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 09:55:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DvVtZ-000204-0c
	for gcvg-git@gmane.org; Thu, 21 Jul 2005 09:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVGUHy6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jul 2005 03:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVGUHy6
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jul 2005 03:54:58 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:51114 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261677AbVGUHy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2005 03:54:57 -0400
Received: from highlab.com ([67.165.222.77])
          by comcast.net (rwcrmhc14) with ESMTP
          id <20050721075453014009pj4se>; Thu, 21 Jul 2005 07:54:57 +0000
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1DvVuZ-0008QX-8N
	for git@vger.kernel.org; Thu, 21 Jul 2005 01:56:07 -0600
To: git@vger.kernel.org
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

Signed-off-by: Sebastian Kuzminsky <seb@highlab.com>
---

 changelog |   11 +++++++++++
 control   |    3 ++-
 rules     |   14 ++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

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
@@ -7,7 +7,8 @@
 
 Package: git-core
 Architecture: any
-Depends: ${shlibs:Depends}, shellutils, diff, rysnc, rcs
+Depends: ${shlibs:Depends}, patch, diff, rsync, rcs, wget, rsh-client
+Conflicts: git
 Description: The git content addressable filesystem
  GIT comes in two layers. The bottom layer is merely an extremely fast
  and flexible filesystem-based database designed to store directory trees
diff --git a/debian/rules b/debian/rules
--- a/debian/rules
+++ b/debian/rules
@@ -12,6 +12,20 @@
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
Sebastian Kuzminsky
