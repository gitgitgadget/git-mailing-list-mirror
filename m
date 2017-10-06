Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB33620372
	for <e@80x24.org>; Fri,  6 Oct 2017 19:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbdJFTWz (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 15:22:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:35650 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752796AbdJFTWy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 15:22:54 -0400
Received: (qmail 24415 invoked by uid 109); 6 Oct 2017 19:22:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 19:22:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9278 invoked by uid 111); 6 Oct 2017 19:22:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 15:22:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Oct 2017 15:22:52 -0400
Date:   Fri, 6 Oct 2017 15:22:52 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] tests: use shell negation instead of test_must_fail
 for test_cmp
Message-ID: <20171006192252.3a27enzim5yurhe5@sigill.intra.peff.net>
References: <20171006190006.19623-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171006190006.19623-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 06, 2017 at 12:00:05PM -0700, Stefan Beller wrote:

> The `test_must_fail` should only be used to indicate a git command is
> failing. `test_cmp` is not a git command, such that it doesn't need the
> special treatment of `test_must_fail` (which e.g. includes checking for
> segfault)

Hmph. "test_must_fail test_cmp" is a weird thing for somebody to write.
And your patch is obviously an improvement, but I have to wonder if some
of these make any sense.

If we're expecting some outcome, then it's reasonable to say:

  1. The output should look exactly like this. (test_cmp)

  2. The output should look something like this. (grep)

  3. The output should _not_ mention this (! grep)

But "the output should not look exactly like this" doesn't seem very
robust. It's likely to give a false success due to small changes (or
translations), or even bugs in the script.

For instance:

> diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
> index a267b2d144..c31141c471 100755
> --- a/t/t3504-cherry-pick-rerere.sh
> +++ b/t/t3504-cherry-pick-rerere.sh
> @@ -95,7 +95,7 @@ test_expect_success 'cherry-pick --rerere-autoupdate more than once' '
>  test_expect_success 'cherry-pick conflict without rerere' '
>  	test_config rerere.enabled false &&
>  	test_must_fail git cherry-pick master &&
> -	test_must_fail test_cmp expect foo
> +	! test_cmp expect foo
>  '

Running ./t3504 with "-v" (with or without your patch) shows:

  --- expect	2017-10-06 19:14:43.677840120 +0000
  +++ foo	2017-10-06 19:14:43.705840120 +0000
  @@ -1 +1 @@
  -fatal: cherry-pick: --no-rerere-autoupdate cannot be used with --continue
  +foo-dev

Which just seems like a bug.  Did the original author mean foo-expect?
It's hard to tell, as we are just reusing expectations from previous
tests.

> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> index 02106c9226..7178b917ce 100755
> --- a/t/t5512-ls-remote.sh
> +++ b/t/t5512-ls-remote.sh
> @@ -56,7 +56,7 @@ test_expect_success 'use "origin" when no remote specified' '
>  
>  test_expect_success 'suppress "From <url>" with -q' '
>  	git ls-remote -q 2>actual_err &&
> -	test_must_fail test_cmp exp_err actual_err
> +	! test_cmp exp_err actual_err
>  '

This one seems like "test_18ngrep ! ^From" would be more appropriate. Or
even "test_must_be_empty".

> diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
> index fac5a73851..5f9ad51929 100755
> --- a/t/t5612-clone-refspec.sh
> +++ b/t/t5612-clone-refspec.sh
> @@ -87,7 +87,7 @@ test_expect_success 'by default no tags will be kept updated' '
>  		git for-each-ref refs/tags >../actual
>  	) &&
>  	git for-each-ref refs/tags >expect &&
> -	test_must_fail test_cmp expect actual &&
> +	! test_cmp expect actual &&
>  	test_line_count = 2 actual

Here we check that no updates happened due to a fetch because we see
that the tags in the fetched repo do not match the tags in the parent
repo. That actually seems pretty legitimate. But I think:

  git for-each-ref refs/tags >before
  git fetch
  git for-each-ref refs/tags >after
  test_cmp before after

would be more straightforward.

> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index 93f162a4f7..1644866571 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -1532,7 +1532,7 @@ test_expect_success '"status.branch=true" same as "-b"' '
>  test_expect_success '"status.branch=true" different from "--no-branch"' '
>  	git status -s --no-branch  >expected_nobranch &&
>  	git -c status.branch=true status -s >actual &&
> -	test_must_fail test_cmp expected_nobranch actual
> +	! test_cmp expected_nobranch actual
>  '

Shouldn't this be comparing it positively to the output with "--branch"?

>  test_expect_success '"status.branch=true" weaker than "--no-branch"' '
> diff --git a/t/t9164-git-svn-dcommit-concurrent.sh b/t/t9164-git-svn-dcommit-concurrent.sh
> index d8464d4218..5cd6b40432 100755
> --- a/t/t9164-git-svn-dcommit-concurrent.sh
> +++ b/t/t9164-git-svn-dcommit-concurrent.sh
> @@ -92,7 +92,7 @@ test_expect_success 'check if post-commit hook creates a concurrent commit' '
>  		echo 1 >> file &&
>  		svn_cmd commit -m "changing file" &&
>  		svn_cmd up &&
> -		test_must_fail test_cmp auto_updated_file au_file_saved
> +		! test_cmp auto_updated_file au_file_saved
>  	)
>  '

This one looked complicated, so I leave it as an exercise for the
reader. :)

-Peff
