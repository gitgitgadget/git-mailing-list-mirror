From: Chris Wright <chrisw@osdl.org>
Subject: [GIT PATCH] Add infrastructure for git rpm build
Date: Thu, 7 Jul 2005 13:25:39 -0700
Message-ID: <20050707202539.GP5324@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 22:29:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqczN-00079U-2T
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 22:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVGGU2U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 16:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVGGU0D
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 16:26:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25512 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261363AbVGGUZn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 16:25:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j67KPdjA008195
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Thu, 7 Jul 2005 13:25:40 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j67KPd5q023118;
	Thu, 7 Jul 2005 13:25:39 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j67KPdD0023117;
	Thu, 7 Jul 2005 13:25:39 -0700
To: torvalds@osdl.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus,

You'll find the necessary infrastructure for doing an rpm build here:

	kernel.org/pub/scm/linux/kernel/git/chrisw/git.git

The diff is below:

diff-tree a9db297485a7b8c641d3cf686d03cb63b774e530 (from dd7ba8b4949535c24e604a37709db0e3be9ccbbc)
Author: Chris Wright <chrisw@osdl.org>
Date:   Thu Jul 7 13:09:50 2005 -0700

    Infrastructure for git rpm builds.  Adds GIT_VERSION to Makefile and new make
    targets: git.spec, dist, and rpm.  A simple 'make rpm' will build the rpm.
    Also adds git.spec.in which is used to generate git.spec.
    
    Signed-off-by: Chris Wright <chrisw@osdl.org>

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -9,6 +9,8 @@
 # BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely randomly
 # break unless your underlying filesystem supports those sub-second times
 # (my ext3 doesn't).
+GIT_VERSION=0.99
+
 COPTS=-O2
 CFLAGS=-g $(COPTS) -Wall
 
@@ -49,6 +51,7 @@ PROG=   git-update-cache git-diff-files 
 all: $(PROG)
 
 install: $(PROG) $(SCRIPTS)
+	$(INSTALL) -m755 -d $(dest)$(bin)
 	$(INSTALL) $(PROG) $(SCRIPTS) $(dest)$(bin)
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
@@ -164,6 +167,21 @@ diffcore-break.o : $(LIB_H) diffcore.h
 diffcore-order.o : $(LIB_H) diffcore.h
 epoch.o: $(LIB_H)
 
+git.spec: git.spec.in
+	sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@
+
+GIT_TARNAME=git-$(GIT_VERSION)
+dist: git.spec
+	git-tar-tree HEAD $(GIT_TARNAME) > $(GIT_TARNAME).tar
+	@mkdir -p $(GIT_TARNAME)
+	@cp git.spec $(GIT_TARNAME)
+	tar rf $(GIT_TARNAME).tar $(GIT_TARNAME)/git.spec
+	@rm -rf $(GIT_TARNAME)
+	gzip -9 $(GIT_TARNAME).tar
+
+rpm: dist
+	rpmbuild -ta git-$(GIT_VERSION).tar.gz
+
 test: all
 	$(MAKE) -C t/ all
 
diff --git a/git.spec.in b/git.spec.in
new file mode 100644
--- /dev/null
+++ b/git.spec.in
@@ -0,0 +1,42 @@
+Name: 		git
+Version: 	@@VERSION@@
+Release: 	1
+Vendor: 	Linus Torvalds <torvalds@osdl.org>
+Summary:  	Git core and tools
+License: 	GPL
+Group: 		Development/Tools
+URL: 		http://kernel.org/pub/software/scm/git/
+Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.gz
+BuildRequires:	zlib-devel, openssl-devel, curl-devel
+BuildRoot:	%{_tmppath}/%{name}-%{version}-root
+Prereq: 	sh-utils, diffutils, rsync, rcs, mktemp >= 1.5
+
+%description
+GIT comes in two layers. The bottom layer is merely an extremely fast
+and flexible filesystem-based database designed to store directory trees
+with regard to their history. The top layer is a SCM-like tool which
+enables human beings to work with the database in a manner to a degree
+similar to other SCM tools (like CVS, BitKeeper or Monotone).
+
+%prep
+%setup -q
+
+%build
+
+make
+
+%install
+rm -rf $RPM_BUILD_ROOT
+make dest=$RPM_BUILD_ROOT prefix=%{_prefix} install
+
+%clean
+rm -rf $RPM_BUILD_ROOT
+
+%files
+%defattr(-,root,root)
+%{_bindir}/*
+%doc README COPYING Documentation/*
+
+%changelog
+* Wed Jul 7 2005 Chris Wright <chris@osdl.org>
+- initial git spec file
