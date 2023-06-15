Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8295CEB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 07:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244080AbjFOH0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 03:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244665AbjFOH02 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 03:26:28 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653CEDF
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 00:26:27 -0700 (PDT)
Received: (qmail 20463 invoked by uid 109); 15 Jun 2023 07:26:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Jun 2023 07:26:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19618 invoked by uid 111); 15 Jun 2023 07:26:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Jun 2023 03:26:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Jun 2023 03:26:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jim Pryor <dubiousjim@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] diff: detect pathspec magic not supported by --follow
Message-ID: <20230615072625.GD1460739@coredump.intra.peff.net>
References: <20230601173724.GA4158369@coredump.intra.peff.net>
 <20230601174351.GC4165297@coredump.intra.peff.net>
 <xmqq4jnq9vee.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4jnq9vee.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 02, 2023 at 04:27:05PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The --follow code doesn't handle most forms of pathspec magic. We check
> > that no unexpected ones have made it to try_to_follow_renames() with a
> > runtime GUARD_PATHSPEC() check, which gives behavior like this:
> >
> >   $ git log --follow ':(icase)makefile' >/dev/null
> >   BUG: tree-diff.c:596: unsupported magic 10
> >   Aborted
> 
> Stepping back a bit, isn't the real reason why follow mode is
> incompatible with the pathspec magic because it does not want to
> deal with anything but a single literal pathname?

Sorry, I'm a little behind on list reading; I know this topic has
advanced almost to 'master' in the meantime, but I had a few thoughts
worth getting out.

Basically, yes, I agree with everything in your email. My series is more
or less papering over deficiencies in the --follow code, and that code
would be much better off thinking of single literal paths that it is
following.

I was trying with my series not to go down the rabbit hole of --follow
deficiencies. So in that sense, I think it is still a good idea for the
short-term. And though we might perhaps revert some of it if we actually
improve how --follow works, I don't think it would be too hard to do so
later. But of course if we are going to improve --follow _now_, then it
could replace my series.

And what you outlined here:

> For the above idea to work, I think we need to resolve the pathspec
> early; "log --follow" should find its starting point, apply the
> given pathspec to its treeish to grab the literal pathname, and use
> that single literal pathname as the literal pathspec and continue,
> which I do not think it does right now.  But with it done upfront,
> the pathspec limiting done during the history traversal, including
> try_to_follow_renames() bit, should be able to limit itself to "is
> the path literally the string given as the pathspec"?

seems mostly sensible to me, except that the notion of "starting point"
is ambiguous. If I do:

  git log --follow branch1 branch2 -- foo*

then we have two treeishes. Do we look at one? Both? What happens if the
pathspec resolves differently?

Off the top of my head, I'd say that we should look at all starting
tips, resolve the pathspec in all of them, and complain if it doesn't
resolve to the same single path in each one. Because it otherwise would
produce garbled results.

To be fair, this same garbled case already happens when traversing a
merge sends us down two paths of history, as a followed rename might be
present on one but not the other, and we keep only a single path. But as
you know, that is a long-time deficiency of --follow. :) At least
detecting it from the starting tips is easy and something the user can
deal with by modifying the command invocation.

So I dunno. That doesn't sound _too_ hard to do, though it probably also
needs a lot of the same infrastructure I introduced in my series. Namely
that log.follow needs to ask "hey, is this pathspec usable for
following?" so that it can quietly turn the feature off, rather than
triggering an error.

So I'd suggest to let my series continue graduating, and then if anybody
wants to work on more sensible pathspec handling, to do so on top.

-Peff
