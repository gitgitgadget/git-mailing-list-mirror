Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B357BC433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 09:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE7C61265
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 09:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhKEJhZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 05:37:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:53756 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230175AbhKEJhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 05:37:25 -0400
Received: (qmail 11293 invoked by uid 109); 5 Nov 2021 09:34:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Nov 2021 09:34:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16310 invoked by uid 111); 5 Nov 2021 09:34:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Nov 2021 05:34:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Nov 2021 05:34:44 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Neeraj Singh <neerajsi@microsoft.com>,
        Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] refs: sync loose refs to disk before committing them
Message-ID: <YYT6tDyfBbwot2br@coredump.intra.peff.net>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <YYTYJpyrxtyR8yYZ@coredump.intra.peff.net>
 <YYTaiIlEKxHRVdCy@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2111051010070.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2111051010070.56@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 05, 2021 at 10:12:25AM +0100, Johannes Schindelin wrote:

> > So this will definitely hurt at edge / pathological cases.
> 
> Ouch.
> 
> I wonder whether this could be handled similarly to the
> `core.fsyncObjectFiles=batch` mode that has been proposed in
> https://lore.kernel.org/git/pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com/

Yeah, that was along the lines I was thinking.

I hadn't really looked at the details of the batch-fsync there. The big
trick seems to be doing a pagecache writeback for each file, and then
stimulating an actual disk write (by fsyncing a tempfile) after the
batch is done.

That would be pretty easy to do for the refs (it's git_fsync() while
closing each file where Patrick is calling fsync(), followed by a single
do_batch_fsync() after everything is closed but before we rename).

> Essentially, we would have to find a better layer to do this, where we
> can synchronize after a potentially quite large number of ref updates has
> happened. That would definitely be a different layer than the file-based
> refs backend, of course, and would probably apply in a different way to
> other refs backends.

We do have the concept of a ref_transaction, so that would be the
natural place for it. Not every caller uses it, though, because it
implies atomicity of the transaction (so some may do a sequence of N
independent transactions, because they don't want failure of one to
impact others). I think that could be changed, if the ref_transaction
learned about non-atomicity, but it may take some surgery.

I expect that reftables would similarly benefit; it is probably much
more efficient to write a table slice with N entries than it is to write
N slices, even before accounting for fsync(). And once doing that, then
the fsync() part becomes trivial.

-Peff
