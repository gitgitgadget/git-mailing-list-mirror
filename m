Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 215BD20248
	for <e@80x24.org>; Thu, 21 Mar 2019 09:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfCUJvF (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 05:51:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:58816 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726551AbfCUJvF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 05:51:05 -0400
Received: (qmail 11012 invoked by uid 109); 21 Mar 2019 09:51:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Mar 2019 09:51:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8557 invoked by uid 111); 21 Mar 2019 09:51:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Mar 2019 05:51:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2019 05:51:03 -0400
Date:   Thu, 21 Mar 2019 05:51:03 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [PATCH v2] stash: setup default diff output format if necessary
Message-ID: <20190321095103.GB2894@sigill.intra.peff.net>
References: <20190319190503.GA10066@dev-l>
 <20190319231826.GB32487@hank.intra.tgummerer.com>
 <20190320224955.GE32487@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320224955.GE32487@hank.intra.tgummerer.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 20, 2019 at 10:49:55PM +0000, Thomas Gummerer wrote:

> I think this also deserves some explanation of what didn't change,
> especially after what I said in [*1*].  We're still not using the
> 'diff_opt_parse()' option parser, as it doesn't understand '-v' for
> example.  'setup_revisions()' understands that, but 'diff_opt_parse()'
> doesn't, so we'd still have a change in behaviour at least there.
> After discovering that I gave up on that approach.

Yeah, I think this would get into the "why are we even looking at
revision options" thing, which really is a separate topic. Let's do the
minimal fix here.

> The other thing that was pointed out is the 'diff_setup_done()' call
> here.  'diff_setup_done()' is already called inside of
> 'setup_revisions()', so we don't need to do it again, unless we change
> the output format, which is what we are doing here.  In fact this is
> the same way it's implemented in 'builtin/diff.c'.

That makes me wonder if any part of diff_setup_done() could be surprised
at being called twice. I guess not, if nobody has reported a bug in
git-diff. :)

There is a "set_default" callback that was added by 6c374008b1
(diff_opt: track whether flags have been set explicitly, 2013-05-10),
but it looks like it was never actually used. I think the theory is that
cases like this could do their tweaking in such a callback. But I think
it makes sense to follow the lead of builtin/diff.c for the immediate
fix, and we can look at using set_default as a separate topic.

-Peff
