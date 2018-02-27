Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A730E1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 21:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeB0VdI (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:33:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:39408 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751723AbeB0VdH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 16:33:07 -0500
Received: (qmail 7504 invoked by uid 109); 27 Feb 2018 21:33:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 27 Feb 2018 21:33:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27473 invoked by uid 111); 27 Feb 2018 21:33:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 27 Feb 2018 16:33:56 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Feb 2018 16:33:05 -0500
Date:   Tue, 27 Feb 2018 16:33:05 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, christian.couder@gmail.com
Subject: Re: [PATCH v2] sha1_name: fix uninitialized memory errors
Message-ID: <20180227213305.GB6899@sigill.intra.peff.net>
References: <20180226204151.GA12598@sigill.intra.peff.net>
 <20180227114704.193145-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180227114704.193145-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 06:47:04AM -0500, Derrick Stolee wrote:

> Peff made an excellent point about the nested if statements. This
> goes back to Christian's original recommendation.
> 
> -- >8 --
> 
> During abbreviation checks, we navigate to the position within a
> pack-index that an OID would be inserted and check surrounding OIDs
> for the maximum matching prefix. This position may be beyond the
> last position, because the given OID is lexicographically larger
> than every OID in the pack. Then nth_packed_object_oid() does not
> initialize "oid".
> 
> Use the return value of nth_packed_object_oid() to prevent these
> errors.
> 
> Reported-by: Christian Couder <christian.couder@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

Thanks, this looks good to me.

Semi-related, I wondered also at the weird asymmetry in the if-else,
which is:

  if ...
  else if ...
  if ...

but the comment directly above says: "we consider a maximum of three
objects nearby". I think it's actually two, because you can only trigger
one of the first two conditionals.

Is that right?

Let's imagine we're looking for object 1234abcd.  If we didn't find a
match, then we might have:

  1234abcc 
  1234abce <-- first points here

in which case we need to check both first-1 and first. And we do.

If we do have a match, then we might see:

  1234abcc
  1234abcd <-- first points here
  1234abce

and we must check first-1 and first+1, but _not_ first.

So I think the code is right, but the comment is wrong.

-Peff
