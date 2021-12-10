Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446A2C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 04:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhLJEDj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 23:03:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:48430 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhLJEDj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 23:03:39 -0500
Received: (qmail 16634 invoked by uid 109); 10 Dec 2021 04:00:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Dec 2021 04:00:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26343 invoked by uid 111); 10 Dec 2021 04:00:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Dec 2021 23:00:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Dec 2021 23:00:04 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 10/10] linear-assignment.c: use "intmax_t" instead of
 "int"
Message-ID: <YbLQxId7DLkbT7mQ@coredump.intra.peff.net>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <RFC-patch-10.10-46395080b64-20211209T191653Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <RFC-patch-10.10-46395080b64-20211209T191653Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 09, 2021 at 08:19:27PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Change the "int" type used by compute_assignment() to "intmax_t". On
> 64 bit systems this changes the overflow "die" added in the preceding
> commit (which before that was a segfault) to something that merely
> takes a very long time and a lot of memory to run.
> 
> On my relatively beefy system this completes:
> 
>     git -P range-diff --creation-factor=50 origin/master...git-for-windows/main
> 
> In around 300 seconds, with a reported max RSS of just under 18GB, but
> it does give you correct results for all ~50k commitsin that range.

So here you do what I think is the "real" fix. And at this point I
suspect that the overflow checks here:

> -static inline int cost_index(int *cost, int a, int b, int c)
> +static inline intmax_t cost_index(intmax_t *cost, intmax_t a, intmax_t b, intmax_t c)
>  {
> -	int r;
> +	intmax_t r;
>  
>  	if (INT_MULTIPLY_WRAPV(a, c, &r))
> -		die(_("integer overflow in cost[%d + %d * %d] multiplication"), b, a, c);
> +		die(_("integer overflow in cost[%"PRIuMAX" + %"PRIuMAX" * %"PRIuMAX"] multiplication"), b, a, c);
>  	if (INT_ADD_WRAPV(b, r, &r))
> -		die(_("integer overflow in cost[%d + ((%d * %d) = %d)] addition"), b, a, c, r);
> +		die(_("integer overflow in cost[%"PRIuMAX" + ((%"PRIuMAX" * %"PRIuMAX") = %"PRIuMAX")] addition"), b, a, c, r);
>  
>  	return r;

cannot be triggered. We are indexing an array that is already limited to
size_t. So using that type should be sufficient (or else we have
problems even outside of overflow).

And for that reason I'd probably pick size_t (or ssize_t; you don't need
it in the hunk above, but presumably some of the other code cares about
signedness. And as I said earlier, it's effectively the same from a
protection standpoint).

-Peff
