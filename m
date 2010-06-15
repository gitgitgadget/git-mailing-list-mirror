From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 1/2] Add infrastructure for translating Git with gettext
Date: Tue, 15 Jun 2010 19:33:51 +0000
Message-ID: <1276630432-13299-2-git-send-email-avarab@gmail.com>
References: <7vd3vucip0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff Epler <jepler@unpythonic.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	John Wiegley <johnw@newartisans.com>,
	Graham Anderson <graham.anderson@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 21:34:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OObuI-00053T-0b
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 21:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178Ab0FOTek convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 15:34:40 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43512 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab0FOTeh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 15:34:37 -0400
Received: by wyb40 with SMTP id 40so5117488wyb.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 12:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=8onDmOaKig1/cuTi8Hxg8/vWGwB9qWtVN5rPLCgloGE=;
        b=UD/YMEaFqWlAugC/TR9D6GRM8W1JumZ44JLA+gto8CB5ExsOMadcuiMSq+xoHGdshy
         fq7qCx8CN6W0+S8bpuHvtt2WBNKTSzt0jXDGTNjs04wkzQsqnyjtceQWUhf0Nnl2hTRN
         HRAAFCzhKYT/gLkd6/mMZURaEhu/IYKqyIY7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=QHIltfu5fZ8pdNZZ0/FCWOW8CK7YfQOtqTVVXBwIsTR2VM2ZcHEYV/ct0Jtjsai7k/
         bdxBfA8gkZWgo4qiqFX52C2RMk4GcPnNycIZO1irw5WIHkvXRgUXPpfkHic9cbGWvtNH
         Qdh5lZA0cxOeXG2nApMnqBsJ8SsKMHMNX2fao=
Received: by 10.216.89.199 with SMTP id c49mr4113831wef.29.1276630475625;
        Tue, 15 Jun 2010 12:34:35 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v59sm1965955wec.27.2010.06.15.12.34.32
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Jun 2010 12:34:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <7vd3vucip0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149217>

All of the interface messages in Git core are currently hardcoded in
English. Change that by optionally enabling translation of the core C,
Shell and Perl programs via GNU or SunOS gettext. If you set the
appropriate LC_* variables Git will speak your language, provided that
someone has submitted a translation.

If gettext isn't available, or if Git is compiled with
NO_GETTEXT=3DYesPlease, then Git fall back on its previous behavior of
only speaking English. When using ./configure the autoconf script will
auto-detect if the gettext libraries are installed and act
appropriately.

With NO_GETTEXT=3DYesPlease gettext support will be #defined away for C
programs. For Shell and Perl programs we rely on the git message
catalog not being available. That's a reasonable assumption since then
the message catalog won't be installed on the system during make
install.

The gettext wrappers that are provided in the patch are only the bare
minimum required to begin translation work. In particular I haven't
added wrappers for the gettext functions that enable plural support,
or those that provide message context (msgctxt).

Those can be added later. The intent is to start with a small subset
and see what we need later, not to start with something that's
unnecessarily large right away.

