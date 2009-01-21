From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2 v2] Add valgrind support in test scripts
Date: Wed, 21 Jan 2009 02:10:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901210209580.19014@racer>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net>
 <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302> <20090121001219.GA18169@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 02:11:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPRcy-0002WY-2T
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 02:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757738AbZAUBKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 20:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757431AbZAUBKG
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 20:10:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:37969 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757306AbZAUBKF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 20:10:05 -0500
Received: (qmail invoked by alias); 21 Jan 2009 01:10:03 -0000
Received: from pD9EB302D.dip0.t-ipconnect.de (EHLO noname) [217.235.48.45]
  by mail.gmx.net (mp043) with SMTP; 21 Jan 2009 02:10:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18dXvRhBhsdqpPj+E0tVSTzsCEW9BFuh3AHyhHWQ/
	925lGrrkUIM144
X-X-Sender: gene099@racer
In-Reply-To: <20090121001219.GA18169@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106552>


This patch adds the ability to use valgrind's memcheck tool to
diagnose memory problems in git while running the test scripts. It
works by placing a "fake" git in the front of the test script's PATH;
this fake git runs the real git under valgrind. It also points the
exec-path such that any stand-alone dashed git programs are run using
the same script. In this way we avoid having to modify the actual git
code in any way.

To be certain that every call to any git executable is intercepted,
the PATH is searched for executables beginning with "git-"; Scripts
are excluded however.

Valgrind can be used by specifying "GIT_TEST_OPTS=--valgrind" in the
make invocation. Any invocation of git that finds any errors under
valgrind will exit with failure code 126. Any valgrind output will go
to the usual stderr channel for tests (i.e., /dev/null, unless -v has
been specified).

If you need to pass options to valgrind -- you might want to run
another tool than memcheck, for example -- you can set the environment
variable GIT_VALGRIND_OPTIONS.

A few default suppressions are included, since libz seems to
trigger quite a few false positives. We'll assume that libz
works and that we can ignore any errors which are reported
there.

Initial patch and all the hard work by Jeff King.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Changes vs v1:

	- the symlinks will be created in t/valgrind/bin/ again, as it is
	  easier to remove the whole directory than weed out the unwanted
	  files from t/valgrind/.

	- symbolic links are inspected for correct targets now, and if they
	  point somewhere else than expected, they are removed (this can
	  error out if the file could not be removed) and recreated.

	- if the executable ends in ".sh" or ".perl", the target will be
	  set to a non-existing file (to catch invocations, erroring out).

	- the Git binaries from the root are actually found now (IFS is
	  only interpreted after the file is parsed, it seems).

	- added rudimentary documentation to t/README.

	Interdiff to follow.

 t/README                |    6 ++++-
 t/test-lib.sh           |   49 +++++++++++++++++++++++++++++++++++++++++++++-
 t/valgrind/.gitignore   |    1 +
 t/valgrind/default.supp |   21 ++++++++++++++++++++
 t/valgrind/valgrind.sh  |   12 +++++++++++
 5 files changed, 86 insertions(+), 3 deletions(-)
 create mode 100644 t/valgrind/.gitignore
 create mode 100644 t/valgrind/default.supp
 create mode 100755 t/valgrind/valgrind.sh

diff --git a/t/README b/t/README
index 8f12d48..0cee429 100644
--- a/t/README
+++ b/t/README
@@ -39,7 +39,8 @@ this:
     * passed all 3 test(s)
 
 You can pass --verbose (or -v), --debug (or -d), and --immediate
-(or -i) command line argument to the test.
+(or -i) command line argument to the test, or by setting GIT_TEST_OPTS
+appropriately before running "make".
 
 --verbose::
 	This makes the test more verbose.  Specifically, the
@@ -58,6 +59,9 @@ You can pass --verbose (or -v), --debug (or -d), and --immediate
 	This causes additional long-running tests to be run (where
 	available), for more exhaustive testing.
 
