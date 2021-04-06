Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E59C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 17:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370DE60FF1
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 17:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhDFRyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 13:54:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:42818 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234529AbhDFRyk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 13:54:40 -0400
Received: (qmail 8342 invoked by uid 109); 6 Apr 2021 17:54:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Apr 2021 17:54:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30763 invoked by uid 111); 6 Apr 2021 17:54:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Apr 2021 13:54:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Apr 2021 13:54:31 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 7/8] pack-bitmap: implement combined filter
Message-ID: <YGygV1mesbJzdPr5@coredump.intra.peff.net>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
 <fac3477d979058da0430b974a34f7c7f866bf456.1615813673.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fac3477d979058da0430b974a34f7c7f866bf456.1615813673.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 02:14:59PM +0100, Patrick Steinhardt wrote:

> When the user has multiple objects filters specified, then this is
> internally represented by having a "combined" filter. These combined
> filters aren't yet supported by bitmap indices and can thus not be
> accelerated.
> 
> Fix this by implementing support for these combined filters. The
> implementation is quite trivial: when there's a combined filter, we
> simply recurse into `filter_bitmap()` for all of the sub-filters.

The goal makes sense.

Before this patch, I think your test:

> +test_expect_success 'combine filter' '
> +	git rev-list --objects --filter=blob:limit=1000 --filter=object:type=blob tag >expect &&
> +	git rev-list --use-bitmap-index \
> +		     --objects --filter=blob:limit=1000 --filter=object:type=blob tag >actual &&
> +	test_bitmap_traversal expect actual
> +'

would pass anyway, because we'd just skip using bitmaps. Is there a way
we can tell that the bitmap code actually kicked in? Maybe a perf test
would make it clear (those aren't always run, but hopefully we'd
eventually notice a regression there).

> +static int filter_supported(struct list_objects_filter_options *filter)
> +{
> +	int i;
> +
> +	switch (filter->choice) {
> +	case LOFC_BLOB_NONE:
> +	case LOFC_BLOB_LIMIT:
> +	case LOFC_OBJECT_TYPE:
> +		return 1;
> +	case LOFC_TREE_DEPTH:
> +		if (filter->tree_exclude_depth == 0)
> +			return 1;
> +		return 0;
> +	case LOFC_COMBINE:
> +		for (i = 0; i < filter->sub_nr; i++)
> +			if (!filter_supported(&filter->sub[i]))
> +				return 0;
> +		return 1;
> +	default:
> +		return 0;
> +	}
> +}

Hmm. This is essentially reproducing the list in filter_bitmap() of
what's OK for bitmaps. So when adding a new filter, it would have to be
added in both places.

Can we preserve that property of the original code? I'd think that just
adding LOFC_COMBINE to filter_bitmap() would be sufficient. I.e., this
hunk:

> +	if (filter->choice == LOFC_COMBINE) {
> +		int i;
> +		for (i = 0; i < filter->sub_nr; i++) {
> +			filter_bitmap(bitmap_git, tip_objects, to_filter,
> +				      &filter->sub[i]);
> +		}
> +		return 0;
> +	}

...except that we need to see if filter_bitmap() returns "-1" for any of
the recursive calls. Which we probably should be doing anyway to
propagate any errors (though I think the only "errors" we'd return are
"not supported", at least for now).

-Peff
