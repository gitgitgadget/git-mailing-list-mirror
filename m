From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH] add git.spec and adapt Makefile for RPM build
Date: Mon, 2 May 2005 16:52:55 +0200
Message-ID: <20050502145255.GA26439@vrfy.org>
References: <20050502102303.GA22630@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon May 02 16:48:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DScCL-0008Qw-Rn
	for gcvg-git@gmane.org; Mon, 02 May 2005 16:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVEBOxH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 10:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVEBOxH
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 10:53:07 -0400
Received: from soundwarez.org ([217.160.171.123]:50118 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261292AbVEBOw6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 10:52:58 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 19A0A28BCC; Mon,  2 May 2005 16:52:55 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050502102303.GA22630@vrfy.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 02, 2005 at 12:23:03PM +0200, Kay Sievers wrote:
> Add support for building the rpm package directly from the git tree.

This version creates the git.spec from a git.spec.in with the version
number from the Makefile.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
---

--- a/Makefile
+++ b/Makefile
@@ -7,6 +7,12 @@
 # BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely randomly
 # break unless your underlying filesystem supports those sub-second times
 # (my ext3 doesn't).
+
+VERSION = 0.7
+
+prefix=$(HOME)
+bindir=$(prefix)/bin
+
 CFLAGS=-g -O2 -Wall
 
 CC=gcc
@@ -25,8 +31,15 @@ PROG=   git-update-cache git-diff-files 
 
 all: $(PROG)
 
+git.spec: git.spec.in Makefile
+	sed -e 's/@@VERSION@@/$(VERSION)/g' < $< > $@
+
 install: $(PROG) $(SCRIPTS)
-	install $(PROG) $(SCRIPTS) $(HOME)/bin/
+	install -m755 -d $(DESTDIR)$(bindir)
+	install $(PROG) $(SCRIPTS) $(DESTDIR)$(bindir)
+
+uninstall:
+	cd $(DESTDIR)$(bindir) && rm $(PROG) $(SCRIPTS)
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
 	 tag.o date.o
@@ -110,7 +123,7 @@ diff.o: $(LIB_H)
 strbuf.o: $(LIB_H)
 
 clean:
-	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(LIB_FILE)
+	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(LIB_FILE) git.spec
 
 backup: clean
 	cd .. ; tar czvf dircache.tar.gz dir-cache
Created: git.spec.in (mode:100644)
--- /dev/null
+++ b/git.spec.in
@@ -0,0 +1,44 @@
+Name: 		git
+Version: 	@@VERSION@@
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

