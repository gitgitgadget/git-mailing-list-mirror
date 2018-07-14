Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 903641F915
	for <e@80x24.org>; Sat, 14 Jul 2018 00:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbeGNBOG (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 21:14:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:59112 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729658AbeGNBOG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 21:14:06 -0400
Received: (qmail 11988 invoked by uid 109); 14 Jul 2018 00:57:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 14 Jul 2018 00:57:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8763 invoked by uid 111); 14 Jul 2018 00:57:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 13 Jul 2018 20:57:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jul 2018 20:57:03 -0400
Date:   Fri, 13 Jul 2018 20:57:03 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Vitali Lovich <vlovich@gmail.com>
Subject: Re: [PATCH] sequencer: pass absolute GIT_WORK_TREE to exec commands
Message-ID: <20180714005702.GA20399@sigill.intra.peff.net>
References: <20180713230548.GC1042117@genre.crustytoothpaste.net>
 <20180714003505.67650-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180714003505.67650-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 14, 2018 at 12:35:05AM +0000, brian m. carlson wrote:

> diff --git a/sequencer.c b/sequencer.c
> index 5354d4d51e..c8e16f9168 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2636,6 +2636,8 @@ static int do_exec(const char *command_line)
>  	fprintf(stderr, "Executing: %s\n", command_line);
>  	child_argv[0] = command_line;
>  	argv_array_pushf(&child_env, "GIT_DIR=%s", absolute_path(get_git_dir()));
> +	argv_array_pushf(&child_env, "GIT_WORK_TREE=%s",
> +			 absolute_path(get_git_work_tree()));
>  	status = run_command_v_opt_cd_env(child_argv, RUN_USING_SHELL, NULL,
>  					  child_env.argv);
>  

As a general rule of "always pass GIT_WORK_TREE with GIT_DIR", you have
to deal with the case where there _isn't_ a work tree. Are we OK here
because this code is inside sequencer.c, and you cannot do a sequencer
operation without a work tree?

This all seemed vaguely familiar, so I dug up 2cd83d10bb (setup:
suppress implicit "." work-tree for bare repos, 2013-03-08), which
handles a similar case in the alias code.

So I think it would also work to set:

  GIT_IMPLICIT_WORK_TREE=0

here. But if the answer to my "are we OK" above is yes, I am fine with
either that solution or the one you show here (but I think the commit
message should probably mention it).

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 352a52e59d..d03055d149 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -119,6 +119,15 @@ test_expect_success 'rebase -i with exec allows git commands in subdirs' '
>  	)
>  '
>  
> +test_expect_success 'rebase -i sets work tree properly' '
> +	test_when_finished "rm -rf subdir" &&
> +	test_when_finished "test_might_fail git rebase --abort" &&
> +	mkdir subdir &&
> +	git rebase -x "(cd subdir && git rev-parse --show-toplevel)" HEAD^ \
> +		>actual &&
> +	! grep "/subdir$" actual
> +'

This test looks good to me.

-Peff
