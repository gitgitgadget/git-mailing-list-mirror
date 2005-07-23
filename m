From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Deb packages should include the binaries (Try 2 - this time it actually applies)
Date: Fri, 22 Jul 2005 22:31:59 -0700
Message-ID: <7voe8u5bqo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 07:32:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwCcT-0003WI-LH
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 07:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVGWFcC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 01:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVGWFcC
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 01:32:02 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:9151 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261205AbVGWFcB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 01:32:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050723053159.YLMV18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 23 Jul 2005 01:31:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

From: Ryan Anderson <ryan@michonline.com>
Date: 1122011756 -0400

The Deb packages were missing a dependency on "build install" from the
binary target - this fixes that, and cleans up some inconsistencies
elsewhere in the rulesets.

Traditionally, Debian packaging uses a file called "build-stamp" (or
"install-stamp", etc) in the main source tree.  The initial deb package
support for Git tried to move this "build-stamp" file into the debian/
directory, but some instances were missed.  That problem, however, was
incidental - the real fix is the missing dependency mentioned above.

(version 2 of this patch.  I missed an early commit in v1 that made the old
patch impossible to apply.)

Signed-off-by: Ryan Anderson <ryan@michonline.com>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 debian/changelog |    8 +++++++-
 debian/control   |    2 +-
 debian/rules     |   10 +++++-----
 3 files changed, 13 insertions(+), 7 deletions(-)

469775a2f3b479cd4bbd930754e59601a7132f68
diff --git a/debian/changelog b/debian/changelog
--- a/debian/changelog
+++ b/debian/changelog
@@ -1,5 +1,11 @@
+git-core (0.99-1) unstable; urgency=low
+
+  * Update deb package support to build correctly. 
+
+ -- Ryan Anderson <ryan@michonline.com>  Thu, 21 Jul 2005 02:03:32 -0400
+
 git-core (0.99-0) unstable; urgency=low
-	
+
   * Initial deb package support
 
  -- Eric Biederman <ebiederm@xmission.com>  Tue, 12 Jul 2005 10:57:51 -0600
diff --git a/debian/control b/debian/control
--- a/debian/control
+++ b/debian/control
@@ -7,7 +7,7 @@ Standards-Version: 3.6.1
 
 Package: git-core
 Architecture: any
-Depends: ${shlibs:Depends}, shellutils, diff, rsync, rcs
+Depends: ${misc:Depends}, shellutils, diff, rsync, rcs
 Description: The git content addressable filesystem
  GIT comes in two layers. The bottom layer is merely an extremely fast
  and flexible filesystem-based database designed to store directory trees
diff --git a/debian/rules b/debian/rules
--- a/debian/rules
+++ b/debian/rules
@@ -21,8 +21,8 @@ DESTDIR  := $(CURDIR)/debian/tmp
 DOC_DESTDIR := $(DESTDIR)/usr/share/doc/git-core/
 MAN_DESTDIR := $(DESTDIR)/$(MANDIR)
 
-build: build-stamp
-build-stamp:
+build: debian/build-stamp
+debian/build-stamp:
 	dh_testdir
 	$(MAKE) all doc
 	touch debian/build-stamp
@@ -36,7 +36,7 @@ debian-clean:
 clean: debian-clean
 	$(MAKE) clean
 
-install: debian/build-stamp
+install: build
 	dh_testdir
 	dh_testroot
 	dh_clean -k 
@@ -47,9 +47,9 @@ install: debian/build-stamp
 	mkdir -p $(DOC_DESTDIR)
 	find $(DOC) '(' -name '*.txt' -o -name '*.html' ')' -exec install {} $(DOC_DESTDIR) ';'
 
-	dh_install --sourcedir=$(DESTDIR)
+	dh_install --list-missing --sourcedir=$(DESTDIR)
 
-binary:
+binary: build install
 	dh_testdir
 	dh_testroot
 	dh_installchangelogs
