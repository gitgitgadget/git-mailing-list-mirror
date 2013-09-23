From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/3] test-lib: introduce "modern" style tests
Date: Mon, 23 Sep 2013 23:08:44 +0200
Message-ID: <1379970526-27997-2-git-send-email-t.gummerer@gmail.com>
References: <xmqqtxhgsi5p.fsf@gitster.dls.corp.google.com>
 <1379970526-27997-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, git@vger.kernel.org, t.gummerer@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 23 23:09:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VODOF-0007tb-GM
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 23:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912Ab3IWVJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 17:09:50 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:44341 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603Ab3IWVJt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 17:09:49 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so3705699pbc.29
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 14:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zgiyrTOTuwge8afiTgDn9l4Mn86WyiZOfUWCsn3Hecw=;
        b=Gx5fhI6OcL1Ynq02aLMr4gOiOa6JV67d0rCHN8mzjMJLt7w0DoJG3oPA8UdHNxOAYQ
         iAdnSfOu1GZMvQt0S2gwyIr9yeN0Bk3U+WbS5P4P3v7VaqGGuCiCI2w/6YjfbmHhUlgD
         FowR7eswFEGaxuswziXTyomxMaDjkckGICn00JJzgYrtfNIB9KeZAAXsVDbLzdi61lx6
         SFsDiu1jqK9zr5vhldFFdcfbmKlEIyXEcG3KP68w+2uwNpXfdoQYARwTF+VVPFax0foD
         cCNtaOm54sRShe6cMKj1VoKmY4Ori9bHaHp5Rq2RNh+bq8OWO0XllyV6knMk5gOEsJLN
         BcVg==
X-Received: by 10.68.200.100 with SMTP id jr4mr25724813pbc.0.1379970588623;
        Mon, 23 Sep 2013 14:09:48 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPSA id bb1sm36235533pbc.10.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 23 Sep 2013 14:09:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1241.g1ce9896
In-Reply-To: <1379970526-27997-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235242>

From: Junio C Hamano <gitster@pobox.com>

Add a new, extensible style for tests that allows the addition of new
parameters other than the prerequitites

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/README                | 24 +++++++++++++++--
 t/perf/README           | 12 ++++++++-
 t/perf/perf-lib.sh      | 17 +++++-------
 t/t0008-ignores.sh      | 34 +++++++++++------------
 t/test-lib-functions.sh | 72 ++++++++++++++++++++++++++++++++++++++-----------
 5 files changed, 114 insertions(+), 45 deletions(-)

diff --git a/t/README b/t/README
index 2167125..bf41c29 100644
--- a/t/README
+++ b/t/README
@@ -390,6 +390,12 @@ below), e.g.:
         "$PERL_PATH" -e "hlagh() if unf_unf()"
     '
 
+or in the "modern" form, specifying the prerequisite as a parameter, e.g.:
+
+    test_expect_success --prereq PERL 'I need Perl' '
+        "$PERL_PATH" -e "hlagh() if unf_unf()"
+    '
+
 The advantage of skipping tests like this is that platforms that don't
 have the PERL and other optional dependencies get an indication of how
 many tests they're missing.
@@ -422,6 +428,7 @@ There are a handful helper functions defined in the test harness
 library for your script to use.
 
  - test_expect_success [<prereq>] <message> <script>
+ - test_expect_success [--prereq <prereq>] [--] <message> <script>
 
    Usually takes two strings as parameters, and evaluates the
    <script>.  If it yields success, test is considered
@@ -434,19 +441,31 @@ library for your script to use.
 	    'tree=$(git-write-tree)'
 
    If you supply three parameters the first will be taken to be a
-   prerequisite; see the test_set_prereq and test_have_prereq
+   prerequisite; if you ues the "modern" test style, you can specify
+   the prerequisites with --prereq; see the test_set_prereq and test_have_prereq
    documentation below:
 
 	test_expect_success TTY 'git --paginate rev-list uses a pager' \
 	    ' ... '
 
