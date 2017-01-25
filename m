Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05B5F1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 19:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbdAYTrq (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 14:47:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:44690 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751056AbdAYTrq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 14:47:46 -0500
Received: (qmail 29810 invoked by uid 109); 25 Jan 2017 19:47:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 19:47:45 +0000
Received: (qmail 15049 invoked by uid 111); 25 Jan 2017 19:47:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 14:47:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 14:47:43 -0500
Date:   Wed, 25 Jan 2017 14:47:43 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 07/12] fetch-pack: cache results of for_each_alternate_ref
Message-ID: <20170125194743.5dl5cypyoeciqcyq@sigill.intra.peff.net>
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
 <20170124004559.vlsrwwphuzdsfqoq@sigill.intra.peff.net>
 <xmqqinp3aqu0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqinp3aqu0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 11:21:11AM -0800, Junio C Hamano wrote:

> > diff --git a/object.h b/object.h
> > index 614a00675..f52957dcb 100644
> > --- a/object.h
> > +++ b/object.h
> > @@ -29,7 +29,7 @@ struct object_array {
> >  /*
> >   * object flag allocation:
> >   * revision.h:      0---------10                                26
> > - * fetch-pack.c:    0---4
> > + * fetch-pack.c:    0---5
> >   * walker.c:        0-2
> >   * upload-pack.c:       4       11----------------19
> >   * builtin/blame.c:               12-13
> 
> This is a tangent, but I am not sure how much it buys us to keep
> track of the information here in object.h, as all that picture says
> is "revision traversal machinery given by revision.[ch] can never be
> used inside fetch-pack and upload-pack", and that is already said by
> the current picture that says fetch-pack.c uses 0 thru 4, and
> updating it to say that we now use 0 thru 5 would not change the
> conclusion.

I agree that bumping 4 to 5 does not help at all, given the current
allocations. But it could eventually, if another allocation wanted to
pick up 5, and might plausibly be used together with fetch-pack.

The main thing is that we should keep this up to date, and that it
should cause textual conflicts when two topics update the allocation, so
that a human looks at it. I actually think we fail at the latter,
because a change to revision.h to use bit 20 would probably get
auto-resolved against a change to allocate the same bit to blame.c.

Probably a better organization is:

  bit 0: revision.h, fetch-pack.c, walker.c
  bit 1: revision.h, fetch-pack.c, walker.c
  ...
  bit 10: revision.h
  bit 11: upload-pack.c

and so forth. It's more tedious to read and write, but any two changes
to the same bit would be forced to generate a conflict (assuming a
line-oriented merge, of course :) ).

> What I am trying to get at is that we may want to (re)consider how
> we manage these bits.  But that is totally outside the scope of this
> series, and updating the above is the right thing to do here.

Perhaps you meant something like the above when you said this. But what
I'd _really_ love is to stop using global bits entirely, and have some
way to allocate a bitset and efficiently convert "struct object" to an
index into the bitset. Then cleaning up just becomes throwing out your
bitset, and by default operations do not see the bits from other
unrelated operations. That makes it impossible to have bugs like the one
fixed by 5c08dc48a (checkout: clear commit marks after detached-orphan
check, 2011-03-20).

I can't think of a way to do that efficiently besides something like the
commit-slab system, but extended to all objects. The lookups there are
fairly cheap, though it does have worse cache performance. I don't know
if that would matter in practice or not.

But yeah, definitely outside the scope of this series. :)

-Peff
