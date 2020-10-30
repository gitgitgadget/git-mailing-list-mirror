Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD093C4741F
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 14:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F6B022210
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 14:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgJ3O1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 10:27:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:42530 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgJ3O1I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 10:27:08 -0400
Received: (qmail 7297 invoked by uid 109); 30 Oct 2020 14:27:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Oct 2020 14:27:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21680 invoked by uid 111); 30 Oct 2020 14:27:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2020 10:27:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Oct 2020 10:27:07 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 07/10] strmap: enable faster clearing and reusing of
 strmaps
Message-ID: <20201030142707.GG3277724@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <2ebce0c5d82b87fa9c9ef5dcefc0ac2701654f3b.1602549650.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ebce0c5d82b87fa9c9ef5dcefc0ac2701654f3b.1602549650.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 12:40:47AM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> When strmaps are used heavily, such as is done by my new merge-ort
> algorithm, and strmaps need to be cleared but then re-used (because of
> e.g. picking multiple commits to cherry-pick, or due to a recursive
> merge having several different merges while recursing), free-ing and
> reallocating map->table repeatedly can add up in time, especially since
> it will likely be reallocated to a much smaller size but the previous
> merge provides a good guide to the right size to use for the next merge.
> 
> Introduce strmap_partial_clear() to take advantage of this type of
> situation; it will act similar to strmap_clear() except that
> map->table's entries are zeroed instead of map->table being free'd.
> Making use of this function reduced the cost of reset_maps() by about
> 20% in mert-ort, and dropped the overall runtime of my rebase testcase
> by just under 2%.

Oh, these were the real numbers I was looking for earlier. :)

Of course it's a little confusing because reset_maps() doesn't exist yet
in the code base this is being applied on, but I can live with that.

> +/*
> + * Similar to strmap_clear() but leaves map->map->table allocated and
> + * pre-sized so that subsequent uses won't need as many rehashings.
> + */
> +void strmap_partial_clear(struct strmap *map, int free_values);

Oh good, you anticipated my free_values suggestion from earlier. But...

> +void strmap_partial_clear(struct strmap *map, int free_util)
> +{
> +	strmap_free_entries_(map, free_util);
> +	hashmap_partial_clear(&map->map);
> +}

...the implementation didn't catch up.

Other than that the patch looks obviously correct.

-Peff
