Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C90801F406
	for <e@80x24.org>; Sat, 12 May 2018 19:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeELTGr (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 15:06:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:37402 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751096AbeELTGq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 15:06:46 -0400
Received: (qmail 12892 invoked by uid 109); 12 May 2018 19:06:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 12 May 2018 19:06:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16555 invoked by uid 111); 12 May 2018 19:06:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 12 May 2018 15:06:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 May 2018 15:06:44 -0400
Date:   Sat, 12 May 2018 15:06:44 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 06/12] revision.c: use commit-slab for show_source
Message-ID: <20180512190644.GA8814@sigill.intra.peff.net>
References: <20180512080028.29611-1-pclouds@gmail.com>
 <20180512080028.29611-7-pclouds@gmail.com>
 <20180512093344.GG28279@sigill.intra.peff.net>
 <xmqqy3gpdlgy.fsf@gitster-ct.c.googlers.com>
 <CACsJy8CJ1_iKx_fvfoFKp8_x5ZO8Nvhqd_JoGTYYrjePoC0ZKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CJ1_iKx_fvfoFKp8_x5ZO8Nvhqd_JoGTYYrjePoC0ZKA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 04:13:59PM +0200, Duy Nguyen wrote:

> > Should this one be global in the first place?  Can we tie it to say
> > "struct rev_info" or something?  I'd somehow anticipate a far future
> > where object flag bits used for traversal book-keeping would be moved
> > out of the objects themselves and multiple simultanous traversal
> > becomes reality.
> 
> Yeah I thought about those 27 bits but discarded it because it was not
> that much. But now that you brought up the maintainability aspect of
> it, it might make sense to move those bits out (if we manage to make
> commit-slab (or a specialized version of it) manage bitmaps instead of
> primitive types, which is not impossible).
> 
> I don't understand the tying to struct rev_info though. This is a
> struct definition and cannot really be tied to another struct. The
> pointer to struct source_slab _is_ tied to struct rev_info.

Right. We have a global type name and global functions, because this is
C. But the actual variable itself is inside struct rev_info (you used a
pointer to a caller-allocated struct, but I think that's fine, too).

> > Not limited to this particular one, but we'd need to think how the
> > commit_slab mechanism should interact with the_repository idea
> > Stefan has been having fun with.  If the object pool is maintained
> > per in-core repository object, presumably we'd have more than one
> > in-core instances of the same commit object if we have more than one
> > repository objects, and decorating one with a slab data may not want
> > to decorate the other one at the same time.
> 
> It should be ok. The slab is indexed by the "commit index" which is
> already per parsed_object_pool. Commit-slab user has to be careful to
> use the right slab with the right repo and free it at the right time,
> but that I think is outside with struct repository.

In theory somebody could misuse a "struct commit" from the wrong
repository and get nonsense results. I'd like to think that would be
pretty hard, but I guess it could be possible to make a mistake like
that at the interface where we call into a submodule-related function.

You could get around it by making the commit_index global across all
pools, but I don't think that's a good idea. Since it's an array index,
we want it to be compact and low.

-Peff
