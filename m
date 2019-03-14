Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0165C20248
	for <e@80x24.org>; Thu, 14 Mar 2019 00:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfCNA2G (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 20:28:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:50074 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726799AbfCNA2F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 20:28:05 -0400
Received: (qmail 31226 invoked by uid 109); 14 Mar 2019 00:28:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Mar 2019 00:28:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17820 invoked by uid 111); 14 Mar 2019 00:27:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 20:27:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 20:26:48 -0400
Date:   Wed, 13 Mar 2019 20:26:48 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/5] gc: convert to using the_hash_algo
Message-ID: <20190314002648.GG31968@sigill.intra.peff.net>
References: <87imwmbv7l.fsf@evledraar.gmail.com>
 <20190313235439.30439-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190313235439.30439-3-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 12:54:36AM +0100, Ævar Arnfjörð Bjarmason wrote:

> There's been a lot of changing of the hardcoded "40" values to
> the_hash_algo->hexsz, but we've so far missed this one where we
> hardcoded 38 for the loose object file length.
> 
> This is because a SHA-1 like abcde[...] gets turned into
> objects/ab/cde[...]. There's no reason to suppose the same won't be
> the case for SHA-256, and reading between the lines in
> hash-function-transition.txt the format is planned to be the same.

Yep, makes sense.

> However, we may want to modify this code for the hash function
> transition. There's a potential pathological case here where we'll
> only consider the loose objects for the currently active hash, but
> objects for that hash will share a directory storage with the other
> hash.
> 
> Thus we could theoretically have 1k SHA-1 loose objects, and say 1
> million SHA-256 objects, and not notice because we're currently using
> SHA-1.

I agree that we may end up needing to touch this, but I think this patch
doesn't make anything worse in that respect (and likely makes it better,
since we at least know this "38" is supposed to be a hash).

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 8c2312681c..9c2c63276d 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -156,6 +156,8 @@ static int too_many_loose_objects(void)
>  	int auto_threshold;
>  	int num_loose = 0;
>  	int needed = 0;
> +	const unsigned hexsz = the_hash_algo->hexsz;
> +	const unsigned hexsz_loose = hexsz - 2;

It doesn't look like hexsz gets used anywhere else; is it worth having
the extra variable? (Admittedly this quite a nit).

-Peff
