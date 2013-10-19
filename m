From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH 1/2] Revert "test-lib: support running tests under valgrind in parallel"
Date: Sat, 19 Oct 2013 23:06:07 +0200
Message-ID: <e3f3d660882546609aeeda5d5f8ad5ec999494ff.1382215973.git.tr@thomasrast.ch>
References: <cover.1382215973.git.tr@thomasrast.ch>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 19 23:06:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXdjF-0005BM-Rz
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 23:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660Ab3JSVGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Oct 2013 17:06:25 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:36706 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752211Ab3JSVGY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 17:06:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 206AD4D658A;
	Sat, 19 Oct 2013 23:06:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5hsacqN9kqVx; Sat, 19 Oct 2013 23:06:09 +0200 (CEST)
Received: from linux-k42r.v.cablecom.net (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 9A8D04D650A;
	Sat, 19 Oct 2013 23:06:09 +0200 (CEST)
X-Mailer: git-send-email 1.8.4.1.810.g312044e
In-Reply-To: <cover.1382215973.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236408>

This reverts commit ad0e6233320b004f0d686f6887c803e508607bd2.

--valgrind-parallel was broken from the start: during review I made
the whole valgrind setup code conditional on not being a
--valgrind-parallel worker child.  But even the children crucially
need $GIT_VALGRIND to be set; it should therefore have been set
outside the conditional.

The fix would be a two-liner, but since the introduction of the
feature, almost four months have passed without anyone noticing that
it is broken.  So this feature is not worth the about hundred lines of
test-lib.sh complexity.  Revert it.

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---
 t/test-lib.sh | 106 ++++++++++++----------------------------------------------
 1 file changed, 22 insertions(+), 84 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0fa7dfd..eaf6759 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -205,15 +205,6 @@ do
 	--valgrind-only=*)
 		valgrind_only=$(expr "z$1" : 'z[^=]*=\(.*\)')
 		shift ;;
-	--valgrind-parallel=*)
-		valgrind_parallel=$(expr "z$1" : 'z[^=]*=\(.*\)')
-		shift ;;
-	--valgrind-only-stride=*)
-		valgrind_only_stride=$(expr "z$1" : 'z[^=]*=\(.*\)')
-		shift ;;
-	--valgrind-only-offset=*)
-		valgrind_only_offset=$(expr "z$1" : 'z[^=]*=\(.*\)')
-		shift ;;
 	--tee)
 		shift ;; # was handled already
 	--root=*)
@@ -227,7 +218,7 @@ do
 	esac
 done
 
-if test -n "$valgrind_only" || test -n "$valgrind_only_stride"
+if test -n "$valgrind_only"
 then
 	test -z "$valgrind" && valgrind=memcheck
 	test -z "$verbose" && verbose_only="$valgrind_only"
