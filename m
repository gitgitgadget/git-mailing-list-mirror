From: Jim Radford <radford@blackbean.org>
Subject: [PATCH] Separate RPMS for programs with non-standard dependencies
Date: Sat, 5 Nov 2005 11:38:02 -0800
Message-ID: <20051105193802.GA8369@blackbean.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 05 20:39:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYTrn-0005Dp-Fq
	for gcvg-git@gmane.org; Sat, 05 Nov 2005 20:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVKETiH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Nov 2005 14:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVKETiH
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Nov 2005 14:38:07 -0500
Received: from cpe-66-74-186-186.socal.res.rr.com ([66.74.186.186]:62376 "EHLO
	mail.blackbean.org") by vger.kernel.org with ESMTP id S932300AbVKETiF
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 5 Nov 2005 14:38:05 -0500
Received: from home.blackbean.org (localhost.localdomain [127.0.0.1])
	by mail.blackbean.org (8.13.4/8.13.4) with ESMTP id jA5Jc3Og008409
	for <git@vger.kernel.org>; Sat, 5 Nov 2005 11:38:03 -0800
Received: (from jim@localhost)
	by home.blackbean.org (8.13.4/8.13.4/Submit) id jA5Jc2oO008406
	for git@vger.kernel.org; Sat, 5 Nov 2005 11:38:02 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11181>

Separate RPMS for programs with non-standard dependencies

Signed-off-by: Jim Radford <radford@blackbean.org>

diff --git a/git-core.spec.in b/git-core.spec.in
index 5240dd2..26846d0 100644
--- a/git-core.spec.in
+++ b/git-core.spec.in
@@ -19,32 +19,70 @@ distributed source code management syste
 rudimentary tools that can be used as a SCM, but you should look
 elsewhere for tools for ordinary humans layered on top of this.
 
+%package svn
+Summary:        Git tools for importing Subversion repositories.
+Group:          Development/Tools
+Requires:       subversion
+%description svn
+Git tools for importing Subversion repositories.
+
+%package cvs
+Summary:        Git tools for importing CVS repositories.
+Group:          Development/Tools
+Requires:       cvs
+%description cvs
+Git tools for importing CVS repositories.
+
+%package email
+Summary:        Git tools for sending email.
+Group:          Development/Tools
+%description email
+Git tools for sending email.
+
 %prep
 %setup -q
 
 %build
-make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" WITH_OWN_SUBPROCESS_PY=YesPlease \
+make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" WITH_OWN_SUBPROCESS_PY=YesPlease WITH_SEND_EMAIL=1 \
      prefix=%{_prefix} all %{!?_without_docs: doc}
 
 %install
 rm -rf $RPM_BUILD_ROOT
-make %{_smp_mflags} DESTDIR=$RPM_BUILD_ROOT WITH_OWN_SUBPROCESS_PY=YesPlease \
+make %{_smp_mflags} DESTDIR=$RPM_BUILD_ROOT WITH_OWN_SUBPROCESS_PY=YesPlease WITH_SEND_EMAIL=1 \
      prefix=%{_prefix} mandir=%{_mandir} \
      install %{!?_without_docs: install-doc}
 
+(find $RPM_BUILD_ROOT%{_bindir} -type f | grep -vE "svn|cvs|email" | sed -e s@^$RPM_BUILD_ROOT@@)               > bin-man-files
+%if %{!?_without_docs:1}0
+(find $RPM_BUILD_ROOT%{_mandir} -type f | grep -vE "svn|cvs|email" | sed -e s@^$RPM_BUILD_ROOT@@ -e 's/$/*/' ) >> bin-man-files
+%endif
+
 %clean
 rm -rf $RPM_BUILD_ROOT
 
-%files
+%files svn
+%{_bindir}/*svn*
+%{!?_without_docs: %{_mandir}/man1/*svn*.1*}
+
+%files cvs
+%{_bindir}/*cvs*
+%{!?_without_docs: %{_mandir}/man1/*cvs*.1*}
+
+%files email
+%{_bindir}/*email*
+%{!?_without_docs: %{_mandir}/man1/*email*.1*}
+
+%files -f bin-man-files
 %defattr(-,root,root)
-%{_bindir}/*
 %{_datadir}/git-core/
 %doc README COPYING Documentation/*.txt
 %{!?_without_docs: %doc Documentation/*.html }
-%{!?_without_docs: %{_mandir}/man1/*.1*}
-%{!?_without_docs: %{_mandir}/man7/*.7*}
 
 %changelog
+* Tue Sep 27 2005 Jim Radford <radford@blackbean.org>
+- Move programs with non-standard dependencies (svn, cvs, email)
+  into separate packages
+
 * Tue Sep 27 2005 H. Peter Anvin <hpa@zytor.com>
 - parallelize build
 - COPTS -> CFLAGS
