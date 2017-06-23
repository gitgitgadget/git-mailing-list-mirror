Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081D620282
	for <e@80x24.org>; Fri, 23 Jun 2017 19:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754936AbdFWT4E (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 15:56:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:51144 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754796AbdFWT4D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 15:56:03 -0400
Received: (qmail 14616 invoked by uid 109); 23 Jun 2017 19:56:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Jun 2017 19:56:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18609 invoked by uid 111); 23 Jun 2017 19:56:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jun 2017 15:56:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2017 15:56:01 -0400
Date:   Fri, 23 Jun 2017 15:56:01 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 28/29] repack_without_refs(): don't lock or unlock the
 packed refs
Message-ID: <20170623195600.cvn26gt7o5rtywy6@sigill.intra.peff.net>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
 <38b397dddd210f008e28d9a92218727b08a08735.1498200513.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38b397dddd210f008e28d9a92218727b08a08735.1498200513.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 09:01:46AM +0200, Michael Haggerty wrote:

> Change `repack_without_refs()` to expect the packed-refs lock to be
> held already, and not to release the lock before returning. Change the
> callers to deal with lock management.
> 
> This change makes it possible for callers to hold the packed-refs lock
> for a longer span of time, a possibility that will eventually make it
> possible to fix some longstanding races.

This is the sort of clue I was thinking about in my last email. :)

> The only semantic change here is that `repack_without_refs()` used to
> forgot to release the lock in the `if (!removed)` exit path. That
> omission is now fixed.

s/used to forgot/previously forgot/ or similar?

> @@ -731,14 +717,12 @@ int repack_without_refs(struct ref_store *ref_store,
>  		 * All packed entries disappeared while we were
>  		 * acquiring the lock.
>  		 */
> -		rollback_packed_refs(refs);
> +		clear_packed_ref_cache(refs);
>  		return 0;

And this is the reason for the earlier "you should be able to clear the
packed ref cache without holding the lock" commit, I guess. Makes sense.

-Peff
