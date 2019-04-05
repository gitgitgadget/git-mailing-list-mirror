Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD66A20248
	for <e@80x24.org>; Fri,  5 Apr 2019 18:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbfDESbo (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 14:31:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:48848 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731589AbfDESbo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 14:31:44 -0400
Received: (qmail 12008 invoked by uid 109); 5 Apr 2019 18:31:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 18:31:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28598 invoked by uid 111); 5 Apr 2019 18:32:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 14:32:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 14:31:42 -0400
Date:   Fri, 5 Apr 2019 14:31:42 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
Message-ID: <20190405183142.GD2284@sigill.intra.peff.net>
References: <cover.1554435033.git.me@ttaylorr.com>
 <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 04, 2019 at 08:37:44PM -0700, Taylor Blau wrote:

> Let A be the object referenced with an unexpected type, and B be the
> object doing the referencing. Do the following:
> 
>   - test 'git rev-list --objects A B'. This causes A to be "cached", and
>     presents the above scenario.
> 
> Likewise, if we have a tree entry that claims to be a tree (for example)
> but points to another object type (say, a blob), there are two ways we
> might find out:
> 
>   - when we call lookup_tree(), we might find that we've already seen
>     the object referenced as another type, in which case we'd get NULL
> 
>   - we call lookup_tree() successfully, but when we try to read the
>     object, we find out it's something else.
> 
> We should check that we behave sensibly in both cases (especially
> because it is easy for a malicious actor to provoke one case or the
> other).

I think our pasting together of multiple commits adding the lone/seen
cases ended up in some redundancy in the description. In particular, I'm
not sure what the first paragraph/bullet quoted above is trying to say,
as it corresponds to the second bullet in the later list. Maybe collapse
them together like:

  We might hit an unexpected type in two different ways (imagine we have
  a tree entry that claims to be a tree but actually points to a blob):

    - when we call lookup_tree(), we might find that we've already seen
      the object referenced as a blob, in which case we'd get NULL. We
      can exercise this with "git rev-list --objects $blob $tree", which
      guarantees that the blob will have been parsed before we look in
      the tree. These tests are marked as "seen" in the test script.

    - we call lookup_tree() successfully, but when we try to read the
      object, we find out it's something else. We construct our tests
      such that $blob is not otherwise mentioned in $tree. These tests
      are marked as "lone" in the script.

-Peff
