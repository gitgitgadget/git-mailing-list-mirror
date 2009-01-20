From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] Add valgrind support in test scripts
Date: Tue, 20 Jan 2009 16:04:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net>
 <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 16:06:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPIB1-0002yH-T6
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 16:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772AbZATPEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 10:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755540AbZATPEi
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 10:04:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:34612 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752902AbZATPEh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 10:04:37 -0500
Received: (qmail invoked by alias); 20 Jan 2009 15:04:35 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp049) with SMTP; 20 Jan 2009 16:04:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX186w2oT/mU69+SrKb38TmPLH2ueOOokPPCNY+Wzq2
	9asSbQ5G+YZqKT
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106480>


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

	AFAIR libz reserves only aligned memory, and does all operations 
	in an aligned manner, but it is safe (even if it accesses 
	uninitialized memory, it does not use the results anyway).

 t/test-lib.sh           |   39 +++++++++++++++++++++++++++++++++++++--
 t/valgrind/.gitignore   |    2 ++
 t/valgrind/default.supp |   21 +++++++++++++++++++++
 t/valgrind/valgrind.sh  |   12 ++++++++++++
 4 files changed, 72 insertions(+), 2 deletions(-)
 create mode 100644 t/valgrind/.gitignore
 create mode 100644 t/valgrind/default.supp
 create mode 100755 t/valgrind/valgrind.sh

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 41d5a59..1daae9b 100644
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
@@ -467,8 +469,41 @@ test_done () {
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
+	GIT_VALGRIND=$TEST_DIRECTORY/valgrind
+	mkdir -p "$GIT_VALGRIND"
+	OLDIFS=$IFS
+	IFS=:
+	for path in $PATH:$TEST_DIRECTORY/..
+	do
+		ls "$TEST_DIRECTORY"/../git "$path"/git-* 2> /dev/null |
+		while read file
+		do
+			# handle only executables
+			test -x "$file" || continue
+
+			base=$(basename "$file")
+			test ! -h "$GIT_VALGRIND"/"$base" || continue
+
+			if test "#!" = "$(head -c 2 < "$file")"
+			then
+				# do not override scripts
+				ln -s ../../"$base" "$GIT_VALGRIND"/"$base"
+			else
+				ln -s valgrind.sh "$GIT_VALGRIND"/"$base"
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
index 0000000..d781a63
--- /dev/null
+++ b/t/valgrind/.gitignore
@@ -0,0 +1,2 @@
+/git
+/git-*
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
1.6.1.243.g6c8bb35
