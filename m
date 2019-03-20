Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9909220248
	for <e@80x24.org>; Wed, 20 Mar 2019 05:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfCTFEw (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 01:04:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:57310 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725942AbfCTFEw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 01:04:52 -0400
Received: (qmail 18641 invoked by uid 109); 20 Mar 2019 05:04:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Mar 2019 05:04:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5284 invoked by uid 111); 20 Mar 2019 05:05:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 20 Mar 2019 01:05:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2019 01:04:50 -0400
Date:   Wed, 20 Mar 2019 01:04:50 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [REGRESSION ps/stash-in-c] git stash show -v
Message-ID: <20190320050449.GA6401@sigill.intra.peff.net>
References: <20190319190503.GA10066@dev-l>
 <20190319231826.GB32487@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190319231826.GB32487@hank.intra.tgummerer.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 19, 2019 at 11:18:26PM +0000, Thomas Gummerer wrote:

> From a quick search I couldn't find where 'git diff' actually parses
> the '-v' argument, but I wonder if we should actually disallow it, in
> case we want to use it for something else in the future?  It's not
> documented anywhere in the docs either.

It's a bit interesting, actually. git-diff uses setup_revisions() to
parse its arguments, which picks up any diff options, as well as parsing
the revs and pathspecs.

But it also means we accept any random revision options. So nonsense
like:

  git diff --ancestry-path HEAD^ HEAD

is accepted, even though nobody ever looks at the flags set by parsing
that option.

And "-v" is mostly in the same boat. It works more or less like --pretty
(try rev-list with and without it), and does nothing for an endpoint
diff. What's a little interesting, though, is that it was originally
added as a diff-tree option in the very early days, via cee99d2257
(diff-tree: add "verbose header" mode, 2005-05-06). And the reason there
is that "diff-tree --stdin" filled a "log"-like role; it didn't traverse
the commits itself, but it was responsible for showing them.

Most of that is historical curiosity, but I think the takeaways are:

  - we probably should use a less bizarre option to demonstrate this bug
    (Junio suggested --patience, which makes perfect sense to me)

  - we may want to teach the "diff" porcelain not to accept useless
    revision options. I suspect it may be a bit tricky, just because of
    the way the code takes advantage of setup_revisions.  It would also
    be nice if "diff-tree" in non-stdin mode could do the same, but I
    suspect that is even trickier (we do not even know whether we are in
    --stdin mode or not until we've fed the options to setup_revisions).
    So I'd guess this is not really worth the effort it would take.

  - "-v" is a real thing; we should consider either documenting it or
    deprecating it.

-Peff
