Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43C6C433E0
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 21:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20A964EBE
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 21:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhBUV7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Feb 2021 16:59:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:39802 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhBUV7E (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Feb 2021 16:59:04 -0500
Received: (qmail 14799 invoked by uid 109); 21 Feb 2021 21:58:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 21 Feb 2021 21:58:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3045 invoked by uid 111); 21 Feb 2021 21:58:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 21 Feb 2021 16:58:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 21 Feb 2021 16:58:23 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 2/2] test-lib-functions: use BUG() in 'test_must_fail'
Message-ID: <YDLXf+OoJabrJTWu@coredump.intra.peff.net>
References: <20210221192512.3096291-1-szeder.dev@gmail.com>
 <20210221192512.3096291-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210221192512.3096291-2-szeder.dev@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 21, 2021 at 08:25:12PM +0100, SZEDER Gábor wrote:

> In many test helper functions we verify that they were invoked with
> sensible parameters, and call BUG() to abort the test script when the
> parameters are buggy.  6a67c75948 (test-lib-functions: restrict
> test_must_fail usage, 2020-07-07) added such a parameter verification
> to 'test_must_fail', but it didn't report the error with BUG(), like
> we usually do.

OK. I do not care all that much between BUG() and not-BUG here, since we
are unlikely to have a test where test_must_fail returning 0 yields
success. I guess the most interesting outcome is that we would notice a
bug in a test_expect_failure block.

> The two tests checking that 'test_must_fail' recognizes invalid
> parameters need some updates:
> 
>   - BUG() calls 'exit 1' to abort the test script, but we don't want
>     that to happen while testing 'test_must_fail' itself, so in those
>     tests we must invoke that function in a subshell.
>   - These tests check that 'test_must_fail' failed with the
>     appropriate error message, but BUG() sends its error message to a
>     different file descriptor, so update the redirection accordingly.

This is a bit intimate with the magic 7 descriptor. I think it would be
cleaner to trigger the bug in a sub-test. We do have helpers for that,
like:

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index b9d5c6c404..b3fd740452 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1315,13 +1315,25 @@ test_expect_success 'test_must_fail on a failing git command with env' '
 '
 
 test_expect_success 'test_must_fail rejects a non-git command' '
-	! ( test_must_fail grep ^$ notafile ) 7>err &&
-	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
+	cmd="grep ^$ notafile" &&
+	run_sub_test_lib_test_err bug-fail-nongit "fail nongit" <<-EOF &&
+	test_expect_success "non-git command" "test_must_fail $cmd"
+	EOF
+	check_sub_test_lib_test_err bug-fail-nongit <<-\EOF_OUT 3<<-EOF_ERR
+	EOF_OUT
+	> error: bug in the test script: test_must_fail: only ${SQ}git${SQ} is allowed: $cmd
+	EOF_ERR
 '
 
 test_expect_success 'test_must_fail rejects a non-git command with env' '
-	! ( test_must_fail env var1=a var2=b grep ^$ notafile ) 7>err &&
-	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
+	cmd="env var1=a var2=b grep ^$ notafile" &&
+	run_sub_test_lib_test_err bug-fail-env "fail nongit with env" <<-EOF &&
+	test_expect_success "non-git command with env" "test_must_fail $cmd"
+	EOF
+	check_sub_test_lib_test_err bug-fail-env <<-\EOF_OUT 3<<-EOF_ERR
+	EOF_OUT
+	> error: bug in the test script: test_must_fail: only ${SQ}git${SQ} is allowed: $cmd
+	EOF_ERR
 '
 
 test_done

This is modeled after other similar tests. I find the use of
check_sub_test_lib_test_err here a bit verbose, but I think we could
also easily do:

  grep "bug in the test.*only .git. is allowed" bug-fail-nongit/err

Note that there are some other cases which could likewise be converted
(the one for test_bool_env, which I noticed when grepping for "7>" when
investigating the first patch).

>  test_expect_success 'test_must_fail rejects a non-git command' '
> -	! test_must_fail grep ^$ notafile 2>err &&
> +	! ( test_must_fail grep ^$ notafile ) 7>err &&
>  	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
>  '

Holy double-quoting batman! I do think using $SQ or just "." (if using
grep) to match single-quotes makes things more readable. Obviously not
something you're introducing, but perhaps worth addressing as we touch
this test.

-Peff
