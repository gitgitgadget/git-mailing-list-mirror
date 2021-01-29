Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73272C433E6
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 22:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1228364DE2
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 22:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhA2Wp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 17:45:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:40978 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232590AbhA2WoR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 17:44:17 -0500
Received: (qmail 4424 invoked by uid 109); 29 Jan 2021 22:43:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 22:43:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10271 invoked by uid 111); 29 Jan 2021 22:43:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jan 2021 17:43:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jan 2021 17:43:32 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 03/10] builtin/pack-objects.c: learn
 '--assume-kept-packs-closed'
Message-ID: <YBSPlO/ki5vRNX0T@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <2da42e9ca26c9ef914b8b044047d505f00a27e20.1611098616.git.me@ttaylorr.com>
 <xmqqk0rwtom2.fsf@gitster.c.googlers.com>
 <YBRfvZh86Z8wAnxZ@coredump.intra.peff.net>
 <xmqq35yjtrip.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq35yjtrip.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 29, 2021 at 12:30:38PM -0800, Junio C Hamano wrote:

> > I think this would generally happen if the .keep packs are generated
> > using something like "git repack -a", which packs everything reachable
> > together. So if you do:
> >
> >   git repack -ad
> >   touch .git/objects/pack/pack-whatever.keep
> >   ... some more packs come in, perhaps via pushes ...
> >   # imagine repack knew how to pass this along...
> >   git repack -a --assume-kept-packs-closed
> >
> > then you'd repack just the objects that aren't in the big pack.
> 
> Yeah.  As a tool to help the above workflow, where you are only
> creating another .keep out of youngest objects (i.e. those that are
> either loose or in non-kept packs), because by definition anything
> in .keep cannot be pointing back at these younger objects, it does
> make sense to take advantage of "the set of packs with .keep as a
> whole is closed".
> 
> It may become tricky once we start talking about creating a new
> .keep out of youngest objects PLUS a few young keep packs, though.

Right. You'd have to make sure the younger packs were also created with
that reachability in mind. I.e., if you are in a situation where you've
got:

  - a big "old" pack
  - N new packs from pushes

then you can't assume anything about the reachability for those
individual N packs. It would be wrong to split any of them into the
"keep" side. They need to have all their objects traversed until we hit
something in the old pack.

But if you have a situation with:

  - a big "old" pack
  - M packs made from previous rollups on top of the old pack
  - N new packs from pushes

Then I think you can still take the old pack + the M packs as a
cohesive unit closed under reachability.

The tricky part is knowing which packs are which (size is a heuristic,
but it can be wrong; people may make a big push to a previously-small
repository).

> Starting from all on-disk .keep packs, you'd mark them as in-core
> keep bit, then drop in-core keep bit from the few young keep packs
> that you intend to coalesce with the youngest objects---that is how
> I would imagine your repacking strategy would go.  The set of all
> the on-disk .keep packs may give us "closed" guarantee, but if we 
> exclude a few latest packs from that set, would the remainder still
> give us the "closed" guarantee we can take advantage of, in order to
> pack these youngest objects (including the ones in the kept packs
> that we are coalescing)?

Yeah, I think we are going along the same lines. Except I think it is
dangerous to use on-disk ".keep" as your marker, because we will racily
see incoming push packs with a ".keep" (which receive-pack/index-pack
use as a lockfile until the refs are updated).

So repack has to "somehow" get the list of which is which.

None of which is disputing your "it may become tricky", of course. ;) It
is exactly this trickiness that I am worried about. And I am not being
coy with "somehow", as if we have some custom not-yet-shared layer on
top of repack that tracks this. We are still figuring out whether this
is a good direction in the first place. :)

One of the things that led us to this reachability traversal, away from
"just suck up all of the objects from these packs", is that this is how
--unpacked works. I had always assumed it was implemented as "if it's
loose, then put it in the pack". But it's not. It's attached to the
revision traversal. And it actually gets some cases wrong!

It will walk every commit, so you don't have to worry about a packed
commit referring to an unpacked one. But it doesn't look at the trees of
the packed commits (for the quite obvious reason that doing so is orders
of magnitude more expensive). That means that if there is a packed
commit that refers to an unpacked blob (which is not referenced by an
unpacked commit), then "rev-list --unpacked" will not report it (and
likewise "git repack -d" would not pack it).

It's easy to create such a situation manually, but I've included a
more plausible sequence involving "--amend" and push/fetch unpackLimit
at the end of this email.

At the core, --unpacked is assuming certain things about reachability of
loose/packed objects that aren't necessarily true. And this
--assume-kept-pack-closed stuff is basically doing the same thing for a
particular set of packs (albeit more so; I believe the patches here cut
off traversal of parent pointers, not just commit-to-tree pointers).

One of the reasons I think nobody noticed with --unpacked is that the
stakes are pretty low. If our assumption is wrong, the worst case is
that a loose object remains unpacked in "repack -d". But we'd never
delete it based on that information (instead, git prune would do its own
traversal to find the correct reachability). And it would eventually get
picked up by "git repack -ad".

But for repacking, the general strategy is to put things you want to
keep into the new pack, and then delete the old ones (not marked as
keep, of course). So if our assumption is ever wrong, it means we'd
potentially drop packs that have reachable objects not found elsewhere,
and we'd end up corrupting the repository.

So I think the paths forward are either:

  - come up with an air-tight system of making sure that we know packs
    we claim are closed under reachability really are (perhaps some
    marker that says "I was generated by repack -a")

  - have a "roll-up" mode that does not care about reachability at all,
    and just takes any objects from a particular set of packs (plus
    probably loose objects)

I'm still thinking aloud here, and not really sure which is a better
path. I do feel like the failure modes for the second one are less
risky.

Anyway, here's the --unpacked example, if you're curious. It's based on
fetching, but you could invert it to do pushes (in which case it is
repacking in "parent" that gets the wrong result).

-- >8 --
# two repos, one a clone of the other
git init parent
git -C parent commit --allow-empty -m base
git clone parent child

# now there's a small fetch, which will get
# exploded into loose objects.
(
	cd parent
	echo small >small
	git add small
	git commit -m small
)
git -C child fetch

# We can verify that "rev-list --unpacked" reports these
# objects.
git -C child rev-list --objects --unpacked origin

# and now a bigger one that will remain a pack (we'll
# tweak unpackLimit instead of making a really big commit,
# but the concept is the same)
#
# There are two key things here:
#
#   - the "small" commit is no longer reachable, but the big one
#     still contains the "small" blob object. Using --amend is
#     a plausible mechanism for this happening.
#
#   - we are using bitmaps, which give us an exact answer for the set of
#     objects to send. Otherwise, pack-objects on the server actually
#     fails to notice the other side has told us it has the small blob, and
#     sends another copy of it.
(
	cd parent
	git repack -adb
	echo big >big
	git add big
	git commit --amend -m big
)
git -C child -c fetch.unpackLimit=1 fetch

# So now in the child we have a packed object
# whose ancestor is an unpacked one. rev-list
# now won't report the "small" blob (ac790413).
git.compile -C child rev-list --objects --unpacked origin

# Even though we can see that it's present only as an
# unpacked object.
show_objects() {
	for i in child/.git/objects/pack/*.idx; do
		git show-index <$i
	done | cut -d' ' -f2 | sed 's/^/packed: /'
	find child/.git/objects/??/* |
		perl -F/ -alne 'print " loose: $F[-2]$F[-1]"'
}

# If we were to do an incremental repack now, it wouldn't be packed.
# (Note we have to kill off the reflog, which still references the
# rewound commit).
rm -rf child/.git/logs
git -C child repack -d
show_objects
