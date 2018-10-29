Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC5D1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 23:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbeJ3ISj (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 04:18:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:60134 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725819AbeJ3ISj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 04:18:39 -0400
Received: (qmail 8494 invoked by uid 109); 29 Oct 2018 23:27:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Oct 2018 23:27:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25131 invoked by uid 111); 29 Oct 2018 23:26:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Oct 2018 19:26:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2018 19:27:39 -0400
Date:   Mon, 29 Oct 2018 19:27:39 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Jansen, Geert" <gerardu@amazon.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
Message-ID: <20181029232738.GC24557@sigill.intra.peff.net>
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
 <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
 <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
 <20181027093300.GA23974@sigill.intra.peff.net>
 <87lg6jljmf.fsf@evledraar.gmail.com>
 <20181029150453.GH17668@sigill.intra.peff.net>
 <87bm7clf4o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bm7clf4o.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 08:36:07PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > Yeah, especially given recent advances in SHA-1 attacks, I'm not super
> > comfortable with the idea of disabling the duplicate-object check at
> > this point.
> 
> I'd be comfortable with it in my setup since it's been limited to
> collision attacks that are computationally prohibitive, and there being
> no sign of preimage attacks, which is the case we really need to worry
> about.

I agree, and I'm not actually that worried about the current state. But
what makes me more nervous is the life-cycle around Git. In 5 years,
people are still going to be running what we ship today, and will
grumble about upgrading to deal with SHA-1.

I suppose it's not the end of the world as long as they can un-flip a
config switch to get back the more-paranoid behavior (which is all that
you're really proposing).

> It does introduce a race condition where you can introduce a colliding
> object to the repository by doing two concurrent pushes, but as you note
> in
> https://public-inbox.org/git/20181029151842.GJ17668@sigill.intra.peff.net/
> this already applies to packs, so you can trigger that with the right
> sized push (depending on transfer.unpackLimit), and we also have this in
> existing forms for other stuff.

Right. It can also trigger currently if somebody runs "git repack"
simultaneously (the loose becomes packed, but we don't re-scan the pack
directory).

> I do think it's amazingly paranoid to be worried about SHA-1 collisions
> in the first place, and a bit odd to leave the door open on these race
> conditions. I.e. it's hard to imagine a state-level[1] actor with
> sufficient motivation to exploit this who wouldn't find some way to make
> the race condition work as an escape hatch.

Yeah, I agree there's an element of that. I think the "push twice
quickly to race" thing is actually not all that interesting, though. In
that case, you're providing both the objects already, so why not just
push the one you want?

What's more interesting is racing with the victim of your collision (I
feed Junio the good half of the collision, and then try to race his
push and get my evil half in at the same time). Or racing a repack. But
timing the race there seems a lot trickier.

I suspect you could open up the window substantially by feeding your
pack really slowly. So I start to push at 1pm, but trickle in a byte at
a time of my 1GB pack, taking several hours. Meanwhile Junio pushes, and
then as soon as I see that, I send the rest of my pack. My index-pack
doesn't see Junio's push because it started before.

And ditto with repack, if the servers runs it predictably in response to
load.  So maybe not so tricky after all.

I think the other thing that helps here is that _everybody_ runs the
collision check. So yeah, you can race pushing your evil stuff to my
server. But it only takes one person fetching into their quiescent
laptop repository to notice the collision and sound the alarm.

I'll admit that there's a whole lot of hand-waving there, for a security
claim. I'll be glad to simply move off of SHA-1.

> In a busy repo that gets a lot of branches / branch deletions (so not
> quite as extreme as [2], but close) and the default expiry policy you
> can easily have 20-100K loose objects (something near the lower bound of
> that is the current live state of one server I'm looking at).
> 
> A recursive opendir()/readdir() on that on local disk is really fast if
> it's in cache, but can easily be 1-5 seconds on NFS. So for a push we'd
> now pay up to 5s just populating a cache we'll bearly use to accept some
> tiny push with just a few objects.

That 1-5 seconds is a little scary. Locally for a million objects I was
looking at 400ms. But obviously NFS is going to be much worse.

I do agree with your sentiment below that even if this should be on by
default, it should have a config knob. After all, "please flip this
switch and see if things improve" is a good escape hatch to have.

>  * Re-roll my 4 patch series to include the patch you have in
>    <20181027093300.GA23974@sigill.intra.peff.net>

I don't think it's quite ready for inclusion as-is. I hope to brush it
up a bit, but I have quite a backlog of stuff to review, as well.

-Peff
