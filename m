Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA1CC33CB3
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 09:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1F6214D8
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 09:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgA1JsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:48:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:46148 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725881AbgA1JsC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 04:48:02 -0500
Received: (qmail 8778 invoked by uid 109); 28 Jan 2020 09:48:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Jan 2020 09:48:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5891 invoked by uid 111); 28 Jan 2020 09:55:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jan 2020 04:55:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jan 2020 04:48:01 -0500
From:   Jeff King <peff@peff.net>
To:     Chris Jerdonek <chris.jerdonek@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-clone --single-branch clones objects outside of branch
Message-ID: <20200128094801.GC574544@coredump.intra.peff.net>
References: <CAOTb1wfoMf338VPRYcjAv+EaMYQxKJ=kP6-qMykG-LfxPrWuag@mail.gmail.com>
 <20200127055509.GA12108@coredump.intra.peff.net>
 <CAOTb1wd9D3YytevTt0cGnw1o-9cN1-yxCqbuH4oLH1KB6mzEeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOTb1wd9D3YytevTt0cGnw1o-9cN1-yxCqbuH4oLH1KB6mzEeA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 26, 2020 at 10:46:07PM -0800, Chris Jerdonek wrote:

> Thanks for the reply. It's okay for that to be the expected behavior.
> My suggestion would just be that the documentation for --single-branch
> be updated to clarify that objects unreachable from the specified
> branch can still be in the cloned repo when run using the --local
> optimizations. For example, it can matter for security if one is
> trying to create a clone of a repo that doesn't include data from
> branches with sensitive info (e.g. in following Git's advice to create
> a separate repo if security of private data is desired:
> https://git-scm.com/docs/gitnamespaces#_security ).

I think it would make sense to talk about that under "--local". There
are other subtle reasons you might want "--no-local", too: it will
perform more consistency checks, which could be valuable if you're
thinking about deleting the old copy.

I'm not sure how much Git guarantees in general that you won't get extra
objects. It's true that we try to avoid sending objects that aren't
needed, but it's mostly as an optimization. If we later modified
pack-objects to sometimes send unneeded objects (say, because we're able
to compute the set more efficiently if we use an approximation that errs
on the conservative side), then I think that's something we'd consider.
And I suppose it's already possible with the dumb-http protocol, which
has to fetch whole packfiles. And the same would be true of recently
proposed schemes to clients to a pre-generated packfile URL.

> I'm guessing other flags also don't apply when --local is being used.
> For example, I'm guessing --reference is also ignored when using
> --local, but I haven't checked yet to confirm. It would be nice if the
> documentation gave a heads up in cases like these. Even if hard links
> are being used, it's not clear from the docs whether the objects are
> filtered first, prior to hard linking, when flags like --single-branch
> and --reference are passed.

No, "--reference" behaves as usual. However, "--depth" is ignored (and
issues a warning). I don't think it would be wrong to issue a warning
when --single-branch is used locally (though it would not be "single
branch is ignored, since it does impact which refs are copied). But I
kind of wonder if it would be annoying for people who don't care about
having the extra objects reachable.

> > This one behaves as you expected because git-fetch does not perform the
> > same optimizations (it wouldn't make as much sense there, as generally
> > in a fetch we already have most of the objects from the other side
> > anyway, so hard-linking would just give us duplicates).
> 
> Incidentally, here's a thread from 2010 requesting that this
> optimization be available in the git-fetch case:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=573909
> (I don't know how reports on that Debian list relate to this list.)

Sometimes they get forwarded here, and sometimes not. :)

I think there are subtle issues that make naively using the optimization
a bad idea, as it could actually backfire and cause more disk usage.
E.g., consider a sequence like this:

  1. Repo A has a 100MB packfile.

  2. "git clone A B" uses hardlinks. Now we have two copies of the repo,
     storing 100MB.

  3. Repo A adds a few more commits, and then does a "git gc", breaking
     the hardlinks. Now we have ~200MB used. We're no worse off than if
     we hadn't done the hardlinks in the first place.

  4. Repo B fetches from A. It wants the new commits, but they're in
     repo A's big packfile. So it hardlinks that. We have ~200MB in repo
     B, but half of that is hardlinked and shared with A. So we're still
     using ~200MB. So far so good.

  5. Repo A repacks again, breaking the hardlinks. Now it's using
     ~100MB, but repo B is still using ~300MB. We're worse off than we
     would be without the optimization.

If you really want to keep sharing objects over time, I think using
"clone -s" is a better choice (though it comes with its own
complications and dangers, too; see the git-clone documentation).

-Peff
