Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CF9C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 03:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbhLJEA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 23:00:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:48422 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231529AbhLJEA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 23:00:26 -0500
Received: (qmail 16617 invoked by uid 109); 10 Dec 2021 03:56:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Dec 2021 03:56:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26285 invoked by uid 111); 10 Dec 2021 03:56:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Dec 2021 22:56:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Dec 2021 22:56:51 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 08/10] linear-assignment.c: detect signed add/mul on
 GCC and Clang
Message-ID: <YbLQA820y+WuGwRU@coredump.intra.peff.net>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <RFC-patch-08.10-794d494bedd-20211209T191653Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <RFC-patch-08.10-794d494bedd-20211209T191653Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 09, 2021 at 08:19:25PM +0100, Ævar Arnfjörð Bjarmason wrote:

> diff --git a/linear-assignment.c b/linear-assignment.c
> index e9cec16132a..b6597b622c8 100644
> --- a/linear-assignment.c
> +++ b/linear-assignment.c
> @@ -10,7 +10,14 @@ static inline int cost_index(int *cost, int a, int b, int c)
>  {
>  	int r;
>  
> +#if defined(__GNUC__) || defined(__clang__)
> +	if (__builtin_mul_overflow(a, c, &r))
> +		die(_("integer overflow in cost[%d + %d * %c] multiplication"), b, a, c);
> +	if (__builtin_add_overflow(b, r, &r))
> +		die(_("integer overflow in cost[%d + ((%d * %d) = %d)] addition"), b, a, c, r);
> +#else
>  	r = b + a * c;
> +#endif

I think having an inline #if here is the wrong direction. We already
have signed_add_overflows() which you could use for the second check.
We haven't needed signed_mult_overflows() yet, but we could add one.

Those helpers don't use intrinsics yet. I think it would be reasonable
to have them do so when they're available. One of the big reasons we
haven't done so yet is that they're not generally in hot paths. We
generally use them while allocating, where the extra integer operations
and conditional aren't a big deal.

Here you depart from that and do the check on every index computation.
I'm not completely opposed to that approach, but I think a simpler
method (and what most spots have done so far) is to make sure the array
allocation itself is computed correctly, and then have code which
accesses it use an appropriate type to avoid overflow. In this case just
using size_t for the index computation would work, wouldn't it?

(Likewise, if you really want a negative value, then ssize_t should be
OK. It can't represent the full range of size_t, but if it would
overflow that implies the original allocation was consuming more than
half of the address space, which would have failed at the time of
allocation).

I do see that the following patch replaces this #if with similar helpers
from gnulib, which is better. And if we are going to go the route of
using intrinsics in our helpers, then it might be a good idea to use
gnulib's helpers to avoid portability pitfalls. But in that case we
should probably be converting over callers of the existing helpers (and
getting rid of those helpers).

IMHO it isn't really worth it, though, if we can solve this just by
switching to a more appropriate type here (and assuming there's not a
big performance benefit to the other helper call sites).

-Peff
