Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F1E8211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 22:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbeLCWE0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 17:04:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:57726 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725848AbeLCWE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 17:04:26 -0500
Received: (qmail 4726 invoked by uid 109); 3 Dec 2018 22:04:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Dec 2018 22:04:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14289 invoked by uid 111); 3 Dec 2018 22:03:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 03 Dec 2018 17:03:53 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2018 17:04:24 -0500
Date:   Mon, 3 Dec 2018 17:04:24 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: Re: [PATCH 8/9] sha1-file: use loose object cache for quick
 existence check
Message-ID: <20181203220424.GA11883@sigill.intra.peff.net>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112145442.GH7400@sigill.intra.peff.net>
 <87ftw62sld.fsf@evledraar.gmail.com>
 <20181112162150.GB7612@sigill.intra.peff.net>
 <87d0ra2b3z.fsf@evledraar.gmail.com>
 <87bm6u2akf.fsf@evledraar.gmail.com>
 <878t1x2t3e.fsf@evledraar.gmail.com>
 <221cb2e4-a024-e301-2b3f-e37dcd93795e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221cb2e4-a024-e301-2b3f-e37dcd93795e@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 02, 2018 at 11:52:50AM +0100, René Scharfe wrote:

> > And for mu.git, a ~20k object repo:
> > 
> >     Test                                             origin/master     peff/jk/loose-cache       avar/check-collisions-config
> >     -------------------------------------------------------------------------------------------------------------------------
> >     0008.2: index-pack with 256*1 loose objects      0.59(0.91+0.06)   0.58(0.93+0.03) -1.7%     0.57(0.89+0.04) -3.4%
> >     0008.3: index-pack with 256*10 loose objects     0.59(0.91+0.07)   0.59(0.92+0.03) +0.0%     0.57(0.89+0.03) -3.4%
> >     0008.4: index-pack with 256*100 loose objects    0.59(0.91+0.05)   0.81(1.13+0.04) +37.3%    0.58(0.91+0.04) -1.7%
> >     0008.5: index-pack with 256*250 loose objects    0.59(0.91+0.05)   1.23(1.51+0.08) +108.5%   0.58(0.91+0.04) -1.7%
> >     0008.6: index-pack with 256*500 loose objects    0.59(0.90+0.06)   1.96(2.20+0.12) +232.2%   0.58(0.91+0.04) -1.7%
> >     0008.7: index-pack with 256*750 loose objects    0.59(0.92+0.05)   2.72(2.92+0.17) +361.0%   0.58(0.90+0.04) -1.7%
> >     0008.8: index-pack with 256*1000 loose objects   0.59(0.90+0.06)   3.50(3.67+0.21) +493.2%   0.57(0.90+0.04) -3.4%
> 
> OK, here's another theory: The cache scales badly with increasing
> numbers of loose objects because it sorts the array 256 times as it is
> filled.  Loading it fully and sorting once would help, as would using
> one array per subdirectory.

Yeah, that makes sense. This was actually how I had planned to do it
originally, but then I ended up just reusing the existing single-array
approach from the abbrev code.

I hadn't actually thought about the repeated sortings (but that
definitely makes sense that they would hurt in these pathological
cases), but more just that we get a 256x reduction in N for our binary
search (in fact we already do this first-byte lookup-table trick for
pack index lookups).

Your patch looks good to me. We may want to do one thing on top:

> diff --git a/object-store.h b/object-store.h
> index 8dceed0f31..ee67a50980 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -20,7 +20,7 @@ struct object_directory {
>  	 * Be sure to call odb_load_loose_cache() before using.
>  	 */
>  	char loose_objects_subdir_seen[256];
> -	struct oid_array loose_objects_cache;
> +	struct oid_array loose_objects_cache[256];

The comment in the context there is warning callers to remember to load
the cache first. Now that we have individual caches, might it make sense
to change the interface a bit, and make these members private. I.e.,
something like:

  struct oid_array *odb_loose_cache(struct object_directory *odb,
                                    int subdir_nr) 
  {
	if (!loose_objects_subdir_seen[subdir_nr])
		odb_load_loose_cache(odb, subdir_nr); /* or just inline it here */

	return &odb->loose_objects_cache[subdir_nr];
  }

That's harder to get wrong, and this:

> diff --git a/sha1-file.c b/sha1-file.c
> index 05f63dfd4e..d2f5e65865 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -933,7 +933,8 @@ static int quick_has_loose(struct repository *r,
>  	prepare_alt_odb(r);
>  	for (odb = r->objects->odb; odb; odb = odb->next) {
>  		odb_load_loose_cache(odb, subdir_nr);
> -		if (oid_array_lookup(&odb->loose_objects_cache, &oid) >= 0)
> +		if (oid_array_lookup(&odb->loose_objects_cache[subdir_nr],
> +				     &oid) >= 0)
>  			return 1;
>  	}

becomes:

  struct oid_array *cache = odb_loose_cache(odb, subdir_nr);
  if (oid_array_lookup(cache, &oid))
	return 1;

(An even simpler interface would be a single function that computes
subdir_nr and does the lookup itself, but that would not be enough for
find_short_object_filename()).

-Peff
