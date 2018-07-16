Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4356F1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 22:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbeGPXNK (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 19:13:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:48776 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728784AbeGPXNK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 19:13:10 -0400
Received: (qmail 20361 invoked by uid 109); 16 Jul 2018 22:43:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 22:43:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16695 invoked by uid 111); 16 Jul 2018 22:43:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 18:43:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 18:43:37 -0400
Date:   Mon, 16 Jul 2018 18:43:37 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716224337.GB12482@sigill.intra.peff.net>
References: <20180716185255.GC22298@sigill.intra.peff.net>
 <20180716190949.GB11513@aiede.svl.corp.google.com>
 <20180716194136.GA25189@sigill.intra.peff.net>
 <20180716195431.GD11513@aiede.svl.corp.google.com>
 <20180716202915.GC25189@sigill.intra.peff.net>
 <20180716203753.GE11513@aiede.svl.corp.google.com>
 <20180716210938.GF25189@sigill.intra.peff.net>
 <20180716214003.GH11513@aiede.svl.corp.google.com>
 <20180716214539.GL25189@sigill.intra.peff.net>
 <20180716220306.GI11513@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180716220306.GI11513@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 03:03:06PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > I don't think any command should report failure of its _own_ operation
> > if "gc --auto" failed. And grepping around the source code shows that we
> > typically ignore it.
> 
> Oh, good point.  In non-daemon mode, we don't let "gc --auto" failure
> cause the invoking command to fail, but in daemon mode we do.  That
> should be a straightforward fix; patch coming in a moment.

OK, that definitely sounds like a bug. I'm still confused how that could
happen, though, since from the caller's perspective they ignore git-gc's
exit code either way. I guess I'll see in your patch. :)

> > What I was trying to say earlier is that we _did_ build this
> > rate-limiting, and I think it is a bug that the non-daemon case does not
> > rate-limit (but nobody noticed, because the default is daemonizing).
> >
> > So the fix is not "rip out the rate-limiting in daemon mode", but rather
> > "extend it to the non-daemon case".
> 
> Can you point me to some discussion about building that rate-limiting?
> The commit message for v2.12.2~17^2 (gc: ignore old gc.log files,
> 2017-02-10) definitely doesn't describe that as its intent.

I think that commit is a loosening of the rate-limiting (because we'd
refuse to progress for something that was actually time-based). But the
original stopping comes from this discussion, I think:

  https://public-inbox.org/git/xmqqlhijznpm.fsf@gitster.dls.corp.google.com/

(I didn't read the whole thread, but that was what I hit by blaming the
log code and then tracing that back to the list).

> This is the kind of review that Dscho often complains about, where
> someone tries to fix something small but significant to users and gets
> told to build something larger that was not their itch instead.

I don't know how to say more emphatically that I am not asking anyone to
build something larger (like cruft packfiles). I'm just trying to bring
up an impact that the author didn't consider (and that IMHO would be a
regression). Isn't that what reviews are for?

I only mention packfiles because as the discussion turns to "well, all
of these solutions are mediocre hacks" (because they absolutely are),
it's important to realize that there _is_ a right solution, and we even
already know about it. Even if we don't work on it now, knowing that
it's there makes it easier to decide about the various hacks.

> The comments about the "Why is 'git commit' so slow?" experience and
> how having the warning helps with that are well taken.  I think we
> should be able to find a way to keep the warning in a v2 of this
> patch.  But the rest about rate-limiting and putting unreachable
> objects in packs etc as a blocker for this are demoralizing, since
> they gives the feeling that even if I handle the cases that are
> handled today well, it will never be enough for the project unless I
> solve the larger problems that were already there.

I really don't know why we are having such trouble communicating. I've
tried to make it clear several times that the pack thing is not
something I expect your or Jonathan Tan to work on, but obviously I
failed. I'd be _delighted_ if you wanted to work on it, but AFAICT this
patch is purely motivated by:

  1. there's a funny exit code thing going on (0 on the first run, -1 on
     the second)

  2. the warning is not actionable by users

I disagree with the second, and I think we've discussed easy solutions
for the first.

-Peff
