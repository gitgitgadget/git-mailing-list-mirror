From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] i18n: add infrastructure for translating Git with gettext
Date: Sun, 13 Nov 2011 14:43:55 +0100
Message-ID: <1321191835-24062-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 14:44:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPaMP-0002h3-8q
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 14:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738Ab1KMNo3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Nov 2011 08:44:29 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41059 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab1KMNoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 08:44:25 -0500
Received: by bke11 with SMTP id 11so4920146bke.19
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 05:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=+wxOvoHG6KYNNJ/VSJz0av+NUohldcAMfxU1HhXAbW4=;
        b=FRXxmJOXEWcIpwQdJBNTYDGKAYzcneHqdoQ09W+FlhBQHi+YYJXnLk4JclimGvOZth
         z88cnwG5dXobeRtzOfj/FdwR0NrunznZ94AGQJc8KmufnE6idDFee/ckY8wMAFVt0bpc
         IfGb9VAruvB00CQYvYD94gAjphwIb/Xb+J0p4=
Received: by 10.204.156.68 with SMTP id v4mr15392305bkw.88.1321191862842;
        Sun, 13 Nov 2011 05:44:22 -0800 (PST)
Received: from snth.ams7.corp.booking.com ([62.140.137.69])
        by mx.google.com with ESMTPS id e18sm4479245bkr.15.2011.11.13.05.44.18
        (version=SSLv3 cipher=OTHER);
        Sun, 13 Nov 2011 05:44:22 -0800 (PST)
X-Mailer: git-send-email 1.7.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185338>

Change the skeleton implementation of i18n in Git to one that can show
localized strings to users for our C, Shell and Perl programs using
either GNU libint or the Solaris gettext implementation.

This new internationalization support is enabled by default. If
gettext isn't available, or if Git is compiled with
NO_GETTEXT=3DYesPlease, Git fall back on its current behavior of showin=
g
interface messages in English. When using the autoconf script we'll
auto-detect if the gettext libraries are installed and act
appropriately.

This change is somewhat large because as well as adding a C, Shell and
Perl i18n interface we're adding a lot of tests for them, and for
those tests to work we need a skeleton PO file to actually test
translations. A minimal Icelandic translation is included for this
purpose. Icelandic includes multi-byte characters which makes it easy
to test various edge cases, and it's a language I happen to
understand.

The rest of the commit message goes into detail about various
sub-parts of this commit.

=3D Installation

Gettext .mo files will be installed and looked for in the standard
$(prefix)/share/locale path. GIT_TEXTDOMAINDIR can also be set to
override that, but that's only intended to be used to test Git itself.

=3D Perl

Perl code that's to be localized should use the new Git::I18n
module. It imports a __ function into the caller's package by default.

Instead of using the high level Locale::TextDomain interface I've
opted to use the low-level (equivalent to the C interface)
Locale::Messages module, which Locale::TextDomain itself uses.

Locale::TextDomain does a lot of redundant work we don't need, and
some of it would potentially introduce bugs. It tries to set the
$TEXTDOMAIN based on package of the caller, and has its own
hardcoded paths where it'll search for messages.

I found it easier just to completely avoid it rather than try to
circumvent its behavior. In any case, this is an issue wholly
internal Git::I18N. Its guts can be changed later if that's deemed
necessary.

See <AANLkTilYD_NyIZMyj9dHtVk-ylVBfvyxpCC7982LWnVd@mail.gmail.com> for
a further elaboration on this topic.

=3D Shell

Shell code that's to be localized should use the git-sh-i18n
library. It's basically just a wrapper for the system's gettext.sh.

If gettext.sh isn't available we'll fall back on gettext(1) if it's
available. The latter is available without the former on Solaris,
which has its own non-GNU gettext implementation. We also need to
emulate eval_gettext() there.

If neither are present we'll use a dumb printf(1) fall-through
wrapper.

=3D About libcharset.h and langinfo.h

We use libcharset to query the character set of the current locale if
it's available. I.e. we'll use it instead of nl_langinfo if
HAVE_LIBCHARSET_H is set.

The GNU gettext manual recommends using langinfo.h's
nl_langinfo(CODESET) to acquire the current character set, but on
systems that have libcharset.h's locale_charset() using the latter is
either saner, or the only option on those systems.

GNU and Solaris have a nl_langinfo(CODESET), FreeBSD can use either,
but MinGW and some others need to use libcharset.h's locale_charset()
instead.

=3DCredits

This patch is based on work by Jeff Epler <jepler@unpythonic.net> who
did the initial Makefile / C work, and a lot of comments from the Git
mailing list, including Jonathan Nieder, Jakub Narebski, Johannes
Sixt, Erik Faye-Lund, Peter Krefting, Junio C Hamano, Thomas Rast and
others.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
So here's a non-RFC of the i18n infrastructure patch. I've tested this
both with/without NO_GETTEXT=3DYesPlease and with/without
GETTEXT_POISON=3DYesPlease on both Linux and Solaris.

There are no major changes since the RFC, aside from revamping the
po/README file to match the new i18n functions that we now have.

 .gitignore                          |    1 +
 Documentation/CodingGuidelines      |    7 +
 INSTALL                             |   12 ++
 Makefile                            |   81 ++++++++++++-
 config.mak.in                       |    3 +
 configure.ac                        |   19 +++
 daemon.c                            |    2 +
 fast-import.c                       |    2 +
 gettext.c                           |  117 ++++++++++++++++++
 gettext.h                           |   25 ++++-
 git-sh-i18n.sh                      |  100 +++++++++++-----
 git.c                               |    2 +
 http-backend.c                      |    2 +
 http-fetch.c                        |    2 +
 http-push.c                         |    2 +
 imap-send.c                         |    2 +
 perl/Git/I18N.pm                    |   89 ++++++++++++++
 perl/Makefile                       |    3 +-
 perl/Makefile.PL                    |   14 ++-
 po/README                           |  229 +++++++++++++++++++++++++++=
++++++++
 po/is.po                            |   93 ++++++++++++++
 shell.c                             |    2 +
 show-index.c                        |    2 +
 t/lib-gettext.sh                    |   55 +++++++++
 t/t0200-gettext-basic.sh            |  108 ++++++++++++++++
 t/t0200/test.c                      |   23 ++++
 t/t0200/test.perl                   |   14 ++
 t/t0200/test.sh                     |   14 ++
 t/t0201-gettext-fallbacks.sh        |   20 +++-
 t/t0202-gettext-perl.sh             |   27 ++++
 t/t0202/test.pl                     |  110 +++++++++++++++++
 t/t0203-gettext-setlocale-sanity.sh |   26 ++++
 t/t0204-gettext-reencode-sanity.sh  |   78 ++++++++++++
 t/t0205-gettext-poison.sh           |   36 ++++++
 t/test-lib.sh                       |    3 +
 upload-pack.c                       |    2 +
 wrap-for-bin.sh                     |    3 +-
 37 files changed, 1291 insertions(+), 39 deletions(-)
 create mode 100644 perl/Git/I18N.pm
 create mode 100644 po/README
 create mode 100644 po/is.po
 create mode 100644 t/lib-gettext.sh
 create mode 100755 t/t0200-gettext-basic.sh
 create mode 100644 t/t0200/test.c
 create mode 100644 t/t0200/test.perl
 create mode 100644 t/t0200/test.sh
 create mode 100755 t/t0202-gettext-perl.sh
 create mode 100644 t/t0202/test.pl
 create mode 100755 t/t0203-gettext-setlocale-sanity.sh
 create mode 100755 t/t0204-gettext-reencode-sanity.sh
 create mode 100755 t/t0205-gettext-poison.sh

diff --git a/.gitignore b/.gitignore
index 8572c8c..c47f3a8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -224,3 +224,4 @@
 *.pdb
 /Debug/
 /Release/
+/share/
diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuide=
lines
index fe1c1e5..4830086 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -81,6 +81,10 @@ For shell scripts specifically (not exhaustive):
      are ERE elements not BRE (note that \? and \+ are not even part
      of BRE -- making them accessible from BRE is a GNU extension).
=20
+ - Use Git's gettext wrappers in git-sh-i18n to make the user
+   interface translatable. See "Marking strings for translation" in
+   po/README.
+
 For C programs:
=20
  - We use tabs to indent, and interpret tabs as taking up to
@@ -144,6 +148,9 @@ For C programs:
  - When we pass <string, length> pair to functions, we should try to
    pass them in that order.
=20
+ - Use Git's gettext wrappers to make the user interface
+   translatable. See "Marking strings for translation" in po/README.
+
 Writing Documentation:
=20
  Every user-visible change should be reflected in the documentation.
diff --git a/INSTALL b/INSTALL
index bf0d97e..8120641 100644
--- a/INSTALL
+++ b/INSTALL
@@ -106,6 +106,18 @@ Issues of note:
 	  history graphically, and in git-gui.  If you don't want gitk or
 	  git-gui, you can use NO_TCLTK.
=20
+	- A gettext library is used by default for localizing Git. The
+	  primary target is GNU libintl, but the Solaris gettext
+	  implementation also works.
+
+	  We need a gettext.h on the system for C code, gettext.sh (or
+	  Solaris gettext(1)) for shell scripts, and libintl-perl for Perl
+	  programs.
+
+	  Set NO_GETTEXT to disable localization support and make Git only
+	  use English. Under autoconf the configure script will do this
+	  automatically if it can't find libintl on the system.
+
  - Some platform specific issues are dealt with Makefile rules,
    but depending on your specific installation, you may not
    have all the libraries/tools needed, or you may have
diff --git a/Makefile b/Makefile
index ee34eab..896f5fd 100644
--- a/Makefile
+++ b/Makefile
@@ -43,6 +43,22 @@ all::
 # Define EXPATDIR=3D/foo/bar if your expat header and library files ar=
e in
 # /foo/bar/include and /foo/bar/lib directories.
 #
