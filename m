From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v3 8/8] test-lib: support running tests under valgrind in parallel
Date: Tue, 18 Jun 2013 14:26:04 +0200
Message-ID: <1f5236603e050962b3792c59170d56a2a10a482f.1371557431.git.trast@inf.ethz.ch>
References: <cover.1371557431.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:26:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UouzU-0007cU-2k
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756000Ab3FRM0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 08:26:25 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:42516 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756034Ab3FRM0V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:26:21 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 14:26:15 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.157) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 14:26:19 +0200
X-Mailer: git-send-email 1.8.3.1.530.g6f90e57
In-Reply-To: <cover.1371557431.git.trast@inf.ethz.ch>
X-Originating-IP: [213.55.184.157]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228217>

With the new --valgrind-parallel=<n> option, we support running the
tests in a single test script under valgrind in parallel using 'n'
processes.

This really follows the dumbest approach possible, as follows:

* We spawn the test script 'n' times, using a throw-away
  TEST_OUTPUT_DIRECTORY.  Each of the instances is given options that
  ensures that it only runs every n-th test under valgrind, but
  together they cover the entire range.

* We add up the numbers from the individual tests, and provide the
  usual output.

This is really a gross hack at this point, and should be improved.  In
particular we should keep the actual outputs somewhere more easily
discoverable, and summarize them to the user.

Nevertheless, this is already workable and gives a speedup of more
than 2 on a dual-core (hyperthreaded) machine, using n=4.  This is
expected since the overhead of valgrind is so big (on the order of 20x
under good conditions, and a large startup overhead at every git
invocation) that redundantly running the non-valgrind tests in between
is not that expensive.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/test-lib.sh | 106 ++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 84 insertions(+), 22 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f2abff9..acc7f2a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -204,6 +204,15 @@ do
 	--valgrind-only=*)
 		valgrind_only=$(expr "z$1" : 'z[^=]*=\(.*\)')
 		shift ;;
+	--valgrind-parallel=*)
+		valgrind_parallel=$(expr "z$1" : 'z[^=]*=\(.*\)')
+		shift ;;
+	--valgrind-only-stride=*)
+		valgrind_only_stride=$(expr "z$1" : 'z[^=]*=\(.*\)')
+		shift ;;
+	--valgrind-only-offset=*)
+		valgrind_only_offset=$(expr "z$1" : 'z[^=]*=\(.*\)')
+		shift ;;
 	--tee)
 		shift ;; # was handled already
 	--root=*)
@@ -217,7 +226,7 @@ do
 	esac
 done
 
-if test -n "$valgrind_only"
+if test -n "$valgrind_only" || test -n "$valgrind_only_stride"
 then
 	test -z "$valgrind" && valgrind=memcheck
 	test -z "$verbose" && verbose_only="$valgrind_only"
