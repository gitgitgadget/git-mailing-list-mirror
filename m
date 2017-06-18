Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D2621FA7B
	for <e@80x24.org>; Sun, 18 Jun 2017 11:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbdFRLt0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 07:49:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:42300 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751895AbdFRLtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 07:49:25 -0400
Received: (qmail 3885 invoked by uid 109); 18 Jun 2017 11:49:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 18 Jun 2017 11:49:25 +0000
Received: (qmail 20406 invoked by uid 111); 18 Jun 2017 11:49:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 18 Jun 2017 07:49:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Jun 2017 07:49:23 -0400
Date:   Sun, 18 Jun 2017 07:49:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [BUG] add_again() off-by-one error in custom format
Message-ID: <20170618114923.bffmbr5dqe4oivyw@sigill.intra.peff.net>
References: <xmqqd1a8n7o8.fsf@gitster.mtv.corp.google.com>
 <d229403a-d078-87b4-f3e8-89058fa4b548@web.de>
 <xmqqtw3j68rc.fsf@gitster.mtv.corp.google.com>
 <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
 <xmqqwp8f4mb2.fsf@gitster.mtv.corp.google.com>
 <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
 <20170615055654.efvsouhr3leszz3i@sigill.intra.peff.net>
 <ec36f9fa-5f3e-b511-3985-3d0301b4847f@web.de>
 <20170615132532.nivmj22dctowxssm@sigill.intra.peff.net>
 <b0bc9dab-bd93-c321-9f2e-f1621f857708@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0bc9dab-bd93-c321-9f2e-f1621f857708@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 18, 2017 at 12:58:37PM +0200, René Scharfe wrote:

> An oid_array spends ca. 30 bytes per entry (20 bytes for a hash times
> a factor of 1.5 from alloc_nr).  How many loose objects do we have to
> expect?  30 MB for a million of them sounds not too bad, but can there
> realistically be orders of magnitude more?

Good point. We gc by default at 6000 loose objects, and lots of thing
will suffer poor performance by the time you hit a million. So a little
extra space is probably not worth worrying about.

> So here's a patch for caching loose object hashes in an oid_array
> without a way to invalidate or release the cache.  It uses a single
> oid_array for simplicity, but reads each subdirectory individually and
> remembers that fact using a bitmap.

I like the direction of this very much.

> @@ -1586,6 +1587,9 @@ extern struct alternate_object_database {
>  	struct strbuf scratch;
>  	size_t base_len;
>  
> +	uint32_t loose_objects_subdir_bitmap[8];

Is it worth the complexity of having an actual bitmap and not just an
array of char? I guess it's not _that_ complex to access the bits, but
there are a lot of magic numbers involved.

> +	struct oid_array loose_objects_cache;

We should probably insert a comment here warning that the cache may go
out of date during the process run, and should only be used when that's
an acceptable tradeoff.

> +static void read_loose_object_subdir(struct alternate_object_database *alt,
> +				     int subdir_nr)

I think it's nice to pull this out into a helper function. I do wonder
if it should just be reusing for_each_loose_file_in_objdir(). You'd just
need to expose the in_obj_subdir() variant publicly.

It does do slightly more than we need (for the callbacks it actually
builds the filename), but I doubt memcpy()ing a few bytes would be
measurable.

> +		pos = oid_array_lookup(&alt->loose_objects_cache, &ds->bin_pfx);
> +		if (pos < 0)
> +			pos = -1 - pos;
> +		while (!ds->ambiguous && pos < alt->loose_objects_cache.nr) {
> +			const struct object_id *oid;
> +			oid = alt->loose_objects_cache.oid + pos;
> +			if (!match_sha(ds->len, ds->bin_pfx.hash, oid->hash))
> +				break;
> +			update_candidates(ds, oid);
> +			pos++;
>  		}

This part looks quite nice and straightforward.

-Peff
