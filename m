Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4787FC433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 12:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2989061105
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 12:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhKKMKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 07:10:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:57428 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232318AbhKKMJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 07:09:59 -0500
Received: (qmail 32742 invoked by uid 109); 11 Nov 2021 12:07:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Nov 2021 12:07:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28839 invoked by uid 111); 11 Nov 2021 12:07:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Nov 2021 07:07:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Nov 2021 07:07:09 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.34.0-rc2
Message-ID: <YY0HbQJEWbOwuuFj@coredump.intra.peff.net>
References: <xmqq4k8kzuz2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4k8kzuz2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 09, 2021 at 04:59:29PM -0800, Junio C Hamano wrote:

>  * The revision traversal API has been optimized by taking advantage
>    of the commit-graph, when available, to determine if a commit is
>    reachable from any of the existing refs.

I was thinking a bit about this change, specifically f45022dc2f
(connected: do not sort input revisions, 2021-08-09). At the time, Junio
said[1]:

  Sorting of positive side is done to help both performance and
  correctness in regular use of the traversal machinery, especially
  when reachability bitmap is not in effect, but on the negative side
  I do not think there is any downside to omit sorting offhand.  The
  only case that may get affected is when the revision.c::SLOP kicks
  in to deal with oddball commits with incorrect committer timestamps,
  but then the result of the sorting isn't to be trusted anyway, so...

But wouldn't failure to sort the commits actually _create_ such an
"oddball commits" scenario, because we'd see the UNINTERESTING commits
in an arbitrary order, especially with respect to the interesting ones?

I wondered if there were cases where this would change the output of the
command, and came up with this:

-- >8 --
git init -q repo
cd repo

# make a commit whose timestamp is offset from an arbitrary start point
# by $1 days. That gives us a deterministic commit ordering with no
# chance of any time-based slop.
commit_at() {
	base=1234567890
	unit=86400
	timestamp="@$((base + $1 * unit)) +0000" \
	GIT_COMMITTER_DATE=$timestamp \
	GIT_AUTHOR_DATE=$timestamp \
	git commit --allow-empty -qm "commit at day $1"
	git tag day-$1
}
commit_at 1
commit_at 2
commit_at 3
commit_at 4
commit_at 5
commit_at 6
commit_at 7
commit_at 8
commit_at 9
commit_at 10

# We ask to see day-1 and day-10, but the limit_list() traversal
# should drop day-1 as an ancestor of the others. There are two
# important things about the negative revisions:
#
#  - there are more than 5 of them, which will run out the SLOP counter
#
#  - we don't include ^day-2, as that could cause us to directly mark
#    its parent day-1 as UNINTERESTING
#
# Obviously this command line is contrived, but you could get the same
# inputs from a "rev-list $new_stuff --not --all" connectivity check,
# depending on where refs were pointing and what names they had.
tips='day-1 day-10 ^day-9 ^day-8 ^day-7 ^day-6 ^day-5 ^day-4'

# Now we can compare the sorted/unsorted inputs. I used "log" here just
# to make the output easier to understand.
git log --oneline $tips >expect
git log --oneline --unsorted-input $tips >actual
diff -u expect actual
-- >8 --

And the output I get is:

  --- expect	2021-11-11 06:50:22.148050216 -0500
  +++ actual	2021-11-11 06:50:22.152050263 -0500
  @@ -1 +1,2 @@
  +027d297 commit at day 1
   1dc264f commit at day 10

So indeed, we get confused by the unsorted input and give the wrong
answer. We should look at and propagate UNINTERESTING marks from day-9,
etc on down to day-1, but we don't.

Now in this case, we're sending too much output, which is OK for the
purposes of the connectivity check. It will just walk day-1 and its
tree unnecessarily, which is a performance loss but not incorrect.

My intuition is that this is _probably_ the only type of incorrect
answer we'd give (i.e., that we'd never go the other way, omitting an
object we should have included) because nobody would ever set the
UNINTERESTING flag unnecessarily, and everybody_uninteresting() does do
a full scan looking for any positive tips.

Still, I didn't see this subtlety mentioned in the earlier discussion,
and it's a bit alarming not to understand all of the possible
implications. I'm not sure if it rises to the level of something we want
to consider more or address before the release. Sorry to only come up
with this at the -rc2 stage, but I figure now is better than right after
the release. ;)

-Peff

[1] https://lore.kernel.org/git/xmqqa6lzwu31.fsf@gitster.g/
