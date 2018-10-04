Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57F7A1F453
	for <e@80x24.org>; Thu,  4 Oct 2018 22:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeJEFCi (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 01:02:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:41918 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725758AbeJEFCi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 01:02:38 -0400
Received: (qmail 5045 invoked by uid 109); 4 Oct 2018 22:07:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Oct 2018 22:07:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30989 invoked by uid 111); 4 Oct 2018 22:06:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Oct 2018 18:06:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2018 18:07:11 -0400
Date:   Thu, 4 Oct 2018 18:07:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 2/5] fetch-pack: load tip_oids eagerly iff needed
Message-ID: <20181004220711.GA28287@sigill.intra.peff.net>
References: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
 <14e57ec8-b8a2-10bd-688d-1cb926e77675@web.de>
 <9f51ac28-73e9-2855-c650-7d695945e286@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f51ac28-73e9-2855-c650-7d695945e286@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 04, 2018 at 05:09:39PM +0200, René Scharfe wrote:

> tip_oids_contain() lazily loads refs into an oidset at its first call.
> It abuses the internal (sub)member .map.tablesize of that oidset to
> check if it has done that already.
> 
> Determine if the oidset needs to be populated upfront and then do that
> instead.  This duplicates a loop, but simplifies the existing one by
> separating concerns between the two.

I like this approach much better than what I showed earlier. But...

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 3b317952f0..53914563b5 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -526,23 +526,6 @@ static void add_refs_to_oidset(struct oidset *oids, struct ref *refs)
>  		oidset_insert(oids, &refs->old_oid);
>  }
>  
> -static int tip_oids_contain(struct oidset *tip_oids,
> -			    struct ref *unmatched, struct ref *newlist,
> -			    const struct object_id *id)
> -{
> -	/*
> -	 * Note that this only looks at the ref lists the first time it's
> -	 * called. This works out in filter_refs() because even though it may
> -	 * add to "newlist" between calls, the additions will always be for
> -	 * oids that are already in the set.
> -	 */

I don't think the subtle point this comment is making goes away. We're
still growing the list in the loop that calls tip_oids_contain() (and
which now calls just oidset_contains). That's OK for the reasons given
here, but I think that would need to be moved down to this code:

> +	if (strict) {
> +		for (i = 0; i < nr_sought; i++) {
> +			ref = sought[i];
> +			if (!is_unmatched_ref(ref))
> +				continue;
> +
> +			add_refs_to_oidset(&tip_oids, unmatched);
> +			add_refs_to_oidset(&tip_oids, newlist);
> +			break;
> +		}
> +	}

I.e., we need to say here why it's OK to summarize newlist in the
oidset, even though we're adding to it later.

-Peff
