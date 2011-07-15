From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 14:17:26 -0700
Message-ID: <CA+55aFx0KyAZRsy7gZ3Z4woWC-uWcLu11gcUrR+9MJR5NOSkrA@mail.gmail.com>
References: <20110714183710.GA26820@sigill.intra.peff.net> <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
 <20110714190844.GA26918@sigill.intra.peff.net> <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
 <20110714200144.GE26918@sigill.intra.peff.net> <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
 <20110714203141.GA28548@sigill.intra.peff.net> <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
 <20110715074656.GA31301@sigill.intra.peff.net> <CA+55aFzS3KDNvKt-dXvYpuAQwFwD3+GCj8y8bRQCycPvrynT8Q@mail.gmail.com>
 <20110715194807.GA356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 15 23:17:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhpll-0005ZK-Ba
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 23:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770Ab1GOVRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 17:17:52 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54685 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751226Ab1GOVRv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2011 17:17:51 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6FLHmNl028202
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 15 Jul 2011 14:17:49 -0700
Received: by wyg8 with SMTP id 8so1060994wyg.19
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 14:17:46 -0700 (PDT)
Received: by 10.216.237.131 with SMTP id y3mr909463weq.87.1310764666058; Fri,
 15 Jul 2011 14:17:46 -0700 (PDT)
Received: by 10.216.158.65 with HTTP; Fri, 15 Jul 2011 14:17:26 -0700 (PDT)
In-Reply-To: <20110715194807.GA356@sigill.intra.peff.net>
X-Spam-Status: No, hits=-102.888 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177235>

On Fri, Jul 15, 2011 at 12:48 PM, Jeff King <peff@peff.net> wrote:
>
> Having the information in two different places is my concern, too. And I
> think the fundamental difference between putting it inside or outside
> the commit sha1 (where outside encompasses putting it in a cache, in the
> pack-index, or whatever), is that I see the commit sha1 as somehow more
> "definitive". That is, it is the sole data we pass from repo to repo
> during pushes and pulls, and it is the thing that is consistency-checked
> by hashes.

Sure. That is also the data that is the same for everybody.

That's a big deal, in the sense that it's the only thing we should
rely on if we want consistent behavior. Immediately if core
functionality starts using any other data, behavior becomes "local".
And I think that's really *really* dangerous.

Sure, we have "local behavior" in a lot of small details. We very much
intentionally have it in the ref-logs, and since branches and tags are
local we also have it in things like "--decorate", which obviously
depends on exactly which local refs you have.

We also have local behavior in things like .git/config etc files, so
git can behave very differently for different people even with what is
otherwise an identical repository.

So local behavior is good and expected for some things. We *want* it
for things like colorization decisions, we want it for aliases, and we
want it for branch naming.

But really core behavior shouldn't depend on local information. I
think it would be wrong if something like a merge base decision would
be based on any local information.

For example, should it matter whether something is packed or not? I
really don't think so. That's a pretty random implementation detail,
and if we get different end results because some commit happens to be
packed, vs not packed (because, say, we'd be hiding generation
information in the pack) that would be wrong.

Now, we do have things like merge resolution caches etc (which
obviously do save and use local information again), but I think that's
pretty well clarified.

> So if there is an inconsistency between what the parent pointers
> represent, and what the generation number in "outside" storage says,
> then the outside storage is wrong, and the parent pointers are the right
> answer. It becomes a lot more fuzzy to me if there is an inconsistency
> between what the parent pointers represent, and what the generation
> number says.

So I really don't see why you harp on that. If the generation counters
are in the objects THEY BY DEFINITION CANNOT BE INCONSISTENT.

That's a big issue.

Sure, they may be LYING, but that's a different thing entirely. They
will be lying to everybody consistently. There would never be any
question about what the generation number of a commit is.

See what I'm trying to say? There's no way that they would cause
different behavior for different people. Everything is 100%
consistent.

The exact same thing is true of commit dates, btw. They may be
confused as hell, and they may cause us to do bad things when we
traverse the history, but different clocks on different machines will
still not cause git to act differently on different machines. There's
no possibility of inconsistency.

(Of course, different *versions* of git may traverse the history
differently, since we've changed the heuristics over time. So we do
have that kind of inconsistent behavior, where we give different
results from different versions of git).

