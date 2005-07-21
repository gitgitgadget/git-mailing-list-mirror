From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Deb packages should include the binaries
Date: Thu, 21 Jul 2005 02:15:45 -0400
Message-ID: <20050721061545.GM20369@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jul 21 08:16:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DvULp-0008TW-0W
	for gcvg-git@gmane.org; Thu, 21 Jul 2005 08:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVGUGPs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jul 2005 02:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVGUGPs
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jul 2005 02:15:48 -0400
Received: from mail.autoweb.net ([198.172.237.26]:35514 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261652AbVGUGPq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jul 2005 02:15:46 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DvULS-0006Fg-FH; Thu, 21 Jul 2005 02:15:46 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DvUTT-0000v0-00; Thu, 21 Jul 2005 02:24:03 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DvULR-0007hm-Q3; Thu, 21 Jul 2005 02:15:45 -0400
To: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
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
@@ -49,7 +49,7 @@ install: debian/build-stamp
 
 	dh_install --list-missing --sourcedir=$(DESTDIR)
 
-binary:
+binary: build install
 	dh_testdir
 	dh_testroot
 	dh_installchangelogs
-- 

Ryan Anderson
  sometimes Pug Majere
