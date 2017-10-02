Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47A0E202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750852AbdJBFDy (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:03:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:56988 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750752AbdJBFDx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:03:53 -0400
Received: (qmail 5468 invoked by uid 109); 2 Oct 2017 05:03:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 05:03:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24999 invoked by uid 111); 2 Oct 2017 05:04:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 01:04:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 01:03:51 -0400
Date:   Mon, 2 Oct 2017 01:03:51 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v5 6/6] ref-filter.c: parse trailers arguments with
 %(contents) atom
Message-ID: <20171002050351.imuntcy3xnq4wxux@sigill.intra.peff.net>
References: <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
 <20171002003304.77514-1-me@ttaylorr.com>
 <20171002003304.77514-6-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171002003304.77514-6-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2017 at 05:33:04PM -0700, Taylor Blau wrote:

> The %(contents) atom takes a contents "field" as its argument. Since
> "trailers" is one of those fields, extend contents_atom_parser to parse
> "trailers"'s arguments when used through "%(contents)", like:
> 
>   %(contents:trailers:unfold,only)
> 
> A caveat: trailers_atom_parser expects NULL when no arguments are given
> (see: `parse_ref_filter_atom`). This is because string_list_split (given
> a maxsplit of -1) returns a 1-ary string_list* containing the given
> string if the delimiter could not be found using `strchr`.
> 
> To simulate this behavior without teaching trailers_atom_parser to
> accept strings with length zero, conditionally pass NULL to
> trailers_atom_parser if the arguments portion of the argument to
> %(contents) is empty.

Doh, that string_list behavior is what I was missing in my earlier
comments. I agree this is probably the best way of doing it. I'm tempted
to say that parse_ref_filter_atom() should do a similar thing. Right now
we've got:

  $ git for-each-ref --format='%(refname)' | wc
     2206    2206   79929
  $ git for-each-ref --format='%(refname:short)' | wc
     2206    2206   53622
  $ git for-each-ref --format='%(refname:)' | wc
  fatal: unrecognized %(refname:) argument:
      0       0       0

which seems a bit unfriendly. As we're on v6 here, I don't want to
suggest it as part of this series. But maybe a #leftoverbits candidate,
if others agree it's a good direction.

-Peff