+# Define NO_GETTEXT if you don't want Git output to be translated.
+# A translated Git requires GNU libintl or another gettext implementat=
ion,
+# plus libintl-perl at runtime.
+#
+# Define HAVE_LIBCHARSET_H if you haven't set NO_GETTEXT and you can't
+# trust the langinfo.h's nl_langinfo(CODESET) function to return the
+# current character set. GNU and Solaris have a nl_langinfo(CODESET),
+# FreeBSD can use either, but MinGW and some others need to use
+# libcharset.h's locale_charset() instead.
+#
+# Define LIBC_CONTAINS_LIBINTL if your gettext implementation doesn't
+# need -lintl when linking.
+#
+# Define NO_MSGFMT_CHECK if your implementation of msgfmt doesn't
+# support the --check GNU extension to msgfmt(1)
+#
 # Define HAVE_PATHS_H if you have paths.h and want to use the default =
PATH
 # it specifies.
 #
@@ -301,6 +317,7 @@ gitexecdir =3D libexec/git-core
 mergetoolsdir =3D $(gitexecdir)/mergetools
 sharedir =3D $(prefix)/share
 gitwebdir =3D $(sharedir)/gitweb
+localedir =3D $(sharedir)/locale
 template_dir =3D share/git-core/templates
 htmldir =3D share/doc/git-doc
 ETC_GITCONFIG =3D $(sysconfdir)/gitconfig
@@ -309,7 +326,7 @@ lib =3D lib
 # DESTDIR=3D
 pathsep =3D :
=20
-export prefix bindir sharedir sysconfdir gitwebdir
+export prefix bindir sharedir sysconfdir gitwebdir localedir
=20
 CC =3D gcc
 AR =3D ar
@@ -322,6 +339,7 @@ RPMBUILD =3D rpmbuild
 TCL_PATH =3D tclsh
 TCLTK_PATH =3D wish
 XGETTEXT =3D xgettext
+MSGFMT =3D msgfmt
 PTHREAD_LIBS =3D -lpthread
 PTHREAD_CFLAGS =3D
 GCOV =3D gcov
@@ -621,6 +639,7 @@ LIB_OBJS +=3D entry.o
 LIB_OBJS +=3D environment.o
 LIB_OBJS +=3D exec_cmd.o
 LIB_OBJS +=3D fsck.o
+LIB_OBJS +=3D gettext.o
 LIB_OBJS +=3D graph.o
 LIB_OBJS +=3D grep.o
 LIB_OBJS +=3D hash.o
@@ -817,12 +836,14 @@ ifeq ($(uname_S),Linux)
 	NO_STRLCPY =3D YesPlease
 	NO_MKSTEMPS =3D YesPlease
 	HAVE_PATHS_H =3D YesPlease
+	LIBC_CONTAINS_LIBINTL =3D YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY =3D YesPlease
 	NO_MKSTEMPS =3D YesPlease
 	HAVE_PATHS_H =3D YesPlease
 	DIR_HAS_BSD_GROUP_SEMANTICS =3D YesPlease
+	LIBC_CONTAINS_LIBINTL =3D YesPlease
 endif
 ifeq ($(uname_S),UnixWare)
 	CC =3D cc
@@ -889,6 +910,7 @@ ifeq ($(uname_S),SunOS)
 	NO_MKSTEMPS =3D YesPlease
 	NO_REGEX =3D YesPlease
 	NO_FNMATCH_CASEFOLD =3D YesPlease
+	NO_MSGFMT_CHECK =3D YesPlease
 	ifeq ($(uname_R),5.6)
 		SOCKLEN_T =3D int
 		NO_HSTRERROR =3D YesPlease
@@ -1012,6 +1034,7 @@ ifeq ($(uname_S),GNU)
 	NO_STRLCPY=3DYesPlease
 	NO_MKSTEMPS =3D YesPlease
 	HAVE_PATHS_H =3D YesPlease
+	LIBC_CONTAINS_LIBINTL =3D YesPlease
 endif
 ifeq ($(uname_S),IRIX)
 	NO_SETENV =3D YesPlease
@@ -1228,6 +1251,7 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	EXTLIBS +=3D /mingw/lib/libz.a
 	NO_R_TO_GCC_LINKER =3D YesPlease
 	INTERNAL_QSORT =3D YesPlease
+	HAVE_LIBCHARSET_H =3D YesPlease
 else
 	NO_CURL =3D YesPlease
 endif
@@ -1405,6 +1429,11 @@ endif
 ifdef NEEDS_LIBGEN
 	EXTLIBS +=3D -lgen
 endif
+ifndef NO_GETTEXT
+ifndef LIBC_CONTAINS_LIBINTL
+	EXTLIBS +=3D -lintl
+endif
+endif
 ifdef NEEDS_SOCKET
 	EXTLIBS +=3D -lsocket
 endif
@@ -1447,9 +1476,11 @@ ifdef NO_SYMLINK_HEAD
 	BASIC_CFLAGS +=3D -DNO_SYMLINK_HEAD
 endif
 ifdef GETTEXT_POISON
-	LIB_OBJS +=3D gettext.o
 	BASIC_CFLAGS +=3D -DGETTEXT_POISON
 endif
+ifdef NO_GETTEXT
+	BASIC_CFLAGS +=3D -DNO_GETTEXT
+endif
 ifdef NO_STRCASESTR
 	COMPAT_CFLAGS +=3D -DNO_STRCASESTR
 	COMPAT_OBJS +=3D compat/strcasestr.o
@@ -1612,6 +1643,10 @@ ifdef HAVE_PATHS_H
 	BASIC_CFLAGS +=3D -DHAVE_PATHS_H
 endif
=20
+ifdef HAVE_LIBCHARSET_H
+	BASIC_CFLAGS +=3D -DHAVE_LIBCHARSET_H
+endif
+
 ifdef DIR_HAS_BSD_GROUP_SEMANTICS
 	COMPAT_CFLAGS +=3D -DDIR_HAS_BSD_GROUP_SEMANTICS
 endif
@@ -1632,6 +1667,10 @@ ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	export GIT_TEST_CMP_USE_COPIED_CONTEXT
 endif
=20
+ifndef NO_MSGFMT_CHECK
+	MSGFMT +=3D --check
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK=3DNoThanks
 endif
@@ -1662,6 +1701,7 @@ ifndef V
 	QUIET_GEN      =3D @echo '   ' GEN $@;
 	QUIET_LNCP     =3D @echo '   ' LN/CP $@;
 	QUIET_XGETTEXT =3D @echo '   ' XGETTEXT $@;
+	QUIET_MSGFMT   =3D @echo '   ' MSGFMT $@;
 	QUIET_GCOV     =3D @echo '   ' GCOV $@;
 	QUIET_SP       =3D @echo '   ' SP $<;
 	QUIET_SUBDIR0  =3D +@subdir=3D
@@ -1688,6 +1728,7 @@ bindir_SQ =3D $(subst ','\'',$(bindir))
 bindir_relative_SQ =3D $(subst ','\'',$(bindir_relative))
 mandir_SQ =3D $(subst ','\'',$(mandir))
 infodir_SQ =3D $(subst ','\'',$(infodir))
+localedir_SQ =3D $(subst ','\'',$(localedir))
 gitexecdir_SQ =3D $(subst ','\'',$(gitexecdir))
 template_dir_SQ =3D $(subst ','\'',$(template_dir))
 htmldir_SQ =3D $(subst ','\'',$(htmldir))
@@ -1743,7 +1784,7 @@ ifndef NO_TCLTK
 	$(QUIET_SUBDIR0)gitk-git $(QUIET_SUBDIR1) all
 endif
 ifndef NO_PERL
-	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH=3D'$(PERL_PATH_SQ)' p=
refix=3D'$(prefix_SQ)' all
+	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH=3D'$(PERL_PATH_SQ)' p=
refix=3D'$(prefix_SQ)' localedir=3D'$(localedir_SQ)' all
 endif
 ifndef NO_PYTHON
 	$(QUIET_SUBDIR0)git_remote_helpers $(QUIET_SUBDIR1) PYTHON_PATH=3D'$(=
PYTHON_PATH_SQ)' prefix=3D'$(prefix_SQ)' all
@@ -1793,6 +1834,7 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
     -e 's|@@DIFF@@|$(DIFF_SQ)|' \
     -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+    -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' \
     -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
     -e $(BROKEN_PATH_FIX) \
     $@.sh >$@+
@@ -2045,6 +2087,9 @@ config.sp config.s config.o: EXTRA_CPPFLAGS =3D \
 attr.sp attr.s attr.o: EXTRA_CPPFLAGS =3D \
 	-DETC_GITATTRIBUTES=3D'"$(ETC_GITATTRIBUTES_SQ)"'
=20
+gettext.s gettext.o: EXTRA_CPPFLAGS =3D \
+	-DGIT_LOCALE_PATH=3D'"$(localedir_SQ)"'
+
 http.sp http.s http.o: EXTRA_CPPFLAGS =3D \
 	-DGIT_HTTP_USER_AGENT=3D'"git/$(GIT_VERSION)"'
=20
@@ -2118,17 +2163,37 @@ XGETTEXT_FLAGS =3D \
 XGETTEXT_FLAGS_C =3D $(XGETTEXT_FLAGS) --language=3DC \
 	--keyword=3D_ --keyword=3DN_ --keyword=3D"Q_:1,2"
 XGETTEXT_FLAGS_SH =3D $(XGETTEXT_FLAGS) --language=3DShell
+XGETTEXT_FLAGS_PERL =3D $(XGETTEXT_FLAGS) --keyword=3D__ --language=3D=
Perl
 LOCALIZED_C :=3D $(C_OBJ:o=3Dc)
 LOCALIZED_SH :=3D $(SCRIPT_SH)
+LOCALIZED_PERL :=3D $(SCRIPT_PERL)
+
+ifdef XGETTEXT_INCLUDE_TESTS
+LOCALIZED_C +=3D t/t0200/test.c
+LOCALIZED_SH +=3D t/t0200/test.sh
+LOCALIZED_PERL +=3D t/t0200/test.perl
+endif
=20
 po/git.pot: $(LOCALIZED_C)
 	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
 	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_S=
H) \
 		$(LOCALIZED_SH)
+	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_P=
ERL) \
+		$(LOCALIZED_PERL)
 	mv $@+ $@
=20
 pot: po/git.pot
