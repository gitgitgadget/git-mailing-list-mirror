From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] add a Makefile switch to avoid gettext translation in shell
 scripts
Date: Thu, 19 Jan 2012 20:52:22 +0100
Message-ID: <20120119195222.GA5011@blimp.dmz>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
 <CALxABCbaBmP6k5TYrYLCYm8oiv=9cF=N7_opSTKUnbkz5b-cwg@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 20:52:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rny2B-0003Yl-Jy
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 20:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932848Ab2ASTw0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jan 2012 14:52:26 -0500
Received: from h877881.serverkompetenz.net ([85.214.60.77]:49585 "EHLO
	h877881.serverkompetenz.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932670Ab2ASTwZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2012 14:52:25 -0500
Received: from tigra.home (krlh-4d035602.pool.mediaWays.net [77.3.86.2])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by h877881.serverkompetenz.net (Postfix) with ESMTPSA id 922148C0623;
	Thu, 19 Jan 2012 20:52:23 +0100 (CET)
Received: from blimp.localdomain (unknown [192.168.0.100])
	by tigra.home (Postfix) with ESMTP id 9A5F59FC8C;
	Thu, 19 Jan 2012 20:52:22 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 4AD342DD; Thu, 19 Jan 2012 20:52:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CALxABCbaBmP6k5TYrYLCYm8oiv=9cF=N7_opSTKUnbkz5b-cwg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188827>

Some systems have gettext.sh (GNU gettext) installed, but it is either =
broken
or misconfigured in such a way so its output is not usable.
=46or instance, on this particular system, a Cygwin installations gette=
xt
produces no output whatsoever.

In case the users of these systems are unable or not interested in fixi=
ng
them, setting the new Makefile switch should help:

    USE_FALLTHROUGH_GETTEXT_SCHEME=3Dyes

This will replace the translation routines with fallthrough versions, w=
hich
currently used only for regression testing.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Alex Riesen, Thu, Jan 19, 2012 10:13:20 +0100:
> On Thu, Jan 19, 2012 at 00:18, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
> > It makes sense to prefer the system functions by default in both
> > cases, but when the OS one can be broken or lacking we can just add
> > probes or Makefile options like we do for fnmatch() with the
> > NO_FNMATCH_CASEFOLD switch.
>=20
> Yes, and I personally shall welcome a chance to insult the local IT
> by suggesting BROKEN_SH_GETTEXT. Not that they get the point...

I believe this patch does just that. It is certainly enough for my purp=
oses.
The copy-paste error noticed by Jonathan is also fixed, thanks!
I didn't add the tracking of the switch in GIT-BUILD-OPTIONS: didn't fo=
und
how to do it quickly enough in this time of evening, and gave up, think=
ing
that no one sane would need to set the option anyway. So at the moment =
a
"make clean" needed when changing it.

 Makefile       |    4 ++
 git-sh-i18n.sh |  102 +++++++++++++++++++++++++++---------------------=
--------
 2 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/Makefile b/Makefile
index a782409..806d126 100644
--- a/Makefile
+++ b/Makefile
@@ -47,6 +47,9 @@ all::
 # A translated Git requires GNU libintl or another gettext implementat=
ion,
 # plus libintl-perl at runtime.
 #
+# Define USE_FALLTHROUGH_GETTEXT_SCHEME, if you don't want to trust th=
e
+# installed gettext translation of the shell scripts output.
+#
 # Define HAVE_LIBCHARSET_H if you haven't set NO_GETTEXT and you can't
 # trust the langinfo.h's nl_langinfo(CODESET) function to return the
 # current character set. GNU and Solaris have a nl_langinfo(CODESET),
@@ -1887,6 +1890,7 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
     -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' \
     -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
+    -e 's/@@USE_FALLTHROUGH_GETTEXT_SCHEME@@/$(USE_FALLTHROUGH_GETTEXT=
_SCHEME)/g' \
     -e $(BROKEN_PATH_FIX) \
     $@.sh >$@+
 endef
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index b4575fb..da8b214 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -16,61 +16,44 @@ else
 fi
 export TEXTDOMAINDIR
