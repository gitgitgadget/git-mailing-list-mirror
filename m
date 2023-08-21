Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3A9EE49B1
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 20:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjHUUmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjHUUmG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 16:42:06 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C06E63
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:41:07 -0700 (PDT)
Received: (qmail 17460 invoked by uid 109); 21 Aug 2023 20:41:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Aug 2023 20:41:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19149 invoked by uid 111); 21 Aug 2023 20:41:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Aug 2023 16:41:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Aug 2023 16:41:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/5] diff: move the fallback "--exit-code" code down
Message-ID: <20230821204106.GB1800481@coredump.intra.peff.net>
References: <20230817222949.3835424-1-gitster@pobox.com>
 <20230818235932.3253552-1-gitster@pobox.com>
 <20230818235932.3253552-2-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818235932.3253552-2-gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2023 at 04:59:28PM -0700, Junio C Hamano wrote:

> diff --git a/diff.c b/diff.c
> index d52db685f7..0ce678fc06 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6551,6 +6551,21 @@ void diff_flush(struct diff_options *options)
>  		separator++;
>  	}
>  
> +	if (output_format & DIFF_FORMAT_PATCH) {
> +		if (separator) {

This step makes sense, but I did a double-take when looking at the
patch, because it is moving code _up_ rather than _down_. But the
problem is that the block you moved was larger than the intervening bit,
so the diff chose to flip-flop the context and changed bits.

Obviously orthogonal to your series, but I wonder if there's a way to
convince Git to show what actually happened. I don't think this is
really a heuristic or algorithm problem. Seeing the pre- and
post-images, it can't know whether it was "move A up" or "move B down",
and the "real" diff is simply much larger in this case.

-Peff
