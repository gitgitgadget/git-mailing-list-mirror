From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Add a custom ./configure script
Date: Tue, 04 Jul 2006 02:40:12 +0200
Message-ID: <20060704004012.22639.44317.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 04 03:08:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxZOc-0005Io-75
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 03:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWGDBIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 21:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWGDBIG
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 21:08:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:61113 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751345AbWGDBIF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 21:08:05 -0400
Received: (qmail 22647 invoked by uid 2089); 4 Jul 2006 02:40:13 +0200
MBOX-Line: From pasky@suse.cz Tue Jul  4 02:40:12 2006
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch adds a custom hand-made and supposedly easy to debug ./configure
script. It is originally based on mplayer's ./configure script but heavily
modified and of course stripped of all the mplayer-specific tests, as well
as many other tests we won't probably need (but we might reintroduce some
of them later). I kept the CPU checks since they might come handy to decide
which assembler SHA1 implementation to choose.

Also, I'm an autogeneration freak so compared to the mplayer's script
this one has a bit different design wrt. the configuration variables; instead
of adding random bits of code at various places you just insert one function
call near the top and your test near the bottom, everything else is taken
care of automagically. Also, the heavy machinery is split to a separate library
config-lib.sh.

It's a shame that we have to carry something like this around. Wouldn't the
world be much happier place if there would be something like autoconf but
instead of mucking with M4 you would just write a shell script while calling
various predefined functions? :/

The patch is on top of pu, that is Jakub Narebski's autoconf patch, because
it reuses most of its infrastructure and just replaces the configure script.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 .gitignore    |    6 -
 INSTALL       |    1 
 config-lib.sh |  449 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 config.mak.in |   18 --
 configure     |   78 ++++++++++
 configure.ac  |   14 --
 6 files changed, 528 insertions(+), 38 deletions(-)

diff --git a/.gitignore b/.gitignore
index 616aa98..8950a9e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -136,10 +136,6 @@ git-core.spec
 *.[ao]
 *.py[co]
 config.mak
-autom4te.cache
-config.log
-config.status
-config.mak.in
 config.mak.autogen
-configure
+config.log
 git-blame
diff --git a/INSTALL b/INSTALL
index 6c8fd09..bff6aa6 100644
--- a/INSTALL
+++ b/INSTALL
@@ -16,7 +16,6 @@ install" would not work.
 Alternatively you can use autoconf generated ./configure script to
 set up install paths (via config.mak.autogen), so you can write instead
 
-	$ autoconf ;# as yourself if ./configure doesn't exist yet
 	$ ./configure --prefix=/usr ;# as yourself
 	$ make all doc ;# as yourself
 	# make install install-doc ;# as root
