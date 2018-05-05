Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07B3A200B9
	for <e@80x24.org>; Sat,  5 May 2018 18:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbeEESo3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 14:44:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:57262 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751252AbeEESo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 14:44:28 -0400
Received: (qmail 13569 invoked by uid 109); 5 May 2018 18:44:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 05 May 2018 18:44:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12287 invoked by uid 111); 5 May 2018 18:44:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 05 May 2018 14:44:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 May 2018 14:44:26 -0400
Date:   Sat, 5 May 2018 14:44:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
Message-ID: <20180505184426.GA18385@sigill.intra.peff.net>
References: <20180413170129.15310-1-mgorny@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180413170129.15310-1-mgorny@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 13, 2018 at 07:01:29PM +0200, Michał Górny wrote:

> In order to avoid unnecessary cache mismatches, force a matching mtime
> between all files created by a single checkout action.  This seems to be
> the best course of action.  Matching mtimes do not trigger cache
> updates.  They also match the concept of 'checkout' being an atomic
> action.  Finally, this change does not break backwards compatibility
> as the new result is a subset of the possible previous results.

There's one case that might be regressed. As long as we assume time
always moves forward, I think you're right, but...

> diff --git a/unpack-trees.c b/unpack-trees.c
> index e73745051..e1efefb68 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -346,6 +346,7 @@ static int check_updates(struct unpack_trees_options *o)
>  	state.quiet = 1;
>  	state.refresh_cache = 1;
>  	state.istate = index;
> +	state.checkout_mtime = time(NULL);

ISTR that it's possible for "system time" to be different from
"filesystem time". Is there any case where the time we get from
time(NULL) might vary wildly from what would be written by the
filesystem if we were to simply write the file? E.g., perhaps on some
types of network-mounted filesystems.

The files in your checkout would all be consistent, but they might be
inconsistent with other files _not_ created by Git (e.g., one might be
saved in your editor). Now you may have introduced skew that cause
"make" to do the wrong thing, because your source and target files are
really operating from two different clocks.

I really don't know how possible or common this is, but I feel like I've
been warned about this distinction in the past. I wouldn't be surprised
to find that it's an archaic thing found only on ancient versions of
NFS, and oral tradition passed down the warnings. But I also would not
be surprised if it's still possible and common.

-Peff
