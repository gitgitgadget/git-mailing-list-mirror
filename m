Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE70D1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 21:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754367AbeDBVTX (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 17:19:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:51160 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752311AbeDBVTX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 17:19:23 -0400
Received: (qmail 10511 invoked by uid 109); 2 Apr 2018 21:19:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Apr 2018 21:19:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20765 invoked by uid 111); 2 Apr 2018 21:20:23 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 02 Apr 2018 17:20:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Apr 2018 17:19:20 -0400
Date:   Mon, 2 Apr 2018 17:19:20 -0400
From:   Jeff King <peff@peff.net>
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ls-remote: create '--sort' option
Message-ID: <20180402211920.GA32099@sigill.intra.peff.net>
References: <20180402200736.80161-1-haraldnordgren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180402200736.80161-1-haraldnordgren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 02, 2018 at 10:07:36PM +0200, Harald Nordgren wrote:

> @@ -108,9 +115,25 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  			continue;
>  		if (!tail_match(pattern, ref->name))
>  			continue;
> +
> +		struct ref_array_item *item;

We don't allow mixed declarations and code; this line needs to go at the
top of the block.

> +		FLEX_ALLOC_MEM(item, refname, ref->name, strlen(ref->name));
> +		item->symref = ref->symref;
> +		item->objectname = ref->old_oid;
> +
> +		REALLOC_ARRAY(array.items, array.nr + 1);
> +		array.items[array.nr++] = item;
> +	}

This will grow by one each time, which ends up doing quadratic work in
the number of items (although it can often be less if the realloc is
able to just extend the block). It should probably use ALLOC_GROW()
to move it more aggressively.

Interestingly, the ref-filter code itself seems to have the same
problem, but I couldn't measure any speedup. So either my analysis is
totally wrong, or we end up reusing the block most of the time in
practice.

> +
> +	if (sorting) {
> +		ref_array_sort(sorting, &array);
> +	}

Minor style nit: we usually omit the braces for a one-liner block.

The ref-filter code lets you sort on any arbitrary field. So you could
do:

  git ls-remote --sort=committerdate

What should that do?

With your patch, I think we'll just get something like:

  fatal: missing object 468165c1d8a442994a825f3684528361727cd8c0 for HEAD

which is perhaps the best we can do (it might even work if you've
recently fetched from the other side).

-Peff
