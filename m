Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C76E1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 14:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeCNO41 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 10:56:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:56196 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752327AbeCNO4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 10:56:25 -0400
Received: (qmail 20940 invoked by uid 109); 14 Mar 2018 14:56:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Mar 2018 14:56:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1137 invoked by uid 111); 14 Mar 2018 14:57:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Mar 2018 10:57:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Mar 2018 10:56:23 -0400
Date:   Wed, 14 Mar 2018 10:56:23 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [git-sizer] Implications of a large commit object
Message-ID: <20180314145623.GB15531@sigill.intra.peff.net>
References: <953C263C-6ECA-46AC-849C-8D1A38378654@gmail.com>
 <CAMy9T_GdYjUm9DqcgrC=NxyTbZk_ep5rvAAK2J=zwhiSMyvaLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMy9T_GdYjUm9DqcgrC=NxyTbZk_ep5rvAAK2J=zwhiSMyvaLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 14, 2018 at 09:33:32AM +0100, Michael Haggerty wrote:

> Maybe your migration tool created a huge commit message, for example
> listing each of the files that was changed.
> 
> AFAIK this won't cause Git itself any problems, but it's likely to be
> inconvenient. For example, when you type `git log` and 7 million
> characters page by. Or when you use some GUI tool to view your history
> and it performs badly because it wasn't built to handle such enormous
> commit messages.

Probably one such commit won't break the bank, but it will make history
traversals that cross it slower (e.g., "--contains", merge-bases, etc).
We'll load the whole 7MB object just to find its parents. If you imagine
the average commit object is more like 1k and that current traversals
bottleneck on loading the commit object bytes (both of which I think are
roughly accurate), then crossing that one commit in a traversal is
equivalent to crossing 7000 "normal" commits in cost.

At least until Stolee's serialized commit graph work is merged, at which
point it will only be expensive if we actually try to show the commit
message for that particular object.

-Peff
