From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 5/9 v2] Allow the built-in exec path to be relative to the command invocation path
Date: Wed, 23 Jul 2008 21:12:18 +0200
Message-ID: <200807232112.18352.johannes.sixt@telecom.at>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at> <1216667998-8879-6-git-send-email-johannes.sixt@telecom.at> <7vfxq0e9lk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:13:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLjm5-00020L-TC
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbYGWTMW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 15:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbYGWTMW
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:12:22 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:42018 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbYGWTMV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 15:12:21 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id B1F2FBEEF7;
	Wed, 23 Jul 2008 21:12:18 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 731DD1D0E8;
	Wed, 23 Jul 2008 21:12:18 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vfxq0e9lk.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89748>

If GIT_EXEC_PATH (the macro that is defined in the Makefile) is relativ=
e,
it is interpreted relative to the command's invocation path, which usua=
lly
is $(bindir).

The Makefile rules were written with the assumption that $(gitexecdir) =
is
an absolute path. We introduce a separate variable that names the
(absolute) installation directory.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
On Mittwoch, 23. Juli 2008, Junio C Hamano wrote:
> Johannes Sixt <johannes.sixt@telecom.at> writes:
> > If $(gitexecdir) is relative, it is interpreted relative to the com=
mand's
> > invocation path, which usually is $(bindir).
> >
> > The Makefile rules were written with the assumption that $(gitexecd=
ir) is
> > an absolute path. We introduce a separate variable that names the
> > (absolute) installation directory.
> > =A0...
> > +ifeq ($(firstword $(subst /, ,$(gitexecdir))),..)
> > +gitexec_instdir =3D $(bindir)/$(gitexecdir)
> > +else
>
> Can we please have a brief comment in the Makefile near we define man=
dir,
> infodir, gitexecdir and friends about this "relative to $(bindir)"
> business?

Here it is.

It also fixes 'make install' of git-gui as well (sigh!) by not exportin=
g
gitexecdir - assuming that Shawn applies the git-gui patch.

The first two hunks are new compared to v1 of this patch.

-- Hannes

 Makefile   |   28 +++++++++++++++++++++++-----
 exec_cmd.c |   38 ++------------------------------------
 2 files changed, 25 insertions(+), 41 deletions(-)

diff --git a/Makefile b/Makefile
index 23f2185..4f19b52 100644
--- a/Makefile
+++ b/Makefile
@@ -170,6 +170,16 @@ ALL_CFLAGS =3D $(CFLAGS)
 ALL_LDFLAGS =3D $(LDFLAGS)
 STRIP ?=3D strip
=20
+# Among the variables below, these:
+#   gitexecdir
+#   template_dir
+#   htmldir
+#   ETC_GITCONFIG (but not sysconfdir)
+# can be specified as a relative path ../some/where/else (which must b=
egin
+# with ../); this is interpreted as relative to $(bindir) and "git" at
+# runtime figures out where they are based on the path to the executab=
le.
+# This can help installing the suite in a relocatable way.
+
 prefix =3D $(HOME)
 bindir =3D $(prefix)/bin
 mandir =3D $(prefix)/share/man
@@ -205,7 +215,7 @@ GITWEB_FAVICON =3D git-favicon.png
 GITWEB_SITE_HEADER =3D
 GITWEB_SITE_FOOTER =3D
=20
-export prefix bindir gitexecdir sharedir htmldir sysconfdir
+export prefix bindir sharedir htmldir sysconfdir
=20
 CC =3D gcc
 AR =3D ar
@@ -1316,10 +1326,18 @@ template_instdir =3D $(template_dir)
 endif
 export template_instdir
=20
+ifeq ($(firstword $(subst /, ,$(gitexecdir))),..)
+gitexec_instdir =3D $(bindir)/$(gitexecdir)
+else
+gitexec_instdir =3D $(gitexecdir)
+endif
+gitexec_instdir_SQ =3D $(subst ','\'',$(gitexec_instdir))
+export gitexec_instdir
+
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
-	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X=20
git-upload-archive$X '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR=3D'$(DESTDIR_SQ)' install
 	$(MAKE) -C perl prefix=3D'$(prefix_SQ)' DESTDIR=3D'$(DESTDIR_SQ)' ins=
tall
@@ -1328,10 +1346,10 @@ ifndef NO_TCLTK
 	$(MAKE) -C git-gui install
 endif
 ifneq (,$X)
-	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS=
) git$X)),=20
$(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p';)
+	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS=
) git$X)),=20
$(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
 endif
 	bindir=3D$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
-	execdir=3D$$(cd '$(DESTDIR_SQ)$(gitexecdir_SQ)' && pwd) && \
+	execdir=3D$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
 	if test "z$$bindir" !=3D "z$$execdir"; \
 	then \
 		ln -f "$$bindir/git$X" "$$execdir/git$X" || \
diff --git a/exec_cmd.c b/exec_cmd.c
index 45f92eb..c236034 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -7,40 +7,6 @@ extern char **environ;
 static const char *argv_exec_path;
 static const char *argv0_path;
=20
-static const char *builtin_exec_path(void)
-{
-#ifndef __MINGW32__
-	return GIT_EXEC_PATH;
-#else
-	int len;
-	char *p, *q, *sl;
-	static char *ep;
-	if (ep)
-		return ep;
-
-	len =3D strlen(_pgmptr);
-	if (len < 2)
-		return ep =3D ".";
-
-	p =3D ep =3D xmalloc(len+1);
-	q =3D _pgmptr;
-	sl =3D NULL;
-	/* copy program name, turn '\\' into '/', skip last part */
-	while ((*p =3D *q)) {
-		if (*q =3D=3D '\\' || *q =3D=3D '/') {
-			*p =3D '/';
-			sl =3D p;
-		}
-		p++, q++;
-	}
-	if (sl)
-		*sl =3D '\0';
-	else
-		ep[0] =3D '.', ep[1] =3D '\0';
-	return ep;
-#endif
-}
-
 const char *system_path(const char *path)
 {
 	if (!is_absolute_path(path) && argv0_path) {
@@ -75,7 +41,7 @@ const char *git_exec_path(void)
 		return env;
 	}
=20
-	return builtin_exec_path();
+	return system_path(GIT_EXEC_PATH);
 }
=20
 static void add_path(struct strbuf *out, const char *path)
@@ -99,7 +65,7 @@ void setup_path(void)
=20
 	add_path(&new_path, argv_exec_path);
 	add_path(&new_path, getenv(EXEC_PATH_ENVIRONMENT));
-	add_path(&new_path, builtin_exec_path());
+	add_path(&new_path, system_path(GIT_EXEC_PATH));
 	add_path(&new_path, argv0_path);
=20
 	if (old_path)
--=20
1.6.0.rc0.18.g6aef2
