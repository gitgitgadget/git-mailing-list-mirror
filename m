Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FF9C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 20:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiKVUW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 15:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiKVUW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 15:22:26 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88FAB483F
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 12:22:24 -0800 (PST)
Received: (qmail 19016 invoked by uid 109); 22 Nov 2022 20:22:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Nov 2022 20:22:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6781 invoked by uid 111); 22 Nov 2022 20:22:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Nov 2022 15:22:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Nov 2022 15:22:23 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] delta-islands: free island-related data after use
Message-ID: <Y30vf76mdrSv4We4@coredump.intra.peff.net>
References: <20221116105013.1777440-1-e@80x24.org>
 <221116.861qq2kieu.gmgdl@evledraar.gmail.com>
 <20221117230658.M516129@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221117230658.M516129@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2022 at 11:06:58PM +0000, Eric Wong wrote:

> Aside from that, v2 below still frees the regex memory early on
> in the hopes deduplicate_islands() can reuse some of the freed
> regexp memory.
> 
> Anyways, here's v2, which seems to work.  I'm still trying to
> figure out SATA errors+resets after replacing a CMOS battery,
> but I really hope this patch isn't the cause.

This looks OK to me, though I think it would have been easier to review
split into two patches (one pushing the globals into local variables and
the other adding the freeing).

Two small notes:

>  void load_delta_islands(struct repository *r, int progress)
>  {
> +	struct island_load_data ild = { 0 };
> +
>  	island_marks = kh_init_oid_map();
> -	remote_islands = kh_init_str();
>  
> -	git_config(island_config_callback, NULL);
> -	for_each_ref(find_island_for_ref, NULL);
> -	deduplicate_islands(r);
> +	git_config(island_config_callback, &ild);
> +	ild.remote_islands = kh_init_str();

The initialization of the remote_islands khash is now moved after we
read the config. That's OK, because our callback doesn't read it, but
it's not immediately obvious without going back to check the callback.

Splitting it into:

  struct island_load_data {
	kh_str_t *remote_islands;
	struct island_regexes regexes {
		regex_t *rx;
		size_t nr;
		size_t alloc;
	};
  };

lets you pass:

  git_config(island_config_callback, &ild.regexes);

which makes it clear that the khash part isn't touched. But you still
get to pass the whole &ild around later. Of course that's all going
through a void pointer, so you're praying that the callback expects the
right type anyway. ;)

And with your code we'd hopefully notice the problem right away since
the khash pointer is NULL. So it might not be that big a deal.

> +	for_each_ref(find_island_for_ref, &ild);
> +	free_config_regexes(&ild);
> +	deduplicate_islands(ild.remote_islands, r);
> +	free_remote_islands(ild.remote_islands);

Here we free the regexes, but they're pointing to garbage memory still.
But since we pass just the remote_islands part of the struct to those
functions, we know they can't look at the garbage regexes. Good.

I'd have said it ought to be two separate variables, but the
for_each_ref() callback forces your hand there.

-Peff
