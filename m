Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909E5C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B2760C40
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhH3S7u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 14:59:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:34120 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230471AbhH3S7t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 14:59:49 -0400
Received: (qmail 651 invoked by uid 109); 30 Aug 2021 18:58:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Aug 2021 18:58:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9130 invoked by uid 111); 30 Aug 2021 18:58:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Aug 2021 14:58:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Aug 2021 14:58:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Mickey Endito <mickey.endito.2323@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] t5582: remove spurious 'cd "$D"' line
Message-ID: <YS0qbgQhRP6XI7aj@coredump.intra.peff.net>
References: <tV8xl8isDPhmGxCNmN06tTwhJTve0PsrkakKwLMcFQJybDZO2SGHHbDLZFrcLp1Yda1_KRygSm7-lVDSZSaG-antdalcPnhSqYqcK5Fpifk=@protonmail.com>
 <xmqq8s0rpwiw.fsf@gitster.g>
 <20210824185942.GE2257957@szeder.dev>
 <YSWeeEgzCCT/3kxR@coredump.intra.peff.net>
 <xmqqsfyxjyfe.fsf@gitster.g>
 <20210828094726.GG2257957@szeder.dev>
 <xmqqilzm6g10.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqilzm6g10.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 09:42:03AM -0700, Junio C Hamano wrote:

> I wonder how close our test suite is for being "set -u" clean.
> Running our tests under "set -u" may not be a bad endpoint, but
> only if we can get there without too much pain.

I wondered, too, but I don't think we're very close.

Just throwing "set -u" at the top of test-lib.sh shows many issues:

  - we don't initialize some known variables, like say, verbose_only. It
    might be reasonable to have a big list of:

      verbose_only=
      verbose=

    etc. That would probably be an improvement, though a slight
    maintenance burden.

  - reading optional environment variables needs to be careful. You
    can't just say:

      if test -z "$GIT_TEST_CMP"

    but need:

      if test -z "${GIT_TEST_CMP:-}"

    It's doubly annoying when you're passing it to "test -z", of course,
    since the whole point is to see if it's set. In this case you can't
    just initialize to empty, since we might get the variable from the
    environment. I guess you could do:

      : ${GIT_TEST_CMP:=}

    near the top of the script to pre-declare all such variables.

  - optional arguments in functions need to be annotated. Like:

      foo=${2:-}

    Kind of annoying, but at least it communicates the intent in some
    ways.

Below is a diff that gets "./t0001-init.sh" running. But:

  - I have no illusions that there aren't tons of problems still
    lurking. All of these spots were found by running repeatedly and
    fixing up any errors. So whatever code paths I didn't run are
    probably full of similar bugs.

  - Most of the fixes were in test-lib.sh, so they'd apply to the other
    tests. If that's the extent, then maybe it's not so bad. But it's
    not clear how many individual scripts will need to be fixed, too
    (and likewise, for script authors to remain aware as they write new
    scripts). t0000, for example, fails half of its tests.

