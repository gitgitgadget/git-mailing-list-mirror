Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4474C1F915
	for <e@80x24.org>; Sat, 14 Jul 2018 21:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbeGNVkN (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 17:40:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:59632 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731213AbeGNVkN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 17:40:13 -0400
Received: (qmail 28200 invoked by uid 109); 14 Jul 2018 21:19:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 14 Jul 2018 21:19:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3576 invoked by uid 111); 14 Jul 2018 21:19:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 14 Jul 2018 17:19:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jul 2018 17:19:50 -0400
Date:   Sat, 14 Jul 2018 17:19:50 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Vitali Lovich <vlovich@gmail.com>
Subject: Re: [PATCH v2] sequencer: pass absolute GIT_WORK_TREE to exec
 commands
Message-ID: <20180714211950.GA6430@sigill.intra.peff.net>
References: <20180714175555.GD1042117@genre.crustytoothpaste.net>
 <20180714183859.97988-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180714183859.97988-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 14, 2018 at 06:38:59PM +0000, brian m. carlson wrote:

> The sequencer currently passes GIT_DIR, but not GIT_WORK_TREE, to exec
> commands.  In that configuration, we assume that whatever directory
> we're in is the top level of the work tree, and git rev-parse
> --show-toplevel responds accordingly.  However, when we're in a
> subdirectory, that isn't correct: we respond with the subdirectory as
> the top level, resulting in unexpected behavior.
> 
> Ensure that we pass GIT_WORK_TREE as well as GIT_DIR so that git
> operations within subdirectories work correctly.
> 
> Note that we are guaranteed to have a work tree in this case: the
> relevant sequencer functions are called only from revert, cherry-pick,
> and rebase--helper; all of these commands require a working tree.

Thanks for digging into this corner case.

It's possible, of course, that some day we may have a caller without a
work-tree, but it seems pretty unlikely for sequencer code. If we did,
then:

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

I think this would just segfault (feeding NULL to absolute_path). That's
probably OK, as it would be a big red flag to whomever is trying to
teach the sequencer to work in a bare repo. :)

So this version looks good to me.

-Peff
