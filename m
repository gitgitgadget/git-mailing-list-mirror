Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E041F461
	for <e@80x24.org>; Fri,  6 Sep 2019 06:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391672AbfIFGfF (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 02:35:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:41752 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726525AbfIFGfF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 02:35:05 -0400
Received: (qmail 14772 invoked by uid 109); 6 Sep 2019 06:35:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Sep 2019 06:35:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2109 invoked by uid 111); 6 Sep 2019 06:36:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Sep 2019 02:36:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Sep 2019 02:35:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, stolee@gmail.com,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] commit-graph.c: die on un-parseable commits
Message-ID: <20190906063503.GB5122@sigill.intra.peff.net>
References: <cover.1567563244.git.me@ttaylorr.com>
 <34e4ec793cb0d321d16b88777cd2db64ed7b772e.1567563244.git.me@ttaylorr.com>
 <20190904030456.GA28836@sigill.intra.peff.net>
 <xmqqsgpao06z.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgpao06z.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 05, 2019 at 03:19:48PM -0700, Junio C Hamano wrote:

> > Here an earlier parsing error could cause (*list)->object.parsed to be
> > true, but with (*list)->maybe_tree still NULL. Our call to
> > parse_commit_no_graph() here would silently return "yep, already tried
> > to parse this", and then we'd still segfault.
> > ...
> > And I think there's literally no way for this function to tell the
> > difference between "no parent" and "there was an earlier error, but we
> > set the parsed flag anyway and the parent flag is invalid".
> >
> > I think that argues against Junio's response in:
> 
> Fair enough.  Forcing later users to reattempt parsing (and failing
> the same way) would be safer and it should also be sufficient as we
> are talking about how to handle a broken repository, i.e. an error
> case.

One of the tricky things, and the reason I used a "corrupt" flag in my
earlier sketch, is that the state after we encounter a parse error is
unknown. So imagine parse_commit_buffer() sees that one of the parent
lines is bogus, and we return an error. The caller gets to see whatever
half-parsed state we managed to come up with.

So far so good. But now imagine we call parse_commit_buffer() again, and
we re-parse. How does that interact with the half-parsed state? Some of
it works OK (e.g., lookup_tree() would find the same tree). Some not so
much (I think we'd keep appending parents at each call).

I guess this might not be too bad to handle. Value fields like
timestamp_t are OK to overwrite. Pointers to objects likewise, since the
memory is owned elsewhere. If we see existing parent pointers in an
object we're parsing, we could probably free them under the assumption
they're leftover cruft. Likewise for the "tag" field of "struct tag",
which is owned by the struct and should be freed.

Blobs and trees don't actually parse anything into their structs. So
it's really just special-casing those two items.

-Peff
