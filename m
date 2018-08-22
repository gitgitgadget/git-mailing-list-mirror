Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE9881F954
	for <e@80x24.org>; Wed, 22 Aug 2018 15:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbeHVSuP (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 14:50:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:51662 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728711AbeHVSuP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 14:50:15 -0400
Received: (qmail 18722 invoked by uid 109); 22 Aug 2018 15:24:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Aug 2018 15:24:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 451 invoked by uid 111); 22 Aug 2018 15:25:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 11:25:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 11:24:54 -0400
Date:   Wed, 22 Aug 2018 11:24:54 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180822152453.GD32630@sigill.intra.peff.net>
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <20180822053626.GB535143@genre.crustytoothpaste.net>
 <459f138f-78ba-6465-0f2b-b2419bbc36ff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <459f138f-78ba-6465-0f2b-b2419bbc36ff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 10:28:56AM -0400, Derrick Stolee wrote:

> In my testing, I've had the best luck with this change:
> 
> diff --git a/cache.h b/cache.h
> index b1fd3d58ab..6c8b51c390 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1023,7 +1023,14 @@ extern const struct object_id null_oid;
> 
>  static inline int hashcmp(const unsigned char *sha1, const unsigned char
> *sha2)
>  {
> -       return memcmp(sha1, sha2, the_hash_algo->rawsz);
> +       switch (the_hash_algo->rawsz) {
> +               case 20:
> +                       return memcmp(sha1, sha2, 20);
> +               case 32:
> +                       return memcmp(sha1, sha2, 32);
> +               default:
> +                       assert(0);
> +       }
>  }
> 
> The fact that '20' and '32' are constants here may be helpful to the
> compiler. Can someone else test the perf?

I tested that one last night (and just re-tested it now to be sure). It
seems to just generate two separate calls to memcmp, with no speed
improvement.

-Peff
