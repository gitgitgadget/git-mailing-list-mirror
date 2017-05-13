Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1443D201A4
	for <e@80x24.org>; Sat, 13 May 2017 08:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbdEMIu4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 04:50:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:50752 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751217AbdEMIuz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 04:50:55 -0400
Received: (qmail 27259 invoked by uid 109); 13 May 2017 08:50:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 08:50:52 +0000
Received: (qmail 30536 invoked by uid 111); 13 May 2017 08:51:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 04:51:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 May 2017 04:50:50 -0400
Date:   Sat, 13 May 2017 04:50:50 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] hashmap: hashmap_get_next passes through keydata as well
Message-ID: <20170513085050.plmau5ffvzn6ibfp@sigill.intra.peff.net>
References: <20170512200244.25245-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170512200244.25245-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 01:02:44PM -0700, Stefan Beller wrote:

> The 'keydata' may be of value in the underlying compare function to decide
> if the given two entries are the same.

I had to scratch my head over this for a minute, because there isn't
really any motivating example of what you're trying to do.

I think I figured it out, but I have a feeling it is violating the
intent of the "keydata" parameter.  That parameter is typically used not
as a pointer to arbitrary auxiliary data, but as a trick for finding a
hash entry without having to allocate a struct for it.

So generally, I'd think two entries in the table should be able to be
compared on their own merits, even if no keydata is available. Without
that property, any internal operations in the hashmap can't actually do
an entry comparison (e.g., a table resize that needs to rehash the
entries).

It works out in the current code because the chaining is purely linear,
and doesn't care about order. So we can rehash and just stick the
elements into a new list. But if it were switched out for a different
data structure (e.g., a tree), then the hashmap code would need to be
able to compare elements.

I don't think we have any particular plans for such a change, but I
wonder if we should avoid encouraging callers to rely on the current
implementation.

-Peff
