Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEF7C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 16:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C6B60174
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 16:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhKOQzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 11:55:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:59140 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232229AbhKOQzq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 11:55:46 -0500
Received: (qmail 13544 invoked by uid 109); 15 Nov 2021 16:52:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Nov 2021 16:52:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12618 invoked by uid 111); 15 Nov 2021 16:52:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Nov 2021 11:52:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 15 Nov 2021 11:52:45 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.34.0-rc2
Message-ID: <YZKQXYdemZCNS/Bz@coredump.intra.peff.net>
References: <xmqq4k8kzuz2.fsf@gitster.g>
 <YY0HbQJEWbOwuuFj@coredump.intra.peff.net>
 <xmqqwnlemwcy.fsf@gitster.g>
 <YY17rBFIdDl+H47I@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YY17rBFIdDl+H47I@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 11, 2021 at 03:23:09PM -0500, Jeff King wrote:

> Yes, I think that framing is right: it is making SLOP much worse. We
> could similarly have had bogus timestamps in those commits which would
> cause the same outcome. So in that sense it is nothing new. On the other
> hand, I wonder how often it will cause extra traversal work (keeping in
> mind that this commit traversal is just the first stage; after we find
> the commits, then we talk all of their trees, which is the more
> expensive part).
> 
> For the case of adding new commits directly on top of another branch, I
> think there would be no change. But any time you have to walk down to a
> common fork point (e.g., imagine I made a new branch forked from an old
> bit of history), we may fail to find that. I haven't quite constructed
> an example, but I have a feeling we could end up walking over
> arbitrarily long segments of history.

I was playing around with this a bit more, and there is one subtlety in
the "day-10" snippet I showed that I hadn't noted before. It's important
the day-1 does not have any parents. If we used day-2 instead, then
limit_list() would insert its parent (day-1, in this case) into the
queue, without an UNINTERESTING flag (because it's the parent of
something interesting).  And thus when we call still_interesting(), we
would never decrement the slop counter, because we know we are still
walking back to something potentially interesting.

This "works" because we put the new commit at the end of the list via
commit_list_insert_by_date(). That can be fooled, of course, because
it's assuming the list is already in sorted order (which it isn't). So
there could be an "old" commit at the front, and we place the parent in
front of that, even though it's UNINTERESTING descendants are further
back in the list.

So I do think we could walk an arbitrary string of history in this way,
all the way down to the root, or to something else pointed to by a ref
tip. Here's the example I came up with:

-- >8 --
git init -q repo
cd repo

commit_at() {
	echo $1 >$1
	git add .
	base=1234567890
	unit=86400
	timestamp="@$((base + $1 * unit)) +0000"
	GIT_COMMITTER_DATE=$timestamp \
	GIT_AUTHOR_DATE=$timestamp \
	git commit -qm "commit at day $1"
}

# imagine a bunch of base history
for i in $(seq 100); do
	commit_at $i
done
git tag base

# And then we have some older branches hanging around.
for i in $(seq 1 10); do
	git checkout -b branch-$i base~$((60+$i))
done

# But also a newer one; it's important that this refname
# sort after the other ones, because that's what confuses
# the sorting.
git branch new-branch

# and then somebody pushes/fetches a branch based on an old part of history,
# newer than our old branches, but older than our new one.
#
# We won't actually create the branch here, because we're simulating the state
# before the ref is created, when we do the connectivity check.
old_commit=$(git rev-parse base~50)
new_commit=$(echo foo | git commit-tree -p $old_commit HEAD^{tree})

# and now here's the connectivity check we would do
git rev-list $new_commit --not --all >expect
git rev-list --unsorted-input $new_commit --not --all >actual
diff -u expect actual
-- >8 --

That will report all of base~60..base~50 in the output, when it should
just report the single new commit.

I don't think any of this changes the plan for the 2.34 release (in
fact, it makes me more confident that reverting this change was the
right thing to do). I'm just recording my notes here for revisiting the
topic later.

My suspicion is that there's no easy way to make this work. We're
violating the assumption in still_interesting() that it can easily find
the lowest-date commit. We could drop that assumption for the unsorted
case, but then I think we'd be forced to walk all the way to the root
commits, which is even worse than sorting the tips.

I suspect a better solution would be to make use of generation numbers
from the commit graph if we have them. The --topo-order stuff already
does this, and I kind of wonder if we could piggy-back on that.

-Peff
