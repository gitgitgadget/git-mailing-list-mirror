Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96A031F462
	for <e@80x24.org>; Fri, 26 Jul 2019 08:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfGZI57 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 04:57:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:52108 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725815AbfGZI56 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 04:57:58 -0400
Received: (qmail 9262 invoked by uid 109); 26 Jul 2019 08:57:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 26 Jul 2019 08:57:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5686 invoked by uid 111); 26 Jul 2019 08:59:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Jul 2019 04:59:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Jul 2019 04:57:57 -0400
From:   Jeff King <peff@peff.net>
To:     Varun Naik <vcnaik94@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] checkout.c: unstage empty deleted ita files
Message-ID: <20190726085756.GA20017@sigill.intra.peff.net>
References: <20190726045645.2437-1-vcnaik94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190726045645.2437-1-vcnaik94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 25, 2019 at 09:56:45PM -0700, Varun Naik wrote:

> It is possible to delete a committed file from the index and then add it
> as intent-to-add. After `git checkout HEAD` or `git restore --staged`,
> the file should be identical in the index and HEAD. This patch provides
> the desired behavior even when the file is empty in the index.

OK, so the issue is that ITA entries have an empty-file sha1, so they
confuse the logic to decide if we can use the old entry. Your fix makes
sense.

> ---
> CC Jeff because you wrote the code that I am changing now.
> 
> checkout.c:update_some() discards the newly created cache entry when its
> mode and oid match those of the old entry. Since an ita file has the
> same oid as an empty file, an empty deleted ita file passes both of
> these checks, and the new entry is discarded. In this case, the file
> should be added to the cache instead.
> 
> This change should not affect newly added ita files. For those, inside
> tree.c:read_tree_1(), tree_entry_interesting() returns
> entry_not_interesting, so fn (which points to update_some()) is never
> called.

These two paragraphs would be a nice addition to the actual commit
message.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 91f8509f85..27daa09c3c 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -126,6 +126,7 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
>  	if (pos >= 0) {
>  		struct cache_entry *old = active_cache[pos];
>  		if (ce->ce_mode == old->ce_mode &&
> +		    !ce_intent_to_add(old) &&
>  		    oideq(&ce->oid, &old->oid)) {
>  			old->ce_flags |= CE_UPDATE;
>  			discard_cache_entry(ce);

My first thought here was that we could skip ITA entries here only when
the HEAD hash is also the empty blob, which would let us retain index
results in more cases. But it doesn't help. If the HEAD entry isn't the
empty blob, then we'll have !oideq() and we'll skip anyway, because an
ITA entry must be the empty blob (if we `git add` some other content,
then it ceases to be ITA).

So it makes sense to just always skip this "retain the old index entry"
block for any ITA entry.

> +test_expect_success 'checkout HEAD adds deleted intent-to-add file back to index' '
> +	echo "nonempty" >nonempty &&
> +	>empty &&
> +	git add nonempty empty &&
> +	git commit -m "create files to be deleted" &&
> +	git rm --cached nonempty empty &&
> +	git add -N nonempty empty &&
> +	git checkout HEAD nonempty empty &&
> +	git diff --staged --exit-code
> +'

This clearly demonstrates the problem. Nice.

> +test_expect_success 'restore --staged adds deleted intent-to-add file back to index' '
> +	echo "nonempty" >nonempty &&
> +	>empty &&
> +	git add nonempty empty &&
> +	git commit -m "create files to be deleted" &&
> +	git rm --cached nonempty empty &&
> +	git add -N nonempty empty &&
> +	git restore --staged nonempty empty &&
> +	git diff --staged --exit-code
> +'

Hmm. This git-restore test means we don't apply to maint. But wouldn't
we want the fix for "checkout" there?

I.e., I'd expect a patch to fix and test git-checkout, and then an
additional patch to be added on the merge of that plus master to test
git-restore.

Other than that, the patch looks good to me.

-Peff
