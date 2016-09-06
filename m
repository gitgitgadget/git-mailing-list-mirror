Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3DE71F859
	for <e@80x24.org>; Tue,  6 Sep 2016 07:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754572AbcIFHGH (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 03:06:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:38644 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754538AbcIFHGH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 03:06:07 -0400
Received: (qmail 13285 invoked by uid 109); 6 Sep 2016 07:06:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Sep 2016 07:06:06 +0000
Received: (qmail 24951 invoked by uid 111); 6 Sep 2016 07:06:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Sep 2016 03:06:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Sep 2016 03:06:04 -0400
Date:   Tue, 6 Sep 2016 03:06:04 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] diff_populate_filespec: NUL-terminate buffers
Message-ID: <20160906070604.i5rojh3kyc7x7kso@sigill.intra.peff.net>
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
 <f899957fa71537aa2686f17ce18aaf16f2fea2ac.1473090278.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f899957fa71537aa2686f17ce18aaf16f2fea2ac.1473090278.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 05, 2016 at 05:45:06PM +0200, Johannes Schindelin wrote:

> It is true that many code paths populate the mmfile_t structure silently
> appending a NUL, e.g. when running textconv on a temporary file and
> reading the results back into an strbuf.
> 
> The assumption is most definitely wrong, however, when mmap()ing a file.
> 
> Practically, we seemed to be lucky that the bytes after mmap()ed memory
> were 1) accessible and 2) somehow contained NUL bytes *somewhere*.
> 
> In a use case reported by Chris Sidi, it turned out that the mmap()ed
> file had the precise size of a memory page, and on Windows the bytes
> after memory-mapped pages are in general not valid.
> 
> This patch works around that issue, giving us time to discuss the best
> course how to fix this problem more generally.

I don't know if we are in that much of a rush. This bug has been around
for many years (the thread I linked earlier is from 2012). Yes, it's bad
and annoying, but we can probably spend a few days discussing the
solution.

> diff --git a/diff.c b/diff.c
> index 534c12e..32f7f46 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2826,6 +2826,15 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
>  			s->data = strbuf_detach(&buf, &size);
>  			s->size = size;
>  			s->should_free = 1;
> +		} else {
> +			/* data must be NUL-terminated so e.g. for regexec() */
> +			char *data = xmalloc(s->size + 1);
> +			memcpy(data, s->data, s->size);
> +			data[s->size] = '\0';
> +			munmap(s->data, s->size);
> +			s->should_munmap = 0;
> +			s->data = data;
> +			s->should_free = 1;
>  		}

Without having done a complete audit recently, my gut and my
recollection from previous discussions is that regexec() really is the
culprit here for the diff code[1]. If we are going to do a workaround
like this, I think we could limit it only to cases where know it
matters, like --pickaxe-regex.

Can it be triggered with -G? I thought that operated on the diff content
itself, which would always be in a heap buffer (which should be NUL
terminated, but if it isn't, that would be a separate fix from this).

-Peff

[1] We do make the assumption elsewhere that git objects are
    NUL-terminated, but that is enforced by the object-reading code
    (with the exception of streamed blobs, but those are obviously dealt
    with separately anyway).
