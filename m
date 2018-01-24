Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 546A61F404
	for <e@80x24.org>; Wed, 24 Jan 2018 20:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932250AbeAXU2C (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 15:28:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:55954 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932238AbeAXU2B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 15:28:01 -0500
Received: (qmail 29479 invoked by uid 109); 24 Jan 2018 20:27:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Jan 2018 20:27:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28265 invoked by uid 111); 24 Jan 2018 20:28:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 15:28:34 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 15:27:54 -0500
Date:   Wed, 24 Jan 2018 15:27:54 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kim Gybels <kgybels@infogroep.be>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/6] find_reference_location(): make function safe for
 empty snapshots
Message-ID: <20180124202754.GA7773@sigill.intra.peff.net>
References: <cover.1516791909.git.mhagger@alum.mit.edu>
 <e9f9ed1944c297a68c2b76f5d4ddd73e279bd207.1516791909.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9f9ed1944c297a68c2b76f5d4ddd73e279bd207.1516791909.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 12:14:13PM +0100, Michael Haggerty wrote:

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 08698de6ea..361affd7ad 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> [...]
> @@ -551,7 +553,7 @@ static const char *find_reference_location(struct snapshot *snapshot,
>  	 */
>  	const char *hi = snapshot->eof;
>  
> -	while (lo < hi) {
> +	while (lo != hi) {
>  		const char *mid, *rec;
>  		int cmp;

This tightens the binary search termination condition. If we ever did
see "hi > lo", we'd want to terminate the loop. Is that ever possible?

I think the answer is "no". Our "hi" here is an exclusive bound, so we
should never go past it via find_end_of_record() when assigning "lo".
And "hi" is always assigned from the start of the current record. That
can never cross "lo", because find_start_of_record() ensures it.

So I think it's fine, but I wanted to double check.

-Peff
