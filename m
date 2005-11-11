From: Chris Wright <chrisw@osdl.org>
Subject: [PATCH] specfile cleanups
Date: Fri, 11 Nov 2005 01:10:29 -0800
Message-ID: <20051111091029.GW8041@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 10:12:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaUvv-0004Ml-2h
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 10:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbVKKJKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 04:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVKKJKi
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 04:10:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37055 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932303AbVKKJKf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 04:10:35 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAB9ATnO028067
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 11 Nov 2005 01:10:30 -0800
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAB9AT68032016;
	Fri, 11 Nov 2005 01:10:29 -0800
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id jAB9ATCq032015;
	Fri, 11 Nov 2005 01:10:29 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11575>

Some specfile cleanups after the split.
- zlib dependency fix, current method is inconsistent, you can
  potentially build a package that you can't install on machine you
  built it on
- Add proper defattr
- Remove trailing '.' in summary
- Add docs to split up packages
- Add git-core dependency for each subpackage
- Move arch import to separate package as well

Signed-off-by: Chris Wright <chrisw@osdl.org>
---

diff --git a/git-core.spec.in b/git-core.spec.in
index 26846d0..8ef29b8 100644
--- a/git-core.spec.in
+++ b/git-core.spec.in
@@ -1,4 +1,4 @@
-# Pass --without docs to rpmbuild if you don't want the documetnation
+# Pass --without docs to rpmbuild if you don't want the documentation
 Name: 		git-core
 Version: 	@@VERSION@@
 Release: 	1%{?dist}
@@ -7,7 +7,7 @@ License: 	GPL
 Group: 		Development/Tools
 URL: 		http://kernel.org/pub/software/scm/git/
 Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.gz
-BuildRequires:	zlib-devel, openssl-devel, curl-devel  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
+BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
 BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
 Requires:	zlib >= 1.2, rsync, rcs, curl, less, openssh-clients, python >= 2.3, tk >= 8.4
 
@@ -20,22 +20,30 @@ rudimentary tools that can be used as a 
 elsewhere for tools for ordinary humans layered on top of this.
 
 %package svn
-Summary:        Git tools for importing Subversion repositories.
+Summary:        Git tools for importing Subversion repositories
 Group:          Development/Tools
-Requires:       subversion
+Requires:       git-core = %{version}-%{release} subversion
 %description svn
 Git tools for importing Subversion repositories.
 
 %package cvs
-Summary:        Git tools for importing CVS repositories.
+Summary:        Git tools for importing CVS repositories
 Group:          Development/Tools
-Requires:       cvs
+Requires:       git-core = %{version}-%{release} cvs
 %description cvs
 Git tools for importing CVS repositories.
 
+%package arch
+Summary:        Git tools for importing Arch repositories
+Group:          Development/Tools
+Requires:       git-core = %{version}-%{release}
+%description arch
+Git tools for importing Arch repositories.
+
 %package email
-Summary:        Git tools for sending email.
+Summary:        Git tools for sending email
 Group:          Development/Tools
+Requires:	git-core = %{version}-%{release} 
 %description email
 Git tools for sending email.
 
@@ -52,33 +60,54 @@ make %{_smp_mflags} DESTDIR=$RPM_BUILD_R
      prefix=%{_prefix} mandir=%{_mandir} \
      install %{!?_without_docs: install-doc}
 
-(find $RPM_BUILD_ROOT%{_bindir} -type f | grep -vE "svn|cvs|email" | sed -e s@^$RPM_BUILD_ROOT@@)               > bin-man-files
+(find $RPM_BUILD_ROOT%{_bindir} -type f | grep -vE "arch|svn|cvs|email" | sed -e s@^$RPM_BUILD_ROOT@@)               > bin-man-doc-files
 %if %{!?_without_docs:1}0
-(find $RPM_BUILD_ROOT%{_mandir} -type f | grep -vE "svn|cvs|email" | sed -e s@^$RPM_BUILD_ROOT@@ -e 's/$/*/' ) >> bin-man-files
+(find $RPM_BUILD_ROOT%{_mandir} $RPM_BUILD_ROOT/Documentation -type f | grep -vE "arch|svn|git-cvs|email" | sed -e s@^$RPM_BUILD_ROOT@@ -e 's/$/*/' ) >> bin-man-doc-files
 %endif
 
 %clean
 rm -rf $RPM_BUILD_ROOT
 
 %files svn
+%defattr(-,root,root)
 %{_bindir}/*svn*
+%doc Documentation/*svn*.txt
 %{!?_without_docs: %{_mandir}/man1/*svn*.1*}
+%{!?_without_docs: %doc Documentation/*svn*.html }
 
 %files cvs
+%defattr(-,root,root)
+%doc Documentation/*git-cvs*.txt
 %{_bindir}/*cvs*
 %{!?_without_docs: %{_mandir}/man1/*cvs*.1*}
+%{!?_without_docs: %doc Documentation/*git-cvs*.html }
+
+%files arch
+%defattr(-,root,root)
+%doc Documentation/*arch*.txt
+%{_bindir}/*arch*
+%{!?_without_docs: %{_mandir}/man1/*arch*.1*}
+%{!?_without_docs: %doc Documentation/*arch*.html }
 
 %files email
+%defattr(-,root,root)
+%doc Documentation/*email*.txt
 %{_bindir}/*email*
 %{!?_without_docs: %{_mandir}/man1/*email*.1*}
+%{!?_without_docs: %doc Documentation/*email*.html }
 
-%files -f bin-man-files
+%files -f bin-man-doc-files
 %defattr(-,root,root)
 %{_datadir}/git-core/
 %doc README COPYING Documentation/*.txt
 %{!?_without_docs: %doc Documentation/*.html }
 
 %changelog
+* Thu Nov 10 2005 Chris Wright <chrisw@osdl.org> 0.99.9g-1
+- zlib dependency fix
+- Minor cleanups from split
+- Move arch import to separate package as well
+
 * Tue Sep 27 2005 Jim Radford <radford@blackbean.org>
 - Move programs with non-standard dependencies (svn, cvs, email)
   into separate packages
