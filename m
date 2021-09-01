Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0747EC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 06:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9B6C60295
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 06:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242090AbhIAGbk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 02:31:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:36084 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhIAGbj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 02:31:39 -0400
Received: (qmail 15489 invoked by uid 109); 1 Sep 2021 06:30:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Sep 2021 06:30:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4007 invoked by uid 111); 1 Sep 2021 06:30:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Sep 2021 02:30:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Sep 2021 02:30:42 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] rebase, cherry-pick, revert: only run from toplevel
Message-ID: <YS8eEtwQvF7TaLCb@coredump.intra.peff.net>
References: <pull.1083.git.git.1630379030665.gitgitgadget@gmail.com>
 <YS3Tv7UfNkF+adry@coredump.intra.peff.net>
 <CABPp-BFmU+RaAjq4_0-PSfRgH1Jc63nN0fMuDWk2+iDbdz7CCA@mail.gmail.com>
 <xmqqk0k0sw2h.fsf@gitster.g>
 <CABPp-BFET9PhgAh+xvMWzTGD+pW3ujOUXO6JOF1rtFMMpDHZvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFET9PhgAh+xvMWzTGD+pW3ujOUXO6JOF1rtFMMpDHZvg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 11:08:35PM -0700, Elijah Newren wrote:

> On Tue, Aug 31, 2021 at 10:29 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Elijah Newren <newren@gmail.com> writes:
> >
> > > Ooh, this sounds intriguing to me...but what if we changed that rule
> > > slightly and just decided to never make the cwd go away?  Currently,
> > > the checkout code removes directories if they have no tracked or
> > > untracked or ignored files left, i.e. if they're empty.  What if we
> > > decide to only have remove_scheduled_dirs() remove directories that
> > > are empty AND they are not the current working directory?
> >
> > Is that generally doable?  What would we do when the directory the
> > subcommand was started from (or one of its parent directories) is
> > not just missing but has to be a file in the revision the subcommand
> > is trying to checkout?
> 
> The same problem (an untracked directory is in the way) already exists
> and has to be handled by all relevant subcommands, right?
> 
> In particular, if the current working directory only has untracked
> files in it, then the directory cannot be removed.  That will prevent
> us from checking out the revision we want, so we have to throw an
> error.
> 
> So my idea just piggy backs on that, resulting in the same error also
> being shown when the current working directory has 0 untracked files
> within it.
> 
> Since the whole thread started from, "maybe we should throw an error
> instead of continuing if it would result in the current working
> directory getting deleted", I believe this idea does exactly what we
> were looking for...and nicely tailors the new error cases to precisely
> the situations we wanted them for -- when the current working
> directory would have been removed by the old code.

Yeah, this is definitely what I had in mind for my original suggestion:
extending the "do not delete directory if it contains an untracked file"
rule to the cwd. I guess I was thinking of it as an error, but it really
_isn't_ an error in most cases, as long as we don't need to recreate
another entry there (and if we do, then as you say, the existing error
paths should handle it).

It does leave crufty directories behind in the working tree that Git
would not then delete (because it only cleans up directories after it
removes their contents, and there are no contents left to remove).
That's probably not a big deal, though. If you are moving around history
with things like rebase or bisect, you'd likely move back to a working
tree with the directory anyway. And it's not like you can't end up with
such directories through other means (and "git clean -d" takes care of
them).

So I do like the approach.

-Peff

PS I'm assuming this is all taking the cwd of the process based on the
   original "prefix" (since Git processes generally move up to the
   top-level of the working tree). But that still leaves the problem for
   _other_ processes. E.g., if I am working in two terminals, one could
   be in "subdir/" and I could issue a bisect or rebase command from the
   other at the top-level, which would put one of them into the
   confusing state. You could strengthen the rule to "is _any_ process
   using this as a cwd", but it's hard to do so portably. And I know
   I've been annoyed by similar such safety valves before ("why can't I
   delete this? Argh, some process I don't care about is squatting on
   it").
