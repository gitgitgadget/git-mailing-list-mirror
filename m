From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v6 1/2] Add infrastructure for translating Git with gettext
Date: Thu,  3 Jun 2010 21:10:10 +0000
Message-ID: <1275599411-14413-2-git-send-email-avarab@gmail.com>
References: <1275599411-14413-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 03 23:12:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKHi5-0003G9-VX
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 23:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885Ab0FCVMJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 17:12:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64204 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755775Ab0FCVMG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 17:12:06 -0400
Received: by fxm8 with SMTP id 8so420668fxm.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 14:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=UNW3czOHfO7gsXpfeGM+aLLe0n/cwP5RdN/fjkpSbxI=;
        b=rRSpJh0/vKXOtqoqbupDDSzM/bIuJ5o0zlvnw+P8d4o5ATZrob2BZQXtXQ21jotKpN
         v3dZtbesGvgLLUNIb7BmwjF6o405geFvvsCZqoApRCXzn5Y4pqV202xQ61HRzGqjpqLl
         1B1zj5314xocAQkxyCGMwi9YRYyK2eNK3wYDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Mjd8ozh+iqXA6W9QI3xh8YKIrO4g2/GqjqMgvg0QEZSKLnLxv/WVHtLFgG7UXhtZH6
         xK2lBn9L8mxlKVrmcXh3fnPGnEERXQoPV/Vu2guyGdeKRnSovF5YhhHH+RlaZ94siMf5
         HmiGg4D3iau7Zy63FsOqnvRka7zrIj0JDmvcI=
Received: by 10.102.246.2 with SMTP id t2mr3538333muh.103.1275599522838;
        Thu, 03 Jun 2010 14:12:02 -0700 (PDT)
Received: from aoeu.localdomain (pD9534BE8.dip.t-dialin.net [217.83.75.232])
        by mx.google.com with ESMTPS id e9sm675707muf.10.2010.06.03.14.11.59
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 14:12:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.242.g64631
In-Reply-To: <1275599411-14413-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148364>

All of the interface messages in Git core are currently hardcoded in
English. Change that by optionally enabling translation of the core C,
Shell and Perl programs via GNU gettext. If you set the appropriate
LC_* variables Git will speak your language, provided that someone has
submitted a translation.

If gettext isn't available, or if Git is compiled with
NO_GETTEXT=3DYesPlease, then Git fall back on its previous behavior of
only speaking English.

With NO_GETTEXT=3DYesPlease gettext support will be #defined away for C
programs. For Shell and Perl programs we rely on the git message
catalog not being avalalable. That's a reasonable assumption since the
*.po files won't be installed on the system during make install.

The gettext wrappers that are provided in the patch are only the bare
minimum required to begin translation work. In particular I haven't
added wrappers for the gettext functions that enable plural support,
or those that provide message context (msgctxt). Those can be added
later. The intent is to start with a small subset and see what we need
later, not to start with something that's unnecessarily large right
away.

