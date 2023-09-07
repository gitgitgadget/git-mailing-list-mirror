Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B322EC8754
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 19:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjIGTP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 15:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjIGTP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 15:15:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35927B2
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 12:15:55 -0700 (PDT)
Received: (qmail 27540 invoked by uid 109); 7 Sep 2023 08:09:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Sep 2023 08:09:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24486 invoked by uid 111); 7 Sep 2023 08:09:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Sep 2023 04:09:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Sep 2023 04:09:13 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 6/8] builtin/repack.c: store existing cruft packs
 separately
Message-ID: <20230907080913.GF1260718@coredump.intra.peff.net>
References: <cover.1693946195.git.me@ttaylorr.com>
 <414a558883830a29924710126960074b37ab97fc.1693946195.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <414a558883830a29924710126960074b37ab97fc.1693946195.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2023 at 04:36:54PM -0400, Taylor Blau wrote:

> When repacking with the `--write-midx` option, we invoke the function
> `midx_included_packs()` in order to produce the list of packs we want to
> include in the resulting MIDX.
> 
> This list is comprised of:
> 
>   - existing .keep packs
>   - any pack(s) which were written earlier in the same process
>   - any unchanged packs when doing a `--geometric` repack
>   - any cruft packs
> 
> Prior to this patch, we stored pre-existing cruft and non-cruft packs
> together (provided those packs are non-kept). This meant we needed an
> additional bit to indicate which non-kept pack(s) were cruft versus
> those that aren't.
> 
> But alternatively we can store cruft packs in a separate list, avoiding
> the need for this extra bit, and simplifying the code below.

OK. Getting rid of the extra bit is nice. We shorten code that only
cares about cruft packs like:

  for each pack
    if (pack is cruft)
       ...

to just:

  for each cruft_pack
    ...

which is good. But the flip side is that any existing code which looks
at the combined list now has to do:

  for each pack
     ...
  for each cruft_pack
     ...

I think there's just one case of that, here:

> @@ -707,6 +706,12 @@ static void midx_included_packs(struct string_list *include,
>  				continue;
>  			string_list_insert(include, xstrfmt("%s.idx", item->string));
>  		}
> +
> +		for_each_string_list_item(item, &existing->cruft_packs) {
> +			if ((uintptr_t)item->util & DELETE_PACK)
> +				continue;
> +			string_list_insert(include, xstrfmt("%s.idx", item->string));
> +		}
>  	}
>  }

It may be an OK price to pay if this lets us keep cleaning things up
(especially if we could get rid of that util casting entirely!). Let's
read on...

-Peff
