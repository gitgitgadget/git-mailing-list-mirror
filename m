Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456AEC10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 06:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245AF2073E
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 06:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgCXGB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:01:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:49040 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725853AbgCXGB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 02:01:26 -0400
Received: (qmail 15121 invoked by uid 109); 24 Mar 2020 06:01:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Mar 2020 06:01:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21156 invoked by uid 111); 24 Mar 2020 06:11:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Mar 2020 02:11:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Mar 2020 02:01:25 -0400
From:   Jeff King <peff@peff.net>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        William Baker <William.Baker@microsoft.com>,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: Re: [PATCH v3 1/1] midx.c: fix an integer overflow
Message-ID: <20200324060125.GA610977@coredump.intra.peff.net>
References: <20200312173520.2401776-1-damien.olivier.robert+git@gmail.com>
 <20200323222515.779477-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200323222515.779477-1-damien.olivier.robert+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 23, 2020 at 11:25:15PM +0100, Damien Robert wrote:

> When verifying a midx index with 0 objects, the
>     m->num_objects - 1
> overflows to 4294967295.
> 
> Fix this both by checking that the midx contains at least one oid,
> and also that we don't write any midx when there is no packfiles.
> 
> Update the tests so that we check that `git multi-pack-index write` does
> not write an midx when there is no object.

Thanks, both sides of this make sense.

> ---
> Since I did not receive any guidelines, I did not upload an midx with no
> object to check in the tests. I just modified the current tests to check
> that we don't produce an midx if there is no objects.

I'd be OK with just this, but adding a binary t/t5319/zero-objs.midx
would be fine by me, too.

One minor style nit:

> @@ -1124,6 +1130,13 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
>  				    i, oid_fanout1, oid_fanout2, i + 1);
>  	}
>  
> +	if (m->num_objects == 0) {
> +		midx_report(_("the midx contains no oid"));
> +		// remaining tests assume that we have objects, so we can
> +		// return here
> +		return verify_midx_error;
> +	}

We prefer /**/ for comments, like:

  /*
   * Remaining tests assume that we have objects, so we can
   * return here.
   */

-Peff
