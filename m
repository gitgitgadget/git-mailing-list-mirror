Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 191041F453
	for <e@80x24.org>; Mon, 29 Oct 2018 15:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeJ2Xx4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 19:53:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:59094 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726035AbeJ2Xx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 19:53:56 -0400
Received: (qmail 21932 invoked by uid 109); 29 Oct 2018 15:04:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Oct 2018 15:04:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18321 invoked by uid 111); 29 Oct 2018 15:04:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Oct 2018 11:04:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2018 11:04:53 -0400
Date:   Mon, 29 Oct 2018 11:04:53 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Jansen, Geert" <gerardu@amazon.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
Message-ID: <20181029150453.GH17668@sigill.intra.peff.net>
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
 <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
 <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
 <20181027093300.GA23974@sigill.intra.peff.net>
 <87lg6jljmf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lg6jljmf.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 27, 2018 at 01:22:16PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Taking one step back, the root problem in this thread is that stat() on
> > non-existing files is slow (which makes has_sha1_file slow).
> >
> > One solution there is to cache the results of looking in .git/objects
> > (or any alternate object store) for loose files. And indeed, this whole
> > scheme is just a specialized form of that: it's a flag to say "hey, we
> > do not have any objects yet, so do not bother looking".
> >
> > Could we implement that in a more direct and central way? And could we
> > implement it in a way that catches more cases? E.g., if I have _one_
> > object, that defeats this specialized optimization, but it is probably
> > still beneficial to cache that knowledge (and the reasonable cutoff is
> > probably not 1, but some value of N loose objects).
> [...]
> 
> The assumption with making it exactly 0 objects and not any value of >0
> is that we can safely assume that a "clone" or initial "fetch"[1] is
> special in ways that a clone isn't. I.e. we're starting out with nothing
> and doing the initial population, that's probably not as true in an
> existing repo that's getting concurrent fetches, commits, rebases etc.

I assume you mean s/that a clone isn't/that a fetch isn't/.

I agree there are cases where you might be able to go further if you
assume a full "0". But my point is that "clone" is an ambiguous concept,
and it doesn't map completely to what's actually slow here. So if you
only look at "are we cloning", then:

  - you have a bunch of cases which are "clones", but aren't actually
    starting from scratch

  - you get zero benefit in the non-clone cases, when we could be
    scaling the benefit smoothly

> But in the spirit of taking a step back, maybe we should take two steps
> back and consider why we're doing this at all.

OK, I think it's worth discussing, and I'll do that below. But first I
want to say...

> Three of our tests fail if we compile git like this, and cloning is much
> faster (especially on NFS):
> 
>     diff --git a/builtin/index-pack.c b/builtin/index-pack.c
>     index 2004e25da2..0c2d008ee0 100644
>     --- a/builtin/index-pack.c
>     +++ b/builtin/index-pack.c
>     @@ -796,3 +796,3 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
> 
>     -       if (startup_info->have_repository) {
>     +       if (0) {
>                     read_lock();
> 
> Even on a local disk I'm doing 262759 lstat() calls cloning git.git and
> spending 5% of my time on that.

With the caching patch I posted earlier, I see roughly the same speedup
on an index-pack of git.git as I do with disabling the collision check
entirely (I did see about a 1% difference in favor of what you wrote
above, which was within the noise, but may well be valid due to slightly
reduced lock contention).

TBH I'm not sure if any of this is actually worth caring about on a
normal Linux system, though. There stat() is fast. It might be much more
interesting on macOS or Windows, or on a Linux system on NFS.

> But why do we have this in the first place? It's because of 8685da4256
> ("don't ever allow SHA1 collisions to exist by fetching a pack",
> 2007-03-20) and your 51054177b3 ("index-pack: detect local corruption in
> collision check", 2017-04-01).
> 
> I.e. we are worried about (and those tests check for):
> 
>  a) A malicious user trying to give us repository where they have
>     created an object with the same SHA-1 that's different, as in the
>     SHAttered attack.
> 
>     I remember (but have not dug up) an old E-Mail from Linus saying
>     that this was an important security aspect of git, i.e. even if
>     SHA-1 was broken you couldn't easily propagate bad objects.

Yeah, especially given recent advances in SHA-1 attacks, I'm not super
comfortable with the idea of disabling the duplicate-object check at
this point.

>  b) Cases where we've ended up with different content for a SHA-1 due to
>     e.g. a local FS corruption. Which is the subject of your commit in
>     2017.

Sort of. We actually detected it before my patch, but we just gave a
really crappy error message. ;)

>  c) Are there cases where fetch.fsckObjects is off and we just flip a
>     bit on the wire and don't notice? I think not because we always
>     check the pack checksum (don't we), but I'm not 100% sure.

We'd detect bit-blips on the wire due to the pack checksum. But what's
more interesting are bit-flips on the disk of the sender, which would
then put the bogus data into the pack checksum they generate on the fly.

However, we do detect such a bit-flip, even without fsckObjects, because
the sender does not tell us the expected sha-1 of each object. It gives
us a stream of objects, and the receiver computes the sha-1's
themselves. So a bit flip manifests in the connectivity-check when we
say "hey, the other side should have sent us object X but did not" (we
do not say "gee, what is this object Y they sent?" because after not
seeing X, we do not know which objects would have been reachable, so we
have a whole bunch of such Y's).

fetch.fsckObjects is purely about doing semantic object-quality checks.
They're not even that expensive to do. The main reason they're disabled
is that there are many historical objects floating around that fail
them (I think it would be a useful exercise to sort the existing checks
by priority, downgrading many of them to warnings, and then setting the
default for fetch.fsckObjects to "reject anything above warning").

> Even if someone wants to make the argument that this is behavior that we
> absolutely *MUST* keep and not make configurable, there's still much
> smarter ways to do it.

I don't have any real object to a configuration like this, if people
want to experiment with it. But in contrast, the patch I showed earlier:

  - is safe enough to just turn on all the time, without the user having
    to configure anything nor make a safety tradeoff

  - speeds up all the other spots that use OBJECT_INFO_QUICK (like
    fetch's tag-following, or what appears to be the exact same
    optimization done manually inside mark_complete_and_common-ref()).

> We could e.g. just unconditionally write out the packfile into a
> quarantine environment (see 720dae5a19 ("config doc: elaborate on
> fetch.fsckObjects security", 2018-07-27)), *then* loop over the loose
> objects and packs we have and see if any of those exist in the new pack,
> if they do, do the current assertion, and if not (and fetch.fsckObjects
> passes) move it out of the quarantine.

Yes, I agree that would work, though it's a bigger architecture change.

-Peff