So I dunno. It could help find some bugs, but it seems like a
non-trivial burden.

 t/test-lib-functions.sh |  2 +-
 t/test-lib.sh           | 75 ++++++++++++++++++++++-------------
 2 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index e28411bb75..c1449fb91c 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1518,7 +1518,7 @@ test_detect_hash () {
 # Load common hash metadata and common placeholder object IDs for use with
 # test_oid.
 test_oid_init () {
-	test -n "$test_hash_algo" || test_detect_hash &&
+	test -n "${test_hash_algo:-}" || test_detect_hash &&
 	test_oid_cache <"$TEST_DIRECTORY/oid-info/hash-info" &&
 	test_oid_cache <"$TEST_DIRECTORY/oid-info/oid"
 }
diff --git a/t/test-lib.sh b/t/test-lib.sh
index abcfbed6d6..72344ddf78 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -15,9 +15,11 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see http://www.gnu.org/licenses/ .
 
+set -u
+
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
-if test -z "$TEST_DIRECTORY"
+if test -z "${TEST_DIRECTORY:-}"
 then
 	# We allow tests to override this, in case they want to run tests
 	# outside of t/, e.g. for running tests on the test library
@@ -28,7 +30,7 @@ else
 	# is valid even if the current working directory is changed
 	TEST_DIRECTORY=$(cd "$TEST_DIRECTORY" && pwd) || exit 1
 fi
-if test -z "$TEST_OUTPUT_DIRECTORY"
+if test -z "${TEST_OUTPUT_DIRECTORY:-}"
 then
 	# Similarly, override this to store the test-results subdir
 	# elsewhere
@@ -61,13 +63,13 @@ export PERL_PATH SHELL_PATH
 # the developer has TEST_OUTPUT_DIRECTORY part of his build options, then we'd
 # reset this value to instead contain what the developer has specified. We thus
 # have this knob to allow overriding the directory.
-if test -n "${TEST_OUTPUT_DIRECTORY_OVERRIDE}"
+if test -n "${TEST_OUTPUT_DIRECTORY_OVERRIDE:-}"
 then
 	TEST_OUTPUT_DIRECTORY="${TEST_OUTPUT_DIRECTORY_OVERRIDE}"
 fi
 
 # Disallow the use of abbreviated options in the test suite by default
-if test -z "${GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS}"
+if test -z "${GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS:-}"
 then
 	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true
 	export GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS
@@ -204,6 +206,24 @@ parse_option () {
 	esac
 }
 
+debug=
+help=
+immediate=
+quiet=
+run_list=
+root=
+stress=
+tee=
+trace=
+valgrind=
+valgrind_only=
+verbose=
+verbose_log=
+verbose_only=
+write_junit_xml=
+
+skip_all=
+
 # Parse options while taking care to leave $@ intact, so we will still
 # have all the original command line options when executing the test
 # script again for '--tee' and '--verbose-log' later.
@@ -271,7 +291,7 @@ case "$TRASH_DIRECTORY" in
 esac
 
 # If --stress was passed, run this test repeatedly in several parallel loops.
-if test "$GIT_TEST_STRESS_STARTED" = "done"
+if test "${GIT_TEST_STRESS_STARTED:-}" = "done"
 then
 	: # Don't stress test again.
 elif test -n "$stress"
@@ -359,7 +379,7 @@ fi
 
 # if --tee was passed, write the output not only to the terminal, but
 # additionally to the file test-results/$BASENAME.out, too.
-if test "$GIT_TEST_TEE_STARTED" = "done"
+if test "${GIT_TEST_TEE_STARTED:-}" = "done"
 then
 	: # do not redirect again
 elif test -n "$tee"
@@ -391,7 +411,7 @@ then
 	# potentially re-executed with $TEST_SHELL_PATH for '--tee' or
 	# '--verbose-log', so the right shell is checked and the
 	# warning is issued only once.
-	if test -n "$BASH_VERSION" && eval '
+	if test -n "${BASH_VERSION:-}" && eval '
 	     test ${BASH_VERSINFO[0]} -gt 4 || {
 	       test ${BASH_VERSINFO[0]} -eq 4 &&
 	       test ${BASH_VERSINFO[1]} -ge 1
@@ -413,7 +433,7 @@ fi
 # update the COLUMNS variable every time a non-builtin command
 # completes, even for non-interactive shells.
 # Disable that since we are aiming for repeatability.
-test -n "$BASH_VERSION" && shopt -u checkwinsize 2>/dev/null
+test -n "${BASH_VERSION:-}" && shopt -u checkwinsize 2>/dev/null
 
 # For repeatability, reset the environment to known value.
 # TERM is sanitized below, after saving color control sequences.
@@ -483,7 +503,7 @@ then
 	export GIT_INDEX_VERSION
 fi
 
-if test -n "$GIT_TEST_PERL_FATAL_WARNINGS"
+if test -n "${GIT_TEST_PERL_FATAL_WARNINGS:-}"
 then
 	GIT_PERL_FATAL_WARNINGS=1
 	export GIT_PERL_FATAL_WARNINGS
@@ -492,7 +512,7 @@ fi
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
 if test -n "$valgrind" ||
-   test -n "$TEST_NO_MALLOC_CHECK"
+   test -n "${TEST_NO_MALLOC_CHECK:-}"
 then
 	setup_malloc_check () {
 		: nothing
@@ -517,7 +537,7 @@ unset CDPATH
 unset GREP_OPTIONS
 unset UNZIP
 
-case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
+case $(echo ${GIT_TRACE:-} |tr "[A-Z]" "[a-z]") in
 1|2|true)
 	GIT_TRACE=4
 	;;
@@ -603,7 +623,7 @@ say () {
 	say_color info "$*"
 }
 
-if test -n "$HARNESS_ACTIVE"
+if test -n "${HARNESS_ACTIVE:-}"
 then
 	if test "$verbose" = t || test -n "$verbose_only"
 	then
@@ -892,12 +912,12 @@ maybe_setup_verbose () {
 }
 
 maybe_teardown_valgrind () {
-	test -z "$GIT_VALGRIND" && return
+	test -z "${GIT_VALGRIND:-}" && return
 	GIT_VALGRIND_ENABLED=
 }
 
 maybe_setup_valgrind () {
-	test -z "$GIT_VALGRIND" && return
+	test -z "${GIT_VALGRIND:-}" && return
 	if test -z "$valgrind_only"
 	then
 		GIT_VALGRIND_ENABLED=t
@@ -969,12 +989,12 @@ test_eval_ () {
 
 test_run_ () {
 	test_cleanup=:
-	expecting_failure=$2
+	expecting_failure=${2:-}
 
 	if test "${GIT_TEST_CHAIN_LINT:-1}" != 0; then
 		# turn off tracing for this test-eval, as it simply creates
 		# confusing noise in the "-x" output
-		trace_tmp=$trace
+		trace_tmp=${trace:-}
 		trace=
 		# 117 is magic because it is unlikely to match the exit
 		# code of other programs
@@ -1022,7 +1042,7 @@ test_finish_ () {
 	echo >&3 ""
 	maybe_teardown_valgrind
 	maybe_teardown_verbose
-	if test -n "$GIT_TEST_TEE_OFFSET"
+	if test -n "${GIT_TEST_TEE_OFFSET:-}"
 	then
 		GIT_TEST_TEE_OFFSET=$(test-tool path-utils file-size \
 			"$GIT_TEST_TEE_OUTPUT_FILE")
@@ -1032,7 +1052,7 @@ test_finish_ () {
 test_skip () {
 	to_skip=
 	skipped_reason=
-	if match_pattern_list $this_test.$test_count "$GIT_SKIP_TESTS"
+	if match_pattern_list $this_test.$test_count "${GIT_SKIP_TESTS:-}"
 	then
 		to_skip=t
 		skipped_reason="GIT_SKIP_TESTS"
@@ -1150,7 +1170,7 @@ test_done () {
 
 	finalize_junit_xml
 
-	if test -z "$HARNESS_ACTIVE"
+	if test -z "${HARNESS_ACTIVE:-}"
 	then
 		mkdir -p "$TEST_RESULTS_DIR"
 
@@ -1312,17 +1332,18 @@ then
 	GIT_VALGRIND_ENABLED=t
 	test -n "$valgrind_only" && GIT_VALGRIND_ENABLED=
 	export GIT_VALGRIND_ENABLED
-elif test -n "$GIT_TEST_INSTALLED"
+elif test -n "${GIT_TEST_INSTALLED:-}"
 then
 	GIT_EXEC_PATH=$($GIT_TEST_INSTALLED/git --exec-path)  ||
 	error "Cannot run git from $GIT_TEST_INSTALLED."
 	PATH=$GIT_TEST_INSTALLED:$GIT_BUILD_DIR/t/helper:$PATH
 	GIT_EXEC_PATH=${GIT_TEST_EXEC_PATH:-$GIT_EXEC_PATH}
 else # normal case, use ../bin-wrappers only unless $with_dashes:
-	if test -n "$no_bin_wrappers"
+	if test -n "${no_bin_wrappers:-}"
 	then
 		with_dashes=t
 	else
+		with_dashes=
 		git_bin_dir="$GIT_BUILD_DIR/bin-wrappers"
 		if ! test -x "$git_bin_dir/git"
 		then
@@ -1345,9 +1366,9 @@ GIT_CONFIG_NOSYSTEM=1
 GIT_ATTR_NOSYSTEM=1
 export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM
 
-if test -z "$GIT_TEST_CMP"
+if test -z "${GIT_TEST_CMP:-}"
 then
-	if test -n "$GIT_TEST_CMP_USE_COPIED_CONTEXT"
+	if test -n "${GIT_TEST_CMP_USE_COPIED_CONTEXT:-}"
 	then
 		GIT_TEST_CMP="$DIFF -c"
 	else
@@ -1372,7 +1393,7 @@ fi
 remove_trash=
 this_test=${0##*/}
 this_test=${this_test%%-*}
-if match_pattern_list "$this_test" "$GIT_SKIP_TESTS"
+if match_pattern_list "$this_test" "${GIT_SKIP_TESTS:-}"
 then
 	say_color info >&3 "skipping test $this_test altogether"
 	skip_all="skip all tests in $this_test"
@@ -1392,7 +1413,7 @@ rm -fr "$TRASH_DIRECTORY" || {
 }
 
 remove_trash=t
-if test -z "$TEST_NO_CREATE_REPO"
+if test -z "${TEST_NO_CREATE_REPO:-}"
 then
 	git init "$TRASH_DIRECTORY" >&3 2>&4 ||
 	error "cannot run git init"
@@ -1463,7 +1484,7 @@ yes () {
 # to call "git env--helper" (via test_bool_env). Only do that work
 # if needed by seeing if GIT_TEST_FAIL_PREREQS is set at all.
 GIT_TEST_FAIL_PREREQS_INTERNAL=
-if test -n "$GIT_TEST_FAIL_PREREQS"
+if test -n "${GIT_TEST_FAIL_PREREQS:-}"
 then
 	if test_bool_env GIT_TEST_FAIL_PREREQS false
 	then
@@ -1534,7 +1555,7 @@ test -n "$USE_LIBPCRE2" && test_set_prereq PCRE
 test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 
-if test -z "$GIT_TEST_CHECK_CACHE_TREE"
+if test -z "${GIT_TEST_CHECK_CACHE_TREE:-}"
 then
 	GIT_TEST_CHECK_CACHE_TREE=true
 	export GIT_TEST_CHECK_CACHE_TREE
