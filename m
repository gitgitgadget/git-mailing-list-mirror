Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE0AC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 04:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE78207B3
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 04:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgLOEhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 23:37:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:60900 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgLOEhf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 23:37:35 -0500
Received: (qmail 13820 invoked by uid 109); 15 Dec 2020 04:36:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Dec 2020 04:36:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7975 invoked by uid 111); 15 Dec 2020 04:36:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 14 Dec 2020 23:36:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 14 Dec 2020 23:36:51 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] clone: in protocol v2, use remote's default branch
Message-ID: <X9g9Y9LWc0NtHlQn@coredump.intra.peff.net>
References: <20201208013121.677494-1-jonathantanmy@google.com>
 <20201211210508.2337494-1-jonathantanmy@google.com>
 <87blewwoil.fsf@evledraar.gmail.com>
 <xmqqim94e4et.fsf@gitster.c.googlers.com>
 <878s9zx2ul.fsf@evledraar.gmail.com>
 <X9ghqMo5WS8FrBEz@coredump.intra.peff.net>
 <xmqq8s9zaica.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8s9zaica.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 14, 2020 at 06:55:33PM -0800, Junio C Hamano wrote:

> >   - it might be nice to be able to have some equivalent to the dwim "git
> >     checkout foo" that creates a new "foo" based off of origin/foo.
> >     Doing "git checkout origin/HEAD" will detach the HEAD. I think right
> >     now you'd have to do something like:
> >
> >       tracking=$(git symbolic-ref refs/remotes/origin/HEAD)
> >       branch=${tracking#refs/remotes/origin/}
> >       git checkout -b $branch $tracking
> 
> Meaning "git checkout origin" would look at origin/HEAD and find the
> remote-tracking branch it points at, and uses that name?  I think
> that does make quite a lot of sense.  You are correct to point out
> that not just "git checkout origin/HEAD", but "git checkout origin",
> currently detaches the HEAD at that commit, if you have origin/HEAD
> pointing at one of the remote-tracking branches.

I'm not sure if it's a good idea to change "git checkout origin" here or
not. It already does something useful. I was mostly suggesting that the
other thing might _also_ be useful, but I'm not sure if it is wise to
change the current behavior.

I was thinking more like an explicit way to trigger the dwim-behavior,
like:

  # same as "git checkout foo" magic that creates "foo", but we
  # have said explicitly both that we expect to make the new branch, and
  # also that we expect it to come from origin.
  git checkout --make-local origin/foo

  # similar, but because we are being explicit, we know it is reasonable
  # to dereference HEAD to find the actual branch name
  git checkout --make-local origin/HEAD

I dunno. I hate the name "--make-local", and in the non-dereferencing
form, it is not much different than just "git checkout -b foo
origin/foo". I'm mostly just thinking aloud here. :)

> But if we were to make such a change, "git fetch" shouldn't
> automatically update remotes/origin/HEAD, I would think.  It does
> not matter too much if we are talking about a publishing repository
> where the HEAD rarely changes (and when it does, it is a significant
> event that everybody in the downstream should take notice), but if
> you clone from a live repository with active development, you do not
> want to lose a stable reference to what you consider as the primary
> branch at your origin repository.

That seems orthogonal. Whether there is checkout magic or not, changing
what origin/HEAD points to would be disruptive to selecting it as a
tracking source, or doing diffs, or whatever. But that is why the
proposal in that series was to make the behavior configurable, and
default to "fill it in if missing" as the default, not "always update on
fetch".

-Peff
