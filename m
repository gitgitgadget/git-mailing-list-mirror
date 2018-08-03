Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE7CF1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 13:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbeHCPWd (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 11:22:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:41726 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731364AbeHCPWc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 11:22:32 -0400
Received: (qmail 2955 invoked by uid 109); 3 Aug 2018 13:26:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Aug 2018 13:26:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1561 invoked by uid 111); 3 Aug 2018 13:26:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 03 Aug 2018 09:26:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2018 09:26:10 -0400
Date:   Fri, 3 Aug 2018 09:26:10 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com
Subject: Re: [GSoC][PATCH v4 15/20] rebase -i: rewrite write_basic_state() in
 C
Message-ID: <20180803132610.GA28939@sigill.intra.peff.net>
References: <20180710121557.6698-1-alban.gruin@gmail.com>
 <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180724163221.15201-16-alban.gruin@gmail.com>
 <20180730182516.32644-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180730182516.32644-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 08:25:16PM +0200, SZEDER Gábor wrote:

> > diff --git a/sequencer.c b/sequencer.c
> > index 1c035ceec7..d257903db0 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> 
> > +int write_basic_state(struct replay_opts *opts, const char *head_name,
> > +		      const char *onto, const char *orig_head)
> > +{
> > +	const char *quiet = getenv("GIT_QUIET");
> > +
> > +	if (head_name)
> > +		write_file(rebase_path_head_name(), "%s\n", head_name);
> > +	if (onto)
> > +		write_file(rebase_path_onto(), "%s\n", onto);
> > +	if (orig_head)
> > +		write_file(rebase_path_orig_head(), "%s\n", orig_head);
> > +
> > +	if (quiet)
> > +		write_file(rebase_path_quiet(), "%s\n", quiet);
> > +	else
> > +		write_file(rebase_path_quiet(), "");
> 
> This is not a faithful conversion of the original.  git-rebase.sh writes
> this 'quiet' file with:
> 
>   echo "$GIT_QUIET" > "$state_dir"/quiet
> 
> which means that a single newline character was written even when
> $GIT_QUIET was unset/empty.

write_file() will call strbuf_complete_line(), so even passing "" will
result in a file with a newline in it (I didn't dig, but this comes from
e7ffa38c in 2015, so it may well have been a response to the breakage
you were thinking of).

So actually all of the "%s\n" here can be just "%s".

But there _is_ a reason not to use "", which is that it triggers
-Wformat-zero-length (which is part of -Wall unless you explicitly turn
it off, which our DEVELOPER=1 setup does). For a long time you _had_ to
do that, but these days we're actually clean with respect to that
warning.

So using "\n" here is better, and likewise here:

> > +	if (opts->verbose)
> > +		write_file(rebase_path_verbose(), "");

Unless we really do want a zero-length file, in which case:

  write_file_buf(path, "", 0);

is the right option. That matches the shell version, but I'd be
surprised if it mattered, since it's clearly meant to be "if this file
exists, we're verbose".

-Peff
