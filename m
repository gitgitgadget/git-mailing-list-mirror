Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A242FC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 07:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 765DA60FE8
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 07:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbhHaHCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 03:02:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:34702 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232209AbhHaHCP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 03:02:15 -0400
Received: (qmail 3999 invoked by uid 109); 31 Aug 2021 07:01:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Aug 2021 07:01:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20232 invoked by uid 111); 31 Aug 2021 07:01:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Aug 2021 03:01:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 31 Aug 2021 03:01:19 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] rebase, cherry-pick, revert: only run from toplevel
Message-ID: <YS3Tv7UfNkF+adry@coredump.intra.peff.net>
References: <pull.1083.git.git.1630379030665.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1083.git.git.1630379030665.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 03:03:50AM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> Allowing rebase, cherry-pick and revert to run from subdirectories
> inevitably leads to eventual user confusion.  For example, if they
> are within a directory that was created by one of the patches being
> rebased, then the rebase operation could hit a conflict before the
> directory is restored leading the user to be running from a directory
> that no longer exists.  Similarly with cherry-pick and revert, those
> operations could result in the directory being removed.
> 
> Similar to bisect, simply require that these commands be run from the
> toplevel to avoid such problems.

IMHO this is too draconian. You are occasionally helping people who are
in a directory which goes away over the course of the operation. But you
are hurting everyone who _isn't_ in that situation, and who needlessly
has to re-issue their command after doing a "cd".

I think we'd be much better served to do even a rudimentary analysis of
whether the operation will be a problem. E.g., if we taught the checkout
code to error out when the cwd is going to disappear, then:

  - we'd protect the user from confusion during regular sight-seeing via
    "git checkout v0.99" and so forth

  - we'd protect the most common cases for git-rebase (your patches
    introduce "subdir/", but it is not yet in the parent directory). We
    wouldn't preemptively avoid a rebase where subdir/ disappears and
    then reappears in the middle of the series. We could find such a
    case by iterating over the patches, but IMHO it's not worth the
    computation.

  - we could likewise protect git-bisect, making it more reasonable to
    loosen its current restriction

  - we might want to teach similar logic to sequencer operations, so
    that applying a patch would likewise error-out. That would protect
    cherry-pick and revert, but also make the "subdir/ disappears
    mid-patch-series" case pretty nice: the specific patch that deletes
    it would fail to apply, and then you could "cd .. && git rebase
    --continue".

    I suspect that the "oops, we're going to delete cwd" code would end
    up in unpack-trees anyway, which means that both checkout and all of
    this sequencer operations would use the same code.

Now I have spent zero time looking into actually coding this, so it may
turn out to be much trickier than I am suggesting. But this seems like a
much more fruitful direction, where we can protect users in cases where
they benefit (and give them sensible and actionable error messages),
without bothering people in the majority of cases where their cwd
doesn't go away.

-Peff
