Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E67EC48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 23:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55044611AD
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 23:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhFWXmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 19:42:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:58882 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229987AbhFWXmv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 19:42:51 -0400
Received: (qmail 8300 invoked by uid 109); 23 Jun 2021 23:39:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Jun 2021 23:39:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8058 invoked by uid 111); 23 Jun 2021 23:40:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Jun 2021 19:40:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 23 Jun 2021 19:40:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Roland Hieber <rhi@pengutronix.de>, git@vger.kernel.org,
        Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH] bisect: allow to run from subdirectories
Message-ID: <YNPGb5gvygs++jlv@coredump.intra.peff.net>
References: <20210620213836.10771-1-rhi@pengutronix.de>
 <xmqqy2b3j317.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2b3j317.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 12:43:32PM +0900, Junio C Hamano wrote:

> Roland Hieber <rhi@pengutronix.de> writes:
> 
> > Currently, calling 'git bisect' from a directory other than the top
> > level of a repository only comes up with an error message:
> >
> >     You need to run this command from the toplevel of the working tree.
> >
> > After a glance through the bisect code, there seems to be nothing that
> > relies on the current working directory, and a few hours of bisect usage
> > also didn't turn up any problems. Set the appropriate flag for
> > git-sh-setup to remove the error message.
> 
> Try to find a history in which to run a bisect that
> 
>  (1) has a directory T in the recent part of the history, and
> 
>  (2) does not have that directory in the older part of the history.
>      Better yet, if the older part of the history has T as a regular
>      file, that would be ideal.  Even better, if that old regular
>      file T was added, then removed, and then recreated, before it
>      got turned into a directory.
> 
> Now, using the two commits you used to satisfy conditions (1) and
> (2) as "bad" and "good", and using "bad - has T as a directory" and
> "good - does not have T as a directory", as the bisection criterion,
> try to find where "good" turns "bad"---in other words, find the
> commit that either creates T as a directory or turns the regular
> file T into a directory.
> 
> Perform that bisect from the subdirectory T.  Would that work?  I
> suspect it wouldn't; when trying to check out an old version that
> does not have T in the directory, either the checkout would fail
> because it cannot remove T which has an active process (i.e. your
> terminal session) in it, or your process sitting in an orphaned
> directory (i.e. your ".." may still be the original top-level
> directory that used to have T subdirectory, but "cd T" from the
> top-level will not reach where you are).  All sorts of things can
> go wrong and that is why we forbid it.  Just a single "cd" upfront
> would save the user a lot of headache.
> 
> This does not depend on "do we have T as a directory?" being the
> bisection criteria.  The important thing is that the current
> directory would appear and disappear as the bisection process makes
> you jump around in the history.

I think that is a good explanation. But I remain somewhat unconvinced
that it is that big a problem in practice.

There are already other cases where checkout may fail (e.g., an
untracked build artifact in one commit conflicting with a tracked file
in another). E.g., this sequence in git.git:

  # here we build git-remote-testgit from its .sh counterpart
  git checkout 5afb2ce4cd^
  make

  # now imagine our bisect jumps forward; this one drops it from
  # the .gitignore, so its now a precious untracked file
  git checkout 5afb2ce4cd
  make

  # now jump backwards. I'm not sure if this can actually happen in
  # a bisection of git.git, since we went forward then back. But
  # possibly you could hit it in parallel lines of history[1], and
  # certainly a similar history which didn't update ".gitignore" at the
  # same time could run into it.
  git checkout 709a957d9493^

That last command yields:

  error: The following untracked working tree files would be overwritten by checkout:
	git-remote-testgit
  Please move or remove them before you switch branches.
  Aborting

Which is annoying, but it's pretty clear that you need to remove the
file and then re-run your "bisect good" or "bisect bad" (and if we want
to make it more clear, then git-bisect could notice that git-checkout
failed and add extra advice).

And I think any directory typechange shenanigans would end up with a
similar message. It's nice to avoid that ahead of time, but it comes at
the cost of bugging the user to preemptively "cd" to the toplevel _every
time_, even if they are not going to bisect through history where the
directory goes away.

So while I don't disagree with avoiding the confusing case, it seems
like the safety check is overly cautious. (Of course an alternative is
that it could actually examine the history to make sure $PWD never goes
away; I wonder if that would be annoyingly costly or not).

The more interesting case, I think, is when T is simply removed.  If
there are untracked files (even ignored build artifacts) in T, then the
directory sticks around anyway. But if not, Git is able to checkout the
original commit and deletes the directory. And then you get:

  $ cd builtin
  $ git checkout 81b50f3ce40bfdd66e5d967bf82be001039a9a98^
  $ git status
  fatal: Unable to read current working directory: No such file or directory

That's potentially more confusing, as things subtly don't work. But as
shown by the command above, it's not the exclusive domain of bisect.
Perhaps a poorly written bisect-run script could get confused. But it
still doesn't seem to me like it justifies the tradeoff of "we must
never allow bisect from a subdirectory, on the off chance that we might
run into this case".

If we did want try helping the user in this case, we could also diagnose
it pretty easily by confirming that $PWD will be in the destination
commit before checking it out, and complaining otherwise (which turns it
into the earlier case). In fact, regular "checkout" could perhaps do
that, too, as a courtesy (with "-f" overriding).

There may be other corner cases of interest (I didn't think too hard
about weird symlink cases, for example). But overall I think people are
more likely to be annoyed by the "must be at the toplevel" safety valve
than they are by "checkout failed midway through my bisect", if only
because the former happens a lot more frequently.

-Peff

[1] I'm sorry not to have produced a real git-bisect example that causes
    "checkout" to bail. My subjective recollection is that I have run
    into this problem with git-remote-testgit before during real-world
    use, but I'm not 100% sure it was while bisecting, and not simply
    sight-seeing around history.
