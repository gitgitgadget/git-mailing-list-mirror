Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CE13203EA
	for <e@80x24.org>; Fri, 19 Aug 2016 01:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754389AbcHSBDZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:03:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:57789 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754549AbcHSBCk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:02:40 -0400
Received: (qmail 22267 invoked by uid 109); 18 Aug 2016 18:06:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Aug 2016 18:06:18 +0000
Received: (qmail 16165 invoked by uid 111); 18 Aug 2016 18:06:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Aug 2016 14:06:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Aug 2016 14:06:15 -0400
Date:   Thu, 18 Aug 2016 14:06:15 -0400
From:   Jeff King <peff@peff.net>
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vicent Marti <tanoku@gmail.com>,
        =?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
        Isabelle Vallet <isabelle.vallet@nexedi.com>,
        Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
        Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2 v7] pack-objects: use reachability bitmap index when
 generating non-stdout pack
Message-ID: <20160818180615.q25p57v35m2xxtww@sigill.intra.peff.net>
References: <20160809192858.GA25822@teco.navytux.spb.ru>
 <20160809193217.32389-1-kirr@nexedi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160809193217.32389-1-kirr@nexedi.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 09, 2016 at 10:32:17PM +0300, Kirill Smelkov wrote:

> Subject: Re: [PATCH 2/2 v7] pack-objects: use reachability bitmap index when
>    generating non-stdout pack

This is v7, but as I understand your numbering, it goes with v5 of patch
1/2 that I just reviewed (usually we just increment the version number
on the whole series and treat it as a unit, even if some patches didn't
change from version to version).

> So we can teach pack-objects to use bitmap index for initial object
> counting phase when generating resultant pack file too:
> 
> - if we care it is not activated under git-repack:

Do you mean "if we take care that it is not..." here?

(I think you might just be getting tripped up in the English idioms;
"care" means that we have a preference; "to take care" means that we are
being careful).

> - if we know bitmap index generation is not enabled for resultant pack:
> 
>   Current code has singleton bitmap_git so cannot work simultaneously
>   with two bitmap indices.

Minor English fixes:

  The current code has a singleton bitmap_git, so it cannot work
  simultaneously with two bitmap indices.

> - if we keep pack reuse enabled still only for "send-to-stdout" case:
> 
>   Because on pack reuse raw entries are directly written out to destination
>   pack by write_reused_pack() bypassing needed for pack index generation
>   bookkeeping done by regular codepath in write_one() and friends.

Ditto on English:

  On pack reuse raw entries are directly written out to the destination
  pack by write_reused_pack(), bypassing the need for pack index
  generation bookkeeping done by the regular code path in write_one()
  and friends.

I think this is missing the implication. Why wouldn't we want to reuse
in this case? Certainly we don't when doing a "careful" on-disk repack.
I suspect the answer is that we cannot write a ".idx" off of the result
of write_reused_pack(), and write-to-disk always includes the .idx.

> More context:
> 
>     http://marc.info/?t=146792101400001&r=1&w=2

Can we turn this into a link to public-inbox? We have just been bit by
all of our old links to gmane dying, and they cannot easily be replaced
because they use a gmane-specific article number. public-inbox URLs use
message-ids, which should be usable for other archives if public-inbox
goes away.

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index b1007f2..c92d7fc 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c

The code here looks fine.

> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index a278d30..9602e9a 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -196,6 +196,18 @@ test_expect_success 'pack-objects respects --local (non-local bitmapped pack)' '
>  	! has_any packbitmap.objects 3b.objects
>  '
>  
> +test_expect_success 'pack-objects to file can use bitmap' '
> +	# make sure we still have 1 bitmap index from previous tests
> +	ls .git/objects/pack/ | grep bitmap >output &&
> +	test_line_count = 1 output &&
> +	# verify equivalent packs are generated with/without using bitmap index
> +	packasha1=$(git pack-objects --no-use-bitmap-index --all packa </dev/null) &&
> +	packbsha1=$(git pack-objects --use-bitmap-index --all packb </dev/null) &&
> +	list_packed_objects <packa-$packasha1.idx >packa.objects &&
> +	list_packed_objects <packb-$packbsha1.idx >packb.objects &&
> +	test_cmp packa.objects packb.objects
> +'

Of course we can't know if bitmaps were actually used, or if they were
turned off under the hood. But at least this exercises the code a bit.

You could possibly add a perf test which shows off the improvement, but
I don't think it's strictly necessary.

-Peff
