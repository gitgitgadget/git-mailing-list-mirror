Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16730C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 13:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE95F2083B
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 13:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgIQNUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 09:20:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:59860 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbgIQNQP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 09:16:15 -0400
Received: (qmail 484 invoked by uid 109); 17 Sep 2020 13:16:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Sep 2020 13:16:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8382 invoked by uid 111); 17 Sep 2020 13:16:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Sep 2020 09:16:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Sep 2020 09:16:05 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, tytso@mit.edu,
        Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] sha1-file: fsync() loose dir entry when
 core.fsyncObjectFiles
Message-ID: <20200917131605.GC3024501@coredump.intra.peff.net>
References: <87sgbghdbp.fsf@evledraar.gmail.com>
 <20200917112830.26606-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200917112830.26606-2-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 01:28:29PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Change the behavior of core.fsyncObjectFiles to also sync the
> directory entry. I don't have a case where this broke, just going by
> paranoia and the fsync(2) manual page's guarantees about its behavior.

I've also often wondered whether this is necessary. Given the symptom of
"oops, this object is there but with 0 bytes" after a hard crash (power
off, etc), my assumption is that the metadata is being journaled but the
actual data is not. Which would imply this isn't needed, but may just be
revealing my naive view of how filesystems work.

And of course all of my experience is on ext4 (which doubly confuses me,
because my systems typically have data=ordered, which I thought would
solve this). Non-journalling filesystems or other modes likely behave
differently, but if this extra fsync carries a cost, we may want to make
it optional.

>  sha1-file.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

We already fsync pack files, but we don't fsync their directories. If
this is important to do, we should be doing it there, too.

We also don't fsync ref files (nor packed-refs) at all. If fsyncing
files is important for reliability, we should be including those, too.
It may be tempting to say that the important stuff is in objects and the
refs can be salvaged from the commit graph, but my experience says
otherwise. Missing, broken, or mysteriously-rewound refs cause confusing
user-visible behavior, and when compounded with pruning operations like
"git gc" they _do_ result in losing objects.

-Peff
