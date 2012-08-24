From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/6] Replace gettext poison implementation with pseudotranslation generation
Date: Fri, 24 Aug 2012 12:43:03 +0700
Message-ID: <1345786986-10826-4-git-send-email-pclouds@gmail.com>
References: <1345786986-10826-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 07:44:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4mgl-0000aU-QH
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 07:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247Ab2HXFoF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Aug 2012 01:44:05 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39005 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175Ab2HXFoC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 01:44:02 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so2795592pbb.19
        for <git@vger.kernel.org>; Thu, 23 Aug 2012 22:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Nm4wh9TtJf49w8Rv3p0irVC8ng5Qa5U+ekKxI6GzuhE=;
        b=aeiOVcsTHy0FoIbrkuzfmtd+Kt7ODeRd91mRxN3N1RVX9gLjO9+9tTnr8x+h5HXEax
         VBswYQ0y+smB7i3fQUhCOFWztlUwSvxe14KFxyOgpOwAXn0OyYBB8pf8BwNWCteKDQIc
         z0CMgQGDAPoPaT8i+/uT3a0h4pgABDNr/vkET7Q3NbfsFGdHg/pgt/lHM4hcbW3ycv4E
         FAZ/zkFgJH4RGi+JKDRZheSS7ZDicAgdyqU4oS7wdQ+2jduXe1+jvGPHAQEHmmAomNq5
         Apw36KhQQuubztmB3KkXLzKo7lORqKzVePE5uZsqHRNn+K9S/sc4kJgpDS4cMdcx9HO1
         rO9w==
Received: by 10.68.132.230 with SMTP id ox6mr10157697pbb.116.1345787041405;
        Thu, 23 Aug 2012 22:44:01 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id po4sm4505325pbb.13.2012.08.23.22.43.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Aug 2012 22:44:00 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 24 Aug 2012 12:43:43 +0700
X-Mailer: git-send-email 1.7.12.rc2
In-Reply-To: <1345786986-10826-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204184>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile                  | 45 ++++++++++++++++++++++++++-------------=
------
 gettext.c                 | 10 ----------
 gettext.h                 | 10 +---------
 git-sh-i18n.sh            | 14 --------------
 po/.gitignore             |  1 +
 po/README                 | 15 ++++++++-------
 t/.gitignore              |  1 +
 t/lib-gettext.sh          |  7 ++++++-
 t/t0200-gettext-basic.sh  |  1 +
 t/t0205-gettext-poison.sh | 36 ------------------------------------
 t/test-lib.sh             |  2 +-
 wrap-for-bin.sh           | 10 +++++++++-
 12 files changed, 54 insertions(+), 98 deletions(-)
 delete mode 100755 t/t0205-gettext-poison.sh

diff --git a/Makefile b/Makefile
index 485978f..89f4fc0 100644
--- a/Makefile
+++ b/Makefile
@@ -258,11 +258,6 @@ all::
 # Define HAVE_DEV_TTY if your system can open /dev/tty to interact wit=
h the
 # user.
 #
-# Define GETTEXT_POISON if you are debugging the choice of strings mar=
ked
-# for translation.  In a GETTEXT_POISON build, you can turn all string=
s marked
-# for translation into gibberish by setting the GIT_GETTEXT_POISON var=
iable
-# (to any value) in your environment.
-#
 # Define JSMIN to point to JavaScript minifier that functions as
 # a filter to have gitweb.js minified.
 #
@@ -376,6 +371,8 @@ MSGFMT =3D msgfmt
 PTHREAD_LIBS =3D -lpthread
 PTHREAD_CFLAGS =3D
 GCOV =3D gcov
+PODEBUG =3D podebug
+PODEBUG_OPTS =3D --rewrite=3Dunicode
=20
 export TCL_PATH TCLTK_PATH
=20
@@ -1594,9 +1591,6 @@ endif
 ifdef NO_SYMLINK_HEAD
 	BASIC_CFLAGS +=3D -DNO_SYMLINK_HEAD
 endif
