From: "H. Peter Anvin" <hpa@orionmulti.com>
Subject: Re: [PATCH Cogito] .spec file update
Date: Mon, 09 May 2005 07:37:50 -0700
Message-ID: <427F75BE.8000602@orionmulti.com>
References: <427F6FCF.9090109@orionmulti.com> <20050509141940.GP87309@mmj.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070600090103050501030502"
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 16:54:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DV9PO-0003VD-FJ
	for gcvg-git@gmane.org; Mon, 09 May 2005 16:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVEIOos (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 10:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVEIOmo
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 10:42:44 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:33722 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S261391AbVEIOiM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2005 10:38:12 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j49Ebqtv005250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 May 2005 07:37:52 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Mads Martin Joergensen <mmj@mmj.dk>
In-Reply-To: <20050509141940.GP87309@mmj.dk>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: clamd / ClamAV version 0.75.1, clamav-milter version 0.75c
	on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------070600090103050501030502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Mads Martin Joergensen wrote:
> * H. Peter Anvin <hpa@orionmulti.com> [May 09. 2005 16:14]:
> 
>>+Provides: 	cogito = %{version}
> 
> This provides is not necessary, rpm will figure this out by itself.
> 

Eh, right.  That shouldn't have been there.

Update included.

	-hpa

--------------070600090103050501030502
Content-Type: text/x-patch;
 name="cogito.spec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cogito.spec.patch"

Index: Makefile
===================================================================
--- 3974261da777f55a7a11aff6e02f584bbfe2b475/Makefile  (mode:100644)
+++ d486ada2c4c7abf6bc32bed730e18f46f9dc6cd2/Makefile  (mode:100644)
@@ -125,7 +125,7 @@
 	@chmod +x $@
 endif
 
-git.spec: git.spec.in $(VERSION)
+cogito.spec: cogito.spec.in $(VERSION)
 	sed -e 's/@@VERSION@@/$(shell cat $(VERSION) | cut -d"-" -f2)/g' < $< > $@
 
 
@@ -155,5 +155,8 @@
 clean:
 	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(GEN_SCRIPT) $(LIB_FILE)
 
+distclean: clean
+	find . -name \*~ -print0 | xargs -0rt rm -f
+
 backup: clean
 	cd .. ; tar czvf dircache.tar.gz dir-cache
Index: cogito.spec.in
===================================================================
--- /dev/null  (tree:3974261da777f55a7a11aff6e02f584bbfe2b475)
+++ d486ada2c4c7abf6bc32bed730e18f46f9dc6cd2/cogito.spec.in  (mode:100644)
@@ -0,0 +1,60 @@
+Name: 		cogito
+Version: 	@@VERSION@@
+Release: 	1
+Vendor: 	Petr Baudis <pasky@ucw.cz>
+Summary:  	Git core and tools
+License: 	GPL
+Group: 		Development/Tools
+URL: 		http://kernel.org/pub/software/scm/cogito/
+Source: 	http://kernel.org/pub/software/scm/cogito/%{name}-%{version}.tar.bz2
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
+/usr/lib/cogito
+%doc README COPYING Documentation/*
+
+%changelog
+* Mon May 9 2005 H. Peter Anvin <hpa@zytor.com> 0.10-1
+- New upstream revision
+- Rename spec file to cogito.spec
+
+* Wed Apr 27 2005 Terje Rosten <terje.rosten@ntnu.no> 0.8-2
+- Doc files
+- Use %%{_prefix} macro
+- Rename spec file
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
Index: git.spec.in
===================================================================
--- 3974261da777f55a7a11aff6e02f584bbfe2b475/git.spec.in  (mode:100644)
+++ /dev/null  (tree:d486ada2c4c7abf6bc32bed730e18f46f9dc6cd2)
@@ -1,55 +0,0 @@
-Name: 		cogito
-Version: 	@@VERSION@@
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

--------------070600090103050501030502--