=20
+POFILES :=3D $(wildcard po/*.po)
+MOFILES :=3D $(patsubst po/%.po,share/locale/%/LC_MESSAGES/git.mo,$(PO=
=46ILES))
+
+ifndef NO_GETTEXT
+all:: $(MOFILES)
+endif
+
+share/locale/%/LC_MESSAGES/git.mo: po/%.po
+	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
+
 FIND_SOURCE_FILES =3D ( git ls-files '*.[hcS]' 2>/dev/null || \
 			$(FIND) . \( -name .git -type d -prune \) \
 				-o \( -name '*.[hcS]' -type f -print \) )
@@ -2147,7 +2212,8 @@ cscope:
=20
 ### Detect prefix changes
 TRACK_CFLAGS =3D $(CC):$(subst ','\'',$(ALL_CFLAGS)):\
-             $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix=
_SQ)
+             $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix=
_SQ):\
+             $(localedir_SQ)
=20
 GIT-CFLAGS: FORCE
 	@FLAGS=3D'$(TRACK_CFLAGS)'; \
@@ -2184,6 +2250,7 @@ endif
 ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=3DYesPlease >>$@
 endif
+	@echo NO_GETTEXT=3D\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\=
' >>$@
 	@echo GETTEXT_POISON=3D\''$(subst ','\'',$(subst ','\'',$(GETTEXT_POI=
SON)))'\' >>$@
=20
 ### Detect Tck/Tk interpreter path changes
@@ -2299,6 +2366,11 @@ install: all
 	$(MAKE) -C templates DESTDIR=3D'$(DESTDIR_SQ)' install
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
 	$(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)=
'
+ifndef NO_GETTEXT
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
+	(cd share/locale && $(TAR) cf - .) | \
+	(cd '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR) xof -)
+endif
 ifndef NO_PERL
 	$(MAKE) -C perl prefix=3D'$(prefix_SQ)' DESTDIR=3D'$(DESTDIR_SQ)' ins=
tall
 	$(MAKE) -C gitweb install
@@ -2435,6 +2507,7 @@ clean:
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) -r bin-wrappers
 	$(RM) -r $(dep_dirs)
+	$(RM) -r po/git.pot share/
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET=
) tags cscope*
 	$(RM) -r autom4te.cache
 	$(RM) config.log config.mak.autogen config.mak.append config.status c=
onfig.cache
diff --git a/config.mak.in b/config.mak.in
index ab37101..10698c8 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -35,6 +35,9 @@ NO_CURL=3D@NO_CURL@
 NO_EXPAT=3D@NO_EXPAT@
 NO_LIBGEN_H=3D@NO_LIBGEN_H@
 HAVE_PATHS_H=3D@HAVE_PATHS_H@
+HAVE_LIBCHARSET_H=3D@HAVE_LIBCHARSET_H@
+NO_GETTEXT=3D@NO_GETTEXT@
+LIBC_CONTAINS_LIBINTL=3D@LIBC_CONTAINS_LIBINTL@
 NEEDS_LIBICONV=3D@NEEDS_LIBICONV@
 NEEDS_SOCKET=3D@NEEDS_SOCKET@
 NEEDS_RESOLV=3D@NEEDS_RESOLV@
diff --git a/configure.ac b/configure.ac
index 048a1d4..630dbdd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -636,6 +636,12 @@ AC_CHECK_LIB([c], [basename],
 AC_SUBST(NEEDS_LIBGEN)
 test -n "$NEEDS_LIBGEN" && LIBS=3D"$LIBS -lgen"
=20
+AC_CHECK_LIB([c], [gettext],
+[LIBC_CONTAINS_LIBINTL=3DYesPlease],
+[LIBC_CONTAINS_LIBINTL=3D])
+AC_SUBST(LIBC_CONTAINS_LIBINTL)
+test -n "$LIBC_CONTAINS_LIBINTL" || LIBS=3D"$LIBS -lintl"
+
 ## Checks for header files.
 AC_MSG_NOTICE([CHECKS for header files])
 #
@@ -818,6 +824,19 @@ AC_CHECK_HEADER([paths.h],
 [HAVE_PATHS_H=3D])
 AC_SUBST(HAVE_PATHS_H)
 #
+# Define NO_GETTEXT if you don't want Git output to be translated.
+# A translated Git requires GNU libintl or another gettext implementat=
ion
+AC_CHECK_HEADER([libintl.h],
+[NO_GETTEXT=3D],
+[NO_GETTEXT=3DYesPlease])
+AC_SUBST(NO_GETTEXT)
+#
+# Define HAVE_LIBCHARSET_H if have libcharset.h
+AC_CHECK_HEADER([libcharset.h],
+[HAVE_LIBCHARSET_H=3DYesPlease],
+[HAVE_LIBCHARSET_H=3D])
+AC_SUBST(HAVE_LIBCHARSET_H)
+#
 # Define NO_STRCASESTR if you don't have strcasestr.
 GIT_CHECK_FUNC(strcasestr,
 [NO_STRCASESTR=3D],
diff --git a/daemon.c b/daemon.c
index fa28300..15ce918 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1099,6 +1099,8 @@ int main(int argc, char **argv)
 	struct credentials *cred =3D NULL;
 	int i;
=20
+	git_setup_gettext();
+
 	git_extract_argv0_path(argv[0]);
=20
 	for (i =3D 1; i < argc; i++) {
diff --git a/fast-import.c b/fast-import.c
index 8d8ea3c..b59e7db 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3292,6 +3292,8 @@ int main(int argc, const char **argv)
=20
 	git_extract_argv0_path(argv[0]);
=20
+	git_setup_gettext();
+
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage(fast_import_usage);
=20
diff --git a/gettext.c b/gettext.c
index ae5394a..d551cb2 100644
--- a/gettext.c
+++ b/gettext.c
@@ -5,6 +5,18 @@
 #include "git-compat-util.h"
 #include "gettext.h"
=20
+#ifndef NO_GETTEXT
+#	include <locale.h>
+#	include <libintl.h>
+#	ifdef HAVE_LIBCHARSET_H
+#		include <libcharset.h>
+#	else
+#		include <langinfo.h>
+#		define locale_charset() nl_langinfo(CODESET)
+#	endif
+#endif
+
+#ifdef GETTEXT_POISON
 int use_gettext_poison(void)
 {
 	static int poison_requested =3D -1;
@@ -12,3 +24,108 @@ int use_gettext_poison(void)
 		poison_requested =3D getenv("GIT_GETTEXT_POISON") ? 1 : 0;
 	return poison_requested;
 }
+#endif
+
+#ifndef NO_GETTEXT
+static void init_gettext_charset(const char *domain)
+{
+	const char *charset;
+
+	/*=20
+	   This trick arranges for messages to be emitted in the user's
+	   requested encoding, but avoids setting LC_CTYPE from the
+	   environment for the whole program.
+
+	   This primarily done to avoid a bug in vsnprintf in the GNU C
+	   Library [1]. which triggered a "your vsnprintf is broken" error
+	   on Git's own repository when inspecting v0.99.6~1 under a UTF-8
+	   locale.
+
+	   That commit contains a ISO-8859-1 encoded author name, which
+	   the locale aware vsnprintf(3) won't interpolate in the format
+	   argument, due to mismatch between the data encoding and the
+	   locale.
+
+	   Even if it wasn't for that bug we wouldn't want to use LC_CTYPE at
+	   this point, because it'd require auditing all the code that uses C
+	   functions whose semantics are modified by LC_CTYPE.
+
+	   But only setting LC_MESSAGES as we do creates a problem, since
+	   we declare the encoding of our PO files[2] the gettext
+	   implementation will try to recode it to the user's locale, but
+	   without LC_CTYPE it'll emit something like this on 'git init'
+	   under the Icelandic locale:
+
+	       Bj? til t?ma Git lind ? /hlagh/.git/
+
+	   Gettext knows about the encoding of our PO file, but we haven't
+	   told it about the user's encoding, so all the non-US-ASCII
+	   characters get encoded to question marks.
+
+	   But we're in luck! We can set LC_CTYPE from the environment
+	   only while we call nl_langinfo and
+	   bind_textdomain_codeset. That suffices to tell gettext what
+	   encoding it should emit in, so it'll now say:
+
+	       Bj=C3=B3 til t=C3=B3ma Git lind =C3=AD /hlagh/.git/
+
+	   And the equivalent ISO-8859-1 string will be emitted under a
+	   ISO-8859-1 locale.
+
+	   With this change way we get the advantages of setting LC_CTYPE
+	   (talk to the user in his language/encoding), without the major
+	   drawbacks (changed semantics for C functions we rely on).
+
+	   However foreign functions using other message catalogs that
+	   aren't using our neat trick will still have a problem, e.g. if
+	   we have to call perror(3):
+   =20
+    	   #include <stdio.h>
+    	   #include <locale.h>
+    	   #include <errno.h>
+   =20
+    	   int main(void)
+    	   {
+        	   setlocale(LC_MESSAGES, "");
+        	   setlocale(LC_CTYPE, "C");
+        	   errno =3D ENODEV;
+        	   perror("test");
+        	   return 0;
+    	   }
+   =20
+	   Running that will give you a message with question marks:
+
+    	   $ LANGUAGE=3D LANG=3Dde_DE.utf8 ./test
+    	   test: Kein passendes Ger?t gefunden
+
+	   In the long term we should probably see about getting that
+	   vsnprintf bug in glibc fixed, and audit our code so it won't
+	   fall apart under a non-C locale.
+
+	   Then we could simply set LC_CTYPE from the environment, which woul=
d
+	   make things like the external perror(3) messages work.
+
+	   See t/t0203-gettext-setlocale-sanity.sh's "gettext.c" tests for
+	   regression tests.
+
+	   1. http://sourceware.org/bugzilla/show_bug.cgi?id=3D6530
+	   2. E.g. "Content-Type: text/plain; charset=3DUTF-8\n" in po/is.po
+	*/
+	setlocale(LC_CTYPE, "");
+	charset =3D locale_charset();
+	bind_textdomain_codeset(domain, charset);
+	setlocale(LC_CTYPE, "C");
+}
+
+void git_setup_gettext(void)
+{
+	const char *podir =3D getenv("GIT_TEXTDOMAINDIR");
+
+	if (!podir)
+		podir =3D GIT_LOCALE_PATH;
+	bindtextdomain("git", podir);
+	setlocale(LC_MESSAGES, "");
+	init_gettext_charset("git");
+	textdomain("git");
+}
+#endif
diff --git a/gettext.h b/gettext.h
index 24d9182..57ba8bb 100644
--- a/gettext.h
+++ b/gettext.h
@@ -13,8 +13,29 @@
 #error "namespace conflict: '_' or 'Q_' is pre-defined?"
 #endif
