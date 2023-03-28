Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3829AC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 20:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjC1U2p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjC1U2m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 16:28:42 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F335730DD
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:28:40 -0700 (PDT)
Received: (qmail 2000 invoked by uid 109); 28 Mar 2023 20:28:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 20:28:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1892 invoked by uid 111); 28 Mar 2023 20:28:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 16:28:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 16:28:39 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: [PATCH 4/4] tests: skip test_eval_ in internal chain-lint
Message-ID: <20230328202839.GD1241631@coredump.intra.peff.net>
References: <20230328202043.GA1241391@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230328202043.GA1241391@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To check for broken &&-chains, we run "fail_117 && $1" as a test
snippet, and check the exit code. We use test_eval_ to do so, because
that's the way we run the actual test.

But we don't need any of its niceties, like "set -x" tracing. In fact,
they hinder us, because we have to explicitly disable them. So let's
skip that and use "eval" more directly, which is simpler. I had hoped it
would also be faster, but it doesn't seem to produce a measurable
improvement (probably because it's just running internal shell commands,
with no subshells or forks).

Note that there is one gotcha: even though we don't intend to run any of
the commands if the &&-chain is intact, an error like this:

   test_expect_success 'broken' '
	# this next line breaks the &&-chain
	true
	# and then this one is executed even by the linter
	return 1
   '

means we'll "return 1" from the eval, and thus from test_run_(). We
actually do notice this in test_expect_success, but only by saying "hey,
this test didn't say it was OK, so it must have failed", which is not
right (it should say "broken &&-chain").

We can handle this by calling test_eval_inner_() instead, which is our
trick for wrapping "return" in a test snippet. But to do that, we have
to push the trace code out of that inner function and into test_eval_().
This is arguably where it belonged in the first place, but it never
mattered because the "inner_" function had only one caller.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0048ec7b6f6..293caf0f20e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1041,10 +1041,7 @@ want_trace () {
 # (and we want to make sure we run any cleanup like
 # "set +x").
 test_eval_inner_ () {
-	# Do not add anything extra (including LF) after '$*'
-	eval "
-		want_trace && trace_level_=$(($trace_level_+1)) && set -x
-		$*"
+	eval "$*"
 }
 
 test_eval_ () {
@@ -1069,7 +1066,10 @@ test_eval_ () {
 	#     be _inside_ the block to avoid polluting the "set -x" output
 	#
 
-	test_eval_inner_ "$@" </dev/null >&3 2>&4
+	# Do not add anything extra (including LF) after '$*'
+	test_eval_inner_ </dev/null >&3 2>&4 "
+		want_trace && trace_level_=$(($trace_level_+1)) && set -x
+		$*"
 	{
 		test_eval_ret_=$?
 		if want_trace
@@ -1095,18 +1095,13 @@ test_run_ () {
 	expecting_failure=$2
 
 	if test "${GIT_TEST_CHAIN_LINT:-1}" != 0; then
-		# turn off tracing for this test-eval, as it simply creates
-		# confusing noise in the "-x" output
-		trace_tmp=$trace
-		trace=
 		# 117 is magic because it is unlikely to match the exit
 		# code of other programs
-		test_eval_ "fail_117 && $1"
+		test_eval_inner_ "fail_117 && $1" </dev/null >&3 2>&4
 		if test $? != 117
 		then
 			BUG "broken &&-chain: $1"
 		fi
-		trace=$trace_tmp
 	fi
 
 	setup_malloc_check
-- 
2.40.0.616.gf524ec75088
