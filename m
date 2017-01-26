Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D23331F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 23:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbdAZXBX (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 18:01:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:45627 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752363AbdAZXBS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 18:01:18 -0500
Received: (qmail 4503 invoked by uid 109); 26 Jan 2017 23:00:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 23:00:49 +0000
Received: (qmail 28649 invoked by uid 111); 26 Jan 2017 23:00:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 18:00:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2017 18:00:46 -0500
Date:   Thu, 26 Jan 2017 18:00:46 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 00/14] Allow fetch-pack to send ref names (globs allowed)
Message-ID: <20170126230046.aknesybfyzxhx3ia@sigill.intra.peff.net>
References: <cover.1485381677.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 02:02:53PM -0800, Jonathan Tan wrote:

> Negotiation currently happens by upload-pack initially sending a list of
> refs with names and SHA-1 hashes, and then several request/response
> pairs in which the request from fetch-pack consists of SHA-1 hashes
> (selected from the initial list). Allowing the request to consist of
> names instead of SHA-1 hashes increases tolerance to refs changing
> (due to time, and due to having load-balanced servers without strong
> consistency),

Interesting. My big question is: what happens when a ref _does_ change?
How does the client handle this?

The existing uploadpack.allowReachableSHA1InWant is there to work around
the problem that an http client may get a ref advertisement in one step,
and then come back later to do the want/have negotiation, at which point
the server has moved on (or maybe it's even a different server). There
the client says "I want sha1 X", and the server needs to say "well, X
isn't my tip now, but it's still acceptable for you to fetch".

But this seems to go in the opposite direction. After the advertisement,
the client decides "OK, I want to fetch refs/heads/master which is at
SHA1 X". It connects to the server and says "I want refs/heads/master".
Let's say the server has moved its version of the ref to SHA1 Y.

What happens? I think the server will say "wanted-ref master Y". Does
the client just decide to use "Y" then?  How does that interact with any
decisions the client might have made about X? I guess things like
fast-forwards have to be decided after we fetch the objects anyway
(since we cannot compute them until we get the pack), so maybe there
aren't any such decisions. I haven't checked.

> and is a step towards eliminating the need for the server
> to send the list of refs first (possibly improving performance).

I'm not sure it is all that useful towards that end. You still have to
break compatibility so that the client tells the server to suppress the
ref advertisement. After that, it is just a question of asking for the
refs. And you have two options:

  1. Ask the server to tell you the values of some subset of the refs,
     pick what you want, and then do the want/have as normal.

  2. Go straight to the want/have, but tell the server the refs you want
     instead of their sha1s.

I think your approach here would lead to (2).

But (1), besides being closer to how the protocol works now, seems like
it's more flexible. I can ask about the ref state without necessarily
having to retrieve the objects. How would you write git-ls-remote with
such a system?

> [1] There has been some discussion about whether the server should
> accept partial ref names, e.g. [2]. In this patch set, I have made the
> server only accept full names, and it is the responsibility of the
> client to send the multiple patterns which it wants to match. Quoting
> from the commit message of the second patch:
> 
>   For example, a client could reasonably expand an abbreviated
>   name "foo" to "want-ref foo", "want-ref refs/heads/foo", "want-ref
>   refs/tags/foo", among others, and ensure that at least one such ref has
>   been fetched.

That has a cost that scales linearly with the number of refs, because
you have to ask for each name 6 times.  After the discussion you linked,
I think my preference is more like:

  1. Teach servers to accept a list of patterns from the client
     which will be resolved in order. Unlike your system, the client
     only needs to specify the list once per session, rather than once
     per ref.

  2. (Optional) Give a shorthand for the stock patterns that git has had
     in place for years. That saves some bytes over specifying the
     patterns completely (though it's really not _that_ many bytes, so
     perhaps the complication isn't a big deal).

-Peff
