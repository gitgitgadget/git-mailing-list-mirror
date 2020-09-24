Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EB0C2D0E2
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 06:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 412AB23772
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 06:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgIXGvm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 02:51:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:39026 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbgIXGvb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 02:51:31 -0400
Received: (qmail 1595 invoked by uid 109); 24 Sep 2020 06:51:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Sep 2020 06:51:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18438 invoked by uid 111); 24 Sep 2020 06:51:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Sep 2020 02:51:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Sep 2020 02:51:29 -0400
From:   Jeff King <peff@peff.net>
To:     Chris Webster <chris@webstech.net>
Cc:     "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: github action - add check for whitespace errors
Message-ID: <20200924065129.GB1851751@coredump.intra.peff.net>
References: <pull.709.git.1600759684548.gitgitgadget@gmail.com>
 <20200922170745.GA541915@coredump.intra.peff.net>
 <CAGT1KpVmeT+nT1-Pfwa_M8BptFYwRTL4ofM0k6UOOzkYh0kucw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGT1KpVmeT+nT1-Pfwa_M8BptFYwRTL4ofM0k6UOOzkYh0kucw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 22, 2020 at 03:17:54PM -0700, Chris Webster wrote:

> On Tue, Sep 22, 2020 at 10:07 AM Jeff King <peff@peff.net> wrote:
> >  - for a linear branch on top of master, using the commit count will
> >    work reliably. But I suspect it would run into problems if there were
> >    ever a merge on a PR (e.g., back-merging from master), where we'd be
> >    subject to how `git log` linearizes the commits. That's not really a
> >    workflow I'd expect people to use with git.git, but it would probably
> >    be easy to make it more robust. Does the PR object provide the "base"
> >    oid, so we could do "git log $base..$head"?
> 
> GitGitGadget PR linting is going to flag merges in the PR and request
> a rebase.  If I understand correctly, that means back-merging is not
> part of the workflow.

Yeah, I would definitely be surprised to see it used with a git PR, but
I didn't realize there was other linting that would actually complain
about it.

> The checkout is limited to improve performance
> and reduce resources.  In the PR object, the base is the branch.  The
> github api would need to be used to get more detailed information.
> The "base" is not really part of the checkout so it can not be
> referenced in the git log command (without doing a larger checkout).

Hmm.

  git clone --shallow-exclude=HEAD --single-branch -b $branch
  git log --check

_almost_ works. The problem is that the shallow graft means that the
bottom commit looks like it introduces every file. We really want to
graft at HEAD^, but the server side only accepts exact refnames. You
could work around it with a followup:

  git fetch --deepen 1

which is getting a bit convoluted. I suspect you may also have to
abandon the "checkout" action and do this manually. Definitely not worth
it compared to your solution for a PR, but maybe worth it if it lets us
do the same thing for arbitrary branches.

-Peff
