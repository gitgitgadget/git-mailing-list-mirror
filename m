Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37DDC11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C0661483
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhF3RUv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 13:20:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:37544 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhF3RUv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 13:20:51 -0400
Received: (qmail 24537 invoked by uid 109); 30 Jun 2021 17:18:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Jun 2021 17:18:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9009 invoked by uid 111); 30 Jun 2021 17:18:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Jun 2021 13:18:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Jun 2021 13:18:21 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] xmmap: inform Linux users of tuning knobs on ENOMEM
Message-ID: <YNynXZkDOXJDeR4P@coredump.intra.peff.net>
References: <20210629081108.28657-1-e@80x24.org>
 <20210630000132.GA2653@dcvr>
 <YNva8PWFJ24QX2yF@coredump.intra.peff.net>
 <20210630100722.GB2653@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210630100722.GB2653@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 10:07:22AM +0000, Eric Wong wrote:

> > In general I agree that trying to manage our map count can never be
> > foolproof. As you note, other parts of the system may contribute to that
> > count. But even within Git, we don't have any mechanism for unmapping
> > many non-packfiles. So if you have 30,000 packs, you may hit the limit
> > purely via the .idx files (and ditto for the new .rev files, and
> > probably commit-graph files, etc).
> 
> Yeah, the most annoying thing with my original series was when
> I hit "inflate: out of memory" once I stopped xmmap from dying.
> I suspect that would be a worse far error message for users who
> aren't familiar with how malloc works.

Yep. When I've seen this problem in the wild, that was exactly the
message I hit, too.

> > That said, I'm not opposed to handling xmmap() failures more gracefully,
> > as your series did. It's not foolproof, but it might help in some cases.
> 
> I've also been wondering if we can maintain a watermark based
> on reading the contents of /proc/sys/vm/max_map_count and the
> mappings we make.   Then we could start dropping mappings
> when we hit half (or some other threshold) of that sysctl.
> Similar for RLIMIT_DATA (though that defaults to unlimited
> on my Debian system).

Maybe. You'd still need to teach Git to start closing pack idx files.

One downside of closing any maps is that it leads to races with
simultaneous repacks. Usually if a pack goes away we'll re-scan the
objects directory and look for new packs. But in pack-objects, we commit
ourselves to a certain packed representation. If that pack goes away
(and we aren't holding on to it via an mmap or open descriptor), then we
have to bail.

If we hit a point where the alternative is calling die() because we
couldn't map or allocate something, then risking the race is OK. But
unmapping at a more conservative level opens us up to that race even
when we would have otherwise succeeded.

> OTOH, I also wonder if we're overusing mmap when we could be
> just as well served with pread.
> 
> I'm not up-to-date on modern mmap performance and maybe CPU
> vulnerability mitigations nowadays make mmap more compelling.
> However, once upon a time in 2006, pread could be a hair quicker:

You can compile with NO_MMAP now to emulate it with pread(), but I doubt
it performs that well. If you shrink the packedGitWindowSize, then I
think use_pack() would bring in and operate on reasonable amounts of
bytes at a time.

But lots of other code will mmap whole files (.idx code, packed-refs
lookup, the index). We'd end up copying those files entirely into
memory, rather than accessing them directly page-wise.  That increases
RAM usage (we are copying into our own heap) and makes operations
inherently O(n) in the file sizes (one of the big reasons we mmap the
packed-refs file is so that we can binary search without having to
process the whole thing).

Those cases could be converted to use pread() more directly. Doing so
for .idx files might not be too bad, as the records are fixed-length and
we know where each step of the binary search will land. For packed-refs
it would get pretty hairy; we jump to a particular offset and then have
to scan around (sometimes backwards) for the beginning of the record.

> > > So I think giving users some information to feed their sysadmins
> > > is the best we can do in this situation:
> > 
> > This seems OK to me, too. Translators might complain a bit about the
> > message-lego. I don't have a strong opinion.
> 
> *shrug*  I saw my original patches already ended up in `seen'
> (commit 7b79212a93c375365c06cab5c0018ab97a4185cf)

That doesn't necessarily mean much. Only that the topic was "seen" by
the maintainer and didn't look like complete garbage. :)

-Peff
