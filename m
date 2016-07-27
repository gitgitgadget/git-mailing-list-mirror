Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1283A1F855
	for <e@80x24.org>; Wed, 27 Jul 2016 21:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758547AbcG0VNm (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 17:13:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:50145 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752275AbcG0VNl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 17:13:41 -0400
Received: (qmail 8794 invoked by uid 102); 27 Jul 2016 21:13:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 17:13:42 -0400
Received: (qmail 20975 invoked by uid 107); 27 Jul 2016 21:14:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 17:14:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2016 17:13:38 -0400
Date:	Wed, 27 Jul 2016 17:13:38 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: break out of want_object loop early
Message-ID: <20160727211338.GA20608@sigill.intra.peff.net>
References: <20160725184938.GA12871@sigill.intra.peff.net>
 <20160725185010.GA12974@sigill.intra.peff.net>
 <xmqqeg6h5w60.fsf@gitster.mtv.corp.google.com>
 <20160725214113.GA13589@sigill.intra.peff.net>
 <xmqqbn1l4c87.fsf@gitster.mtv.corp.google.com>
 <20160725221411.GA14131@sigill.intra.peff.net>
 <xmqqshuwyw14.fsf@gitster.mtv.corp.google.com>
 <20160726204851.GA22353@sigill.intra.peff.net>
 <xmqqr3agxep7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr3agxep7.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 26, 2016 at 02:38:28PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I got side-tracked by adding a t/perf test to show off the improvement.
> > It's rather tricky to get right and takes a long time to run. I _think_
> > I have it now, but am waiting for results. :)
> 
> Well, then I'd stop here and wait for the reroll to requeue.

So I hoped to follow up with my little perf-testing patch last night,
but the rabbit hole goes deeper. :)

It turns out that I could not replicate my earlier results using a perf
script like the one below. The problem is that it heavily depends on the
ordering of your packs. The early-break does not do any good if you
mostly end up finding your objects in the final pack in the list. And
that is the exact situation my perf script creates: imagine you had a
big repository, then 1000 pushes came in, and then you tried to run "git
repack". We sort reverse-chronologically, so the big pack is at the end,
and most lookups have to go through the entire pack list to get there.

In the normal object-lookup paths, we cache the last_found_pack and
check it first, but this loop has no equivalent (and until now it
wouldn't have helped much, because we generally had to walk the whole
list anyway).

I knew this was a potential issue and even had experimented this back
when the original patches were written, but in my experiments then it
didn't help much. That makes sense, though; any case that _was_ improved
by the first two patches would not benefit from reordering the pack
lookups, because that meant it was finding the objects early in the
search (or else the first two patches would have helped not at all).

And I think the particular case I was experimenting on back then was not
a normal "oops, we had some pushes and forgot to run gc". It was more
bizarre, and had several packs that had most of the objects duplicated.

So I think this is an area worth looking into; a series of small
incremental packs on top of a large one is what I would expect to be
the most common case, and the first two patches don't handle it well.

I tried a hacky version of the last_found_pack trick, and it does cut
the counting phase in half for my perf test. But no patch yet. One is
just that doing it cleanly is a little tricky. But two is that I've
wondered if we can do even better with a most-recently-used cache
instead of the last_pack_found hack. So I'm trying to implement and
measure that (both for this loop, and to see if it does better in
find_pack_entry).

Perf script below is just for a sneak peek at what I'm trying to
measure.

-Peff

-- >8 --
#!/bin/sh

test_description='performance with large numbers of packs'
. ./perf-lib.sh

test_perf_large_repo

# Pretend we just have a single branch and no reflogs, and that everything is
# in objects/pack; that makes our fake pack-building in the next step much
# simpler.
test_expect_success 'simplify reachability' '
	tip=$(git rev-parse --verify HEAD) &&
	git for-each-ref --format="option no-deref%0adelete %(refname)" |
	git update-ref --stdin &&
	rm -rf .git/logs &&
	git update-ref refs/heads/master $tip &&
	git symbolic-ref HEAD refs/heads/master &&
	git repack -ad
'

# A real many-pack situation would probably come from having a lot of pushes
# over time. We don't know how big each push would be, but we can fake it by
# just walking the first-parent chain and having each commit be its own "push".
# This isn't _entirely_ accurate, as real pushes would have some duplicate
# objects due to thin-pack fixing, but it's a reasonable approximation.
#
# And then all of the rest of the objects can go in a single packfile that
# represents the state before any of those pushes (actually, we'll generate
# that first because in such a setup it would be the oldest pack, and we sort
# the packs by reverse mtime inside git).
#
# We prepare this in a staging area, because we need to install our baseline
# set of packs for each iteration of the perf test (which unfortunately counts
# against their times, but is a limitation of the perf framework).
test_expect_success 'create a large number of packs' '
	mkdir staging &&

	pushes() {
		git rev-list --first-parent -1000 HEAD
	} &&
	pack() {
		git pack-objects --revs --delta-base-offset staging/pack
	} &&

	bottom=$(pushes | tail -n 1) &&
	echo "$bottom^" | pack &&

	pushes |
	while read rev
	do
		printf "%s\n^%s^" $rev $rev | pack ||
			return 1
	done &&

	setup_many_packs () {
		rm -f .git/objects/pack/* &&
		cp staging/* .git/objects/pack/
	} &&
	setup_many_packs
'

test_perf 'rev-list' '
	git rev-list --objects --all
'

test_perf 'full repack' '
	setup_many_packs &&
	git repack -ad
'

test_done
