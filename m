Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A0C920966
	for <e@80x24.org>; Tue,  4 Apr 2017 06:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbdDDGvG (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 02:51:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:56364 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbdDDGvF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 02:51:05 -0400
Received: (qmail 8549 invoked by uid 109); 4 Apr 2017 06:51:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Apr 2017 06:51:00 +0000
Received: (qmail 4297 invoked by uid 111); 4 Apr 2017 06:51:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Apr 2017 02:51:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Apr 2017 02:50:59 -0400
Date:   Tue, 4 Apr 2017 02:50:59 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug in "git am" when the body starts with spaces
Message-ID: <20170404065059.3p3lzxj64mrvdtpi@sigill.intra.peff.net>
References: <CA+55aFypmFkc4gOEea-AF1kKYb3K=6nosXvYS4AMGFOQHw0ZxA@mail.gmail.com>
 <CA+55aFwcQuxwhQ+LABmev2XRHgOqsbRm7YDYn3FDDXKMYcF-CA@mail.gmail.com>
 <CA+55aFwmNuvh_ABtnd_uxXv5HjEjN-+HMZGh_u1OjOCa4dbpmg@mail.gmail.com>
 <20170402041838.dzkmibc5lq37sm3h@sigill.intra.peff.net>
 <f3f2b6f0-c6bb-f50a-5030-61afe941eb23@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3f2b6f0-c6bb-f50a-5030-61afe941eb23@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 03, 2017 at 10:42:46AM -0700, Jonathan Tan wrote:

> On 04/01/2017 09:18 PM, Jeff King wrote:
> > On Sat, Apr 01, 2017 at 12:03:44PM -0700, Linus Torvalds wrote:
> > > The logic is fairly simple: if we encounter an empty line, and we have
> > > pending in-body headers, we flush the pending headers, and mark us as
> > > no longer in header mode.
> > 
> > Hmm. I think this may work. At first I thought it was too strict in
> > always checking inbody_header_accum.len, because we want this to kick in
> > always, whether there's whitespace continuation or not. But that
> > accumulator has to collect preemptively, before it knows if there's
> > continuation. So it will always be non-empty if we've seen _any_ header,
> > and it will remain non-empty as long as we keep parsing (because any
> > time we flush, we do so in order to handle another line).
> > 
> > IOW, I think this implements the state-machine thing I wrote in my
> > earlier email, because the state "are we inside in-body header parsing"
> > is always reflected by having a non-empty accumulator. It is a bit
> > non-obvious though.
> 
> About obviousness, I think of a non-empty accumulator merely representing
> that the next line could potentially be a continuation line. And it is
> coincidence that this implies "are we inside in-body header parsing"; if not
> all in-body header lines could be "continued", there would be no such
> implication.
> 
> mi->inbody_header_accum.len is already used in check_inbody_header to mean
> "could the next line potentially be a continuation line" and to trigger a
> check for a negative criterion (in this case, a scissors line). I think it's
> fine to do the same thing, the negative criterion here being a blank line.

FWIW, I looked into making a single "state" variable, but it actually
got ugly pretty quickly. I think not because it's not a cleaner method
in the long run, but just because the existing code is so dependent on
individual state variables that needed changing. So I'm OK with Linus's
fix; it certainly follows the existing code patterns.

-Peff
