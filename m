Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 305271FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 08:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755011AbeAJIH6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 03:07:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:39776 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754982AbeAJIH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 03:07:56 -0500
Received: (qmail 17596 invoked by uid 109); 10 Jan 2018 08:07:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 10 Jan 2018 08:07:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13481 invoked by uid 111); 10 Jan 2018 08:08:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Jan 2018 03:08:29 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jan 2018 03:07:54 -0500
Date:   Wed, 10 Jan 2018 03:07:54 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/9] bisect: avoid using the rev_info flag leak_pending
Message-ID: <20180110080754.GE16315@sigill.intra.peff.net>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
 <07d0e0c6-d023-bd28-511b-78092cb35b4f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07d0e0c6-d023-bd28-511b-78092cb35b4f@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 25, 2017 at 06:45:36PM +0100, René Scharfe wrote:

> The leak_pending flag is so awkward to use that multiple comments had to
> be added around each occurrence.  We only use it for remembering the
> commits whose marks we have to clear after checking if all of the good
> ones are ancestors of the bad one.  This is easy, though: We need to do
> that for the bad and good commits, of course.

Are we sure that our list is the same as what is traversed? I won't be
surprised if it is true, but it doesn't seem immediately obvious from
the code:

> -static int check_ancestors(const char *prefix)
> +static int check_ancestors(int rev_nr, struct commit **rev, const char *prefix)
>  {

So now we take in a set of objects...

>  	struct rev_info revs;
> -	struct object_array pending_copy;
>  	int res;
>  
>  	bisect_rev_setup(&revs, prefix, "^%s", "%s", 0);

But those objects aren't provided here. bisect_rev_setup() puts its own
set of objects into the pending list...

> -	/* Save pending objects, so they can be cleaned up later. */
> -	pending_copy = revs.pending;
> -	revs.leak_pending = 1;
> -
> -	/*
> -	 * bisect_common calls prepare_revision_walk right away, which
> -	 * (together with .leak_pending = 1) makes us the sole owner of
> -	 * the list of pending objects.
> -	 */
>  	bisect_common(&revs);
>  	res = (revs.commits != NULL);

And then we traverse, and then...

>  
>  	/* Clean up objects used, as they will be reused. */
> -	clear_commit_marks_for_object_array(&pending_copy, ALL_REV_FLAGS);
> -
> -	object_array_clear(&pending_copy);
> +	clear_commit_marks_many(rev_nr, rev, ALL_REV_FLAGS);

...this is the first time we look at "rev".

If we already have the list of tips, could we just feed it ourselves to
bisect_rev_setup (I think that would require us remembering which were
"good" and "bad", but that doesn't seem like a big deal).

I'm not overly concerned that you've introduced a bug here, but just
wondering if we could make this a bit more maintainable going forward.

-Peff