@@ -377,9 +368,7 @@ maybe_teardown_verbose () {
 last_verbose=t
 maybe_setup_verbose () {
 	test -z "$verbose_only" && return
-	if match_pattern_list $test_count $verbose_only ||
-		{ test -n "$valgrind_only_stride" &&
-		expr $test_count "%" $valgrind_only_stride - $valgrind_only_offset = 0 >/dev/null; }
+	if match_pattern_list $test_count $verbose_only
 	then
 		exec 4>&2 3>&1
 		# Emit a delimiting blank line when going from
@@ -403,7 +392,7 @@ maybe_teardown_valgrind () {
 
 maybe_setup_valgrind () {
 	test -z "$GIT_VALGRIND" && return
-	if test -z "$valgrind_only" && test -z "$valgrind_only_stride"
+	if test -z "$valgrind_only"
 	then
 		GIT_VALGRIND_ENABLED=t
 		return
@@ -412,10 +401,6 @@ maybe_setup_valgrind () {
 	if match_pattern_list $test_count $valgrind_only
 	then
 		GIT_VALGRIND_ENABLED=t
-	elif test -n "$valgrind_only_stride" &&
-		expr $test_count "%" $valgrind_only_stride - $valgrind_only_offset = 0 >/dev/null
-	then
-		GIT_VALGRIND_ENABLED=t
 	fi
 }
 
@@ -568,9 +553,6 @@ test_done () {
 	esac
 }
 
-
-# Set up a directory that we can put in PATH which redirects all git
-# calls to 'valgrind git ...'.
 if test -n "$valgrind"
 then
 	make_symlink () {
@@ -618,42 +600,33 @@ then
 		make_symlink "$symlink_target" "$GIT_VALGRIND/bin/$base" || exit
 	}
 
-	# In the case of --valgrind-parallel, we only need to do the
-	# wrapping once, in the main script.  The worker children all
-	# have $valgrind_only_stride set, so we can skip based on that.
-	if test -z "$valgrind_only_stride"
-	then
-		# override all git executables in TEST_DIRECTORY/..
-		GIT_VALGRIND=$TEST_DIRECTORY/valgrind
-		mkdir -p "$GIT_VALGRIND"/bin
-		for file in $GIT_BUILD_DIR/git* $GIT_BUILD_DIR/test-*
-		do
-			make_valgrind_symlink $file
-		done
-		# special-case the mergetools loadables
-		make_symlink "$GIT_BUILD_DIR"/mergetools "$GIT_VALGRIND/bin/mergetools"
-		OLDIFS=$IFS
-		IFS=:
-		for path in $PATH
+	# override all git executables in TEST_DIRECTORY/..
+	GIT_VALGRIND=$TEST_DIRECTORY/valgrind
+	mkdir -p "$GIT_VALGRIND"/bin
+	for file in $GIT_BUILD_DIR/git* $GIT_BUILD_DIR/test-*
+	do
+		make_valgrind_symlink $file
+	done
+	# special-case the mergetools loadables
+	make_symlink "$GIT_BUILD_DIR"/mergetools "$GIT_VALGRIND/bin/mergetools"
+	OLDIFS=$IFS
+	IFS=:
+	for path in $PATH
+	do
+		ls "$path"/git-* 2> /dev/null |
+		while read file
 		do
-			ls "$path"/git-* 2> /dev/null |
-			while read file
-			do
-				make_valgrind_symlink "$file"
-			done
+			make_valgrind_symlink "$file"
 		done
-		IFS=$OLDIFS
-	fi
+	done
+	IFS=$OLDIFS
 	PATH=$GIT_VALGRIND/bin:$PATH
 	GIT_EXEC_PATH=$GIT_VALGRIND/bin
 	export GIT_VALGRIND
 	GIT_VALGRIND_MODE="$valgrind"
 	export GIT_VALGRIND_MODE
 	GIT_VALGRIND_ENABLED=t
-	if test -n "$valgrind_only" || test -n "$valgrind_only_stride"
-	then
-		GIT_VALGRIND_ENABLED=
-	fi
+	test -n "$valgrind_only" && GIT_VALGRIND_ENABLED=
 	export GIT_VALGRIND_ENABLED
 elif test -n "$GIT_TEST_INSTALLED"
 then
@@ -730,41 +703,6 @@ then
 else
 	mkdir -p "$TRASH_DIRECTORY"
 fi
-
-# Gross hack to spawn N sub-instances of the tests in parallel, and
-# summarize the results.  Note that if this is enabled, the script
-# terminates at the end of this 'if' block.
-if test -n "$valgrind_parallel"
-then
-	for i in $(test_seq 1 $valgrind_parallel)
-	do
-		root="$TRASH_DIRECTORY/vgparallel-$i"
-		mkdir "$root"
-		TEST_OUTPUT_DIRECTORY="$root" \
-			${SHELL_PATH} "$0" \
-			--root="$root" --statusprefix="[$i] " \
-			--valgrind="$valgrind" \
-			--valgrind-only-stride="$valgrind_parallel" \
-			--valgrind-only-offset="$i" &
-		pids="$pids $!"
-	done
-	trap "kill $pids" INT TERM HUP
-	wait $pids
-	trap - INT TERM HUP
-	for i in $(test_seq 1 $valgrind_parallel)
-	do
-		root="$TRASH_DIRECTORY/vgparallel-$i"
-		eval "$(cat "$root/test-results/$(basename "$0" .sh)"-*.counts |
-			sed 's/^\([a-z][a-z]*\) \([0-9][0-9]*\)/inner_\1=\2/')"
-		test_count=$(expr $test_count + $inner_total)
-		test_success=$(expr $test_success + $inner_success)
-		test_fixed=$(expr $test_fixed + $inner_fixed)
-		test_broken=$(expr $test_broken + $inner_broken)
-		test_failure=$(expr $test_failure + $inner_failed)
-	done
-	test_done
-fi
-
 # Use -P to resolve symlinks in our working directory so that the cwd
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$TRASH_DIRECTORY" || exit 1
-- 
1.8.4.1.810.g312044e
