Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED333C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 01:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE7BA64DBA
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 01:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhBPBQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 20:16:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:33420 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhBPBQl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 20:16:41 -0500
Received: (qmail 9929 invoked by uid 109); 16 Feb 2021 01:16:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 01:16:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18227 invoked by uid 111); 16 Feb 2021 01:16:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Feb 2021 20:16:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 15 Feb 2021 20:16:00 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Blake Burkhart <bburky@bburky.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] fsck: make symlinked .gitignore and .gitattributes a
 warning
Message-ID: <YCsc0OePtrotjeg5@coredump.intra.peff.net>
References: <YCsBA002yv8XpppM@coredump.intra.peff.net>
 <YCsBRUQkrAm8l2gz@coredump.intra.peff.net>
 <87y2foaltl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y2foaltl.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 01:38:30AM +0100, Ævar Arnfjörð Bjarmason wrote:

> On Tue, Feb 16 2021, Jeff King wrote:
> 
> > While there are some minor security implications to having these files
> > be symlinks, this is out-weighed by the inconvenience of blocking
> > historical commits in some projects that might include them.
> 
> Digging up the relevant thread that's the projects noted at
> https://lore.kernel.org/git/20201027033518.GH2645313@google.com/ ?
> 
> I cloned the openmrn.git repository noted there, and checkout dies with:
> 
>     error: invalid path 'applications/clinic_app/targets/linux.x86/.gitignore'
>     fatal: Could not reset index file to revision 'HEAD'.
> 
> I'm running a recent-ish snapshot of next at d98b1dd5eaa7, so with your
> verify_path() change in current "seen".
> 
> So this series changes nothing about the checkout, just the fsck check?

Right.

> I see there's your
> https://lore.kernel.org/git/20201027075853.GH3005508@coredump.intra.peff.net/#t
> to improve the !!symlink() codepath in apply.c

That's a somewhat orthogonal approach, that tries to look at out-of-tree
symlinks (rather than banning all symlinks for these files).

I think it's worth banning them all, though; they don't actually work
as you'd expect (i.e., whenever we read them in-repo the symlinks do
nothing).

> Still, it seems like a rather jarring gap in implementation to just warn
> about this in fsck for the benefit of e.g. server operations, but then
> hard die on the current client.

It's not for the benefits of servers. It's because the solution for them
is to stop symlinking, which fixes clone/checkout of new commits. But
they'll still have those old trees hanging around in their history. If
everybody rejects them, then it becomes difficult to push/fetch at all.

That said, they'd probably want to checkout those old commits, too. So
we probably do need a config override, even if it's a broad one ("trust
me, this repo is OK, just allow symlinks for these special files").

> There seems to be no way around that hard die, and both repos in that
> report are ones that are just symlinking .gitignore to a
> ../somedir/.gitignore deep in their own tree.
> 
> So aren't we both making the fsck check too loose and the client too
> strict? Would anyone care if this was an error on fsck if we did the "is
> outside repo?" check?

An outside-the-repo check would probably be less invasive, but:

  - it still allows broken setups

  - it's significantly more complex. I know that the implementation I
    showed errs on the side of complaining in at least some cases
    (because it doesn't know if intermediate paths are themselves
    symlinks). But I'd worry there are also cases where it covers too
    little, nullifying the protection.

-Peff
