Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BB1C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 00:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05B286102A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 00:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241393AbhIAAQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 20:16:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:35876 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240856AbhIAAQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 20:16:27 -0400
Received: (qmail 14729 invoked by uid 109); 1 Sep 2021 00:15:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Sep 2021 00:15:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 567 invoked by uid 111); 1 Sep 2021 00:15:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Aug 2021 20:15:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 31 Aug 2021 20:15:30 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>, ps@pks.im
Subject: Re: [PATCH v3 0/2] send_ref buffering
Message-ID: <YS7GItELaEM8lq2z@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADMWQoOfPr47a6bJtApt=wSE9BrgXQKJRfJuNAj0zbtio2BRHw@mail.gmail.com>
 <CADMWQoPerffQcTfKh3bfesjgHaBqXGzW2805knyRW3R_q4V-YA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 03:08:25PM +0200, Jacob Vosmaer wrote:

> > Does the 64k buffer actually improve things? Here are the timings I get
> > on a repo with ~1M refs (it's linux.git with one ref per commit).
> Thanks for challenging that. I have a repeatable benchmark where it
> matters, because each write syscall wakes up a chain of proxies
> between the user and git-upload-pack. Larger buffers means fewer
> wake-ups. But then I tried to simplify my example by having sshd as
> the only intermediary, and in that experiment 64K buffers were not
> better than 4K buffers. I think that goes to show that picking a good
> buffer size is hard, and we'd be better off picking one specifically
> for Gitaly (and GitLab) that works with our stack.

Thanks for explaining. Yeah, I think leaving it as a custom thing makes
sense, then.

> >   Summary
> >     'GIT_REF_PARANOIA=1 git.compile upload-pack .' ran
> >       2.17 ± 0.02 times faster than 'git.compile upload-pack .'
> >
> > It's not exactly the intended use of that environment variable, but its
> > side effect is that we do not call has_object_file() on each ref tip.
> That is nice to know, but as a user of Git I don't know when it is or
> is not safe to skip those has_object_file() calls. If it's safe to
> skip them then Git should skip them always. If not, then I will err on
> the side of caution and keep the checks.

Yeah, the use of REF_PARANOIA there was just an easy illustration. IMHO
it would be reasonable for upload-pack to just assume that the refs
files are valid. If they aren't, then either:

  - the receiver is uninterested in those objects or already has them,
    so won't ask for them. They're happy either way.

  - the receiver _will_ ask for them, at which point we'd barf later in
    pack-objects when we try to access them.

There are some thoughts in this old thread which introduce
GIT_REF_PARANOIA:

  https://lore.kernel.org/git/20150317073730.GA25267@peff.net/

I think I was mostly too cowardly to make the change back then. And I
hadn't considered that the performance implications would be all that
big (though I will say this million-ref repo is at the edge of what I'd
consider reasonable).

> > > I do think it would be nice to take the packet_writer
> > > interface further (letting it replace the static buf, and use stdio
> > > handles, and using it throughout upload-pack).
> > I would like that too, for the sake of neatness and general
> > performance, but I don't have the time to take on a larger project
> > like that at the moment.
> I gave solving the problem with packet_writer a couple of hours today.
> The diff gets too big, and I have too little confidence I'm not
> introducing deadlocks. This really is more work than I can chew off
> right now. Sorry!

Thanks for taking a look! I think we can proceed with your series for
now, then.

-Peff