Implementation and usage notes:

 * General:

   Gettext .mo files will be installed and looked for in the standard
   $(prefix)/share/locale path. GIT_TEXTDOMAINDIR can also be set to
   override that. But this is only intended to be used to test Git
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

 * Shell:

   Shell code that wants to be localized should use the new
   git-sh-i18n library. It's just a wrapper for the system's
   gettext.sh.

   If gettext.sh isn't available we'll fall back on a dumb
   printf(1)-powered fall-through wrapper.

   I originally tried to detect if the system supported `echo -n' but
   I found this to be a waste of time. My benchmarks on Linux, Solaris
   and FreeBSD reveal that printf(1) is fast enough, especially since
   we aren't calling gettext() from within any tight loops.

This patch is based on work by Jeff Epler <jepler@unpythonic.net> who
did the initial Makefile / C work, and a lot of comments from the Git
mailing list.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 .gitignore                   |    2 +
 INSTALL                      |    8 +++
 Makefile                     |   44 +++++++++++++-
 config.mak.in                |    1 +
 configure.ac                 |    6 ++
 gettext.c                    |   25 ++++++++
 gettext.h                    |   13 ++++
 git-sh-i18n.sh               |   47 ++++++++++++++
 git.c                        |    3 +
 perl/Git/I18N.pm             |   91 ++++++++++++++++++++++++++++
 perl/Makefile                |    3 +-
 perl/Makefile.PL             |   14 ++++-
 po/.gitignore                |    1 +
 po/is.po                     |   46 ++++++++++++++
 t/t0200-gettext.sh           |  136 ++++++++++++++++++++++++++++++++++=
++++++++
 t/t0200/test.c               |   11 ++++
 t/t0200/test.perl            |   14 ++++
 t/t0200/test.sh              |   14 ++++
 t/t0201-gettext-fallbacks.sh |   42 +++++++++++++
 t/t0202-gettext-perl.sh      |   20 ++++++
 t/t0202/test.pl              |  104 ++++++++++++++++++++++++++++++++
 t/test-lib.sh                |    1 +
 22 files changed, 642 insertions(+), 4 deletions(-)
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
index 61086ab..f30d5bd 100644
--- a/INSTALL
+++ b/INSTALL
@@ -93,6 +93,14 @@ Issues of note:
 	  history graphically, and in git-gui.  If you don't want gitk or
 	  git-gui, you can use NO_TCLTK.
=20
+	- The GNU "libintl" library is used by default for localizing
+	  Git. It needs a gettext.h on the system for C code, gettext.sh
+	  for shell scripts, and libintl-perl for Perl programs.
+
+	  Set NO_GETTEXT to disable localization support and make Git only
+	  use English. Under autoconf the configure script will do this
+	  automatically if it can't find libintl on the system.
+
  - Some platform specific issues are dealt with Makefile rules,
    but depending on your specific installation, you may not
    have all the libraries/tools needed, or you may have
diff --git a/Makefile b/Makefile
index d5d6565..5169aec 100644
--- a/Makefile
+++ b/Makefile
@@ -272,6 +272,7 @@ mandir =3D share/man
 infodir =3D share/info
 gitexecdir =3D libexec/git-core
 sharedir =3D $(prefix)/share
+localedir =3D $(sharedir)/locale
 template_dir =3D share/git-core/templates
 htmldir =3D share/doc/git-doc
 ifeq ($(prefix),/usr)
@@ -285,7 +286,7 @@ lib =3D lib
 # DESTDIR=3D
 pathsep =3D :
=20
-export prefix bindir sharedir sysconfdir
+export prefix bindir sharedir sysconfdir localedir
=20
 CC =3D gcc
 AR =3D ar
@@ -297,6 +298,8 @@ RPMBUILD =3D rpmbuild
 TCL_PATH =3D tclsh
 TCLTK_PATH =3D wish
 PTHREAD_LIBS =3D -lpthread
+XGETTEXT =3D xgettext
+MSGFMT =3D msgfmt
=20
 export TCL_PATH TCLTK_PATH
=20
@@ -358,6 +361,7 @@ SCRIPT_SH +=3D git-web--browse.sh
 SCRIPT_LIB +=3D git-mergetool--lib
 SCRIPT_LIB +=3D git-parse-remote
 SCRIPT_LIB +=3D git-sh-setup
+SCRIPT_LIB +=3D git-sh-i18n
=20
 SCRIPT_PERL +=3D git-add--interactive.perl
 SCRIPT_PERL +=3D git-difftool.perl
@@ -523,6 +527,7 @@ LIB_H +=3D userdiff.h
 LIB_H +=3D utf8.h
 LIB_H +=3D xdiff-interface.h
 LIB_H +=3D xdiff/xdiff.h
+LIB_H +=3D gettext.h
=20
 LIB_OBJS +=3D abspath.o
 LIB_OBJS +=3D advice.o
@@ -564,6 +569,7 @@ LIB_OBJS +=3D entry.o
 LIB_OBJS +=3D environment.o
 LIB_OBJS +=3D exec_cmd.o
 LIB_OBJS +=3D fsck.o
+LIB_OBJS +=3D gettext.o
 LIB_OBJS +=3D graph.o
 LIB_OBJS +=3D grep.o
 LIB_OBJS +=3D hash.o
@@ -1386,6 +1392,12 @@ ifdef USE_NED_ALLOCATOR
        COMPAT_OBJS +=3D compat/nedmalloc/nedmalloc.o
 endif
=20
+ifdef NO_GETTEXT
+	COMPAT_CFLAGS +=3D -DNO_GETTEXT
+else
+	LIBINTL =3D -lintl
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK=3DNoThanks
 endif
@@ -1415,6 +1427,7 @@ ifndef V
 	QUIET_BUILT_IN =3D @echo '   ' BUILTIN $@;
 	QUIET_GEN      =3D @echo '   ' GEN $@;
 	QUIET_LNCP     =3D @echo '   ' LN/CP $@;
+	QUIET_MSGFMT   =3D @echo '   ' MSGFMT $@;
 	QUIET_SUBDIR0  =3D +@subdir=3D
 	QUIET_SUBDIR1  =3D ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
@@ -1442,7 +1455,9 @@ gitexecdir_SQ =3D $(subst ','\'',$(gitexecdir))
 template_dir_SQ =3D $(subst ','\'',$(template_dir))
 htmldir_SQ =3D $(subst ','\'',$(htmldir))
 prefix_SQ =3D $(subst ','\'',$(prefix))
+sharedir_SQ =3D $(subst ','\'',$(sharedir))
=20
+LOCALEDIR_SQ =3D $(subst ','\'',$(localedir))
 SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ =3D $(subst ','\'',$(PERL_PATH))
 PYTHON_PATH_SQ =3D $(subst ','\'',$(PYTHON_PATH))
@@ -1491,7 +1506,7 @@ ifndef NO_TCLTK
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
@@ -1536,6 +1551,7 @@ $(RM) $@ $@+ && \
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
     -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+    -e 's|@@LOCALEDIR@@|$(LOCALEDIR_SQ)|g' \
     -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
     -e $(BROKEN_PATH_FIX) \
     $@.sh >$@+
@@ -1868,6 +1884,21 @@ cscope:
 	$(RM) cscope*
 	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
=20
+pot:
+	$(XGETTEXT) --add-comments --keyword=3D_ --output=3Dpo/git.pot --lang=
uage=3DC $(C_OBJ:o=3Dc) t/t0200/test.c
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
@@ -1980,6 +2011,11 @@ install: all
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
@@ -2127,6 +2163,10 @@ ifndef NO_TCLTK
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
index 0d4b64d..a15f3c1 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -32,6 +32,7 @@ NO_CURL=3D@NO_CURL@
 NO_EXPAT=3D@NO_EXPAT@
 NO_LIBGEN_H=3D@NO_LIBGEN_H@
 HAVE_PATHS_H=3D@HAVE_PATHS_H@
+NO_GETTEXT=3D@NO_GETTEXT@
 NEEDS_LIBICONV=3D@NEEDS_LIBICONV@
 NEEDS_SOCKET=3D@NEEDS_SOCKET@
 NEEDS_RESOLV=3D@NEEDS_RESOLV@
diff --git a/configure.ac b/configure.ac
index 71038fc..7bebfd8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -730,6 +730,12 @@ AC_CHECK_HEADER([paths.h],
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
diff --git a/gettext.c b/gettext.c
new file mode 100644
index 0000000..22cdcc1
--- /dev/null
+++ b/gettext.c
@@ -0,0 +1,25 @@
+#ifdef NO_GETTEXT
+void git_setup_gettext(void) {}
+#else
+#include "exec_cmd.h"
+#include <libintl.h>
+#include <stdlib.h>
+
+void git_setup_gettext(void) {
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
+#endif
diff --git a/gettext.h b/gettext.h
new file mode 100644
index 0000000..a99da6a
--- /dev/null
+++ b/gettext.h
@@ -0,0 +1,13 @@
+#ifndef GETTEXT_H
+#define GETTEXT_H
+
+void git_setup_gettext(void);
+
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
index 0000000..d4963e9
--- /dev/null
+++ b/git-sh-i18n.sh
@@ -0,0 +1,47 @@
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
+# Try to use libintl's gettext.sh, or fall back to English if we
+# can't.
+. gettext.sh
+
+if test $? -eq 0 && test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
+then
+	TEXTDOMAIN=3Dgit
+	export TEXTDOMAIN
+	if [ -z "$GIT_TEXTDOMAINDIR" ]
+	then
+		TEXTDOMAINDIR=3D"@@LOCALEDIR@@"
+	else
+		TEXTDOMAINDIR=3D"$GIT_TEXTDOMAINDIR"
+	fi
+	export TEXTDOMAINDIR
+else
+	# Since gettext.sh isn't available we'll have to define our own
+	# dummy pass-through functions.
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
index 0000000..1b35738
--- /dev/null
+++ b/po/is.po
@@ -0,0 +1,46 @@
+msgid ""
+msgstr ""
+"Project-Id-Version: Git\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2010-06-02 17:35+0000\n"
+"PO-Revision-Date: 2010-06-02 16:01+0000\n"
+"Last-Translator: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
=2Ecom>\n"
+"Language-Team: Git Mailing List <git@vger.kernel.org>\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"X-Poedit-Language: English\n"
+"X-Poedit-SourceCharset: utf-8\n"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200-gettext/test.c:6
+msgid "TEST: A C test string"
+msgstr "TILRAUN: C tilraunastrengur"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200-gettext/test.c:9
+#, c-format
+msgid "TEST: A C test string %s"
+msgstr "TILRAUN: C tilraunastrengur %s"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200-gettext/test.sh:8
+msgid "TEST: A Shell test string"
+msgstr "TILRAUN: Skeljartilraunastrengur"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200-gettext/test.sh:11
+#, sh-format
+msgid "TEST: A Shell test $variable"
+msgstr "TILRAUN: Skeljartilraunastrengur me=C3=B0 breytunni $variable"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200-gettext/test.perl:5
+msgid "TEST: A Perl test string"
+msgstr "TILRAUN: Perl tilraunastrengur"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200-gettext/test.perl:8
+#, perl-format
+msgid "TEST: A Perl test variable %s"
+msgstr "TILRAUN: Perl tilraunastrengur me=C3=B0 breytunni %s"
diff --git a/t/t0200-gettext.sh b/t/t0200-gettext.sh
new file mode 100755
index 0000000..7eba5dd
--- /dev/null
+++ b/t/t0200-gettext.sh
@@ -0,0 +1,136 @@
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
+test_expect_success 'sanity: $TEXTDOMAIN is git' '
+    test $TEXTDOMAIN =3D "git"
+'
+
+test_expect_success 'sanity: $TEXTDOMAINDIR exists' '
+    test -d "$TEXTDOMAINDIR" &&
+    test "$TEXTDOMAINDIR" =3D "$GIT_TEXTDOMAINDIR"
+'
+
+test_expect_success 'sanity: Icelandic locale was compiled' '
+    test -f "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
+'
+
+test_expect_success 'sanity: No gettext("") data for fantasy locale' '
+    LANGUAGE=3Dis LC_ALL=3Dtlh_TLH.UTF-8 gettext "" > real-locale &&
+    test_expect_failure test -s real-locale
+'
+
+test_expect_success 'sanity: Some gettext("") data for real locale' '
+    LANGUAGE=3Dis LC_ALL=3Dis_IS.UTF-8 gettext "" > fantasy-locale &&
+    test -s fantasy-locale
+'
+
+# TODO: When we have more locales, generalize this to test them
+# all. Maybe we'll need a dir->locale map for that.
+test_expect_success 'sanity: gettext("") metadata is OK' '
+    # Return value may be non-zero
+    LANGUAGE=3Dis LC_ALL=3Dis_IS.UTF-8 gettext "" > zero-expect &&
+    grep "Project-Id-Version: Git" zero-expect &&
+    grep "Git Mailing List <git@vger.kernel.org>" zero-expect &&
+    grep "Content-Type: text/plain; charset=3DUTF-8" zero-expect &&
+    grep "Content-Transfer-Encoding: 8bit" zero-expect
+'
+
+test_expect_success 'sanity: gettext(unknown) is passed through' '
+    printf "This is not a translation string"  > expect &&
+    gettext "This is not a translation string" > actual &&
+    eval_gettext "This is not a translation string" > actual &&
+    test_cmp expect actual
+'
+
+# xgettext from C
+test_expect_success 'xgettext: C extraction' '
+    printf "TILRAUN: C tilraunastrengur" > expect &&
+    LANGUAGE=3Dis LC_ALL=3Dis_IS.UTF-8 gettext "TEST: A C test string"=
 > actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'xgettext: C extraction with %s' '
+    printf "TILRAUN: C tilraunastrengur %%s" > expect &&
+    LANGUAGE=3Dis LC_ALL=3Dis_IS.UTF-8 gettext "TEST: A C test string =
%s" > actual &&
+    test_cmp expect actual
+'
+
+# xgettext from Shell
+test_expect_success 'xgettext: Shell extraction' '
+    printf "TILRAUN: Skeljartilraunastrengur" > expect &&
+    LANGUAGE=3Dis LC_ALL=3Dis_IS.UTF-8 gettext "TEST: A Shell test str=
ing" > actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'xgettext: Shell extraction with $variable' '
+    printf "TILRAUN: Skeljartilraunastrengur me=C3=B0 breytunni a var =
i able" > x-expect &&
+    LANGUAGE=3Dis LC_ALL=3Dis_IS.UTF-8 variable=3D"a var i able" eval_=
gettext "TEST: A Shell test \$variable" > x-actual &&
+    test_cmp x-expect x-actual
+'
+
+# xgettext from Perl
+test_expect_success 'xgettext: Perl extraction' '
+    printf "TILRAUN: Perl tilraunastrengur" > expect &&
+    LANGUAGE=3Dis LC_ALL=3Dis_IS.UTF-8 gettext "TEST: A Perl test stri=
ng" > actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'xgettext: Perl extraction with %s' '
+    printf "TILRAUN: Perl tilraunastrengur me=C3=B0 breytunni %%s" > e=
xpect &&
+    LANGUAGE=3Dis LC_ALL=3Dis_IS.UTF-8 gettext "TEST: A Perl test vari=
able %s" > actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'xgettext: Perl _() strings are not extracted' '
+    test_expect_failure grep "A Perl string xgettext will not get" "$G=
IT_PO_PATH"/is.po
+'
+
+test_expect_success 'xgettext: Comment extraction with --add-comments'=
 '
+    grep "TRANSLATORS: This is a test" "$TEST_DIRECTORY"/t0200/* | wc =
-l > expect &&
+    grep "TRANSLATORS: This is a test" "$GIT_PO_PATH"/is.po  | wc -l >=
 actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'xgettext: Comment extraction with --add-comments =
stops at statements' '
+    test_expect_failure grep "This is a phony" "$GIT_PO_PATH"/is.po &&
+    test_expect_failure grep "the above comment" "$GIT_PO_PATH"/is.po
+'
+
+# Actually execute some C and Shell code that uses Gettext
+test_expect_success 'C: git-status reads our message catalog ' '
+    test_commit "some-file" &&
+    git checkout -b test/gettext &&
+    LANGUAGE=3DC LC_ALL=3DC git status | grep test/gettext > expect &&
+    echo "# On branch test/gettext" > actual &&
+    test_cmp expect actual &&
+
+    LANGUAGE=3Dis LC_ALL=3Dis_IS.UTF-8 git status | grep test/gettext =
> expect &&
+    echo "# =C3=81 greininni test/gettext" > actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'Shell: git-pull reads our message catalog' '
+    # Repository for testing
+    mkdir parent &&
+    (cd parent && git init &&
+     echo one >file && git add file &&
+     git commit -m one) &&
+
+    # Actual test
+    (cd parent &&
+    (LANGUAGE=3DC LC_ALL=3DC git pull --tags "../" >out 2>err);
+    grep "Fetching tags only" err &&
+    (LANGUAGE=3Dis LC_ALL=3Dis_IS.UTF-8 git pull --tags ../ >out 2>err=
 || :) &&
+    grep "N=C3=A6 a=C3=B0eins =C3=AD" err)
+'
+
+test_done
diff --git a/t/t0200/test.c b/t/t0200/test.c
new file mode 100644
index 0000000..9fa4c23
--- /dev/null
+++ b/t/t0200/test.c
@@ -0,0 +1,11 @@
+/* This is a phony C program that's only here to test xgettext message=
 extraction */
+
+int main(void)
+{
+	/* TRANSLATORS: This is a test. You don't need to translate it. */
+	puts(_("TEST: A C test string"));
+
+	/* TRANSLATORS: This is a test. You don't need to translate it. */
+	printf(_("TEST: A C test string %s"), "variable");
+}
+=09
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
index 0000000..b4bc1df
--- /dev/null
+++ b/t/t0201-gettext-fallbacks.sh
@@ -0,0 +1,42 @@
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
+test_expect_success 'sanity: $GIT_INTERNAL_GETTEXT_TEST_FALLBACKS is s=
et' '
+	test_expect_failure test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
+'
+
+test_expect_success 'gettext: our gettext() fallback has pass-through =
semantics' '
+    printf "test" > expect &&
+    gettext "test" > actual &&
+    test_cmp expect actual &&
+    printf "test more words" > expect &&
+    gettext "test more words" > actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'eval_gettext: our eval_gettext() fallback has pas=
s-through semantics' '
+    printf "test" > expect &&
+    eval_gettext "test" > actual &&
+    test_cmp expect actual &&
+    printf "test more words" > expect &&
+    eval_gettext "test more words" > actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'eval_gettext: our eval_gettext() fallback can int=
erpolate variables' '
+    printf "test YesPlease" > expect &&
+    eval_gettext "test \$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" > actual=
 &&
+    test_cmp expect actual
+'
+
+test_done
diff --git a/t/t0202-gettext-perl.sh b/t/t0202-gettext-perl.sh
new file mode 100755
index 0000000..9b075b1
--- /dev/null
+++ b/t/t0202-gettext-perl.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+
+test_description=3D'Perl gettext interface (Git::I18N)'
+. ./test-lib.sh
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
index 0000000..4e9a0dc
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
+    unless ($ENV{TEST_GIT_I18N_EXHAUSTIVE}) {
+        # Can't reliably test __() with a non-C locales because the
+        # required locales may not be installed on the system.
+        #
+        # We test for these anyway as part of the shell
+        # tests. Skipping these here will eliminate failures on odd
+        # platforms with incomplete locale data.
+
+        skip "Set TEST_GIT_I18N_EXHAUSTIVE=3D1 to enable exhaustive Gi=
t::I18N locale tests", 2;
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
index 454880a..cb3c9c5 100644
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
--=20
1.7.1.242.g64631
