Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBB581F404
	for <e@80x24.org>; Wed, 24 Jan 2018 20:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932479AbeAXUdB (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 15:33:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:55978 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932072AbeAXUdA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 15:33:00 -0500
Received: (qmail 29891 invoked by uid 109); 24 Jan 2018 20:33:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Jan 2018 20:33:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28331 invoked by uid 111); 24 Jan 2018 20:33:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 15:33:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 15:32:58 -0500
Date:   Wed, 24 Jan 2018 15:32:58 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kim Gybels <kgybels@infogroep.be>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/6] packed_ref_iterator_begin(): make optimization more
 general
Message-ID: <20180124203258.GB7773@sigill.intra.peff.net>
References: <cover.1516791909.git.mhagger@alum.mit.edu>
 <bf6c0c67430b936738f5e8891b82022d0127acb0.1516791909.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf6c0c67430b936738f5e8891b82022d0127acb0.1516791909.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 12:14:14PM +0100, Michael Haggerty wrote:

> We can return an empty iterator not only if the `packed-refs` file is
> missing, but also if it is empty or if there are no references whose
> names succeed `prefix`. Optimize away those cases as well by moving
> the call to `find_reference_location()` higher in the function and
> checking whether the determined start position is the same as
> `snapshot->eof`. (This is possible now because the previous commit
> made `find_reference_location()` robust against empty snapshots.)

Makes sense.

> @@ -937,11 +942,6 @@ static struct ref_iterator *packed_ref_iterator_begin(
>  	iter->snapshot = snapshot;
>  	acquire_snapshot(snapshot);
>  
> -	if (prefix && *prefix)
> -		start = find_reference_location(snapshot, prefix, 0);
> -	else
> -		start = snapshot->start;
> -

I did a double-take here that we are now looking at the snapshot without
calling acquire_snapshot(). But that function is just about taking a
refcount on it. The actual acquisition of data happens in
get_snapshot().

-Peff