=20
+#ifndef NO_GETTEXT
+#	include <libintl.h>
+#else
+#	ifdef gettext
+#		undef gettext
+#	endif
+#	define gettext(s) (s)
+#	ifdef ngettext
+#		undef ngettext
+#	endif
+#	define ngettext(s, p, n) ((n =3D=3D 1) ? (s) : (p))
+#endif
+
 #define FORMAT_PRESERVING(n) __attribute__((format_arg(n)))
=20
+#ifndef NO_GETTEXT
+extern void git_setup_gettext(void);
+#else
+static inline void git_setup_gettext(void)
+{
+}
+#endif
+
 #ifdef GETTEXT_POISON
 extern int use_gettext_poison(void);
 #else
@@ -23,7 +44,7 @@ extern int use_gettext_poison(void);
=20
 static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 {
-	return use_gettext_poison() ? "# GETTEXT POISON #" : msgid;
+	return use_gettext_poison() ? "# GETTEXT POISON #" : gettext(msgid);
 }
=20
 static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
@@ -31,7 +52,7 @@ const char *Q_(const char *msgid, const char *plu, un=
signed long n)
 {
 	if (use_gettext_poison())
 		return "# GETTEXT POISON #";
-	return n =3D=3D 1 ? msgid : plu;
+	return ngettext(msgid, plu, n);
 }
=20
 /* Mark msgid for translation but do not translate it. */
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index e672366..b4575fb 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -2,47 +2,91 @@
 #
 # Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
 #
-# This is a skeleton no-op implementation of gettext for Git. It'll be
-# replaced by something that uses gettext.sh in a future patch series.
+# This is Git's interface to gettext.sh. See po/README for usage
+# instructions.
+
+# Export the TEXTDOMAIN* data that we need for Git
+TEXTDOMAIN=3Dgit
+export TEXTDOMAIN
+if test -z "$GIT_TEXTDOMAINDIR"
+then
+	TEXTDOMAINDIR=3D"@@LOCALEDIR@@"
+else
+	TEXTDOMAINDIR=3D"$GIT_TEXTDOMAINDIR"
+fi
+export TEXTDOMAINDIR
=20
 if test -z "$GIT_GETTEXT_POISON"
 then
-	gettext () {
-		printf "%s" "$1"
-	}
+	if test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && type gettext.sh =
>/dev/null 2>&1
+	then
+		# This is GNU libintl's gettext.sh, we don't need to do anything
+		# else than setting up the environment and loading gettext.sh
+		GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dgnu
+		export GIT_INTERNAL_GETTEXT_SH_SCHEME
=20
-	gettextln() {
-		printf "%s\n" "$1"
-	}
+		# Try to use libintl's gettext.sh, or fall back to English if we
+		# can't.
+		. gettext.sh
=20
-	eval_gettext () {
-		printf "%s" "$1" | (
-			export PATH $(git sh-i18n--envsubst --variables "$1");
-			git sh-i18n--envsubst "$1"
-		)
-	}
+	elif test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && test "$(gettex=
t -h 2>&1)" =3D "-h"
+	then
+		# We don't have gettext.sh, but there's a gettext binary in our
+		# path. This is probably Solaris or something like it which has a
+		# gettext implementation that isn't GNU libintl.
+		GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dsolaris
+		export GIT_INTERNAL_GETTEXT_SH_SCHEME
=20
-	eval_gettextln () {
-		printf "%s\n" "$1" | (
-			export PATH $(git sh-i18n--envsubst --variables "$1");
-			git sh-i18n--envsubst "$1"
-		)
-	}
+		# Solaris has a gettext(1) but no eval_gettext(1)
+		eval_gettext () {
+			gettext "$1" | (
+				export PATH $(git sh-i18n--envsubst --variables "$1");
+				git sh-i18n--envsubst "$1"
+			)
+		}
+
+	else
+		# Since gettext.sh isn't available we'll have to define our own
+		# dummy pass-through functions.
+
+		# Tell our tests that we don't have the real gettext.sh
+		GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dfallthrough
+		export GIT_INTERNAL_GETTEXT_SH_SCHEME
+
+		gettext () {
+			printf "%s" "$1"
+		}
+
+		eval_gettext () {
+			printf "%s" "$1" | (
+				export PATH $(git sh-i18n--envsubst --variables "$1");
+				git sh-i18n--envsubst "$1"
+			)
+		}
+	fi
 else
+	# Emit garbage under GETTEXT_POISON=3DYesPlease. Unlike the C tests
+	# this relies on an environment variable
+
+	GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dpoison
+	export GIT_INTERNAL_GETTEXT_SH_SCHEME
+
 	gettext () {
 		printf "%s" "# GETTEXT POISON #"
 	}
=20
-	gettextln () {
-		printf "%s\n" "# GETTEXT POISON #"
-	}
-
 	eval_gettext () {
 		printf "%s" "# GETTEXT POISON #"
 	}
-
-	eval_gettextln () {
-		printf "%s\n" "# GETTEXT POISON #"
-	}
 fi
=20
+# Git-specific wrapper functions
+gettextln () {
+	gettext "$1"
+	echo
+}
+
+eval_gettextln () {
+	eval_gettext "$1"
+	echo
+}
diff --git a/git.c b/git.c
index 8e34903..fa918b5 100644
--- a/git.c
+++ b/git.c
@@ -537,6 +537,8 @@ int main(int argc, const char **argv)
 	if (!cmd)
 		cmd =3D "git-help";
