Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EE6A20401
	for <e@80x24.org>; Wed, 21 Jun 2017 13:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbdFUNov (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 09:44:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:47368 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750992AbdFUNou (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 09:44:50 -0400
Received: (qmail 20336 invoked by uid 109); 21 Jun 2017 13:44:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Jun 2017 13:44:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22531 invoked by uid 111); 21 Jun 2017 13:44:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jun 2017 09:44:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jun 2017 09:44:49 -0400
Date:   Wed, 21 Jun 2017 09:44:49 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Increase core.packedGitLimit
Message-ID: <20170621134449.5znbg6an6gjwmbek@sigill.intra.peff.net>
References: <20170420204118.17856-1-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170420204118.17856-1-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 04:41:18PM -0400, David Turner wrote:

> When core.packedGitLimit is exceeded, git will close packs.  If there
> is a repack operation going on in parallel with a fetch, the fetch
> might open a pack, and then be forced to close it due to
> packedGitLimit being hit.  The repack could then delete the pack
> out from under the fetch, causing the fetch to fail.
> 
> Increase core.packedGitLimit's default value to prevent
> this.
> 
> On current 64-bit x86_64 machines, 48 bits of address space are
> available.  It appears that 64-bit ARM machines have no standard
> amount of address space (that is, it varies by manufacturer), and IA64
> and POWER machines have the full 64 bits.  So 48 bits is the only
> limit that we can reasonably care about.  We reserve a few bits of the
> 48-bit address space for the kernel's use (this is not strictly
> necessary, but it's better to be safe), and use up to the remaining
> 45.  No git repository will be anywhere near this large any time soon,
> so this should prevent the failure.

I happened to run into another case of this which failed fairly
reliably, and confirmed that bumping packedGitLimit fixed it. Having
forgotten completely that we did this bump here, I wrote a similar
patch. :-/

The content of the patch is basically the same, but for the sake of the
list archive, here's the bit from my commit message about the
reproduction recipe (in case we should ever need to revisit it again,
though I'm pretty sure that your patch should fix the problem for good).

-- >8 --

You can see this situation in practice with strace:

  # two objects, one big and one small; for the sake of
  # speed, we'll make our big object only 1.1MB and drop
  # core.packedGitLimit to 1MB. Note that we care about
  # on-disk compressed sizes here, so we need uncompressible
  # data.
  small=$(echo small | git hash-object -w --stdin)
  big=$(dd if=/dev/urandom bs=1k count=1100 | git hash-object -w --stdin)

  # Now put each in a pack, which will get mmap'd
  # separately.
  echo $small | git pack-objects objects/pack/pack
  echo $big | git pack-objects objects/pack/pack

  # Now we look in the packs alternately, and observe the
  # access patterns.
  {
          echo $small
          echo $big
          echo $small
  } | strace -e open,close,mmap,munmap \
      git -c core.packedgitlimit=1M \
          -c core.packedGitWindowSize=512K \
          cat-file --batch >/dev/null

The trace will look something like this (I've omitted the
uninteresting .idx bits):

  open("./objects/pack/pack-b2a8452664fe8848fd0a78be8b6f69ce65af3c57.pack", O_RDONLY|O_CLOEXEC) = 3
  mmap(NULL, 47, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fb5890af000
  close(3)                                = 0

There we opened the small pack, mapped the whole thing, and
closed it.

  open("./objects/pack/pack-acfa5f8886b391d0b2475ef3f19bcc387ce19271.pack", O_RDONLY|O_CLOEXEC) = 3
  mmap(NULL, 524288, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fb589011000
  mmap(NULL, 1130496, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7fb588efd000
  munmap(0x7fb5890af000, 47)              = 0
  mmap(NULL, 524288, PROT_READ, MAP_PRIVATE, 3, 0x80000) = 0x7fb5881c0000
  munmap(0x7fb589011000, 524288)          = 0
  mmap(NULL, 78211, PROT_READ, MAP_PRIVATE, 3, 0x100000) = 0x7fb58909a000
  munmap(0x7fb588efd000, 1130496)         = 0

And here we open the larger pack. Note that we don't close
the descriptor because the file is bigger than our 512k
window.  And in fact we end up creating several maps as we
progress through the file. But before making the second one,
which would push us over our packedGitLimit, we close the
original small 47-byte map.

  open("./objects/pack/pack-b2a8452664fe8848fd0a78be8b6f69ce65af3c57.pack", O_RDONLY|O_CLOEXEC) = 4
  mmap(NULL, 47, PROT_READ, MAP_PRIVATE, 4, 0) = 0x7fb5890af000
  close(4)                                = 0

And here we access the small pack again, but we have to
re-open and map it from scratch.  If there had been a
simultaneous repack and if this had been pack-objects, we
would now fail the operation.

These numbers are shrunk to make the test more tractable,
but you can see the same thing with the defaults when
fetching from a large repository.  The real-world situation
that would trigger this is something like:

  0. Repo has 8GB or larger packfile (this is the default
     core.packedGitLimit on 64-bit machines).

  1. Somebody pushes a "small" pack (smaller than the 1GB
     default window).

  2. Somebody tries to clone/fetch the result. The
     pack-objects process on the server starts by generating
     the list of objects to write, committing to the
     use of those packs. After accessing the recent objects
     in the small pack, it opens the big pack and closes the
     small one.

  3. Meanwhile, git-repack runs and folds the small pack
     into a larger one.

  4. The pack-objects process hits the write phase, but it
     can no longer access the recent objects from the small
     pack, and dies.
