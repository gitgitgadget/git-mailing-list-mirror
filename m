Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECA8F1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 07:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeHXK7w (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 06:59:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:54356 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726305AbeHXK7w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 06:59:52 -0400
Received: (qmail 15452 invoked by uid 109); 24 Aug 2018 07:26:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Aug 2018 07:26:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24644 invoked by uid 111); 24 Aug 2018 07:26:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 24 Aug 2018 03:26:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Aug 2018 03:26:29 -0400
Date:   Fri, 24 Aug 2018 03:26:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/9] trailer-parsing false positives
Message-ID: <20180824072629.GA11977@sigill.intra.peff.net>
References: <20180821184140.GA24165@sigill.intra.peff.net>
 <20180821190705.GF30764@sigill.intra.peff.net>
 <xmqqin438pze.fsf@gitster-ct.c.googlers.com>
 <xmqqbm9v8pou.fsf@gitster-ct.c.googlers.com>
 <20180821200747.GA21955@sigill.intra.peff.net>
 <xmqq36v78ml8.fsf@gitster-ct.c.googlers.com>
 <20180823004300.GA1355@sigill.intra.peff.net>
 <xmqqefephr4x.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefephr4x.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23, 2018 at 11:30:54AM -0700, Junio C Hamano wrote:

> > Now here's the tricky part. I think patches 1-8 are mostly sensible.
> 
> Yeah, nothing that made me go "Huh?" in these 8 patches.  Thanks.
> 
> > So I think there may be further opportunities for cleanup here. I'm not
> > sure if we'd need to retain this behavior for git-interpret-trailers.
> > AFAICT it is not documented, and I suspect is mostly historical
> > accident, and not anything anybody ever wanted.
> 
> I tend to think the behaviour was not designed but it "just happens
> to work that way".

OK, so I've slept on it as promised, and looked at ignore_non_trailer()
a bit more closely.

It actually ignores three things:

 - comment blocks

 - "commit -v" cut lines

 - "Conflicts:" blocks for merges

I think I could see an argument for handling the third type everywhere,
if we wanted trailers to go above such a block (since they really are
part of the actual commit message). Of course, we try to make those
"Conflicts" blocks into comments these days. And looking at our history,
I had trouble finding many examples, since most of the old merges do not
have sign-offs in the first place.

There are a handful with the S-o-b below the conflict block (e.g.,
a24a32ddb). There are even some gems like 425b139313 and a5db4b127b)
where there is one sign-off above the block and one below. In our
history, there's nothing more recent than 2015, which is not incredibly
long after 261f315beb (merge & sequencer: turn "Conflicts:" hint into a
comment, 2014-10-28).

But in linux.git, I can find many examples from this year of Conflicts
blocks with the signoffs afterwards. And a few with the signoffs before
(e.g., ed09f6d05c).  I think the current code will do the right thing
either way when parsing those (if the trailers are after, we won't
exclude those, but if they're before, then we'll skip over the Conflicts
block).

So frankly, that all makes me afraid of touching any of it. I do think
it's probably doing the wrong thing in some cases, and we should
probably just make a rule like "trailers always go at the bottom, end of
story". But there are enough weird and historical cases, not to mention
potential interactions with git-commit, that I'd be quite likely to
regress some other case.

So my inclination is to punt on it for now, and go with my patches 1-8,
which fix an actual case that we saw in the real world, without creating
other problems.

I think patch 9 is not hurting anything and may later help us, but I
could take or leave it.

> > If we do keep it by default, then the "--no-divider" option I added in
> > patch 4 should probably get a more generic name and cover this.
> > Something like "--verbatim-input".
> 
> Perhaps.  Even if this is not covered, --verbatim-input would be a
> good name for the option ;-)

Possibly. :) What I was worried about is realizing that it's not really
"verbatim", though, but rather "some mystical set of rules including
nonsense like git-commit cut-lines". And so we should not over-promise
with the option name.

I'd also be OK to call it "verbatim" and consider it a to-be-fixed bug
that it still respects these weird rules. I'm just not sure I want to
spend more time digging on those weird rules now.

-Peff
