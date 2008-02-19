From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] Rename git-core rpm to just git and rename the meta-pacakge to git-all.
Date: Mon, 18 Feb 2008 20:25:25 -0500
Message-ID: <1203384325-32097-1-git-send-email-krh@redhat.com>
References: <7v7ih2p0wk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 02:26:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRHFJ-0003fQ-EX
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 02:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580AbYBSBZd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Feb 2008 20:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754393AbYBSBZd
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 20:25:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48636 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbYBSBZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 20:25:32 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m1J1PVgI013354
	for <git@vger.kernel.org>; Mon, 18 Feb 2008 20:25:31 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1J1PUGN025093
	for <git@vger.kernel.org>; Mon, 18 Feb 2008 20:25:31 -0500
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m1J1PUsT009601;
	Mon, 18 Feb 2008 20:25:30 -0500
X-Mailer: git-send-email 1.5.4.1.123.gf3c6
In-Reply-To: <7v7ih2p0wk.fsf@gitster.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74363>

This fixes my favorite annoyance with the git rpm packaging: don't pull
in tla when I say yum install git!  You wouldn't expect yum install gcc
to pull in gcc-gfortran, right?

With this change, and blanket 'yum update' will automatically pull in t=
he
new 'git' package and push out the old 'git-core', and if the old 'git'
package was installed 'git-all' will be pulled in instead.  A couple of
things do break though: 'yum update git-core', because yum behaves
differently when given a specific package name - it doesn't follow obso=
letes.

Instead, 'yum install git' will pull in the new git rpm, which will the=
n
push out the old 'git-core'.  Similarly, to get the newest version of
the meta package, 'yum install git-all' will install git-all, which the=
n
pushes out the old 'git' meta package.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---

Here's the updated patch.  I did spend some time trying to better handl=
e
the 'yum update git-core' case, but yum doesn't work that way.  When an
explicit package name is given, yum doesn't use Obsoletes to find the
latest version, but it does for just 'yum update'.  Yes, I think yum is
broken in that respect.

Other changes: added back the git-p4 obsoletion I dropped, added parts =
of
my rant to the commit message, added an empty %files section for the
git-all package so it's actually created, hard code the obsoletes versi=
ons
to < 1.5.4.2.

I tried 'yum install git-core' on a system with no git packages as you
described in your email, and both rpm versions in the repo, but I didn'=
t
see the errors you mentioned, I just got 'git' installed.  Perhaps you
need to issue a 'yum clean all' and rebuild the yum repo metadata?

Kristian

[ Sent to Junio earlier, forgot to Cc the list ]

 git.spec.in |   69 +++++++++++++++++++++++++++++++++------------------=
-------
 1 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index 3f9f888..97a26be 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -3,7 +3,7 @@
 Name: 		git
 Version: 	@@VERSION@@
 Release: 	1%{?dist}
-Summary:  	Git core and tools
+Summary:  	Core git tools
 License: 	GPL
 Group: 		Development/Tools
 URL: 		http://kernel.org/pub/software/scm/git/
@@ -11,80 +11,86 @@ Source: 	http://kernel.org/pub/software/scm/git/%{n=
ame}-%{version}.tar.gz
 BuildRequires:	zlib-devel >=3D 1.2, openssl-devel, curl-devel, expat-d=
evel, gettext  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
 BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} =
-n)
=20
-Requires:	git-core =3D %{version}-%{release}
-Requires:	git-svn =3D %{version}-%{release}
-Requires:	git-cvs =3D %{version}-%{release}
-Requires:	git-arch =3D %{version}-%{release}
-Requires:	git-email =3D %{version}-%{release}
-Requires:	gitk =3D %{version}-%{release}
-Requires:	git-gui =3D %{version}-%{release}
 Requires:	perl-Git =3D %{version}-%{release}
+Requires:	zlib >=3D 1.2, rsync, curl, less, openssh-clients, expat
+Provides:	git-core =3D %{version}-%{release}
+Obsoletes:	git-core <=3D 1.5.4.2
+Obsoletes:	git-p4
=20
 %description
 Git is a fast, scalable, distributed revision control system with an
 unusually rich command set that provides both high-level operations
 and full access to internals.
=20
-This is a dummy package which brings in all subpackages.
+The git rpm installs the core tools with minimal dependencies.  To
+install all git packages, including tools for integrating with other
+SCMs, install the git-all meta-package.
=20
-%package core
-Summary:	Core git tools
+%package all
+Summary:	Meta-package to pull in all git tools
 Group:		Development/Tools
