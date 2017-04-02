Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A6B720964
	for <e@80x24.org>; Sun,  2 Apr 2017 04:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750803AbdDBESp (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 00:18:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:55574 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750768AbdDBESp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 00:18:45 -0400
Received: (qmail 16592 invoked by uid 109); 2 Apr 2017 04:18:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 02 Apr 2017 04:18:40 +0000
Received: (qmail 21844 invoked by uid 111); 2 Apr 2017 04:18:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 02 Apr 2017 00:18:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Apr 2017 00:18:38 -0400
Date:   Sun, 2 Apr 2017 00:18:38 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug in "git am" when the body starts with spaces
Message-ID: <20170402041838.dzkmibc5lq37sm3h@sigill.intra.peff.net>
References: <CA+55aFypmFkc4gOEea-AF1kKYb3K=6nosXvYS4AMGFOQHw0ZxA@mail.gmail.com>
 <CA+55aFwcQuxwhQ+LABmev2XRHgOqsbRm7YDYn3FDDXKMYcF-CA@mail.gmail.com>
 <CA+55aFwmNuvh_ABtnd_uxXv5HjEjN-+HMZGh_u1OjOCa4dbpmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFwmNuvh_ABtnd_uxXv5HjEjN-+HMZGh_u1OjOCa4dbpmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 01, 2017 at 12:03:44PM -0700, Linus Torvalds wrote:

> On Fri, Mar 31, 2017 at 5:52 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The continuation logic is oddly complex, and I can't follow the logic.
> > But it is completely broken in how it thinks empty lines are somehow
> > "continuations".
> 
> The attached patch seems to work for me. Comments?
> 
> The logic is fairly simple: if we encounter an empty line, and we have
> pending in-body headers, we flush the pending headers, and mark us as
> no longer in header mode.

Hmm. I think this may work. At first I thought it was too strict in
always checking inbody_header_accum.len, because we want this to kick in
always, whether there's whitespace continuation or not. But that
accumulator has to collect preemptively, before it knows if there's
continuation. So it will always be non-empty if we've seen _any_ header,
and it will remain non-empty as long as we keep parsing (because any
time we flush, we do so in order to handle another line).

IOW, I think this implements the state-machine thing I wrote in my
earlier email, because the state "are we inside in-body header parsing"
is always reflected by having a non-empty accumulator. It is a bit
non-obvious though.

-Peff
