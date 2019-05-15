Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C00551F461
	for <e@80x24.org>; Wed, 15 May 2019 23:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfEOXZB (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 19:25:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:58742 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726369AbfEOXXA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 19:23:00 -0400
Received: (qmail 30256 invoked by uid 109); 15 May 2019 23:16:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 May 2019 23:16:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25683 invoked by uid 111); 15 May 2019 23:16:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 15 May 2019 19:16:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 May 2019 19:16:18 -0400
Date:   Wed, 15 May 2019 19:16:18 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
Message-ID: <20190515231617.GA1395@sigill.intra.peff.net>
References: <cover.1557868134.git.jonathantanmy@google.com>
 <4fcaa4481b5fd2a76aa21263f997e00913db0e0f.1557868134.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4fcaa4481b5fd2a76aa21263f997e00913db0e0f.1557868134.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 02:10:55PM -0700, Jonathan Tan wrote:

> Support for lazy fetching should still generally be turned off in
> index-pack because it is used as part of the lazy fetching process
> itself (if not, infinite loops may occur), but we do need to fetch the
> REF_DELTA bases. (When fetching REF_DELTA bases, it is unlikely that
> those are REF_DELTA themselves, because we do not send "have" when
> making such fetches.)

I agree that the current implementation (and probably any sane
implementation) would not send us a delta if we have not provided any
haves. But this does mean that a malicious server could send a client
into an infinite loop.

Pretty unlikely, but should we put some kind of circuit-breaker into the
client to ensure this?

> To resolve this, prefetch all missing REF_DELTA bases before attempting
> to resolve them. This both ensures that all bases are attempted to be
> fetched, and ensures that we make only one request per index-pack
> invocation, and not one request per missing object.

Ah, but now things get more tricky.

You are assuming that the server does not ever send a REF_DELTA unless
the base object is not present in the pack (it would use OFS_DELTA
instead). If we imagine a server which did, then there are two
implications:

  1. We might pre-fetch a full copy of an object that we don't need.
     It's just that it's stored as a delta in the pack which we are
     currently indexing.

  2. If we pre-fetch multiple objects, some of them may be REF_DELTAs
     against each other, leading to an infinite loop.

Off the top of my head, I am pretty sure your assumption holds for all
versions of Git that support delta-base-offset[1]. But that feels a lot
less certain to me. I could imagine an alternate server implementation,
for example, that is gluing together packs and does not try hard to
order the base before the delta, which would require it to use REF_DELTA
instead of OFS_DELTA.

That's sort of contrived, but it does feel like we're introducing a
really subtle requirement on the server here, which might close off
options to us in the future.

Unfortunately, I can't really think of a way for an existing client to
solve this without doing individual fetches for each REF_DELTA as we
encounter a need for it. In fact, even then we may lose if our ordering
is unlucky. E.g., imagine we have two packfile entries whose object ids
(which we don't know yet!) are X and Y, and they are stored as
REF_DELTAs with bases Z and X, respectively. Then either:

  1. We try to resolve X first. We fetch Z on-demand, and reconstruct X.
     We're lucky, because when we try to resolve Y, we see that we
     already have its base X.

  2. We try to resolve Y first. We fetch X on-demand, and reconstruct Y.
     We're unlucky; we then resolve X, but only after on-demand fetching
     Z and reconstructing it do we realize that we already had it.

So really, pre-fetching all of the REF_DELTAs just means we always hit
the unlucky case. But even with careful on-demand fetching, our worst
case is the same (and even worse in terms of latency).

I dunno. Maybe we should just ignore it. It's a fundamental issue with
partial clones that we're going to have to fetch extra junk here anyway,
because what the server _optimally_ would do is not send us deltas
against objects we don't have anyway. We just don't have an efficient
way to tell it what we do have.

If we're willing to modify the format, one thing we _could_ do is have
the server communicate the expectations for each base. I.e., introduce a
new THIN_DELTA type that behaves exactly as a REF_DELTA, but with the
extra 1-bit of knowledge that the server knows it is not including the
base in the pack. I'm not sure how painful that retro-fitting would be.
It would need at least a new capability and options to pack-objects and
index-pack. We might be tight on bits in the packfile type field.

-Peff

[1] Of course there are versions of Git that don't support
    delta-base-offset. They wouldn't support partial clones either, but
    it's possible to fetch into a partially-cloned repository from
    another remote. Given how old and rare such versions are, I think we
    can probably discount it entirely. I'm much more concerned about
    alternate implementations, or trying our hands for future
    pack-objects optimizations.
