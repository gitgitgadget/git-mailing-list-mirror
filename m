Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBCC61F858
	for <e@80x24.org>; Wed,  3 Aug 2016 17:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbcHCRMs (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 13:12:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:53928 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932481AbcHCRMr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 13:12:47 -0400
Received: (qmail 7525 invoked by uid 102); 3 Aug 2016 17:11:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 13:11:27 -0400
Received: (qmail 2941 invoked by uid 107); 3 Aug 2016 17:11:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 13:11:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 13:11:24 -0400
Date:	Wed, 3 Aug 2016 13:11:24 -0400
From:	Jeff King <peff@peff.net>
To:	Santiago Torres <santiago@nyu.edu>
Cc:	Git <git@vger.kernel.org>
Subject: Re: [OT] USENIX paper on Git
Message-ID: <20160803171124.yzm5xs67empuka7o@sigill.intra.peff.net>
References: <20160801224043.4qmf56pmv27riq4i@LykOS.localdomain>
 <20160803145830.uwssj4uhqfemhr4o@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160803145830.uwssj4uhqfemhr4o@LykOS.localdomain>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 10:58:31AM -0400, Santiago Torres wrote:

> I will be presenting a paper regarding the Git metadata issues that we
> discussed at the beginning on the year on USENIX '16. I'm writing To
> make everyone in this ML aware that this work exists and to bring
> everyone into the loop.
> 
> I'm open for feedback and corrections. If anything seems odd imprecise
> to the community, I can make an errata in the presentation (at least).
> I'll also try to work towards making corrections anywhere if possible;
> this is my first publication, so I wasn't sure if it was possible to
> share things before they are published. Thankfully, this is OK in
> USENIX's book. Here's the link:

I read it over. As far as technical descriptions of Git, it looked OK.
I found a few minor nits, but nothing worth caring about (e.g., ref
storage is not quite so simple these days as 40 bytes in a file, but
there is no point describing the whole packed-refs scheme in your paper,
as it does not change anything with respect to your work).

Here are my comments on the work itself. They're critical, but meant in
a friendly way. :)

As far as the attack goes, I'm still not convinced this is all that
_interesting_ an attack in the real world. What it boils down to is: the
ref state is not signed or authenticated in any way, so somebody who can
compromise your server repo or do a MiTM can lie about where the refs
are (even if individual commits are signed).

So if you want to treat Git as a cryptographic end-to-end distribution
mechanism, then no, it fails horribly at that. But the state of the art
in source code distribution, no matter which system you use, is much
less advanced than that. People download tarballs, even ones with GPG
signatures, all the time without verifying their contents. Most packages
distribute a sha1sum or similar (sometimes even gpg-signed), but quite
often the source of authority is questionable.

For example, consider somebody downloading a new package for the first
time. They don't know the author in any out-of-band way, so any
signatures are likely meaningless. They _might_ be depending on the
source domain for some security (and using some hierarchical PKI like
TLS+x.509 to be sure they're talking to that domain), but in your threat
model, even well-known hosts like FSF could be compromised internally.

So yes, I think the current state of affairs (especially open-source) is
that people download and run possibly-compromised code all the time. But
I'm not sure that lack of tool support is really the limiting factor. Or
that it has turned out to be all that big a problem in practice.

Anyway. As far as your solution goes, I'll admit I skimmed over the
details, but it looks like basically a sequence of signatures producing
a chain of state (so the tip state is signed, but you can also make sure
the chain connects from your current state to what the server claims is
the new tip state, and not a replay of some old state). Please correct
me if that's not accurate. :)

Without having thought too hard about it, it seems like you could do the
same thing with push certs, as they have both a "before" and "after" for
each ref. So if in addition to fetching the refs from a server, I fetch
all of the push certs, I should be able to walk the chain of push certs
from the one at my current state, to the one at the tip state, making
sure that each one builds on the last.

There are two cases that I don't think that handles, but that I also
don't see are handled in your solution:

  - if I am cloning for the first time, I have no "current" state to
    base the chain from. An attacker could serve me any old signed ref
    state, and I have no way to know that it's old (except perhaps by
    seeing the wall-clock timestamp and comparing it to my clock; this
    isn't a proof but may be cause for suspicion if it's too old)

  - if there is a chain of signatures, the attacker must follow the
    chain, but they can always withhold links from the end. So imagine a
    repository has held a sequence of signed states (A, B, C), that B
    has a bug, C has the fix, and I am at A. An attacker can serve me B
    and I cannot know without out-of-band information that it is not the
    correct tip (because until C was created, it _was_ the correct tip).

    I think this is actually a generalization of the cloning issue
    (where state "A" is simply "I have no existing state yet").

So it seems like there is room for better tooling around push-certs
(e.g., to fetch and verify the chaining automatically). I think git in
general is quite weak in automatic tooling for verifications. There are
room for signatures in the data format and tools for checking that the
bytes haven't been touched, but there's almost nothing to tell you that
signatures make any sense, tools for handling trust, etc.

I think your solution also had some mechanisms for adding trusted keys
as part of the hash chain. I'm not convinced that's something that
should be part of git's solution in particular, and not an out-of-band
thing handled as part of the PKI. Because it's really a group key
management problem, and applies to anything you might sign.

-Peff
