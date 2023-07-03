Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1D4EB64DD
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjGCG05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjGCG0z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:26:55 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FE11B6
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:26:46 -0700 (PDT)
Received: (qmail 12118 invoked by uid 109); 3 Jul 2023 06:26:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:26:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2475 invoked by uid 111); 3 Jul 2023 06:26:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:26:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:26:44 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 15/16] upload-pack.c: avoid enumerating hidden refs
 where possible
Message-ID: <20230703062644.GI3502534@coredump.intra.peff.net>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
 <19bf4a52d696b4789e6ab9c62f51d0ba955b7b6a.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19bf4a52d696b4789e6ab9c62f51d0ba955b7b6a.1687270849.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 10:22:17AM -0400, Taylor Blau wrote:

> In a similar fashion as a previous commit, teach `upload-pack` to avoid
> enumerating hidden references where possible.
> 
> Note, however, that there are certain cases where cannot avoid
> enumerating even hidden references, in particular when either of:
> 
>   - `uploadpack.allowTipSHA1InWant`, or
>   - `uploadpack.allowReachableSHA1InWant`
> 
> are set, corresponding to `ALLOW_TIP_SHA1` and `ALLOW_REACHABLE_SHA1`,
> respectively.
> 
> When either of these bits are set, upload-pack's `is_our_ref()` function
> needs to consider the `HIDDEN_REF` bit of the referent's object flags.
> So we must visit all references, including the hidden ones, in order to
> mark their referents with the `HIDDEN_REF` bit.
> 
> When neither `ALLOW_TIP_SHA1` nor `ALLOW_REACHABLE_SHA1` are set, the
> `is_our_ref()` function considers only the `OUR_REF` bit, and not the
> `HIDDEN_REF` one. `OUR_REF` is applied via `mark_our_ref()`, and only
> to objects at the tips of non-hidden references, so we do not need to
> visit hidden references in this case.

Both of these are noops if uploadpack.allowAnySHA1InWant is set, or if
we are using the v2 protocol. Setting both allowAny and allowTip is
sufficiently stupid that I don't care much that they lose out on an
optimization. But I could see somebody setting one of those for the
benefit of v0 clients, but then also serving v2 clients (which
effectively ignore those restrictions).

I guess v2 clients don't hit this code at all (they are handled by
ls-refs, which comes in the next patch). So that just leaves the case
that allowAny is set. By itself the optimization should kick in (good).
With allowTip or allowReachable it would not, but that is the "this is
stupid" case in which it is OK to fall back to the existing behavior
(even though we _could_ enable the optimization). OTOH, it would be easy
to check it, as it's just another bit in allow_uor.

I'm OK going either way.

-Peff
