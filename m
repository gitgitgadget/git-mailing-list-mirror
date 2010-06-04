From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH RFC] gettext: Support building on non-GNU with -lintl
Date: Fri,  4 Jun 2010 16:36:10 +0000
Message-ID: <1275669370-6004-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 04 18:37:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKZtK-0004ds-B3
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 18:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475Ab0FDQg6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 12:36:58 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58708 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab0FDQg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 12:36:57 -0400
Received: by fxm8 with SMTP id 8so945557fxm.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 09:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=AmRw8P13VbryITl5DBWopk1YzlRQpktLQJdHM1itEpU=;
        b=Vj81a4wW0LQW90D3IJHtHWYyqFGe0XLtA94snus6Ez/QOp4x6K9Y3m35jPrnAeos0c
         lBw4oddVcye8DzVuRwpoyvKusik+QgpqGGSf3SRDX6sxO1x7PpcsFpdiGh3/jHVgaf2e
         EN50Jeaw372GJrkvVCEt/at65WDBgqGu62LMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=CUv+3Ty546PQMH5aHHum++Qg/unf4yGSqiQVmoJTKNOkYYWAOHgWzQN5aNwGZiXlK3
         17fyM6h/8Zdw33REUj1VusCNoqvvv8sGSFtekcrpkoKCzHlss75QSfFry436ytybaNBA
         sE9wY1NR+BNP6N54+uLWHpNOpFVv44HEWBEv0=
Received: by 10.102.182.28 with SMTP id e28mr3980936muf.78.1275669415918;
        Fri, 04 Jun 2010 09:36:55 -0700 (PDT)
Received: from aoeu.localdomain (pD95366A4.dip.t-dialin.net [217.83.102.164])
        by mx.google.com with ESMTPS id e9sm2089838muf.40.2010.06.04.09.36.54
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 09:36:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.243.gda92d6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148428>

Change the build process on non-GNU systems to use -lintl if
NO_GETTEXT hasn't been set.

Systems that use the GNU C Library don't need this, but on others the
GNU libintl library is an externally install package, so we need to
explicitly link to it.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

When I got access to a FreeBSD system I found that my gettext series
didn't link there, because -lintl needed to be supplied. GNU gettext
is only included in GNU libc, not other C libraries.

So here's a probe to check if we're building on a non-GNU
system. I.e. not Linux, Hurd or GNU/kFreeBSD. on non-GNU we -lintl
when linking unless NEEDS_LIBINTL=3D is supplied.

What I'm unsure about is this part:
   =20
    +ifndef NO_GETTEXT
    +	# Systems that use GNU gettext and glibc are the exception
    +	NEEDS_LIBINTL =3D YesPlease
    +endif

As far as I can see there's no other NEED_* feature that's on by
default. I think it makes more sense to explicitly list those
platforms that are likely to have glibc, rather than try to enumerate
all those without. Especially since that would break the build process
on any new platform that the makefile doesn't know about, but perhaps
there's a better way to do this.

If you're using e.g. glibc on a *BSD you can just build Git as:

    gmake NEEDS_LIBINTL=3D

This also work, i.e. doesn't link to -lintl because NO_GETTEXT is
given:

    gmake NEEDS_LIBINTL=3DYesPlease NO_GETTEXT=3DYesPlease

But this works now so I'll keep it if there aren't objections, and
perhaps the "Platform specific defaults" could be used for something
else.

Should I include a GETTEXTDIR option similar to CURLDIR and EXPATDIR
in the Makefile? Now it just assumes that it can find gettext.h and
libintl in the default paths.

 Makefile |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 5169aec..1dfcd65 100644
--- a/Makefile
+++ b/Makefile
@@ -28,6 +28,15 @@ all::
 # Define NO_EXPAT if you do not have expat installed.  git-http-push i=
s
 # not built, and you cannot push using http:// and https:// transports=
=2E
 #
+# Define NO_GETTEXT if you don't have libintl installed, or don't want
+# to build Git with localization support.
+#
+# Define NEEDS_LIBINTL if you haven't defined NO_GETTEXT=3DYesPlease,
+# but your system needs to be explicitly linked to -lintl. This is
+# defined automatically if we're building gettext support on systems
+# where we expect not to use glibc (which has libintl included in
+# libc).
+#
 # Define EXPATDIR=3D/foo/bar if your expat header and library files ar=
e in
 # /foo/bar/include and /foo/bar/lib directories.
 #
@@ -741,6 +750,14 @@ EXTLIBS =3D
 # Platform specific tweaks
 #
=20
+# Platform specific defaults. Where we'd only like some feature on the
+# minority of systems, e.g. if linking to a library isn't needed
+# because its features are included in the GNU C library.
+ifndef NO_GETTEXT
+	# Systems that use GNU gettext and glibc are the exception
+	NEEDS_LIBINTL =3D YesPlease
+endif
+
 # We choose to avoid "if .. else if .. else .. endif endif"
 # because maintaining the nesting to match is a pain.  If
 # we had "elif" things would have been much nicer...
@@ -749,11 +766,13 @@ ifeq ($(uname_S),Linux)
 	NO_STRLCPY =3D YesPlease
 	NO_MKSTEMPS =3D YesPlease
 	HAVE_PATHS_H =3D YesPlease
+	NEEDS_LIBINTL =3D
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY =3D YesPlease
 	NO_MKSTEMPS =3D YesPlease
 	HAVE_PATHS_H =3D YesPlease
+	NEEDS_LIBINTL =3D
 endif
 ifeq ($(uname_S),UnixWare)
 	CC =3D cc
@@ -923,6 +942,7 @@ ifeq ($(uname_S),GNU)
 	NO_STRLCPY=3DYesPlease
 	NO_MKSTEMPS =3D YesPlease
 	HAVE_PATHS_H =3D YesPlease
+	NEEDS_LIBINTL =3D
 endif
 ifeq ($(uname_S),IRIX)
 	NO_SETENV =3D YesPlease
@@ -1395,7 +1415,9 @@ endif
 ifdef NO_GETTEXT
 	COMPAT_CFLAGS +=3D -DNO_GETTEXT
 else
-	LIBINTL =3D -lintl
+	ifdef NEEDS_LIBINTL
+		EXTLIBS +=3D -lintl
+	endif
 endif
=20
 ifeq ($(TCLTK_PATH),)
--=20
1.7.0.4