=20
-if test -z "$GIT_GETTEXT_POISON"
+GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dfallthrough
+if test -n "@@USE_FALLTHROUGH_GETTEXT_SCHEME@@$GIT_INTERNAL_GETTEXT_TE=
ST_FALLBACKS"
+then
+	: no probing necessary
+elif test -n "$GIT_GETTEXT_POISON"
 then
-	if test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && type gettext.sh =
>/dev/null 2>&1
-	then
-		# This is GNU libintl's gettext.sh, we don't need to do anything
-		# else than setting up the environment and loading gettext.sh
-		GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dgnu
-		export GIT_INTERNAL_GETTEXT_SH_SCHEME
-
-		# Try to use libintl's gettext.sh, or fall back to English if we
-		# can't.
-		. gettext.sh
-
-	elif test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && test "$(gettex=
t -h 2>&1)" =3D "-h"
-	then
-		# We don't have gettext.sh, but there's a gettext binary in our
-		# path. This is probably Solaris or something like it which has a
-		# gettext implementation that isn't GNU libintl.
-		GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dsolaris
-		export GIT_INTERNAL_GETTEXT_SH_SCHEME
-
-		# Solaris has a gettext(1) but no eval_gettext(1)
-		eval_gettext () {
-			gettext "$1" | (
-				export PATH $(git sh-i18n--envsubst --variables "$1");
-				git sh-i18n--envsubst "$1"
-			)
-		}
-
-	else
-		# Since gettext.sh isn't available we'll have to define our own
-		# dummy pass-through functions.
-
-		# Tell our tests that we don't have the real gettext.sh
-		GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dfallthrough
-		export GIT_INTERNAL_GETTEXT_SH_SCHEME
-
-		gettext () {
-			printf "%s" "$1"
-		}
-
-		eval_gettext () {
-			printf "%s" "$1" | (
-				export PATH $(git sh-i18n--envsubst --variables "$1");
-				git sh-i18n--envsubst "$1"
-			)
-		}
-	fi
-else
-	# Emit garbage under GETTEXT_POISON=3DYesPlease. Unlike the C tests
-	# this relies on an environment variable
-
 	GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dpoison
-	export GIT_INTERNAL_GETTEXT_SH_SCHEME
+elif type gettext.sh >/dev/null 2>&1
+then
+	# This is GNU libintl's gettext.sh, we don't need to do anything
+	# else than setting up the environment and loading gettext.sh
+	GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dgnu
+elif test "$(gettext -h 2>&1)" =3D "-h"
+then
+	# We don't have gettext.sh, but there's a gettext binary in our
+	# path. This is probably Solaris or something like it which has a
+	# gettext implementation that isn't GNU libintl.
+	GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dsolaris
+fi
+export GIT_INTERNAL_GETTEXT_SH_SCHEME
=20
+case "$GIT_INTERNAL_GETTEXT_SH_SCHEME" in
+gnu)
+	# Try to use libintl's gettext.sh, or fall back to English if we
+	# can't.
+	. gettext.sh
+	;;
+solaris)
+	# Solaris has a gettext(1) but no eval_gettext(1)
+	eval_gettext () {
+		gettext "$1" | (
+			export PATH $(git sh-i18n--envsubst --variables "$1");
+			git sh-i18n--envsubst "$1"
+		)
+	}
+	;;
+poison)
+	# Used in tests
 	gettext () {
 		printf "%s" "# GETTEXT POISON #"
 	}
@@ -78,7 +61,20 @@ else
 	eval_gettext () {
 		printf "%s" "# GETTEXT POISON #"
 	}
-fi
+	;;
+*)
+	gettext () {
+		printf "%s" "$1"
+	}
+
+	eval_gettext () {
+		printf "%s" "$1" | (
+			export PATH $(git sh-i18n--envsubst --variables "$1");
+			git sh-i18n--envsubst "$1"
+		)
+	}
+	;;
+esac
=20
 # Git-specific wrapper functions
 gettextln () {
--=20
1.7.9.rc1.92.ga90a1
