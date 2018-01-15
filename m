Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F1A81F406
	for <e@80x24.org>; Mon, 15 Jan 2018 21:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750941AbeAOVdi (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 16:33:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:44398 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750737AbeAOVdh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 16:33:37 -0500
Received: (qmail 13407 invoked by uid 109); 15 Jan 2018 21:33:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 15 Jan 2018 21:33:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20022 invoked by uid 111); 15 Jan 2018 21:34:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 15 Jan 2018 16:34:12 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jan 2018 16:33:35 -0500
Date:   Mon, 15 Jan 2018 16:33:35 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 01/18] cat-file: split expand_atom into 2 functions
Message-ID: <20180115213335.GB4778@sigill.intra.peff.net>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
 <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 10, 2018 at 09:36:41AM +0000, Olga Telezhnaya wrote:

> Split expand_atom function into 2 different functions,
> expand_atom_into_fields prepares variable for further filling,
> (new) expand_atom creates resulting string.
> Need that for further reusing of formatting logic from ref-filter.

This commit puzzled me, and I had to look ahead to try to figure out why
we want this split (because on its face, the split is bad, since it
duplicates the list).

Later, the preparation step goes away, but we still are left with
expand_atom(). That's because the preparation was all moved into
ref-filter.c, where we rely on populate_value() to fill in the values,
and then we pick them out with our own formats.

That works, but I don't think it's where we want to end up in the long
run. Because:

  1. We still have the set of formats duplicated between expand_atom()
     and the "preparation" step. It's just that the preparation is now
     in ref-filter.c. What happens if ref-filter.c learns new formatting
     placeholders (or options for those placeholders) that cat-file.c
     doesn't, or vice versa? The two have to be kept in sync.

  2. We're missing out on all of the other placeholders that ref-filter
     knows about. Not all of them are meaningful (e.g., %(refname)
     wouldn't make sense here), but part of our goal is to support the
     same set of placeholders as much as possible. Some obvious ones
     that ought to work for cat-file: %(objectname:short), %(if), and
     things like %(subject) when the appropriate object type is used.

In other words, I think the endgame is that expand_atom() isn't there at
all, and we're calling the equivalent of format_ref_item() for each
object (except that in a unified formatting world, it probably doesn't
have the word "ref" in it, since that's just one of the items a caller
might pass in).

-Peff
