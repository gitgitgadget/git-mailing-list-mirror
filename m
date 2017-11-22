Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A37320954
	for <e@80x24.org>; Wed, 22 Nov 2017 22:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753199AbdKVWgR (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 17:36:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:38092 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753146AbdKVWgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 17:36:16 -0500
Received: (qmail 5582 invoked by uid 109); 22 Nov 2017 22:36:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Nov 2017 22:36:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5265 invoked by uid 111); 22 Nov 2017 22:36:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 22 Nov 2017 17:36:32 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Nov 2017 17:36:14 -0500
Date:   Wed, 22 Nov 2017 17:36:14 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] sha1_file: don't re-scan pack directory for null sha1
Message-ID: <20171122223613.GA1405@sigill>
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
 <20171120203523.c3pt5qi43e24ttqq@sigill.intra.peff.net>
 <xmqqd14cjr13.fsf@gitster.mtv.corp.google.com>
 <20171121225744.GA21197@sigill>
 <xmqqwp2jxf5l.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwp2jxf5l.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 10:42:30AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm not sure what the right behavior is, but I'm pretty sure that's not
> > it. Probably one of:
> >
> >   - skip updating the ref when we see the breakage
> >
> >   - ditto, but terminate the whole operation, since we might be deleting
> >     other refs and in a broken repo we're probably best to make as few
> >     changes as possible
> >
> >   - behave as if it was a non-ff, which would allow "--force" to
> >     overwrite the broken ref. Maybe convenient for fixing things, but
> >     possibly surprising (and it's not that hard to just delete the
> >     broken refs manually before proceeding).
> 
> Perhaps the last one would be the ideal endgame, but the second one
> may be a good stopping point in the shorter term.

This turns out to be a lot trickier than I expected. The crux of the
matter is that the case we care about is hidden inside
lookup_commit_reference_gently(), which doesn't distinguish between
corruption and "not a commit".

So there are four cases we care about for this call in fetch:

  1. We fed a real sha1 and got a commit (or peeled to one).

  2. We fed a real sha1 which resolved to a non-commit, and we got NULL.

  3. We fed a real sha1 and the object was missing or corrupted, and we
     got NULL.

  4. We fed a null sha1 and got NULL.

Right now we lump cases 2-4 together as "do not do a fast-forward
check". That's fine for 2 and 4, but probably not for 3. We can easily
catch case 4 ourselves (if we care to), but distinguishing case 3 from
the others is hard. How should lookup_commit_reference_gently() signal
it to us?

Or should lookup_commit_reference_gently() die on corruption? That's not
very "gentle", but I think the "gently" here is really about "it might
not be a commit", not "the repo might be corrupted". But I think even
that may be the tip of the iceberg. The next thing we do is feed the
commits to in_merge_bases(), which will happily return "nope" if the old
commit cannot be parsed (because it has only a boolean return value).

So I dunno. Maybe it is a losing battle to try to pass this kind of
corruption information up the stack.  I'm tempted to say that there
should just be a "paranoid" flag to globally die() whenever we see a
corruption (and you could run with it normally, but relax it whenever
you're investigating a broken repo). But I doubt even that works. Not
having the "old_oid" object at all would be a repo corruption here, but
how are the low-level routines supposed to know when a missing object is
a corruption and when it is not?

-Peff
