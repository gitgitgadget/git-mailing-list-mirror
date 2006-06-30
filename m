From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 3/3] Make perl interface a separate package
Date: Fri, 30 Jun 2006 01:09:28 -0400
Message-ID: <20060630050928.701.17817.stgit@dv.roinet.com>
References: <20060630050923.701.37665.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Jun 30 07:09:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwBG1-0002Lx-4L
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 07:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWF3FJa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 01:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWF3FJa
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 01:09:30 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:6295 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750922AbWF3FJ3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 01:09:29 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FwBFw-0004aM-Rg
	for git@vger.kernel.org; Fri, 30 Jun 2006 01:09:28 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.62)
	(envelope-from <proski@gnu.org>)
	id 1FwBFw-0000Bw-8n
	for git@vger.kernel.org; Fri, 30 Jun 2006 01:09:28 -0400
To: git@vger.kernel.org
In-Reply-To: <20060630050923.701.37665.stgit@dv.roinet.com>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22956>

From: Pavel Roskin <proski@gnu.org>

Install it as a vendor package.  Remove .packlist, perllocal.pod,
Git.bs.  Require perl(Error) for building so that our Error.pm is not
installed.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 git.spec.in |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index b8feda3..6d90034 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -9,7 +9,7 @@ URL: 		http://kernel.org/pub/software/sc
 Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.gz
 BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel, expat-devel  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
 BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
-Requires:	git-core, git-svn, git-cvs, git-arch, git-email, gitk
+Requires:	git-core, git-svn, git-cvs, git-arch, git-email, gitk, perl-Git
 
 %description
 This is a stupid (but extremely fast) directory content manager.  It
@@ -70,6 +70,16 @@ Requires:       git-core = %{version}-%{
 %description -n gitk
 Git revision tree visualiser ('gitk')
 
+%package -n perl-Git
+Summary:        Perl interface to Git
+Group:          Development/Libraries
+Requires:       git-core = %{version}-%{release}
+Requires:       perl(:MODULE_COMPAT_%(eval "`%{__perl} -V:version`"; echo $version))
+BuildRequires:  perl(Error)
+
+%description -n perl-Git
+Perl interface to Git
+
 %prep
 %setup -q
 
@@ -80,10 +90,14 @@ make %{_smp_mflags} CFLAGS="$RPM_OPT_FLA
 %install
 rm -rf $RPM_BUILD_ROOT
 make %{_smp_mflags} DESTDIR=$RPM_BUILD_ROOT WITH_OWN_SUBPROCESS_PY=YesPlease \
-     prefix=%{_prefix} mandir=%{_mandir} \
+     prefix=%{_prefix} mandir=%{_mandir} INSTALLDIRS=vendor \
      install %{!?_without_docs: install-doc}
+find $RPM_BUILD_ROOT -type f -name .packlist -exec rm -f {} ';'
+find $RPM_BUILD_ROOT -type f -name '*.bs' -empty -exec rm -f {} ';'
+find $RPM_BUILD_ROOT -type f -name perllocal.pod -exec rm -f {} ';'
 
 (find $RPM_BUILD_ROOT%{_bindir} -type f | grep -vE "arch|svn|cvs|email|gitk" | sed -e s@^$RPM_BUILD_ROOT@@)               > bin-man-doc-files
+(find $RPM_BUILD_ROOT%{perl_vendorarch} -type f | sed -e s@^$RPM_BUILD_ROOT@@) >> perl-files
 %if %{!?_without_docs:1}0
 (find $RPM_BUILD_ROOT%{_mandir} $RPM_BUILD_ROOT/Documentation -type f | grep -vE "arch|svn|git-cvs|email|gitk" | sed -e s@^$RPM_BUILD_ROOT@@ -e 's/$/*/' ) >> bin-man-doc-files
 %else
@@ -131,6 +145,9 @@ # These are no files in the root package
 %{!?_without_docs: %{_mandir}/man1/*gitk*.1*}
 %{!?_without_docs: %doc Documentation/*gitk*.html }
 
+%files -n perl-Git -f perl-files
+%defattr(-,root,root)
+
 %files core -f bin-man-doc-files
 %defattr(-,root,root)
 %{_datadir}/git-core/
