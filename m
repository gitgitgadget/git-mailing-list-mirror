From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2, proof of concept] autoconf: Use %configure in git.spec, autoconf dependency only in rpm target
Date: Tue, 4 Jul 2006 16:09:35 +0200
Message-ID: <200607041609.36329.jnareb@gmail.com>
References: <200607030156.50455.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jul 04 16:09:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxlb7-0008PB-1q
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 16:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWGDOJl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 10:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWGDOJl
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 10:09:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:49942 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932251AbWGDOJk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 10:09:40 -0400
Received: by nf-out-0910.google.com with SMTP id k26so731646nfc
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 07:09:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MehpF2Yz2m9SgWlicjOU7rTYQVB1b5CR+n8ilr7JLpUXJzwzUuy211Jwe6ulr0aGuTXVRZowiGcqIRm1PFJ6EvmNJDRmPjvQIJmq5H0NqGdm6Q/iPxV2iEHCOaf2mftJ4iqHmVaVA4ZsukIjrDTn/WEY0WGNWTt0QlvPQC8VXwU=
Received: by 10.48.233.18 with SMTP id f18mr3354771nfh;
        Tue, 04 Jul 2006 07:09:39 -0700 (PDT)
Received: from host-81-190-27-124.torun.mm.pl ( [81.190.27.124])
        by mx.gmail.com with ESMTP id p43sm4570941nfa.2006.07.04.07.09.38;
        Tue, 04 Jul 2006 07:09:39 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607030156.50455.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23298>

This is __Proof of Concept__ patch, which makes use of predefined 
%configure rpm macro to define install dirs, using autoconf 
generated ./configure script.

This patch introduces dependency on autoconf _only_ for rpm target during
build process. 
---
Probably there is more portable way of ignoring diff exit status than 
using '|| true', and probably better way to generate 
"file creation"/"new file" patch from a working directory (only) file
(perhaps using git-diff too).


Sidenote 1: current git.spec.in doesn't allow building RPMS from a dirty
version: 
  error: line 3: Illegal char '-' in version: Version:    1.4.1.g1c7c-dirty
Is it intentional?

Sidenote 2: building rpm currently does compilation _twice_, once to generate
git-tar-tree, and once in the rpm build (in BuildRoot).


 Makefile    |    3 +++
 git.spec.in |    6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 3c2c257..8ad1a4a 100644
--- a/Makefile
+++ b/Makefile
@@ -721,6 +722,9 @@ dist: git.spec git-tar-tree
 	gzip -f -9 $(GIT_TARNAME).tar
 
 rpm: dist
+	autoconf
+	diff -Nu /dev/null configure > git-add-autoconf-configure.patch || true
+	gzip -f -9 git-add-autoconf-configure.patch
 	$(RPMBUILD) -ta $(GIT_TARNAME).tar.gz
 
 htmldocs = git-htmldocs-$(GIT_VERSION)
diff --git a/git.spec.in b/git.spec.in
index 8ccd256..9c02803 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -7,6 +7,7 @@ License: 	GPL
 Group: 		Development/Tools
 URL: 		http://kernel.org/pub/software/scm/git/
 Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.gz
+Patch0: 	git-add-autoconf-configure.patch.gz
 BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel, expat-devel  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
 BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
 Requires:	git-core, git-svn, git-cvs, git-arch, git-email, gitk
@@ -72,15 +73,16 @@ Git revision tree visualiser ('gitk')
 
 %prep
 %setup -q
+%patch0 -p0
 
 %build
+%configure
 make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" WITH_OWN_SUBPROCESS_PY=YesPlease \
-     prefix=%{_prefix} all %{!?_without_docs: doc}
+     all %{!?_without_docs: doc}
 
 %install
 rm -rf $RPM_BUILD_ROOT
 make %{_smp_mflags} DESTDIR=$RPM_BUILD_ROOT WITH_OWN_SUBPROCESS_PY=YesPlease \
-     prefix=%{_prefix} mandir=%{_mandir} \
      install %{!?_without_docs: install-doc}
 
 (find $RPM_BUILD_ROOT%{_bindir} -type f | grep -vE "arch|svn|cvs|email|gitk" | sed -e s@^$RPM_BUILD_ROOT@@)               > bin-man-doc-files
-- 
1.4.0
