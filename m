Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04D401F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 02:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbeJNKbd (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Oct 2018 06:31:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:39830 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725773AbeJNKbd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Oct 2018 06:31:33 -0400
Received: (qmail 18679 invoked by uid 109); 14 Oct 2018 02:52:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 14 Oct 2018 02:52:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21958 invoked by uid 111); 14 Oct 2018 02:51:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 13 Oct 2018 22:51:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Oct 2018 22:52:07 -0400
Date:   Sat, 13 Oct 2018 22:52:07 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Martin Koegler <martin.koegler@chello.at>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] zlib.c: use size_t for size
Message-ID: <20181014025207.GA1527@sigill.intra.peff.net>
References: <xmqqsh1bbq36.fsf@gitster-ct.c.googlers.com>
 <20181012204229.11890-1-tboegi@web.de>
 <20181012222234.GF19800@szeder.dev>
 <20181013050057.GA6805@tor.lan>
 <fb6367b3-975b-1bc6-e95b-a457fb9e3a33@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb6367b3-975b-1bc6-e95b-a457fb9e3a33@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 14, 2018 at 03:16:36AM +0100, Ramsay Jones wrote:

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index b059b86aee..3b5f2c38b3 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -269,12 +269,12 @@ static void copy_pack_data(struct hashfile *f,
>  		off_t len)
>  {
>  	unsigned char *in;
> -	unsigned long avail;
> +	size_t avail;
>  
>  	while (len) {
>  		in = use_pack(p, w_curs, offset, &avail);
>  		if (avail > len)
> -			avail = (unsigned long)len;
> +			avail = xsize_t(len);

We don't actually care about truncation here. The idea is that we take a
bite-sized chunk via use_pack, and loop as necessary. So mod-2^32
truncation via a cast would be bad (we might not make forward progress),
but truncating to SIZE_MAX would be fine.

That said, we know that would not truncate here, because we must
strictly be shrinking "avail", which was already a size_t (unless "len"
is negative, but then we are really screwed ;) ).

So I kind of wonder if a comment would be better than xsize_t here.
Something like:

  if (avail > len) {
	/*
	 * This can never truncate because we know that len is smaller
	 * than avail, which is already a size_t.
	 */
	avail = (size_t)len;
  }

-Peff
