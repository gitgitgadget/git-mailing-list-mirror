From: Josh Triplett <josh@freedesktop.org>
Subject: [PATCH] Add USE_SHARED_LIBGIT flag to build and use libgit.so rather
 than libgit.a
Date: Sun, 01 Jul 2007 01:28:02 -0700
Message-ID: <46876592.4060600@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig52293E4595A7BBC6BEACFF50"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 01 10:28:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4unA-0001tW-Gg
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 10:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801AbXGAI2O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 04:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754532AbXGAI2O
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 04:28:14 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:50578 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018AbXGAI2N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 04:28:13 -0400
Received: (qmail 27003 invoked from network); 1 Jul 2007 08:28:12 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail4.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 1 Jul 2007 08:28:11 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.4 (X11/20070622)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51284>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig52293E4595A7BBC6BEACFF50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Git builds a static libgit.a, and many commands which link to libgit.a,
resulting in many duplicate copies of the code in libgit.a.  Add a
USE_SHARED_LIBGIT flag to the Makefile (off by default), which builds and=
 uses
a shared library libgit.so instead.

The existing objects in libgit.a reference the symbols git_version_string=
 and
git_usage_string, defined in git.c, but libgit does not include git.o, ma=
king
the library not self-contained, and leading to linking errors when trying=
 to
use a shared library.  Move those two symbols to help.c, where the refere=
nces
from libgit occur.

This change does not install header files, versioned libraries, or anythi=
ng
else that would support actually using libgit.so from anything other than=
 the
installed git binaries.  The built libgit.so exists solely for the benefi=
t of
the installed git binaries that link to it.

Motivated by trying to install Git on a machine for which this makes the
difference between remaining under quota and not.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 Makefile |   31 ++++++++++++++++++++++++++-----
 git.c    |    5 -----
 help.c   |    5 +++++
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index a98e27a..db35b3b 100644
--- a/Makefile
+++ b/Makefile
@@ -124,6 +124,8 @@ all::
 # If not set it defaults to the bare 'wish'. If it is set to the empty
 # string then NO_TCLTK will be forced (this is used by configure script)=
=2E
 #
+# Define USE_SHARED_LIBGIT to create and use a shared library libgit.so =
rather
+# than a static library libgit.a.
=20
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -146,6 +148,7 @@ STRIP ?=3D strip
 prefix =3D $(HOME)
 bindir =3D $(prefix)/bin
 gitexecdir =3D $(bindir)
+libdir =3D $(prefix)/lib
 sharedir =3D $(prefix)/share
 template_dir =3D $(sharedir)/git-core/templates
 ifeq ($(prefix),/usr)
@@ -290,7 +293,13 @@ endif
=20
 export PERL_PATH
=20
+ifdef USE_SHARED_LIBGIT
+LIB_FILE=3Dlibgit.so
+LIBGIT=3D-L. -lgit
+else
 LIB_FILE=3Dlibgit.a
+LIBGIT=3D$(LIB_FILE)
+endif
 XDIFF_LIB=3Dxdiff/lib.a
=20
 LIB_H =3D \
@@ -704,6 +713,7 @@ ETC_GITCONFIG_SQ =3D $(subst ','\'',$(ETC_GITCONFIG))=

 DESTDIR_SQ =3D $(subst ','\'',$(DESTDIR))
 bindir_SQ =3D $(subst ','\'',$(bindir))
 gitexecdir_SQ =3D $(subst ','\'',$(gitexecdir))
+libdir_SQ =3D $(subst ','\'',$(libdir))
 template_dir_SQ =3D $(subst ','\'',$(template_dir))
 prefix_SQ =3D $(subst ','\'',$(prefix))
=20
@@ -712,7 +722,7 @@ PERL_PATH_SQ =3D $(subst ','\'',$(PERL_PATH))
 PYTHON_PATH_SQ =3D $(subst ','\'',$(PYTHON_PATH))
 TCLTK_PATH_SQ =3D $(subst ','\'',$(TCLTK_PATH))
=20
-LIBS =3D $(GITLIBS) $(EXTLIBS)
+LIBS =3D $(LIBGIT) $(XDIFF_LIB) $(EXTLIBS)
=20
 BASIC_CFLAGS +=3D -DSHA1_HEADER=3D'$(SHA1_HEADER_SQ)' \
 	-DETC_GITCONFIG=3D'"$(ETC_GITCONFIG_SQ)"' $(COMPAT_CFLAGS)
@@ -721,6 +731,10 @@ LIB_OBJS +=3D $(COMPAT_OBJS)
 ALL_CFLAGS +=3D $(BASIC_CFLAGS)
 ALL_LDFLAGS +=3D $(BASIC_LDFLAGS)
