Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2784FC433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 06:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E396C6140C
	for <git@archiver.kernel.org>; Thu, 13 May 2021 06:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhEMG1E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 02:27:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:53228 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhEMG1D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 02:27:03 -0400
Received: (qmail 31692 invoked by uid 109); 13 May 2021 06:25:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 May 2021 06:25:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13397 invoked by uid 111); 13 May 2021 06:25:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 May 2021 02:25:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 May 2021 02:25:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH] t: avoid sed-based chain-linting in some expensive cases
Message-ID: <YJzGcZpZ+E9R0gYd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 878f988350 (t/test-lib: teach --chain-lint to detect broken
&&-chains in subshells, 2018-07-11) introduced additional chain-lint
tests which add an extra "sed" pipeline to each test we run. This has a
measurable impact on runtime. Here are timings with and without a new
environment variable (added by this patch) that lets you disable just
the additional sed-based chain-lint tests:

  Benchmark #1: GIT_TEST_CHAIN_LINT_HARDER=1 make test
    Time (mean ± σ):     64.202 s ±  1.030 s    [User: 622.469 s, System: 301.402 s]
    Range (min … max):   61.571 s … 65.662 s    10 runs

  Benchmark #2: GIT_TEST_CHAIN_LINT_HARDER=0 make test
    Time (mean ± σ):     57.591 s ±  0.333 s    [User: 529.368 s, System: 270.618 s]
    Range (min … max):   57.143 s … 58.309 s    10 runs

  Summary
    'GIT_TEST_CHAIN_LINT_HARDER=0 make test' ran
      1.11 ± 0.02 times faster than 'GIT_TEST_CHAIN_LINT_HARDER=1 make test'

Of course those extra lint checks are doing something useful, so paying
a few extra seconds (at least on Linux) isn't so bad (though note the
CPU time; we're bounded in our parallel run here by the slowest test, so
it really is ~120s of CPU improvement).

But we can observe that there are some test scripts where they produce a
much stronger effect, and provide less value. In t0027 and t3070 we run
a very large number of small tests, all driven by a series of
functions/loops which are filling in the test bodies. There we get much
less bang for our buck in terms of bug-finding versus CPU cost.

This patch introduces a mechanism for controlling when those extra
lint checks are run, at two levels:

  - a user can ask to disable or to force-enable the checks by setting
    GIT_TEST_CHAIN_LINT_HARDER

  - if the user hasn't specified a preference, individual scripts can
    disable the checks by setting GIT_TEST_CHAIN_LINT_HARDER_DEFAULT;
    scripts which don't set that get the current behavior of enabling
    them.

In addition, this patch flips the default for t0027 and t3070's
mass-generated sections to disable the extra checks. Here are the timing
results for t0027:

  Benchmark #1: GIT_TEST_CHAIN_LINT_HARDER=1 ./t0027-auto-crlf.sh
    Time (mean ± σ):     17.078 s ±  0.848 s    [User: 14.878 s, System: 7.075 s]
    Range (min … max):   15.952 s … 18.421 s    10 runs

  Benchmark #2: GIT_TEST_CHAIN_LINT_HARDER=0 ./t0027-auto-crlf.sh
    Time (mean ± σ):      9.063 s ±  0.759 s    [User: 7.890 s, System: 3.362 s]
    Range (min … max):    7.747 s … 10.619 s    10 runs

  Benchmark #3: ./t0027-auto-crlf.sh
    Time (mean ± σ):      9.186 s ±  0.881 s    [User: 7.957 s, System: 3.427 s]
    Range (min … max):    7.796 s … 10.498 s    10 runs

  Summary
    'GIT_TEST_CHAIN_LINT_HARDER=0 ./t0027-auto-crlf.sh' ran
      1.01 ± 0.13 times faster than './t0027-auto-crlf.sh'
      1.88 ± 0.18 times faster than 'GIT_TEST_CHAIN_LINT_HARDER=1 ./t0027-auto-crlf.sh'

We can see that disabling the checks for the whole script buys us an
almost 2x speedup. But the new default behavior, disabling them only for
the mass-generated part, gets us most of that speedup (but still leaves
the checks on for further manual tests people might write).

  As a side note, I'd caution about comparing runtimes and CPU seconds
  between this timing and the earlier "make test" one. In "make test",
  we're running a lot of scripts in parallel, so the CPU is throttling
  down (and thus a CPU second saved here would count for more during a
  parallel run; the same work takes more CPU seconds there).

We get similar results for t3070:

  Benchmark #1: GIT_TEST_CHAIN_LINT_HARDER=1 ./t3070-wildmatch.sh
    Time (mean ± σ):     20.054 s ±  3.967 s    [User: 16.003 s, System: 8.286 s]
    Range (min … max):   11.891 s … 23.671 s    10 runs

  Benchmark #2: GIT_TEST_CHAIN_LINT_HARDER=0 ./t3070-wildmatch.sh
    Time (mean ± σ):     12.399 s ±  2.256 s    [User: 7.542 s, System: 5.342 s]
    Range (min … max):    9.606 s … 15.727 s    10 runs

  Benchmark #3: ./t3070-wildmatch.sh
    Time (mean ± σ):     10.726 s ±  3.476 s    [User: 6.790 s, System: 4.365 s]
    Range (min … max):    5.444 s … 15.376 s    10 runs

  Summary
    './t3070-wildmatch.sh' ran
      1.16 ± 0.43 times faster than 'GIT_TEST_CHAIN_LINT_HARDER=0 ./t3070-wildmatch.sh'
      1.87 ± 0.71 times faster than 'GIT_TEST_CHAIN_LINT_HARDER=1 ./t3070-wildmatch.sh'

