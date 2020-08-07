Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B53C433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53AA42177B
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgHGVpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:45:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:52344 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgHGVpf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 17:45:35 -0400
Received: (qmail 2828 invoked by uid 109); 7 Aug 2020 21:45:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 Aug 2020 21:45:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18696 invoked by uid 111); 7 Aug 2020 21:45:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 Aug 2020 17:45:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 Aug 2020 17:45:33 -0400
From:   Jeff King <peff@peff.net>
To:     Nuthan Munaiah <nm6061@rit.edu>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: `git blame` Line Number Off-by-one
Message-ID: <20200807214533.GC1871940@coredump.intra.peff.net>
References: <emc6590292-832a-4a35-8815-d5707731d605@sanctum>
 <20200807212159.GA1871940@coredump.intra.peff.net>
 <20200807213349.GB1871940@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200807213349.GB1871940@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 07, 2020 at 05:33:49PM -0400, Jeff King wrote:

> Dropping it entirely, as below, doesn't break any tests. Junio, do you
> know of a case this is meant to improve?
> [...]
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 94ef57c1cc..ce564a5916 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1143,8 +1143,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  
>  	blame_sort_final(&sb);
>  
> -	blame_coalesce(&sb);
> -
>  	if (!(output_option & (OUTPUT_COLOR_LINE | OUTPUT_SHOW_AGE_WITH_COLOR)))
>  		output_option |= coloring_mode;

I wondered also whether this sort was necessary (obviously it is for
coalescing, but is it otherwise?). But there are definitely tests that
break if it's removed (e.g. t8011-blame-split-file). And it's sorting on
"lno", which implies that yes, in some cases we may end up with a
contiguous block of final-result lines that was broken up and shuffled
around.

I'm not sure if that implies a case where source-coalescing could help.
Would you ever have such a case where they end up blaming to the same
commit?

I'm not sure. If so, then it would probably make sense for
blame_coalesce() to make sure that the ent->lno and next->lno blocks are
contiguous (as well as the s_lno ones).

But even if that's true, I'm not sure that this coalescing is really all
that beneficial. It doesn't impact the normal blame output at all (which
is line oriented anyway, and repeats information). It doesn't make
--porcelain more efficient, because we omit repeated commit details even
for non-contiguous blocks. It would let a consumer of --porcelain see
bigger blocks which could be useful for coloring, etc.

So I dunno. I'd still be curious to see a concrete case where this code
triggers and does something useful.

-Peff
