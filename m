From: Thomas Rast <trast@inf.ethz.ch>
Subject: [RFC PATCH 6/6] test-lib: support running tests under valgrind in parallel
Date: Thu, 16 May 2013 22:50:17 +0200
Message-ID: <1d22b4b7885ff6b27c0837608aeaacd20e36ed94.1368736093.git.trast@inf.ethz.ch>
References: <cover.1368736093.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 16 22:50:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud58U-00051H-Bo
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 22:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323Ab3EPUud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 16:50:33 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:48887 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753119Ab3EPUuX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 16:50:23 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 16 May
 2013 22:50:19 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 16 May
 2013 22:50:19 +0200
X-Mailer: git-send-email 1.8.3.rc2.393.g8636c0b
In-Reply-To: <cover.1368736093.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224620>

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

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/test-lib.sh | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 55fa749..b4e81bc 100644
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
@@ -359,8 +368,10 @@ match_pattern_list () {
 }
 
 toggle_verbose () {
-	test -z "$verbose_only" && return
-	if match_pattern_list $test_count $verbose_only
+	test -z "$verbose_only" && test -z "$valgrind_only_stride" && return
+	if match_pattern_list $test_count $verbose_only ||
+		{ test -n "$valgrind_only_stride" &&
+		expr $test_count "%" $valgrind_only_stride - $valgrind_only_offset = 0 >/dev/null; }
 	then
 		exec 4>&2 3>&1
 	else
@@ -370,7 +381,7 @@ toggle_verbose () {
 
 toggle_valgrind () {
 	test -z "$GIT_VALGRIND" && return
-	if test -z "$valgrind_only"
+	if test -z "$valgrind_only" && test -z "$valgrind_only_stride"
 	then
 		GIT_VALGRIND_ENABLED=t
 		return
@@ -379,6 +390,10 @@ toggle_valgrind () {
 	if match_pattern_list $test_count $valgrind_only
 	then
 		GIT_VALGRIND_ENABLED=t
+	elif test -n "$valgrind_only_stride" &&
+		expr $test_count "%" $valgrind_only_stride - $valgrind_only_offset = 0 >/dev/null
+	then
+		GIT_VALGRIND_ENABLED=t
 	fi
 }
 
@@ -600,7 +615,10 @@ then
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
@@ -686,6 +704,38 @@ then
 else
 	mkdir -p "$TRASH_DIRECTORY"
 fi
+
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
+		test_failed=$(expr $test_failed + $inner_failed)
+	done
+	test_done
+fi
+
 # Use -P to resolve symlinks in our working directory so that the cwd
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$TRASH_DIRECTORY" || exit 1
-- 
1.8.3.rc2.393.g8636c0b
