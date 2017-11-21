Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F7B22036D
	for <e@80x24.org>; Tue, 21 Nov 2017 22:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbdKUW5r (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 17:57:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:36938 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751364AbdKUW5q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 17:57:46 -0500
Received: (qmail 4753 invoked by uid 109); 21 Nov 2017 22:57:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Nov 2017 22:57:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28600 invoked by uid 111); 21 Nov 2017 22:58:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 21 Nov 2017 17:58:02 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Nov 2017 17:57:44 -0500
Date:   Tue, 21 Nov 2017 17:57:44 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] sha1_file: don't re-scan pack directory for null sha1
Message-ID: <20171121225744.GA21197@sigill>
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
 <20171120203523.c3pt5qi43e24ttqq@sigill.intra.peff.net>
 <xmqqd14cjr13.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd14cjr13.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 11:37:28AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > In an ideal world, we'd simply fix all of the callers to
> > notice the null sha1 and avoid passing it to us. But a
> > simple experiment to catch this with a BUG() shows that
> > there are a large number of code paths.
> 
> Well, we can view this (or the alternative you sent later that does
> the same a bit earlier in the function) as "fixing the caller" but
> has already refactord the common logic to a helper function that all
> of these callers call into ;-).

Yes, I'm definitely tempted by that view. :)

What worries me, though, is that callers who lazily propagate the null
sha1 to the lookup functions cannot reasonably tell the difference
between "this object was corrupt or missing" and "we passed the null
sha1, and a missing object is expected".

For example, look at how fetch.c:update_local_ref() looks up objects.
It feeds the old and new sha1 to lookup_commit_reference_gently(), and
if either is NULL, it skips the fast-forward check. That makes sense if
we expect the null sha1 to get translated into a NULL commit. But it
also triggers for a broken ref, and we'd overwrite it (when the right
thing is probably refusing to update).

Here's a runnable example:

-- >8 --
git init parent
git -C parent commit --allow-empty -m base

git clone parent child
git -C parent commit --allow-empty -m more

cd child
rm -f .git/objects/??/*
git fetch
-- 8< --

That final fetch spews a bunch of errors about broken refs, and then
overwrites the value of origin/master, even though it's broken (in this
case it actually is a fast-forward, but the child repo doesn't even know
that).

I'm not sure what the right behavior is, but I'm pretty sure that's not
it. Probably one of:

  - skip updating the ref when we see the breakage

  - ditto, but terminate the whole operation, since we might be deleting
    other refs and in a broken repo we're probably best to make as few
    changes as possible

  - behave as if it was a non-ff, which would allow "--force" to
    overwrite the broken ref. Maybe convenient for fixing things, but
    possibly surprising (and it's not that hard to just delete the
    broken refs manually before proceeding).

-Peff
