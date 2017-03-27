Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AA1120966
	for <e@80x24.org>; Mon, 27 Mar 2017 07:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbdC0HJb (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 03:09:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:52247 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751483AbdC0HJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 03:09:29 -0400
Received: (qmail 19354 invoked by uid 109); 27 Mar 2017 07:09:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Mar 2017 07:09:11 +0000
Received: (qmail 26972 invoked by uid 111); 27 Mar 2017 07:09:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Mar 2017 03:09:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Mar 2017 03:09:09 -0400
Date:   Mon, 27 Mar 2017 03:09:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/7] PREVIEW: Introduce DC_AND_OPENSSL_SHA1 make flag
Message-ID: <20170327070909.26ojhkhagf6pq3wp@sigill.intra.peff.net>
References: <cover.1490397869.git.johannes.schindelin@gmx.de>
 <xmqq7f3d6ev1.fsf@gitster.mtv.corp.google.com>
 <20170326061826.yx6nh3k2ps6uyyz6@sigill.intra.peff.net>
 <xmqqinmv4ojt.fsf@gitster.mtv.corp.google.com>
 <20170327011140.icqfc4lqlarvae6l@sigill.intra.peff.net>
 <xmqqbmsn2qyh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmsn2qyh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 26, 2017 at 11:07:02PM -0700, Junio C Hamano wrote:

> > No, I don't think so. We don't trust the trailer hash for anything to do
> > with corruption; we actually inflate the objects and see which ones we
> > got. So the victim will notice immediately that what the attacker sent
> > it is insufficient to complete the fetch (or push), and will refuse to
> > update the refs. The fetch transfer, but nobody gets corrupted.
> 
> In the scenario I was presenting, both the original fetch that gives
> one packdata and the later fetch that gives another packdata (which
> happens to share the csum-file trailing checksum) satisfy the "does
> the new pack give us enough objects to really complete the tips of
> refs?" check.

Right, my point was that we do that check _after_ throwing away the
duplicate-named pack. So you cannot fool that check, update the ref, and
then throw away the pack to get a corrupt receiver. The receiver throws
away the pack first, then says "hey, I don't have all the objects" and
aborts.

That said...

> The second fetch transfers, we validate the packdata using index-pack
> (we may pass --check-self-contained-and-connected and we would pass
> --strict if transfer-fsck is set), we perhaps even store it in
> quarantine area while adding it to the list of in-core packs, make
> sure everything is now connected from the refs using pre-existing
> packs and this new pack.  The index-pack may see everything is good
> and then would report the resulting pack name back to
> index_pack_lockfile() called by fetch-pack.c::get_pack().

These are interesting corner cases. We only use
--check-self-contained-and-connected with clones, but you may still have
packs from an alternate during a clone (although I think the two packs
would be allowed to co-exist indefinitely, then).

The quarantine case is more interesting. The two packs _do_ co-exist
while we do the connectivity check there, and then afterwards we can
have only one. So that reversal of operations introduces a problem, and
you could end up with a lasting corruption as a result.

> But even though both of these packs _are_ otherwise valid (in the
> sense that they satisfactorily transfer objects necessary to make
> the refs that were fetched complete), because we name the packs
> after the trailer hash and we cannot have two files with the same
> name, we end up throwing away the later one.

I kind of wonder if we should simply allow potential duplicates to
co-exist. The pack names really aren't used for duplicate suppression in
any meaningful sense. We effectively use them as UUIDs so that each new
pack gets a unique name without having to do any locking or other
coordination. It would not be unreasonable to say "oops, 1234abcd
already exists; I'll just increment and call this new one 1234abce". The
two presumably-the-same packs would then co-exist until the new "repack
-a" removes duplicates (not just at the pack level, but at the object
level).

The biggest problem there is that "claiming" a pack name is not
currently atomic. We just do it blindly. So switching to some other
presumed-unique UUID might actually be easier (whether SHA-256 of the
pack contents or some other method).

> As I said, it is a totally different matter if this attack scenario
> is a practical threat.  For one thing, it is probably harder than
> just applying the straight "shattered" attack to create a single
> object collision--you have to make two packs share the same trailing
> hash _and_ make sure that both of them record data for valid
> objects.  But I am not convinced that it would be much harder
> (e.g. I understand that zlib deflate can be told not to attempt
> compression at all, and the crafted garbage used in the middle part
> of the "shattered" attack can be such a blob object expressed as a
> base object--once the attacker has two such packfiles that hash the
> same, two object names for these garbage blobs can be used to
> present two versions of the values for a ref to be fetched by these
> two fetch requests).

Yeah, I think we can assume it will be possible with SHAttered levels of
effort. An attacker can use it to create a persistent corruption by
having somebody fetch from them twice. So not really that interesting an
attack, but it is something. I still think that ditching SHA-1 for the
naming is probably a better fix than worrying about SHA-1 collisions.

-Peff
