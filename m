Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C96F120281
	for <e@80x24.org>; Thu, 21 Sep 2017 04:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbdIUE7f (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 00:59:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:45618 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750912AbdIUE7e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 00:59:34 -0400
Received: (qmail 2309 invoked by uid 109); 21 Sep 2017 04:59:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 04:59:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19182 invoked by uid 111); 21 Sep 2017 05:00:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 01:00:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Sep 2017 00:59:32 -0400
Date:   Thu, 21 Sep 2017 00:59:32 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2 02/21] prefix_ref_iterator: break when we leave the
 prefix
Message-ID: <20170921045932.b5y33fm7gao27ium@sigill.intra.peff.net>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
 <2bb2e8ccb57eef8acbea5004167751a007a1bd2f.1505799700.git.mhagger@alum.mit.edu>
 <CAGZ79kbwCAidGR3cgukdjckZVYwj+qbOikqN-e934uP1yk9Cuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbwCAidGR3cgukdjckZVYwj+qbOikqN-e934uP1yk9Cuw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 20, 2017 at 01:25:43PM -0700, Stefan Beller wrote:

> > +/* Return -1, 0, 1 if refname is before, inside, or after the prefix. */
> > +static int compare_prefix(const char *refname, const char *prefix)
> > +{
> > +       while (*prefix) {
> > +               if (*refname != *prefix)
> > +                       return ((unsigned char)*refname < (unsigned char)*prefix) ? -1 : +1;
> 
> This looks interesting.
> 
> We get a signed char* , cast it to unsigned char* and then
> compare byte by byte.
> 
> The cast lead me to think that this should work for non-ASCII
> (e.g. ANSI?), but given that there are multi-byte characters (e.g.
> UTF-8) depending on your encoding used, we may not assume
> that in the given encoding the characters order by their byte order?

We don't really care about encodings here. We're doing a byte-wise
comparison. Which may include high-bit bytes for some encodings.

The important thing is that it match the byte-wise comparison that we
use elsewhere (e.g., in memcmp or strcmp), since our sort order must be
the same. And those functions are defined to do the funny "subtract as
unsigned" rule.

> But this compare function is not to order by the natural encoding order,
> but it's used to detect the '0' at the end of prefix, which orders
> before *any* unsigned char.

It's not just detecting the "0". We care about the ordering overall (so
that "refs/foo" comes after "refs/bar", and we know that "refs/bar/baz"
cannot come after "refs/foo", and we can stop iterating).

> We cannot enhance starts_with for this case as we'd have to invert
> the return value to differentiate between the prefix ordering before
> or after the given string.

Exactly. starts_with() is about a boolean match. But this is inherently
about matching the ordering of other "cmp" functions, but for a partial
match. It's possible that's something we could use in a more general
case, but I don't know of one offhand.

> Essentially compare_prefix wants to provide the same return
> value as `strncmp(refname, prefix, min(strlen(refname), strlen(prefix)));`
> except that it is optimized as we do not have to walk over a string
> multiple times (to determine length and then pass it to compare).

Hmm, yeah, I think that would be an equivalent. I didn't think of that,
but as you say it would be less efficient.

> Feel free to ignore the rambling, I just had to sort my thoughts.
> The patch looks good.

Rambling is sometimes good if it points out holes in the original
reasoning.

The patch is credited to me, but I actually screwed up the ordering by
failing to do the unsigned cast. Michael fixed that part before posting
it. :)

-Peff
