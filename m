Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9241C433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 15:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347158AbhKXP6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:58:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:37750 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhKXP6g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 10:58:36 -0500
Received: (qmail 28666 invoked by uid 109); 24 Nov 2021 15:55:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Nov 2021 15:55:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14635 invoked by uid 111); 24 Nov 2021 15:55:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Nov 2021 10:55:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Nov 2021 10:55:22 -0500
From:   Jeff King <peff@peff.net>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] pager: fix crash when pager program doesn't exist
Message-ID: <YZ5gao4sZF3R9mD8@coredump.intra.peff.net>
References: <20211124145409.8779-1-ematsumiya@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211124145409.8779-1-ematsumiya@suse.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 24, 2021 at 11:54:09AM -0300, Enzo Matsumiya wrote:

> When prepare_cmd() fails for, e.g., pager process setup,
> child_process_clear() frees the memory in pager_process.args, but .argv
> was pointed to pager_process.args.v earlier in start_command(), so it's
> now a dangling pointer.
> 
> setup_pager() is then called a second time, from cmd_log_init_finish()
> in this case, and any further operations using its .argv, e.g. strvec_*,
> will use the dangling pointer and eventually crash. According to trivial
> tests, setup_pager() is not called twice if the first call is
> successful.
> 
> This patch makes sure that pager_process is properly initialized on
> setup_pager().
> 
> Add a test to catch possible regressions.

Oh, good. I just replied in the separate thread suggesting this
direction, but I see you had already sent this. :)

This patch looks good to me. Two small nits:

> diff --git a/pager.c b/pager.c
> index 52f27a6765c8..d93304527d62 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -124,6 +124,8 @@ void setup_pager(void)
>  
>  	setenv("GIT_PAGER_IN_USE", "true", 1);
>  
> +	child_process_init(&pager_process);
> +

You could drop the CHILD_PROCESS_INIT initializer in the declaration of
pager_process now. I'm OK with keeping it, though, as a
belt-and-suspenders thing. If we don't run setup_pager() at all I don't
think anybody should look at it (since we won't have installed our
signal/atexit cleanup handlers), but it doesn't hurt.

> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> index 0e7cf75435ec..0be9bcba49a8 100755
> --- a/t/t7006-pager.sh
> +++ b/t/t7006-pager.sh
> @@ -786,4 +786,9 @@ test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
>  	test_path_is_file pager-used
>  '
>  
> +test_expect_success TTY 'handle attempt to run an invalid pager' '
> +	test_config pager.show invalid-pager &&
> +	test_terminal git show
> +'

Yep, this should trigger the bug. I agree with Eric that "non-existent"
is probably more descriptive, as the key thing here is that
start_command() fails immediately, rather than us piping to the broken
pager.

-Peff
