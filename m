Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B721DC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E48223428
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbgLPSkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:40:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:34904 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbgLPSka (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:40:30 -0500
Received: (qmail 23987 invoked by uid 109); 16 Dec 2020 18:39:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Dec 2020 18:39:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31963 invoked by uid 111); 16 Dec 2020 18:39:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Dec 2020 13:39:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Dec 2020 13:39:47 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] clone: in protocol v2, use remote's default branch
Message-ID: <X9pUc2HXUr3+WHbR@coredump.intra.peff.net>
References: <20201208013121.677494-1-jonathantanmy@google.com>
 <20201211210508.2337494-1-jonathantanmy@google.com>
 <87blewwoil.fsf@evledraar.gmail.com>
 <xmqqim94e4et.fsf@gitster.c.googlers.com>
 <878s9zx2ul.fsf@evledraar.gmail.com>
 <X9ghqMo5WS8FrBEz@coredump.intra.peff.net>
 <xmqq8s9zaica.fsf@gitster.c.googlers.com>
 <X9g9Y9LWc0NtHlQn@coredump.intra.peff.net>
 <xmqq7dpi5tvl.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7dpi5tvl.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 15, 2020 at 07:09:50PM -0800, Junio C Hamano wrote:

> > I'm not sure if it's a good idea to change "git checkout origin" here or
> > not. It already does something useful. I was mostly suggesting that the
> > other thing might _also_ be useful, but I'm not sure if it is wise to
> > change the current behavior.
> 
> Well, "git checkout origin/HEAD" would also do something useful,
> which happens to be identical to "git checkout origin", to detach
> HEAD at the commit.

To be clear, I meant that both of those do the useful thing, and I'm not
sure if it would be confusing to users to change that (but see below).

> > I was thinking more like an explicit way to trigger the dwim-behavior,
> > like:
> >
> >   # same as "git checkout foo" magic that creates "foo", but we
> >   # have said explicitly both that we expect to make the new branch, and
> >   # also that we expect it to come from origin.
> >   git checkout --make-local origin/foo
> 
> By default I think --guess (formerly known as --dwim) is enabled, so
> "git checkout foo" is "git checkout --guess foo", which is making
> local 'foo' out of the uniquely found remote-tracking branch.  This
> new one is to reduce the "uniquely found" part from the magic and
> let you be a bit more explicit, but not explicit enough to say "-t"
> or "-b foo"?  I am not sure if this is all that useful.

I agree it's not all that useful in that example. What I was thinking is
that by giving the implicit/heuristic magic a more explicit verbose
name, then we make it natural to extend the explicit version to more
cases where it might be questionable to do it implicitly.

So no, I doubt anybody would normally type what I wrote above. But it
lets us explain it as:

  - there's a feature "--make-local" (I still hate the name) that makes
    a local branch from a remote one if it doesn't already exist

  - that feature knows how to resolve symrefs and create the branch from
    the pointed-to name

  - as a shortcut, "git checkout foo" is a synonym for "--make-local
    origin/foo" when "origin/foo" exists but "foo" does not

It's definitely not worth it, though, if we decide that there's an
implicit/heuristic syntax that should trigger the symref thing.

> If this were a slightly different proposal, I would see the
> convenience value in it, though.  Currently what "--guess" does is:
> 
>       If the name 'foo' given does not exist as a local branch,
>       and the name appears exactly once as a remote-tracking branch
>       from some remote (i.e. 'refs/remotes/origin/foo' exists, but
>       there is no other 'refs/remotes/*/foo'), create a local 'foo'
>       that builds on that remote-tracking branch and check it out.
> 
> What would happen if we tweaked the existing "--guess" behaviour
> slightly?
> 
>       "git checkout --guess origin/foo", even when there is a second
>       remote 'publish' that also has a remote-tracking branch for
>       its 'foo' (i.e. both 'refs/remotes/{origin,publish}/foo'
>       exists), can be used to disambiguate among these remotes with
>       'foo'.  You'd get local 'foo' that builds on 'foo' from the
>       remote 'origin' and check it out.

I forgot we had --guess. Piggy-backing on that might be sensible as a
stronger "explicit" signal that this is what the user wants (though
"--guess" is still a funny name here, because we're no longer guessing
at all; the user told us what they want).

But yeah, the semantics you outlined in the second paragraph match what
I was expecting "--make-local" to do.

> >   # similar, but because we are being explicit, we know it is reasonable
> >   # to dereference HEAD to find the actual branch name
> >   git checkout --make-local origin/HEAD
> 
> The user does not need "git symbolic-ref refs/remotes/origin/HEAD"
> if such a feature were available.  "git checkout --some-option origin"
> without having to say /HEAD may be a better UI, though.

Right. I'm assuming that "origin/HEAD" and "origin" could be used
interchangeably in my example.

> And "checkout" being a Porcelain, and the DWIM feature that is
> always on is subject to be improved for human use, I do not see why
> that --some-option cannot be --guess.  If I want to get the current
> behaviour, I can explicitly say "git checkout --detach origin"
> anyway, no?

I think:

  git checkout --guess origin

would make sense to dereference origin/HEAD to "foo", as if we had said
"git checkout foo". That's the explicit part that seems safe. My
question is whether:

  git checkout origin

should likewise do so. As you note, one can always use --detach to make
their intention clear, and checkout is a porcelain, so we are OK to
change it. But would users find that annoying? I frequently use "git
checkout origin" to get a detached HEAD pointing at your master (e.g.,
because I want to reproduce a bug, or do a "something like this..."
patch). I'm sure I could retrain my fingers, but I wonder if I'm not the
only one.

Doing it for only an explicit "--guess" turns that feature into a
tri-state (explicitly off, explicitly on, or "implicit, so be a little
more conservative"). Which perhaps is harder to explain, but I think
cleanly adds the new feature in a consistent way, without really
changing any existing behavior.

Related, I assume that:

  git checkout --guess origin/foo
  git checkout origin/foo

should behave the same as their "origin" or "origin/HEAD" counterparts
for consistency (obviously making "foo" in the former case, and either
detaching or making "foo" in the second case, depending on what you
think of the earlier paragraphs).

-Peff
