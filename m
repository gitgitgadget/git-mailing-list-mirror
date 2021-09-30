Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF2BC433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 07:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F391561555
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 07:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348865AbhI3IAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 04:00:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:58150 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348701AbhI3IAi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 04:00:38 -0400
Received: (qmail 22349 invoked by uid 109); 30 Sep 2021 07:58:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Sep 2021 07:58:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24410 invoked by uid 111); 30 Sep 2021 07:58:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Sep 2021 03:58:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Sep 2021 03:58:55 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 2/7] merge-ort: add ability to record conflict messages
 in a file
Message-ID: <YVVuP8ReqaPi/Z5E@coredump.intra.peff.net>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <ed71913886e19ccc276b382de707b4bab7834d12.1630376800.git.gitgitgadget@gmail.com>
 <YVOXPTjsp9lrxmS6@coredump.intra.peff.net>
 <CABPp-BEioOUJRd6FSsmsDtYHhUy7xhr4YabdEmVKzkduo4g9TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEioOUJRd6FSsmsDtYHhUy7xhr4YabdEmVKzkduo4g9TQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 11:25:20PM -0700, Elijah Newren wrote:

> > Just brainstorming some alternatives:
> >
> >  - we have diff.orderFile, etc. Could we stuff this data into a less
> >    confusing name (even just "$filename.conflict_msg"), and then provide
> >    a custom ordering to the diff code? I think it could be done by
> >    generating a static ordering ahead of time, but it might even just be
> >    possible to tell diffcore_order() to take the ".conflict_msg"
> >    extension into account in its comparison function.
> 
> I can't just go on the ".conflict_msg" extension.  As you noted above,
> this scheme is not sufficient for avoiding collisions.  So I need to
> append extra "cruft" to the name in the case of collisions -- meaning
> we can't special case on just that extension.

Sure, but we can call it filename.conflict_msg.1, etc, and the sort code
can pattern-match. It can never be fully robust (if you really did have
a foo.conflict_msg, we'd sort it differently), but I think it's OK if
the worst-case is that pathological trees get ordered slightly
sub-optimally).

That said, I think it could also make sense to annotate the conflict
files by giving them an unusual set of mode bits. That would be easier
to recognize (and while real trees _could_ have silly modes, we do
complain about them in fsck, so it shouldn't happen in practice).

> I also don't like how diff.orderFile provides a global ordering of the
> files listed, rather than providing some scheme for relative
> orderings.  That'd either force me to precompute the diff to determine
> all the files that were different so I can list _all_ of them, or put
> up with the fact that the files with non-content conflicts will be
> listed very first in the output, even if their name is
> 'zee-last-file.c' -- surprising users at the output ordering.
> 
> This also means that if the user had their own ordering defined, then
> I'm overriding it and messing up their ordering, which might be
> problematic.

Agreed. I do think it may be too horrible unless you teach
diffcore_order() to actually understand your annotations in code.  But
that wouldn't be too hard if it's done in the mode bits.

But I do think anything that avoids these pseudo-files is going to be a
lot cleaner overall.

> >  - there can be other non-diff data between the individual segments. For
> >    example, "patch" will skip over non-diff lines. And certainly in Git
> >    we have our own custom headers. I'm wondering if we could attach
> >    these annotations to the diff-pair somehow, and then show something
> >    like:
> >
> >      diff --git a/foo.c b/foo.c
> >      index 1234abcd..5678cdef 100644
> >      conflict modify/delete foo.c
> 
> A couple things here...

I think Junio already indicated that we can pretty much make this look
like whatever we want. As soon as any reader sees "conflict", it should
happily ignore the rest as something it doesn't know about. And my short
example here was just meant to be illustrative. I agree it probably
needs more details (and the whole CONFLICT line that usually goes to
stderr is probably the best thing).

-Peff
