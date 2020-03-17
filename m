Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6247C1975A
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 18:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854DD20714
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 18:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCQSlZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:41:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:42040 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726294AbgCQSlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 14:41:25 -0400
Received: (qmail 4127 invoked by uid 109); 17 Mar 2020 18:41:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Mar 2020 18:41:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8980 invoked by uid 111); 17 Mar 2020 18:51:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Mar 2020 14:51:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 17 Mar 2020 14:41:24 -0400
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Andreas Krey <a.krey@gmx.de>,
        Git Users <git@vger.kernel.org>
Subject: Re: Avoid race condition between fetch and repack/gc?
Message-ID: <20200317184124.GA17006@coredump.intra.peff.net>
References: <20200316082348.GA26581@inner.h.apk.li>
 <759f4b3b-28a7-c002-ae51-5991bf9ad211@gmail.com>
 <20200316172729.GA1072073@coredump.intra.peff.net>
 <CAGyf7-HQH7hjuYSmOYeOEvZBWkUzjU4M8Wr50FNPYgG4NZ=5UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-HQH7hjuYSmOYeOEvZBWkUzjU4M8Wr50FNPYgG4NZ=5UA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 16, 2020 at 04:40:13PM -0700, Bryan Turner wrote:

> On Mon, Mar 16, 2020 at 10:27 AM Jeff King <peff@peff.net> wrote:
> >
> >   - you don't use config like core.packedGitLimit that encourages Git to
> >     drop mmap'd windows. On 64-bit systems, this doesn't help at all (we
> >     have plenty of address space, and since the maps are read-only, the
> >     OS is free to drop the clean pages if there's memory pressure). On
> >     32-bit systems, it's a necessity (and I'd expect a 32-bit server to
> >     run into this issue a lot for large repositories).
> 
> I could be wrong, but I'm going to _guess_ from the :7999 in the
> example output that the repository is hosted with Bitbucket Server.
> Assuming my guess is correct, Bitbucket Server _does_ set
> "core.packedgitlimit=256m" (and "core.packedgitwindowsize=32m", for
> what it's worth).

Thanks for letting me know. That would definitely explain the behavior
Andreas is seeing.

> Those settings are applied specifically because
> we've found they _do_ impact Git's overall memory usage when serving
> clones in particular, which is important for cases where the system is
> serving dozens (or hundreds) of concurrent clones.

I do think there's an open question here, but it's also really easy to
be misled by common metrics. If we imagine a repo with a 512MB packfile
and two scenarios:

  - Git mmap's the whole packfile at once, and accesses pages within
    that mmap

  - Git mmap's no more than 256MB at once, shifting its window around as
    necessary

and then we get a bunch of clones. Then I'd expect to see:

  - virtual memory size for those Git processes will be higher. But much
    of that will be shared pages with each other. Measuring something
    like Proportional Set Size (PSS) yields a more useful number.

  - the Resident Set Size (RSS) of those processes will also be higher,
    because the OS may be leaving pages in the mmap resident. However,
    in my experience this is often a sign that there _isn't_ memory
    pressure on the system. Because if there was, then infrequently used
    pages would be dropped by the OS (and they should be among the first
    to go, as they're by definition clean pages. Though they do
    presumably compete with other read-only disk cache).

Or another way to think about it: the mmap patterns don't change the
working set patterns of Git. They just change what the OS knows, and
possibly how it reacts. And that's the "open question" for me: does the
operating system react significantly differently under memory pressure
for a big mmap with infrequently accessed pages than it would for a
series of smaller maps. I don't know the answer. Our servers are all
Linux, and we've tended to just trust that the operating system's
page-level decisions are sensible.

But I don't have any real numbers to support that. We stopped using
core.packedGitLimit in 2012 (because of this issue), and everything has
been good enough since to not bother looking into it more. Memory
pressure for us is usually from actual heap usage (e.g., pack-objects
has a high per-object cost plus delta window size times max object
size).

> Of course, we don't always do a great job of re-testing
> once-beneficial settings later, which means sometimes they end up
> being based on outdated observations. Perhaps we should prioritize
> some additional testing here, especially on 64-bit systems. (We've
> been setting "core.packedgitlimit" since back when Bitbucket Server
> was called Stash and supported Git 1.7.6 on the server.)

It sounds like you don't have any recent numbers, either. :)

> That said, though, you note "core.packedgitlimit" is necessary on
> 32-bit servers and, unfortunately, we do still support Bitbucket
> Server on 32-bit OSes. Maybe we should investigate applying (or not)
> the flags depending on the platform. Sadly, that's not necessarily
> simple to do since just because the _OS_ is 64-bit doesn't mean _Git_
> is; it's pretty trivial to run 32-bit Git on 64-bit Windows, for
> example.

The default for core.packedGitLimit is already 256MB on 32-bit builds of
Git (based on sizeof(void *), so truly on the build and not the OS). So
if you just left it unset, it would do what you want.

-Peff
