Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39AEF1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 12:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755384AbdCGMbt (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 07:31:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:39670 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754831AbdCGMao (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 07:30:44 -0500
Received: (qmail 4346 invoked by uid 109); 7 Mar 2017 09:42:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Mar 2017 09:42:49 +0000
Received: (qmail 24248 invoked by uid 111); 7 Mar 2017 09:42:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Mar 2017 04:42:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Mar 2017 04:42:47 -0500
Date:   Tue, 7 Mar 2017 04:42:47 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mark Thomas <markbt@efaref.net>, git@vger.kernel.org
Subject: Re: [RFC 0/4] Shallow clones with on-demand fetch
Message-ID: <20170307094247.atdtqpttchk5r6qe@sigill.intra.peff.net>
References: <20170304191901.9622-1-markbt@efaref.net>
 <xmqqr32anri1.fsf@junio-linux.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr32anri1.fsf@junio-linux.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2017 at 11:18:30AM -0800, Junio C Hamano wrote:

> Mark Thomas <markbt@efaref.net> writes:
> 
> > This is a proof-of-concept, so it is in no way complete.  It contains a
> > few hacks to make it work, but these can be ironed out with a bit more
> > work.  What I have so far is sufficient to try out the idea.
> 
> Two things that immediately come to mind (which may or may not be
> real issues) are 
> 
>  (1) What (if any) security model you have in mind.
> 
>      From object-confidentiality's point of view, this needs to be
>      enabled only on a host that allows
>      uploadpack.allowAnySHA1InWant but even riskier.
> 
>      From DoS point of view, you can make a short 40-byte request to
>      cause the other side emit megabytes of stuff.  I do not think
>      it is a new problem (anybody can repeatedly request a clone of
>      large stuff), but there may be new ramifications.
> 
>  (2) If the interface to ask just one object kills the whole idea
>      due to roundtrip latency.
> 
>      You may want to be able to say "I want all objects reachable
>      from this tree; please give me a packfile of needed objects
>      assuming that I have all objects reachable from this other tree
>      (or these other trees)".

Not just latency, but you also lose all of the benefits of delta
compression. So if I asked for:

  git log -p -- foo.c

and git is going to fault in all of the various versions of foo.c over
time, it's _much_ more efficient to batch them into a single request, so
that the server can reuse on-disk deltas between the various versions.
That makes the transmission smaller, and it also makes it more likely
for the server to be able to transmit the bits straight off the disk
(rather than assembling each delta itself then zlib-compressing the
result).

Similarly, there's a latency tension in just finding out whether an
object exists. When we call has_sha1_file() as part of a fetch, for
example, we really want to be able to answer it quickly. So you'd
probably want some mechanism to say "tell me the sha1, type, and size"
of each object I _could_ get via upload-file. The size of that data is
far from trivial for a large repository, but you're probably better off
getting it once than paying the latency cost to fetch it piecemeal.

-Peff
