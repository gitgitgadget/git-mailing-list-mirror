Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCBCC3F2D2
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 18:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40C520675
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 18:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgB1Sz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:55:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:57386 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725730AbgB1Sz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 13:55:26 -0500
Received: (qmail 4682 invoked by uid 109); 28 Feb 2020 18:55:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Feb 2020 18:55:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18503 invoked by uid 111); 28 Feb 2020 19:04:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 28 Feb 2020 14:04:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 28 Feb 2020 13:55:25 -0500
From:   Jeff King <peff@peff.net>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org,
        Damien Robert <damien.olivier.robert+git@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH 1/1] midx.c: fix an integer overflow
Message-ID: <20200228185525.GB1408759@coredump.intra.peff.net>
References: <20200228162450.1720795-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200228162450.1720795-1-damien.olivier.robert+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 28, 2020 at 05:24:49PM +0100, Damien Robert wrote:

> When verifying a midx index with 0 objects, the
>     m->num_objects - 1
> overflows to 4294967295.
> 
> Fix this.

Makes sense. Such a midx shouldn't be generated in the first place, but
we should handle it robustly if we do see one.

> diff --git a/midx.c b/midx.c
> index 37ec28623a..6ffe013089 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -1127,7 +1127,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
>  	if (flags & MIDX_PROGRESS)
>  		progress = start_sparse_progress(_("Verifying OID order in multi-pack-index"),
>  						 m->num_objects - 1);
> -	for (i = 0; i < m->num_objects - 1; i++) {
> +	for (i = 0; i + 1 < m->num_objects; i++) {
>  		struct object_id oid1, oid2;
>  
>  		nth_midxed_object_oid(&oid1, m, i);
[...]           nth_midxed_object_oid(&oid2, m, i + 1);

Perhaps it would be simpler as:

  for (i = 1; i < m->num_objects; i++) {
          ...
	  nth_midxed_object_oid(&oid1, m, i - 1);
	  nth_midxed_object_oid(&oid2, m, i);
	  ...
  }

Though I almost wonder if we should be catching "m->num_objects == 0"
early and declaring the midx to be bogus (it's not _technically_ wrong,
but I'd have to suspect a bug in anything that generated a 0-object midx
file).

-Peff
