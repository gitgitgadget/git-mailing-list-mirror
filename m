Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81ABC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 04:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A539C61058
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 04:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241905AbhIAFAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 01:00:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:36040 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhIAFAV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 01:00:21 -0400
Received: (qmail 15301 invoked by uid 109); 1 Sep 2021 04:59:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Sep 2021 04:59:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3363 invoked by uid 111); 1 Sep 2021 04:59:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Sep 2021 00:59:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Sep 2021 00:59:23 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] pack-write,repack: prevent opening packs too early
Message-ID: <YS8IqxNbxy0YrXSe@coredump.intra.peff.net>
References: <cover.1630461918.git.me@ttaylorr.com>
 <YS75P7r33NIBmFh2@coredump.intra.peff.net>
 <YS8BwgfurPzhT4xh@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YS8BwgfurPzhT4xh@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 01, 2021 at 12:29:54AM -0400, Taylor Blau wrote:

> > We _might_ also want to re-order the calls to write_idx_file() and
> > write_rev_file() in its caller, given that simultaneous readers are
> > happy to read our tmp_pack_* files. I guess the same might apply to the
> > actual file write order pack-objects, too? I'm not sure if that's even
> > possible, though; do we rely on side effects of generating the .idx when
> > generating the other meta files?
> 
> These are a little trickier. write_idx_file() is also responsible for
> rearranging the objects array into index (name) order on the way out,
> which write_rev_file() depends on in order to build up its mapping.
> 
> So you could sort the array at the call-site before calling either
> function, but it gets awkward since there are a handful of other callers
> of write_idx_file() besides the two we're discussing.

Yeah, I had in the back of my mind that there was some dependency there.
I definitely prefer the "readers should not pick up tmp-packs" approach
if that is workable.

> > I think it might be more sensible if the reading side was taught to
> > ignore ".tmp-*" and "tmp_*" (and possibly even ".*", though it's
> > possible somebody is relying on that).
> 
> ...this seems like the much-better way to go. Git shouldn't have to
> worry about what order it writes the temporary files in, only what order
> those temporary files are made non-temporary.
> 
> But I need to do some more investigation to make sure there aren't any
> other implications. So I'm happy to wait on that, or send a new version
> of this series with a patch to fix the race in
> builtin/index-pack.c:final(), too.

I think if we kept it restricted to ".tmp-*" and "tmp_*", it should be
pretty safe. The absolute worst case is that somebody trying to recover
a corrupted repository might have to rename the files manually, I would
think.

Blocking ".*" is a harder sell. If we were starting from scratch, I'd
probably do that, but now we don't know what weird things people might
be doing. So unless there's a huge gain, it's hard to justify. (If we
were starting from scratch, I'd actually probably insist they be named
pack-$checksum.pack, etc, but it's much too late for that now).

So anyway. I think we definitely want the index-pack.c change. We
_could_ stop there and change the read side as a separate series, but I
think that until we do, the ordering changes on the write side aren't
really doing that much. They're shrinking the race a little, I guess,
but it's still very much there.

> (Unrelated to your suggestions above) another consideration for "stuff
> to do later" would be to flip the default of pack.writeReverseIndex. I
> had intentions to do that in the 2.32 cycle, but I forgot about it.

Oh, yeah. We should definitely do that (in its own series). The .rev
files have been a huge performance win, and I don't think there's any
reason we wouldn't want to always use them.

-Peff
