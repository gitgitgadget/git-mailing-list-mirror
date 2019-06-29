Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD0201F461
	for <e@80x24.org>; Sat, 29 Jun 2019 00:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfF2AO7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 20:14:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:54710 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726643AbfF2AO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 20:14:59 -0400
Received: (qmail 16029 invoked by uid 109); 29 Jun 2019 00:14:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 29 Jun 2019 00:14:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22050 invoked by uid 111); 29 Jun 2019 00:15:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Jun 2019 20:15:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2019 20:14:57 -0400
Date:   Fri, 28 Jun 2019 20:14:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] test-lib: introduce test_commit_bulk
Message-ID: <20190629001457.GD2625@sigill.intra.peff.net>
References: <20190628093751.GA3569@sigill.intra.peff.net>
 <20190628093911.GA27329@sigill.intra.peff.net>
 <xmqqlfxl8ul6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfxl8ul6.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 10:53:41AM -0700, Junio C Hamano wrote:

> > +	in_dir=${indir:+-C "$indir"}
> 
> I thought that this assignment to $in_dir would be unnecessary if we
> parsed -C directly into it, i.e.

Heh, sorry for the confusion. That in_dir is leftover cruft. I was
trying to see if I could then expand it as:

  git $in_dir some-cmd ...

to make the git calls more readable. But that doesn't work if $indir has
whitespace, so I abandoned it (we're relying on whitespace splitting
between "-C" and the argument, but we don't want it split on the
argument).

I _also_ mispelled $indir as $in_dir in that attempt, which meant that
the leftover line did not break anything, and I didn't notice. But it
can just go away.

> 		-C)
> 			in_dir="-C $indir"
> 			shift
> 			;;
> 		...
> 
> but you probably could pass -C '' to defeat an $in_dir that was set
> earlier by using a separate variable?

I don't know if "-C ''" works with Git or not. I had contemplated
defaulting indir to ".", so that we did:

  git -C . command ...

which I think would work (at the minor cost of a useless chdir() inside
the C process).

In the end I just stole the technique that test_commit uses. It's a
little ugly, but there are only 3 calls.

> Reading further, though, I do not seem to see where this variable is
> referred to, and that is the answer to my puzzlement.  This must be
> a leftover that was written once before but no longer is used.  We
> can remove $in_dir while keeping the initialization and assignment
> to $indir as-is, I think.

Yes. :)

> All uses of $indir in the remainder of the function look $IFS-safe,
> which is good.

Yeah, I think it should be (though since most callers pass relative
paths for these kind of one-off -C uses, it's actually pretty rare for
it to matter).

-Peff
