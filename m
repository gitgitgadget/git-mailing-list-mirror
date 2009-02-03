From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/8] Add valgrind support in test scripts
Date: Wed, 4 Feb 2009 00:25:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902040025580.9822@pacific.mpi-cbg.de>
References: <cover.1233702893u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 00:27:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUUfL-00078h-DO
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 00:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbZBCXZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 18:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbZBCXZ2
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 18:25:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:35318 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751695AbZBCXZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 18:25:27 -0500
Received: (qmail invoked by alias); 03 Feb 2009 23:25:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp032) with SMTP; 04 Feb 2009 00:25:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+U1qVnSBWUWlxuddJelXtdpBuWOXVbYvWusc/fH5
	Eos3ppYpwMczNt
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1233702893u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108267>

This patch adds the ability to use valgrind's memcheck tool to
diagnose memory problems in Git while running the test scripts.

It requires valgrind 3.4.0 or newer.

It works by creating symlinks to a valgrind script, which have the same
name as our Git binaries, and then putting that directory in front of
the test script's PATH as well as set GIT_EXEC_PATH to that directory.
Git scripts are symlinked from that directory directly.

That way, Git binaries called by Git scripts are valgrinded, too.

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
Signed-off-by: Jeff King <peff@peff.net>
---
 t/README                |    8 +++++-
 t/test-lib.sh           |   58 +++++++++++++++++++++++++++++++++++++++++++++-
 t/valgrind/.gitignore   |    2 +
 t/valgrind/default.supp |   21 +++++++++++++++++
 t/valgrind/valgrind.sh  |   13 ++++++++++
 5 files changed, 99 insertions(+), 3 deletions(-)
 create mode 100644 t/valgrind/.gitignore
 create mode 100644 t/valgrind/default.supp
 create mode 100755 t/valgrind/valgrind.sh

diff --git a/t/README b/t/README
index f208cf1..7560db5 100644
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
index c1839f7..aa9f938 100644
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
@@ -492,8 +494,60 @@ test_done () {
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
+	make_valgrind_symlink () {
+		# handle only executables
+		test -x "$1" || return
+
+		base=$(basename "$1")
+		symlink_target=$TEST_DIRECTORY/../$base
+		# do not override scripts
+		if test -x "$symlink_target" &&
+		    test ! -d "$symlink_target" &&
+		    test "#!" != "$(head -c 2 < "$symlink_target")"
+		then
+			symlink_target=../valgrind.sh
+		fi
+		# create the link, or replace it if it is out of date
+		make_symlink "$symlink_target" "$GIT_VALGRIND/bin/$base" || exit
+	}
+
+	# override all git executables in TEST_DIRECTORY/..
+	GIT_VALGRIND=$TEST_DIRECTORY/valgrind
+	mkdir -p "$GIT_VALGRIND"/bin
+	for file in $TEST_DIRECTORY/../git* $TEST_DIRECTORY/../test-*
+	do
+		make_valgrind_symlink $file
+	done
+	PATH=$GIT_VALGRIND/bin:$PATH
+	GIT_EXEC_PATH=$GIT_VALGRIND/bin
+	export GIT_VALGRIND
+
+	make_symlink ../../../templates "$GIT_VALGRIND"/bin/templates || exit
+fi
 GIT_TEMPLATE_DIR=$(pwd)/../templates/blt
 unset GIT_CONFIG
 GIT_CONFIG_NOSYSTEM=1
diff --git a/t/valgrind/.gitignore b/t/valgrind/.gitignore
new file mode 100644
index 0000000..d4ae667
--- /dev/null
+++ b/t/valgrind/.gitignore
@@ -0,0 +1,2 @@
+/bin/
+/templates
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
index 0000000..dc92612
--- /dev/null
+++ b/t/valgrind/valgrind.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+
+base=$(basename "$0")
+
+exec valgrind -q --error-exitcode=126 \
+	--leak-check=no \
+	--suppressions="$GIT_VALGRIND/default.supp" \
+	--gen-suppressions=all \
+	--track-origins=yes \
+	--log-fd=4 \
+	--input-fd=4 \
+	$GIT_VALGRIND_OPTIONS \
+	"$GIT_VALGRIND"/../../"$base" "$@"
-- 
1.6.1.2.582.g3fdd5
