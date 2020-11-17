Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B146C63777
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 00:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1835F2465A
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 00:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbgKQACx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 19:02:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:59820 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730311AbgKQACx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 19:02:53 -0500
Received: (qmail 12478 invoked by uid 109); 17 Nov 2020 00:02:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Nov 2020 00:02:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20421 invoked by uid 111); 17 Nov 2020 00:02:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Nov 2020 19:02:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Nov 2020 19:02:52 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] builtin/repack.c: don't move existing packs out of
 the way
Message-ID: <20201117000252.GB12322@coredump.intra.peff.net>
References: <cover.1605552016.git.me@ttaylorr.com>
 <d4e73aad14189a00621da9e000d2c6a5fe776d84.1605552016.git.me@ttaylorr.com>
 <xmqqpn4c7uf2.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpn4c7uf2.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 16, 2020 at 03:29:05PM -0800, Junio C Hamano wrote:

> > t7700.14 ensures
> > that 'git repack' will, for example, remove existing bitmaps even if the
> > pack written is verbatim the same (when repacking without '-b' in a
> > repository unchanged from the time 'git repack -b' was run). So, we have
> > to handle metadata that we didn't write, by unlinking any existing
> > metadata that our invocation of pack-objects didn't generate itself.
> 
> Hmph, t7700.14 wants it that way because?
> 
> If we were told to generate a packfile, and we ended up regenerating
> the exactly the same one, it appears to me that we can just pretend
> nothing happened and leave things as they were?  Puzzled...

We definitely could, and the outcome would be correct in the sense that
the bitmap would still work. I'm not sure that the test in t7700 cares
particularly about this "making the same pack" case. It only wants to
know that if we disable bitmaps and repack, we end up without a bitmap.
And normally, if you added in even a single extra object, you'd get a
new pack and that would happen.

But of course the test just repacks back-to-back, so it does trigger
the "making the same pack" case.

I think you could make an argument either way:

  - we have an existing bitmap for free, and bitmaps make things faster,
    so why not keep it?

  - the user did not ask for bitmaps, so we should make the outcome
    consistent whether a pack of the exact name existed before or not

The second one seems less surprising to me. But I think if we did the
first, the code would be shorter (it would not need any of this "keep
track of what pack-objects generated" stuff at all, but would just copy
whatever files we see into place).

> >  				if (rename(fname_old, fname))
> >  					die_errno(_("renaming '%s' failed"), fname_old);
> 
> OK, so this is where the previous step matters.  We do the same as
> before (i.e. stat+chmod and rename) only for paths we have created.
> 
> We don't reuse the old one because we have already written a new
> file so we won't save anything by doing so, and checking if the
> target of rename exists already before deciding not to rename cannot
> be made atomic, so just relying on rename() to do the right thing is
> a good idea anyway.

Even though the pack is byte-for-byte identical, the new .idx, etc,
might not be. And those could be affected by options. E.g.:

  git -c pack.writeBitmapHashCache=false repack -adb
  git -c pack.writeBitmapHashCache=true  repack -adb

should probably end up with a bitmap file that contains a hash cache.

-Peff