-ifdef GETTEXT_POISON
-	BASIC_CFLAGS +=3D -DGETTEXT_POISON
-endif
 ifdef NO_GETTEXT
 	BASIC_CFLAGS +=3D -DNO_GETTEXT
 	USE_GETTEXT_SCHEME ?=3D fallthrough
@@ -2403,19 +2397,28 @@ LOCALIZED_C :=3D $(C_OBJ_NOTESTS:o=3Dc) $(LIB_H=
) $(GENERATED_H)
 LOCALIZED_SH :=3D $(SCRIPT_SH)
 LOCALIZED_PERL :=3D $(SCRIPT_PERL)
=20
-ifdef XGETTEXT_INCLUDE_TESTS
-LOCALIZED_C +=3D t/t0200/test.c
-LOCALIZED_SH +=3D t/t0200/test.sh
-LOCALIZED_PERL +=3D t/t0200/test.perl
-endif
+LOCALIZED_C_TESTS +=3D t/t0200/test.c $(TEST_OBJS:o=3Dc)
+LOCALIZED_SH_TESTS +=3D t/t0200/test.sh
+LOCALIZED_PERL_TESTS +=3D t/t0200/test.perl
=20
-po/git.pot: $(LOCALIZED_C) $(LOCALIZED_SH) $(LOCALIZED_PERL)
-	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
-	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_S=
H) \
+po/git.pot+: $(LOCALIZED_C) $(LOCALIZED_SH) $(LOCALIZED_PERL)
+	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
+	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@ --join-existing $(XGETTEXT_FLAGS_SH=
) \
 		$(LOCALIZED_SH)
-	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_P=
ERL) \
+	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@ --join-existing $(XGETTEXT_FLAGS_PE=
RL) \
 		$(LOCALIZED_PERL)
-	mv $@+ $@
+
+po/git.pot: po/git.pot+
+	mv $< $@
+
+t/test.po: po/git.pot+ $(LOCALIZED_C_TESTS) $(LOCALIZED_SH_TESTS) $(LO=
CALIZED_PERL_TESTS)
+	cp $< $@t
+	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@t --join-existing $(XGETTEXT_FLAGS_C=
) $(LOCALIZED_C_TESTS)
+	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@t --join-existing $(XGETTEXT_FLAGS_S=
H) \
+		$(LOCALIZED_SH_TESTS)
+	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@t --join-existing $(XGETTEXT_FLAGS_P=
ERL) \
+		$(LOCALIZED_PERL_TESTS)
+	$(PODEBUG) $(PODEBUG_OPTS) $@t -o $@
=20
 pot: po/git.pot
=20
@@ -2429,6 +2432,11 @@ endif
 po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
 	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
=20
+po/build/pseudo-locale/$(L)/LC_MESSAGES/git.mo: t/test.po
+	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
+
+pseudo-locale: po/build/pseudo-locale/$(L)/LC_MESSAGES/git.mo
+
 FIND_SOURCE_FILES =3D ( git ls-files '*.[hcS]' 2>/dev/null || \
 			$(FIND) . \( -name .git -type d -prune \) \
 				-o \( -name '*.[hcS]' -type f -print \) )
@@ -2498,7 +2506,6 @@ ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=3DYesPlease >>$@
 endif
 	@echo NO_GETTEXT=3D\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\=
' >>$@
-	@echo GETTEXT_POISON=3D\''$(subst ','\'',$(subst ','\'',$(GETTEXT_POI=
SON)))'\' >>$@
 ifdef GIT_PERF_REPEAT_COUNT
 	@echo GIT_PERF_REPEAT_COUNT=3D\''$(subst ','\'',$(subst ','\'',$(GIT_=
PERF_REPEAT_COUNT)))'\' >>$@
 endif
diff --git a/gettext.c b/gettext.c
index f75bca7..6aa822c 100644
--- a/gettext.c
+++ b/gettext.c
@@ -16,16 +16,6 @@
 #	endif
 #endif