Again, we get almost a 2x speedup disabling these. In this case, there
are no tests not covered by the script's "default to disable" behavior,
so the second two benchmarks should be the same (and while they do
differ, you can see the variance is quite high but they're within one
standard deviation).

So it seems like for these two scripts, at least, disabling the extra
checks is a reasonable tradeoff. Sadly, the overall runtime of "make
test" on my system doesn't get much faster. But that's because we're
mostly limited by the cost of the single biggest test. Here are the
top-5 tests by wall-clock time from a parallel run, before my patch:

  57.9192368984222 t9001-send-email.sh
  45.6329638957977 t0027-auto-crlf.sh
  32.5278220176697 t3070-wildmatch.sh
  22.2701289653778 t7610-mergetool.sh
  20.8635759353638 t1701-racy-split-index.sh

And after:

  57.1476998329163 t9001-send-email.sh
  33.776211977005 t0027-auto-crlf.sh
  21.3116669654846 t7610-mergetool.sh
  20.7748689651489 t1701-racy-split-index.sh
  19.6957249641418 t7112-reset-submodule.sh

We dropped 12s from t0027, and t3070 dropped off our list entirely at
around 16s. In both cases we're bound by t9001, but its slowness is
due to the actual tests, so we'll have to deal with it in a different
way. But this reduces overall CPU, and means that dealing with t9001 (by
improving the speed of send-email or splitting it apart) will let us
reduce our overall runtime even on multi-core machines.

Signed-off-by: Jeff King <peff@peff.net>
---
This is one of the speedups I mentioned earlier in:

  https://lore.kernel.org/git/YJxmHbHAn4x93xsr@coredump.intra.peff.net/

but it's really independent of Ævar's your work on send-email (of course
once he makes t9001 faster, then these two scripts become the most
expensive :) ).

I suspect t3070 could be made faster still by consolidating some of its
1890 test cases (e.g., testing multiple related variants in a single
invocation of git, reducing the number of processes needed). But it
looks non-trivial, and I think this extra chain-lint knob is a good tool
to have in our belt anyway.

 t/README             | 5 +++++
 t/t0027-auto-crlf.sh | 7 ++++++-
 t/t3070-wildmatch.sh | 5 +++++
 t/test-lib.sh        | 7 +++++--
 4 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/t/README b/t/README
index 8eb9e46b1d..6f28819406 100644
--- a/t/README
+++ b/t/README
@@ -196,6 +196,11 @@ appropriately before running "make". Short options can be bundled, i.e.
 	this feature by setting the GIT_TEST_CHAIN_LINT environment
 	variable to "1" or "0", respectively.
 
+	A few test scripts disable some of the more advanced
+	chain-linting detection in the name of efficiency. You can
+	override this by setting the GIT_TEST_CHAIN_LINT_HARDER
+	environment variable to "1".
+
 --stress::
 	Run the test script repeatedly in multiple parallel jobs until
 	one of them fails.  Useful for reproducing rare failures in
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index d24d5acfbc..4a5c5c602c 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -386,7 +386,9 @@ test_expect_success 'setup main' '
 	test_tick
 '
 
-
+# Disable extra chain-linting for the next set of tests. There are many
+# auto-generated ones that are not worth checking over and over.
+GIT_TEST_CHAIN_LINT_HARDER_DEFAULT=0
 
 warn_LF_CRLF="LF will be replaced by CRLF"
 warn_CRLF_LF="CRLF will be replaced by LF"
@@ -597,6 +599,9 @@ do
 	checkout_files     auto  "$id" ""     false   native   $NL   CRLF  CRLF_mix_LF  LF_mix_CR    LF_nul
 done
 
+# The rest of the tests are unique; do the usual linting.
+unset GIT_TEST_CHAIN_LINT_HARDER_DEFAULT
+
 # Should be the last test case: remove some files from the worktree
 test_expect_success 'ls-files --eol -d -z' '
 	rm crlf_false_attr__CRLF.txt crlf_false_attr__CRLF_mix_LF.txt crlf_false_attr__LF.txt .gitattributes &&
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 891d4d7cb9..56ea4bda13 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -4,6 +4,11 @@ test_description='wildmatch tests'
 
 . ./test-lib.sh
 
+# Disable expensive chain-lint tests; all of the tests in this script
+# are variants of a few trivial test-tool invocations, and there are a lot of
+# them.
+GIT_TEST_CHAIN_LINT_HARDER_DEFAULT=0
+
 should_create_test_file() {
 	file=$1
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index adaa2db601..adaf03543e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -947,8 +947,11 @@ test_run_ () {
 		trace=
 		# 117 is magic because it is unlikely to match the exit
 		# code of other programs
-		if $(printf '%s\n' "$1" | sed -f "$GIT_BUILD_DIR/t/chainlint.sed" | grep -q '?![A-Z][A-Z]*?!') ||
-			test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
+		if test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)" ||
+		   {
+			test "${GIT_TEST_CHAIN_LINT_HARDER:-${GIT_TEST_CHAIN_LINT_HARDER_DEFAULT:-1}}" != 0 &&
+			$(printf '%s\n' "$1" | sed -f "$GIT_BUILD_DIR/t/chainlint.sed" | grep -q '?![A-Z][A-Z]*?!')
+		   }
 		then
 			BUG "broken &&-chain or run-away HERE-DOC: $1"
 		fi
-- 
2.31.1.1030.g25c0337765
