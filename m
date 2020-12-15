Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D64C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 02:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50CCB207A2
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 02:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgLOCje (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 21:39:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:60788 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbgLOCjT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 21:39:19 -0500
Received: (qmail 11582 invoked by uid 109); 15 Dec 2020 02:38:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Dec 2020 02:38:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7022 invoked by uid 111); 15 Dec 2020 02:38:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 14 Dec 2020 21:38:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 14 Dec 2020 21:38:32 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] clone: in protocol v2, use remote's default branch
Message-ID: <X9ghqMo5WS8FrBEz@coredump.intra.peff.net>
References: <20201208013121.677494-1-jonathantanmy@google.com>
 <20201211210508.2337494-1-jonathantanmy@google.com>
 <87blewwoil.fsf@evledraar.gmail.com>
 <xmqqim94e4et.fsf@gitster.c.googlers.com>
 <878s9zx2ul.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878s9zx2ul.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 15, 2020 at 02:41:38AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > > Another reason I'm not a fan of it is because it's another piece of
> > > magic "clone" does that you can't emulate in "init/fetch".
> > 
> > That ship has sailed longlonglong time ago when dfeff66e (revamp
> > git-clone., 2006-03-20) started pointing our HEAD to match theirs.
> 
> Let me rephrase: I think it's unfortunate when we add new things things
> to porcelain commands that aren't easy or possible to emulate in
> plumbing.
> 
> I.e. this feature seems like a candidate to be exposed by something like
> by a ls-remote flag if you'd like to do an init/config/fetch. AFAIK the
> only way to do it is to mock a "clone" with GIT_TRACE_PACKET or get the
> information out-of-bounds.

I think the situation is better than that. We are surfacing the remote
HEAD here, and there is already a command for copying that to our local
tracking symref: "git remote set-head origin -a", which will set up
refs/remotes/origin/HEAD.

I think there are two ways we could improve that further:

  - making it more natural to pick up or update the remote HEAD via
    fetch; Felipe's patches to git-fetch look good to me

  - it might be nice to be able to have some equivalent to the dwim "git
    checkout foo" that creates a new "foo" based off of origin/foo.
    Doing "git checkout origin/HEAD" will detach the HEAD. I think right
    now you'd have to do something like:

      tracking=$(git symbolic-ref refs/remotes/origin/HEAD)
      branch=${tracking#refs/remotes/origin/}
      git checkout -b $branch $tracking

    Or maybe not. It's not something people probably need to do a lot.
    And if the point is to have plumbing commands that can do the same,
    then maybe those commands are sufficient.

-Peff
