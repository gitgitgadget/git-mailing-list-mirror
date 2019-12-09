Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AD3C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 06:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCCC20721
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 06:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfLIG2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 01:28:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:41718 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726343AbfLIG2n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 01:28:43 -0500
Received: (qmail 17960 invoked by uid 109); 9 Dec 2019 06:28:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Dec 2019 06:28:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18262 invoked by uid 111); 9 Dec 2019 06:32:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Dec 2019 01:32:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Dec 2019 01:28:41 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 3/9] ewah/bitmap: introduce bitmap_word_alloc()
Message-ID: <20191209062841.GC40570@coredump.intra.peff.net>
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
 <20191115141541.11149-4-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191115141541.11149-4-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 15, 2019 at 03:15:35PM +0100, Christian Couder wrote:

> In a following commit we will need to allocate a variable
> number of bitmap words, instead of always 32, so let's add
> bitmap_word_alloc() for this purpose.

This name is much better than the horrible "bitmap_new2()" it was called
in the original. ;)

I wonder if "new_with_world_alloc" or "new_with_size" would make it more
obvious that this is also a constructor, though.

>  void bitmap_set(struct bitmap *self, size_t pos)
>  {
>  	size_t block = EWAH_BLOCK(pos);
>  
>  	if (block >= self->word_alloc) {
>  		size_t old_size = self->word_alloc;
> -		self->word_alloc = block * 2;
> +		self->word_alloc = block ? block * 2 : 1;

Since this hunk caused so much confusion, maybe worth calling it out in
the commit message. Something like:

  Note that we have to adjust the block growth in bitmap_set(), since
  a caller could now use an initial size of "0" (we don't plan to do
  that, but it doesn't hurt to be defensive).

-Peff
