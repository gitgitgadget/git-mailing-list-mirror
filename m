From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH 3/3] configure: Try to figure out compiler options
Date: Thu, 6 Jul 2006 14:41:24 +0200
Message-ID: <20060706124124.G1358ce5f@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jul 06 14:41:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyTAg-0000ew-MO
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 14:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWGFMl2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 08:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbWGFMl1
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 08:41:27 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:15305 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S965192AbWGFMl1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jul 2006 08:41:27 -0400
Received: from leonov.stosberg.net (p213.54.86.66.tisdip.tiscali.de [213.54.86.66])
	by ncs.stosberg.net (Postfix) with ESMTP id 8D6E8AEBA004
	for <git@vger.kernel.org>; Thu,  6 Jul 2006 14:41:19 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 6014B103B3F; Thu,  6 Jul 2006 14:41:24 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
Received: from leonov ([unix socket]) by leonov (Cyrus v2.1.18-IPv6-Debian-2.1.18-1+sarge2) with LMTP; Thu, 06 Jul 2006 14:18:52 +0200
X-Sieve: CMU Sieve 2.2
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23384>

This patch adds tests to determine of what flavour the used
compiler is and sets CFLAGS and the PIC flag appropriately.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---
 Makefile      |    3 ++-
 config-lib.sh |   56 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 4dc5379..23c784e 100644
--- a/Makefile
+++ b/Makefile
@@ -96,6 +96,7 @@ ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 PERL_CFLAGS =
 PERL_LDFLAGS =
+PICFLAG = -fPIC
 STRIP ?= strip
 
 prefix = $(HOME)
@@ -483,7 +484,7 @@ endif
 endif
 endif
 ifdef USE_PIC
-	ALL_CFLAGS += -fPIC
+	ALL_CFLAGS += $(PICFLAG)
 endif
 ifdef NO_ACCURATE_DIFF
 	BASIC_CFLAGS += -DNO_ACCURATE_DIFF
diff --git a/config-lib.sh b/config-lib.sh
index 50ad6e9..6000ec9 100755
--- a/config-lib.sh
+++ b/config-lib.sh
@@ -35,9 +35,9 @@ compile_check() {
 	echo
 	cat "$1"
 	echo
-	echo "$_cc $CFLAGS $_inc_extra $_ld_static $_ld_extra -o $TMPO $@"
+	echo "$_cc $_cflags $_inc_extra $_ld_static $_ld_extra -o $TMPO $@"
 	rm -f "$TMPO"
-	$_cc $CFLAGS $_inc_extra $_ld_static $_ld_extra -o "$TMPO" "$@" || return $?
+	$_cc $_cflags $_inc_extra $_ld_static $_ld_extra -o "$TMPO" "$@" || return $?
 	echo
 	echo "ldd $TMPO"
 	$_ldd "$TMPO" || return $?
@@ -261,7 +261,7 @@ Installation directories:
   --gitpythondir=DIR     use this prefix for python libraries [PREFIX/share/git-core/python]
 
 Miscellaneous options:
-  --cc=COMPILER          use this C compiler to build MPlayer [gcc]
+  --cc=COMPILER          use this C compiler to build Git [cc]
   --perl=PATH            path to perl binary [autodetect]
   --python=PATH          path to python binary [autodetect]
   --target=PLATFORM      target platform (i386-linux, arm-linux, etc)
@@ -351,8 +351,8 @@ EOF
 				i[3-9]86*|x86|x86pc|k5|k6|k6_2|k6_3|k6-2|k6-3|pentium*|athlon*|i586_i686|i586-i686|BePC) host_arch=i386 ;;
 				ia64) host_arch=ia64 ;;
 				x86_64|amd64)
-				if [ -n "`$_cc -dumpmachine | sed -n '/^x86_64-/p;/^amd64-/p'`" -a \
-					-z "`echo $CFLAGS | grep -- -m32`"  ]; then
+				if [ -n "`$_cc -dumpmachine 2>/dev/null | sed -n '/^x86_64-/p;/^amd64-/p'`" -a \
+					-z "`echo $_cflags | grep -- -m32`"  ]; then
 					host_arch=x86_64
 				else
 					host_arch=i386
@@ -408,7 +408,51 @@ test_setup() {
 	TMPS="$I/git-conf-$RANDOM-$$.S"
 }
 
+cc_flavour() {
+
+	echocheck "whether cc is GCC"
+	cat > $TMPC <<EOF
+#ifndef __GNUC__
+#error Not GCC
+#endif
+int main(void) { return 0; }
+EOF
+	if cc_check ; then
+		echores "yes"
+		_cc_flavour="gcc"
+		return
+	fi
+	echores "no"
+
+	echocheck "whether cc is Sun CC"
+	cat > $TMPC <<EOF
+#ifndef __SUNPRO_C
+#error Not SUN CC
+#endif
+int main(void) { return 0; }
+EOF
+	if cc_check ; then
+		echores "yes"
+		_cc_flavour="suncc"
+		return
+	fi
+	echores "no"
+}
+
 basic_tests() {
+	_cc_flavour=unknown
+	cc_flavour
+
+	if test "$_cc_flavour" = "gcc" ; then
+		_cflags="-g -O2 -Wall"
+		_picflag="-fPIC"
+	elif test "$_cc_flavour" = "suncc"; then
+		_cflags="-g -xO3"
+		_picflag="-KPIC"
+	fi
+	test "$CFLAGS" && _cflags="$CFLAGS"
+	test "$PICFLAG" && _picflag="$PICFLAG"
+
 	echocheck "if your build environment is sane"
 	cat > $TMPC <<EOF
 int main(void) { return 0; }
@@ -457,6 +501,8 @@ write_config() {
 # -------- Generated by configure -----------
 
 CC = $_cc
+CFLAGS = $_cflags
+PICFLAG = $_picflag
 PERL_PATH = $_perl
 PYTHON_PATH = $_python
 INSTALL = $_install
-- 
1.4.1
