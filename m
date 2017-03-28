Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A41511FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 20:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932149AbdC1UiW (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 16:38:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:53237 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752605AbdC1UiV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 16:38:21 -0400
Received: (qmail 14968 invoked by uid 109); 28 Mar 2017 20:38:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 20:38:17 +0000
Received: (qmail 28692 invoked by uid 111); 28 Mar 2017 20:38:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 16:38:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 16:38:14 -0400
Date:   Tue, 28 Mar 2017 16:38:14 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH RFC 2/2] diff: teach diff to expand tabs in output
Message-ID: <20170328203814.36aiocj53wtfcjz5@sigill.intra.peff.net>
References: <20170328122209.4861-1-jacob.e.keller@intel.com>
 <20170328122209.4861-2-jacob.e.keller@intel.com>
 <xmqqk279cjfs.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xqA9ZOfaeVg0wjgXVs=N=OJUZjjY1pahUn2xbvSQohfUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xqA9ZOfaeVg0wjgXVs=N=OJUZjjY1pahUn2xbvSQohfUQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 01:05:40PM -0700, Jacob Keller wrote:

> On Tue, Mar 28, 2017 at 12:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Jacob Keller <jacob.e.keller@intel.com> writes:
> >
> >> I'm really not a fan of how the ws code ended up. It seems pretty ugly
> >> and weird to hack in the expand_tabs stuff here. However, I'm really not
> >> sure how else I could handle this. Additionally, I'm not 100% sure
> >> whether this interacts with format-patch or other machinery which may
> >> well want some way to be excluded. Thoughts?
> >
> > As long as you do the same as "do we color the output?  no, no, we
> > are format-patch and must not color" logic to refrain from expanding
> > the tabs, you should be OK.
> >
> >> I think there also may be some wonky bits when performing the tab
> >> expansion during whitespace checks, due to the way we expand, because I
> >> don't think that the tabexpand function takes into account the "current"
> >> location when adding a string, so it very well may not be correct.... I
> >> am unsure if there is a good way to fix this.
> >
> > This "feature" is limited to the diff output, so one way may be to
> > leave the code as-is and pipe the output to a filter that is similar
> > to /usr/bin/expand but knows that the first column is special (this
> > is the part that "this is limited to diff" kicks in).  You may even
> > be able to implement it as a new option to "expand(1)" and then
> > people who aren't Git users would also benefit.
> >
> 
> That makes more sense. I'll take a look at that. It might even be
> possible to modify the pager setup so that it does that as part of its
> process.

This is similar to how I use diff-highlight, which is basically:

  [pager]
  log = diff-highlight | less
  show = diff-highlight | less
  diff = diff-highlight | less

I've wanted to move diff-highlight inside git, but ran into ugly
conflicts with the whitespace-marking code as well. Something like:

  git show b16a991c1be5681b4b673d4343dfcc0c2f5ad498 |
  perl -pe 's/^(.)(\t+)/$1 . (" " x (length($2) * 8))/e'

But sticking it in your pager pipeline is tough, because you actually
need to skip over the color bytes when they are present. You can see in
diff-highlight how this is handled.

That also means an option to something like "expand" is tough, because
"first character" really means "first non-ANSI-code character".

-Peff
