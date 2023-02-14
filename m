Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A47C05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 16:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjBNQIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 11:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjBNQII (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 11:08:08 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FC7CDED
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 08:07:58 -0800 (PST)
Received: (qmail 31605 invoked by uid 109); 14 Feb 2023 16:07:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Feb 2023 16:07:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2121 invoked by uid 111); 14 Feb 2023 16:07:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Feb 2023 11:07:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Feb 2023 11:07:56 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [RFC PATCH 6/6] add: reject nested repositories
Message-ID: <Y+ux3DEd/p5emFWs@coredump.intra.peff.net>
References: <20230213182134.2173280-1-calvinwan@google.com>
 <20230213182134.2173280-7-calvinwan@google.com>
 <Y+qgwHx52DSAfsEb@coredump.intra.peff.net>
 <xmqqilg57zxq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqilg57zxq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2023 at 06:17:53PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >>  "	git rm --cached %s\n"
> >>  "\n"
> >> -"See \"git help submodule\" for more information."
> >> +"See \"git help submodule\" for more information.\n"
> >> +"\n"
> >> +"If you cannot use submodules, you may bypass this check with:\n"
> >> +"\n"
> >> +"	git add --no-warn-embedded-repo %s\n"
> >>  );
> >
> > I was a little surprised by this hunk, but I guess if we are going to
> > block the user's operation from completing, we might want to tell them
> > how to get around it. But it seems odd to me that the instructions to
> > "git rm --cached" the submodule remain. If this situation is now an
> > error and not a warning, there is nothing to roll back from the index,
> > since we will have bailed before writing it.
> >
> > If we are going to start recommending --no-warn-embedded-repo here,
> > would we want to promote it from being OPT_HIDDEN_BOOL()? We do document
> > it in the manpage, but just omit it from the "-h" output, since it
> > should be rarely used. Maybe it is OK to stay that way; you don't need
> > it until you run into this situation, at which point the advice
> > hopefully has guided you in the right direction.
> 
> If we are keeping the escape hatch, it would make sense to actually
> use that escape hatch to protect existing "git add" with that,
> instead of turning them into "git submodule add" and then adjust the
> tests for the consequences (i.e. "submodule add" does more than what
> "git add [--no-warn-embedded-repo]" would), at least for these tests
> in [3,4,5/6].

Good point. I did not really look at the test modifications, but
anywhere that is triggering the current warning is arguably a good spot
to be using --no-warn-embedded-repo already. It is simply that the test
did not bother to look at their noisy stderr. And such a modification is
obviously correct, as there are no further implications for the test.

> Also I do not think it is too late for a more natural UI, e.g.
> "--allow-embedded-repo=[yes/no/warn]", to deprecate the
> "--[no-]warn-*" option.

True. We have to keep the existing form for backwards compatibility, but
we can certainly add a new one.

I kind of doubt that --allow-embedded-repo=warn is useful, though. If a
caller knows what it is doing is OK, then it would say "yes". And
otherwise, you'd want "no". There is no situation where a caller is
unsure.

-Peff
