Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D612320958
	for <e@80x24.org>; Mon, 20 Mar 2017 18:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932495AbdCTSNx (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 14:13:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:47875 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932467AbdCTSNN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 14:13:13 -0400
Received: (qmail 13167 invoked by uid 109); 20 Mar 2017 18:05:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 18:05:36 +0000
Received: (qmail 3934 invoked by uid 111); 20 Mar 2017 18:05:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 14:05:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 14:05:32 -0400
Date:   Mon, 20 Mar 2017 14:05:32 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 18/20] commit_packed_refs(): use reference iteration
Message-ID: <20170320180532.vxzra6tpf3t7qjks@sigill.intra.peff.net>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
 <b8d279659c6755c5d042a3062b526e4752114c38.1490026594.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8d279659c6755c5d042a3062b526e4752114c38.1490026594.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 05:33:23PM +0100, Michael Haggerty wrote:

> -/*
> - * An each_ref_entry_fn that writes the entry to a packed-refs file.
> - */
> -static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
> -{
> -	enum peel_status peel_status = peel_entry(entry, 0);
> -
> -	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
> -		error("internal error: %s is not a valid packed reference!",
> -		      entry->name);
> -	write_packed_entry(cb_data, entry->name, entry->u.value.oid.hash,
> -			   peel_status == PEEL_PEELED ?
> -			   entry->u.value.peeled.hash : NULL);
> -	return 0;
> -}

This assertion goes away. It can't be moved into write_packed_entry()
because the peel status is only known in the caller.

But here:

> @@ -1376,8 +1362,18 @@ static int commit_packed_refs(struct files_ref_store *refs)
>  		die_errno("unable to fdopen packed-refs descriptor");
>  
>  	fprintf_or_die(out, "%s", PACKED_REFS_HEADER);
> -	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
> -				 write_packed_entry_fn, out);
> +
> +	iter = cache_ref_iterator_begin(packed_ref_cache->cache, NULL, 0);
> +	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
> +		struct object_id peeled;
> +		int peel_error = ref_iterator_peel(iter, &peeled);
> +
> +		write_packed_entry(out, iter->refname, iter->oid->hash,
> +				   peel_error ? NULL : peeled.hash);
> +	}

Should we be checking that peel_error is only PEELED or NON_TAG?

-Peff
