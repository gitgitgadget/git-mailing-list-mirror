From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Deb packages should include the binaries (Try 2 - this time it actually applies)
Date: Fri, 22 Jul 2005 01:55:56 -0400
Message-ID: <20050722055556.GR20369@mythryan2.michonline.com>
References: <20050721061545.GM20369@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jul 22 07:56:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DvqW1-0007G3-7m
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 07:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVGVFz7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 01:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVGVFz7
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 01:55:59 -0400
Received: from mail.autoweb.net ([198.172.237.26]:5092 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S262036AbVGVFz5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 01:55:57 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DvqVo-0003Hr-NT; Fri, 22 Jul 2005 01:55:56 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Dvqdx-0001rv-00; Fri, 22 Jul 2005 02:04:21 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DvqVo-0002lY-5s; Fri, 22 Jul 2005 01:55:56 -0400
To: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050721061545.GM20369@mythryan2.michonline.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


The Deb packages were mising a dependency on "build install" from the
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
-- 

Ryan Anderson
  sometimes Pug Majere
