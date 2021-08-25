Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4219EC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 00:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1386E61373
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 00:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbhHYA3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 20:29:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:58340 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231552AbhHYA3W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 20:29:22 -0400
Received: (qmail 21076 invoked by uid 109); 25 Aug 2021 00:28:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Aug 2021 00:28:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3391 invoked by uid 111); 25 Aug 2021 00:28:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Aug 2021 20:28:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Aug 2021 20:28:36 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 00/25] multi-pack reachability bitmaps
Message-ID: <YSWOtNoxirDdmBXG@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1629821743.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 12:15:47PM -0400, Taylor Blau wrote:

> Range-diff against v3:
> [...]
>  9:  40cff5beb5 !  9:  c9fea31fa8 midx: avoid opening multiple MIDXs when writing
>     @@ Commit message
>          one and should invalidate the object store's memory of any MIDX that
>          might have existed beforehand.
>      
>     +    Note that this now forbids passing object directories that don't belong
>     +    to alternate repositories over `--object-dir`, since before we would
>     +    have happily opened a MIDX in any directory, but now restrict ourselves
>     +    to only those reachable by `r->objects->multi_pack_index` (and alternate
>     +    MIDXs that we can see by walking the `next` pointer).
>     +
>     +    As far as I can tell, supporting arbitrary directories with
>     +    `--object-dir` was a historical accident, since even the documentation
>     +    says `<alt>` when referring to the value passed to this option.
>     +
>     +    A future patch could clean this up and provide a warning() when a
>     +    non-alternate directory was given, since we'll still write a new MIDX
>     +    there, we just won't reuse any MIDX that might happen to already exist
>     +    in that directory.
>     +

So this is definitely fixed as we discussed. But since that discussion,
we've had the thread over in:

  https://lore.kernel.org/git/20210820195558.44275-1-johannes@sipsolutions.net/

and its siblings:

  https://lore.kernel.org/git/20210823094049.44136-1-johannes@sipsolutions.net/

  https://lore.kernel.org/git/20210823171011.80588-1-johannes@sipsolutions.net/

It's not clear to me that we have a resolution on whether calling "cd ..
&& git multi-pack-index write --object-dir repo.git" is supposed to
work.

It has traditionally worked (at least for trivial cases, AFAICT), but I
find the behavior surprising and unlike most of the rest of Git, and I'm
not at all certain that there aren't subtle bugs lurking (basically
anything that wants to do object lookup, like oh say, a bitmap
generator).

But if we do want to support it, then we have to find a different
solution here, don't we?  I think the least-painful version of that is
probably recording _whether_ we found ctx.m in the_repository's
object_store, and switching behavior based on that (e.g., calling
close_midx() versus close_object_store() depending).

-Peff