+	test_expect_success --prereq TTY 'git --paginate rev-list uses a pager' \
+	    ' ... '
+
    You can also supply a comma-separated list of prerequisites, in the
    rare case where your test depends on more than one:
 
 	test_expect_success PERL,PYTHON 'yo dawg' \
 	    ' test $(perl -E 'print eval "1 +" . qx[python -c "print 2"]') == "4" '
 
+	test_expect_success --prereq PERL,PYTHON 'yo dawg' \
+	    ' test $(perl -E 'print eval "1 +" . qx[python -c "print 2"]') == "4" '
+
+    The modern version also allows to distinguish the message from the
+    description and test script with --, in case the message starts
+    with --.
+
  - test_expect_failure [<prereq>] <message> <script>
+ - test_expect_failure [--prereq <prereq>] [--] <message> <script>
 
    This is NOT the opposite of test_expect_success, but is used
    to mark a test that demonstrates a known breakage.  Unlike
@@ -456,7 +475,8 @@ library for your script to use.
    tests won't cause -i (immediate) to stop.
 
    Like test_expect_success this function can optionally use a three
-   argument invocation with a prerequisite as the first argument.
+   argument invocation with a prerequisite as the first argument, or
+   the modern invocation with the prerequisite as an extra parameter.
 
  - test_debug <script>
 
diff --git a/t/perf/README b/t/perf/README
index 8848c14..21abbaf 100644
--- a/t/perf/README
+++ b/t/perf/README
@@ -118,11 +118,21 @@ At least one of the first two is required!
 You can use test_expect_success as usual.  For actual performance
 tests, use
 
-	test_perf 'descriptive string' '
+	test_perf [<prereq>] 'descriptive string' '
+		command1 &&
+		command2
+	'
+
+	test_perf [--prereq <prereq>] [--] 'descriptive string' '
 		command1 &&
 		command2
 	'
 
