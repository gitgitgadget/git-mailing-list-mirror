Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A74C1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 18:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757519AbeAISMd (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 13:12:33 -0500
Received: from elephants.elehost.com ([216.66.27.132]:10783 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbeAISMc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 13:12:32 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from secure.elehost.com (wolfserver.elehost.com [216.66.27.130])
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTP id w09ICUF0047470
        for <git@vger.kernel.org>; Tue, 9 Jan 2018 13:12:30 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Received: from 99.229.179.249
        (SquirrelMail authenticated user rsbecker)
        by secure.elehost.com with HTTP;
        Tue, 9 Jan 2018 13:12:30 -0500
Message-ID: <f08a9506afb73c57751d3d413bfb433a.squirrel@secure.elehost.com>
Date:   Tue, 9 Jan 2018 13:12:30 -0500
Subject: [PATCH] Prototype PATH_MAX length detection in tests, demonstrated
 in t0001-init.sh
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     git@vger.kernel.org
User-Agent: SquirrelMail/1.4.23 [SVN]
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch create a configuration variable PATH_MAX that
corresponds with the value in limits.h. The value of PATH_MAX,
if supplied, is added to BASIC_CFLAGS and will validate with
limits.h. PATH_MAX is also added to GIT-BUILD-OPTIONS and is
available in the git test suite.

This patch also creates a test_expected_success_cond, taking a
single function as first argument. In the t0001-init.sh case,
subtest 34 this function is test_path_max_is_sane, although any
0/1 returning function can be used. The prototype allows the long base
path test to be skipped if PATH_MAX is less than 2048 bytes.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 Makefile                |  9 +++++++++
 config.mak.uname        |  1 +
 t/t0001-init.sh         |  2 +-
 t/test-lib-functions.sh | 31 +++++++++++++++++++++++++++++++
 t/test-lib.sh           | 42 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 5543dd2..c9b96a6 100644
--- a/Makefile
+++ b/Makefile
@@ -151,6 +151,9 @@ all::
 # in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
 # wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
 #
+# Define PATH_MAX to limit the size of paths used by git and test scripts.
+# This value should be consistent with limits.h
+#
 # Define NEEDS_CRYPTO_WITH_SSL if you need -lcrypto when using -lssl
(Darwin).
 #
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto
(Darwin).
@@ -1431,6 +1434,9 @@ ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
 	BASIC_CFLAGS += -DSHA1_MAX_BLOCK_SIZE="$(SHA1_MAX_BLOCK_SIZE)"
 endif
+ifdef PATH_MAX
+	BASIC_CFLAGS += -DPATH_MAX="$(PATH_MAX)"
+endif
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
@@ -2283,6 +2289,9 @@ endif
 ifdef TEST_GIT_INDEX_VERSION
 	@echo TEST_GIT_INDEX_VERSION=\''$(subst ','\'',$(subst
','\'',$(TEST_GIT_INDEX_VERSION)))'\' >>$@+
 endif
+ifdef PATH_MAX
+	@echo PATH_MAX=\''$(subst ','\'',$(subst ','\'',$(PATH_MAX)))'\' >>$@+
+endif
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi

 ### Detect Python interpreter path changes
diff --git a/config.mak.uname b/config.mak.uname
index 3721cea..06ee503 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -442,6 +442,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	# Missdetected, hence commented out, see below.
 	#NO_CURL = YesPlease
 	# Added manually, see above.
+	PATH_MAX = 1024
 	NEEDS_SSL_WITH_CURL = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	HAVE_DEV_TTY = YesPlease
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index c4814d2..58dad87 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -315,7 +315,7 @@ test_expect_success 'init with separate gitdir' '
 	test_path_is_dir realgitdir/refs
 '

-test_expect_success 'init in long base path' '
+test_expect_success_cond 'test_path_max_is_sane' 'init in long base path' '
 	# exceed initial buffer size of strbuf_getcwd()
 	component=123456789abcdef &&
 	test_when_finished "chmod 0700 $component; rm -rf $component" &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 50a9a1d..67e24e9 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -430,6 +430,24 @@ test_expect_success () {
 	test_finish_
 }

+test_expect_success_cond () {
+	test_start_
+	test "$#" = 3 && { test_cond_func=$1; shift; } ||
+	error "bug in the test script: not parameters to test-expect-success-cond"
+	export test_cond_func
+	if ! test_skip_cond "$@"
+	then
+		say >&3 "expecting success: $2"
+		if test_run_ "$2"
+		then
+			test_ok_ "$1"
+		else
+			test_failure_ "$@"
+		fi
+	fi
+	test_finish_
+}
+
 # test_external runs external test scripts that provide continuous
 # test output about their progress, and succeeds/fails on
 # zero/non-zero exit code.  It outputs the test output on stdout even
@@ -536,6 +554,19 @@ test_path_is_dir () {
 	fi
 }

+test_path_max_is_sane() {
+	if test -z "$PATH_MAX"
+	then
+		retval=1
+	elif test $PATH_MAX -ge 2048
+	then
+		retval=1
+	else
+		retval=0
+	fi
+	return "$retval"
+}
+
 # Check if the directory exists and is empty as expected, barf otherwise.
 test_dir_is_empty () {
 	test_path_is_dir "$1" &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 30eb743..8d16e9e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -702,6 +702,48 @@ test_skip () {
 	esac
 }

+test_skip_cond () {
+	to_skip=
+	skipped_reason=
+	if match_pattern_list $this_test.$test_count $GIT_SKIP_TESTS
+	then
+		to_skip=t
+		skipped_reason="GIT_SKIP_TESTS"
+	fi
+	if test -z "$to_skip" && test -n "$test_cond_func"
+	then
+		to_skip=t
+
+		of_prereq=
+		${test_cond_func}
+		if [ $? -eq 0 ]
+		then
+			of_func=" of $test_cond_func"
+			to_skip=t
+		else
+			to_skip=f
+		fi
+		skipped_reason="failed conditional${of_func}"
+	fi
+	if test -z "$to_skip" && test -n "$run_list" &&
+		! match_test_selector_list '--run' $test_count "$run_list"
+	then
+		to_skip=t
+		skipped_reason="--run"
+	fi
+
+	case "$to_skip" in
+	t)
+		say_color skip >&3 "skipping test: $@"
+		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
+		: true
+		;;
+	*)
+		false
+		;;
+	esac
+}
+
 # stub; perf-lib overrides it
 test_at_end_hook_ () {
 	:
-- 
2.8.5.21.g9298251