-Requires:	zlib >=3D 1.2, rsync, curl, less, openssh-clients, expat
-Obsoletes:	git-p4
-%description core
+Requires:	git =3D %{version}-%{release}
+Requires:	git-svn =3D %{version}-%{release}
+Requires:	git-cvs =3D %{version}-%{release}
+Requires:	git-arch =3D %{version}-%{release}
+Requires:	git-email =3D %{version}-%{release}
+Requires:	gitk =3D %{version}-%{release}
+Requires:	git-gui =3D %{version}-%{release}
+Obsoletes:	git <=3D 1.5.4.2
+
+%description all
 Git is a fast, scalable, distributed revision control system with an
 unusually rich command set that provides both high-level operations
 and full access to internals.
=20
-These are the core tools with minimal dependencies.
+This is a dummy package which brings in all subpackages.
=20
 %package svn
 Summary:        Git tools for importing Subversion repositories
 Group:          Development/Tools
-Requires:       git-core =3D %{version}-%{release}, subversion
+Requires:       git =3D %{version}-%{release}, subversion
 %description svn
 Git tools for importing Subversion repositories.
=20
 %package cvs
 Summary:        Git tools for importing CVS repositories
 Group:          Development/Tools
-Requires:       git-core =3D %{version}-%{release}, cvs, cvsps
+Requires:       git =3D %{version}-%{release}, cvs, cvsps
 %description cvs
 Git tools for importing CVS repositories.
=20
 %package arch
 Summary:        Git tools for importing Arch repositories
 Group:          Development/Tools
-Requires:       git-core =3D %{version}-%{release}, tla
+Requires:       git =3D %{version}-%{release}, tla
 %description arch
 Git tools for importing Arch repositories.
=20
 %package email
 Summary:        Git tools for sending email
 Group:          Development/Tools
-Requires:	git-core =3D %{version}-%{release}
+Requires:	git =3D %{version}-%{release}
 %description email
 Git tools for sending email.
=20
 %package gui
 Summary:        Git GUI tool
 Group:          Development/Tools
-Requires:       git-core =3D %{version}-%{release}, tk >=3D 8.4
+Requires:       git =3D %{version}-%{release}, tk >=3D 8.4
 %description gui
 Git GUI tool
=20
 %package -n gitk
 Summary:        Git revision tree visualiser ('gitk')
 Group:          Development/Tools
-Requires:       git-core =3D %{version}-%{release}, tk >=3D 8.4
+Requires:       git =3D %{version}-%{release}, tk >=3D 8.4
 %description -n gitk
 Git revision tree visualiser ('gitk')
=20
 %package -n perl-Git
 Summary:        Perl interface to Git
 Group:          Development/Libraries
-Requires:       git-core =3D %{version}-%{release}
+Requires:       git =3D %{version}-%{release}
 Requires:       perl(:MODULE_COMPAT_%(eval "`%{__perl} -V:version`"; e=
cho $version))
 BuildRequires:  perl(Error)
=20
@@ -121,8 +127,12 @@ rm -rf $RPM_BUILD_ROOT%{_mandir}
 %clean
 rm -rf $RPM_BUILD_ROOT
=20
-%files
-# These are no files in the root package
+%files -f bin-man-doc-files
+%defattr(-,root,root)
+%{_datadir}/git-core/
+%doc README COPYING Documentation/*.txt
+%{!?_without_docs: %doc Documentation/*.html Documentation/howto}
+%{!?_without_docs: %doc Documentation/technical}
=20
 %files svn
 %defattr(-,root,root)
@@ -173,14 +183,13 @@ rm -rf $RPM_BUILD_ROOT
 %files -n perl-Git -f perl-files
 %defattr(-,root,root)
=20
-%files core -f bin-man-doc-files
-%defattr(-,root,root)
-%{_datadir}/git-core/
-%doc README COPYING Documentation/*.txt
-%{!?_without_docs: %doc Documentation/*.html Documentation/howto}
-%{!?_without_docs: %doc Documentation/technical}
+%files all
+# No files for you!
=20
 %changelog
+* Fri Feb 15 2008 Kristian H=C3=B8gsberg <krh@redhat.com>
+- Rename git-core to just git and rename meta package from git to git-=
all.
+
 * Sun Feb 03 2008 James Bowes <jbowes@dangerouslyinc.com>
 - Add a BuildRequires for gettext
=20
--=20
1.5.4.1.123.gf3c6