diff --git a/config-lib.sh b/config-lib.sh
new file mode 100755
index 0000000..68fecc5
--- /dev/null
+++ b/config-lib.sh
@@ -0,0 +1,449 @@
+# This script provides a wannabe-generic library for compile-time package
+# autoconfiguration
+# Copyright (c) Petr Baudis, 2006
+#
+#
+# Some design traits and large chunks of this script come from mplayer:
+#
+# Original version (C) 2000 Pontscho/fresh!mindworkz
+#                      pontscho@makacs.poliod.hu
+#
+# History / Contributors: check the cvs log !
+#
+# Cleanups all over the place (c) 2001 pl
+#
+#
+# This configure script is *not* autoconf-based and has different semantics.
+# It attempts to autodetect all settings and options where possible. It is
+# possible to override autodetection with the --enable-option/--disable-option
+# command line parameters.  --enable-option forces the option on skipping
+# autodetection. Yes, this means that compilation may fail and yes, this is not
+# how autoconf-based configure scripts behave.
+#
+# configure generates config.mak.autogen, then included in the Makefile.
+#
+#############################################################################
+
+# Prevent locale nonsense from breaking basic text processing utils
+LC_ALL=C
+export LC_ALL
+
+# These macros only return an error code - NO display is done
+
+compile_check() {
+{
+	echo
+	cat "$1"
+	echo
+	echo "$_cc $CFLAGS $_inc_extra $_ld_static $_ld_extra -o $TMPO $@"
+	rm -f "$TMPO"
+	$_cc $CFLAGS $_inc_extra $_ld_static $_ld_extra -o "$TMPO" "$@" || return $?
+	echo
+	echo "ldd $TMPO"
+	$_ldd "$TMPO" || return $?
+	echo
+} >>"$TMPLOG" 2>&1
+}
+
+cc_check() {
+	compile_check $TMPC $@
+}
+
+# Try to run the compiled file
+tmp_run() {
+	"$TMPO" >> "$TMPLOG" 2>&1
+}
+
+# Display error message, flushes tempfile, exit
+die () {
+	echo
+	echo "Error: $@" >&2
+	echo >&2
+	rm -f "$TMPO" "$TMPC" "$TMPS" "$TMPCPP"
+	echo "Check \"$TMPLOG\" if you do not understand why it failed." >&2
+	exit 1
+}
+
+# OS test booleans functions
+issystem() {
+	test "`echo $system_name | tr A-Z a-z`" = "`echo $1 | tr A-Z a-z`"
+}
+linux()   { issystem "Linux"   ; return "$?" ; }
+sunos()   { issystem "SunOS"   ; return "$?" ; }
+hpux()    { issystem "HP-UX"   ; return "$?" ; }
+irix()    { issystem "IRIX"    ; return "$?" ; }
+aix()     { issystem "AIX"     ; return "$?" ; }
+cygwin()  { issystem "CYGWIN"  ; return "$?" ; }
+freebsd() { issystem "FreeBSD" ; return "$?" ; }
+netbsd()  { issystem "NetBSD"  ; return "$?" ; }
+bsdos()   { issystem "BSD/OS"  ; return "$?" ; }
+openbsd() { issystem "OpenBSD" ; return "$?" ; }
+bsd()     { freebsd || netbsd || bsdos || openbsd ; return "$?" ; }
+qnx()     { issystem "QNX"     ; return "$?" ; }
+darwin()  { issystem "Darwin"  ; return "$?" ; }
+gnu()     { issystem "GNU"     ; return "$?" ; }
+mingw32() { issystem "MINGW32" ; return "$?" ; }
+morphos() { issystem "MorphOS" ; return "$?" ; }
+win32()   { cygwin || mingw32  ; return "$?" ; }
+beos()    { issystem "BEOS"    ; return "$?" ; }
+
+# arch test boolean functions
+# x86/x86pc is used by QNX
+x86() {
+	case "$host_arch" in
+		i[3-9]86|x86|x86pc|k5|k6|k6-2|k6-3|pentium*|athlon*|i586-i686) return 0 ;;
+		*) return 1 ;;
+	esac
+}
+
+x86_64() {
+	case "$host_arch" in
+		x86_64|amd64) return 0 ;;
+		*) return 1 ;;
+	esac
+}
+
+ppc() {
+	case "$host_arch" in
+		ppc) return 0;;
+		*) return 1;;
+	esac
+}
+
+alpha() {
+	case "$host_arch" in
+		alpha) return 0;;
+		*) return 1;;
+	esac
+}
+
+# not boolean test: implement the posix shell "!" operator for a
+# non-posix /bin/sh.
+#   usage:  not {command}
+# returns exit status "success" when the execution of "command"
+# fails.
+not() {
+	eval "$@"
+	test $? -ne 0
+}
+
+# Use this before starting a check
+# The second optional parameter is name of the feature variable;
+# it is preset to an empty string so that it can be dropped into
+# config.mak.autogen seamlessly; use echores_yesno() for reporting.
+echocheck() {
+	echo "============ Checking $@ ============" >> "$TMPLOG"
+	echo ${_echo_n} "Checking $@... ${_echo_c}"
+}
+
+# Use this to echo the results of a check
+echores() {
+	if test "$_res_comment" ; then
+		_res_comment="($_res_comment)"
+	fi
+	echo "Result is: $@ $_res_comment" >> "$TMPLOG"
+	echo "##########################################" >> "$TMPLOG"
+	echo "" >> "$TMPLOG"
+	echo "$@ $_res_comment"
+	_res_comment=""
+}
+
+# Use this to introduce a regular feature with a commandline switch
+# @name is the variable name
+# @switch is the commandline switch
+# @mkvar is the Makefile variable name; prefix with a space to say that it's negated (ow)
+# @desc is a line to insert to the --help output
+# @default is the default value (yes/no/auto)
+add_library() { # --with
+	name="$1"; shift; switch="$1"; shift; mkvar="$1"; shift; default="$1"; shift; desc="$1"; shift
+	case $default in
+		yes) hdefault=with;;
+		no) hdefault=without;;
+		auto) hdefault=autodetect;;
+	esac
+
+	lib_help="$lib_help
+$desc [$hdefault]"
+	switches="$switches switch_lib \"$name\" \"$switch\" \"\$ac_option\" || "
+	mkvars="$mkvars mkvar \"\$$name\" \"$mkvar\";"
+	eval "$name=$default"
+}
+
+add_feature() { # --enable
+	name="$1"; shift; switch="$1"; shift; mkvar="$1"; shift; default="$1"; shift; desc="$1"; shift
+	case $default in
+		yes) hdefault=enable;;
+		no) hdefault=disable;;
+		auto) hdefault=autodetect;;
+	esac
+
+	feature_help="$feature_help
+$desc [$hdefault]"
+	switches="$switches switch_feature \"$name\" \"$switch\" \"\$ac_option\" || "
+	mkvars="$mkvars mkvar \"\$$name\" \"$mkvar\";"
+	eval "$name=$default"
+}
+
+lib_help=
+feature_help=
+switches=
+mkvars=
+
+
+switch_lib() {
+	name="$1"; shift; switch="$1"; shift; option="$1"; shift
+	case $option in
+		--with-$switch) eval "$name=yes";;
+		--without-$switch) eval "$name=no";;
+		*) return 1
+	esac
+	return 0
+}
+
+switch_feature() {
+	name="$1"; shift; switch="$1"; shift; option="$1"; shift
+	case $option in
+		--enable-$switch) eval "$name=yes";;
+		--disable-$switch) eval "$name=no";;
+		*) return 1
+	esac
+	return 0
+}
+
+mkvar() {
+	value="$1"; shift; mkvar="$1"; shift
+	noval=""; yesval="ConfigureYesPlease"
+	case $mkvar in
+		\ *) swap="$noval"; noval="$yesval"; yesval="$swap";;
+	esac
+	case $value in
+		auto) die "$mkvar autodetection failed";;
+		no) echo "$mkvar = $noval";;
+		yes) echo "$mkvar = $yesval";;
+		*) die "$mkvar got invalid value ''$value''";;
+	esac
+}
+
+
+#############################################################################
+
+
+# Check how echo works in this /bin/sh
+case `echo -n` in
+	-n)	_echo_n=	_echo_c='\c'	;;	# SysV echo
+	*)	_echo_n='-n '	_echo_c=	;;	# BSD echo
+esac
+
+
+process_params() {
+	_install=install
+	_cc=cc
+	test "$CC" && _cc="$CC"
+
+	for ac_option do
+		case "$ac_option" in
+		--help|-help|-h)
+			cat << EOF
+Usage: $0 [OPTIONS]...
+
+Configuration:
+  -h, --help             display this help and exit
+
+Installation directories:
+  --prefix=DIR           use this prefix for installing git [HOME]
+  --bindir=DIR           use this prefix for installing git binary
+                         [PREFIX/bin]
+  --gitexecdir=DIR       use this prefix for installing individual git command
+                         binaries [BINDIR]
+  --mandir=DIR           use this prefix for installing manpages [PREFIX/man]
+  --templatedir=DIR      use this prefix for installing configuration file
+                         templates [PREFIX/share/git-core/templates]
+  --gitpythondir=DIR     use this prefix for python libraries [PREFIX/share/git-core/python]
+
+Miscellaneous options:
+  --cc=COMPILER          use this C compiler to build MPlayer [gcc]
+  --target=PLATFORM      target platform (i386-linux, arm-linux, etc)
+  --with-install=PATH    use a custom install program (useful if your OS uses
+                         a GNU-incompatible install utility by default and
+                         you want to use GNU version)
+
+For the options below, see the top of the Makefile for more detailed
+description.
+
+Optional features:$feature_help
+
+Optional libraries:$lib_help
+
+This configure script is NOT autoconf-based, even though its output is similar.
+It will try to autodetect all configuration options. If you --enable an option
+it will be forcefully turned on, skipping autodetection. This can break
+compilation, so you need to know what you are doing.
+EOF
+			exit 0 ;;
+
+		--prefix=*)
+			_prefix=`echo $ac_option | cut -d '=' -f 2` ;;
+		--bindir=*)
+			_bindir=`echo $ac_option | cut -d '=' -f 2` ;;
+		--gitexecdir=*)
+			_gitexecdir=`echo $ac_option | cut -d '=' -f 2` ;;
+		--mandir=*)
+			_mandir=`echo $ac_option | cut -d '=' -f 2` ;;
+		--templatedir=*)
+			_templatedir=`echo $ac_option | cut -d '=' -f 2` ;;
+		--gitpythondir=*)
+			_gitpythondir=`echo $ac_option | cut -d '=' -f 2` ;;
+
+		--cc=*)
+			_cc=`echo $ac_option | cut -d '=' -f 2` ;;
+		--target=*)
+			_target=`echo $ac_option | cut -d '=' -f 2` ;;
+		--with-install=*)
+			_install=`echo $ac_option | cut -d '=' -f 2 ` ;;
+
+		*)
+			# $switches is the real bulk
+			eval "$switches { echo \"Unknown parameter: $ac_option\"; exit 1; }" || exit 1 ;;
+		esac
+	done
+
+	# Determine our OS name and CPU architecture
+	if test -z "$_target" ; then
+		# OS name
+		system_name=`uname -s 2>&1`
+		case "$system_name" in
+		Linux|FreeBSD|NetBSD|BSD/OS|OpenBSD|SunOS|QNX|Darwin|GNU|BeOS|MorphOS|AIX)
+			;;
+		IRIX*)
+			system_name=IRIX ;;
+		HP-UX*)
+			system_name=HP-UX ;;
+		[cC][yY][gG][wW][iI][nN]*)
+			system_name=CYGWIN ;;
+		MINGW32*)
+			system_name=MINGW32 ;;
+		*)
+			system_name="$system_name-UNKNOWN" ;;
+		esac
+
+
+		# host's CPU/instruction set
+		host_arch=`uname -p 2>&1`
+		case "$host_arch" in
+		i386|sparc|ppc|alpha|arm|mips|vax)
+			;;
+		powerpc) # Darwin returns 'powerpc'
+			host_arch=ppc ;;
+		*)	# uname -p on Linux returns 'unknown' for the processor type,
+			# OpenBSD returns 'Intel Pentium/MMX ("Genuine Intel" 586-class)'
+
+			# Maybe uname -m (machine hardware name) returns something we
+			# recognize.
+
+			# x86/x86pc is used by QNX
+			case "`uname -m 2>&1`" in
+				i[3-9]86*|x86|x86pc|k5|k6|k6_2|k6_3|k6-2|k6-3|pentium*|athlon*|i586_i686|i586-i686|BePC) host_arch=i386 ;;
+				ia64) host_arch=ia64 ;;
+				x86_64|amd64)
+				if [ -n "`$_cc -dumpmachine | sed -n '/^x86_64-/p;/^amd64-/p'`" -a \
+					-z "`echo $CFLAGS | grep -- -m32`"  ]; then
+					host_arch=x86_64
+				else
+					host_arch=i386
+				fi
+				;;
+				macppc|ppc|ppc64) host_arch=ppc ;;
+				alpha) host_arch=alpha ;;
+				sparc) host_arch=sparc ;;
+				sparc64) host_arch=sparc64 ;;
+				parisc*|hppa*|9000*) host_arch=hppa ;;
+				arm*|zaurus|cats) host_arch=arm ;;
+				s390) host_arch=s390 ;;
+				s390x) host_arch=s390x ;;
+				mips*) host_arch=mips ;;
+				vax) host_arch=vax ;;
+				*) host_arch=UNKNOWN ;;
+			esac
+			;;
+		esac
+	else # if test -z "$_target"
+		system_name=`echo $_target | cut -d '-' -f 2`
+		case "`echo $system_name | tr A-Z a-z`" in
+			linux) system_name=Linux ;;
+			freebsd) system_name=FreeBSD ;;
+			netbsd) system_name=NetBSD ;;
+			bsd/os) system_name=BSD/OS ;;
+			openbsd) system_name=OpenBSD ;;
+			sunos) system_name=SunOS ;;
+			qnx) system_name=QNX ;;
+			morphos) system_name=MorphOS ;;
+			mingw32msvc) system_name=MINGW32 ;;
+		esac
+		# We need to convert underscores so that values like k6-2 and pentium-mmx can be passed
+		host_arch=`echo $_target | cut -d '-' -f 1 | tr '_' '-'`
+	fi
+
+	echo "Detected operating system: $system_name"
+	echo "Detected host architecture: $host_arch"
+}
+
+
+test_setup() {
+	# LGB: temporary files
+	# FIXME: Use mktemp -d?
+	for I in "$TMPDIR" "$TEMPDIR" "/tmp" ; do
+		test "$I" && break
+	done
+
+	TMPLOG="config.log"
+	rm -f "$TMPLOG"
+	TMPC="$I/git-conf-$RANDOM-$$.c"
+	TMPO="$I/git-conf-$RANDOM-$$.o"
+	TMPS="$I/git-conf-$RANDOM-$$.S"
+}
+
+basic_tests() {
+	echocheck "if your build environment is sane"
+	cat > $TMPC <<EOF
+int main(void) { return 0; }
+EOF
+	{ cc_check && tmp_run; } || die "unusable compiler or produced binary"
+	echores yes
+}
+
+
+write_config() {
+	echo "Creating config.mak.autogen"
+
+	{
+		cat << EOF
+# -------- Generated by configure -----------
+
+CC = $_cc
+INSTALL = $_install
+
+EOF
+		test -z $_prefix || echo "prefix = $_prefix"
+		test -z $_bindir || echo "bindir = $_bindir"
+		test -z $_gitexecdir || echo "gitexecdir = $_gitexecdir"
+		test -z $_mandir || ( echo "mandir = $_mandir" && echo "export mandir" )
+		test -z $_templatedir || echo "template_dir = $_templatedir"
+		test -z $_gitpythondir || echo "GIT_PYTHON_DIR = $_gitpythondir"
+		echo
+		eval "$mkvars"
+	} > config.mak.autogen
+
+	cat << EOF
+
+Config files successfully generated by ./configure.
+You can inspect the results in \`\`./config.mak.autogen''.
+EOF
+}
+
+
+finish() {
+	# Last move:
+	rm -f "$TMPO" "$TMPC" "$TMPS" "$TMPCPP"
+}
+
+trap finish 0
diff --git a/config.mak.in b/config.mak.in
deleted file mode 100644
index 82c9781..0000000
--- a/config.mak.in
+++ /dev/null
@@ -1,18 +0,0 @@
-# git Makefile configuration, included in main Makefile
-# @configure_input@
-
-prefix = @prefix@
-exec_prefix = @exec_prefix@
-bindir = @bindir@
-#gitexecdir = @libexecdir@/git-core/
-template_dir = @datadir@/git-core/templates/
-GIT_PYTHON_DIR = @datadir@/git-core/python
-
-mandir=@mandir@
-
-srcdir = @srcdir@
-VPATH = @srcdir@
-
-export exec_prefix mandir
-export srcdir VPATH
-
diff --git a/configure b/configure
new file mode 100755
index 0000000..2604aa3
--- /dev/null
+++ b/configure
@@ -0,0 +1,78 @@
+#! /bin/sh
+#
+# This configure script is *not* autoconf-based and has different semantics.
+# It attempts to autodetect all settings and options where possible. It is
+# possible to override autodetection with the --enable-option/--disable-option
+# command line parameters.  --enable-option forces the option on skipping
+# autodetection. Yes, this means that compilation may fail and yes, this is not
+# how autoconf-based configure scripts behave.
+#
+# configure generates config.mak.autogen, then included in the Makefile.
+#
+# If you want to add a new check for $feature, add it at two places - to the
+# variable list and to the checks section. You will find both below.
+#
+#############################################################################
+
+[ -f ./config-lib.sh ] || {
+	echo "config-lib.sh not found; please run ./configure from the source tree" >&2
+	exit 1
+}
+. ./config-lib.sh
+
+
+
+#############################################################################
+
+# List variables for features and libraries here:
+
+add_feature "_no_symlink_head" "no-symlink-head" "NO_SYMLINK_HEAD" "auto" \
+"  --enable-no-symlink-head  Never have .git/HEAD as a symbolic link"
+
+add_feature "_nsec" "nsec" "USE_NSEC" "no" \
+"  --enable-nsec          Use sub-second resolution when checking mtimes"
+
+add_library "_expat" "expat" " NO_EXPAT" "auto" \
+"  --without-expat        Disable libexpat support (disables git-http-push)"
+
+
+#############################################################################
+
+
+process_params "$@"
+test_setup
+basic_tests
+
+
+#############################################################################
+
+
+echocheck "whether to prohibit usage of symlinked HEAD"
+if test "$_no_symlink_head" = auto ; then
+	if win32; then
+		_no_symlink_head=yes
+	else
+		_no_symlink_head=no
+	fi
+fi
+echores "$_no_symlink_head"
+
+
+echocheck "for expat"
+if test "$_expat" = auto ; then
+	cat > $TMPC <<EOF
+#include <expat.h>
+int main(void) { return 0; }
+EOF
+	_expat=no
+	cc_check -lexpat && _expat=yes
+fi
+echores "$_expat"
+
+
+# Insert tests for features and libraries here.
+
+#############################################################################
+
+
+write_config
diff --git a/configure.ac b/configure.ac
deleted file mode 100644
index a0374d4..0000000
--- a/configure.ac
+++ /dev/null
@@ -1,14 +0,0 @@
-#                                               -*- Autoconf -*-
-# Process this file with autoconf to produce a configure script.
-
-AC_PREREQ(2.59)
-AC_INIT([git], [1.4.1], [git@vger.kernel.org])
-
-AC_CONFIG_SRCDIR([git.c])
-
-config_file=config.mak.autogen
-config_in=config.mak.in
-
-# Output files
-AC_CONFIG_FILES(["${config_file}":"${config_in}"])
-AC_OUTPUT
