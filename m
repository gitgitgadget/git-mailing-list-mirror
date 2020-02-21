Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E5CC35640
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 05:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A26D20637
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 05:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgBUF6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 00:58:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:50102 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725973AbgBUF6w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 00:58:52 -0500
Received: (qmail 15836 invoked by uid 109); 21 Feb 2020 05:58:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Feb 2020 05:58:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16385 invoked by uid 111); 21 Feb 2020 06:07:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Feb 2020 01:07:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Feb 2020 00:58:51 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        rhi@pengutronix.de
Subject: Re: [PATCH] describe: output tag's ref instead of embedded name
Message-ID: <20200221055851.GE1280313@coredump.intra.peff.net>
References: <xmqqd0abk7zc.fsf@gitster-ct.c.googlers.com>
 <20200218195402.GA21586@coredump.intra.peff.net>
 <xmqq4kvnijim.fsf@gitster-ct.c.googlers.com>
 <xmqqzhdfh3vr.fsf@gitster-ct.c.googlers.com>
 <20200219015733.GA81560@coredump.intra.peff.net>
 <xmqqr1yrgt2d.fsf@gitster-ct.c.googlers.com>
 <20200219035650.GA84414@coredump.intra.peff.net>
 <xmqqftf6hlrt.fsf@gitster-ct.c.googlers.com>
 <20200220112539.GB1252160@coredump.intra.peff.net>
 <xmqq4kvlcgcz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4kvlcgcz.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 09:34:36AM -0800, Junio C Hamano wrote:

> > The "-g$objectname" one is kind of clever, and definitely not something
> > I had thought of. We already have "--long", and of course we'd show the
> > long version for any name that isn't an exact match anyway. So as an
> > added bonus, it seems unlikely to surprise anybody who is expecting the
> > current "show the tag, not the refname" output (though again, this is
> > rare enough that I think people simply expect them to be the same ;) ).
> 
> There is one thing you may have brought up in the discussion but I
> did not touch.  Using v1.0-0-g0123456, based on tagname "v1.0" Bob
> gave to it would still describe the right object, but if the user
> forced "--no-long", it becomes unclear what we should do.

I think "--no-long" is not "do not ever write a long name". It is
"counteract an earlier request to _always_ print long names". I.e.:

  $ git describe --no-long v2.25.1^
  v2.25.0-99-g6141e0cc00

still produces long output regardless of your patch. And if we continue
to do so in the wrongly-named case (which your patch seems to), that
would be consistent.

> Another thing that is not satisfying is what should happen in "all"
> mode.  We add "tags/" prefix so in the case we've been discussing,
> the output would be "tags/v1.0-0-g0123456", but the whole reason why
> we add the prefix is to say that the early part of the name, "v1.0",
> is a tag, and it would be natural to associate it with refs/tags/v1.0
> that is *not* Bob's tag.

I agree that is not fantastic, but the same problem is there to some
degree even without the "tags/" prefix. The prefix just makes you think
more of the ref namespace. :) I think it's the best we can do, given
that we'll also have just issued a warning.

Speaking of which...

> Having said all that, here is what I have at this moment.
> [...]
> While at it, remove an overly cautious dead code to protect against
> an annotated tag object without the tagname.  Such a tag is filtered
> out much earlier in the codeflow, and will not reach this part of
> the code.

This patch also reverses the order of the warning from "is really" to
"is externally known as", but I didn't see it mentioned in the commit
message.

-Peff
