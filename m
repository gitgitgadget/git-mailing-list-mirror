Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15F941F404
	for <e@80x24.org>; Wed,  4 Apr 2018 18:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbeDDSzX (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 14:55:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:53482 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751769AbeDDSzV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 14:55:21 -0400
Received: (qmail 16955 invoked by uid 109); 4 Apr 2018 18:55:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Apr 2018 18:55:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7044 invoked by uid 111); 4 Apr 2018 18:56:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 04 Apr 2018 14:56:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Apr 2018 14:55:19 -0400
Date:   Wed, 4 Apr 2018 14:55:19 -0400
From:   Jeff King <peff@peff.net>
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v7] ls-remote: create '--sort' option
Message-ID: <20180404185518.GD9055@sigill.intra.peff.net>
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
 <20180404171153.4126-1-haraldnordgren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180404171153.4126-1-haraldnordgren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 04, 2018 at 07:11:53PM +0200, Harald Nordgren wrote:

> @@ -60,6 +60,16 @@ OPTIONS
>  	upload-pack only shows the symref HEAD, so it will be the only
>  	one shown by ls-remote.
>  
> +--sort=<key>::
> +	Sort based on the key given.  Prefix `-` to sort in
> +	descending order of the value. You may use the --sort=<key> option
> +	multiple times, in which case the last key becomes the primary
> +	key. Also supports "version:refname" or "v:refname" (tag
> +	names are treated as versions). The "version:refname" sort
> +	order can also be affected by the "versionsort.suffix"
> +	configuration variable.
> +	The keys supported are the same as those in `git for-each-ref`.

We probably ought to warn the user in that final sentence that keys
which actually look at the objects may not work, since we don't
necessarily have the objects.

There's one other subtlety, which is that things like %(HEAD) assume
we're talking about local refs, not the remote HEAD. So that wouldn't
work (of course it seems unlikely that anybody woudl _sort_ on that).

> @@ -104,13 +112,28 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  	if (!dest && !quiet)
>  		fprintf(stderr, "From %s\n", *remote->url);
>  	for ( ; ref; ref = ref->next) {
> +		struct ref_array_item *item;
>  		if (!check_ref_type(ref, flags))
>  			continue;
>  		if (!tail_match(pattern, ref->name))
>  			continue;
> +
> +		FLEX_ALLOC_MEM(item, refname, ref->name, strlen(ref->name));

I think this can use the slightly-simpler FLEX_ALLOC_STR().

> +		item->symref = ref->symref;

Normally a ref_array_item's symref is an allocated string owned by the
item. I don't think it actually matters now, but in the spirit of
least-surprise for the future, should this be xstrdup_or_null(ref->symref)?

> +		item->objectname = ref->old_oid;

This is actually a struct assignment. Which does work, but our usual
mechanism would be to use "oidcpy(&item->objectname, &ref->old_oid)".

All of this might be a little nicer if ref-filter provided a function to
allocate a new item. We're pushing the boundaries of ref-filter was
meant to be used here, as it was assumed you'd always start with a call
to filter_refs().

> +		ALLOC_GROW(array.items, array.nr + 1, array.alloc);
> +		array.items[array.nr++] = item;

The existing ref-filter code fails to use ALLOC_GROW() correctly. I
don't think it actually matters, since we don't intermingle this with
allocations done there. But perhaps we should be fixing that one while
we're looking at it. Or again, maybe it would be nicer still if there
were a ref-filter function to do this, and the whole call here could
just be:

  ref_array_push(&array, ref->name, &ref->old_oid);

One more drastic alternative is to actually use the existing
filter_refs(), and just teach it to populate the array from a list of
refs. As you can see from its implementation, it does a few other setup
steps. I don't think they matter now, but if you eventually wanted to be
able to do "git ls-remote --contains HEAD", you'd need that setup.

-Peff