@@ -367,7 +376,9 @@ maybe_teardown_verbose () {
 last_verbose=t
 maybe_setup_verbose () {
 	test -z "$verbose_only" && return
-	if match_pattern_list $test_count $verbose_only
+	if match_pattern_list $test_count $verbose_only ||
+		{ test -n "$valgrind_only_stride" &&
+		expr $test_count "%" $valgrind_only_stride - $valgrind_only_offset = 0 >/dev/null; }
 	then
 		exec 4>&2 3>&1
 		# Emit a delimiting blank line when going from
@@ -391,7 +402,7 @@ maybe_teardown_valgrind () {
 
 maybe_setup_valgrind () {
 	test -z "$GIT_VALGRIND" && return
-	if test -z "$valgrind_only"
+	if test -z "$valgrind_only" && test -z "$valgrind_only_stride"
 	then
 		GIT_VALGRIND_ENABLED=t
 		return
@@ -400,6 +411,10 @@ maybe_setup_valgrind () {
 	if match_pattern_list $test_count $valgrind_only
 	then
 		GIT_VALGRIND_ENABLED=t
+	elif test -n "$valgrind_only_stride" &&
+		expr $test_count "%" $valgrind_only_stride - $valgrind_only_offset = 0 >/dev/null
+	then
+		GIT_VALGRIND_ENABLED=t
 	fi
 }
 
@@ -550,6 +565,9 @@ test_done () {
 	esac
 }
 
+
+# Set up a directory that we can put in PATH which redirects all git
+# calls to 'valgrind git ...'.
 if test -n "$valgrind"
 then
 	make_symlink () {
@@ -597,33 +615,42 @@ then
 		make_symlink "$symlink_target" "$GIT_VALGRIND/bin/$base" || exit
 	}
 
-	# override all git executables in TEST_DIRECTORY/..
-	GIT_VALGRIND=$TEST_DIRECTORY/valgrind
-	mkdir -p "$GIT_VALGRIND"/bin
-	for file in $GIT_BUILD_DIR/git* $GIT_BUILD_DIR/test-*
-	do
-		make_valgrind_symlink $file
-	done
-	# special-case the mergetools loadables
-	make_symlink "$GIT_BUILD_DIR"/mergetools "$GIT_VALGRIND/bin/mergetools"
-	OLDIFS=$IFS
-	IFS=:
-	for path in $PATH
-	do
-		ls "$path"/git-* 2> /dev/null |
-		while read file
+	# In the case of --valgrind-parallel, we only need to do the
+	# wrapping once, in the main script.  The worker children all
+	# have $valgrind_only_stride set, so we can skip based on that.
+	if test -z "$valgrind_only_stride"
+	then
+		# override all git executables in TEST_DIRECTORY/..
+		GIT_VALGRIND=$TEST_DIRECTORY/valgrind
+		mkdir -p "$GIT_VALGRIND"/bin
+		for file in $GIT_BUILD_DIR/git* $GIT_BUILD_DIR/test-*
 		do
-			make_valgrind_symlink "$file"
+			make_valgrind_symlink $file
 		done
-	done
-	IFS=$OLDIFS
+		# special-case the mergetools loadables
+		make_symlink "$GIT_BUILD_DIR"/mergetools "$GIT_VALGRIND/bin/mergetools"
+		OLDIFS=$IFS
+		IFS=:
+		for path in $PATH
+		do
+			ls "$path"/git-* 2> /dev/null |
+			while read file
+			do
+				make_valgrind_symlink "$file"
+			done
+		done
+		IFS=$OLDIFS
+	fi
 	PATH=$GIT_VALGRIND/bin:$PATH
 	GIT_EXEC_PATH=$GIT_VALGRIND/bin
 	export GIT_VALGRIND
 	GIT_VALGRIND_MODE="$valgrind"
 	export GIT_VALGRIND_MODE
 	GIT_VALGRIND_ENABLED=t
-	test -n "$valgrind_only" && GIT_VALGRIND_ENABLED=
+	if test -n "$valgrind_only" || test -n "$valgrind_only_stride"
+	then
+		GIT_VALGRIND_ENABLED=
+	fi
 	export GIT_VALGRIND_ENABLED
 elif test -n "$GIT_TEST_INSTALLED"
 then
@@ -709,6 +736,41 @@ then
 else
 	mkdir -p "$TRASH_DIRECTORY"
 fi
+
+# Gross hack to spawn N sub-instances of the tests in parallel, and
+# summarize the results.  Note that if this is enabled, the script
+# terminates at the end of this 'if' block.
+if test -n "$valgrind_parallel"
+then
+	for i in $(test_seq 1 $valgrind_parallel)
+	do
+		root="$TRASH_DIRECTORY/vgparallel-$i"
+		mkdir "$root"
+		TEST_OUTPUT_DIRECTORY="$root" \
+			${SHELL_PATH} "$0" \
+			--root="$root" --statusprefix="[$i] " \
+			--valgrind="$valgrind" \
+			--valgrind-only-stride="$valgrind_parallel" \
+			--valgrind-only-offset="$i" &
+		pids="$pids $!"
+	done
+	trap "kill $pids" INT TERM HUP
+	wait $pids
+	trap - INT TERM HUP
+	for i in $(test_seq 1 $valgrind_parallel)
+	do
+		root="$TRASH_DIRECTORY/vgparallel-$i"
+		eval "$(cat "$root/test-results/$(basename "$0" .sh)"-*.counts |
+			sed 's/^\([a-z][a-z]*\) \([0-9][0-9]*\)/inner_\1=\2/')"
+		test_count=$(expr $test_count + $inner_total)
+		test_success=$(expr $test_success + $inner_success)
+		test_fixed=$(expr $test_fixed + $inner_fixed)
+		test_broken=$(expr $test_broken + $inner_broken)
+		test_failure=$(expr $test_failure + $inner_failed)
+	done
+	test_done
+fi
+
 # Use -P to resolve symlinks in our working directory so that the cwd
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$TRASH_DIRECTORY" || exit 1
-- 
1.8.3.1.530.g6f90e57
