From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH 2/4] configure: Add test for Python
Date: Fri, 07 Jul 2006 18:26:40 +0200
Message-ID: <20060707162640.25746.45482.stgit@leonov.stosberg.net>
References: <20060707162513.25746.57374.stgit@leonov.stosberg.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Jul 07 18:27:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FytAK-0000c8-85
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 18:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWGGQ0p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 12:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWGGQ0o
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 12:26:44 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:65206 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S932198AbWGGQ0o (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 12:26:44 -0400
Received: from leonov.stosberg.net (p213.54.86.102.tisdip.tiscali.de [213.54.86.102])
	by ncs.stosberg.net (Postfix) with ESMTP id 45635AEBA004
	for <git@vger.kernel.org>; Fri,  7 Jul 2006 18:26:33 +0200 (CEST)
Received: from leonov.stosberg.net (localhost [127.0.0.1])
	by leonov.stosberg.net (Postfix) with ESMTP id 6F3A21149B7
	for <git@vger.kernel.org>; Fri,  7 Jul 2006 18:26:40 +0200 (CEST)
To: git@vger.kernel.org
In-Reply-To: <20060707162513.25746.57374.stgit@leonov.stosberg.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23447>

From: Dennis Stosberg <dennis@stosberg.net>

The test tries to find the path to a suitable Python binary.  The
user can override the auto-detection with the --python parameter
or with the PYTHON environment variable.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---

 config-lib.sh |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/config-lib.sh b/config-lib.sh
index 34dfc05..3968245 100755
--- a/config-lib.sh
+++ b/config-lib.sh
@@ -259,6 +259,9 @@ process_params() {
 	_perl=
 	test "$PERL" && _perl="$PERL"
 
+	_python=
+	test "$PYTHON" && _python="$PYTHON"
+
 	for ac_option do
 		case "$ac_option" in
 		--help|-help|-h)
@@ -282,6 +285,7 @@ Installation directories:
 Miscellaneous options:
   --cc=COMPILER          use this C compiler to build MPlayer [gcc]
   --perl=PATH            path to perl binary [autodetect]
+  --python=PATH          path to python binary [autodetect]
   --target=PLATFORM      target platform (i386-linux, arm-linux, etc)
   --with-install=PATH    use a custom install program (useful if your OS uses
                          a GNU-incompatible install utility by default and
@@ -318,6 +322,8 @@ EOF
 			_cc=`echo $ac_option | cut -d '=' -f 2` ;;
 		--perl=*)
 			_perl=`echo $ac_option | cut -d '=' -f 2` ;;
+		--python=*)
+			_python=`echo $ac_option | cut -d '=' -f 2` ;;
 		--target=*)
 			_target=`echo $ac_option | cut -d '=' -f 2` ;;
 		--with-install=*)
@@ -445,6 +451,28 @@ EOF
 		die "your perl is too old. Perl 5.6.0 or newer is required."
 	fi
 	echores "$_perl_version"
+
+	echocheck "for python"
+	for _py_bin in python python2.4 python2.3; do
+		test "$_python" && continue
+
+		_candidate=`path_find $_py_bin`
+		test "$_candidate" || continue
+
+		$_candidate - <<EOF || continue
+import sys
+v = sys.version_info
+if v < (2, 3):
+    sys.exit(1)
+EOF
+		_python=$_candidate
+	done
+	if test "$_python"; then
+		echores "$_python"
+	else
+		_no_python="ConfigureYesPlease"
+		echores "not found"
+	fi
 }
 
 write_config() {
@@ -465,6 +493,10 @@ EOF
 		test -z $_mandir || ( echo "mandir = $_mandir" && echo "export mandir" )
 		test -z $_templatedir || echo "template_dir = $_templatedir"
 		test -z $_gitpythondir || echo "GIT_PYTHON_DIR = $_gitpythondir"
+
+		test -z $_python || echo "PYTHON_PATH = $_python"
+		test -z $_no_python || echo "NO_PYTHON = $_no_python"
+
 		echo
 		eval "$mkvars"
 	} > config.mak.autogen