Implementation and usage notes:

 * General:

   Gettext .mo files will be installed and looked for in the standard
   $(prefix)/share/locale path. GIT_TEXTDOMAINDIR can also be set to
   override that, but that's only intended to be used to test Git
   itself.

 * Perl:

   Perl code that wants to be localized should use the new Git::I18n
   module. It imports a __ function into the caller's package by
   default.

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

   See <AANLkTilYD_NyIZMyj9dHtVk-ylVBfvyxpCC7982LWnVd@mail.gmail.com>
   for a further elaboration on this topic.

 * Shell:

   Shell code that's to be localized should use the new git-sh-i18n
   library. It's just a wrapper for the system's gettext.sh.

   If gettext.sh isn't available we'll fall back gettext(1) if it's
   available. The latter is available without the former on Solaris,
   which has its own non-GNU gettext implementation. We also need to
   emulate eval_gettext() there.

   If neither are present we'll use a dumb printf(1) fall-through
   wrapper.

   I originally tried to detect if the system supported `echo -n' but
   I found this to be a waste of time. My benchmarks on Linux, Solaris
   and FreeBSD reveal that printf(1) is fast enough, especially since
   we aren't calling gettext() from within any tight loops, and
   unlikely to ever do so.

This series has been tested by me on Ubuntu 10.04, Debian testing,
=46reeBSD 8.1 and SunOS 5.10, and by others on Mac OS X 10.6.3 (with
Xcode 3.2.2) and openSUSE Factory (11.3, milestone 7).

SunOS has its own non-GNU gettext implementation which this patch
supports, although that may change in the future if it turns out that
we need some GNU libintl features that SunOS doesn't provide.

This patch is based on work by Jeff Epler <jepler@unpythonic.net> who
did the initial Makefile / C work, and a lot of comments from the Git
mailing list, including Jonathan Nieder, Jakub Narebski, Johannes
Sixt, Peter Krefting, Junio C Hamano, Thomas Rast and others.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Tested-By: John Wiegley <johnw@newartisans.com>
Tested-by: Graham Anderson <graham.anderson@gmail.com>
---
 .gitignore                   |    2 +
 INSTALL                      |   12 ++++
 Makefile                     |   69 ++++++++++++++++++++-
 config.mak.in                |    2 +
 configure.ac                 |   12 ++++
 daemon.c                     |    3 +
 fast-import.c                |    3 +
 gettext.c                    |   22 +++++++
 gettext.h                    |   18 ++++++
 git-sh-i18n.sh               |   71 +++++++++++++++++++++
 git.c                        |    3 +
 http-backend.c               |    3 +
 http-fetch.c                 |    3 +
 http-push.c                  |    3 +
 imap-send.c                  |    3 +
 perl/Git/I18N.pm             |   91 +++++++++++++++++++++++++++
 perl/Makefile                |    3 +-
 perl/Makefile.PL             |   14 ++++-
 po/.gitignore                |    1 +
 po/is.po                     |   47 ++++++++++++++
 shell.c                      |    3 +
 show-index.c                 |    3 +
 t/t0200-gettext.sh           |  138 ++++++++++++++++++++++++++++++++++=
++++++++
 t/t0200/test.c               |   13 ++++
 t/t0200/test.perl            |   14 ++++
 t/t0200/test.sh              |   14 ++++
 t/t0201-gettext-fallbacks.sh |   50 +++++++++++++++
 t/t0202-gettext-perl.sh      |   23 +++++++
 t/t0202/test.pl              |  104 +++++++++++++++++++++++++++++++
 t/test-lib.sh                |    2 +
 upload-pack.c                |    3 +
 31 files changed, 748 insertions(+), 4 deletions(-)
 create mode 100644 gettext.c
 create mode 100644 gettext.h
 create mode 100644 git-sh-i18n.sh
 create mode 100644 perl/Git/I18N.pm
 create mode 100644 po/.gitignore
 create mode 100644 po/is.po
 create mode 100755 t/t0200-gettext.sh
 create mode 100644 t/t0200/test.c
 create mode 100644 t/t0200/test.perl
 create mode 100644 t/t0200/test.sh
 create mode 100755 t/t0201-gettext-fallbacks.sh
 create mode 100755 t/t0202-gettext-perl.sh
 create mode 100644 t/t0202/test.pl

diff --git a/.gitignore b/.gitignore
index 14e2b6b..6c2b193 100644
--- a/.gitignore
+++ b/.gitignore
@@ -125,6 +125,7 @@
 /git-rm
 /git-send-email
 /git-send-pack
+/git-sh-i18n
 /git-sh-setup
 /git-shell
 /git-shortlog
@@ -204,3 +205,4 @@
 *.pdb
 /Debug/
 /Release/
+/share/
diff --git a/INSTALL b/INSTALL
index 61086ab..9c9a5fa 100644
--- a/INSTALL
+++ b/INSTALL
@@ -93,6 +93,18 @@ Issues of note:
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
index 5fa893c..b5297b6 100644
--- a/Makefile
+++ b/Makefile
@@ -28,6 +28,15 @@ all::
 # Define NO_EXPAT if you do not have expat installed.  git-http-push i=
s
 # not built, and you cannot push using http:// and https:// transports=
=2E
 #
+# Define NO_GETTEXT if you don't want to build with Git with gettext
+# support. Building it requires GNU libintl or another gettext
+# implementation, and additionally libintl-perl at runtime.
+#
+# Define NEEDS_LIBINTL if you haven't set NO_GETTEXT and your system
+# needs to be explicitly linked to -lintl. It's defined automatically
+# on platforms where we don't expect glibc (Linux, Hurd,
+# GNU/kFreeBSD), which includes libintl.
+#
 # Define EXPATDIR=3D/foo/bar if your expat header and library files ar=
e in
 # /foo/bar/include and /foo/bar/lib directories.
 #
@@ -272,6 +281,7 @@ mandir =3D share/man
 infodir =3D share/info
 gitexecdir =3D libexec/git-core
 sharedir =3D $(prefix)/share
+localedir =3D $(sharedir)/locale
 template_dir =3D share/git-core/templates
 htmldir =3D share/doc/git-doc
 ifeq ($(prefix),/usr)
@@ -285,7 +295,7 @@ lib =3D lib
 # DESTDIR=3D
 pathsep =3D :
=20
-export prefix bindir sharedir sysconfdir
+export prefix bindir sharedir sysconfdir localedir
=20
 CC =3D gcc
 AR =3D ar
@@ -297,6 +307,8 @@ RPMBUILD =3D rpmbuild
 TCL_PATH =3D tclsh
 TCLTK_PATH =3D wish
 PTHREAD_LIBS =3D -lpthread
+XGETTEXT =3D xgettext
+MSGFMT =3D msgfmt
=20
 export TCL_PATH TCLTK_PATH
=20
@@ -358,6 +370,7 @@ SCRIPT_SH +=3D git-web--browse.sh
 SCRIPT_LIB +=3D git-mergetool--lib
 SCRIPT_LIB +=3D git-parse-remote
 SCRIPT_LIB +=3D git-sh-setup
+SCRIPT_LIB +=3D git-sh-i18n
=20
 SCRIPT_PERL +=3D git-add--interactive.perl
 SCRIPT_PERL +=3D git-difftool.perl
@@ -523,6 +536,7 @@ LIB_H +=3D userdiff.h
 LIB_H +=3D utf8.h
 LIB_H +=3D xdiff-interface.h
 LIB_H +=3D xdiff/xdiff.h
+LIB_H +=3D gettext.h
=20
 LIB_OBJS +=3D abspath.o
 LIB_OBJS +=3D advice.o
@@ -564,6 +578,9 @@ LIB_OBJS +=3D entry.o
 LIB_OBJS +=3D environment.o
 LIB_OBJS +=3D exec_cmd.o
 LIB_OBJS +=3D fsck.o
+ifndef NO_GETTEXT
+LIB_OBJS +=3D gettext.o
+endif
 LIB_OBJS +=3D graph.o
 LIB_OBJS +=3D grep.o
 LIB_OBJS +=3D hash.o
@@ -735,6 +752,14 @@ EXTLIBS =3D
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
@@ -743,11 +768,13 @@ ifeq ($(uname_S),Linux)
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
@@ -918,6 +945,7 @@ ifeq ($(uname_S),GNU)
 	NO_STRLCPY=3DYesPlease
 	NO_MKSTEMPS =3D YesPlease
 	HAVE_PATHS_H =3D YesPlease
+	NEEDS_LIBINTL =3D
 endif
 ifeq ($(uname_S),IRIX)
 	NO_SETENV =3D YesPlease
@@ -1387,6 +1415,14 @@ ifdef USE_NED_ALLOCATOR
        COMPAT_OBJS +=3D compat/nedmalloc/nedmalloc.o
 endif
=20
+ifdef NO_GETTEXT
+	COMPAT_CFLAGS +=3D -DNO_GETTEXT
+endif
+
+ifdef NEEDS_LIBINTL
+	EXTLIBS +=3D -lintl
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK=3DNoThanks
 endif
@@ -1416,6 +1452,7 @@ ifndef V
 	QUIET_BUILT_IN =3D @echo '   ' BUILTIN $@;
 	QUIET_GEN      =3D @echo '   ' GEN $@;
 	QUIET_LNCP     =3D @echo '   ' LN/CP $@;
+	QUIET_MSGFMT   =3D @echo '   ' MSGFMT $@;
 	QUIET_SUBDIR0  =3D +@subdir=3D
 	QUIET_SUBDIR1  =3D ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
@@ -1443,7 +1480,9 @@ gitexecdir_SQ =3D $(subst ','\'',$(gitexecdir))
 template_dir_SQ =3D $(subst ','\'',$(template_dir))
 htmldir_SQ =3D $(subst ','\'',$(htmldir))
 prefix_SQ =3D $(subst ','\'',$(prefix))
+sharedir_SQ =3D $(subst ','\'',$(sharedir))
=20
+LOCALEDIR_SQ =3D $(subst ','\'',$(localedir))
 SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ =3D $(subst ','\'',$(PERL_PATH))
 PYTHON_PATH_SQ =3D $(subst ','\'',$(PYTHON_PATH))
@@ -1492,7 +1531,7 @@ ifndef NO_TCLTK
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
@@ -1537,6 +1576,7 @@ $(RM) $@ $@+ && \
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
     -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+    -e 's|@@LOCALEDIR@@|$(LOCALEDIR_SQ)|g' \
     -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
     -e $(BROKEN_PATH_FIX) \
     $@.sh >$@+
@@ -1872,6 +1912,21 @@ cscope:
 	$(RM) cscope*
 	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
=20
+pot:
+	$(XGETTEXT) --add-comments --keyword=3D_ --keyword=3DN_ --output=3Dpo=
/git.pot --language=3DC $(C_OBJ:o=3Dc) t/t0200/test.c
+	$(XGETTEXT) --add-comments --join-existing --output=3Dpo/git.pot --la=
nguage=3DShell $(SCRIPT_SH) t/t0200/test.sh
+	$(XGETTEXT) --add-comments --join-existing --keyword=3D__ --output=3D=
po/git.pot --language=3DPerl $(SCRIPT_PERL) t/t0200/test.perl
+
+POFILES :=3D $(wildcard po/*.po)
+MOFILES :=3D $(patsubst po/%.po,share/locale/%/LC_MESSAGES/git.mo,$(PO=
=46ILES))
+MODIRS :=3D $(patsubst po/%.po,share/locale/%/LC_MESSAGES/,$(POFILES))
+ifndef NO_GETTEXT
+all:: $(MOFILES)
+endif
+share/locale/%/LC_MESSAGES/git.mo: po/%.po
+	@mkdir -p $(dir $@)
+	$(QUIET_MSGFMT)$(MSGFMT) -o $@ $<
+
 ### Detect prefix changes
 TRACK_CFLAGS =3D $(subst ','\'',$(ALL_CFLAGS)):\
              $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix=
_SQ)
@@ -1893,6 +1948,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_CURL=3D\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
 	@echo NO_PERL=3D\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
 	@echo NO_PYTHON=3D\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' =
>>$@
+	@echo NO_GETTEXT=3D\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\=
' >>$@
=20
 ### Detect Tck/Tk interpreter path changes
 ifndef NO_TCLTK
@@ -1984,6 +2040,11 @@ install: all
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
+ifndef NO_GETTEXT
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(sharedir_SQ)/locale'
+	(cd share && tar cf - locale) | \
+		(cd '$(DESTDIR_SQ)$(sharedir_SQ)' && umask 022 && tar xof -)
+endif
 	$(MAKE) -C templates DESTDIR=3D'$(DESTDIR_SQ)' install
 ifndef NO_PERL
 	$(MAKE) -C perl prefix=3D'$(prefix_SQ)' DESTDIR=3D'$(DESTDIR_SQ)' ins=
tall
@@ -2131,6 +2192,10 @@ ifndef NO_TCLTK
 	$(MAKE) -C git-gui clean
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-GUI-VARS GIT-BUILD-OPTIONS
+ifndef NO_GETTEXT
+	$(RM) po/git.pot
+	$(RM) -r share/
+endif
=20
 .PHONY: all install clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_moder=
n_shell
diff --git a/config.mak.in b/config.mak.in
index 0d4b64d..c49072c 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -32,9 +32,11 @@ NO_CURL=3D@NO_CURL@
 NO_EXPAT=3D@NO_EXPAT@
 NO_LIBGEN_H=3D@NO_LIBGEN_H@
 HAVE_PATHS_H=3D@HAVE_PATHS_H@
+NO_GETTEXT=3D@NO_GETTEXT@
 NEEDS_LIBICONV=3D@NEEDS_LIBICONV@
 NEEDS_SOCKET=3D@NEEDS_SOCKET@
 NEEDS_RESOLV=3D@NEEDS_RESOLV@
+NEEDS_LIBINTL=3D@NEEDS_LIBINTL@
 NEEDS_LIBGEN=3D@NEEDS_LIBGEN@
 NO_SYS_SELECT_H=3D@NO_SYS_SELECT_H@
 NO_D_INO_IN_DIRENT=3D@NO_D_INO_IN_DIRENT@
diff --git a/configure.ac b/configure.ac
index 71038fc..74879b4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -559,6 +559,12 @@ AC_CHECK_LIB([c], [basename],
 AC_SUBST(NEEDS_LIBGEN)
 test -n "$NEEDS_LIBGEN" && LIBS=3D"$LIBS -lgen"
=20
+AC_CHECK_LIB([c], [gettext],
+[NEEDS_LIBINTL=3D],
+[NEEDS_LIBINTL=3DYesPlease])
+AC_SUBST(NEEDS_LIBINTL)
+test -n "$NEEDS_LIBINTL" && LIBS=3D"$LIBS -lintl"
+
 ## Checks for header files.
 AC_MSG_NOTICE([CHECKS for header files])
 #
@@ -730,6 +736,12 @@ AC_CHECK_HEADER([paths.h],
 [HAVE_PATHS_H=3D])
 AC_SUBST(HAVE_PATHS_H)
 #
+# Define NO_GETTEXT if you don't have libintl.h
+AC_CHECK_HEADER([libintl.h],
+[NO_GETTEXT=3D],
+[NO_GETTEXT=3DYesPlease])
+AC_SUBST(NO_GETTEXT)
+#
 # Define NO_STRCASESTR if you don't have strcasestr.
 GIT_CHECK_FUNC(strcasestr,
 [NO_STRCASESTR=3D],
diff --git a/daemon.c b/daemon.c
index a90ab10..7f4691c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -3,6 +3,7 @@
 #include "exec_cmd.h"
 #include "run-command.h"
 #include "strbuf.h"
+#include "gettext.h"
=20
 #include <syslog.h>
=20
@@ -974,6 +975,8 @@ int main(int argc, char **argv)
 	gid_t gid =3D 0;
 	int i;
=20
+	git_setup_gettext();
+
 	git_extract_argv0_path(argv[0]);
=20
 	for (i =3D 1; i < argc; i++) {
diff --git a/fast-import.c b/fast-import.c
index 129a786..6947f7a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -156,6 +156,7 @@ Format of STDIN stream:
 #include "csum-file.h"
 #include "quote.h"
 #include "exec_cmd.h"
+#include "gettext.h"
=20
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -2904,6 +2905,8 @@ int main(int argc, const char **argv)
=20
 	git_extract_argv0_path(argv[0]);
=20
+	git_setup_gettext();
+
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage(fast_import_usage);
=20
diff --git a/gettext.c b/gettext.c
new file mode 100644
index 0000000..7ae5cae
--- /dev/null
+++ b/gettext.c
@@ -0,0 +1,22 @@
+#include "exec_cmd.h"
+#include <locale.h>
+#include <libintl.h>
+#include <stdlib.h>
+
+extern void git_setup_gettext(void) {
+	char *podir;
+	char *envdir =3D getenv("GIT_TEXTDOMAINDIR");
+
+	if (envdir) {
+		(void)bindtextdomain("git", envdir);
+	} else {
+		podir =3D (char *)system_path("share/locale");
+		if (!podir) return;
+		(void)bindtextdomain("git", podir);
+		free(podir);
+	}
+
+	(void)setlocale(LC_MESSAGES, "");
+	(void)setlocale(LC_CTYPE, "");
+	(void)textdomain("git");
+}
diff --git a/gettext.h b/gettext.h
new file mode 100644
index 0000000..e02939a
--- /dev/null
+++ b/gettext.h
@@ -0,0 +1,18 @@
+#ifndef GETTEXT_H
+#define GETTEXT_H
+
+#ifdef NO_GETTEXT
+static inline void git_setup_gettext(void) {}
+#else
+extern void git_setup_gettext(void);
+#endif
+
+#define N_(s) (s)
+#ifdef NO_GETTEXT
+#define _(s) (s)
+#else
+#include <libintl.h>
+#define _(s) gettext(s)
+#endif
+
+#endif
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
new file mode 100644
index 0000000..698a000
--- /dev/null
+++ b/git-sh-i18n.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+#
+# This is Git's interface to gettext.sh. Use it right after
+# git-sh-setup as:
+#
+#   . git-sh-setup
+#   . git-sh-i18n
+#
+#   # For constant interface messages:
+#   gettext "A message for the user"; echo
+#
+#   # To interpolate variables:
+#   details=3D"oh noes"
+#   eval_gettext "An error occured: \$details"; echo
+#
+# See "info '(gettext)sh'" for the full manual.
+
+# Export the TEXTDOMAIN* data that we need for Git
+TEXTDOMAIN=3Dgit
+export TEXTDOMAIN
+if [ -z "$GIT_TEXTDOMAINDIR" ]
+then
+	TEXTDOMAINDIR=3D"@@LOCALEDIR@@"
+else
+	TEXTDOMAINDIR=3D"$GIT_TEXTDOMAINDIR"
+fi
+export TEXTDOMAINDIR
+
+if test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && type gettext.sh >=
/dev/null 2>&1
+then
+	# This is GNU libintl's gettext.sh, we don't need to do anything
+	# else than setting up the environment and loading gettext.sh
+	GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dgnu
+	export GIT_INTERNAL_GETTEXT_SH_SCHEME
+
+	# Try to use libintl's gettext.sh, or fall back to English if we
+	# can't.
+	. gettext.sh
+elif test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && test "$(gettext=
 -h 2>&1)" =3D "-h"
+then
+	# We don't have gettext.sh, but there's a gettext binary in our
+	# path. This is probably Solaris or something like it which has a
+	# gettext implementation that isn't GNU libintl.
+	GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dsolaris
+	export GIT_INTERNAL_GETTEXT_SH_SCHEME
+
+	# Solaris has a gettext(1) but no eval_gettext(1)
+	eval_gettext () {
+		gettext_out=3D$(gettext "$1")
+		gettext_eval=3D"printf '%s' \"$gettext_out\""
+		printf "%s" "`eval \"$gettext_eval\"`"
+	}
+else
+	# Since gettext.sh isn't available we'll have to define our own
+	# dummy pass-through functions.
+
+	# Tell our tests that we don't have the real gettext.sh
+	GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dfallthrough
+	export GIT_INTERNAL_GETTEXT_SH_SCHEME
+
+	gettext () {
+		printf "%s" "$1"
+	}
+
+	eval_gettext () {
+		gettext_eval=3D"printf '%s' \"$1\""
+		printf "%s" "`eval \"$gettext_eval\"`"
+	}
+fi
diff --git a/git.c b/git.c
index 99f0363..d749eab 100644
--- a/git.c
+++ b/git.c
@@ -3,6 +3,7 @@
 #include "cache.h"
 #include "quote.h"
 #include "run-command.h"