+prereq is an optional parameter to test_perf, and the performance
+tests are only executed if the prerequisite is fulfilled.  The modern
+version also allows to distinguish the message from the description
+and test script with --, in case the message starts with --.
+
 test_perf spawns a subshell, for lack of better options.  This means
 that
 
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index f4eecaa..6477d38 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -151,23 +151,20 @@ exit $ret' >&3 2>&4
 
 test_perf () {
 	test_start_
-	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
-	test "$#" = 2 ||
-	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
-	export test_prereq
+	test_expect_parse test_perf "$@"
 	if ! test_skip "$@"
 	then
 		base=$(basename "$0" .sh)
 		echo "$test_count" >>"$perf_results_dir"/$base.subtests
-		echo "$1" >"$perf_results_dir"/$base.$test_count.descr
+		echo "$test_label" >"$perf_results_dir"/$base.$test_count.descr
 		if test -z "$verbose"; then
-			printf "%s" "perf $test_count - $1:"
+			printf "%s" "perf $test_count - $test_label:"
 		else
-			echo "perf $test_count - $1:"
+			echo "perf $test_count - $test_label:"
 		fi
 		for i in $(test_seq 1 $GIT_PERF_REPEAT_COUNT); do
-			say >&3 "running: $2"
-			if test_run_perf_ "$2"
+			say >&3 "running: $test_body"
+			if test_run_perf_ "$test_body"
 			then
 				if test -z "$verbose"; then
 					printf " %s" "$i"
@@ -183,7 +180,7 @@ test_perf () {
 		if test -z "$verbose"; then
 			echo " ok"
 		else
-			test_ok_ "$1"
+			test_ok_ "$test_label"
 		fi
 		base="$perf_results_dir"/"$perf_results_prefix$(basename "$0" .sh)"."$test_count"
 		"$TEST_DIRECTORY"/perf/min_time.perl test_time.* >"$base".times
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 181513a..efe8dfd 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -234,7 +234,7 @@ test_expect_success_multi 'empty command line' '' '
 	stderr_contains "fatal: no path specified"
 '
 
-test_expect_success_multi '--stdin with empty STDIN' '' '
+test_expect_success_multi -- '--stdin with empty STDIN' '' '
 	test_check_ignore "--stdin" 1 </dev/null &&
 	test_stderr ""
 '
@@ -245,7 +245,7 @@ test_expect_success '-q with multiple args' '
 	stderr_contains "fatal: --quiet is only valid with a single pathname"
 '
 
-test_expect_success '--quiet with multiple args' '
+test_expect_success -- '--quiet with multiple args' '
 	expect "" &&
 	test_check_ignore "--quiet one two" 128 &&
 	stderr_contains "fatal: --quiet is only valid with a single pathname"
@@ -255,7 +255,7 @@ for verbose_opt in '-v' '--verbose'
 do
 	for quiet_opt in '-q' '--quiet'
 	do
-		test_expect_success "$quiet_opt $verbose_opt" "
+		test_expect_success -- "$quiet_opt $verbose_opt" "
 			expect '' &&
 			test_check_ignore '$quiet_opt $verbose_opt foo' 128 &&
 			stderr_contains 'fatal: cannot have both --quiet and --verbose'
@@ -263,7 +263,7 @@ do
 	done
 done
 
-test_expect_success '--quiet with multiple args' '
+test_expect_success -- '--quiet with multiple args' '
 	expect "" &&
 	test_check_ignore "--quiet one two" 128 &&
 	stderr_contains "fatal: --quiet is only valid with a single pathname"
@@ -274,12 +274,12 @@ test_expect_success_multi 'erroneous use of --' '' '
 	stderr_contains "fatal: no path specified"
 '
 
-test_expect_success_multi '--stdin with superfluous arg' '' '
+test_expect_success_multi -- '--stdin with superfluous arg' '' '
 	test_check_ignore "--stdin foo" 128 &&
 	stderr_contains "fatal: cannot specify pathnames with --stdin"
 '
 
-test_expect_success_multi '--stdin -z with superfluous arg' '' '
+test_expect_success_multi -- '--stdin -z with superfluous arg' '' '
 	test_check_ignore "--stdin -z foo" 128 &&
 	stderr_contains "fatal: cannot specify pathnames with --stdin"
 '
@@ -613,34 +613,34 @@ sed -e 's/^"//' -e 's/\\//' -e 's/"$//' expected-default | \
 sed -e 's/	"/	/' -e 's/\\//' -e 's/"$//' expected-verbose | \
 	tr ":\t\n" "\0" >expected-verbose0
 
-test_expect_success '--stdin' '
+test_expect_success -- '--stdin' '
 	expect_from_stdin <expected-default &&
 	test_check_ignore "--stdin" <stdin
 '
 
-test_expect_success '--stdin -q' '
+test_expect_success -- '--stdin -q' '
 	expect "" &&
 	test_check_ignore "-q --stdin" <stdin
 '
 
-test_expect_success '--stdin -v' '
+test_expect_success -- '--stdin -v' '
 	expect_from_stdin <expected-verbose &&
 	test_check_ignore "-v --stdin" <stdin
 '
 
 for opts in '--stdin -z' '-z --stdin'
 do
-	test_expect_success "$opts" "
+	test_expect_success -- "$opts" "
 		expect_from_stdin <expected-default0 &&
 		test_check_ignore '$opts' <stdin0
 	"
 
-	test_expect_success "$opts -q" "
+	test_expect_success -- "$opts -q" "
 		expect "" &&
 		test_check_ignore '-q $opts' <stdin0
 	"
 
-	test_expect_success "$opts -v" "
+	test_expect_success -- "$opts -v" "
 		expect_from_stdin <expected-verbose0 &&
 		test_check_ignore '-v $opts' <stdin0
 	"
@@ -699,7 +699,7 @@ sed -e 's/^"//' -e 's/\\//' -e 's/"$//' expected-default | \
 sed -e 's/	"/	/' -e 's/\\//' -e 's/"$//' expected-verbose | \
 	tr ":\t\n" "\0" >expected-verbose0
 
-test_expect_success '--stdin from subdirectory' '
+test_expect_success -- '--stdin from subdirectory' '
 	expect_from_stdin <expected-default &&
 	(
 		cd a &&
@@ -707,7 +707,7 @@ test_expect_success '--stdin from subdirectory' '
 	)
 '
 
-test_expect_success '--stdin from subdirectory with -v' '
+test_expect_success -- '--stdin from subdirectory with -v' '
 	expect_from_stdin <expected-verbose &&
 	(
 		cd a &&
@@ -715,7 +715,7 @@ test_expect_success '--stdin from subdirectory with -v' '
 	)
 '
 
-test_expect_success '--stdin from subdirectory with -v -n' '
+test_expect_success -- '--stdin from subdirectory with -v -n' '
 	expect_from_stdin <expected-all &&
 	(
 		cd a &&
@@ -725,7 +725,7 @@ test_expect_success '--stdin from subdirectory with -v -n' '
 
 for opts in '--stdin -z' '-z --stdin'
 do
-	test_expect_success "$opts from subdirectory" '
+	test_expect_success -- "$opts from subdirectory" '
 		expect_from_stdin <expected-default0 &&
 		(
 			cd a &&
@@ -733,7 +733,7 @@ do
 		)
 	'
 
-	test_expect_success "$opts from subdirectory with -v" '
+	test_expect_success -- "$opts from subdirectory with -v" '
 		expect_from_stdin <expected-verbose0 &&
 		(
 			cd a &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 19cdf0b..473b21d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -347,20 +347,65 @@ test_declared_prereq () {
 	return 1
 }
 
+test_expect_parse () {
+	whoami=$1
+	shift
+	test_expect_new_style=
+	while case $# in 0) false ;; esac
+	do
+		case "$1" in
+		--prereq)
+			test $# -gt 1 ||
+			error "bug in the test script: --prereq needs a parameter"
+			test_prereq=$2
+			shift
+			;;
+		--)
+			shift
+			break
+			;;
+		--*)
+			error "bug in the test script: unknown option '$1'"
+			;;
+		*)
+			break
+			;;
+		esac
+		test_expect_new_style=yes
+		shift
+	done
+
+	# Traditional "test_expect_what [PREREQ] BODY"
+	if test -z "$test_expect_new_style"
+	then
+		test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
+	fi
+
+	if test $# != 2
+	then
+		if test -z "$test_expect_new_style"
+		then
+			error "bug in the test script: not 2 or 3 parameters to $whoami"
+		else
+			error "bug in the test script: not 2 parameters to $whoami"
+		fi
+	fi
+	test_label=$1 test_body=$2
+
+	export test_prereq
+}
+
 test_expect_failure () {
 	test_start_
-	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
-	test "$#" = 2 ||
-	error "bug in the test script: not 2 or 3 parameters to test-expect-failure"
-	export test_prereq
+	test_expect_parse test_expect_failure "$@"
 	if ! test_skip "$@"
 	then
-		say >&3 "checking known breakage: $2"
-		if test_run_ "$2" expecting_failure
+		say >&3 "checking known breakage: $test_body"
+		if test_run_ "$test_body" expecting_failure
 		then
-			test_known_broken_ok_ "$1"
+			test_known_broken_ok_ "$test_label"
 		else
-			test_known_broken_failure_ "$1"
+			test_known_broken_failure_ "$test_label"
 		fi
 	fi
 	test_finish_
@@ -368,16 +413,13 @@ test_expect_failure () {
 
 test_expect_success () {
 	test_start_
-	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
-	test "$#" = 2 ||
-	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
-	export test_prereq
+	test_expect_parse test_expect_success "$@"
 	if ! test_skip "$@"
 	then
-		say >&3 "expecting success: $2"
-		if test_run_ "$2"
+		say >&3 "expecting success: $test_body"
+		if test_run_ "$test_body"
 		then
-			test_ok_ "$1"
+			test_ok_ "$test_label"
 		else
 			test_failure_ "$@"
 		fi
-- 
1.8.3.4.1241.g1ce9896