And btw, having "incorrect" data in the git objects is not the end of
the world. You can generate merge commits that simply have the wrong
parents. That will be confusing as hell to the user, and it will make
future merges not work very well, but it's a bug in the archive, and
that's "ok". The developers may not be very happy about it. In fact,
afaik we've had a few cases like that in the kernel tree, because
early git had bugs where it would not properly forget parents after a
failed merge. Most of them are ARM-related, because the ARM tree was
one of the first users of git (outside of me, but I had fewer issues
with what happens when things go wrong).

So I would not be *too* shocked if we'd end up with "odd" generation
counts due to some odd bug. It sounds unlikely, but my point is that
that is not at all what I'd *worry* about.

> How should that situation be handled? Should fsck check for it and
> complain? Should we just ignore it, even though it may cause our
> traversal algorithms to be inaccurate? Like clock skew, there's not much
> that can be done if the commits are published.

Right. I simply think it's not a big deal.

IOW, if we would rely on generation counts instead of clock dates,
maybe the generation counts would have occasional problems too, but I
suspect they'd be *much* rarer than time-based issues, because at
least the generation count is a well-defined number rather than a
random thing we pick out of emails and badly maintained machines.

That said, I'm not 100% sure at all that we want generation numbers at
all. Their use is pretty limited. If we had had them from the
beginning, I think we would simply have replaced the date-based commit
list sorting with a generation-number-based one, and it should have
been possible to guarantee that we never output a parent before the
commit in rev-parse.

As it is, I have to admit that looking at it, I shudder at changing
the current date-based logic and replacing it with a "date or
generation number".

The date-based one, despite all its fuzziness and not being very well
defined ("Global clock in a distributed system? You're a moron") and
up being a *nice* heuristic for certain human interaction. So it's not
a wonderful solution from a technical standpoint, but it does have (I
think) some nice UI advantages.

(For an example of that: using "--topo-sort" for revision history may
be a very good thing technically, but even if it wasn't for the fact
that it's more expensive, I think that our largely time-based default
order for "git log" in many ways is a better interface for humans. Of
course, when mixed with actually giving a history graph, that changes,
because then you want the "related" commits to group together, rather
than by time. So I think it's just basically a fuzzy area, without any
clear hard rules - which is probably why using that fuzzy timestamp
works so well in practice)

> Those are serious questions that I think should be considered if we are
> going to put a generation header into the commit object, and I haven't
> seen answers for them yet.

I do agree that the really *big* question is "do we even need it at
all". I do like perhaps just tightening the commit timestamp rules.
Because I do think they would probably work very well for the
"contains" problem too.

With the exact same fuzzy downsides, of course. Timestamps aren't
perfect, and they need that annoying fuzz factor thing.

>> That said, I don't think a generation count necessarily "fits" in the
>> pack-file. They are designed to be incremental, so it's not very
>> natural there. But I do think it would be conceptually prettier to
>> have the "depth of commit" be part of the "filesystem" data than to
>> have it as a separate ad-hoc cache.
>
> Sure, I would be fine with that. When you say "packfile", do you mean
> the the general concept, as in it could go in the pack index as opposed
> to the packfile itself? Or specifically in the packfile? The latter
> seems a lot more problematic to me in terms of implementation.

I was thinking the "general" issue - it might make most sense to put
them in the index.
>> If we should have fixed it in the original specification, we damn well
>> should fix it today. It's been "ignorable" because it's just not been
>> important enough. But if git now adds a fundamental cache for them,
>> then that information is clearly no longer "not important enough".
>
> OK, so let's say we add generation headers to each commit. What happens
> next? Are we going to convert algorithms that use timestamps to use
> commit generations? How are we going to handle performance issues when
> dealing with older parts of history that don't have generations?

So I do think the _initial_ question need to be the other way around:
do we have to have generation numbers at all?

I think it's likely a design misfeature not to have them, but
considering that we don't, and have been able to make do without for
so long, I'm also perfectly willing to believe that we could speed up
"contains" dramatically with the same kind of (crazy and inexact)
tricks we use for merge bases.

(Looking at a profile, a third - and the top entry - of the "git tag
--contains" profile cost is just in "clear_commit_marks()" - not doing
any real work, rather *undoing* the work in order to re-do things. So
it's entirely possible that the real issue is simply that
"in_merge_bases()" is badly done, and we could speed things up a lot
independently of anything else).

For example, for the "git tag --contains" thing, what's the
performance effect of just skipping tags that are much older than the
commit we ask for?

                Linus
