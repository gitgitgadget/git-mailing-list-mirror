Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8014820248
	for <e@80x24.org>; Sat, 13 Apr 2019 01:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfDMBey (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 21:34:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:57074 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726946AbfDMBey (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 21:34:54 -0400
Received: (qmail 21645 invoked by uid 109); 13 Apr 2019 01:34:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 13 Apr 2019 01:34:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11533 invoked by uid 111); 13 Apr 2019 01:35:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Apr 2019 21:35:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Apr 2019 21:34:52 -0400
Date:   Fri, 12 Apr 2019 21:34:52 -0400
From:   Jeff King <peff@peff.net>
To:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 1/2] archive: replace write_or_die() calls with
 write_block_or_die()
Message-ID: <20190413013451.GB2040@sigill.intra.peff.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <7a9525a78a7b7b237150b9264cf675a4a0b37267.1555110278.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a9525a78a7b7b237150b9264cf675a4a0b37267.1555110278.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 12, 2019 at 04:04:39PM -0700, Rohit Ashiwal via GitGitGadget wrote:

> From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> 
> MinGit for Windows comes without `gzip` bundled inside, git-archive uses
> `gzip -cn` to compress tar files but for this to work, gzip needs to be
> present on the host system.
> 
> In the next commit, we will change the gzip compression so that we no
> longer spawn `gzip` but let zlib perform the compression in the same
> process instead.
> 
> In preparation for this, we consolidate all the block writes into a
> single function.

Sounds like a good preparatory step. This part confused me, though:

> @@ -38,11 +40,21 @@ static int write_tar_filter_archive(const struct archiver *ar,
>  #define USTAR_MAX_MTIME 077777777777ULL
>  #endif
>  
> +/* writes out the whole block, or dies if fails */
> +static void write_block_or_die(const char *block) {
> +	if (gzip) {
> +		if (gzwrite(gzip, block, (unsigned) BLOCKSIZE) != BLOCKSIZE)
> +			die(_("gzwrite failed"));
> +	} else {
> +		write_or_die(1, block, BLOCKSIZE);
> +	}
> +}

What is gzwrite()? At first I thought this was an out-of-sequence bit of
the series, but it turns out that this is a zlib.h interface. So the
idea (I think) is that here we introduce a "gzip" variable that is
always false, and this first conditional arm is effectively dead code.
And then in a later patch we'd set up "gzip" and it would become
not-dead.

I think it would be less confusing if this just factored out
write_block_or_die(), which starts as a thin wrapper and then grows the
gzip parts in the next patch.

A few nits on the code itself:

> +static gzFile gzip;
> [...]
> +       if (gzip) {

Is it OK for us to ask about the truthiness of this opaque type? That
works if it's really a pointer behind the scenes, but it seems like it
would be equally OK for zlib to declare it as a struct.

It looks OK in my version of zlib, and that library tends to be fairly
conservative so I wouldn't be surprised if it was that way back to the
beginning and remains that way for eternity. But it feels like a bad
pattern.

> +		if (gzwrite(gzip, block, (unsigned) BLOCKSIZE) != BLOCKSIZE)

This cast is interesting. All of the matching write_or_die() calls are
promoting it to a size_t, which is also unsigned.

BLOCKSIZE is a constant. Should we be defining it with a "U" in the first place?

I doubt it matters much either way from a correctness perspective. I
just wonder when I see a cast like that if we're going to get unexpected
truncation or similar.

-Peff
