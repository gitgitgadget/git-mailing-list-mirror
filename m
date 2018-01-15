Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DCF41F406
	for <e@80x24.org>; Mon, 15 Jan 2018 21:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751103AbeAOVPI (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 16:15:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:44344 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751085AbeAOVPI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 16:15:08 -0500
Received: (qmail 11943 invoked by uid 109); 15 Jan 2018 21:15:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 15 Jan 2018 21:15:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19778 invoked by uid 111); 15 Jan 2018 21:15:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 15 Jan 2018 16:15:42 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jan 2018 16:15:05 -0500
Date:   Mon, 15 Jan 2018 16:15:05 -0500
From:   Jeff King <peff@peff.net>
To:     Kim Gybels <kgybels@infogroep.be>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] packed_ref_cache: don't use mmap() for small files
Message-ID: <20180115211505.GA4778@sigill.intra.peff.net>
References: <20180113161149.9564-1-kgybels@infogroep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180113161149.9564-1-kgybels@infogroep.be>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 13, 2018 at 05:11:49PM +0100, Kim Gybels wrote:

> Take a hint from commit ea68b0ce9f8ce8da3e360aed3cbd6720159ffbee and use
> read() instead of mmap() for small packed-refs files.
> 
> This also fixes the problem[1] where xmmap() returns NULL for zero
> length[2], for which munmap() later fails.
> 
> Alternatively, we could simply check for NULL before munmap(), or
> introduce an xmunmap() that could be used together with xmmap().

This looks good to me, and since it's a recent-ish regression, I think
we should take the minimal fix here.

But it does make me wonder whether xmmap() ought to be doing this "small
mmap" optimization for us. Obviously that only works when we do
MAP_PRIVATE and never write to the result. But that's how we always use
it anyway, and we're restricted to that to work with the NO_MMAP wrapper
in compat/mmap.c.

> @@ -489,21 +491,21 @@ static int load_contents(struct snapshot *snapshot)
>  		die_errno("couldn't stat %s", snapshot->refs->path);
>  	size = xsize_t(st.st_size);
>  
> -	switch (mmap_strategy) {
> -	case MMAP_NONE:
> +	if (!size) {
> +		snapshot->buf = NULL;
> +		snapshot->eof = NULL;
> +		snapshot->mmapped = 0;
> +	} else if (size <= SMALL_FILE_SIZE || mmap_strategy == MMAP_NONE) {
>  		snapshot->buf = xmalloc(size);
>  		bytes_read = read_in_full(fd, snapshot->buf, size);
>  		if (bytes_read < 0 || bytes_read != size)
>  			die_errno("couldn't read %s", snapshot->refs->path);
>  		snapshot->eof = snapshot->buf + size;
>  		snapshot->mmapped = 0;

If the "!size" case is just lumped in with "size <= SMALL_FILE_SIZE",
then we'd try to xmalloc(0), which is guaranteed to work (we fallback to
a 1-byte allocation if necessary). Would that make things simpler and
more consistent for the rest of the code to always have snapshot->buf be
a valid pointer (just based on seeing Michael's follow-up patches)?

-Peff
