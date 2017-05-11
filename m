Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FC221FF34
	for <e@80x24.org>; Thu, 11 May 2017 10:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755154AbdEKKF5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 06:05:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:49428 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754975AbdEKKF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 06:05:56 -0400
Received: (qmail 5327 invoked by uid 109); 11 May 2017 10:05:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 10:05:56 +0000
Received: (qmail 12277 invoked by uid 111); 11 May 2017 10:06:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 06:06:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 06:05:54 -0400
Date:   Thu, 11 May 2017 06:05:54 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, spearce@spearce.org
Subject: Re: [PATCH v3] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170511100553.ptyazchujgdfxotl@sigill.intra.peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170510221157.8971-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170510221157.8971-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2017 at 03:11:57PM -0700, Jonathan Tan wrote:

> fetch-pack, when fetching a literal SHA-1 from a server that is not
> configured with uploadpack.allowtipsha1inwant (or similar), always
> returns an error message of the form "Server does not allow request for
> unadvertised object %s". However, it is sometimes the case that such
> object is advertised. This situation would occur, for example, if a user
> or a script was provided a SHA-1 instead of a branch or tag name for
> fetching, and wanted to invoke "git fetch" or "git fetch-pack" using
> that SHA-1.
> 
> Teach fetch-pack to also check the SHA-1s of the refs in the received
> ref advertisement if a literal SHA-1 was given by the user.

Stepping back a bit, what does this mean for a world where we implement
protocol extensions to let the client specify a set of refspecs to limit
the advertisement?

If we give the server our usual set of fetch refspecs, then we might
fail to fulfill a request that would have been advertised outside of
that set. And the behavior is confusing and non-transparent to the user.
I don't think that really makes sense, though; the advertisement we ask
for from the server should include only the bits we're interested in for
_this_ fetch.

If we tell the server "we are interested in abcd1234", then it's not
going to find any matching ref by name, obviously. So should servers
then treat 40-hex names in the incoming refspecs as a request to show
any names which have a matching sha1? That works against any server-side
optimizations to avoid looking at the complete set of refs, but it would
only have to kick in when the user actually specified a single SHA-1
(and even then only when allowAnySHA1 isn't on). So that's probably
workable.

None of this is your problem now either way; the advertisement-limiting
extension is still vaporware, albeit one we've discussed a lot. I just
wanted to make sure we weren't painting ourselves into any corners. And
I think this case could probably be handled.

-Peff
