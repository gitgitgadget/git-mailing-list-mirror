Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCFBC4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 21:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415F860C51
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 21:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhHIVII (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 17:08:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:42786 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbhHIVIH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 17:08:07 -0400
Received: (qmail 3297 invoked by uid 109); 9 Aug 2021 21:07:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Aug 2021 21:07:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2520 invoked by uid 111); 9 Aug 2021 21:07:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Aug 2021 17:07:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Aug 2021 17:07:46 -0400
From:   Jeff King <peff@peff.net>
To:     anatoly techtonik <techtonik@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Working with git binary stream
Message-ID: <YRGZIjD7MioTc+Gh@coredump.intra.peff.net>
References: <CAPkN8xJqqnJfdUM5fEEMA00JoKsFcqnQo--_qbCLAx1qXSrgdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPkN8xJqqnJfdUM5fEEMA00JoKsFcqnQo--_qbCLAx1qXSrgdQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 09, 2021 at 07:12:13PM +0300, anatoly techtonik wrote:

> As an alternative it appeared that that theres is also a
> "git binary stream" log that is produced by
> 
> git cat-file --batch --batch-all-objects
> 
> Is there a way to reconstruct the repository given that stream?

Yes, though it is probably not the easiest way to do so. Just dumping
all of the object contents back into another repository will indeed give
you the same hashes, etc. But if you change one object, then all its
hash will change, and all of the other objects pointing to it will need
to change, etc. And that dump is in apparently-random order with respect
to the actual graph structure and relationship between objects.

You'd probably do better to build a tool around rev-list, and only use
cat-file to fetch the verbatim object contents. At some point your tool
would start to look a lot like fast-export/fast-import, and it may be
less work to teach them whatever features you need to avoid any
normalization (e.g., retaining signatures, encodings, etc).

> Is there documentation on how to read it?

The output format is described in the "BATCH FORMAT" section of "git
help cat-file". Basically you get each object id, type, and size in
bytes, followed by the object contents. You can use the size from the
header to know how many bytes to read.

There's no tool to accept the whole stream. You'd have to parse each
entry and feed it to "git hash-object" with the appropriate type.

Having a mode to hash-object to read in a bunch of objects in "cat-file
--batch" format wouldn't be unreasonable, but nobody has found a need
for it so far. It would also be quite slow (it writes out individual
loose objects, whereas something like fast-import writes out a packfile,
including at least a basic attempt at deltas).

-Peff
