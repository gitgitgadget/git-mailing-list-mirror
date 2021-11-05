Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66503C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 07:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BFDE61262
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 07:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhKEHUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 03:20:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:53696 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232129AbhKEHUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 03:20:09 -0400
Received: (qmail 10756 invoked by uid 109); 5 Nov 2021 07:17:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Nov 2021 07:17:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15211 invoked by uid 111); 5 Nov 2021 07:17:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Nov 2021 03:17:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Nov 2021 03:17:28 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] refs: sync loose refs to disk before committing them
Message-ID: <YYTaiIlEKxHRVdCy@coredump.intra.peff.net>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <YYTYJpyrxtyR8yYZ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YYTYJpyrxtyR8yYZ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 05, 2021 at 03:07:18AM -0400, Jeff King wrote:

>   2. It's not clear what the performance implications will be,
>      especially on a busy server doing a lot of ref updates, or on a
>      filesystem where fsync() ends up syncing everything, not just the
>      one file (my impression is ext3 is such a system, but not ext4).
>      Whereas another solution may be journaling data and metadata writes
>      in order without worrying about the durability of writing them to
>      disk.
> 
>      I suspect for small updates (say, a push of one or two refs), this
>      will have little impact. We'd generally fsync the incoming packfile
>      and its idx anyway, so we're adding may one or two fsyncs on top of
>      that. But if you're pushing 100 refs, that will be 100 sequential
>      fsyncs, which may add up to quite a bit of latency. It would be
>      nice if we could batch these by somehow (e.g., by opening up all of
>      the lockfiles, writing and fsyncing them, and then renaming one by
>      one).

So here's a quick experiment that shows a worst case: a small push that
updates a bunch of refs. After building Git with and without your patch,
I set up a small repo like:

  git init
  git commit --allow-empty -m foo
  for i in $(seq 100); do
    git update-ref refs/heads/$i HEAD
  done

To give a clean slate between runs, I stuck this in a script called
"setup":

  #!/bin/sh
  rm -rf dst.git
  git init --bare dst.git
  sync

And then ran:

  $ hyperfine -L v orig,fsync -p ./setup '/tmp/{v}/bin/git push dst.git refs/heads/*'
  Benchmark 1: /tmp/orig/bin/git push dst.git refs/heads/*
    Time (mean ± σ):       9.9 ms ±   0.2 ms    [User: 6.3 ms, System: 4.7 ms]
    Range (min … max):     9.5 ms …  10.5 ms    111 runs
   
  Benchmark 2: /tmp/fsync/bin/git push dst.git refs/heads/*
    Time (mean ± σ):     401.0 ms ±   7.7 ms    [User: 9.4 ms, System: 15.2 ms]
    Range (min … max):   389.4 ms … 412.4 ms    10 runs
   
  Summary
    '/tmp/orig/bin/git push dst.git refs/heads/*' ran
     40.68 ± 1.16 times faster than '/tmp/fsync/bin/git push dst.git refs/heads/*'

So it really does produce a noticeable impact (this is on a system with
a decent SSD and no other disk load, so I'd expect it to be about
average for modern hardware).

Now this test isn't entirely fair. 100 refs is a larger than average
number to be pushing, and the effect is out-sized because there's
virtually no time spent dealing with the objects themselves, nor is
there any network latency. But 400ms feels like a non-trivial amount of
time just in absolute numbers.

The numbers scale pretty linearly, as you'd expect. Pushing 10 refs
takes ~40ms, 100 takes ~400ms, and 1000 takes ~4s. The non-fsyncing
version gets slower, too (there's more work to do), but much more slowly
(6ms, 10ms, and 50ms respectively).

So this will definitely hurt at edge / pathological cases.

-Peff
