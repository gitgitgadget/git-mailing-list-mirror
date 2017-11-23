Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2BAA20954
	for <e@80x24.org>; Thu, 23 Nov 2017 04:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbdKWEAV (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 23:00:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:38360 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752350AbdKWEAV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 23:00:21 -0500
Received: (qmail 17432 invoked by uid 109); 23 Nov 2017 04:00:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Nov 2017 04:00:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6810 invoked by uid 111); 23 Nov 2017 04:00:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 22 Nov 2017 23:00:37 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Nov 2017 23:00:19 -0500
Date:   Wed, 22 Nov 2017 23:00:19 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: [PATCH] defer expensive load_ref_decorations until needed
Message-ID: <20171123040018.GA21706@sigill>
References: <20171121234336.10209-1-phil.hord@gmail.com>
 <20171122212710.GB2854@sigill>
 <CABURp0rq9pwFWuBbrSB-FNUQ6B-7V8uL=Drw6O1-151u_cRKww@mail.gmail.com>
 <20171122234841.GD8577@sigill>
 <xmqqy3mxrb29.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3mxrb29.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 23, 2017 at 11:19:42AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > And lazy-load wouldn't help you there for a normal:
> >
> >   git log
> >
> > But what's interesting in your command is the pretty-format. Even though
> > decoration is turned on, your format doesn't show any. So we never
> > actually ask "is this commit decorated" and the lazy-load helps.
> 
> Hmph, I wonder if we can detect this case and not make a call to
> load decorations in the first place.  That would remove the need to
> remember the options when load is called so that we can use it when
> we load decorations lazily later.

Probably userformat_find_requirements() could (and should) be taught to
report on decoration flags, like it does for notes. As it is now we call
load_ref_decorations() repeatedly while processing the commits (which
works because it's a noop after the first call).

And once we can do that, it would be easy to do something like:

  if (decoration_style && !want->decorations)
	decoration_style = 0;

But I think that may only be part of the story. Do all of the output
formats show decorations? I think --format=email, for instance, does
not.

So the real question is not just "does the user format want
decorations", but "does the pretty format want decorations". Which
requires knowing things about each format that might get out of sync
with the rest of the code. That might be OK if it lives in pretty.c. But
the lazy-load thing make sit just work without having to duplicate the
logic at all.

-Peff
