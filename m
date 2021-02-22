Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7136C433E9
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A188064F6E
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhBVTOV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 14:14:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:40596 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232709AbhBVTLv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 14:11:51 -0500
Received: (qmail 21430 invoked by uid 109); 22 Feb 2021 19:11:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Feb 2021 19:11:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15903 invoked by uid 111); 22 Feb 2021 19:11:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Feb 2021 14:11:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Feb 2021 14:11:02 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 2/2] test-lib-functions: use BUG() in 'test_must_fail'
Message-ID: <YDQBxqTbuYgq1xV8@coredump.intra.peff.net>
References: <20210221192512.3096291-1-szeder.dev@gmail.com>
 <20210221192512.3096291-2-szeder.dev@gmail.com>
 <YDLXf+OoJabrJTWu@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDLXf+OoJabrJTWu@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 21, 2021 at 04:58:23PM -0500, Jeff King wrote:

> This is a bit intimate with the magic 7 descriptor. I think it would be
> cleaner to trigger the bug in a sub-test. We do have helpers for that,
> like:
> [...]
> This is modeled after other similar tests. I find the use of
> check_sub_test_lib_test_err here a bit verbose, but I think we could
> also easily do:
> 
>   grep "bug in the test.*only .git. is allowed" bug-fail-nongit/err

In case it helps, here is a patch which can go on top of yours that
implements my suggestion using the (IMHO) more readable grep.

It also adds "test_done" to the sub-test snippets, which my earlier
patch did not include. That's not strictly necessary (we should error
out before we even get there), but it makes the test more robust (we are
sure that the BUG is what caused us to exit non-zero, not the missing
test_done).

> Note that there are some other cases which could likewise be converted
> (the one for test_bool_env, which I noticed when grepping for "7>" when
> investigating the first patch).

That looks like the only other one, and I think is likewise worth
converting (which is in the patch below).

I thought it first it was also a problem that test_bool_env does not use
BUG to catch invalid values. But I think it is trying to make its
message a bit less confusing when the user is the one who provided us
with the invalid value, such as setting GIT_TEST_GIT_DAEMON=nonsense. We
do still exit the test script immediately, though, which is the right
thing.

It does use BUG to complain when test_bool_env didn't get two
parameters, but we don't bother to test it. We could.

-- >8 --
Subject: [PATCH] t0000: put bug/error checks into a sub-test

When checking whether test_bool_env and test_must_fail correctly trigger
errors or bugs, we run them in a subshell (to avoid their "exit" calls
impacting the greater script) with descriptor 7 redirected (to catch
their direct-to-user output). Let's instead run them using our sub-test
helpers. That gives us a more accurate view of what a calling user sees,
and avoids knowing details like the magic of descriptor 7.

Note that I didn't use check_sub_test_lib_test_err here. We don't really
care what (if anything) is printed on stdout, as long as we see our
expected error on stderr. Plus using grep makes it easier to formulate
the expected text (e.g., using "." instead of tricky quoting).

Signed-off-by: Jeff King <peff@peff.net>
---
This does end up with more lines, and certainly more processes, than the
original. I do think the conceptual cleanliness is worth it, though.

 t/t0000-basic.sh | 50 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index b9d5c6c404..e5c06d055b 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -981,20 +981,32 @@ test_expect_success 'test_bool_env' '
 
 		envvar=false &&
 		! test_bool_env envvar true &&
-		! test_bool_env envvar false &&
+		! test_bool_env envvar false
+	)
+'
 
+test_expect_success 'test_bool_env invalid value' '
+	run_sub_test_lib_test_err invalid-bool-value "invalid value" <<-\EOF &&
+	test_expect_success "invalid bool" "
 		envvar=invalid &&
-		# When encountering an invalid bool value, test_bool_env
-		# prints its error message to the original stderr of the
-		# test script, hence the redirection of fd 7, and aborts
-		# with "exit 1", hence the subshell.
-		! ( test_bool_env envvar true ) 7>err &&
-		grep "error: test_bool_env requires bool values" err &&
+		export envvar &&
+		test_bool_env envvar true
+	"
+	test_done
+	EOF
+	grep "error: test_bool_env requires bool values" invalid-bool-value/err
+'
 
+test_expect_success 'test_bool_env invalid default' '
+	run_sub_test_lib_test_err invalid-bool-default "invalid default" <<-\EOF &&
+	test_expect_success "invalid bool" "
 		envvar=true &&
-		! ( test_bool_env envvar invalid ) 7>err &&
-		grep "error: test_bool_env requires bool values" err
-	)
+		export envvar &&
+		test_bool_env envvar default
+	"
+	test_done
+	EOF
+	grep "error: test_bool_env requires bool values" invalid-bool-default/err
 '
 
 ################################################################
@@ -1315,13 +1327,23 @@ test_expect_success 'test_must_fail on a failing git command with env' '
 '
 
 test_expect_success 'test_must_fail rejects a non-git command' '
-	! ( test_must_fail grep ^$ notafile ) 7>err &&
-	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
+	run_sub_test_lib_test_err bug-fail-nongit "fail nongit" <<-\EOF &&
+	test_expect_success "non-git command" "
+		test_must_fail grep ^$ notafile
+	"
+	test_done
+	EOF
+	grep "bug.*test_must_fail: only .git. is allowed" bug-fail-nongit/err
 '
 
 test_expect_success 'test_must_fail rejects a non-git command with env' '
-	! ( test_must_fail env var1=a var2=b grep ^$ notafile ) 7>err &&
-	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
+	run_sub_test_lib_test_err bug-fail-env "fail nongit with env" <<-\EOF &&
+	test_expect_success "non-git command with env" "
+		test_must_fail env var1=a var2=b grep ^$ notafile
+	"
+	test_done
+	EOF
+	grep "bug.*test_must_fail: only .git. is allowed" bug-fail-env/err
 '
 
 test_done
-- 
2.30.1.1033.gd525307ce1


