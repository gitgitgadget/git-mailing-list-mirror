Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C587120229
	for <e@80x24.org>; Sat, 22 Oct 2016 05:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbcJVFE3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 01:04:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:32798 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750839AbcJVFE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 01:04:29 -0400
Received: (qmail 12965 invoked by uid 109); 22 Oct 2016 05:04:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 22 Oct 2016 05:04:29 +0000
Received: (qmail 9460 invoked by uid 111); 22 Oct 2016 05:04:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 22 Oct 2016 01:04:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Oct 2016 01:04:26 -0400
Date:   Sat, 22 Oct 2016 01:04:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] transport: allow summary-width to be computed
 dynamically
Message-ID: <20161022050426.t2fifjqrldc6mebc@sigill.intra.peff.net>
References: <xmqqa8dxbb9r.fsf@gitster.mtv.corp.google.com>
 <20161021223927.26364-1-gitster@pobox.com>
 <20161021223927.26364-4-gitster@pobox.com>
 <xmqqoa2d9eum.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqoa2d9eum.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 09:39:45PM -0700, Junio C Hamano wrote:

> And this is the final one.
> 
> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Fri, 21 Oct 2016 21:33:06 -0700
> Subject: [PATCH] transport: compute summary-width dynamically
> 
> Now all that is left to do is to actually iterate over the refs
> and measure the display width needed to show their abbreviation.

I think we crossed emails. :) This is obviously correct, if we don't
mind paying the find_unique_abbrev cost twice for each sha1.

>  int transport_summary_width(const struct ref *refs)
>  {
> -	return (2 * FALLBACK_DEFAULT_ABBREV + 3);
> +	int maxw;
> +
> +	for (maxw = -1; refs; refs = refs->next) {
> +		maxw = measure_abbrev(&refs->old_oid, maxw);
> +		maxw = measure_abbrev(&refs->new_oid, maxw);
> +	}

This is a minor style nit, but I think it's better to avoid mixing
unrelated bits between the initialization, condition, and iteration bits
of a for loop. IOW:

  int maxw = -1;

  for (; refs; refs = refs->next) {
	...
  }

makes the for-loop _just_ about iteration, and it is more clear that the
manipulation of "maxw" is a side effect of the loop that is valid after
it finishes.

Though in this particular case, the loop and the whole function are
short enough that I don't care that much. Just raising a philosophical
point. :)

-Peff
