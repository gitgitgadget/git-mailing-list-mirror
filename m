From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH 3/4] configure: Try to figure out compiler options
Date: Fri, 07 Jul 2006 18:26:42 +0200
Message-ID: <20060707162642.25746.3676.stgit@leonov.stosberg.net>
References: <20060707162513.25746.57374.stgit@leonov.stosberg.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Jul 07 18:27:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FytAJ-0000c8-Lx
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 18:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWGGQ0q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 12:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWGGQ0q
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 12:26:46 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:695 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S932198AbWGGQ0p (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 12:26:45 -0400
Received: from leonov.stosberg.net (p213.54.86.102.tisdip.tiscali.de [213.54.86.102])
	by ncs.stosberg.net (Postfix) with ESMTP id CE3BFAEBA00D
	for <git@vger.kernel.org>; Fri,  7 Jul 2006 18:26:35 +0200 (CEST)
Received: from leonov.stosberg.net (localhost [127.0.0.1])
	by leonov.stosberg.net (Postfix) with ESMTP id A1A4A1149FF
	for <git@vger.kernel.org>; Fri,  7 Jul 2006 18:26:42 +0200 (CEST)
To: git@vger.kernel.org
In-Reply-To: <20060707162513.25746.57374.stgit@leonov.stosberg.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23446>

From: Dennis Stosberg <dennis@stosberg.net>

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
index 3968245..0bcd4c3 100755
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
@@ -283,7 +283,7 @@ Installation directories:
   --gitpythondir=DIR     use this prefix for python libraries [PREFIX/share/git-core/python]
 
 Miscellaneous options:
-  --cc=COMPILER          use this C compiler to build MPlayer [gcc]
+  --cc=COMPILER          use this C compiler to build Git [cc]
   --perl=PATH            path to perl binary [autodetect]
   --python=PATH          path to python binary [autodetect]
   --target=PLATFORM      target platform (i386-linux, arm-linux, etc)
@@ -373,8 +373,8 @@ EOF
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
@@ -430,7 +430,51 @@ test_setup() {
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
@@ -483,6 +527,8 @@ write_config() {
 # -------- Generated by configure -----------
 
 CC = $_cc
+CFLAGS = $_cflags
+PICFLAG = $_picflag
 PERL_PATH = $_perl
 INSTALL = $_install
 