=20
-#ifdef GETTEXT_POISON
-int use_gettext_poison(void)
-{
-	static int poison_requested =3D -1;
-	if (poison_requested =3D=3D -1)
-		poison_requested =3D getenv("GIT_GETTEXT_POISON") ? 1 : 0;
-	return poison_requested;
-}
-#endif
-
 #ifndef NO_GETTEXT
 static void init_gettext_charset(const char *domain)
 {
diff --git a/gettext.h b/gettext.h
index 57ba8bb..634d8fb 100644
--- a/gettext.h
+++ b/gettext.h
@@ -36,22 +36,14 @@ static inline void git_setup_gettext(void)
 }
 #endif
=20
-#ifdef GETTEXT_POISON
-extern int use_gettext_poison(void);
-#else
-#define use_gettext_poison() 0
-#endif
-
 static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 {
-	return use_gettext_poison() ? "# GETTEXT POISON #" : gettext(msgid);
+	return gettext(msgid);
 }
=20
 static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
 const char *Q_(const char *msgid, const char *plu, unsigned long n)
 {
-	if (use_gettext_poison())
-		return "# GETTEXT POISON #";
 	return ngettext(msgid, plu, n);
 }
=20
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index 6a27f68..d446ba5 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -24,9 +24,6 @@ then
 elif test -n "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
 then
 	: no probing necessary
-elif test -n "$GIT_GETTEXT_POISON"
-then
-	GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dpoison
 elif type gettext.sh >/dev/null 2>&1
 then
 	# GNU libintl's gettext.sh
@@ -55,17 +52,6 @@ gettext_without_eval_gettext)
 		)
 	}
 	;;
