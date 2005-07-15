From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] Initial support for building a debian package (.deb)
Date: Thu, 14 Jul 2005 19:26:31 -0600
Message-ID: <m1fyugx3js.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 03:27:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtEyY-00050k-KH
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 03:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263099AbVGOB0q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 21:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbVGOB0q
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 21:26:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42429 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263099AbVGOB0q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 21:26:46 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6F1QVJa021989;
	Thu, 14 Jul 2005 19:26:31 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6F1QV1M021988;
	Thu, 14 Jul 2005 19:26:31 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


It's not any harder to include debian package support
than to include a spec file so here is the setup
to build the equivalent debian package.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 debian/changelog         |    5 +++
 debian/control           |   17 ++++++++++
 debian/copyright         |    3 ++
 debian/docs              |    3 ++
 debian/git-core.doc-base |   12 +++++++
 debian/rules             |   81 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 121 insertions(+), 0 deletions(-)
 create mode 100644 debian/changelog
 create mode 100644 debian/control
 create mode 100644 debian/copyright
 create mode 100644 debian/docs
 create mode 100644 debian/git-core.doc-base
 create mode 100644 debian/rules

a1f78e1ec9e95720b8d349d5095ed66b0137f862
diff --git a/debian/changelog b/debian/changelog
new file mode 100644
--- /dev/null
+++ b/debian/changelog
@@ -0,0 +1,5 @@
+git-core (0.99-0) unstable; urgency=low
+	
+  * Initial deb package support
+
+ -- Eric Biederman <ebiederm@xmission.com>  Tue, 12 Jul 2005 10:57:51 -0600
diff --git a/debian/control b/debian/control
new file mode 100644
--- /dev/null
+++ b/debian/control
@@ -0,0 +1,17 @@
+Source: git-core
+Section: devel
+Priority: optional
+Maintainer: Linus Torvalds <torvalds@osdl.org>
+Build-Depends-Indep: libz-dev, libssl-dev, libcurl3-dev, asciidoc > 6.0.3, xmlto, debhelper (>= 4.0.0)
+Standards-Version: 3.6.1
+
+Package: git-core
+Architecture: any
+Depends: ${shlibs:Depends}, shellutils, diff, rysnc, rcs
+Description: The git content addressable filesystem
+ GIT comes in two layers. The bottom layer is merely an extremely fast
+ and flexible filesystem-based database designed to store directory trees
+ with regard to their history. The top layer is a SCM-like tool which
+ enables human beings to work with the database in a manner to a degree
+ similar to other SCM tools (like CVS, BitKeeper or Monotone).
+
diff --git a/debian/copyright b/debian/copyright
new file mode 100644
--- /dev/null
+++ b/debian/copyright
@@ -0,0 +1,3 @@
+License: 
+
+GPL v2 (see COPYING for details)
diff --git a/debian/docs b/debian/docs
new file mode 100644
--- /dev/null
+++ b/debian/docs
@@ -0,0 +1,3 @@
+README
+COPYING
+
diff --git a/debian/git-core.doc-base b/debian/git-core.doc-base
new file mode 100644
--- /dev/null
+++ b/debian/git-core.doc-base
@@ -0,0 +1,12 @@
+Document: git-core
+Title: git-core
+Author: 
+Abstract: This manual describes git
+Section: Devel
+
+Format: HTML
+Index: /usr/share/doc/git-core/html/git.html
+Files: /usr/share/doc/git-core/html/*.html
+
+Format: text
+Files: /usr/share/doc/git-core/git-core.txt
diff --git a/debian/rules b/debian/rules
new file mode 100644
--- /dev/null
+++ b/debian/rules
@@ -0,0 +1,81 @@
+#!/usr/bin/make -f
+# -*- makefile -*-
+
+# Uncomment this to turn on verbose mode.
+#export DH_VERBOSE=1
+
+CFLAGS = -g -Wall
+ifneq (,$(findstring noopt,$(DEB_BUILD_OPTIONS)))
+       CFLAGS += -O0
+else
+       CFLAGS += -O2
+endif
+export CFLAGS
+
+PREFIX := /usr
+MANDIR := /usr/share/man/
+
+SRC    := ./
+DOC    := Documentation/
+DESTDIR  := $(CURDIR)/debian/tmp
+DOC_DESTDIR := $(DESTDIR)/usr/share/doc/git-core/
+MAN_DESTDIR := $(DESTDIR)/$(MANDIR)
+
+build: build-stamp
+build-stamp:
+	dh_testdir
+	$(MAKE) all doc
+	touch debian/build-stamp
+
+debian-clean:
+	dh_testdir
+	dh_testroot
+	rm -f debian/build-stamp
+	dh_clean
+
+clean: debian-clean
+	$(MAKE) clean
+
+install: debian/build-stamp
+	dh_testdir
+	dh_testroot
+	dh_clean -k 
+	dh_installdirs 
+
+	make dest=$(DESTDIR) prefix=$(PREFIX) mandir=$(MANDIR) install install-doc
+
+	mkdir -p $(DOC_DESTDIR)
+	find $(DOC) '(' -name '*.txt' -o -name '*.html' ')' -exec install {} $(DOC_DESTDIR) ';'
+
+	dh_install --sourcedir=$(DESTDIR)
+
+binary:
+	dh_testdir
+	dh_testroot
+	dh_installchangelogs
+	dh_installdocs
+	dh_installexamples
+#	dh_installmenu
+#	dh_installdebconf	
+#	dh_installlogrotate	
+#	dh_installemacsen
+#	dh_installpam
+#	dh_installmime
+#	dh_installinit
+#	dh_installcron
+#	dh_installinfo
+	dh_installman
+	dh_link
+	dh_strip
+	dh_compress 
+	dh_fixperms
+#	dh_perl
+#	dh_python
+	dh_makeshlibs
+	dh_installdeb
+	dh_shlibdeps
+	dh_gencontrol
+	dh_md5sums
+	dh_builddeb
+
+.PHONY: build clean binary install clean debian-clean
