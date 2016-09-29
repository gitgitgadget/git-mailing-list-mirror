Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBA1C207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 19:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754406AbcI2TQO (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 15:16:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:50112 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751670AbcI2TQN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 15:16:13 -0400
Received: (qmail 14533 invoked by uid 109); 29 Sep 2016 19:16:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 19:16:12 +0000
Received: (qmail 4134 invoked by uid 111); 29 Sep 2016 19:16:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 15:16:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 15:16:09 -0400
Date:   Thu, 29 Sep 2016 15:16:09 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12
 hexdigits
Message-ID: <20160929191609.maxggcli76472t4g@sigill.intra.peff.net>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com>
 <20160928233047.14313-5-gitster@pobox.com>
 <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org>
 <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
 <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 11:55:46AM -0700, Linus Torvalds wrote:

> I think the patch can speak for itself, but the basic core is this
> section in get_short_sha1():
> 
>   +       if (len < 16 && !status && (flags & GET_SHA1_AUTOMATIC)) {
>   +               unsigned int expect_collision = 1 << (len * 2);
>   +               if (ds.nrobjects > expect_collision)
>   +                       return SHORT_NAME_AMBIGUOUS;
>   +       }

Hmm. So at length 7, we expect collisions at 2^14, which is 16384. That
seems really low. I mean, by the birthday paradox that's where expect
a 50% chance of a collision. But that's a single collision. We
definitely don't expect them to be common at that size.

So I suspect this could be a bit looser. The real number we care about
is probably something like "there is probability 'p' of a collision when
we add a new object", but I'm not sure what that 'p' would be. Or
perhaps "we accept collisions in 'n' percent of objects". But again, I
don't know that 'n'.

I dunno. I suppose being overly conservative with this number leaves
room for growth. Repositories generally get bigger, not smaller. :)

> What do you think? It's actually a fairly simple patch and I really do
> think it makes sense and it seems to just DTRT automatically.

I like the general idea.

As far as the implementation, I was surprised to see it touch
get_short_sha1() at all. That's, after all, for lookups, and we would
never want to require more characters on the reading side.

I see you worked around it with a flag so that this behavior only kicks
in when called via find_unique_abbrev(). But if you look at the caller:

> @@ -458,14 +472,19 @@ int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
>  int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
>  {
>  	int status, exists;
> +	int flags = GET_SHA1_QUIETLY;
>  
> +	if (len < 0) {
> +		flags |= GET_SHA1_AUTOMATIC;
> +		len = 7;
> +	}
>  	sha1_to_hex_r(hex, sha1);
>  	if (len == 40 || !len)
>  		return 40;
>  	exists = has_sha1_file(sha1);
>  	while (len < 40) {
>  		unsigned char sha1_ret[20];
> -		status = get_short_sha1(hex, len, sha1_ret, GET_SHA1_QUIETLY);
> +		status = get_short_sha1(hex, len, sha1_ret, flags);
>  		if (exists
>  		    ? !status
>  		    : status == SHORT_NAME_NOT_FOUND) {

You can see that we're going to do more work than we would otherwise
need to. Because we start at 7, and ask get_short_sha1() "is this unique
enough?", and looping. But if we _know_ we won't accept any answer
shorter than some N based on the number of objects in the repository,
then we should start at that N.

IOW, something like:

  if (len < 0)
	len = ceil(log_base_2(repository_object_count()));

here, and then you don't have to touch get_short_sha1() at all.

I suspect you pushed it down into get_short_sha1() because it kind-of
does the repository_object_count() step for "free" as it's looking at
the object anyway. But that step is really not very expensive. And I'd
even say you could just ignore loose objects entirely, and treat them
like a rounding error (the way that duplicate objects in packs are
treated).

That leaves you with just an O(# of packs) loop over a linked list. You
could even just keep a global object count up to date in
add_packed_git(), and then it's O(1).

-Peff
