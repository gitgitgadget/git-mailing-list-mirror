Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DDA120899
	for <e@80x24.org>; Thu, 27 Jul 2017 14:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbdG0OfM (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 10:35:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:50526 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751760AbdG0OfK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 10:35:10 -0400
Received: (qmail 3853 invoked by uid 109); 27 Jul 2017 14:35:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Jul 2017 14:35:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1798 invoked by uid 111); 27 Jul 2017 14:35:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Jul 2017 10:35:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Jul 2017 10:35:08 -0400
Date:   Thu, 27 Jul 2017 10:35:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Fwd: Should "head" also work for "HEAD" on case-insensitive FS?
Message-ID: <20170727143507.bezad7dnthx4nqtc@sigill.intra.peff.net>
References: <87ziclb2pa.fsf@gmail.com>
 <20170704071909.phs4bf5ybdord2lv@tigra>
 <87van8boe9.fsf@gmail.com>
 <20170705083611.jgxbp4sqogicfwdb@sigill.intra.peff.net>
 <xmqqshiaizhz.fsf@gitster.mtv.corp.google.com>
 <xmqqo9sxdwjp.fsf@gitster.mtv.corp.google.com>
 <CAMy9T_FmE=8xzjRJJRxLwQjoMStJx5sYO_xtODv2OEZm54DurA@mail.gmail.com>
 <xmqqa84c6v41.fsf@gitster.mtv.corp.google.com>
 <CAPc5daXj4sBuWP0r6t0nArXt1DJW+9byT49M_g8LcjrqBMJnRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPc5daXj4sBuWP0r6t0nArXt1DJW+9byT49M_g8LcjrqBMJnRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 26, 2017 at 05:49:47PM -0700, Junio C Hamano wrote:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> > I think the most natural thing would be to use different encoding
> > rules for pseudo-refs (references like "HEAD" and "FETCH_HEAD") and
> > for other references (those starting with "refs/").
> >
> > Pseudo-refs (with the partial exception of "HEAD") are quite peculiar
> > beasts....
> 
> I agree with the reasoning, but what I am worried about is that
> their handling in the existing refs.c code may be leaky and/or
> inconsistent.
> 
> What I saw was that a test have ended up with .git/%46%4F%4F when it
> was told to create a ref "FOO" (which indicates that "FOO" was
> passed to the files backend), which later failed to read it back
> because the pseudo_ref handling refs.c wanted to see ".git/FOO" on
> the reading side.
> 
> Perhaps it is only a bug in t/t1405-main-ref-store.sh?

An interesting related issue for pseudo-refs: if you encode HEAD as
.git/%48%45%41%44, how will we recognize that directory as a git
repository? Detecting (and doing a sanity check on) "HEAD" is one of the
key mechanisms for deciding whether we are in a git repository.

Obviously an older version of git that doesn't know about the new
encoding scheme wouldn't work on this repository anyway. But:

  1. It should say "this is a git repo, but not a vintage I understand".
     Not "this isn't a git repo, I'll keep looking".

  2. How does a git version of the correct vintage decide "this is a git
     repo, so I'll check its config for extensions.refBackend, and a-ha,
     they _do_ have a HEAD". There's a chicken-and-egg problem.

Obviously for (2) we could teach that mechanism to look for the encoded
HEAD file, too. But this is just one backend. What about a reftable or
other non-filesystem store that keeps "HEAD" inside a file?

I kind of wonder if more exotic ref storage backends should always just
place a dummy "HEAD" file that is enough to bootstrap the "this is a git
repo" process (for both new and old versions).

This is orthogonal to the rest of the pseudo-refs discussion, but just
something I thought of while reading the thread.

-Peff