=20
+ifdef USE_SHARED_LIBGIT
+ALL_CFLAGS +=3D -fpic
+endif
+
 export TAR INSTALL DESTDIR SHELL_PATH
=20
=20
@@ -747,16 +761,15 @@ gitk-wish: gitk GIT-GUI-VARS
 	chmod +x $@+ && \
 	mv -f $@+ $@
=20
-git.o: git.c common-cmds.h GIT-CFLAGS
-	$(QUIET_CC)$(CC) -DGIT_VERSION=3D'"$(GIT_VERSION)"' \
-		$(ALL_CFLAGS) -c $(filter %.c,$^)
+git.o: common-cmds.h
=20
 git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) -DGIT_VERSION=3D'"$(GIT_VERSION)"' \
 		$(ALL_CFLAGS) -o $@ $(filter %.c,$^) git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
=20
-help.o: common-cmds.h
+help.o: help.c common-cmds.h GIT-CFLAGS
+	$(QUIET_CC)$(CC) -o $@ -c $(ALL_CFLAGS) -DGIT_VERSION=3D'"$(GIT_VERSION=
)"' $<
=20
 git-merge-subtree$X: git-merge-recursive$X
 	$(QUIET_BUILT_IN)rm -f $@ && ln git-merge-recursive$X $@
@@ -908,7 +921,11 @@ $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wild=
card */*.h)
 $(DIFF_OBJS): diffcore.h
=20
 $(LIB_FILE): $(LIB_OBJS)
+ifdef USE_SHARED_LIBGIT
+	$(QUIET_LINK)$(CC) -shared -o $@ $(LIB_OBJS)
+else
 	$(QUIET_AR)rm -f $@ && $(AR) rcs $@ $(LIB_OBJS)
+endif
=20
 XDIFF_OBJS=3Dxdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.=
o \
 	xdiff/xmerge.o
@@ -996,6 +1013,10 @@ install: all
 	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(INSTALL) git$X '$(DESTDIR_SQ)$(bindir_SQ)'
+ifdef USE_SHARED_LIBGIT
+	$(INSTALL) -d -m755 $(DESTDIR_SQ)$(libdir_SQ)
+	$(INSTALL) $(LIB_FILE) $(DESTDIR_SQ)$(libdir_SQ)
+endif
 	$(MAKE) -C templates DESTDIR=3D'$(DESTDIR_SQ)' install
 	$(MAKE) -C perl prefix=3D'$(prefix_SQ)' install
 ifndef NO_TCLTK
diff --git a/git.c b/git.c
index 29b55a1..1e24903 100644
--- a/git.c
+++ b/git.c
@@ -3,9 +3,6 @@
 #include "cache.h"
 #include "quote.h"
=20
-const char git_usage_string[] =3D
-	"git [--version] [--exec-path[=3DGIT_EXEC_PATH]] [-p|--paginate] [--bar=
e] [--git-dir=3DGIT_DIR] [--help] COMMAND [ARGS]";
-
 static void prepend_to_path(const char *dir, int len)
 {
 	const char *old_path =3D getenv("PATH");
@@ -206,8 +203,6 @@ static int handle_alias(int *argcp, const char ***arg=
v)
 	return ret;
 }
=20
-const char git_version_string[] =3D GIT_VERSION;
-
 #define RUN_SETUP	(1<<0)
 #define USE_PAGER	(1<<1)
 /*
diff --git a/help.c b/help.c
index 1cd33ec..3f3ceeb 100644
--- a/help.c
+++ b/help.c
@@ -9,6 +9,11 @@
 #include "common-cmds.h"
 #include <sys/ioctl.h>
=20
+const char git_usage_string[] =3D
+	"git [--version] [--exec-path[=3DGIT_EXEC_PATH]] [-p|--paginate] [--bar=
e] [--git-dir=3DGIT_DIR] [--help] COMMAND [ARGS]";
+
+const char git_version_string[] =3D GIT_VERSION;
+
 /* most GUI terminals set COLUMNS (although some don't export it) */
 static int term_columns(void)
 {
--=20
1.5.2.2



--------------enig52293E4595A7BBC6BEACFF50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGh2WSGJuZRtD+evsRAo3SAJ99aGjfgvYgT8mjhzGa/KyEAPs9iQCdH65u
Oy8ZgdPgPLYOkaDrBThKzeo=
=f6bU
-----END PGP SIGNATURE-----

--------------enig52293E4595A7BBC6BEACFF50--
