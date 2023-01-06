Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB80C3DA7A
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 08:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjAFI6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 03:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjAFI6I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 03:58:08 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021FA35911
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 00:57:56 -0800 (PST)
Received: (qmail 12847 invoked by uid 109); 6 Jan 2023 08:57:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Jan 2023 08:57:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12657 invoked by uid 111); 6 Jan 2023 08:58:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Jan 2023 03:58:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Jan 2023 03:57:55 -0500
From:   Jeff King <peff@peff.net>
To:     Andrew Hlynskyi <ahlincq@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] `git gc` or `git pack-refs` wipes all notes for `git
 notes` command
Message-ID: <Y7fikyZV1ky2modr@coredump.intra.peff.net>
References: <CAAYtLELp4v=id-UUdGT+BoCxLuTV05Z0fFMQmPfd3Mt-yXJ9Tw@mail.gmail.com>
 <Y7Pvqk00sj3R7cZv@coredump.intra.peff.net>
 <CAAYtLE+PWK_v0cc8uqaiKnTHKghrkxuCCgfWyo9bhD23+vxK1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAYtLE+PWK_v0cc8uqaiKnTHKghrkxuCCgfWyo9bhD23+vxK1g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 05, 2023 at 06:59:36PM +0200, Andrew Hlynskyi wrote:

> > Can you share the .git directory of a repository that exhibits this
> > behavior? It's possible there's a bug or something in the packed-refs
> > code, though I find it pretty unlikely, as it's fairly well exercised in
> > normal use.
> 
> The above excerpts completely describe the issue and there is no more
> special in the repo.

Thanks for digging. Your explanation makes sense.

> I was surprised that such an issue can remain in the
> `.git/packed-refs` for more than a year.
> I thought that commands like `git fsck` would report such unordering
> problems and `git gc` or `git pack-refs`
> make ordering checks and make full resorting of the `.git/packed-refs`
> file in case of issues with ordering.

I don't think we have any fsck checks that the packed-refs file is in
sorted order. It might be reasonable to have them. Likewise, when
pack-refs rewrites the file, it should be able to cheaply double-check
that the input is sorted by comparing each entry against its previous.

I'm not _too_ surprised that the repo could persist for a while with an
out-of-order packed-refs file, especially if you are not doing writes
that would trigger a gc. Lookups are done by binary-search (and thus
require sorting), but many operations will just iterate over the whole
list and don't care.  For an infrequently used ref, you might get
unlucky and fall on it during a binary search, but otherwise it wouldn't
affect most results.

> I understand that the `.git/packed-refs` file is for machines and not
> for humans but sometimes
> it's the fastest way to make several simple corrections in it manually.

Yes, I have certainly done this myself. There are is a header line at
the top of the file, though, which tells what is guaranteed:

  $ head -1 .git/packed-refs
  # pack-refs with: peeled fully-peeled sorted

if you are going to muck with the file, deleting that line should be
sufficient; the reading code will fall back to the older routines which
don't assume it's sorted.

-Peff
