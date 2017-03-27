Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7607620958
	for <e@80x24.org>; Mon, 27 Mar 2017 01:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbdC0BLs (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 21:11:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:52171 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751743AbdC0BLr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 21:11:47 -0400
Received: (qmail 30536 invoked by uid 109); 27 Mar 2017 01:11:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Mar 2017 01:11:42 +0000
Received: (qmail 20438 invoked by uid 111); 27 Mar 2017 01:11:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Mar 2017 21:11:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Mar 2017 21:11:40 -0400
Date:   Sun, 26 Mar 2017 21:11:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/7] PREVIEW: Introduce DC_AND_OPENSSL_SHA1 make flag
Message-ID: <20170327011140.icqfc4lqlarvae6l@sigill.intra.peff.net>
References: <cover.1490397869.git.johannes.schindelin@gmx.de>
 <xmqq7f3d6ev1.fsf@gitster.mtv.corp.google.com>
 <20170326061826.yx6nh3k2ps6uyyz6@sigill.intra.peff.net>
 <xmqqinmv4ojt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqinmv4ojt.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 26, 2017 at 04:16:06PM -0700, Junio C Hamano wrote:

> > I don't think this case really matters for collision detection. What's
> > important is what Git does when it receives a brand-new packfile that
> > would overwrite an existing one. It _should_ keep the old one, under the
> > usual "existing data wins" rule.
> 
> If a malicious site can craft two packfiles that hash to the same,
> then it can first feed one against a fetch request, then feed the
> other one when a later fetch request comes, and then the later pack
> is discarded by the "existing data wins" rule.  Even though this
> later pack may have all the objects necessary to complete the refs
> this later fetch request asked for, and an earlier pack that
> happened to have the same pack trailer hash doesn't have these
> necessary objects, the receiver ends up discarding this necessary
> pack.  The end result is that the receiver's repository is now
> corrupt, lacking some objects.

No, I don't think so. We don't trust the trailer hash for anything to do
with corruption; we actually inflate the objects and see which ones we
got. So the victim will notice immediately that what the attacker sent
it is insufficient to complete the fetch (or push), and will refuse to
update the refs. The fetch transfer, but nobody gets corrupted.

Or another way to think about it: we don't care what the trailer hash
is. It comes from the untrusted attacker in the first place. So this
attack is no different than the other side just sending a bogus pack
that omits an object (but has a valid checksum).  The fact that it
happens to use the same on-disk name as something we already have is
irrelevant. We'll still notice that we don't have everything we need to
update the refs.

So the best you could do is probably a mini-DoS. Something like:

  0. Attacker generates two colliding packs, A and B. Only pack B has
     object X.

  1. Somehow, the attacker convinces upstream to take history with X
     _and_ to repack such that serving a fetch will yield pack B.

  2. You fetch from the attacker, who feeds you A.

  3. Now you fetch from upstream, who tries to send you B. You refuse
     it, thinking you already have it (but you really have A). The fetch
     fails because you are missing X.

That situation persists until either you repack (at which point you no
longer have A, unless your repack happens to generate the exact same
pack again!), or upstream history moves (or is repacked), causing them
to send a different pack.

I think arranging for (1) is exceedingly unlikely, and the fact that
your investment in (0) is lost the moment either the victim or the
upstream changes a single bit makes it an unlikely attack.

> I highlighted this case as notable because the way the trailing hash
> is also used as the name of packfile makes this fall into the same
> category as object hash, in that the hash is used for identification
> and deduplication (because we have a rule that says there can be
> only one _thing_ that hashes to one value), for which we do want to
> use the collision-attack detecting kind of hashing, even though it
> otherwise should fall into the other category (i.e. use of csum-file
> API to compute trailer hash), where the hash is used merely for
> bit-flip detection (we are perfectly OK if you have multiple index
> files with different contents that happen to have the same hash in
> the trailer, because the hash is not used for identificaiton and
> deduplication).

If we really wanted to address this (and I remain unconvinced that it's
worth caring about), the simplest thing is not to do collision
detection, but simply to give the packs a less predictable name. There
is nothing at all that cares about the filenames beyond the syntactic
"pack-[0-9a-f]{40}.pack", and it does not need to match the trailer
checksum (and as you know, we switched it recently without ill effect).

So we could literally just switch to writing out pack-$x.pack, where $x
is something like the 160-bit truncated sha-256, and the readers would
be none the wiser.

-Peff
