Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD97320A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 08:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeLNIzJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 03:55:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:41768 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726998AbeLNIzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 03:55:09 -0500
Received: (qmail 22664 invoked by uid 109); 14 Dec 2018 08:55:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Dec 2018 08:55:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1763 invoked by uid 111); 14 Dec 2018 08:54:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 14 Dec 2018 03:54:40 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Dec 2018 03:55:07 -0500
Date:   Fri, 14 Dec 2018 03:55:07 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 1/3] serve: pass "config context" through to individual
 commands
Message-ID: <20181214085507.GD11777@sigill.intra.peff.net>
References: <20181211104236.GA6899@sigill.intra.peff.net>
 <20181211104342.GA7233@sigill.intra.peff.net>
 <20181214083621.GA7121@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181214083621.GA7121@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 12:36:21AM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > In protocol v2, instead of just running "upload-pack", we have a generic
> > "serve" loop which runs command requests from the client. What used to
> > be "upload-pack" is now generally split into two operations: "ls-refs"
> > and "fetch". The latter knows it must respect uploadpack.* config, but
> > the former is not actually specific to a fetch operation (we do not yet
> > do v2 receive-pack, but eventually we may, and ls-refs would support
> > both operations).
> 
> I think I'm missing something.  Why wouldn't "ls-refs for push" not pass
> the information that it's for push as part of the *body* of the ls-refs
> request?

I don't know. Why doesn't the current "ls-refs" say "ls-refs for fetch"?

Certainly if that information was carried from the client request it
would work fine, and ls-refs would have enough to know which config to
respect. But I could not find any documentation on this, nor discussion
of plans for a v2 push. Since that information isn't passed now, we'd
have to assume that "ls-refs" without "for-push" always means "for
fetch".

I'm conceptually OK with that, but if that is the plan for going
forward, it was not at all obvious to me (and it does feel rather
implicit).

> Is there some other more immediate motivation for this patch?  In the
> spirit of YAGNI, I would rather understand that motivation instead of
> one that in many possible designs would never materialize.

Without this information, in patch 3 ls-refs cannot know to look at
uploadpack.hiderefs, unless it makes the implicit assumption that it is
always serving a fetch.

-Peff
