From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v4 2/8] Makefile & configure: add a NO_FNMATCH_CASEFOLD flag
Date: Mon,  4 Oct 2010 02:48:11 +0000
Message-ID: <1286160491-4026-1-git-send-email-avarab@gmail.com>
References: <201010031958.59482.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Brandon Casey <drafnel@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 04 04:49:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2b7M-0006PM-2y
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 04:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369Ab0JDCs1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 22:48:27 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37147 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab0JDCs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 22:48:26 -0400
Received: by wwj40 with SMTP id 40so3542817wwj.1
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 19:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=RdEZybDI7C+l227fJb0/7dXlTIaChb/2s5/cWStYYbA=;
        b=Gym1QK+bQuF8JGoPt39R/N75dsssh283l096prMq8ZFOw2FsDZWzznoYvhpqGGsThn
         gmjzsdw2/QpznNshD1/RhQe5HtmLbUSiB/Vc4zoJCT0ZPZa/p5jdsmmUQHyvDpdqjfhV
         ZICF1YfuCoFw4XwXuPBHU7EEx3sE03LXz4m+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ggOdBJWDQ8+uWCdiRzWCm/h0NaHGqPc+SCLur+RO5ERE4Y0mUg4SvyvefajtmCYXN6
         MuvVqC21y0dHxKzDslt4yEJqe4YxWC7w9zuyNCsvifLCXljjK+gNFsLZhI6Vpu6SHg+4
         h3wBE9HGj21e3B12vgWSqbZClZWubiRNYjfaI=
Received: by 10.216.174.143 with SMTP id x15mr4636643wel.105.1286160504425;
        Sun, 03 Oct 2010 19:48:24 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b10sm2613490wer.17.2010.10.03.19.48.21
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 19:48:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <201010031958.59482.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157959>

On some platforms (like Solaris) there is a fnmatch, but it doesn't
support the GNU FNM_CASEFOLD extension that's used by the
jj/icase-directory series' fnmatch_icase wrapper.

Change the Makefile so that it's now possible to set
NO_FNMATCH_CASEFOLD=3DYesPlease on those systems, and add a configure
probe for it.

Unlike the NO_REGEX check we don't add AC_INCLUDES_DEFAULT to our
headers. This is because on a GNU system the definition of
=46NM_CASEFOLD in fnmatch.h is guarded by:

    #if !defined _POSIX_C_SOURCE || _POSIX_C_SOURCE < 2 || defined _GNU=
_SOURCE

One of the headers AC_INCLUDES_DEFAULT includes ends up defining one
of those, so if we'd use it we'd always get
NO_FNMATCH_CASEFOLD=3DYesPlease on GNU systems, even though they have
=46NM_CASEFOLD.

When checking the flags we use:

    ifdef NO_FNMATCH
    ...
    else
    ifdef NO_FNMATCH_CASEFOLD
    ...
    endif
    endif

The "else" so that we don't link against compat/fnmatch/fnmatch.o
twice if both NO_FNMATCH and NO_FNMATCH_CASEFOLD are defined.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

On Sun, Oct 3, 2010 at 17:58, Johannes Sixt <j6t@kdbg.org> wrote:
> I think you should protect against defining both NO_FNMATCH and
> NO_FNMATCH_CASEFOLD (your version would link compat/fnmatch/fnmatch.o=
 twice
> in this case):

Well spotted. That's fixed in this version.

 Makefile      |   10 ++++++++++
 config.mak.in |    1 +
 configure.ac  |   22 ++++++++++++++++++++++
 3 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index f7c4383..7bd0a2b 100644
--- a/Makefile
+++ b/Makefile
@@ -72,6 +72,9 @@ all::
 #
 # Define NO_FNMATCH if you don't have fnmatch in the C library.
 #
+# Define NO_FNMATCH_CASEFOLD if your fnmatch function doesn't have the
+# FNM_CASEFOLD GNU extension.
+#
 # Define NO_LIBGEN_H if you don't have libgen.h.
 #
 # Define NEEDS_LIBGEN if your libgen needs -lgen when linking
@@ -848,6 +851,7 @@ ifeq ($(uname_S),SunOS)
 	NO_MKDTEMP =3D YesPlease
 	NO_MKSTEMPS =3D YesPlease
 	NO_REGEX =3D YesPlease
+	NO_FNMATCH_CASEFOLD =3D YesPlease
 	ifeq ($(uname_R),5.6)
 		SOCKLEN_T =3D int
 		NO_HSTRERROR =3D YesPlease
@@ -1349,6 +1353,12 @@ ifdef NO_FNMATCH
 	COMPAT_CFLAGS +=3D -Icompat/fnmatch
 	COMPAT_CFLAGS +=3D -DNO_FNMATCH
 	COMPAT_OBJS +=3D compat/fnmatch/fnmatch.o
+else
+ifdef NO_FNMATCH_CASEFOLD
+	COMPAT_CFLAGS +=3D -Icompat/fnmatch
+	COMPAT_CFLAGS +=3D -DNO_FNMATCH_CASEFOLD
+	COMPAT_OBJS +=3D compat/fnmatch/fnmatch.o
+endif
 endif
 ifdef NO_SETENV
 	COMPAT_CFLAGS +=3D -DNO_SETENV
diff --git a/config.mak.in b/config.mak.in
index aaa70a8..56343ba 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -48,6 +48,7 @@ NO_HSTRERROR=3D@NO_HSTRERROR@
 NO_STRCASESTR=3D@NO_STRCASESTR@
 NO_STRTOK_R=3D@NO_STRTOK_R@
 NO_FNMATCH=3D@NO_FNMATCH@
+NO_FNMATCH_CASEFOLD=3D@NO_FNMATCH_CASEFOLD@
 NO_MEMMEM=3D@NO_MEMMEM@
 NO_STRLCPY=3D@NO_STRLCPY@
 NO_UINTMAX_T=3D@NO_UINTMAX_T@
diff --git a/configure.ac b/configure.ac
index 7715f6c..6dd9241 100644
--- a/configure.ac
+++ b/configure.ac
@@ -824,6 +824,28 @@ GIT_CHECK_FUNC(fnmatch,
 [NO_FNMATCH=3DYesPlease])
 AC_SUBST(NO_FNMATCH)
 #
+# Define NO_FNMATCH_CASEFOLD if your fnmatch function doesn't have the
+# FNM_CASEFOLD GNU extension.
+AC_CACHE_CHECK([whether the fnmatch function supports the FNMATCH_CASE=
=46OLD GNU extension],
+ [ac_cv_c_excellent_fnmatch], [
+AC_EGREP_CPP(yippeeyeswehaveit,
+	AC_LANG_PROGRAM([
+#include <fnmatch.h>
+],
+[#ifdef FNM_CASEFOLD
+yippeeyeswehaveit
+#endif
+]),
+	[ac_cv_c_excellent_fnmatch=3Dyes],
+	[ac_cv_c_excellent_fnmatch=3Dno])
+])
+if test $ac_cv_c_excellent_fnmatch =3D yes; then
+	NO_FNMATCH_CASEFOLD=3D
+else
+	NO_FNMATCH_CASEFOLD=3DYesPlease
+fi
+AC_SUBST(NO_FNMATCH_CASEFOLD)
+#
 # Define NO_MEMMEM if you don't have memmem.
 GIT_CHECK_FUNC(memmem,
 [NO_MEMMEM=3D],
--=20
1.7.3.159.g610493