-poison)
-	# Emit garbage so that tests that incorrectly rely on translatable
-	# strings will fail.
-	gettext () {
-		printf "%s" "# GETTEXT POISON #"
-	}
-
-	eval_gettext () {
-		printf "%s" "# GETTEXT POISON #"
-	}
-	;;
 *)
 	gettext () {
 		printf "%s" "$1"
diff --git a/po/.gitignore b/po/.gitignore
index 796b96d..0a4b7fa 100644
--- a/po/.gitignore
+++ b/po/.gitignore
@@ -1 +1,2 @@
 /build
+/git.pot+
diff --git a/po/README b/po/README
index c1520e8..7f40b08 100644
--- a/po/README
+++ b/po/README
@@ -270,16 +270,15 @@ something in the test suite might still depend on=
 the US English
 version of the strings, e.g. to grep some error message or other
 output.
=20
-To smoke out issues like these Git can be compiled with gettext poison
-support, at the top-level:
+To smoke out issues like these, we can use a podebug [1] utility
+to generate a pseudotranslation. At top level:
=20
-    make GETTEXT_POISON=3DYesPlease
+    # Assume locale "vi_VN.UTF-8" is supported by system
+    make pseudo-locale L=3Dvi
+    make GETTEXT_POISON=3Dvi_VN.UTF-8 test
=20
 That'll give you a git which emits gibberish on every call to
-gettext. It's obviously not meant to be installed, but you should run
-the test suite with it:
-
-    cd t && prove -j 9 ./t[0-9]*.sh
+gettext.
=20
 If tests break with it you should inspect them manually and see if
 what you're translating is sane, i.e. that you're not translating
@@ -290,3 +289,5 @@ test_cmp calls with test_i18ncmp. If that's not eno=
ugh you can skip
 the whole test by making it depend on the C_LOCALE_OUTPUT
 prerequisite. See existing test files with this prerequisite for
 examples.
+
+[1] http://translate.sourceforge.net/wiki/toolkit/podebug
diff --git a/t/.gitignore b/t/.gitignore
index 4e731dc..077b7d5 100644
--- a/t/.gitignore
+++ b/t/.gitignore
@@ -1,3 +1,4 @@
 /trash directory*
 /test-results
 /.prove
+/test.po*
diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index 0f76f6c..50b5ef9 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -5,7 +5,12 @@
=20
 . ./test-lib.sh
=20
-GIT_TEXTDOMAINDIR=3D"$GIT_BUILD_DIR/po/build/locale"
+if test -n "$GETTEXT_POISON"
+then
+	GIT_TEXTDOMAINDIR=3D"$GIT_BUILD_DIR/po/build/pseudo-locale"
+else
+	GIT_TEXTDOMAINDIR=3D"$GIT_BUILD_DIR/po/build/locale"
+fi
 GIT_PO_PATH=3D"$GIT_BUILD_DIR/po"
 export GIT_TEXTDOMAINDIR GIT_PO_PATH
=20
diff --git a/t/t0200-gettext-basic.sh b/t/t0200-gettext-basic.sh
index 8853d8a..572df23 100755
--- a/t/t0200-gettext-basic.sh
+++ b/t/t0200-gettext-basic.sh
@@ -36,6 +36,7 @@ test_expect_success GETTEXT 'sanity: $TEXTDOMAINDIR e=
xists without NO_GETTEXT=3DYe
 '
=20
 test_expect_success GETTEXT 'sanity: Icelandic locale was compiled' '
+    test -n "$GETTEXT_POISON" ||
     test -f "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
 '
=20
diff --git a/t/t0205-gettext-poison.sh b/t/t0205-gettext-poison.sh
deleted file mode 100755
index 2361590..0000000
--- a/t/t0205-gettext-poison.sh
+++ /dev/null
@@ -1,36 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
-#
-
-test_description=3D'Gettext Shell poison'
-
-. ./lib-gettext.sh
-
-test_expect_success GETTEXT_POISON "sanity: \$GIT_INTERNAL_GETTEXT_SH_=
SCHEME is set (to $GIT_INTERNAL_GETTEXT_SH_SCHEME)" '
-    test -n "$GIT_INTERNAL_GETTEXT_SH_SCHEME"
-'
-
-test_expect_success GETTEXT_POISON 'sanity: $GIT_INTERNAL_GETTEXT_SH_S=
CHEME" is poison' '
-    test "$GIT_INTERNAL_GETTEXT_SH_SCHEME" =3D "poison"
-'
-
-test_expect_success GETTEXT_POISON 'gettext: our gettext() fallback ha=
s poison semantics' '
-    printf "# GETTEXT POISON #" >expect &&
-    gettext "test" >actual &&
-    test_cmp expect actual &&
-    printf "# GETTEXT POISON #" >expect &&
-    gettext "test more words" >actual &&
-    test_cmp expect actual
-'
-
-test_expect_success GETTEXT_POISON 'eval_gettext: our eval_gettext() f=
allback has poison semantics' '
-    printf "# GETTEXT POISON #" >expect &&
-    eval_gettext "test" >actual &&
-    test_cmp expect actual &&
-    printf "# GETTEXT POISON #" >expect &&
-    eval_gettext "test more words" >actual &&
-    test_cmp expect actual
-'
-
-test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index bb4f886..b18a079 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -626,7 +626,7 @@ test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 # Can we rely on git's output in the C locale?
 if test -n "$GETTEXT_POISON"
 then
-	GIT_GETTEXT_POISON=3DYesPlease
+	GIT_GETTEXT_POISON=3D$GETTEXT_POISON
 	export GIT_GETTEXT_POISON
 	test_set_prereq GETTEXT_POISON
 else
diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
index 53a8dd0..a2d9aef 100644
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -15,7 +15,15 @@ else
 	export GIT_TEMPLATE_DIR
 fi
 GITPERLLIB=3D'@@BUILD_DIR@@/perl/blib/lib'
-GIT_TEXTDOMAINDIR=3D'@@BUILD_DIR@@/po/build/locale'
+if test -n "$GIT_GETTEXT_POISON"
+then
+	GIT_TEXTDOMAINDIR=3D'@@BUILD_DIR@@/po/build/pseudo-locale'
+	LANG=3D$GIT_GETTEXT_POISON
+	unset LC_ALL
+	export LANG
+else
+	GIT_TEXTDOMAINDIR=3D'@@BUILD_DIR@@/po/build/locale'
+fi
 PATH=3D'@@BUILD_DIR@@/bin-wrappers:'"$PATH"
 export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
=20
--=20
1.7.12.rc2
