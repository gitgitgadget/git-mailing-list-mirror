Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C71D1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 19:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754588AbdBNTzY (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 14:55:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:55262 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753807AbdBNTzV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 14:55:21 -0500
Received: (qmail 16132 invoked by uid 109); 14 Feb 2017 19:55:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 19:55:15 +0000
Received: (qmail 6060 invoked by uid 111); 14 Feb 2017 19:55:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 14:55:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 14:55:13 -0500
Date:   Tue, 14 Feb 2017 14:55:13 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] show-branch: fix crash with long ref name
Message-ID: <20170214195513.7zae6x22advkrms6@sigill.intra.peff.net>
References: <20170214154816.12625-1-chriscool@tuxfamily.org>
 <20170214172526.hzpm3d3ubd3vjnzr@sigill.intra.peff.net>
 <xmqqlgt88t0r.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgt88t0r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 11:35:48AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This fixes the problem, but I think we can simplify it quite a bit by
> > using resolve_refdup(). Here's the patch series I ended up with:
> >
> >   [1/3]: show-branch: drop head_len variable
> >   [2/3]: show-branch: store resolved head in heap buffer
> >   [3/3]: show-branch: use skip_prefix to drop magic numbers
> >
> >  builtin/show-branch.c | 39 ++++++++++++---------------------------
> >  1 file changed, 12 insertions(+), 27 deletions(-)
> 
> Yes, the whole thing is my fault ;-) and I agree with what these
> patches do.
> 
> The second one lacks free(head) but I think that is OK; it is
> something we allocate in cmd_*() and use pretty much thruout the
> rest of the program.

Yes, I actually tested the whole thing under ASAN (which was necessary
to notice the problem), which complained about the leak. I don't mind
adding a free(head), but there are a bunch of similar "leaks" in that
function, so I didn't bother.

I notice Christian's patch added a few tests. I don't know if we'd want
to squash them in (I didn't mean to override his patch at all; I was
about to send mine out when I noticed his, and I wondered if we wanted
to combine the two efforts).

-Peff
