Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FB661F461
	for <e@80x24.org>; Mon, 15 Jul 2019 18:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbfGOSPa (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jul 2019 14:15:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:36816 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729535AbfGOSPa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jul 2019 14:15:30 -0400
Received: (qmail 22266 invoked by uid 109); 15 Jul 2019 18:15:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 15 Jul 2019 18:15:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24315 invoked by uid 111); 15 Jul 2019 18:16:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 15 Jul 2019 14:16:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jul 2019 14:15:27 -0400
Date:   Mon, 15 Jul 2019 14:15:27 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] range-diff: fix some 'hdr-check' and sparse warnings
Message-ID: <20190715181527.GA30747@sigill.intra.peff.net>
References: <e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com>
 <41a60e60-d2c0-7d54-5456-e44d106548a4@kdbg.org>
 <xmqqy313p5hn.fsf@gitster-ct.c.googlers.com>
 <ec635d0d-00ca-2419-3c1a-9b0343b46daa@kdbg.org>
 <xmqq1rytpqse.fsf@gitster-ct.c.googlers.com>
 <CAPUEspgD8E02FcNvBx96neGEejdqMDWoH8NgpsHyGPo_KM09FA@mail.gmail.com>
 <20190714005129.GA4525@sigill.intra.peff.net>
 <54c2ee44-ee99-ea4a-3154-f642e0060877@kdbg.org>
 <20190715144602.GA26636@sigill.intra.peff.net>
 <4be7a0a1-0256-40c3-4abc-d3d9302f527b@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4be7a0a1-0256-40c3-4abc-d3d9302f527b@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 15, 2019 at 07:30:09PM +0200, Johannes Sixt wrote:

> Am 15.07.19 um 16:46 schrieb Jeff King:
> > On Sun, Jul 14, 2019 at 10:30:27AM +0200, Johannes Sixt wrote:
> >>> But it does fall down
> >>> when the first element _has_ to be a struct (like, say, any user of our
> >>> hashmap.[ch] interface).
> >>
> >> No, it does not. It is not necessary to spell out nested structs in the
> >> initializer.
> > 
> > Ah, that is news to me. I know that this compiles OK with "gcc -Wall",
> > but is it guaranteed by the standard?
> 
> Yes; see http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1124.pdf,
> 6.7.8 §20, in particular, the sentence beginning with "Otherwise".

Thanks, I didn't know about that subtlety.

I think relying on that flattening would be a terrible style choice to
use for initializing to particular values, but it makes perfect sense in
the context of using a single 0 to mean "zero-initialize the whole
struct".

That actually kind of makes me think that reordering our struct members
(to put an arithmetic type or a struct containing one at the beginning)
_might_ be worth doing as a workaround to tools like sparse. It's hacky,
but it puts the effort of dealing with this problem only in one spot
(the struct definition) instead of many (everywhere the struct is used).

But I'd be happy if we could address it in another way (e.g., convincing
sparse to stop complaining about it, or just decide it's not worth
dealing with). One other thing I haven't seen discussed in this thread:
we could actually make our preferred style be for all structs to define
a FOO_INIT initializer, like we already do for STRBUF_INIT, etc. That's
a much more heavyweight solution than what's being discussed here, but
it comes with an extra benefit: it's easy to catch and change all users
if the struct switches away from zero-initialization.

I'm on the fence on whether having non-zero initializers is a good
strategy overall.  You can always bootstrap any other on-demand setup
from the zero-initialized state, but it does sometimes lead to more
awkward code (e.g., needing an explicit call to initialized_if_needed()
in every function that works with the struct, or inverting the sense of
boolean members so that the default is always "0").

-Peff