+#include "gettext.h"
=20
 const char git_usage_string[] =3D
 	"git [--version] [--exec-path[=3DGIT_EXEC_PATH]] [--html-path]\n"
@@ -490,6 +491,8 @@ int main(int argc, const char **argv)
 	if (!cmd)
 		cmd =3D "git-help";
=20
+	git_setup_gettext();
+
 	/*
 	 * "git-xxxx" is the same as "git xxxx", but we obviously:
 	 *
diff --git a/http-backend.c b/http-backend.c
index d1e83d0..b6d9bd5 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -6,6 +6,7 @@
 #include "exec_cmd.h"
 #include "run-command.h"
 #include "string-list.h"
+#include "gettext.h"
=20
 static const char content_type[] =3D "Content-Type";
 static const char content_length[] =3D "Content-Length";
@@ -605,6 +606,8 @@ int main(int argc, char **argv)
 	char *cmd_arg =3D NULL;
 	int i;
=20
+	git_setup_gettext();
+
 	git_extract_argv0_path(argv[0]);
 	set_die_routine(die_webcgi);
=20
diff --git a/http-fetch.c b/http-fetch.c
index 762c750..b889c36 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -2,6 +2,7 @@
 #include "exec_cmd.h"
 #include "http.h"
 #include "walker.h"
+#include "gettext.h"
=20
 static const char http_fetch_usage[] =3D "git http-fetch "
 "[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url";
@@ -24,6 +25,8 @@ int main(int argc, const char **argv)
 	int get_verbosely =3D 0;
 	int get_recover =3D 0;
=20
+	git_setup_gettext();
+
 	git_extract_argv0_path(argv[0]);
=20
 	while (arg < argc && argv[arg][0] =3D=3D '-') {
diff --git a/http-push.c b/http-push.c
index 415b1ab..ba0338c 100644
--- a/http-push.c
+++ b/http-push.c
@@ -10,6 +10,7 @@
 #include "remote.h"
 #include "list-objects.h"
 #include "sigchain.h"
+#include "gettext.h"
=20
 #include <expat.h>
=20
@@ -1791,6 +1792,8 @@ int main(int argc, char **argv)
 	struct remote *remote;
 	char *rewritten_url =3D NULL;
=20
+	git_setup_gettext();
+
 	git_extract_argv0_path(argv[0]);
=20
 	repo =3D xcalloc(sizeof(*repo), 1);
diff --git a/imap-send.c b/imap-send.c
index 9d0097c..4f5f269 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -25,6 +25,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "run-command.h"
+#include "gettext.h"
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #else
@@ -1535,6 +1536,8 @@ int main(int argc, char **argv)
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
index 0000000..5918d68
--- /dev/null
+++ b/perl/Git/I18N.pm
@@ -0,0 +1,91 @@
+package Git::I18N;
+use 5.006002;
+use strict;
+use warnings;
+use Exporter;
+use base 'Exporter';
+
+our $VERSION =3D '0.01';
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
+	eval { __bootstrap_locale_messages() };
+	if ($@) {
+		# Tell test.pl that we couldn't load the gettext library.
+		$Git::I18N::__HAS_LIBRARY =3D 0;
+
+		# Just a fall-through no-op
+		*__ =3D sub ($) { $_[0] };
+	} else {
+		*__ =3D \&Locale::Messages::gettext;
+	}
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
index 4ab21d6..4e624ff 100644
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
-	$(PERL_PATH) $< PREFIX=3D'$(prefix_SQ)'
+	$(PERL_PATH) $< PREFIX=3D'$(prefix_SQ)' --localedir=3D'$(localedir_SQ=
)'
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
diff --git a/po/.gitignore b/po/.gitignore
new file mode 100644
index 0000000..221000e
--- /dev/null
+++ b/po/.gitignore
@@ -0,0 +1 @@
+/*.pot
diff --git a/po/is.po b/po/is.po
new file mode 100644
index 0000000..95739f1
--- /dev/null
+++ b/po/is.po
@@ -0,0 +1,47 @@
+msgid ""
+msgstr ""
+"Project-Id-Version: Git\n"
+"PO-Revision-Date: 2010-06-05 19:06 +0000\n"
+"Language-Team: Git Mailing List <git@vger.kernel.org>\n"
+"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
+"Last-Translator: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
=2Ecom>\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#: t/t0200/test.c:4
+msgid "See git help COMMAND for more information on a specific command=
=2E"
+msgstr "Sj=C3=A1 git help SKIPUN til a=C3=B0 sj=C3=A1 hj=C3=A1lp fyrir=
 tiltekna skipun."
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:9
+msgid "TEST: A C test string"
+msgstr "TILRAUN: C tilraunastrengur"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:12
+#, c-format
+msgid "TEST: A C test string %s"
+msgstr "TILRAUN: C tilraunastrengur %s"
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
diff --git a/shell.c b/shell.c
index e4864e0..ba27c6b 100644
--- a/shell.c
+++ b/shell.c
@@ -2,6 +2,7 @@
 #include "quote.h"
 #include "exec_cmd.h"
 #include "strbuf.h"
+#include "gettext.h"
=20
 static int do_generic_cmd(const char *me, char *arg)
 {
@@ -51,6 +52,8 @@ int main(int argc, char **argv)
 	struct commands *cmd;
 	int devnull_fd;
=20
+	git_setup_gettext();
+
 	/*
 	 * Always open file descriptors 0/1/2 to avoid clobbering files
 	 * in die().  It also avoids not messing up when the pipes are
diff --git a/show-index.c b/show-index.c
index 4c0ac13..c2f5448 100644
--- a/show-index.c
+++ b/show-index.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "pack.h"
+#include "gettext.h"
=20
 static const char show_index_usage[] =3D
 "git show-index < <packed archive index>";
@@ -11,6 +12,8 @@ int main(int argc, char **argv)
 	unsigned int version;
 	static unsigned int top_index[256];
=20
+	git_setup_gettext();
+
 	if (argc !=3D 1)
 		usage(show_index_usage);
 	if (fread(top_index, 2 * 4, 1, stdin) !=3D 1)
diff --git a/t/t0200-gettext.sh b/t/t0200-gettext.sh
new file mode 100755
index 0000000..98fbc4d
--- /dev/null
+++ b/t/t0200-gettext.sh
@@ -0,0 +1,138 @@
+#!/bin/sh
+
+test_description=3D'Gettext support for Git'
+
+. ./test-lib.sh
+
+GIT_TEXTDOMAINDIR=3D"$GIT_EXEC_PATH/share/locale"
+GIT_PO_PATH=3D"$GIT_EXEC_PATH/po"
+export GIT_TEXTDOMAINDIR GIT_PO_PATH
+
+. "$GIT_EXEC_PATH"/git-sh-i18n
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
+# Basic xgettext() extraction tests on po/*.po. Doesn't need gettext s=
upport
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
+if test_have_prereq GETTEXT; then
+	test_expect_success 'sanity: $TEXTDOMAINDIR exists without NO_GETTEXT=
=3DYesPlease' '
+    test -d "$TEXTDOMAINDIR" &&
+    test "$TEXTDOMAINDIR" =3D "$GIT_TEXTDOMAINDIR"
+'
+
+	test_expect_success 'sanity: Icelandic locale was compiled' '
+    test -f "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
+'
+else
+	test_expect_success "sanity: \$TEXTDOMAINDIR doesn't exists with NO_G=
ETTEXT=3DYesPlease" '
+    ! test -d "$TEXTDOMAINDIR" &&
+    test "$TEXTDOMAINDIR" =3D "$GIT_TEXTDOMAINDIR"
+'
+fi
+
+# We can go no further without actual gettext support
+if ! test_have_prereq GETTEXT || test $GIT_INTERNAL_GETTEXT_SH_SCHEME =
=3D "fallthrough"; then
+	say "Skipping the rest of the gettext tests, Git was compiled with NO=
_GETTEXT=3DYesPlease"
+	test_done
+fi
+
+# The remaining tests are locale sensitive. They'll fail if the
+# example is_IS locale isn't installed on e.g a fresh Debian system
+if test -z "$TEST_GIT_GETTEXT_EXHAUSTIVE"; then
+	say 'Skipping unportable gettext() tests which depend on is_IS locale=
, set TEST_GIT_GETTEXT_EXHAUSTIVE=3D1 to enable'
+
+	test_done
+fi=20
+
+# TODO: When we have more locales, generalize this to test them
+# all. Maybe we'll need a dir->locale map for that.
+test_expect_success 'sanity: gettext("") metadata is OK' '
+    # Return value may be non-zero
+    LANGUAGE=3Dis LC_ALL=3Dis_IS.UTF-8 gettext "" >zero-expect &&
+    grep "Project-Id-Version: Git" zero-expect &&
+    grep "Git Mailing List <git@vger.kernel.org>" zero-expect &&
+    grep "Content-Type: text/plain; charset=3DUTF-8" zero-expect &&
+    grep "Content-Transfer-Encoding: 8bit" zero-expect
+'
+
+test_expect_success 'sanity: gettext(unknown) is passed through' '
+    printf "This is not a translation string"  >expect &&
+    gettext "This is not a translation string" >actual &&
+    eval_gettext "This is not a translation string" >actual &&
+    test_cmp expect actual
+'
+
+# xgettext from C
+test_expect_success 'xgettext: C extraction of _() and N_() strings' '
+    printf "TILRAUN: C tilraunastrengur" >expect &&
+    printf "\n" >>expect &&
+    printf "Sj=C3=A1 git help SKIPUN til a=C3=B0 sj=C3=A1 hj=C3=A1lp f=
yrir tiltekna skipun." >>expect &&
+    LANGUAGE=3Dis LC_ALL=3Dis_IS.UTF-8 gettext "TEST: A C test string"=
 >actual &&
+    printf "\n" >>actual &&
+    LANGUAGE=3Dis LC_ALL=3Dis_IS.UTF-8 gettext "See git help COMMAND f=
or more information on a specific command." >>actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'xgettext: C extraction with %s' '
+    printf "TILRAUN: C tilraunastrengur %%s" >expect &&
+    LANGUAGE=3Dis LC_ALL=3Dis_IS.UTF-8 gettext "TEST: A C test string =
%s" >actual &&
+    test_cmp expect actual
+'
+
+# xgettext from Shell
+test_expect_success 'xgettext: Shell extraction' '
+    printf "TILRAUN: Skeljartilraunastrengur" >expect &&
+    LANGUAGE=3Dis LC_ALL=3Dis_IS.UTF-8 gettext "TEST: A Shell test str=
ing" >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'xgettext: Shell extraction with $variable' '
+    printf "TILRAUN: Skeljartilraunastrengur me=C3=B0 breytunni a var =
i able" >x-expect &&
+    LANGUAGE=3Dis LC_ALL=3Dis_IS.UTF-8 variable=3D"a var i able" eval_=
gettext "TEST: A Shell test \$variable" >x-actual &&
+    test_cmp x-expect x-actual
+'
+
+# xgettext from Perl
+test_expect_success 'xgettext: Perl extraction' '
+    printf "TILRAUN: Perl tilraunastrengur" >expect &&
+    LANGUAGE=3Dis LC_ALL=3Dis_IS.UTF-8 gettext "TEST: A Perl test stri=
ng" >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'xgettext: Perl extraction with %s' '
+    printf "TILRAUN: Perl tilraunastrengur me=C3=B0 breytunni %%s" >ex=
pect &&
+    LANGUAGE=3Dis LC_ALL=3Dis_IS.UTF-8 gettext "TEST: A Perl test vari=
able %s" >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'sanity: No gettext("") data for fantasy locale' '
+    LANGUAGE=3Dis LC_ALL=3Dtlh_TLH.UTF-8 gettext "" >fantasy-locale &&
+    ! test -s fantasy-locale
+'
+
+test_expect_success 'sanity: Some gettext("") data for real locale' '
+    LANGUAGE=3Dis LC_ALL=3Dis_IS.UTF-8 gettext "" >real-locale &&
+    test -s real-locale
+'
+
+test_done
diff --git a/t/t0200/test.c b/t/t0200/test.c
new file mode 100644
index 0000000..93373b3
--- /dev/null
+++ b/t/t0200/test.c
@@ -0,0 +1,13 @@
+/* This is a phony C program that's only here to test xgettext message=
 extraction */
