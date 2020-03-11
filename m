Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43DEC2BAEE
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 19:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A255720736
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 19:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbgCKTdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:33:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:36762 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731322AbgCKTdT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 15:33:19 -0400
Received: (qmail 3625 invoked by uid 109); 11 Mar 2020 19:33:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Mar 2020 19:33:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22391 invoked by uid 111); 11 Mar 2020 19:42:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Mar 2020 15:42:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Mar 2020 15:33:17 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] sequencer: clear state upon dropping a
 become-empty commit
Message-ID: <20200311193317.GC27978@coredump.intra.peff.net>
References: <pull.722.git.git.1583903621.gitgitgadget@gmail.com>
 <pull.722.v2.git.git.1583940623.gitgitgadget@gmail.com>
 <84b89d7843527d7b1f3e00f122dc1e82f1ced381.1583940623.git.gitgitgadget@gmail.com>
 <20200311163454.GC27893@coredump.intra.peff.net>
 <CABPp-BFtspDhSherYyhH-Aw=oPLzCiGfbMUiLPB0n1rnzV3k0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFtspDhSherYyhH-Aw=oPLzCiGfbMUiLPB0n1rnzV3k0Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 11, 2020 at 10:16:22AM -0700, Elijah Newren wrote:

> > It feels like the set of paths to be cleaned up would probably exist
> > elsewhere in a helper function for cleaning up real cherry-picks. But
> > I'll defer to your expertise there, as I don't know the sequencer code
> > very well.
> 
> Yeah, I was looking for something like that but instead found the
> unlink() directives for cleaning up various state files scattered
> throughout the code.  I think sequencer.c is in need of some cleaning
> up; the slow transition from "do what shell does, now work both with
> an external shell and some pieces built in, now move slightly more
> towards being built-in" seems to have left a lot of artifacts around
> and made it a bit unwieldy.

OK. As long as you looked and didn't find anything obvious that should
be used, I'm content to leave it for a later cleanup (I also looked
briefly and didn't find anything useful).

> I'm not sure deferring to my expertise with sequencer.c makes sense,
> since you have about twice as many commits to sequencer.c as me.  But
> I was deferring to Phillip and he commented on my v1 and seemed happy
> (other than my missing handling of MERGE_MSG).

Heh, all memories of sequencer.c have been wiped from my memory. I
thought you might have looked at it more recently because of this rebase
backend work, but I guess that didn't involve poking at the sequencer
internals much.

> > This could check the output of git-status to avoid poking around in the
> > .git directory itself. But I doubt that the exact filenames are going to
> > change, and parsing the output of status is its own problem (I don't
> > think we give this "state" info in a machine-readable way).
> 
> Yeah, it's not clear to me what's best either.  When I was testing my
> changes locally I was checking status output.  However, after creating
> the fix and deciding to add a regression test, I switched to checking
> for the existence of those files basically for the reasons you
> mention, despite knowing I'm only testing for certain state files
> rather than testing that git in general doesn't think it's still in
> the middle of some operation.

I did just double check that "git status" has no way to produce a
machine-readable version of the data. That might be worth addressing in
general[1], but I think what you have here is a good test for now.

-Peff

[1] In particular, I think that git-prompt.sh reimplements some of this
    logic, and I would be surprised if there wasn't some weird corner
    case where they differ. The prompt code does try to avoid invoking
    subprocesses for efficiency, but I imagine we're running git-status
    already to get the dirty state.
