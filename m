Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E3BC433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 07:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14EE72177B
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 07:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgHGH6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:58:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:51450 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgHGH6i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 03:58:38 -0400
Received: (qmail 29518 invoked by uid 109); 7 Aug 2020 07:58:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 Aug 2020 07:58:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11725 invoked by uid 111); 7 Aug 2020 07:58:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 Aug 2020 03:58:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 Aug 2020 03:58:37 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] refs: fix interleaving hook calls with
 reference-transaction hook
Message-ID: <20200807075837.GA32344@coredump.intra.peff.net>
References: <63fb363375b515b903ed1269d10124b727c1d1cc.1596783732.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63fb363375b515b903ed1269d10124b727c1d1cc.1596783732.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 07, 2020 at 09:05:58AM +0200, Patrick Steinhardt wrote:

> In order to not repeatedly search for the reference-transaction hook in
> case it's getting called multiple times, we use a caching mechanism to
> only call `find_hook()` once. What was missed though is that the return
> value of `find_hook()` actually comes from a static strbuf, which means
> it will get overwritten when calling `find_hook()` again. As a result,
> we may call the wrong hook with parameters of the reference-transaction
> hook.
> 
> This scenario was spotted in the wild when executing a git-push(1) with
> multiple references, where there are interleaving calls to both the
> update and the reference-transaction hook. While initial calls to the
> reference-transaction hook work as expected, it will stop working after
> the next invocation of the update hook. The result is that we now start
> calling the update hook with parameters and stdin of the
> reference-transaction hook.

That makes sense. I think of push as a single transaction, but that's
only if the caller sends the "atomic" capability. Otherwise get one per
ref.

> diff --git a/refs.c b/refs.c
> index 2dd851fe81..17e515b288 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2044,7 +2044,7 @@ static int run_transaction_hook(struct ref_transaction *transaction,
>  	if (hook == &hook_not_found)
>  		return ret;
>  	if (!hook)
> -		hook = find_hook("reference-transaction");
> +		hook = xstrdup_or_null(find_hook("reference-transaction"));
>  	if (!hook) {
>  		hook = &hook_not_found;
>  		return ret;

The fix here looks obviously correct, though I have to wonder if the
caching is even worth it. It's saving us an access() call, but we're
about to exec a whole sub-process.

It's perhaps more justifiable when there isn't a hook (we're still just
paying that one access(), but it's proportionally bigger). I kind of
doubt it's measurable, though, since a ref write requires a bunch of
syscalls anyway.

-Peff
