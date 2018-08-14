Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B89F41F404
	for <e@80x24.org>; Tue, 14 Aug 2018 20:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbeHNWun (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 18:50:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:55236 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728270AbeHNWun (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 18:50:43 -0400
Received: (qmail 3386 invoked by uid 109); 14 Aug 2018 20:01:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 20:01:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25653 invoked by uid 111); 14 Aug 2018 20:02:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 16:02:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 16:01:55 -0400
Date:   Tue, 14 Aug 2018 16:01:55 -0400
From:   Jeff King <peff@peff.net>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jeffhost@microsoft.com,
        stefanbeller@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 6/6] list-objects-filter: implement filter tree:0
Message-ID: <20180814200154.GF28452@sigill.intra.peff.net>
References: <cover.1533854545.git.matvore@google.com>
 <cover.1534267611.git.matvore@google.com>
 <05e69ef260ca2b28b2444b94850bddf44ca0388a.1534267611.git.matvore@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <05e69ef260ca2b28b2444b94850bddf44ca0388a.1534267611.git.matvore@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 10:28:13AM -0700, Matthew DeVore wrote:

> The name "tree:0" allows later filtering based on depth, i.e. "tree:1"
> would filter out all but the root tree and blobs. In order to avoid
> confusion between 0 and capital O, the documentation was worded in a
> somewhat round-about way that also hints at this future improvement to
> the feature.

I'm OK with this as a name, since we're explicitly not supporting deeper
depths. But I'd note that "depth" is actually a tricky characteristic,
as it's not a property of the object itself, but rather who refers to
it. So:

  - it's expensive to compute, because you have to actually walk all of
    the possible commits and trees that could refer to it. This
    prohibits a lot of other optimizations like reachability bitmaps
    (though with some complexity you could cache the depths, too).

  - you have to define it as something like "the minimum depth at which
    this object is found", since there may be multiple depths

I think you can read that second definition between the lines of:

> +The form '--filter=tree:<depth>' omits all blobs and trees deeper than
> +<depth> from the root tree. Currently, only <depth>=0 is supported.

But I wonder if we should be more precise. It doesn't matter now, but it
may help set expectations if the feature does come later.

-Peff
