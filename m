Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB520C4742C
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 04:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A34D4222B9
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 04:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgKPEKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Nov 2020 23:10:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:58686 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgKPEKw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Nov 2020 23:10:52 -0500
Received: (qmail 6295 invoked by uid 109); 16 Nov 2020 04:10:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Nov 2020 04:10:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6438 invoked by uid 111); 16 Nov 2020 04:10:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Nov 2020 23:10:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 15 Nov 2020 23:10:51 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] handling 4GB .idx files
Message-ID: <20201116041051.GA883199@coredump.intra.peff.net>
References: <20201113050631.GA744608@coredump.intra.peff.net>
 <323fd904-a7ee-061d-d846-5da5afbc88b2@virtuell-zuhause.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <323fd904-a7ee-061d-d846-5da5afbc88b2@virtuell-zuhause.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 15, 2020 at 03:43:39PM +0100, Thomas Braun wrote:

> On 13.11.2020 06:06, Jeff King wrote:
> > I recently ran into a case where Git could not read the pack it had
> > produced via running "git repack". The culprit turned out to be an .idx
> > file which crossed the 4GB barrier (in bytes, not number of objects).
> > This series fixes the problems I saw, along with similar ones I couldn't
> > trigger in practice, and protects the .idx loading code against integer
> > overflows that would fool the size checks.
> 
> Would it be feasible to have a test case for this large index case? This
> should very certainly have an EXPENSIVE tag, or might even not yet work
> on windows. But hopefully someday I'll find some more time to push large
> object support on windows forward, and these kind of tests would really
> help then.

I think it would be a level beyond what we usually consider even for
EXPENSIVE. The cheapest I could come up with to generate the case is:

  perl -e '
	for (0..154_000_000) {
		print "blob\n";
		print "data <<EOF\n";
		print "$_\n";
		print "EOF\n";
	}
  ' |
  git fast-import

which took almost 13 minutes of CPU to run, and peaked around 15GB of
RAM (and takes about 6.7GB on disk).

In the resulting repo, the old code barfed on lookups:

  $ blob=$(echo 0 | git hash-object --stdin)
  $ git cat-file blob $blob
  error: wrong index v2 file size in .git/objects/pack/pack-f8f43ae56c25c1c8ff49ad6320df6efb393f551e.idx
  error: wrong index v2 file size in .git/objects/pack/pack-f8f43ae56c25c1c8ff49ad6320df6efb393f551e.idx
  error: wrong index v2 file size in .git/objects/pack/pack-f8f43ae56c25c1c8ff49ad6320df6efb393f551e.idx
  error: wrong index v2 file size in .git/objects/pack/pack-f8f43ae56c25c1c8ff49ad6320df6efb393f551e.idx
  error: wrong index v2 file size in .git/objects/pack/pack-f8f43ae56c25c1c8ff49ad6320df6efb393f551e.idx
  error: wrong index v2 file size in .git/objects/pack/pack-f8f43ae56c25c1c8ff49ad6320df6efb393f551e.idx
  fatal: git cat-file 573541ac9702dd3969c9bc859d2b91ec1f7e6e56: bad file

whereas now it works:

  $ git cat-file blob $blob
  0

That's the most basic test I think you could do. More interesting is
looking at entries that are actually after the 4GB mark. That requires
dumping the whole index:

  final=$(git show-index <.git/objects/pack/*.idx | tail -1 | awk '{print $2}')
  git cat-file blob $final

That takes ~35s to run. Curiously, it also allocates 5GB of heap. For
some reason it decides to make an internal copy of the entries table. I
guess because it reads the file sequentially rather than mmap-ing it,
and 64-bit offsets in v2 idx files can't be resolved until we've read
the whole entry table (and it wants to output the entries in sha1
order).

The checksum bug requires running git-fsck on the repo. That's another 5
minutes of CPU (and even higher peak memory; I think we create a "struct
blob" for each one, and it seems to hit 20GB).

Hitting the other cases that I fixed but never triggered in practice
would need a repo about 4x as large. So figure an hour of CPU and 60GB
of RAM.

So I dunno. I wouldn't be opposed to codifying some of that in a script,
but I can't imagine anybody ever running it unless they were working on
this specific problem.

-Peff
