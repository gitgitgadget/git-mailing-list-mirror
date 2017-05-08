Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E5A11FDEA
	for <e@80x24.org>; Mon,  8 May 2017 07:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbdEHHbu (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 03:31:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:47245 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752553AbdEHHbt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 03:31:49 -0400
Received: (qmail 21072 invoked by uid 109); 8 May 2017 07:31:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 07:31:45 +0000
Received: (qmail 27068 invoked by uid 111); 8 May 2017 07:32:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 03:32:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 May 2017 03:31:43 -0400
Date:   Mon, 8 May 2017 03:31:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-objects: disable pack reuse for object-selection
 options
Message-ID: <20170508073143.lu73w5b54lvstty2@sigill.intra.peff.net>
References: <20170502084326.65eisqmr4th5cbf7@sigill.intra.peff.net>
 <xmqq4lww9cas.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4lww9cas.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2017 at 01:56:27PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If certain options like --honor-pack-keep, --local, or
> > --incremental are used with pack-objects, then we need to
> > feed each potential object to want_object_in_pack() to see
> > if it should be filtered out.  This is totally contrary to
> > the purpose of the pack-reuse optimization, which tries hard
> > to avoid doing any per-object work.  Therefore we need to
> > disable this optimization when these options are in use.
> 
> I read this five times, as I wanted to understand what you are
> saying, but I am not sure if I got it right.  One of the reasons why
> I was confused was that I originally thought this "reuse" was about
> delta reuse, but it is not.  It is "sending a slice of the original
> packfile straight to the output".

Right. The "send a slice" goes under the name "reuse_packfile" in the
code, but I'm not surprised you're not familiar with it. We added it
long ago as part of the bitmap feature, and it's not often talked about
(and in its current incarnation, isn't actually very useful; I have
patches to improve that, but haven't gotten around to upstreaming them).

> But even after getting myself out
> of that confusion, I still do not see why we "need to disable".
> Surely, even if we need to exclude some objects from an existing
> packfile due to these selection options, we should be able to reuse
> the non-excluded part, no?  The end result may involve having to
> pick and reuse more and smaller slices from existing packfiles,
> which may be much less efficient, but it is no immediately obvious
> to me if it leads to "need to disable".  I would understand it if it
> were "it becomes much less efficient and we are better off not using
> the bitmap code at all", though.

Yes, it's this last bit. The main win of the packfile reuse code is that
it builds on the bitmaps to avoid doing as much per-object work as
possible. So the objects don't even get added to the list of "struct
object_entry", and we never consider them for the "should they be in the
result" checks beyond the have/want computation done by the bitmaps.

We could add those checks in, but what's the point? The idea of the
reuse code is to be a fast path for serving vanilla clones. Searching
through all of the packfiles for a .keep entry is the antithesis of
that.

> Is the real reason why we want to disable the "reuse" because it is
> not easy to update the reuse_partial_packfile_from_bitmap() logic to
> take these selection options into account?  If so, I would also
> understand why this is a good change.

This is a side concern for the current form. With the patches I
mentioned above, it's not too hard to omit some objects and still reuse
the other bits verbatim. But again, even evaluating the function for
each pack is too expensive, even if the implementation supported it.

> > +test_expect_success 'pack reuse respects --honor-pack-keep' '
> > +	test_when_finished "rm -f .git/objects/pack/*.keep" &&
> > +	for i in .git/objects/pack/*.pack; do
> > +		>${i%.pack}.keep
> > +	done &&
> 
> Micronit: style.

I assume you mean putting "do" on a separate line. Sorry, the "; do" is
my native tongue and I sometimes slip back into it without thinking.

-Peff
