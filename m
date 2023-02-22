Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0FCC636D6
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 19:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjBVT0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 14:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjBVT02 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 14:26:28 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBB138654
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 11:25:59 -0800 (PST)
Received: (qmail 14636 invoked by uid 109); 22 Feb 2023 19:25:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Feb 2023 19:25:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10465 invoked by uid 111); 22 Feb 2023 19:25:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Feb 2023 14:25:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Feb 2023 14:25:10 -0500
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     Elijah Newren <newren@gmail.com>, Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
Message-ID: <Y/ZsFuTKyfR+AQy5@coredump.intra.peff.net>
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
 <CABPp-BE6EA+vXLXJtn8CHO9pHJgLH_uh7_t7AYBRN2gAAA5C+Q@mail.gmail.com>
 <CAJoAoZm+TkCL0Jpg_qFgKottxbtiG2QOiY0qGrz3-uQy+=waPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJoAoZm+TkCL0Jpg_qFgKottxbtiG2QOiY0qGrz3-uQy+=waPg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2023 at 02:06:55PM -0800, Emily Shaffer wrote:

> > Does removing memory leaks also mean converting UNLEAK to free()?
> 
> I suspect so - as I understand it, UNLEAK is a macro that resolves to
> "don't complain to me, compiler, I meant not to free it."

Correct. It is supposed to be used sparingly at the outermost level to
say "I'm about to exit, so yes, we are leaking this, but no, it does not
matter".

So...

> > Thinking of things in a library context probably pushes us in that
> > direction (though, alternatively, it might just highlight the question
> > of what is considered "low-level" instead).
> 
> I'm not sure whether use of UNLEAK has so much to do with "low-level"
> or not. In cases when Git is being called as an ephemeral single-run
> process, UNLEAK makes a lot of sense. In cases when Git is being
> called in a long-lived process, UNLEAK is just a sign that says
> "there's a leak here".  So I think the distinction is not low-level or
> high-level, but more simply, within a library or not.

I'd take "low-level" here to mean "far down in the call stack". That is,
code which is called potentially from a lot of places, and can't know
what is going to happen afterwards.

In that case, such code calling UNLEAK() is already doing the wrong
thing. And such code is a likely candidate for being called in a
lib-ified long-running process, which means that ignoring the leaks is
likely to be more noticeable. :)

There are probably cases where code that is currently high-level becomes
more low-level, and will need to be adapted. For example, if cmd_diff()
has a static-local helper function for "diff these two blobs", and it
knows it will run it exactly once, it is OK to UNLEAK() from there now.
But that may be a reasonable API to expose more widely, at which point
it needs to stop UNLEAK()-ing and really free.

Just my two cents as the originator of UNLEAK(). :)

-Peff