+--valgrind::
+	Execute all Git binaries with valgrind and stop on errors (the
+	exit code will be 126).
 
 Skipping Tests
 --------------
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 79f69de..f031905 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -94,6 +94,8 @@ do
 	--no-python)
 		# noop now...
 		shift ;;
+	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind)
+		valgrind=t; shift ;;
 	*)
 		break ;;
 	esac
@@ -480,8 +482,51 @@ test_done () {
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
 TEST_DIRECTORY=$(pwd)
-PATH=$TEST_DIRECTORY/..:$PATH
-GIT_EXEC_PATH=$(pwd)/..
+if test -z "$valgrind"
+then
+	PATH=$TEST_DIRECTORY/..:$PATH
+	GIT_EXEC_PATH=$TEST_DIRECTORY/..
+else
+	# override all git executables in PATH and TEST_DIRECTORY/..
+	GIT_VALGRIND=$TEST_DIRECTORY/valgrind/bin
+	mkdir -p "$GIT_VALGRIND"
+	OLDIFS=$IFS
+	IFS=:
+	for path in $PATH $TEST_DIRECTORY/..
+	do
+		ls "$path"/git "$path"/git-* 2> /dev/null |
+		while read file
+		do
+			# handle only executables
+			test -x "$file" && test ! -d "$file" || continue
+
+			base=$(basename "$file")
+			symlink_target=$TEST_DIRECTORY/../$base
+			# do not override scripts
+			if test -x "$symlink_target" &&
+			    test "#!" != "$(head -c 2 < "$symlink_target")"
+			then
+				symlink_target=../valgrind.sh
+			fi
+			case "$base" in
+			*.sh|*.perl)
+				symlink_target=../unprocessed-script
+			esac
+			# create the link, or replace it if it is out of date
+			if test ! -h "$GIT_VALGRIND"/"$base" ||
+			    test "$symlink_target" != \
+					"$(readlink "$GIT_VALGRIND"/"$base")"
+			then
+				rm -f "$GIT_VALGRIND"/"$base" || exit
+				ln -s "$symlink_target" "$GIT_VALGRIND"/"$base"
+			fi
+		done
+	done
+	IFS=$OLDIFS
+	PATH=$GIT_VALGRIND:$PATH
+	GIT_EXEC_PATH=$GIT_VALGRIND
+	export GIT_VALGRIND
+fi
 GIT_TEMPLATE_DIR=$(pwd)/../templates/blt
 unset GIT_CONFIG
 GIT_CONFIG_NOSYSTEM=1
diff --git a/t/valgrind/.gitignore b/t/valgrind/.gitignore
new file mode 100644
index 0000000..ae3c172
--- /dev/null
+++ b/t/valgrind/.gitignore
@@ -0,0 +1 @@
+/bin/
diff --git a/t/valgrind/default.supp b/t/valgrind/default.supp
new file mode 100644
index 0000000..2482b3b
--- /dev/null
+++ b/t/valgrind/default.supp
@@ -0,0 +1,21 @@
+{
+	ignore-zlib-errors-cond
+	Memcheck:Cond
+	obj:*libz.so*
+}
+
+{
+	ignore-zlib-errors-value4
+	Memcheck:Value4
+	obj:*libz.so*
+}
+
+{
+	writing-data-from-zlib-triggers-errors
+	Memcheck:Param
+	write(buf)
+	obj:/lib/ld-*.so
+	fun:write_in_full
+	fun:write_buffer
+	fun:write_loose_object
+}
diff --git a/t/valgrind/valgrind.sh b/t/valgrind/valgrind.sh
new file mode 100755
index 0000000..2c4b54b
--- /dev/null
+++ b/t/valgrind/valgrind.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+base=$(basename "$0")
+
+exec valgrind -q --error-exitcode=126 \
+	--leak-check=no \
+	--suppressions="$GIT_VALGRIND/../default.supp" \
+	--gen-suppressions=all \
+	--log-fd=4 \
+	--input-fd=4 \
+	$GIT_VALGRIND_OPTIONS \
+	"$GIT_VALGRIND"/../../../"$base" "$@"
-- 
1.6.1.243.g6c8bb35
