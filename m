Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA6EC1F667
	for <e@80x24.org>; Fri, 18 Aug 2017 06:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750748AbdHRGnk (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 02:43:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:42432 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750709AbdHRGnj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 02:43:39 -0400
Received: (qmail 22122 invoked by uid 109); 18 Aug 2017 06:43:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Aug 2017 06:43:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32692 invoked by uid 111); 18 Aug 2017 06:44:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Aug 2017 02:44:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Aug 2017 02:43:36 -0400
Date:   Fri, 18 Aug 2017 02:43:36 -0400
From:   Jeff King <peff@peff.net>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 4/4] commit: rewrite read_graft_line
Message-ID: <20170818064335.h5sr5iz7mh64axji@sigill.intra.peff.net>
References: <cover.1503020338.git.patryk.obara@gmail.com>
 <cb98970b3f6c175321f52efb65deb48f9cfeabae.1503020338.git.patryk.obara@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb98970b3f6c175321f52efb65deb48f9cfeabae.1503020338.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2017 at 03:59:38AM +0200, Patryk Obara wrote:

> Determine the number of object_id's to parse in a single graft line by
> counting separators (whitespace characters) instead of dividing by
> length of hash representation.
> 
> This way graft parsing code can support different sizes of hashes
> without any further code adaptations.

Sounds like a reasonable approach, though I wonder what happens if our
counting pass differs in its behavior from the actual parse.

E.g., here:

> +	/* count number of blanks to determine size of array to allocate */
> +	for (i = 0, n = 0; i < line->len; i++)
> +		if (isspace(line->buf[i]))
> +			n++;

If we see multiple spaces like "1234abcd     5678abcd" we'll allocate a
slot for each. I think that's OK because here:

> +	for (i = 0; i < graft->nr_parent; i++)
> +		if (!isspace(*tail++) || parse_oid_hex(tail, &graft->parent[i], &tail))
>  			goto bad_graft_data;

We'd reject such an input totally (though as an interesting side effect,
you can convince the parser to allocate 20x as much RAM as you send it;
one oid for each space).

So we're probably fine. The two parsing passes are right next to each
other and are sufficiently simple and strict that we don't have to
worry about them diverging.

The single-pass alternative would probably be to read into a dynamic
structure like an oid_array, and then copy the result into the flex
structure.

Or of course to stop using a flex structure, as your original pass did.
I agree with Junio that the use of object_id's is orthogonal to using a
FLEX_ARRAY. But I could also see an argument that the complexity the
flex array adds here isn't worth the savings. The main benefits of a
flex array are:

  1. Less memory used. But we don't expect to see a large enough number
     of grafts for this to matter.

  2. A more compact memory representation, which can be faster. But
     accessing the parent list of a graft isn't going to be the hot code
     path. It probably only happens once in a program run when we
     rewrite the parents (versus checking the grafted commit, which is
     looked up once per commit we access).

  3. It's easier to free the struct and its associated resources in a
     single free(). But we never free the graft list.

Reading your original, my thought was "why _not_ keep doing it as a
FLEX_ARRAY, as it saves a little memory, which can't hurt". But seeing
this pre-counting phase, I think it does make the code a little more
complicated. But I'd be OK with doing it either way.

-Peff
