Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9F171F462
	for <e@80x24.org>; Mon, 29 Jul 2019 09:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfG2Jma (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 05:42:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:53876 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725818AbfG2Jma (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 05:42:30 -0400
Received: (qmail 21379 invoked by uid 109); 29 Jul 2019 09:42:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Jul 2019 09:42:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26801 invoked by uid 111); 29 Jul 2019 09:44:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Jul 2019 05:44:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Jul 2019 05:42:29 -0400
From:   Jeff King <peff@peff.net>
To:     ardi <ardillasdelmonte@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Settings for minimizing repacking (and keeping 'rsync' happy)
Message-ID: <20190729094229.GA2415@sigill.intra.peff.net>
References: <CA+fZqCXBjA5jsYg7L7X1VhJZXrp9NP+dR1SQWK9fAf9b1jgpCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+fZqCXBjA5jsYg7L7X1VhJZXrp9NP+dR1SQWK9fAf9b1jgpCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 28, 2019 at 01:41:34AM +0200, ardi wrote:

> Some of my Git repositories have mirrors, maintained with 'rsync'. I
> want to have some level of repacking, so that the repositories are
> efficient, but I also want it to minimize it, so that 'rsync' never
> has to perform a big transfer for the repositories.

Yes, this is a common problem. The solutions I've seen/used are:

  - use a git-aware transport like git-fetch that can negotiate which
    objects to send

  - use a tool that can find duplicated chunks across files. Many
    de-duping backup systems (e.g., borg) use a rolling hash similar to
    rsync to find moveable chunks, but then look up those chunks in a
    master index (whereas rsync is always looking to match chunks in a
    file of the same name). This works well in practice because Git is
    not usually rewriting most of the data, but just shuffling it around
    between files.

    In theory it shouldn't be that hard to tell the receiving rsync to
    look for source chunks not just in the file of the same name, but
    from a set of existing packfiles (say, everything already in
    .git/objects/pack/ on the receiver). But I don't know offhand of an
    option to rsync to do so.

> For example, I think it would be fine if files are repacked just once
> in their lifetimes, and then that resulting pack file is never
> repacked again. I did read the gc.bigPackThreshold and
> gc.autoPackLimit settings, but I don't think they would accomplish
> that.
> 
> Basically, what I'm describing is the behaviour of not packing files
> until the resulting pack would be a given size (say 10MB for example),
> and then never repack such ~10MB packs again, ever.
> 
> Can this be done with some Git settings? And do you foresee any kind
> of serious drawback or potential problem with this kind of behaviour?

You can mark a pack to be kept forever by creating a matching
"pack-1234abcd.keep" file. That doesn't do your automatic "I want 10MB
packs" thing, but if you did it occasionally at the right frequency,
you'd end up with a bunch of 10MB-ish packs.

But there are downsides to having a bunch of packs:

  - object lookups are O(log n) within a single pack, but O(n) over the
    number of packs. So if you get a very large number of packs, normal
    operations will start to suffer. This is mitigated by the new "midx"
    feature, which generates an index for multiple packs.

  - git doesn't allow delta compression across packs. So imagine you
    have ten versions of a file that's 5kb, and each version changes
    about 100 bytes. In a single pack, we'd store one base object, plus
    9 deltas, for a total of about 6kb (5000 + 9*100). Across two packs,
    we'd store ~11kb (2*5000 + 8*100). And the worst case is ten packs
    at 50kb.

    As a more real-world example, try this:

      git -c pack.packsizelimit=10M repack -ad

    In a fresh clone of git.git, the size of the pack directory jumps
    from 88MB to 168MB. And in a time-based split (i.e., creating a new
    10MB pack every week), it may be even worse. The command above
    ordered the objects optimally to keep deltas together and _then_
    split things. Whereas a time-based scheme would likely sprinkle
    versions of a file across more packs.

    It should be possible to loosen this restriction and allow
    cross-pack deltas, but it would be very risky. The assumption that
    packs are independent of each other is implicit in much of Git's
    repacking code, so it would be easy to introduce a bug where we
    generate a circular dependency (object A in pack X is a delta
    against object B in pack Y, which is a delta against object A --
    oops, we don't have a full copy anymore).

-Peff
