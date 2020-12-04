Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25570C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06ED22CA1
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbgLDTv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 14:51:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:51966 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729459AbgLDTv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 14:51:56 -0500
Received: (qmail 32389 invoked by uid 109); 4 Dec 2020 19:51:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Dec 2020 19:51:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14810 invoked by uid 111); 4 Dec 2020 19:51:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Dec 2020 14:51:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Dec 2020 14:51:15 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 6/9] oid-array: provide a for-loop iterator
Message-ID: <X8qTM22mVzrhqRnn@coredump.intra.peff.net>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
 <X8qFo+GJJTbaPV58@coredump.intra.peff.net>
 <X8qIaOe3aT1qr+es@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8qIaOe3aT1qr+es@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 04, 2020 at 02:05:12PM -0500, Taylor Blau wrote:

> > +static inline size_t oid_array_next_unique(struct oid_array *array, size_t cur)
> > +{
> > +	do {
> > +		cur++;
> > +	} while (cur < array->nr &&
> > +		 oideq(array->oid + cur, array->oid + cur - 1));
> 
> I don't love the pointer math here (would instead prefer
> oideq(&array->oid[cur]) and so on), but I don't think that it matters
> enough to make a difference.

I think it is a matter of preference. I actually prefer the arithmetic
(it's also what was in the code that we are replacing in
oid_array_for_each_unique(), but that is probably because I wrote that
one, too).

> I additionally had to make sure that cur - 1 >= 0 so that the second
> argument would always be valid, but it is, since we call cur++.

Yeah. I originally wrote it as:

  cur++;
  while (cur < array->nr) {
	if (!oideq(...))
		break;
	cur++;
  }

which maybe makes it more obvious that cur always gets implemented at
least once, but I found it harder to reason about the second increment.
I think the do-while expresses it pretty clearly, but we're not that
used to seeing them.

> You could check that cur++ doesn't overflow, but I think that that's
> mostly academic.

It can't overflow, because it can't ever go past array->nr (unless you
call it again after cur is already equal to array->nr, but that would be
a bug just like calling i++ after hitting the loop end would be).

-Peff
