Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF96A1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 01:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbeHOEMR (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 00:12:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:55732 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725843AbeHOEMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 00:12:16 -0400
Received: (qmail 15836 invoked by uid 109); 15 Aug 2018 01:22:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Aug 2018 01:22:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28670 invoked by uid 111); 15 Aug 2018 01:22:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 21:22:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 21:22:24 -0400
Date:   Tue, 14 Aug 2018 21:22:24 -0400
From:   Jeff King <peff@peff.net>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jeffhost@microsoft.com,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 6/6] list-objects-filter: implement filter tree:0
Message-ID: <20180815012224.GA4745@sigill.intra.peff.net>
References: <cover.1533854545.git.matvore@google.com>
 <cover.1534267611.git.matvore@google.com>
 <05e69ef260ca2b28b2444b94850bddf44ca0388a.1534267611.git.matvore@google.com>
 <20180814200154.GF28452@sigill.intra.peff.net>
 <CAMfpvhJM2hUXTfTgY9jA4aB+bgx44xbCktCacpy_yWacyjk00w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMfpvhJM2hUXTfTgY9jA4aB+bgx44xbCktCacpy_yWacyjk00w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 04:55:34PM -0700, Matthew DeVore wrote:

> >   - it's expensive to compute, because you have to actually walk all of
> >     the possible commits and trees that could refer to it. This
> >     prohibits a lot of other optimizations like reachability bitmaps
> >     (though with some complexity you could cache the depths, too).
> I think what the user likely wants is to use the minimum depth based
> on the commits in the traversal, not every commit in the repo - is
> this what you mean?

Right, I'd agree they probably want the minimum for that traversal. And
for `rev-list --filter`, that's probably OK. But keep in mind the main
goal for --filter is using it for fetches, and many servers do not
perform the traversal at all. Instead they use reachability bitmaps to
come up with the set of objects to send. The bitmaps have enough
information to say "remove all trees from the set", but not enough to do
any kind of depth-based calculation (not even "is this a root tree").

> Makes sense. I changed it like this -
> 
> diff --git a/Documentation/rev-list-options.txt
> b/Documentation/rev-list-options.txt
> index 0b5f77ad3..5f1672913 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -732,8 +732,10 @@ the requested refs.
>  The form '--filter=sparse:path=<path>' similarly uses a sparse-checkout
>  specification contained in <path>.
>  +
> -The form '--filter=tree:<depth>' omits all blobs and trees deeper than
> -<depth> from the root tree. Currently, only <depth>=0 is supported.
> +The form '--filter=tree:<depth>' omits all blobs and trees whose depth
> +from the root tree is >= <depth> (minimum depth if an object is located
> +at multiple depths in the commits traversed). Currently, only <depth>=0
> +is supported, which omits all blobs and trees.

Yes, I think that makes sense. Thanks!

-Peff
