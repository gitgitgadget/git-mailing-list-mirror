Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3103EB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 12:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjGEMlR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 08:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGEMlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 08:41:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C285A119
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 05:41:14 -0700 (PDT)
Received: (qmail 14572 invoked by uid 109); 5 Jul 2023 12:41:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Jul 2023 12:41:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3856 invoked by uid 111); 5 Jul 2023 12:41:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Jul 2023 08:41:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 Jul 2023 08:41:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jan =?utf-8?Q?Kl=C3=B6tzke?= <jan@kloetzke.net>,
        git@vger.kernel.org, Steve Kemp <steve@steve.org.uk>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] ref-filter: handle nested tags in --points-at option
Message-ID: <20230705124107.GA3932508@coredump.intra.peff.net>
References: <20230701205703.1172505-1-jan@kloetzke.net>
 <20230702125611.GA1036686@coredump.intra.peff.net>
 <xmqqmt0a3n2w.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmt0a3n2w.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 04, 2023 at 11:10:47PM -0700, Junio C Hamano wrote:

> My preference would be to see these optimization done first and then
> add this new loop on top of it.  That way, we can measure more
> easily what kind of additional overhead, if any, we are paying by
> adding the loop.

I ended up doing them on top, rather than before, but I think the size
of the impact can easily be seen.

The one thing that would actually make us a lot faster (by using the
packed-refs peels) is to make full peels the only option, and do not
bother letting --points-at match "B" in an A->B->C peel. But that would
be removing something that is currently matched (even before the patch
in this thread), so I stopped short of it in my optimizations. But even
if we decide to do that, Jan's patch is not making anything worse there
(in fact, it is making it better, because it is matching "C" which we do
not currently match).

So I'd be inclined to proceed with the patches I sent earlier, and then
if we choose to later refactor again to drop "B", we can.

Of course if somebody wants to do that refactor _now_ instead of the
patches already posted, I'm OK with that. It just won't be me due to
time constraints.

-Peff
