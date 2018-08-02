Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 384D41F597
	for <e@80x24.org>; Thu,  2 Aug 2018 16:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbeHBScX (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 14:32:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:40472 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727079AbeHBScX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 14:32:23 -0400
Received: (qmail 16804 invoked by uid 109); 2 Aug 2018 16:40:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 Aug 2018 16:40:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25338 invoked by uid 111); 2 Aug 2018 16:40:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 02 Aug 2018 12:40:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Aug 2018 12:40:26 -0400
Date:   Thu, 2 Aug 2018 12:40:26 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, bmwill@google.com
Subject: Re: [PATCH] fetch-pack: unify ref in and out param
Message-ID: <20180802164026.GB15984@sigill.intra.peff.net>
References: <20180729121900.GA16770@sigill.intra.peff.net>
 <20180801201320.201133-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180801201320.201133-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 01, 2018 at 01:13:20PM -0700, Jonathan Tan wrote:

> When a user fetches:
>  - at least one up-to-date ref and at least one non-up-to-date ref,
>  - using HTTP with protocol v0 (or something else that uses the fetch
>    command of a remote helper)
> some refs might not be updated after the fetch.
> 
> This bug was introduced in commit 989b8c4452 ("fetch-pack: put shallow
> info in output parameter", 2018-06-28) which allowed transports to
> report the refs that they have fetched in a new out-parameter
> "fetched_refs". If they do so, transport_fetch_refs() makes this
> information available to its caller.
> 
> Users of "fetched_refs" rely on the following 3 properties:
>  (1) it is the complete list of refs that was passed to
>      transport_fetch_refs(),
>  (2) it has shallow information (REF_STATUS_REJECT_SHALLOW set if
>      relevant), and
>  (3) it has updated OIDs if ref-in-want was used (introduced after
>      989b8c4452).
> [...]

Thanks, this is a very clear and well-organized commit message. It
answers my questions, and I agree with the general notion of "we can
figure out the right API for ref patterns later" approach.

>  builtin/clone.c             |  4 ++--
>  builtin/fetch.c             | 28 ++++------------------------
>  fetch-object.c              |  2 +-
>  fetch-pack.c                | 30 +++++++++++++++---------------
>  t/t5551-http-fetch-smart.sh | 18 ++++++++++++++++++
>  transport-helper.c          |  6 ++----
>  transport-internal.h        |  9 +--------
>  transport.c                 | 34 ++++++----------------------------
>  transport.h                 |  3 +--

The patch itself looks sane to me, and obviously fixes the problem. I
cannot offhand think of any reason that munging the existing list would
be a problem (though it has been a while since I have dealt with this
code, so take that with the appropriate grain of salt).

-Peff
