From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Speed up git tag --contains
Date: Wed, 6 Jul 2011 02:40:12 -0400
Message-ID: <20110706064012.GA927@sigill.intra.peff.net>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 08:40:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeLmZ-0002VO-5C
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 08:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568Ab1GFGkQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 02:40:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51141
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150Ab1GFGkP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 02:40:15 -0400
Received: (qmail 16291 invoked by uid 107); 6 Jul 2011 06:40:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Jul 2011 02:40:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jul 2011 02:40:12 -0400
Content-Disposition: inline
In-Reply-To: <1307819051-25748-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176641>

[+cc people who were interested in earlier iterations of this topic]

On Sat, Jun 11, 2011 at 07:04:07PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> This is a resubmission of Jeff King's patch series to speed up git ta=
g
> --contains with some changes. It's been cooking for a while as:

Thanks for resurrecting this. I've been meaning to look at it again, an=
d
somehow an entire year has passed. I've tried to refresh my memory on
the issues, so hopefully I can make coherent comments.

There have been a few responses in the meantime, and one I want to
address is Junio's:

  http://article.gmane.org/gmane.comp.version-control.git/152765

The major points in it are (I'm paraphrasing for brevity, but please
correct me if I'm misrepresenting):

  1. A depth-first algorithm has the problem of going down to the roots
     unnecessarily.

Yes, and that's why with my initial patch, "tag --contains" is on the
same order of time as "git rev-list --tags >/dev/null" (in the worst
case). But with the early return based on commit timestamp, we stop
looking down uninteresting paths early. So the downside isn't speed, bu=
t
trusting commit timestamps.

  2. One solution is to use merge-bases to find earlier cutoff points.

It's possible. But doesn't the merge bases algorithm, like all of the
commit walking, rely somewhat on commit timestamps, too? For example,
this thread shows issues with revision limiting:

  http://thread.gmane.org/gmane.comp.version-control.git/72274

I'm not sure about the merge bases algorithm, though. In the face of
skew, I think it can go down a non-optimal path (e.g., going all the wa=
y
to the root because one branch has commits skewed to look much older
than they really are, which pushes them to the back of the commit_list
priority queue). But I think it will still find the correct answer.

Two problems with doing a merge-base solution are:

  a. It can still end up hitting the roots, or close to them. The
     merge-base of something recent and a tag from years ago is going
     to have to go through years of history. So using a timestamp cutof=
f
     is really nice to know that there's no point in digging (on the
     other hand, searching for something from years ago with respect to
     recent tags will always have to dig through all of that history;
     however, I think this is less common than the other way around).

  b. If you are doing the merge-base over many tags at once, it's hard
     to figure out which source tag is actually responsible for hitting
     the merge base.

Which leads us to Junio's final point:

  3. You can do something like show-branch does, and smudge each commit
     with a bitfield that has one bit per tag (e.g., using the object
     flags).

My problem with this is that it doesn't scale algorithmically with many
tags. If we have a constant number of bits, then that reduces the numbe=
r
of merge-base traversals we have to do by a constant number. Our
constant using the flags field would be 27. And reducing the time by a
factor of 27 is nice, but I suspect something like the 10K-tags example
is still going to be painful, if even one out of the 27 in each
traversal has dig far into history.

Another option is to trade space for time. Do one traversal, but
actually keep a large enough bitfield. For 10K tags, that's about 1K pe=
r
commit. So for git.git, that's 30M. For linux-2.6, it's 250M. Which is
getting pretty big. But remember that's an insane number of tags, and w=
e
can also move the slider between time and space (e.g., 5 traversals of
50M each).

> I've moved the relevant code from commit.[ch] to builtin/tag.c as
> Junio's comment suggested. So IMO the "tag: speed up --contains
> calculation" patch is ready to be applied.

The only downside to that is that the code is harder to reuse in "branc=
h
--contains", which could also benefit. I think the multiple merge-base
traversals tend not to be as bad, because branch tips tend to stay
recent, and you tend to ask for recent commits. So even though we dig
through the same commits multiple times, it all stays in recent history=
=2E
Whereas tags tend to point to very old things.

Still, that is dependent on your repo setup, including numbers of
branches and how stale they tend to be. It would be nice if we could
always be fast.

> The next two patches look OK to me, but they need some documentation
> for the core.clockskew variable, which perhaps should be renamed to
> tag.clockskew, or was the plan to use it for other things in the
> future?

It was intended to be used elsewhere. I have a patch to use it in
name-rev, which currently just has a hard-coded skew.

The problem with a skew variable like this is that you really don't wan=
t
to set it higher than a day or so. Because it affects all parts of the
traversal, not just the parts near the skewed commits. In linux-2.6, fo=
r
example, the worst skew is about 100 days. Here are timings for "git ta=
g
--contains HEAD~200" with various core.clockskew values:

  - no clock skew tolerated: .035s
  - 1 day: .034s
  - 100 days of clock: .252s
  - infinite: 5.373s

So we are almost an order of magnitude slower by having set an
appropriate clockskew value. And that's only for 100 days. Some of the
projects have skew on the order of years.

If we can assume that the skewed commits are relatively rare[1], we
might do better to mark individual skewed commits via notes or the
replace mechanism. A simple test shows that doing notes lookups is not
too expensive:

  # pretend we have some fake timestamps
  for i in 20 40 60; do
    git notes add -m "fake timestamp" HEAD~$i
  done

  (best of 5)
  $ time git log --pretty=3Draw --no-notes >/dev/null
  real    0m3.868s
  user    0m3.796s
  sys     0m0.060s

  (best of 5)
  $ time git log --pretty=3Draw --show-notes >/dev/null
  real    0m3.878s
  user    0m3.812s
  sys     0m0.052s

And then any code wanting to limit traversal would have to check the
notes to see if the timestamp was valid (in fact, we would do even fewe=
r
lookups, since we only need to check for a bogus timestamp at the edges
of our traversal).

The replace mechanism could be used instead; it has the advantage that
we wouldn't even need to change the traversal code; it would just see
the corrected objects with the right timestamp, and has similar
performance characteristics.

[1] The numbers from Jonathan and Clemens show that in most repos, the
numbers of skewed commits tend to be small (single-digits usually, or
even in the dozens; but much fewer than the total number of commits).

> Is the "Why is "git tag --contains" so slow?" utility something we
> want?

As it is now, I don't think so. Tweaking core.clockskew is slow, as
shown above. And it's not something people should have to do manually. =
I
have a version, which I'll post in a minute, which actually fills in a
notes tree with the sha1 of commits with bogus timestamps. And then
that tree can be consulted accurately and automatically.

However, if we're going to have a look-aside cache of metadata on each
commit, maybe it is really time to stop thinking about commit timestamp=
s
and start thinking about "generation numbers". This concept has been
brought up before on the list; it's basically:

  1. Root commits have generation =3D 0.

  2. Other commits have generation =3D 1 + max(generations of parents).

So it's a strictly increasing number, and you know that, given X > Y, X
cannot possibly be an ancestor of Y.

If this were stored in the commit object, we could use it for all
traversals instead of the commit timestamp, and it would presumably be
more reliable (you could still have a bogus repo, of course, but it
would come from a bug in git, not from importing old history or having
your clock set wrong).

The problem is that existing objects don't have this generation number.
It's easy to calculate, though, and we could in theory use a notes-cach=
e
to store it externally. Obviously the complexity and performance aren't
going to be as good as if it were just in the commit object, but we're
sadly 6 years too late to make that decision.

-Peff