+
+const char help[] =3D
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
new file mode 100755
index 0000000..ea1ca9d
--- /dev/null
+++ b/t/t0201-gettext-fallbacks.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description=3D'Gettext Shell fallbacks'
+
+. ./test-lib.sh
+
+GIT_TEXTDOMAINDIR=3D"$GIT_EXEC_PATH/share/locale"
+GIT_INTERNAL_GETTEXT_TEST_FALLBACKS=3DYesPlease
+
+export GIT_TEXTDOMAINDIR GIT_INTERNAL_GETTEXT_TEST_FALLBACKS
+
+. "$GIT_EXEC_PATH"/git-sh-i18n
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
+test_expect_success 'sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME" is fallt=
hrough' '
+    test "$GIT_INTERNAL_GETTEXT_SH_SCHEME" =3D "fallthrough"
+'
+
+test_expect_success 'gettext: our gettext() fallback has pass-through =
semantics' '
+    printf "test" >expect &&
+    gettext "test" >actual &&
+    test_cmp expect actual &&
+    printf "test more words" >expect &&
+    gettext "test more words" >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'eval_gettext: our eval_gettext() fallback has pas=
s-through semantics' '
+    printf "test" >expect &&
+    eval_gettext "test" >actual &&
+    test_cmp expect actual &&
+    printf "test more words" >expect &&
+    eval_gettext "test more words" >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'eval_gettext: our eval_gettext() fallback can int=
erpolate variables' '
+    printf "test YesPlease" >expect &&
+    eval_gettext "test \$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" >actual =
&&
+    test_cmp expect actual
+'
+
+test_done
diff --git a/t/t0202-gettext-perl.sh b/t/t0202-gettext-perl.sh
new file mode 100755
index 0000000..3a37b23
--- /dev/null
+++ b/t/t0202-gettext-perl.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description=3D'Perl gettext interface (Git::I18N)'
+. ./test-lib.sh
+
+GIT_TEXTDOMAINDIR=3D"$GIT_EXEC_PATH/share/locale"
+export GIT_TEXTDOMAINDIR
+
+if ! test_have_prereq PERL; then
+	say 'skipping perl interface tests, perl not available'
+	test_done
+fi
+
+"$PERL_PATH" -MTest::More -e 0 2>/dev/null || {
+	say "Perl Test::More unavailable, skipping test"
+	test_done
+}
+
+test_external_without_stderr \
+    'Perl Git::I18N API' \
+    "$PERL_PATH" "$TEST_DIRECTORY"/t0202/test.pl
+
+test_done
diff --git a/t/t0202/test.pl b/t/t0202/test.pl
new file mode 100644
index 0000000..a952fb2
--- /dev/null
+++ b/t/t0202/test.pl
@@ -0,0 +1,104 @@
+#!/usr/bin/perl
+use 5.006002;
+use lib (split(/:/, $ENV{GITPERLLIB}));
+use warnings;
+use strict;
+use Test::More tests =3D> 9;
+use Git::I18N;
+use POSIX qw(:locale_h);
+
+my $has_gettext_library =3D $Git::I18N::__HAS_LIBRARY;
+
+ok(1, "Testing Git::I18N version $Git::I18N::VERSION with " .
+	 ($has_gettext_library
+	  ? "Locale::Messages version $Locale::Messages::VERSION"
+	  : "NO Perl gettext library"));
+ok(1, "Git::I18N is located at $INC{'Git/I18N.pm'}");
+
+ok($Git::I18N::VERSION, 'sanity: Git::I18N defines a $VERSION');
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
+    ));
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
+	local $ENV{LANG} =3D 'C';
+
+	my ($got, $expect) =3D (('TEST: A Perl test string') x 2);
+
+	is(__($got), $expect, "Passing a string through __() in the C locale =
works");
+}
+
+# Test a basic message on different locales
+SKIP: {
+    unless ($ENV{TEST_GIT_GETTEXT_EXHAUSTIVE}) {
+        # Can't reliably test __() with a non-C locales because the
+        # required locales may not be installed on the system.
+        #
+        # We test for these anyway as part of the shell
+        # tests. Skipping these here will eliminate failures on odd
+        # platforms with incomplete locale data.
+
+        skip "Set TEST_GIT_GETTEXT_EXHAUSTIVE=3D1 to enable exhaustive=
 Git::I18N locale tests", 2;
+    }
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
+		$ENV{LC_ALL}   =3D 'is_IS.UTF-8';
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
+			$test->($got, $expect, "With", 'is_IS.UTF-8');
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
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 454880a..ae63316 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -37,6 +37,7 @@ ORIGINAL_TERM=3D$TERM
 # For repeatability, reset the environment to known value.
 LANG=3DC
 LC_ALL=3DC
+LANGUAGE=3DC
 PAGER=3Dcat
 TZ=3DUTC
 TERM=3Ddumb
@@ -845,6 +846,7 @@ esac
=20
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
+test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
=20
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYML=
INKS
diff --git a/upload-pack.c b/upload-pack.c
index dc464d7..ece9a4b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -10,6 +10,7 @@
 #include "revision.h"
 #include "list-objects.h"
 #include "run-command.h"
+#include "gettext.h"
=20
 static const char upload_pack_usage[] =3D "git upload-pack [--strict] =
[--timeout=3Dnn] <dir>";
=20
@@ -686,6 +687,8 @@ int main(int argc, char **argv)
 	int i;
 	int strict =3D 0;
=20
+	git_setup_gettext();
+
 	git_extract_argv0_path(argv[0]);
 	read_replace_refs =3D 0;
=20
--=20
1.7.1.251.g92a7
