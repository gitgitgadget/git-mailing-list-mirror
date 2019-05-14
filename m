Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4CF31F461
	for <e@80x24.org>; Tue, 14 May 2019 09:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfENJrc (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 05:47:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:56620 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726130AbfENJrb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 05:47:31 -0400
Received: (qmail 3233 invoked by uid 109); 14 May 2019 09:47:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 May 2019 09:47:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11104 invoked by uid 111); 14 May 2019 09:48:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 May 2019 05:48:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 May 2019 05:47:29 -0400
Date:   Tue, 14 May 2019 05:47:29 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-server-info: avoid needless overwrites
Message-ID: <20190514094729.GA12256@sigill.intra.peff.net>
References: <20190511013455.5886-1-e@80x24.org>
 <87v9ygwoj0.fsf@evledraar.gmail.com>
 <20190512040825.GA25370@sigill.intra.peff.net>
 <87tve0w3ao.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tve0w3ao.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 12, 2019 at 09:16:31AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > You're probably right (especially because we'd just spent O(n) work
> > generating the candidate file). But note that I have seen pathological
> > cases where info/refs was gigabytes.
> 
> Wouldn't those users be calling update-server-info from something like a
> post-receive hook where they *know* the refs/packs just got updated?
>
> Well, there is "transfer.unpackLimit" to contend with, but that's just
> for "packs are same", not "refs are same", and that file's presumably
> much smaller.

Yeah, I think there's sort of an open question here of who is calling
update-server-info when nothing got updated. I think the only place we
call it automatically is via receive-pack, but I'd guess Eric runs it as
part of public-inbox scripts.

I agree that this is probably mostly about info/packs. Not every push
(or repo update) will create one, but every push _should_ be changing a
ref (if it succeeds at all).  And I'd guess Eric's interest comes from
the use of Git in public-inbox, which is going to make frequent but
small updates.

So this does seem like a really niche case; it avoids one single HTTP
request of a small that should generally be small (unless you're letting
your pack list grow really big, but I think there are other issues with
that) in a case that we know will generate a bunch of other HTTP traffic
(if somebody updated the server info, there was indeed a push, so you'd
get a refreshed info/refs and presumably the new loose objects).

That said, the logic to preserve the mtime is pretty straightforward, so
I don't mind it too much if Eric finds this really improves things for
him.

> > I don't think our usual dot-locking is great here. What does the
> > race-loser do when it can't take the lock? It can't just skip its
> > update, since it needs to make sure that its new pack is mentioned.
> 
> Right, I mean a *global* .git/I_AM_DOING_WRITES.lock, because there's no
> way to square the ref backend's notion of per-ref ref lock enabling
> concurrent pushes with update-server-info's desire to generate metadata
> showing *all* the refs.

OK. I agree that would work, but it's nasty to delay user-initiated
operations for ongoing maintenance (another obvious place to want such a
lock is for pruning, which can take quite a while).

> > So it has to wait and poll until the other process finishes. I guess
> > maybe that isn't the end of the world.
> 
> If "its" is update-server-info this won't work. It's possible for two
> update-server-info processes to be racing in such a way that their
> for_each_ref() reads a ref at a given value that'll be updated 1
> millisecond later, but to then have that update's update-server-info
> "win" the race to update the info files (hypothetical locks on those
> info files and all).
> 
> Thus the "info" files will be updated to old values, since we'll see we
> need changes, but change things to the old values.
> 
> All things that *can* be dealt with in some clever ways, but I think
> just further proof nobody's using this for anything serious :)
> 
> I.e. the "commit A happened before B" but also "commit B's post-* hooks
> finished after A" is a thing that happens quite frequently (per my
> logs).

I think it would work because any update-server-info, whether from A or
B, will take into account the full current repo state (and we don't look
at that state until we take the lock). So you might get an interleaved
"A-push, B-push, B-maint, A-maint", but that's OK. A-maint will
represent B's state when it runs.

> > I'm not entirely sure of all of the magic that "stale" check is trying
> > to accomplish. I think there's some bits in there that try to preserve
> > the existing ordering, but I don't know why anyone would care (and there
> > are so many cases where the ordering gets thrown out that I think
> > anybody who does care is likely to get disappointed).
> 
> My reading of it is that it's premature optimization that can go away
> (and most of it has already), for "it's cheap" and "if not it's called
> from the 'I know I had an update'" hook case, as noted above.<

That's my reading, too, but I didn't want to be responsible for
regressing some obscure case. At least Eric seems to _use_
update-server-info. ;)

-Peff
