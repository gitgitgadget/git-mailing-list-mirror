Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573B8C76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 20:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjDJUOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 16:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjDJUOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 16:14:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD404C0
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 13:14:15 -0700 (PDT)
Received: (qmail 2954 invoked by uid 109); 10 Apr 2023 20:14:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 10 Apr 2023 20:14:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 607 invoked by uid 111); 10 Apr 2023 20:14:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Apr 2023 16:14:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Apr 2023 16:14:14 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, johncai86@gmail.com
Subject: Re: [Question] Can git cat-file have a type filtering option?
Message-ID: <20230410201414.GC104097@coredump.intra.peff.net>
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
 <xmqqy1n3k63p.fsf@gitster.g>
 <CAOLTT8SXXKG3uEd8Q=uh3zx7XeUDUWezGgNUSCd1Fpq-Kyy-2A@mail.gmail.com>
 <ZDIUvK/bF7BFqX5q@nand.local>
 <CAOLTT8RbU6G67BtE9fSv4gEn10dtR7cT-jf+dcEfhvNhvcwETQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8RbU6G67BtE9fSv4gEn10dtR7cT-jf+dcEfhvNhvcwETQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 09, 2023 at 02:47:30PM +0800, ZheNing Hu wrote:

> > Perhaps slightly so, since there is naturally going to be some
> > duplicated effort spawning processes, loading any shared libraries,
> > initializing the repository and reading its configuration, etc.
> >
> > But I'd wager that these are all a negligible cost when compared to the
> > time we'll have to spend reading, inflating, and printing out all of the
> > objects in your repository.
> 
> "What you said makes sense. I implemented the --type-filter option for
> git cat-file and compared the performance of outputting all blobs in the
> git repository with and without using the type-filter. I found that the
> difference was not significant.
> 
> time git  cat-file --batch-all-objects --batch-check="%(objectname)
> %(objecttype)" |
> awk '{ if ($2 == "blob") print $1 }' | git cat-file --batch > /dev/null
> 17.10s user 0.27s system 102% cpu 16.987 total
> 
> time git cat-file --batch-all-objects --batch --type-filter=blob >/dev/null
> 16.74s user 0.19s system 95% cpu 17.655 total
> 
> At first, I thought the processes that provide all blob oids by using
> git rev-list or git cat-file --batch-all-objects --batch-check might waste
> cpu, io, memory resources because they need to read a large number
> of objects, and then they are read again by git cat-file --batch.
> However, it seems that this is not actually the bottleneck in performance.

Yeah, I think most of your time there is spent on the --batch command
itself, which is just putting through a lot of bytes. You might also try
with "--unordered". The default ordering for --batch-all-objects is in
sha1 order, which has pretty bad locality characteristics for delta
caching. Using --unordered goes in pack-order, which should be optimal.

E.g., in git.git, running:

  time \
    git cat-file --batch-all-objects --batch-check='%(objecttype) %(objectname)' |
    perl -lne 'print $1 if /^blob (.*)/' |
    git cat-file --batch >/dev/null

takes:

  real	0m29.961s
  user	0m29.128s
  sys	0m1.461s

Adding "--unordered" to the initial cat-file gives:

  real	0m1.970s
  user	0m2.170s
  sys	0m0.126s

So reducing the size of the actual --batch printing may make the
relative cost of using multiple processes much higher (I didn't apply
your --type-filter patches to test myself).

In general, I do think having a processing pipeline like this is OK, as
it's pretty flexible. But especially for smaller queries (even ones that
don't ask for the whole object contents), the per-object lookup costs
can start to dominate (especially in a repository that hasn't been
recently packed). Right now, even your "--batch --type-filter" example
is probably making at least two lookups per object, because we don't
have a way to open a "handle" to an object to check its type, and then
extract the contents conditionally. And of course with multiple
processes, we're naturally doing a separate lookup in each one.

So a nice thing about being able to do the filtering in one process is
that we could _eventually_ do it all with one object lookup. But I'd
probably wait on adding something like --type-filter until we have an
internal single-lookup API, and then we could time it to see how much
speedup we can get.

-Peff
