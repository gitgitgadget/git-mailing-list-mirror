Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3442DC4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 21:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1FDD2224D
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 21:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgKMVjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 16:39:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:57930 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgKMVjn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 16:39:43 -0500
Received: (qmail 27789 invoked by uid 109); 13 Nov 2020 21:39:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Nov 2020 21:39:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17233 invoked by uid 111); 13 Nov 2020 21:39:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Nov 2020 16:39:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Nov 2020 16:39:42 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/23] pack-bitmap: bounds-check size of cache extension
Message-ID: <20201113213942.GB780435@coredump.intra.peff.net>
References: <cover.1605123652.git.me@ttaylorr.com>
 <1573902df00e8a14a9cb68c37f55474388b1dc2e.1605123652.git.me@ttaylorr.com>
 <CAN0heSqiiMZgT+rEgWVVR_cEmPK2bS3QNnJuHahrqVQet7_Qug@mail.gmail.com>
 <20201113045700.GA743619@coredump.intra.peff.net>
 <X6760infcF0hRYTG@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X6760infcF0hRYTG@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 04:29:54PM -0500, Taylor Blau wrote:

> > which is the header plus the trailer. We want to readjust for the
> > MAX_RAWSZ part of the header, so it should be:
> >
> >   size_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
> >   if (index->map_size < sizeof(*header) + the_hash_algo->rawsz)
> 
> I'm not sure that I follow. If you apply this to the second patch in
> this series, the only thing that changes is that it factors out:
> 
>   index->map_pos += ...;
> 
> into
> 
>   size_t header_size = ...;
>   // ...
>   index->map_pos += header_size;
> 
> What am I missing here?

The problem is this hunk from patch 2:

> +       size_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
> 
> -       if (index->map_size < sizeof(*header) + the_hash_algo->rawsz)
> +       if (index->map_size < header_size)
>                 return error("Corrupted bitmap index (missing header data)");

The header struct contains a field for the hash of the pack. So the
original code as taking that full header, and adding in another
current-algo rawsz to account for the trailer.

Afterwards, we adjust header_size to swap out the MAX_RAWSZ for the
current-algo rawsz. So header_size is a correct substitution for
sizeof(*header) now. But we still have to add back in
the_hash_algo->rawsz to account for the trailer. The second "+" line is
wrong to have removed it.

The later line we adjust:

> -       index->map_pos += sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
> +       index->map_pos += header_size;

is correct. It's just skipping past the header, and doesn't care about
the trailer at all (and confusing the two is probably what led me to
write the bug in the first place).

-Peff
