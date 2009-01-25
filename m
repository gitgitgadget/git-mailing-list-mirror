From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 1/3] Add valgrind support in test scripts
Date: Mon, 26 Jan 2009 00:18:50 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901260018340.14855@racer>
References: <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net> <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302>
 <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302> <20090121001219.GA18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210209580.19014@racer> <20090121190201.GA21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212137130.3586@pacific.mpi-cbg.de>
 <20090121215318.GA9107@sigill.intra.peff.net> <alpine.DEB.1.00.0901212332030.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901260014470.14855@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 00:19:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LREGZ-0007GA-QX
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbZAYXSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbZAYXSW
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:18:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:37133 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750786AbZAYXSV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:18:21 -0500
Received: (qmail invoked by alias); 25 Jan 2009 23:18:19 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp028) with SMTP; 26 Jan 2009 00:18:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/KDh9vlnTKojDZl0UYlIDs8O+G4Fke7klwjG0vce
	jKpJXVPdjZi5ku
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0901260014470.14855@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107122>


This patch adds the ability to use valgrind's memcheck tool to
diagnose memory problems in Git while running the test scripts.

It works by creating symlinks to a valgrind script, which have the same
name as our Git binaries, and then putting that directory in front of
the test script's PATH as well as set GIT_EXEC_PATH to that directory.

Git scripts are symlinked from that directory directly.  That way, Git
binaries called by Git scripts are valgrinded, too.

Valgrind can be used by specifying "GIT_TEST_OPTS=--valgrind" in the
make invocation. Any invocation of git that finds any errors under
valgrind will exit with failure code 126. Any valgrind output will go
to the usual stderr channel for tests (i.e., /dev/null, unless -v has
been specified).

If you need to pass options to valgrind -- you might want to run
another tool than memcheck, for example -- you can set the environment
variable GIT_VALGRIND_OPTIONS.

A few default suppressions are included, since libz seems to trigger
quite a few false positives. We'll assume that libz works and that we
can ignore any errors which are reported there.

Note: it is safe to run the valgrind tests in parallel, as the links in
t/valgrind/bin/ are created using proper locking.

Initial patch and all the hard work by Jeff King.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/README                |    8 ++++++-
 t/test-lib.sh           |   54 +++++++++++++++++++++++++++++++++++++++++++++-
 t/valgrind/.gitignore   |    1 +
 t/valgrind/default.supp |   21 ++++++++++++++++++
 t/valgrind/valgrind.sh  |   12 ++++++++++
 5 files changed, 93 insertions(+), 3 deletions(-)
 create mode 100644 t/valgrind/.gitignore
 create mode 100644 t/valgrind/default.supp
 create mode 100755 t/valgrind/valgrind.sh

diff --git a/t/README b/t/README
index 8f12d48..811bc0d 100644
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
@@ -58,6 +59,11 @@ You can pass --verbose (or -v), --debug (or -d), and --immediate
 	This causes additional long-running tests to be run (where
 	available), for more exhaustive testing.
 
+--valgrind::
+	Execute all Git binaries with valgrind and exit with status
+	126 on errors (just like regular tests, this will only stop
+	the test script when running under -i).  Valgrind errors
+	go to stderr, so you might want to pass the -v option, too.
 
 Skipping Tests
 --------------
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 41d5a59..67d7883 100644
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
@@ -467,8 +469,56 @@ test_done () {
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
+	make_symlink () {
+		test -h "$2" &&
+		test "$1" = "$(readlink "$2")" || {
+			# be super paranoid
+			if mkdir "$2".lock
+			then
+				rm -f "$2" &&
+				ln -s "$1" "$2" &&
+				rm -r "$2".lock
+			else
+				while test -d "$2".lock
+				do
+					say "Waiting for lock on $2."
+					sleep 1
+				done
+			fi
+		}
+	}
+
+	# override all git executables in TEST_DIRECTORY/..
+	GIT_VALGRIND=$TEST_DIRECTORY/valgrind
+	mkdir -p "$GIT_VALGRIND"/bin
+	ls $TEST_DIRECTORY/../git* 2> /dev/null |
+	while read symlink_target
+	do
+		# handle only executables
+		test -x "$symlink_target" || continue
+
+		base=$(basename "$symlink_target")
+		# do not override scripts
+		if test ! -d "$symlink_target" &&
+		    test "#!" != "$(head -c 2 < "$symlink_target")"
+		then
+			symlink_target=../valgrind.sh
+		fi
+		# create the link, or replace it if it is out of date
+		make_symlink "$symlink_target" \
+			"$GIT_VALGRIND/bin/$base" || exit
+	done
+	PATH=$GIT_VALGRIND/bin:$PATH
+	GIT_EXEC_PATH=$GIT_VALGRIND/bin
+	export GIT_VALGRIND
+
+	make_symlink ../../templates "$GIT_VALGRIND"/templates || exit
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
index 0000000..24f3a4e
--- /dev/null
+++ b/t/valgrind/valgrind.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+base=$(basename "$0")
+
+exec valgrind -q --error-exitcode=126 \
+	--leak-check=no \
+	--suppressions="$GIT_VALGRIND/default.supp" \
+	--gen-suppressions=all \
+	--log-fd=4 \
+	--input-fd=4 \
+	$GIT_VALGRIND_OPTIONS \
+	"$GIT_VALGRIND"/../../"$base" "$@"
-- 
1.6.1.482.g7d54be
