From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: [PATCH 1/2] Add/resurrect make uninstall target
Date: Tue, 08 Dec 2009 16:23:53 +0100
Organization: www.AvatarAcademy.nl
Message-ID: <1260285833.1856.52.camel@vuurvlieg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 08 16:24:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI1uz-0000Km-G7
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 16:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756006AbZLHPXt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 10:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755998AbZLHPXs
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 10:23:48 -0500
Received: from edu-smtp-02.edutel.nl ([88.159.1.222]:56753 "EHLO
	edu-smtp-02.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755989AbZLHPXs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 10:23:48 -0500
Received: from vuurvlieg (unknown [88.159.206.46])
	by edu-smtp-02.edutel.nl (Postfix) with ESMTP id C36DA121BF5;
	Tue,  8 Dec 2009 16:23:53 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by vuurvlieg (Postfix) with ESMTP id 9070011C9A9;
	Tue,  8 Dec 2009 16:23:53 +0100 (CET)
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134887>


Uninstall is a common make target that users may expect to be present,
e.g. it is provided automatically by automake.

The default Git install performs a multi-rooted install in $HOME,
which makes manual removal somewhat cumbersome.

The uninstall target was not present in the toplevel makefile,
only a few other makefiles had partial uninstall targets.

Signed-off-by: Jan Nieuwenhuizen <janneke@gnu.org>
---
 Makefile           |   18 +++++++++++++++++-
 perl/Makefile      |    2 +-
 templates/Makefile |    5 +++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 4a1e5bc..b9ef172 100644
--- a/Makefile
+++ b/Makefile
@@ -1842,7 +1842,23 @@ quick-install-man:
 quick-install-html:
 	$(MAKE) -C Documentation quick-install-html
=20
+bindir_PROGRAMS =3D git$X git-upload-pack$X git-receive-pack$X git-upl=
oad-archive$X git-shell$X git-cvsserver
=20
+uninstall:
+ifndef NO_TCLTK
+	$(MAKE) -C gitk-git uninstall
+	$(MAKE) -C git-gui gitexecdir=3D'$(gitexec_instdir_SQ)' uninstall
+endif
+ifndef NO_PERL
+	$(MAKE) -C perl prefix=3D'$(prefix_SQ)' DESTDIR=3D'$(DESTDIR_SQ)' uni=
nstall
+endif
+	$(MAKE) -C templates DESTDIR=3D'$(DESTDIR_SQ)' uninstall
+	$(RM) $(ALL_PROGRAMS:%=3D'$(DESTDIR_SQ)$(gitexec_instdir_SQ)'/%)
+	$(RM) $(BUILT_INS:%=3D'$(DESTDIR_SQ)$(gitexec_instdir_SQ)'/%)
+	$(RM) $(OTHER_PROGRAMS:%=3D'$(DESTDIR_SQ)$(gitexec_instdir_SQ)'/%)
+	-rmdir -p '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(RM) $(bindir_PROGRAMS:%=3D'$(DESTDIR_SQ)$(bindir_SQ)'/%)
+	-rmdir -p '$(DESTDIR_SQ)$(bindir_SQ)'
=20
 ### Maintainer's dist rules
=20
@@ -1921,7 +1937,7 @@ ifndef NO_TCLTK
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-GUI-VARS GIT-BUILD-OPTIONS
=20
-.PHONY: all install clean strip
+.PHONY: all install uninstall clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_moder=
n_shell
 .PHONY: .FORCE-GIT-VERSION-FILE TAGS tags cscope .FORCE-GIT-CFLAGS
 .PHONY: .FORCE-GIT-BUILD-OPTIONS
diff --git a/perl/Makefile b/perl/Makefile
index 4ab21d6..25fc304 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -10,7 +10,7 @@ ifndef V
 	QUIET =3D @
 endif
=20
-all install instlibdir: $(makfile)
+all install instlibdir uninstall: $(makfile)
 	$(QUIET)$(MAKE) -f $(makfile) $@
=20
 clean:
diff --git a/templates/Makefile b/templates/Makefile
index 408f013..f4048d9 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -51,3 +51,8 @@ install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
 	(cd blt && $(TAR) cf - .) | \
 	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xof =
-)
+
+uninstall:
+	-(cd blt && find . -type f) | (cd '$(DESTDIR_SQ)$(template_instdir_SQ=
)' && xargs $(RM))
+	-(cd blt && find . -mindepth 1 -type d) | (cd '$(DESTDIR_SQ)$(templat=
e_instdir_SQ)' && xargs rmdir)
+	-rmdir -p '$(DESTDIR_SQ)$(template_instdir_SQ)'
--=20
1.6.5.2.182.g1a756



--=20
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesett=
er
Avatar=C2=AE: http://AvatarAcademy.nl    | http://lilypond.org
