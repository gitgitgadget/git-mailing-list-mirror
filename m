Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D9D6203E2
	for <e@80x24.org>; Fri, 19 Aug 2016 00:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754360AbcHSA7M (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 20:59:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:57775 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754079AbcHSA7K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 20:59:10 -0400
Received: (qmail 21381 invoked by uid 109); 18 Aug 2016 17:52:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Aug 2016 17:52:24 +0000
Received: (qmail 15898 invoked by uid 111); 18 Aug 2016 17:52:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Aug 2016 13:52:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Aug 2016 13:52:22 -0400
Date:   Thu, 18 Aug 2016 13:52:22 -0400
From:   Jeff King <peff@peff.net>
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vicent Marti <tanoku@gmail.com>,
        =?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
        Isabelle Vallet <isabelle.vallet@nexedi.com>,
        Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
        Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2 v5] pack-objects: respect
 --local/--honor-pack-keep/--incremental when bitmap is in use
Message-ID: <20160818175222.bmm3ivjheokf2qzl@sigill.intra.peff.net>
References: <20160809192858.GA25822@teco.navytux.spb.ru>
 <20160809193143.32213-1-kirr@nexedi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160809193143.32213-1-kirr@nexedi.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 09, 2016 at 10:31:43PM +0300, Kirill Smelkov wrote:

> Since 6b8fda2d (pack-objects: use bitmaps when packing objects) there
> are two codepaths in pack-objects: with & without using bitmap
> reachability index.

Sorry, I got distracted from reviewing these patches. I'll give them a
detailed look now and hopefully we can finalize the topic.

> In want_object_in_pack() we care to start the checks from already found
> pack, if we have one, this way determining the answer right away
> in case neither --local nor --honour-pack-keep are active. In
> particular, as p5310-pack-bitmaps.sh shows, we do not do harm to
> served-with-bitmap clones performance-wise:
> 
>     Test                      56dfeb62          this tree
>     -----------------------------------------------------------------
>     5310.2: repack to disk    9.63(8.67+0.33)   9.47(8.55+0.28) -1.7%
>     5310.3: simulated clone   2.07(2.17+0.12)   2.03(2.14+0.12) -1.9%
>     5310.4: simulated fetch   0.78(1.03+0.02)   0.76(1.00+0.03) -2.6%
>     5310.6: partial bitmap    1.97(2.43+0.15)   1.92(2.36+0.14) -2.5%
> 
> with all differences strangely showing we are a bit faster now, but
> probably all being within noise.

Good to know there is no regression. It is curious that there is a
slight _improvement_ across the board. Do we have an explanation for
that? It seems odd that noise would be so consistent.

> And in the general case we care not to have duplicate
> find_pack_entry_one(*found_pack) calls. Worst what can happen is we can
> call want_found_object(*found_pack) -- newly introduced helper for
> checking whether we want object -- twice, but since want_found_object()
> is very lightweight it does not make any difference.

I had trouble parsing this. I think maybe:

  In the general case we do not want to call find_pack_entry_one() more
  than once, because it is expensive. This patch splits the loop in
  want_object_in_pack() into two parts: finding the object and seeing if
  it impacts our choice to include it in the pack. We may call the
  inexpensive want_found_object() twice, but we will never call
  find_pack_entry_one() if we do not need to.

> +static int want_found_object(int exclude, struct packed_git *p)
> +{
> +	if (exclude)
> +		return 1;
> +	if (incremental)
> +		return 0;
> +
> +	/*
> +	 * When asked to do --local (do not include an object that appears in a
> +	 * pack we borrow from elsewhere) or --honor-pack-keep (do not include
> +	 * an object that appears in a pack marked with .keep), finding a pack
> +	 * that matches the criteria is sufficient for us to decide to omit it.
> +	 * However, even if this pack does not satisfy the criteria, we need to
> +	 * make sure no copy of this object appears in _any_ pack that makes us
> +	 * to omit the object, so we need to check all the packs. Signal that by
> +	 * returning -1 to the caller.
> +	 */
> +	if (!ignore_packed_keep &&
> +	    (!local || !have_non_local_packs))
> +		return 1;

Hmm. The comment says "-1", but the return says "1". That is because the
comment is describing the return that happens at the end. :)

I wonder if the last sentence should be:

  We can check here whether these options can possibly matter; if not,
  we can return early from the function here. Otherwise, we signal "-1"
  at the end to tell the caller that we do not know either way, and it
  needs to check more packs.

> -	*found_pack = NULL;
> -	*found_offset = 0;
> +	/*
> +	 * If we already know the pack object lives in, start checks from that
> +	 * pack - in the usual case when neither --local was given nor .keep files
> +	 * are present we will determine the answer right now.
> +	 */
> +	if (*found_pack) {
> +		want = want_found_object(exclude, *found_pack);
> +		if (want != -1)
> +			return want;
> +	}

Looks correct. Though it is not really "start checks from..." anymore,
but rather "do a quick check to see if we can quit early, and otherwise
start the loop". That might be nitpicking, though.

>  	for (p = packed_git; p; p = p->next) {
> -		off_t offset = find_pack_entry_one(sha1, p);
> +		off_t offset;
> +
> +		if (p == *found_pack)
> +			offset = *found_offset;
> +		else
> +			offset = find_pack_entry_one(sha1, p);
> +

This hunk will conflict with the MRU optimizations in 'next', but I
think the resolution should be pretty trivial.

>  static int add_object_entry(const unsigned char *sha1, enum object_type type,
>  			    const char *name, int exclude)
>  {
> -	struct packed_git *found_pack;
> -	off_t found_offset;
> +	struct packed_git *found_pack = NULL;
> +	off_t found_offset = 0;

I think technically we don't need to initialize found_offset here (it is
considered only if *found_pack is not NULL), but it doesn't hurt to make
our starting assumptions clear.

> @@ -1073,6 +1097,9 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
>  	if (have_duplicate_entry(sha1, 0, &index_pos))
>  		return 0;
>  
> +	if (!want_object_in_pack(sha1, 0, &pack, &offset))
> +		return 0;
> +

And this caller doesn't need to worry about initialization, because of
course it knows it has a pack/offset already. Good.

> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 3893afd..a278d30 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh

Tests look OK. I saw a few style nitpicks, but I think they are not even
against our style guide but more "I would have written it like this" and
are not even worth quibbling over.

So I think the code here is fine, and I just had a few minor complaints
on comment and commit message clarity.

-Peff
