Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25291FC44
	for <e@80x24.org>; Tue,  9 May 2017 03:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbdEID47 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 23:56:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:47892 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbdEID47 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 23:56:59 -0400
Received: (qmail 15548 invoked by uid 109); 9 May 2017 03:56:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 03:56:57 +0000
Received: (qmail 19851 invoked by uid 111); 9 May 2017 03:57:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 23:57:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 May 2017 23:56:54 -0400
Date:   Mon, 8 May 2017 23:56:54 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] checkout: check return value of resolve_refdup before
 using hash
Message-ID: <20170509035654.ywjabvwxj6rwelcn@sigill.intra.peff.net>
References: <f2e1a050-13e8-89be-ec6e-778054882ea3@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2e1a050-13e8-89be-ec6e-778054882ea3@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 06, 2017 at 07:13:52PM +0200, René Scharfe wrote:

> If resolve_refdup() fails it returns NULL and possibly leaves its hash
> output parameter untouched.  Make sure to use it only if the function
> succeeded, in order to avoid accessing uninitialized memory.
> 
> Found with t/t2011-checkout-invalid-head.sh --valgrind.
> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/checkout.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index bfa5419f33..6c3d2e4f4c 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -833,7 +833,8 @@ static int switch_branches(const struct checkout_opts *opts,
>  	int flag, writeout_error = 0;
>  	memset(&old, 0, sizeof(old));
>  	old.path = path_to_free = resolve_refdup("HEAD", 0, rev.hash, &flag);
> -	old.commit = lookup_commit_reference_gently(rev.hash, 1);
> +	if (old.path)
> +		old.commit = lookup_commit_reference_gently(rev.hash, 1);

I wondered for a second what the value of old.commit would be in the
error case. But it should be NULL due to the memset above.

But what happens after that? Is everybody OK with NULL? I briefly poked
through the callees (merge_working_tree, update_refs_for_switch, and
post_checkout_hook) and they all seem to explicitly handle the NULL.
So I think this is good (well, clearly your change was an improvement
either way, but I feel more confident now that there is nothing else to
be fixed on top of it).

-Peff
