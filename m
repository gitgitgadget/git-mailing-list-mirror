From: Kay Sievers <kay.sievers@vrfy.org>
Subject: [PATCH] add git.spec and adapt Makefile for RPM build
Date: Mon, 2 May 2005 12:23:03 +0200
Message-ID: <20050502102303.GA22630@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon May 02 12:17:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSXzD-00008W-TO
	for gcvg-git@gmane.org; Mon, 02 May 2005 12:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVEBKXO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 06:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVEBKXO
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 06:23:14 -0400
Received: from soundwarez.org ([217.160.171.123]:24236 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261192AbVEBKXF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 06:23:05 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 7066D29A86; Mon,  2 May 2005 12:23:03 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add support for building the rpm package directly from the git tree.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
---

--- a/Makefile
+++ b/Makefile
@@ -7,6 +7,10 @@
 # BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely randomly
 # break unless your underlying filesystem supports those sub-second times
 # (my ext3 doesn't).
+
+prefix=$(HOME)
+bindir=$(prefix)/bin
+
 CFLAGS=-g -O2 -Wall
 
 CC=gcc
@@ -26,7 +30,11 @@ PROG=   git-update-cache git-diff-files 
 all: $(PROG)
 
 install: $(PROG) $(SCRIPTS)
-	install $(PROG) $(SCRIPTS) $(HOME)/bin/
+	install -m755 -d $(DESTDIR)$(bindir)
+	install $(PROG) $(SCRIPTS) $(DESTDIR)$(bindir)
+
+uninstall:
+	cd $(DESTDIR)$(bindir) && rm $(PROG) $(SCRIPTS)
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
 	 tag.o date.o
Created: git.spec (mode:100644)
--- /dev/null
+++ b/git.spec
@@ -0,0 +1,44 @@
+Name: 		git
+Version: 	0.7
+Release: 	1
+Vendor: 	Linus Torvalds <torvalds@osdl.org>
+Summary:  	git
+License: 	GPL
+Group: 		Development/Tools
+URL: 		http://www.kernel.org/pub/software/scm/git/
+Source: 	http://www.kernel.org/pub/software/scm/git/%{name}-%{version}.tar.bz2
+Provides: 	git = %{version}
+BuildRequires:	zlib-devel openssl-devel curl-devel
+BuildRoot:	%{_tmppath}/%{name}-%{version}-root
+Prereq: 	sh-utils diffutils
+
+%description
+git is an fast and flexible filesystem-based database designed to store directory
+trees with regard to their history. It is the base for SCM tools bild on top of
+git like cogito.
+
+%prep
+%setup -q -n %{name}-%{version}
+
+%build
+
+make
+
+%install
+rm -rf $RPM_BUILD_ROOT
+make DESTDIR=$RPM_BUILD_ROOT prefix=/usr install
+
+%clean
+rm -rf $RPM_BUILD_ROOT
+
+%files
+%defattr(-,root,root)
+/usr/bin/*
+#%{_mandir}/*/*
+
+%changelog
+* Thu May 2 2005 Kay Sievers <kay.sievers@vrfy.org> 0.7-1
+- rpm build for core git
+
+* Thu Apr 21 2005 Chris Wright <chrisw@osdl.org> 0.6.3-1
+- Initial rpm build

