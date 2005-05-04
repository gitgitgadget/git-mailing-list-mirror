From: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH 0/3] cogito spec file updates
Date: Wed, 4 May 2005 08:27:09 -0700
Message-ID: <20050504152709.GG5324@shell0.pdx.osdl.net>
References: <20050503211527.42339.qmail@web41208.mail.yahoo.com> <20050503182850.GL18917@shell0.pdx.osdl.net> <20050503193536.GE5324@shell0.pdx.osdl.net> <20050503212142.GB15995@pasky.ji.cz> <20050503213216.GF5324@shell0.pdx.osdl.net> <20050503214401.GE15995@pasky.ji.cz> <4278DE7D.3000005@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Chris Wright <chrisw@osdl.org>,
	Mark Allen <mrallen1@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 17:22:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTLgS-0002RT-Oo
	for gcvg-git@gmane.org; Wed, 04 May 2005 17:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVEDP1d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 11:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVEDP1d
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 11:27:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:15242 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261879AbVEDP1N (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 11:27:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j44FR9U3004903
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 4 May 2005 08:27:09 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j44FR9cu029055;
	Wed, 4 May 2005 08:27:09 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j44FR9r0029054;
	Wed, 4 May 2005 08:27:09 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <4278DE7D.3000005@zytor.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* H. Peter Anvin (hpa@zytor.com) wrote:
> What I usually do is to have a *.spec.in file, and have my release 
> script generate the *.spec file.  I usually have a "version" file 
> checked into the SCM from which all version information derives, 
> including what to put in the *.spec file as well as what to name the 
> subdirectory.
> 
> The release script then ends up being some variant on:
> 
> #!/bin/sh -xe
> PACKAGE=pkgname
> VERSION=`cat version`
> scm-of-choice tag --force $PACKAGE-$VERSION
> mkdir /var/tmp/$PACKAGE-$VERSION
> cd /var/tmp/$PACKAGE-$VERSION
> scm-of-choice export -r $PACKAGE-$VERSION
> make release
> cd ..
> tar cvvfz $PACKAGE-$VERSION.tar.gz $PACKAGE-$VERSION
> rm -rf $PACKAGE-$VERSION
> 
> ... where "make release" creates the specfile and anything else that 
> needs to be created (like autoconf files.)

Yup, that's precisely what I was thinking.  I cobbled up an add-on to
Mark Allen's patch yesterday, but didn't send it since Pasky didn't seem
too interested in the idea.  Anyway, here it is to demonstrate the idea.
The current setup is definitely workable, just means each release tarball
will build a bogus package with rpmbuild -ta.  So I just fix up the spec
and then build...

thanks,
-chris
--



Autogen git.spec from git.spec.in.  Needs patch from Mark Allen.

Signed-off-by: Chris Wright <chrisw@osdl.org>

--- cogito/Makefile~orig	2005-05-03 14:41:50.000000000 -0700
+++ cogito/Makefile	2005-05-03 15:53:36.000000000 -0700
@@ -126,6 +126,8 @@
 	@chmod +x $@
 endif
 
+git.spec: git.spec.in $(VERSION) 
+	sed -e 's/@@VERSION@@/$(shell cat $(VERSION) | cut -d"-" -f2)/g' < $< > $@
 
 install: $(PROG) $(SCRIPTS) $(SCRIPT) $(GEN_SCRIPT)
 	install -m755 -d $(DESTDIR)$(bindir)
@@ -141,10 +143,10 @@
 backup: clean
 	cd .. ; tar czvf dircache.tar.gz dir-cache
 
-release-tar-gzip: clean
+release-tar-gzip: clean git.spec
 	tar czf $(shell cat $(VERSION)).tar.gz *.c *.h git.spec Makefile $(DOCS) $(DIRS) $(SCRIPTS) $(SCRIPT) 
 
-release-tar-bzip2: clean
+release-tar-bzip2: clean git.spec
 	tar cjf $(shell cat $(VERSION)).tar.bz2 *.c *.h git.spec Makefile $(DOCS) $(DIRS) $(SCRIPTS) $(SCRIPT) 
 
 release-tarballs: release-tar-gzip release-tar-bzip2
--- cogito/git.spec~orig	2005-05-03 14:41:59.000000000 -0700
+++ cogito/git.spec	2005-05-03 14:42:55.000000000 -0700
@@ -1,55 +0,0 @@
-Name: 		cogito
-Version: 	0.8
-Release: 	2
-Vendor: 	Petr Baudis <pasky@ucw.cz>
-Summary:  	Git core and tools
-License: 	GPL
-Group: 		Development/Tools
-URL: 		http://kernel.org/pub/software/scm/cogito/
-Source: 	http://kernel.org/pub/software/scm/cogito/%{name}-%{version}.tar.bz2
-Provides: 	cogito = %{version}
-Obsoletes:	git
-BuildRequires:	zlib-devel, openssl-devel, curl-devel
-BuildRoot:	%{_tmppath}/%{name}-%{version}-root
-Prereq: 	sh-utils, diffutils, rsync, rcs, mktemp >= 1.5
-
-%description
-GIT comes in two layers. The bottom layer is merely an extremely fast
-and flexible filesystem-based database designed to store directory trees
-with regard to their history. The top layer is a SCM-like tool which
-enables human beings to work with the database in a manner to a degree
-similar to other SCM tools (like CVS, BitKeeper or Monotone).
-
-%prep
-%setup -q
-
-%build
-
-make
-
-%install
-rm -rf $RPM_BUILD_ROOT
-make DESTDIR=$RPM_BUILD_ROOT prefix=%{_prefix} install
-
-%clean
-rm -rf $RPM_BUILD_ROOT
-
-%files
-%defattr(-,root,root)
-/usr/bin/*
-%doc README README.reference COPYING Changelog
-
-%changelog
-* Wed Apr 27 2005 Terje Rosten <terje.rosten@ntnu.no> 0.8-2
-- Doc files
-- Use %%{_prefix} macro
-- Drop -n option to %%setup macro
-
-* Mon Apr 25 2005 Chris Wright <chrisw@osdl.org> 0.8-1
-- Update to cogito, rename package, move to /usr/bin, update prereqs
-
-* Mon Apr 25 2005 Chris Wright <chrisw@osdl.org> 0.7-1
-- Update to 0.7
-
-* Thu Apr 21 2005 Chris Wright <chrisw@osdl.org> 0.6.3-1
-- Initial rpm build
--- cogito/git.spec.in~orig	2005-05-03 14:42:20.000000000 -0700
+++ cogito/git.spec.in	2005-05-03 14:44:19.000000000 -0700
@@ -0,0 +1,58 @@
+Name: 		cogito
+Version: 	@@VERSION@@
+Release: 	1
+Vendor: 	Petr Baudis <pasky@ucw.cz>
+Summary:  	Git core and tools
+License: 	GPL
+Group: 		Development/Tools
+URL: 		http://kernel.org/pub/software/scm/cogito/
+Source: 	http://kernel.org/pub/software/scm/cogito/%{name}-%{version}.tar.bz2
+Provides: 	cogito = %{version}
+Obsoletes:	git
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
+make DESTDIR=$RPM_BUILD_ROOT prefix=%{_prefix} install
+
+%clean
+rm -rf $RPM_BUILD_ROOT
+
+%files
+%defattr(-,root,root)
+/usr/bin/*
+%doc README README.reference COPYING Changelog
+
+%changelog
+* Tue May 3 2005 Chris Wright <chrisw@osdl.org>
+- Auto build from git.spec.in
+
+* Wed Apr 27 2005 Terje Rosten <terje.rosten@ntnu.no> 0.8-2
+- Doc files
+- Use %%{_prefix} macro
+- Drop -n option to %%setup macro
+
+* Mon Apr 25 2005 Chris Wright <chrisw@osdl.org> 0.8-1
+- Update to cogito, rename package, move to /usr/bin, update prereqs
+
+* Mon Apr 25 2005 Chris Wright <chrisw@osdl.org> 0.7-1
+- Update to 0.7
+
+* Thu Apr 21 2005 Chris Wright <chrisw@osdl.org> 0.6.3-1
+- Initial rpm build
