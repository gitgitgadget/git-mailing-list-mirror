Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9392420A93
	for <e@80x24.org>; Tue, 10 Jan 2017 09:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1765294AbdAJJfI (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 04:35:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:37448 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1765271AbdAJJfH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 04:35:07 -0500
Received: (qmail 30858 invoked by uid 109); 10 Jan 2017 09:35:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Jan 2017 09:35:05 +0000
Received: (qmail 12409 invoked by uid 111); 10 Jan 2017 09:35:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Jan 2017 04:35:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jan 2017 04:35:02 -0500
Date:   Tue, 10 Jan 2017 04:35:02 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git discussion list <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] git-test: run automated tests against a range of Git
 commits
Message-ID: <20170110093502.wbfgof55gdo6mtov@sigill.intra.peff.net>
References: <1341c01a-aca7-699c-c53a-28d048614bfe@alum.mit.edu>
 <20170107071832.2rucap3rskzmkgq4@sigill.intra.peff.net>
 <ce6f98a4-1fb7-aa4b-2efb-78d8f49397a7@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce6f98a4-1fb7-aa4b-2efb-78d8f49397a7@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 08, 2017 at 10:52:25AM +0100, Michael Haggerty wrote:

> > I see the symmetry and simplicity in allowing the user to specify a full
> > range. But it also seems like it's easy to make a mistake that's going
> > to want to test a lot of commits. I wonder if it should complain when
> > there's no lower bound to the commit range. Or alternatively, if there's
> > a single positive reference, treat it as a lower bound, with HEAD as the
> > upper bound (which is vaguely rebase-like).
> 
> I see how this might be unexpected, and it's definitely inconvenient at
> some times (like when you want to test a single commit). I thought it
> would be nice to allow arbitrary `rev-list` expressions (albeit
> currently only a single word), but I think that you are right that other
> semantics would be more convenient.
> 
> I'm thinking of maybe
> 
> * If an argument matches `*..*`, pass it to `rev-list` (like now).
> 
> * Otherwise, treat each argument as a single commit/tree (i.e., pass it
> to `rev-parse`).
> 
> * If no argument is specified, test `@{u}..` (assuming that an
>   upstream is configured). Though actually, this won't be as
>   convenient as it sounds, because (a) `git test` is often run
>   in a separate worktree, and (2) on errors, it currently leaves the
>   repository with a detached `HEAD`.
> 
> * Support a `--stdin` option, to read a list of commits/trees to test
>   from standard input. By this mechanism, users could use arbitrary
>   `rev-list` commands to choose what to test.

That seems quite reasonable to me. The rebase semantics of "a single
argument is my upstream" is convenient, but I think it also confuses
people. Yours seem very simple to explain.

It doesn't allow complex stuff like "git test ^foo ^bar HEAD", but I
don't think "git rev-list ^foo ^bar HEAD | git test --stdin" is really
so bad for complicated cases like that (if anybody would even ever want
such a thing).

> Aside: It would be nice if `git notes` had a subcommand to initialize a
> note reference with an empty tree. (I know how to do it longhand, but
> it's awkward and it should be possible to do it via the `notes` interface.)
> 
> I think ideally `git notes add` would look for pre-existing notes, and:
> 
> * If none are found, create an empty notes reference.
> 
> * If pre-existing notes are found and there was no existing test with
>   that name, probably just leave the old notes in place.
> 
> * If pre-existing notes are found and there was already a test with
>   that name but a different command, perhaps insist that the user
>   decide explicitly whether to forget the old results or continue using
>   them. This might help users avoid the mistake of re-using old results
>   even if they change the manner of testing.

I'm not quite sure what you mean here. By "test" and "command", do you
mean the test name that is used in the notes ref, and the command that
it is defined as?

In the notes-cache.c subsystem, the commit message stores a validity
token which must match in order to use the cache. You could do something
similar here (store the executed command in the commit message, and
invalidate the cache the user has changed the command). The notes-cache
stuff isn't available outside of the C code, though. You could either
expose it, or just do something similar longhand.

Thinking about it, though, I did notice that the tree sha1 is not the
only input to the cache. Things like config.mak (not to mention the
system itself) contribute to the test results. So no system will ever be
perfect, and it seems like just making an easy way to force a retest (or
just invalidate the whole cache) would be sufficient.

But maybe I totally missed what you were trying to say here.

> > It would be even easier if I could just repeat my range and only re-test
> > the "bad" commits. It was then that I decided to actually read the rest
> > of "git test help range" and see that you already wrote such an option,
> > cleverly hidden under the name "--retest".
> 
> I think you were being ironic, but if not, would this have been easier
> to find under another name?

Sorry, the knob on my sarcasm module must have accidentally been knocked
down from "so thick it's obvious even by email".

Yes, I did just mean that I was being blind. You not only had added the
option already, but gave it the exact name I was about to propose it
under. :)

> Yeah, this is awkward, not only because many people don't know what to
> make of detached HEAD, but also because it makes it awkward in general
> to use `git test` in your main working directory. I didn't model this
> behavior on `git rebase --interactive`'s `edit` command, because I
> rarely use that. But I can see how they would fit together pretty well
> for people who like that workflow.

Yeah, after sleeping on it, I think it's best if "git test" remains
separate from that. It's primary function is to run the test, possibly
serving up a cached answer. So it would be perfectly reasonable to do:

  git rebase -x 'git test range HEAD'

to accomplish the interactive testing (though perhaps just "git test"
would be a nice synonym for that).

And then "jump to a thing that I know is broken" becomes a separate
action, whether you are using "git test" or not. I wonder if we could
have:

  git rebase -e HEAD~2

to do an interactive rebase, with "edit" for HEAD~2. I feel like
somebody even proposed that at one point, but I don't think it got
merged.

And then "git test fix" basically becomes:

  git rebase -e "$(git test first-broken)"

though I think you'd still want a shorthand for that.

> > I think it should be possible to script the next steps, though.
> > Something like like "git test fix foo", which would:
> > 
> >   - expand the range of foo@{u}..foo to get the list of commits
> > 
> >   - see which ones were marked as broken
> > 
> >   - kick off an interactive rebase, but override GIT_EDITOR to mark any
> >     broken ones as "edit" instead of "pick"
> > 
> > That lets you separate the act of testing from the act of fixing. You
> > can let the tester run continuously in the background, and only stop to
> > fix when you're at an appropriate point in your work.
> 
> I think you would usually only want to mark only the *first* broken
> commit as "edit", because often errors cascade to descendant commits.

Yeah, I had a similar thought. OTOH, if you didn't say "--keep-going",
you'd only have one breakage either way. I doubt it matters that much in
practice, and either behavior would probably be fine until somebody
comes up with a good use for the multi-commit case.

-Peff
