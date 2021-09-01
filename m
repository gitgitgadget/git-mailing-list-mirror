Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B936C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 03:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 116A960295
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 03:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241838AbhIADyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 23:54:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:36020 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232298AbhIADyc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 23:54:32 -0400
Received: (qmail 15199 invoked by uid 109); 1 Sep 2021 03:53:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Sep 2021 03:53:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2957 invoked by uid 111); 1 Sep 2021 03:53:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Aug 2021 23:53:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 31 Aug 2021 23:53:35 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] pack-write,repack: prevent opening packs too early
Message-ID: <YS75P7r33NIBmFh2@coredump.intra.peff.net>
References: <cover.1630461918.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630461918.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 10:05:46PM -0400, Taylor Blau wrote:

> This pair of patches fixes a race where the .idx is moved into place
> before the .rev file, allowing the pack to be in a state where it
> appears a .rev file wasn't generated.
> 
> This can cause Git to inadvertently take the slow "generate the
> reverse index on-the-fly", which does not impact correctness, but is
> unnecessarily slow when compared to reading the .rev file.
> 
> The race is fixed by moving the .idx into place only after all other
> pack-related files have already been written. The first patch fixes
> the direct `pack-objects` case, and the second patch fixes `repack`
> (which also renames pack files around).

These both look good to me, but I think we're missing one more spot.

The first patch covers git-pack-objects directly, like:

  git pack-objects .git/objects/pack/pack

In practice, though, we never do that. On-disk repacks happen via
git-repack, which always writes to temporary files. So I thought the
case in git-pack-objects wouldn't matter, but it does look like
prepare_packed_git() will actually read .tmp-$$-pack-1234abcd files, and
so might load our temporary pack. Unexpected, but we are covered by your
first patch. And then the second patch covers us as we move those
temporary files into place.

So far so good. But the other obvious way to get a pack idx is via
index-pack (especially "--stdin").

It looks like we'd want the same re-ordering to happen in
builtin/index-pack.c:final(), which is where we rename the temporary
files into place.

We _might_ also want to re-order the calls to write_idx_file() and
write_rev_file() in its caller, given that simultaneous readers are
happy to read our tmp_pack_* files. I guess the same might apply to the
actual file write order pack-objects, too? I'm not sure if that's even
possible, though; do we rely on side effects of generating the .idx when
generating the other meta files?

I think it might be more sensible if the reading side was taught to
ignore ".tmp-*" and "tmp_*" (and possibly even ".*", though it's
possible somebody is relying on that).

-Peff
