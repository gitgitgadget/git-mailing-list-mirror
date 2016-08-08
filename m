Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0115B2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 13:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbcHHN4E (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 09:56:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:51144 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752143AbcHHN4D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 09:56:03 -0400
Received: (qmail 5927 invoked by uid 109); 8 Aug 2016 13:56:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Aug 2016 13:56:02 +0000
Received: (qmail 5090 invoked by uid 111); 8 Aug 2016 13:56:02 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Aug 2016 09:56:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Aug 2016 09:56:00 -0400
Date:	Mon, 8 Aug 2016 09:56:00 -0400
From:	Jeff King <peff@peff.net>
To:	Kirill Smelkov <kirr@nexedi.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Vicent Marti <tanoku@gmail.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 2/2] pack-objects: Teach it to use reachability bitmap
 index when generating non-stdout pack too
Message-ID: <20160808135600.c6hdlqwwtqe7thd5@sigill.intra.peff.net>
References: <20160729074051.GA5987@teco.navytux.spb.ru>
 <20160729074746.31862-1-kirr@nexedi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160729074746.31862-1-kirr@nexedi.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 10:47:46AM +0300, Kirill Smelkov wrote:

> @@ -2527,7 +2528,7 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
>  	if (prepare_bitmap_walk(revs) < 0)
>  		return -1;
>  
> -	if (pack_options_allow_reuse() &&
> +	if (pack_options_allow_reuse() && pack_to_stdout &&
>  	    !reuse_partial_packfile_from_bitmap(

Should pack_to_stdout just be part of pack_options_allow_reuse()?

> @@ -2812,7 +2813,23 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
>  		unpack_unreachable_expiration = 0;
>  
> -	if (!use_internal_rev_list || !pack_to_stdout || is_repository_shallow())
> +	/*
> +	 * "soft" reasons not to use bitmaps - for on-disk repack by default we want
> +	 *
> +	 * - to produce good pack (with bitmap index not-yet-packed objects are
> +	 *   packed in suboptimal order).
> +	 *
> +	 * - to use more robust pack-generation codepath (avoiding possible
> +	 *   bugs in bitmap code and possible bitmap index corruption).
> +	 */
> +	if (!pack_to_stdout)
> +		use_bitmap_index_default = 0;
> +
> +	if (use_bitmap_index < 0)
> +		use_bitmap_index = use_bitmap_index_default;
> +
> +	/* "hard" reasons not to use bitmaps; these just won't work at all */
> +	if (!use_internal_rev_list || (!pack_to_stdout && write_bitmap_index) || is_repository_shallow())
>  		use_bitmap_index = 0;

This all makes sense and looks good.

> +test_expect_success 'pack-objects to file can use bitmap' '
> +	# make sure we still have 1 bitmap index from previous tests
> +	ls .git/objects/pack/ | grep bitmap >output &&
> +	test_line_count = 1 output &&
> +	# verify equivalent packs are generated with/without using bitmap index
> +	packasha1=$(git pack-objects --no-use-bitmap-index --all packa </dev/null) &&
> +	packbsha1=$(git pack-objects --use-bitmap-index --all packb </dev/null) &&
> +	git verify-pack -v packa-$packasha1.pack >packa.verify &&
> +	git verify-pack -v packb-$packbsha1.pack >packb.verify &&
> +	grep -o "^$_x40" packa.verify |sort >packa.objects &&
> +	grep -o "^$_x40" packb.verify |sort >packb.objects &&
> +	test_cmp packa.objects packb.objects
> +'

I don't think "grep -o" is portable. However, an easier way to do this
is probably:

  # these are already in sorted order
  git show-index <packa-$packasha1.pack | cut -d' ' -f2 >packa.objects &&
  git show-index <packb-$packbsha1.pack | cut -d' ' -f2 >packb.objects &&
  test_cmp packa.objects packb.objects

-Peff
