Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD615C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9863661040
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhJ2Umc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:42:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:49776 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhJ2Umc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 16:42:32 -0400
Received: (qmail 23770 invoked by uid 109); 29 Oct 2021 20:40:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Oct 2021 20:40:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22681 invoked by uid 111); 29 Oct 2021 20:40:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Oct 2021 16:40:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Oct 2021 16:40:01 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>,
        git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: *Really* noisy encoding warnings post-v2.33.0
Message-ID: <YXxcIQQS7GQzRwUa@coredump.intra.peff.net>
References: <9896630.2IqcCWsCYL@localhost.localdomain>
 <YSWVi8uLHZCTtG0l@coredump.intra.peff.net>
 <xmqqeeahjxj4.fsf@gitster.g>
 <YSkvNyR4uT52de13@coredump.intra.peff.net>
 <87ily7m1mv.fsf@evledraar.gmail.com>
 <YWEAEjIN0HVHbIpg@coredump.intra.peff.net>
 <YWEBmJk0aENR5Yeo@coredump.intra.peff.net>
 <871r4umfnm.fsf@evledraar.gmail.com>
 <YXkx6WzoF+B1id5T@coredump.intra.peff.net>
 <211029.86bl38w124.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211029.86bl38w124.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 29, 2021 at 12:47:36PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > The other issue is that it is assuming UTF-8 on one end of the
> > conversion. But we aren't necessarily doing such a conversion; it
> > depends on the commit's on-disk encoding, and the requested output
> > encoding. In particular:
> >
> >   - if both of those match, we do not need to call iconv at all (see the
> >     same_encoding() check in repo_logmsg_reencode()). With the patch
> >     above, the NO_ICONV case would start to die() when both are say
> >     iso8859-1, even though it currently works.
> >
> >   - likewise, even if you have iconv support, it's possible that your
> >     preferred encoding is not compatible with utf8. In which case
> >     iconv_open() may complain, even though the actual conversion we'd
> >     ask it to do would succeed.
> >
> > I.e., I don't think there's a way to just ask iconv "does this encoding
> > name by itself make any sense". You can only ask it about to/from
> > combos.
> 
> Yes, I'm not saying it covers the general problem, but that it covers
> the specific complained-about issue of a completely nonsensical encoding
> like "HTML". We should simply error on that on command startup, whether
> or not we have any commits to visit.

I definitely agree with you on the direction, and I don't mind if we
don't cover every case. What I was trying to point out above though is
that the patch you showed actually _regresses_ some cases, and it's hard
to robustly avoid that.

> So per <87ily7m1mv.fsf@evledraar.gmail.com> why can't we just revert the
> warning(), and then consider a good way forward that covers some/all of
> these cases we've noted?

Right, I agreed with that in the other thread. You may need to convince
Junio. ;)

TBH I am not even sure it is worth spending a lot of brain cells on the
"and then consider..." part. Over all these years, we've had one report,
and it simply misunderstand what "--encoding" was for. I thought it was
something we could fix up easily by checking a return value, but IMHO
doing it right is quite tricky because of iconv()'s limited interface,
and the risk of regression outweighs the potential benefit.

-Peff
