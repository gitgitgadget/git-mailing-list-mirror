Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788B9C4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 01:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiKXBGv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 20:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiKXBGt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 20:06:49 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67448DAD04
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 17:06:48 -0800 (PST)
Received: (qmail 24311 invoked by uid 109); 24 Nov 2022 01:06:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Nov 2022 01:06:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21470 invoked by uid 111); 24 Nov 2022 01:06:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Nov 2022 20:06:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 23 Nov 2022 20:06:46 -0500
From:   Jeff King <peff@peff.net>
To:     Glen Choo <chooglen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] object-file: use real paths when adding alternates
Message-ID: <Y37DprbgD2Wg1PMZ@coredump.intra.peff.net>
References: <pull.1382.git.git.1668706274099.gitgitgadget@gmail.com>
 <pull.1382.v2.git.git.1669074557348.gitgitgadget@gmail.com>
 <221122.868rk3bxbb.gmgdl@evledraar.gmail.com>
 <Y30onDTUFmAezkSl@coredump.intra.peff.net>
 <kl6lwn7lch1h.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kl6lwn7lch1h.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 23, 2022 at 04:50:02PM -0800, Glen Choo wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> Doesn't this leak? I've just skimmed strbuf_realpath_1() but e.g. in the
> >> "REALPATH_MANY_MISSING" case it'll have allocated the "resolved" (the
> >> &tmp you pass in here) and then "does a "goto error_out".
> >> 
> >> It then *resets* the strbuf, but doesn't release it, assuming that
> >> you're going to pass it in again. So in that case we'd leak here, no?
> >> 
> >> I.e. a NULL return value from strbuf_realpath() doesn't mean that it
> >> didn't allocate in the scratch area passed to it, so we need to
> >> strbuf_release(&tmp) here too.
> >
> > We don't use MANY_MISSING in this code path, but I didn't read
> > strbuf_realpath_1() carefully enough to see if that is the only case.
> > But regardless, I think it is a bug in strbuf_realpath(). All of the
> > strbuf functions generally try to leave a buffer untouched on error.
> >
> > So IMHO we would want a preparatory patch with s/reset/release/ in that
> > function, which better matches the intent (we might be freeing an
> > allocated buffer, but that's OK from the caller perspective).
> 
> Is that always OK? I would think that we'd do something closer to
> strbuf_getcwd():
> 
>   int strbuf_getcwd(struct strbuf *sb)
>   {
>     size_t oldalloc = sb->alloc;
>     /* ... */
>     if (oldalloc == 0)
>       strbuf_release(sb);
>     else
>       strbuf_reset(sb);
>   }
> 
> i.e. if the caller passed in a strbuf with allocated contents, they're
> responsible for free()-ing it, otherwise we free() it. That does fix the
> leak in this patch, but I don't feel strongly enough about changing
> strbuf_realpath() to do it now, so I'll do without the change for now.

That's what I was getting at with "that's OK from the caller
perspective". strbuf_realpath() is also unlike other strbuf functions in
that it clobbers the contents of the buffer, even on success (rather
than adding on success and rolling back to the original state on error).

Since the caller is OK with the buffer being clobbered anyway, it should
not matter to it whether we clobbered an allocated buffer back to an
unallocated one on error. The confusing thing (and the current behavior)
is when we do the opposite: change an unallocated one to an allocated
one.

-Peff
