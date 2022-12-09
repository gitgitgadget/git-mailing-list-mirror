Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B7BC4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 20:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLIUj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 15:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLIUj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 15:39:58 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62939A4314
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 12:39:57 -0800 (PST)
Received: (qmail 8259 invoked by uid 109); 9 Dec 2022 20:39:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Dec 2022 20:39:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28602 invoked by uid 111); 9 Dec 2022 20:39:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Dec 2022 15:39:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Dec 2022 15:39:56 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, David Caro <dcaro@wikimedia.org>,
        git@vger.kernel.org
Subject: Re: Skipping adding Signed-off-by even if it's not the last on git
 commit
Message-ID: <Y5OdHL4VFCIjgrk7@coredump.intra.peff.net>
References: <20221206170646.6lnpr6h7oprziy5b@vulcanus>
 <Y4/xSObs9QXvE+xR@nand.local>
 <xmqqlenj7t0b.fsf@gitster.g>
 <20221207084027.7dhyaatkzaawrg4g@vulcanus>
 <Y5EQCD4XCsN10HO+@nand.local>
 <xmqqtu266cj5.fsf@gitster.g>
 <Y5GRx86i3ZIiVxb3@coredump.intra.peff.net>
 <xmqq5yel2wuv.fsf@gitster.g>
 <Y5KSfsxLO7com2f9@coredump.intra.peff.net>
 <xmqqcz8t1avz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcz8t1avz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 09, 2022 at 01:03:44PM +0900, Junio C Hamano wrote:

> > What I don't like about it is:
> >
> >   - the external cmd is complicated and slow. It would be nice if you
> >     could just set trailer.sign.ident=true or something, and it would
> >     use your ident by default if no value is given (and maybe even do
> >     completion similar to "commit --author" if a value is given).
> 
> Ah, "trailer.sign.value" to use the same value does not exist, and
> the closest kludge we can use is the .cmd thing?  Then it is a shame
> but it should be easy to correct?

Yeah, I almost suggested trailer.sign.value at first, but on further
thought, it would be kind of weird. When the user asks for a trailer to
be included, it usually already has a value along with it. This could be
thought of as a default value, which might work like:

  git config trailer.signed-off-by.default "Jeff King <peff@peff.net>"

That's pretty flexible, but it seems like what you really want is not
some string, but to say "my usual committer ident". And so we force you
to repeat what's in user.email, etc, or we have to invent some new token
that means "my usual ident". So if we instead have a flag for "this is
an ident", then it can just do the expected thing.

> >   - you have to know to be clever enough to define and use
> >     --trailer=sign. If --signoff didn't exist, that's not too big a
> >     stretch. But since it does, everyone will naturally reach for it
> >     first.
> 
> We could reimplement --signoff to actually take attention to the
> "trailer.sign.*" thing, if we wanted to, and that makes it very easy
> to explain, I guess.

Yeah. My only reservation would be whether anybody would be surprised by
the change in behavior. I have the feeling that hardly anybody uses
trailer.* config, but I admit that's not based in any real data.

-Peff
