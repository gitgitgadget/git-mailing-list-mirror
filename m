Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AB7C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 01:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiLIBma (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 20:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiLIBm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 20:42:27 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442CA8743E
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 17:42:24 -0800 (PST)
Received: (qmail 30799 invoked by uid 109); 9 Dec 2022 01:42:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Dec 2022 01:42:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19277 invoked by uid 111); 9 Dec 2022 01:42:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Dec 2022 20:42:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Dec 2022 20:42:22 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, David Caro <dcaro@wikimedia.org>,
        git@vger.kernel.org
Subject: Re: Skipping adding Signed-off-by even if it's not the last on git
 commit
Message-ID: <Y5KSfsxLO7com2f9@coredump.intra.peff.net>
References: <20221206170646.6lnpr6h7oprziy5b@vulcanus>
 <Y4/xSObs9QXvE+xR@nand.local>
 <xmqqlenj7t0b.fsf@gitster.g>
 <20221207084027.7dhyaatkzaawrg4g@vulcanus>
 <Y5EQCD4XCsN10HO+@nand.local>
 <xmqqtu266cj5.fsf@gitster.g>
 <Y5GRx86i3ZIiVxb3@coredump.intra.peff.net>
 <xmqq5yel2wuv.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5yel2wuv.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 09, 2022 at 10:23:52AM +0900, Junio C Hamano wrote:

> > ... The one exception is that the
> > generic trailer.ifExists, etc, would start affecting --signoff, which
> > _might_ be a surprise. If we wanted to retain the behavior there, we
> > could say "--signoff is special, and doesn't respect generic trailer
> > config".
> 
> Yeah, that may be safe, however it is very unsatisfying.

Agreed. ;)

> > Alternatively, it would be nice if there was an easy way to put your
> > ident into a trailer (what I wrote above doesn't really work unless you
> > have those variables in your environment, and of course it's a lot of
> > typing). I think you can hack it up like:
> >
> >   git config trailer.sign.key Signed-off-by
> >   git config trailer.sign.cmd \
> >     'git var GIT_COMMITTER_IDENT | sed "s/>.*/>/";:'
> >   git commit --trailer=sign
> >
> > which is only a little more typing than --signoff, but it's not very
> > ergonomic.
> 
> It does not look _too_ bad, though.

What I don't like about it is:

  - the external cmd is complicated and slow. It would be nice if you
    could just set trailer.sign.ident=true or something, and it would
    use your ident by default if no value is given (and maybe even do
    completion similar to "commit --author" if a value is given).

  - you have to know to be clever enough to define and use
    --trailer=sign. If --signoff didn't exist, that's not too big a
    stretch. But since it does, everyone will naturally reach for it
    first.

The two could be solved independently, of course. And even if we did
want to solve both by making --signoff behave more like other trailers,
having trailer.*.ident might be nice in general.

I admit I just thought of this concept, though, so I don't have plans to
work up patches, and I make no claims there isn't a gotcha waiting
somewhere. ;)

-Peff
