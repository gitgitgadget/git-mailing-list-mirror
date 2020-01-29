Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11071C33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 05:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E46207FD
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 05:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgA2FJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:09:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:47170 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725208AbgA2FJg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 00:09:36 -0500
Received: (qmail 13883 invoked by uid 109); 29 Jan 2020 05:09:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Jan 2020 05:09:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13892 invoked by uid 111); 29 Jan 2020 05:17:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jan 2020 00:17:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jan 2020 00:09:35 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] diff: only prefetch for certain output formats
Message-ID: <20200129050935.GA601903@coredump.intra.peff.net>
References: <20200128213508.31661-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200128213508.31661-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 01:35:08PM -0800, Jonathan Tan wrote:

> Running "git status" on a partial clone that was cloned with
> "--no-checkout", like this:
> 
>   git clone --no-checkout --filter=blob:none <url> foo
>   git -C foo status
> 
> results in an unnecessary lazy fetch. This is because of commit
> 7fbbcb21b1 ("diff: batch fetching of missing blobs", 2019-04-08), which
> optimized "diff" by prefetching, but inadvertently affected at least one
> command ("status") that does not need prefetching. These 2 cases can be
> distinguished by looking at output_format; the former uses
> DIFF_FORMAT_PATCH and the latter uses DIFF_FORMAT_CALLBACK.

Sometimes "status" does need the actual blobs, if it's going to do
inexact rename detection. Likewise if break-detection is turned on,
though I don't think anything does it by default, and there's (I don't
think) any config option to enable it.

So something like "git log --name-status -B -M" would probably regress
from this (though only in speed, of course; I do think we can play a
little loose with heuristics since we'd generate the correct answer
either way).

You could get pretty specific by putting logic inside diffcore_rename(),
which would know if anything is left over after exact rename detection,
but I suspect just checking:

  (options->break_opt != -1 || options->detect_rename)

in diffcore_std() would be OK in practice.

> (Note that other callers that use DIFF_FORMAT_CALLBACK will also lose
> prefetching. I haven't investigated enough to see if this is a net
> benefit or drawback, but I think this will need to be done on a
> caller-by-caller basis and can be done in the future.)

We can't know what the caller is going to do with a
DIFF_FORMAT_CALLBACK, so I think it makes sense to avoid pre-fetching in
that case. It might be nice, though, if that pre-fetch loop in
diffcore_std() were pulled into a helper function, so they could just
call:

  diffcore_prefetch(&options);

or something. I'm OK to wait on that until one of the FORMAT_CALLBACK
users needs it, though.

> Points of discussion I can think of:
> 
>  - Is the whitelist of output_format constants the best?

I think it could be pared down a bit. For example, --raw doesn't
need the blobs (aside from renames, etc, above). I think the same is
true of --summary. You've already omitted --name-status and --name-only,
which makes sense.

I think --dirstat, even though it is only showing per-file info, still
relies on the line-level stat info. So it should stay.

>  - Should we just have the callers pass a prefetch boolean arg instead
>    of trying to guess it ourselves? I'm leaning towards no since I think
>    we should avoid options unless they are necessary.

If we can avoid it, I think we should. It makes sense to me to try to
tweak the heuristics as much as possible in this central code. If
there's a case that does the wrong thing, then we can decide whether the
heuristics can be improved, or if we need more information from the
caller.

-Peff