=20
+	git_setup_gettext();
+
 	/*
 	 * "git-xxxx" is the same as "git xxxx", but we obviously:
 	 *
diff --git a/http-backend.c b/http-backend.c
index 59ad7da..869d515 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -545,6 +545,8 @@ int main(int argc, char **argv)
 	char *cmd_arg =3D NULL;
 	int i;
=20
+	git_setup_gettext();
+
 	git_extract_argv0_path(argv[0]);
 	set_die_routine(die_webcgi);
=20
diff --git a/http-fetch.c b/http-fetch.c
index 69299b7..9719d58 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -22,6 +22,8 @@ int main(int argc, const char **argv)
 	int get_verbosely =3D 0;
 	int get_recover =3D 0;
=20
+	git_setup_gettext();
+
 	git_extract_argv0_path(argv[0]);
=20
 	while (arg < argc && argv[arg][0] =3D=3D '-') {
diff --git a/http-push.c b/http-push.c
index edd553b..f856299 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1748,6 +1748,8 @@ int main(int argc, char **argv)
 	int new_refs;
 	struct ref *ref, *local_refs;
=20
+	git_setup_gettext();
+
 	git_extract_argv0_path(argv[0]);
=20
 	repo =3D xcalloc(sizeof(*repo), 1);
diff --git a/imap-send.c b/imap-send.c
index e1ad1a4..9fba422 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1539,6 +1539,8 @@ int main(int argc, char **argv)
=20
 	git_extract_argv0_path(argv[0]);
=20
+	git_setup_gettext();
+
 	if (argc !=3D 1)
 		usage(imap_send_usage);
=20
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
new file mode 100644
index 0000000..07597dc
--- /dev/null
+++ b/perl/Git/I18N.pm
@@ -0,0 +1,89 @@
+package Git::I18N;
+use 5.008;
+use strict;
+use warnings;
+use Exporter 'import';
+
+our @EXPORT =3D qw(__);
+our @EXPORT_OK =3D @EXPORT;
+
+sub __bootstrap_locale_messages {
+	our $TEXTDOMAIN =3D 'git';
+	our $TEXTDOMAINDIR =3D $ENV{GIT_TEXTDOMAINDIR} || '++LOCALEDIR++';
+
+	require POSIX;
+	POSIX->import(qw(setlocale));
+	# Non-core prerequisite module
+	require Locale::Messages;
+	Locale::Messages->import(qw(:locale_h :libintl_h));
+
+	setlocale(LC_MESSAGES(), '');
+	setlocale(LC_CTYPE(), '');
+	textdomain($TEXTDOMAIN);
+	bindtextdomain($TEXTDOMAIN =3D> $TEXTDOMAINDIR);
+
+	return;
+}
+
+BEGIN
+{
+	# Used by our test script to see if it should test fallbacks or
+	# not.
+	our $__HAS_LIBRARY =3D 1;
+
+	local $@;
+	eval {
+		__bootstrap_locale_messages();
+		*__ =3D \&Locale::Messages::gettext;
+		1;
+	} or do {
+		# Tell test.pl that we couldn't load the gettext library.
+		$Git::I18N::__HAS_LIBRARY =3D 0;
+
+		# Just a fall-through no-op
+		*__ =3D sub ($) { $_[0] };
+	};
+}
+
+1;
+
+__END__
+
+=3Dhead1 NAME
+
+Git::I18N - Perl interface to Git's Gettext localizations
+
+=3Dhead1 SYNOPSIS
+
+	use Git::I18N;
+
+	print __("Welcome to Git!\n");
+
+	printf __("The following error occured: %s\n"), $error;
+
+=3Dhead1 DESCRIPTION
+
+Git's internal Perl interface to gettext via L<Locale::Messages>. If
+L<Locale::Messages> can't be loaded (it's not a core module) we
+provide stub passthrough fallbacks.
+
+This is a distilled interface to gettext, see C<info '(gettext)Perl'>
+for the full interface. This module implements only a small part of
+it.
+
+=3Dhead1 FUNCTIONS
+
+=3Dhead2 __($)
+
+L<Locale::Messages>'s gettext function if all goes well, otherwise our
+passthrough fallback function.
+
+=3Dhead1 AUTHOR
+
+E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason <avarab@gmail.com>
+
+=3Dhead1 COPYRIGHT
+
+Copyright 2010 E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason <avarab@gmail=
=2Ecom>
+
+=3Dcut
diff --git a/perl/Makefile b/perl/Makefile
index a2ffb64..b2977cd 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -5,6 +5,7 @@ makfile:=3Dperl.mak
=20
 PERL_PATH_SQ =3D $(subst ','\'',$(PERL_PATH))
 prefix_SQ =3D $(subst ','\'',$(prefix))
+localedir_SQ =3D $(subst ','\'',$(localedir))
=20
 ifndef V
 	QUIET =3D @
@@ -38,7 +39,7 @@ $(makfile): ../GIT-CFLAGS Makefile
 	echo '	echo $(instdir_SQ)' >> $@
 else
 $(makfile): Makefile.PL ../GIT-CFLAGS
-	$(PERL_PATH) $< PREFIX=3D'$(prefix_SQ)' INSTALL_BASE=3D''
+	$(PERL_PATH) $< PREFIX=3D'$(prefix_SQ)' INSTALL_BASE=3D'' --localedir=
=3D'$(localedir_SQ)'
 endif
=20
 # this is just added comfort for calling make directly in perl dir
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 0b9deca..456d45b 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -1,4 +1,12 @@
+use strict;
+use warnings;
 use ExtUtils::MakeMaker;
+use Getopt::Long;
+
+# Sanity: die at first unknown option
+Getopt::Long::Configure qw/ pass_through /;
+
+GetOptions("localedir=3Ds" =3D> \my $localedir);
=20
 sub MY::postamble {
 	return <<'MAKE_FRAG';
@@ -16,7 +24,10 @@ endif
 MAKE_FRAG
 }
=20
-my %pm =3D ('Git.pm' =3D> '$(INST_LIBDIR)/Git.pm');
+my %pm =3D (
+	'Git.pm' =3D> '$(INST_LIBDIR)/Git.pm',
+	'Git/I18N.pm' =3D> '$(INST_LIBDIR)/Git/I18N.pm',
+);
=20
 # We come with our own bundled Error.pm. It's not in the set of defaul=
t
 # Perl modules so install it if it's not available on the system yet.
@@ -33,6 +44,7 @@ WriteMakefile(
 	NAME            =3D> 'Git',
 	VERSION_FROM    =3D> 'Git.pm',
 	PM		=3D> \%pm,
+	PM_FILTER	=3D> qq[\$(PERL) -pe "s<\\Q++LOCALEDIR++\\E><$localedir>"],
 	MAKEFILE	=3D> 'perl.mak',
 	INSTALLSITEMAN3DIR =3D> '$(SITEPREFIX)/share/man/man3'
 );
diff --git a/po/README b/po/README
new file mode 100644
index 0000000..f601059
--- /dev/null
+++ b/po/README
@@ -0,0 +1,229 @@
+Core GIT Translations
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This directory holds the translations for the core of Git. This
+document describes how to add to and maintain these translations, and
+how to mark source strings for translation.
+
+
+Generating a .pot file
+----------------------
+
+The po/git.pot file contains a message catalog extracted from Git's
+sources. You need to generate it to add new translations with
+msginit(1), or update existing ones with msgmerge(1).
+
+Since the file can be automatically generated it's not checked into
+git.git. To generate it do, at the top-level:
+
+    make pot
+
+
+Initializing a .po file
+-----------------------
+
+To add a new translation first generate git.pot (see above) and then
+in the po/ directory do:
+
+    msginit --locale=3DXX
+
+Where XX is your locale, e.g. "is", "de" or "pt_BR".
+
+Then edit the automatically generated copyright info in your new XX.po
+to be correct, e.g. for Icelandic:
+   =20
+    @@ -1,6 +1,6 @@
+    -# Icelandic translations for PACKAGE package.
+    -# Copyright (C) 2010 THE PACKAGE'S COPYRIGHT HOLDER
+    -# This file is distributed under the same license as the PACKAGE =
package.
+    +# Icelandic translations for Git.
+    +# Copyright (C) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com>
+    +# This file is distributed under the same license as the Git pack=
age.
+     # =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>, 2010=
=2E
+
+And change references to PACKAGE VERSION in the PO Header Entry to
+just "Git":
+
+    perl -pi -e 's/(?<=3D"Project-Id-Version: )PACKAGE VERSION/Git/' X=
X.po
+
+
+Updating a .po file
+-------------------
+
+If there's an existing *.po file for your language but you need to
+update the translation you first need to generate git.pot (see above)
+and then in the po/ directory do:
+
+    msgmerge --add-location --backup=3Doff -U XX.po git.pot
+
+Where XX.po is the file you want to update.
+
+Testing your changes
+--------------------
+
+Before you submit your changes go back to the top-level and do:
+
+    make
+
+On systems with GNU gettext (i.e. not Solaris) this will compile your
+changed PO file with `msgfmt --check`, the --check option flags many
+common errors, e.g. missing printf format strings, or translated
+messages that deviate from the originals in whether they begin/end
+with a newline or not.
+
+
+Marking strings for translation
+-------------------------------
+
+Before strings can be translated they first have to be marked for
+translation.
+
+Git uses an internationalization interface that wraps the system's
+gettext library, so most of the advice in your gettext documentation
+(on GNU systems `info gettext` in a terminal) applies.
+
+General advice:
+
+ - Don't mark everything for translation, only strings which will be
+   read by humans (the porcelain interface) should be translated.
+
+   The output from Git's plumbing utilities will primarily be read by
+   programs and would break scripts under non-C locales if it was
+   translated. Plumbing strings should not be translated, since
+   they're part of Git's API.
+
+ - Adjust the strings so that they're easy to translate. Most of the
+   advice in `info '(gettext)Preparing Strings'` applies here.
+
+ - If something is unclear or ambiguous you can use a "TRANSLATORS"
+   comment to tell the translators what to make of it. These will be
+   extracted by xgettext(1) and put in the po/*.po files, e.g. from
+   git-am.sh:
+
+       # TRANSLATORS: Make sure to include [y], [n], [e], [v] and [a]
+       # in your translation. The program will only accept English
+       # input at this point.
+       gettext "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
+
+   Or in C, from builtin/revert.c:
+
+       /* TRANSLATORS: %s will be "revert" or "cherry-pick" */
+       die(_("%s: Unable to write new index file"), action_name(opts))=
;
+
+We provide wrappers for C, Shell and Perl programs. Here's how they're
+used:
+
+C:
+
+ - Include builtin.h at the top, it'll pull in in gettext.h, which
+   defines the gettext interface. Consult with the list if you need to
+   use gettext.h directly.
+
+ - The C interface is a subset of the normal GNU gettext
+   interface. We currently export these functions:
+
+   - _()
+
+    Mark and translate a string. E.g.:
+
+        printf(_("HEAD is now at %s"), hex);
+
+   - Q_()
+
+    Mark and translate a plural string. E.g.:
+
+        printf(Q_("%d commit", "%d commits", number_of_commits));
+
+    This is just a wrapper for the ngettext() function.
+
+   - N_()
+
+    A no-op pass-through macro for marking strings inside static
+    initializations, e.g.:
+
+        static const char *reset_type_names[] =3D {
+            N_("mixed"), N_("soft"), N_("hard"), N_("merge"), N_("keep=
"), NULL
+        };
+
+    And then, later:
+
+        die(_("%s reset is not allowed in a bare repository"),
+               _(reset_type_names[reset_type]));
+
+    Here _() couldn't have statically determined what the translation
+    string will be, but since it was already marked for translation
+    with N_() the look-up in the message catalog will succeed.
+
+Shell:
+
+ - The Git gettext shell interface is just a wrapper for
+   gettext.sh. Import it right after git-sh-setup like this:
+
+       . git-sh-setup
+       . git-sh-i18n
+
+   And then use the gettext or eval_gettext functions:
+
+       # For constant interface messages:
+       gettext "A message for the user"; echo
+
+       # To interpolate variables:
+       details=3D"oh noes"
+       eval_gettext "An error occured: \$details"; echo
+
+   In addition we have wrappers for messages that end with a trailing
+   newline. I.e. you could write the above as:
+
+       # For constant interface messages:
+       gettextln "A message for the user"
+
+       # To interpolate variables:
+       details=3D"oh noes"
+       eval_gettextln "An error occured: \$details"
+
+   More documentation about the interface is available in the GNU info
+   page: `info '(gettext)sh'`. Looking at git-am.sh (the first shell
+   command to be translated) for examples is also useful:
+
+       git log --reverse -p --grep=3Di18n git-am.sh
+
+Perl:
+
+ - The Git::I18N module provides a limited subset of the
+   Locale::Messages functionality, e.g.:
+
+       use Git::I18N;
+       print __("Welcome to Git!\n");
+       printf __("The following error occured: %s\n"), $error;
+
+   Run `perldoc perl/Git/I18N.pm` for more info.
+
+
+Testing marked strings
+----------------------
+
+Even if you've correctly marked porcelain strings for translation
+something in the test suite might still depend on the US English
+version of the strings, e.g. to grep some error message or other
+output.
+
+To smoke out issues like these Git can be compiled with gettext poison
+support, at the top-level:
+
+    make GETTEXT_POISON=3DYesPlease
+
+That'll give you a git which emits gibberish on every call to
+gettext. It's obviously not meant to be installed, but you should run
+the test suite with it:
+
+    cd t && prove -j 9 ./t[0-9]*.sh
+
+If tests break with it you should inspect them manually and see if
+what you're translating is sane, i.e. that you're not translating
+plumbing output.
+
+If not you should replace calls to grep with test_i18ngrep, or
+test_cmp calls with test_i18ncmp. If that's not enough you can skip
+the whole test by making it depend on the C_LOCALE_OUTPUT
+prerequisite. See existing test files with this prerequisite for
+examples.
diff --git a/po/is.po b/po/is.po
new file mode 100644
index 0000000..8692a8b
--- /dev/null
+++ b/po/is.po
@@ -0,0 +1,93 @@
+# Icelandic translations for Git.
+# Copyright (C) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
+# This file is distributed under the same license as the Git package.
+# =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>, 2010.
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: Git\n"
+"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
+"POT-Creation-Date: 2010-09-20 14:44+0000\n"
+"PO-Revision-Date: 2010-06-05 19:06 +0000\n"
+"Last-Translator: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
=2Ecom>\n"
+"Language-Team: Git Mailing List <git@vger.kernel.org>\n"
+"Language: is\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:5
+msgid "See 'git help COMMAND' for more information on a specific comma=
nd."
+msgstr "Sj=C3=A1 'git help SKIPUN' til a=C3=B0 sj=C3=A1 hj=C3=A1lp fyr=
ir tiltekna skipun."
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:10
+msgid "TEST: A C test string"
+msgstr "TILRAUN: C tilraunastrengur"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:13
+#, c-format
+msgid "TEST: A C test string %s"
+msgstr "TILRAUN: C tilraunastrengur %s"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:16
+#, c-format
+msgid "TEST: Hello World!"
+msgstr "TILRAUN: Hall=C3=B3 Heimur!"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:19
+#, c-format
+msgid "TEST: Old English Runes"
+msgstr "TILRAUN: =E1=9A=BB=E1=9B=96 =E1=9A=B3=E1=9A=B9=E1=9A=AB=E1=9A=A6=
 =E1=9A=A6=E1=9A=AB=E1=9B=8F =E1=9A=BB=E1=9B=96 =E1=9B=92=E1=9A=A2=E1=9B=
=9E=E1=9B=96 =E1=9A=A9=E1=9A=BE =E1=9A=A6=E1=9A=AB=E1=9B=97 =E1=9B=9A=E1=
=9A=AA=E1=9A=BE=E1=9B=9E=E1=9B=96 =E1=9A=BE=E1=9A=A9=E1=9A=B1=E1=9A=A6=E1=
=9A=B9=E1=9B=96=E1=9A=AA=E1=9A=B1=E1=9B=9E=E1=9A=A2=E1=9B=97 =E1=9A=B9=E1=
=9B=81=E1=9A=A6 =E1=9A=A6=E1=9A=AA =E1=9A=B9=E1=9B=96=E1=9B=A5=E1=9A=AB=
"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:22
+#, c-format
+msgid "TEST: =E2=80=98single=E2=80=99 and =E2=80=9Cdouble=E2=80=9D quo=
tes"
+msgstr "TILRAUN: =E2=80=9Aeinfaldar=E2=80=98 og =E2=80=9Etv=C3=B6falda=
r=E2=80=9C g=C3=A6salappir"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.sh:8
+msgid "TEST: A Shell test string"
+msgstr "TILRAUN: Skeljartilraunastrengur"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.sh:11
+#, sh-format
+msgid "TEST: A Shell test $variable"
+msgstr "TILRAUN: Skeljartilraunastrengur me=C3=B0 breytunni $variable"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.perl:8
+msgid "TEST: A Perl test string"
+msgstr "TILRAUN: Perl tilraunastrengur"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.perl:11
+#, perl-format
+msgid "TEST: A Perl test variable %s"
+msgstr "TILRAUN: Perl tilraunastrengur me=C3=B0 breytunni %s"
+
+#. TRANSLATORS: The first '%s' is either "Reinitialized
+#. existing" or "Initialized empty", the second " shared" or
+#. "", and the last '%s%s' is the verbatim directory name.
+#: builtin/init-db.c:355
+#, c-format
+msgid "%s%s Git repository in %s%s\n"
+msgstr "%s%s Git lind =C3=AD %s%s\n"
+
+#: builtin/init-db.c:356
+msgid "Reinitialized existing"
+msgstr "Endurger=C3=B0i"
+
+#: builtin/init-db.c:356
+msgid "Initialized empty"
+msgstr "Bj=C3=B3 til t=C3=B3ma"
+
+#: builtin/init-db.c:357
+msgid " shared"
+msgstr " sameiginlega"
diff --git a/shell.c b/shell.c
index abb8622..84b237f 100644
--- a/shell.c
+++ b/shell.c
@@ -137,6 +137,8 @@ int main(int argc, char **argv)
 	int devnull_fd;
 	int count;
=20
+	git_setup_gettext();
+
 	git_extract_argv0_path(argv[0]);
=20
 	/*
diff --git a/show-index.c b/show-index.c
index 63f9da5..5a9eed7 100644
--- a/show-index.c
+++ b/show-index.c
@@ -11,6 +11,8 @@ int main(int argc, char **argv)
 	unsigned int version;
 	static unsigned int top_index[256];
=20
+	git_setup_gettext();
+
 	if (argc !=3D 1)
 		usage(show_index_usage);
 	if (fread(top_index, 2 * 4, 1, stdin) !=3D 1)
diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
new file mode 100644
index 0000000..a54a9f8
--- /dev/null
+++ b/t/lib-gettext.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+#
+
+. ./test-lib.sh
+
+GIT_TEXTDOMAINDIR=3D"$GIT_BUILD_DIR/share/locale"
+GIT_PO_PATH=3D"$GIT_BUILD_DIR/po"
+export GIT_TEXTDOMAINDIR GIT_PO_PATH
+
+. "$GIT_BUILD_DIR"/git-sh-i18n
+
+if test_have_prereq GETTEXT && ! test_have_prereq GETTEXT_POISON
+then
+	# is_IS.UTF-8 on Solaris and FreeBSD, is_IS.utf8 on Debian
+	is_IS_locale=3D$(locale -a | sed -n '/^is_IS\.[uU][tT][fF]-*8$/{
+		p
+		q
+	}')
+	# is_IS.ISO8859-1 on Solaris and FreeBSD, is_IS.iso88591 on Debian
+	is_IS_iso_locale=3D$(locale -a | sed -n '/^is_IS\.[iI][sS][oO]8859-*1=
$/{
+		p
+		q
+	}')
+
+	# Export them as an environment variable so the t0202/test.pl Perl
+	# test can use it too
+	export is_IS_locale is_IS_iso_locale
+
+	if test -n "$is_IS_locale" &&
+		test $GIT_INTERNAL_GETTEXT_SH_SCHEME !=3D "fallthrough"
+	then
+		# Some of the tests need the reference Icelandic locale
+		test_set_prereq GETTEXT_LOCALE
+
+		# Exporting for t0202/test.pl
+		GETTEXT_LOCALE=3D1
+		export GETTEXT_LOCALE
+		say "# lib-gettext: Found '$is_IS_locale' as an is_IS UTF-8 locale"
+	else
+		say "# lib-gettext: No is_IS UTF-8 locale available"
+	fi
+
+	if test -n "$is_IS_iso_locale" &&
+		test $GIT_INTERNAL_GETTEXT_SH_SCHEME !=3D "fallthrough"
+	then
+		# Some of the tests need the reference Icelandic locale
+		test_set_prereq GETTEXT_ISO_LOCALE
+
+		say "# lib-gettext: Found '$is_IS_iso_locale' as an is_IS ISO-8859-1=
 locale"
+	else
+		say "# lib-gettext: No is_IS ISO-8859-1 locale available"
+	fi
+fi
diff --git a/t/t0200-gettext-basic.sh b/t/t0200-gettext-basic.sh
new file mode 100755
index 0000000..8853d8a
--- /dev/null
+++ b/t/t0200-gettext-basic.sh
@@ -0,0 +1,108 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+#
+
+test_description=3D'Gettext support for Git'
+
+. ./lib-gettext.sh
+
+test_expect_success "sanity: \$GIT_INTERNAL_GETTEXT_SH_SCHEME is set (=
to $GIT_INTERNAL_GETTEXT_SH_SCHEME)" '
+    test -n "$GIT_INTERNAL_GETTEXT_SH_SCHEME"
+'
+
+test_expect_success 'sanity: $TEXTDOMAIN is git' '
+    test $TEXTDOMAIN =3D "git"
+'
+
+test_expect_success 'xgettext sanity: Perl _() strings are not extract=
ed' '
+    ! grep "A Perl string xgettext will not get" "$GIT_PO_PATH"/is.po
+'
+
+test_expect_success 'xgettext sanity: Comment extraction with --add-co=
mments' '
+    grep "TRANSLATORS: This is a test" "$TEST_DIRECTORY"/t0200/* | wc =
-l >expect &&
+    grep "TRANSLATORS: This is a test" "$GIT_PO_PATH"/is.po  | wc -l >=
actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'xgettext sanity: Comment extraction with --add-co=
mments stops at statements' '
+    ! grep "This is a phony" "$GIT_PO_PATH"/is.po &&
+    ! grep "the above comment" "$GIT_PO_PATH"/is.po
+'
+
+test_expect_success GETTEXT 'sanity: $TEXTDOMAINDIR exists without NO_=
GETTEXT=3DYesPlease' '
+    test -d "$TEXTDOMAINDIR" &&
+    test "$TEXTDOMAINDIR" =3D "$GIT_TEXTDOMAINDIR"
+'
+
+test_expect_success GETTEXT 'sanity: Icelandic locale was compiled' '
+    test -f "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
+'
+
+# TODO: When we have more locales, generalize this to test them
+# all. Maybe we'll need a dir->locale map for that.
+test_expect_success GETTEXT_LOCALE 'sanity: gettext("") metadata is OK=
' '
+    # Return value may be non-zero
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "" >zero-expect &&
+    grep "Project-Id-Version: Git" zero-expect &&
+    grep "Git Mailing List <git@vger.kernel.org>" zero-expect &&
+    grep "Content-Type: text/plain; charset=3DUTF-8" zero-expect &&
+    grep "Content-Transfer-Encoding: 8bit" zero-expect
+'
+
+test_expect_success GETTEXT_LOCALE 'sanity: gettext(unknown) is passed=
 through' '
+    printf "This is not a translation string"  >expect &&
+    gettext "This is not a translation string" >actual &&
+    eval_gettext "This is not a translation string" >actual &&
+    test_cmp expect actual
+'
+
+# xgettext from C
+test_expect_success GETTEXT_LOCALE 'xgettext: C extraction of _() and =
N_() strings' '
+    printf "TILRAUN: C tilraunastrengur" >expect &&
+    printf "\n" >>expect &&
+    printf "Sj=C3=A1 '\''git help SKIPUN'\'' til a=C3=B0 sj=C3=A1 hj=C3=
=A1lp fyrir tiltekna skipun." >>expect &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "TEST: A C test str=
ing" >actual &&
+    printf "\n" >>actual &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "See '\''git help C=
OMMAND'\'' for more information on a specific command." >>actual &&
+    test_cmp expect actual
+'
+
+test_expect_success GETTEXT_LOCALE 'xgettext: C extraction with %s' '
+    printf "TILRAUN: C tilraunastrengur %%s" >expect &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "TEST: A C test str=
ing %s" >actual &&
+    test_cmp expect actual
+'
+
+# xgettext from Shell
+test_expect_success GETTEXT_LOCALE 'xgettext: Shell extraction' '
+    printf "TILRAUN: Skeljartilraunastrengur" >expect &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "TEST: A Shell test=
 string" >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success GETTEXT_LOCALE 'xgettext: Shell extraction with $v=
ariable' '
+    printf "TILRAUN: Skeljartilraunastrengur me=C3=B0 breytunni a var =
i able" >x-expect &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" variable=3D"a var i able" e=
val_gettext "TEST: A Shell test \$variable" >x-actual &&
+    test_cmp x-expect x-actual
+'
+
+# xgettext from Perl
+test_expect_success GETTEXT_LOCALE 'xgettext: Perl extraction' '
+    printf "TILRAUN: Perl tilraunastrengur" >expect &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "TEST: A Perl test =
string" >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success GETTEXT_LOCALE 'xgettext: Perl extraction with %s'=
 '
+    printf "TILRAUN: Perl tilraunastrengur me=C3=B0 breytunni %%s" >ex=
pect &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "TEST: A Perl test =
variable %s" >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success GETTEXT_LOCALE 'sanity: Some gettext("") data for =
real locale' '
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "" >real-locale &&
+    test -s real-locale
+'
+
+test_done
diff --git a/t/t0200/test.c b/t/t0200/test.c
new file mode 100644
index 0000000..584d45c
--- /dev/null
+++ b/t/t0200/test.c
@@ -0,0 +1,23 @@
+/* This is a phony C program that's only here to test xgettext message=
 extraction */
+
+const char help[] =3D
+	/* TRANSLATORS: This is a test. You don't need to translate it. */
+	N_("See 'git help COMMAND' for more information on a specific command=
=2E");
+
+int main(void)
+{
+	/* TRANSLATORS: This is a test. You don't need to translate it. */
+	puts(_("TEST: A C test string"));
+
+	/* TRANSLATORS: This is a test. You don't need to translate it. */
+	printf(_("TEST: A C test string %s"), "variable");
+
+	/* TRANSLATORS: This is a test. You don't need to translate it. */
+	printf(_("TEST: Hello World!"));
+
+	/* TRANSLATORS: This is a test. You don't need to translate it. */
+	printf(_("TEST: Old English Runes"));
+
+	/* TRANSLATORS: This is a test. You don't need to translate it. */
+	printf(_("TEST: =E2=80=98single=E2=80=99 and =E2=80=9Cdouble=E2=80=9D=
 quotes"));
+}
diff --git a/t/t0200/test.perl b/t/t0200/test.perl
new file mode 100644
index 0000000..36fba34
--- /dev/null
+++ b/t/t0200/test.perl
@@ -0,0 +1,14 @@
+# This is a phony Perl program that's only here to test xgettext
+# message extraction
+
+# so the above comment won't be folded into the next one by xgettext
+1;
+
+# TRANSLATORS: This is a test. You don't need to translate it.
+print __("TEST: A Perl test string");
+
+# TRANSLATORS: This is a test. You don't need to translate it.
+printf __("TEST: A Perl test variable %s"), "moo";
+
+# TRANSLATORS: If you see this, Git has a bug
+print _"TEST: A Perl string xgettext will not get";
diff --git a/t/t0200/test.sh b/t/t0200/test.sh
new file mode 100644
index 0000000..022d607
--- /dev/null
+++ b/t/t0200/test.sh
@@ -0,0 +1,14 @@
+# This is a phony Shell program that's only here to test xgettext
+# message extraction
+
+# so the above comment won't be folded into the next one by xgettext
+echo
+
+# TRANSLATORS: This is a test. You don't need to translate it.
+gettext "TEST: A Shell test string"
+
+# TRANSLATORS: This is a test. You don't need to translate it.
+eval_gettext "TEST: A Shell test \$variable"
+
+# TRANSLATORS: If you see this, Git has a bug
+_("TEST: A Shell string xgettext won't get")
diff --git a/t/t0201-gettext-fallbacks.sh b/t/t0201-gettext-fallbacks.s=
h
index 54d98b9..52b1c27 100755
--- a/t/t0201-gettext-fallbacks.sh
+++ b/t/t0201-gettext-fallbacks.sh
@@ -5,8 +5,24 @@
=20
 test_description=3D'Gettext Shell fallbacks'
=20
-. ./test-lib.sh
-. "$GIT_BUILD_DIR"/git-sh-i18n
+GIT_INTERNAL_GETTEXT_TEST_FALLBACKS=3DYesPlease
+export GIT_INTERNAL_GETTEXT_TEST_FALLBACKS
+
+. ./lib-gettext.sh
+
+test_expect_success "sanity: \$GIT_INTERNAL_GETTEXT_SH_SCHEME is set (=
to $GIT_INTERNAL_GETTEXT_SH_SCHEME)" '
+    test -n "$GIT_INTERNAL_GETTEXT_SH_SCHEME"
+'
+
+test_expect_success 'sanity: $GIT_INTERNAL_GETTEXT_TEST_FALLBACKS is s=
et' '
+    test -n "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
+'
+
+test_expect_success C_LOCALE_OUTPUT 'sanity: $GIT_INTERNAL_GETTEXT_SH_=
SCHEME" is fallthrough' '
+    echo fallthrough >expect &&
+    echo $GIT_INTERNAL_GETTEXT_SH_SCHEME >actual &&
+    test_cmp expect actual
+'
=20
 test_expect_success 'gettext: our gettext() fallback has pass-through =
semantics' '
     printf "test" >expect &&
diff --git a/t/t0202-gettext-perl.sh b/t/t0202-gettext-perl.sh
new file mode 100755
index 0000000..428ebb0
--- /dev/null
+++ b/t/t0202-gettext-perl.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+#
+
+test_description=3D'Perl gettext interface (Git::I18N)'
+
+. ./lib-gettext.sh
+
+if ! test_have_prereq PERL; then
+	skip_all=3D'skipping perl interface tests, perl not available'
+	test_done
+fi
+
+"$PERL_PATH" -MTest::More -e 0 2>/dev/null || {
+	skip_all=3D"Perl Test::More unavailable, skipping test"
+	test_done
+}
+
+# The external test will outputs its own plan
+test_external_has_tap=3D1
+
+test_external_without_stderr \
+    'Perl Git::I18N API' \
+    "$PERL_PATH" "$TEST_DIRECTORY"/t0202/test.pl
+
+test_done
diff --git a/t/t0202/test.pl b/t/t0202/test.pl
new file mode 100644
index 0000000..2c10cb4
--- /dev/null
+++ b/t/t0202/test.pl
@@ -0,0 +1,110 @@
+#!/usr/bin/perl
+use 5.008;
+use lib (split(/:/, $ENV{GITPERLLIB}));
+use strict;
+use warnings;
+use POSIX qw(:locale_h);
+use Test::More tests =3D> 8;
+use Git::I18N;
+
+my $has_gettext_library =3D $Git::I18N::__HAS_LIBRARY;
+
+ok(1, "Testing Git::I18N with " .
+	 ($has_gettext_library
+	  ? (defined $Locale::Messages::VERSION
+		 ? "Locale::Messages version $Locale::Messages::VERSION"
+		 # Versions of Locale::Messages before 1.17 didn't have a
+		 # $VERSION variable.
+		 : "Locale::Messages version <1.17")
+	  : "NO Perl gettext library"));
+ok(1, "Git::I18N is located at $INC{'Git/I18N.pm'}");
+
+{
+	my $exports =3D @Git::I18N::EXPORT;
+	ok($exports, "sanity: Git::I18N has $exports export(s)");
+}
+is_deeply(\@Git::I18N::EXPORT, \@Git::I18N::EXPORT_OK, "sanity: Git::I=
18N exports everything by default");
+
+# prototypes
+{
+	# Add prototypes here when modifying the public interface to add
+	# more gettext wrapper functions.
+	my %prototypes =3D (qw(
+		__	$
+	));
+	while (my ($sub, $proto) =3D each %prototypes) {
+		is(prototype(\&{"Git::I18N::$sub"}), $proto, "sanity: $sub has a $pr=
oto prototype");
+	}
+}
+
+# Test basic passthrough in the C locale
+{
+	local $ENV{LANGUAGE} =3D 'C';
+	local $ENV{LC_ALL}   =3D 'C';
+	local $ENV{LANG}     =3D 'C';
+
+	my ($got, $expect) =3D (('TEST: A Perl test string') x 2);
+
+	is(__($got), $expect, "Passing a string through __() in the C locale =
works");
+}
+
+# Test a basic message on different locales
+SKIP: {
+	unless ($ENV{GETTEXT_LOCALE}) {
+		# Can't reliably test __() with a non-C locales because the
+		# required locales may not be installed on the system.
+		#
+		# We test for these anyway as part of the shell
+		# tests. Skipping these here will eliminate failures on odd
+		# platforms with incomplete locale data.
+
+		skip "GETTEXT_LOCALE must be set by lib-gettext.sh for exhaustive Gi=
t::I18N tests", 2;
+	}
+
+	# The is_IS UTF-8 locale passed from lib-gettext.sh
+	my $is_IS_locale =3D $ENV{is_IS_locale};
+
+	my $test =3D sub {
+		my ($got, $expect, $msg, $locale) =3D @_;
+		# Maybe this system doesn't have the locale we're trying to
+		# test.
+		my $locale_ok =3D setlocale(LC_ALL, $locale);
+		is(__($got), $expect, "$msg a gettext library + <$locale> locale <$g=
ot> turns into <$expect>");
+	};
+
+	my $env_C =3D sub {
+		$ENV{LANGUAGE} =3D 'C';
+		$ENV{LC_ALL}   =3D 'C';
+	};
+
+	my $env_is =3D sub {
+		$ENV{LANGUAGE} =3D 'is';
+		$ENV{LC_ALL}   =3D $is_IS_locale;
+	};
+
+	# Translation's the same as the original
+	my ($got, $expect) =3D (('TEST: A Perl test string') x 2);
+
+	if ($has_gettext_library) {
+		{
+			local %ENV; $env_C->();
+			$test->($got, $expect, "With", 'C');
+		}
+
+		{
+			my ($got, $expect) =3D ($got, 'TILRAUN: Perl tilraunastrengur');
+			local %ENV; $env_is->();
+			$test->($got, $expect, "With", $is_IS_locale);
+		}
+	} else {
+		{
+			local %ENV; $env_C->();
+			$test->($got, $expect, "Without", 'C');
+		}
+
+		{
+			local %ENV; $env_is->();
+			$test->($got, $expect, "Without", 'is');
+		}
+	}
+}
diff --git a/t/t0203-gettext-setlocale-sanity.sh b/t/t0203-gettext-setl=
ocale-sanity.sh
new file mode 100755
index 0000000..a212460
--- /dev/null
+++ b/t/t0203-gettext-setlocale-sanity.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+#
+
+test_description=3D"The Git C functions aren't broken by setlocale(3)"
+
+. ./lib-gettext.sh
+
+test_expect_success 'git show a ISO-8859-1 commit under C locale' '
+	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+	test_commit "iso-c-commit" iso-under-c &&
+	git show >out 2>err &&
+	! test -s err &&
+	grep -q "iso-c-commit" out
+'
+
+test_expect_success GETTEXT_LOCALE 'git show a ISO-8859-1 commit under=
 a UTF-8 locale' '
+	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+	test_commit "iso-utf8-commit" iso-under-utf8 &&
+	LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" git show >out 2>err &&
+	! test -s err &&
+	grep -q "iso-utf8-commit" out
+'
+
+test_done
diff --git a/t/t0204-gettext-reencode-sanity.sh b/t/t0204-gettext-reenc=
ode-sanity.sh
new file mode 100755
index 0000000..189af90
--- /dev/null
+++ b/t/t0204-gettext-reencode-sanity.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+#
+
+test_description=3D"Gettext reencoding of our *.po/*.mo files works"
+
+. ./lib-gettext.sh
+
+
+test_expect_success GETTEXT_LOCALE 'gettext: Emitting UTF-8 from our U=
TF-8 *.mo files / Icelandic' '
+    printf "TILRAUN: Hall=C3=B3 Heimur!" >expect &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "TEST: Hello World!=
" >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success GETTEXT_LOCALE 'gettext: Emitting UTF-8 from our U=
TF-8 *.mo files / Runes' '
+    printf "TILRAUN: =E1=9A=BB=E1=9B=96 =E1=9A=B3=E1=9A=B9=E1=9A=AB=E1=
=9A=A6 =E1=9A=A6=E1=9A=AB=E1=9B=8F =E1=9A=BB=E1=9B=96 =E1=9B=92=E1=9A=A2=
=E1=9B=9E=E1=9B=96 =E1=9A=A9=E1=9A=BE =E1=9A=A6=E1=9A=AB=E1=9B=97 =E1=9B=
=9A=E1=9A=AA=E1=9A=BE=E1=9B=9E=E1=9B=96 =E1=9A=BE=E1=9A=A9=E1=9A=B1=E1=9A=
=A6=E1=9A=B9=E1=9B=96=E1=9A=AA=E1=9A=B1=E1=9B=9E=E1=9A=A2=E1=9B=97 =E1=9A=
=B9=E1=9B=81=E1=9A=A6 =E1=9A=A6=E1=9A=AA =E1=9A=B9=E1=9B=96=E1=9B=A5=E1=
=9A=AB" >expect &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "TEST: Old English =
Runes" >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success GETTEXT_ISO_LOCALE 'gettext: Emitting ISO-8859-1 f=
rom our UTF-8 *.mo files / Icelandic' '
+    printf "TILRAUN: Hall=C3=B3 Heimur!" | iconv -f UTF-8 -t ISO8859-1=
 >expect &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" gettext "TEST: Hello Wo=
rld!" >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success GETTEXT_ISO_LOCALE 'gettext: Emitting ISO-8859-1 f=
rom our UTF-8 *.mo files / Runes' '
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" gettext "TEST: Old Engl=
ish Runes" >runes &&
+
+	if grep "^TEST: Old English Runes$" runes
+	then
+		say "Your system can not handle this complexity and returns the stri=
ng as-is"
+	else
+		# Both Solaris and GNU libintl will return this stream of
+		# question marks, so it is s probably portable enough
+		printf "TILRAUN: ?? ???? ??? ?? ???? ?? ??? ????? ??????????? ??? ??=
 ????" >runes-expect &&
+		test_cmp runes-expect runes
+	fi
+'
+
+test_expect_success GETTEXT_LOCALE 'gettext: Fetching a UTF-8 msgid ->=
 UTF-8' '
+    printf "TILRAUN: =E2=80=9Aeinfaldar=E2=80=98 og =E2=80=9Etv=C3=B6f=
aldar=E2=80=9C g=C3=A6salappir" >expect &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "TEST: =E2=80=98sin=
gle=E2=80=99 and =E2=80=9Cdouble=E2=80=9D quotes" >actual &&
+    test_cmp expect actual
+'
+
+# How these quotes get transliterated depends on the gettext implement=
ation:
+#
+#   Debian:  ,einfaldar' og ,,tv=C3=B6faldar" [GNU libintl]
+#   FreeBSD: `einfaldar` og "tv=C3=B6faldar"  [GNU libintl]
+#   Solaris: ?einfaldar? og ?tv=C3=B6faldar?  [Solaris libintl]
+#
+# Just make sure the contents are transliterated, and don't use grep -=
q
+# so that these differences are emitted under --verbose for curious
+# eyes.
+test_expect_success GETTEXT_ISO_LOCALE 'gettext: Fetching a UTF-8 msgi=
d -> ISO-8859-1' '
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" gettext "TEST: =E2=80=98=
single=E2=80=99 and =E2=80=9Cdouble=E2=80=9D quotes" >actual &&
+    grep "einfaldar" actual &&
+    grep "$(echo tv=C3=B6faldar | iconv -f UTF-8 -t ISO8859-1)" actual
+'
+
+test_expect_success GETTEXT_LOCALE 'gettext.c: git init UTF-8 -> UTF-8=
' '
+    printf "Bj=C3=B3 til t=C3=B3ma Git lind" >expect &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" git init repo >actual &&
+    test_when_finished "rm -rf repo" &&
+    grep "^$(cat expect) " actual
+'
+
+test_expect_success GETTEXT_ISO_LOCALE 'gettext.c: git init UTF-8 -> I=
SO-8859-1' '
+    printf "Bj=C3=B3 til t=C3=B3ma Git lind" >expect &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" git init repo >actual &=
&
+    test_when_finished "rm -rf repo" &&
+    grep "^$(cat expect | iconv -f UTF-8 -t ISO8859-1) " actual
+'
+
+test_done
diff --git a/t/t0205-gettext-poison.sh b/t/t0205-gettext-poison.sh
new file mode 100755
index 0000000..2361590
--- /dev/null
+++ b/t/t0205-gettext-poison.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+#
+
+test_description=3D'Gettext Shell poison'
+
+. ./lib-gettext.sh
+
+test_expect_success GETTEXT_POISON "sanity: \$GIT_INTERNAL_GETTEXT_SH_=
SCHEME is set (to $GIT_INTERNAL_GETTEXT_SH_SCHEME)" '
+    test -n "$GIT_INTERNAL_GETTEXT_SH_SCHEME"
+'
+
+test_expect_success GETTEXT_POISON 'sanity: $GIT_INTERNAL_GETTEXT_SH_S=
CHEME" is poison' '
+    test "$GIT_INTERNAL_GETTEXT_SH_SCHEME" =3D "poison"
+'
+
+test_expect_success GETTEXT_POISON 'gettext: our gettext() fallback ha=
s poison semantics' '
+    printf "# GETTEXT POISON #" >expect &&
+    gettext "test" >actual &&
+    test_cmp expect actual &&
+    printf "# GETTEXT POISON #" >expect &&
+    gettext "test more words" >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success GETTEXT_POISON 'eval_gettext: our eval_gettext() f=
allback has poison semantics' '
+    printf "# GETTEXT POISON #" >expect &&
+    eval_gettext "test" >actual &&
+    test_cmp expect actual &&
+    printf "# GETTEXT POISON #" >expect &&
+    eval_gettext "test more words" >actual &&
+    test_cmp expect actual
+'
+
+test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index bdd9513..9cfabe4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -44,6 +44,7 @@ export LANG LC_ALL PAGER TERM TZ
 EDITOR=3D:
 unset VISUAL
 unset EMAIL
+unset LANGUAGE
 unset $(perl -e '
 	my @env =3D keys %ENV;
 	my $ok =3D join("|", qw(
@@ -1113,12 +1114,14 @@ esac
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
 test -n "$USE_LIBPCRE" && test_set_prereq LIBPCRE
+test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
=20
 # Can we rely on git's output in the C locale?
 if test -n "$GETTEXT_POISON"
 then
 	GIT_GETTEXT_POISON=3DYesPlease
 	export GIT_GETTEXT_POISON
+	test_set_prereq GETTEXT_POISON
 else
 	test_set_prereq C_LOCALE_OUTPUT
 fi
diff --git a/upload-pack.c b/upload-pack.c
index 470cffd..6f36f62 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -784,6 +784,8 @@ int main(int argc, char **argv)
 	int i;
 	int strict =3D 0;
=20
+	git_setup_gettext();
+
 	packet_trace_identity("upload-pack");
 	git_extract_argv0_path(argv[0]);
 	read_replace_refs =3D 0;
diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
index 09feb1f..d2d9dcc 100644
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -15,7 +15,8 @@ else
 	export GIT_TEMPLATE_DIR
 fi
 GITPERLLIB=3D'@@BUILD_DIR@@/perl/blib/lib'
+GIT_TEXTDOMAINDIR=3D'@@BUILD_DIR@@/share/locale'
 PATH=3D'@@BUILD_DIR@@/bin-wrappers:'"$PATH"
-export GIT_EXEC_PATH GITPERLLIB PATH
+export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
=20
 exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
--=20
1.7.6.3
