Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DD3C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 252BA2074B
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgG2U6s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:58:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:41616 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgG2U6s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 16:58:48 -0400
Received: (qmail 9168 invoked by uid 109); 29 Jul 2020 20:58:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 20:58:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8863 invoked by uid 111); 29 Jul 2020 20:58:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 16:58:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 16:58:46 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Avoiding 'master' nomenclature
Message-ID: <20200729205846.GA2992025@coredump.intra.peff.net>
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
 <xmqqime69jfc.fsf@gitster.c.googlers.com>
 <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
 <CAHk-=wi2dsROeg=mij5C8O=UBVZGEpOUp=Bn-arQ7i+Wscynnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi2dsROeg=mij5C8O=UBVZGEpOUp=Bn-arQ7i+Wscynnw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 01:40:17PM -0700, Linus Torvalds wrote:

> > So really. Both from a technical _and_ a terminology angle, that
> > commit was just wrong.
> 
> So here's the fix.
> 
> The fix is effectively a revert of the patch (and a follow-up
> test-case patch), and instead just replaces the "master" nomenclature
> with "git_default_branch_name()".
> 
> This patch actually removes more uses of "master" than it adds to git,
> and unlike the patches it replaces, actually removes it from other
> projects commit logs.
> 
> Now whatever default branch name you choose really is immaterial.

I don't think that covers all cases.

If I set init.defaultBranch, then that only sets the default branch name
for new repositories I create with "git init". But I may still interact
with many repositories that use a different name (either "master", or
other names chosen by individual projects).

If you suppressed the output for both "master" and
git_default_branch_name(), that would cover more cases, at the expense
of occasionally doing the wrong thing when some project uses "master"
but doesn't mean for it to be a default branch (but that's presumably
rare).  It would still do the wrong thing if you prefer "foo" as the
default branch name for your projects, but sometimes work on a project
that prefers "bar".

Users can set init.defaultBranch in individual repository config files
to get the right behavior, though probably it should be a separate
config variable (the reason it is init.defaultBranch and not
core.defaultBranch is that you may want different defaults for different
operations).

So I think a path forward is more like:

  1. Add a new config option to shorten fmt-merge-msg's output when the
     destination branch matches it (and this should perhaps not even be
     a single name, but a set of globs, which supports more workflows).
     Call it merge.suppressDest or something.

  2. Optionally a repository created with "git init" could copy its
     init.defaultBranch into merge.suppressDest. And likewise a clone
     might copy the remote HEAD into that variable. I'm not sure if that
     is worth doing or not, but it would restore the original behavior
     for the most part.

-Peff
