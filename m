From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] Add autoconf-based build infrastructure for tig
Date: Sun, 3 Jun 2007 12:35:21 -0700
Message-ID: <20070603193521.GA10161@midwinter.com>
References: <20070531215508.GB9260@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 21:35:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuvrN-0005SI-FX
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 21:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbXFCTfW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 15:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbXFCTfW
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 15:35:22 -0400
Received: from tater.midwinter.com ([216.32.86.90]:51942 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750837AbXFCTfV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 15:35:21 -0400
Received: (qmail 10397 invoked by uid 1001); 3 Jun 2007 19:35:21 -0000
Content-Disposition: inline
In-Reply-To: <20070531215508.GB9260@diku.dk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49026>

---
	This is a first cut at building tig using autoconf. I'm including
	a script to run the various autoconf tools rather than packaging
	up a finished configure script. With this patch, tig configures
	and builds on both Linux (FC4) and OS X. I left a lot of the code
	from the original Makefile intact so as to (hopefully) not mess
	up building release tarballs, etc.

 INSTALL                 |    8 +++---
 Makefile => Makefile.am |   44 +++++--------------------------------
 autoconf.sh             |   24 ++++++++++++++++++++
 configure.ac            |   55 +++++++++++++++++++++++++++++++++++++++++++++++
 tig.c                   |   14 ++++++-----
 version.sh              |   23 +++++++++++++++++++
 6 files changed, 120 insertions(+), 48 deletions(-)
 rename Makefile => Makefile.am (75%)
 create mode 100755 autoconf.sh
 create mode 100644 configure.ac
 create mode 100644 version.sh

diff --git a/INSTALL b/INSTALL
index 586878e..db7dcbf 100644
--- a/INSTALL
+++ b/INSTALL
@@ -8,16 +8,16 @@ available either in the tarballs or in the above repository in the branch named
 
 To install tig simply run:
 
+	$ sh autoconf.sh
+	$ ./configure
 	$ make install
 
 To install documentation run:
 
 	$ make install-doc
 
-Edit the Makefile if you need to configure specific compiler or linker flags.
-On FreeBSD for example the c library does not support the iconv interface and
-to compile tig you need to append `-L/usr/local/lib -liconv` to `LDLIBS` and
-`-I/usr/local/include` to the `CFLAGS` variable.
+If you had to install your own copy of libiconv, you'll probably want to pass
+the "--with-libiconv" option to the "configure" script to tell it where to look.
 
 The following tools and packages are needed:
 
diff --git a/Makefile b/Makefile.am
similarity index 75%
rename from Makefile
rename to Makefile.am
index 91cb097..9f146f9 100644
--- a/Makefile
+++ b/Makefile.am
@@ -1,48 +1,18 @@
-prefix	= $(HOME)
-bindir	= $(prefix)/bin
-mandir	= $(prefix)/man
-docdir	= $(prefix)/share/doc
-# DESTDIR=
-
-# Get version either via git or from VERSION file. Allow either
-# to be overwritten by setting DIST_VERSION on the command line.
-ifneq (,$(wildcard .git))
-GITDESC	= $(subst tig-,,$(shell git describe))
-WTDIRTY	= $(if $(shell git-diff-index HEAD 2>/dev/null),-dirty)
-VERSION	= $(GITDESC)$(WTDIRTY)
-else
-VERSION	= $(shell test -f VERSION && cat VERSION || echo "unknown-version")
-endif
-ifdef DIST_VERSION
-VERSION = $(DIST_VERSION)
-endif
-
-RPM_VERSION = $(subst -,.,$(VERSION))
-
-LDLIBS	= -lcurses
-CFLAGS	= -Wall -O2
-DFLAGS	= -g -DDEBUG -Werror
-PROGS	= tig
+AM_CPPFLAGS = -DTIG_VERSION=\"`sh version.sh`\"
+AM_CFLAGS = -Wall -O2
+
+bin_PROGRAMS = tig
+tig_SOURCES = tig.c
+
 MANDOC	= tig.1 tigrc.5
 HTMLDOC = tig.1.html tigrc.5.html manual.html README.html
 ALLDOC	= $(MANDOC) $(HTMLDOC) manual.html-chunked manual.pdf
 TARNAME	= tig-$(RPM_VERSION)
 
-override CFLAGS += '-DVERSION="$(VERSION)"'
-
-all: $(PROGS)
-all-debug: $(PROGS)
-all-debug: CFLAGS += $(DFLAGS)
 doc: $(ALLDOC)
 doc-man: $(MANDOC)
 doc-html: $(HTMLDOC)
 
-install: all
-	mkdir -p $(DESTDIR)$(bindir) && \
-	for prog in $(PROGS); do \
-		install -p -m 0755 $$prog $(DESTDIR)$(bindir); \
-	done
-
 install-doc-man: doc-man
 	mkdir -p $(DESTDIR)$(mandir)/man1 \
 		 $(DESTDIR)$(mandir)/man5
@@ -107,8 +77,6 @@ release-dist: release-doc
 tig.spec: tig.spec.in
 	sed -e 's/@@VERSION@@/$(RPM_VERSION)/g' < $< > $@
 
-tig: tig.c
-
 manual.html: manual.toc
 manual.toc: manual.txt
 	sed -n '/^\[\[/,/\(---\|~~~\)/p' < $< | while read line; do \
diff --git a/autoconf.sh b/autoconf.sh
new file mode 100755
index 0000000..5492de0
--- /dev/null
+++ b/autoconf.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+echo "aclocal..."
+ACLOCAL=${ACLOCAL:-aclocal-1.9}
+$ACLOCAL || aclocal-1.7 || aclocal-1.5 || aclocal || exit 1
+
+echo "autoheader..."
+AUTOHEADER=${AUTOHEADER:-autoheader}
+$AUTOHEADER || exit 1
+
+echo "automake..."
+# shut automake up about missing files
+touch missing NEWS AUTHORS ChangeLog
+AUTOMAKE=${AUTOMAKE:-automake-1.9}
+$AUTOMAKE --add-missing --foreign || 
+	automake-1.7 --add-missing --foreign || 
+	automake --add-missing --foreign || 
+	exit 1
+rm missing NEWS AUTHORS ChangeLog
+
+echo "autoconf..."
+AUTOCONF=${AUTOCONF:-autoconf}
+$AUTOCONF || exit 1
+
diff --git a/configure.ac b/configure.ac
new file mode 100644
index 0000000..2cdb320
--- /dev/null
+++ b/configure.ac
@@ -0,0 +1,55 @@
+AC_INIT([tig], [0],
+	[Jonas Fonesca <fonesca@diku.dk>],
+	[tig])
+AC_LANG([C])
+AM_CONFIG_HEADER(config.h)
+AC_CONFIG_SRCDIR(tig.c)
+AM_INIT_AUTOMAKE([no-dist])
+
+AC_ARG_WITH(libiconv,
+        AC_HELP_STRING([--with-libiconv=DIRECTORY],[base directory for libiconv]))
+if test "$with_libiconv" != ""
+then
+	CFLAGS="$CFLAGS -I$with_libiconv/include"
+	LDFLAGS="$LDFLAGS -L$with_libiconv/lib"
+fi
+
+dnl
+dnl See if we need to link with -liconv to get the iconv() function.
+dnl
+AC_SEARCH_LIBS([iconv], [iconv])
+AC_SEARCH_LIBS([wclear], [ncurses])
+
+if test "$ac_cv_search_iconv" = "no"
+then
+	AC_MSG_FAILURE([iconv() not found. Please install libiconv.],[1])
+fi
+
+dnl
+dnl See if iconv() requires a const char ** for the input buffer.
+dnl
+if test "$GCC" = "yes"
+then
+	OLD_CFLAGS="$CFLAGS"
+	CFLAGS="$CFLAGS -Werror"
+	AC_MSG_CHECKING([whether iconv needs const char **])
+	AC_COMPILE_IFELSE(
+		[AC_LANG_PROGRAM([[#include <iconv.h>]],
+				 [[char **buf;
+				   size_t *size;
+				   iconv_t cd;
+				   iconv(cd, buf, size, buf, size);]])],
+		[AC_DEFINE([ICONV_INBUF_TYPE],[char *],
+			   [Type of iconv() input buffer])
+		 AC_MSG_RESULT([no])],
+		[AC_DEFINE([ICONV_INBUF_TYPE],[const char *],
+			   [Type of iconv() input buffer])
+		 AC_MSG_RESULT([yes])])
+	CFLAGS="$OLD_CFLAGS"
+fi
+
+AC_PROG_CC
+AC_PROG_INSTALL
+
+AC_CONFIG_FILES([Makefile])
+AC_OUTPUT
diff --git a/tig.c b/tig.c
index 6adfb33..6648c4e 100644
--- a/tig.c
+++ b/tig.c
@@ -11,8 +11,8 @@
  * GNU General Public License for more details.
  */
 
-#ifndef VERSION
-#define VERSION "unknown-version"
+#ifndef TIG_VERSION
+#define TIG_VERSION "unknown-version"
 #endif
 
 #ifndef DEBUG
@@ -40,6 +40,8 @@
 
 #include <curses.h>
 
+#include "config.h"
+
 #if __GNUC__ >= 3
 #define __NORETURN __attribute__((__noreturn__))
 #else
@@ -388,7 +390,7 @@ get_request(const char *name)
  */
 
 static const char usage[] =
-"tig " VERSION " (" __DATE__ ")\n"
+"tig " TIG_VERSION " (" __DATE__ ")\n"
 "\n"
 "Usage: tig [options]\n"
 "   or: tig [options] [--] [git log options]\n"
@@ -513,7 +515,7 @@ parse_options(int argc, char *argv[])
 		}
 
 		if (check_option(opt, 'v', "version", OPT_NONE)) {
-			printf("tig version %s\n", VERSION);
+			printf("tig version %s\n", TIG_VERSION);
 			return FALSE;
 		}
 
@@ -1918,7 +1920,7 @@ update_view(struct view *view)
 			line[linelen - 1] = 0;
 
 		if (opt_iconv != ICONV_NONE) {
-			char *inbuf = line;
+			ICONV_INBUF_TYPE inbuf = line;
 			size_t inlen = linelen;
 
 			char *outbuf = out_buffer;
@@ -2245,7 +2247,7 @@ view_driver(struct view *view, enum request request)
 		break;
 
 	case REQ_SHOW_VERSION:
-		report("tig-%s (built %s)", VERSION, __DATE__);
+		report("tig-%s (built %s)", TIG_VERSION, __DATE__);
 		return TRUE;
 
 	case REQ_SCREEN_RESIZE:
diff --git a/version.sh b/version.sh
new file mode 100644
index 0000000..2519876
--- /dev/null
+++ b/version.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+if [ -n "$DIST_VERSION" ]
+then
+	echo "$DIST_VERSION"
+	exit 0
+else
+	if [ -d .git ]
+	then
+		GITDESC="`git describe | sed s/tig-//`"
+		if git-diff-index HEAD 2> /dev/null > /dev/null
+		then
+			WTDIRTY="-dirty"
+		fi
+		echo $GITDESC$WTDIRTY
+	else
+		if [ -f VERSION ]
+		then
+			cat VERSION
+		else
+			echo "unknown-version"
+		fi
+	fi
+fi
-- 
1.5.2.35.ga334
