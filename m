From: Jeff King <peff@peff.net>
Subject: Re: Re-Transmission of blobs?
Date: Tue, 24 Sep 2013 03:36:13 -0400
Message-ID: <20130924073613.GC7257@sigill.intra.peff.net>
References: <xmqqsixcy395.fsf@gitster.dls.corp.google.com>
 <20130911112758.GB14259@raven.wolf.lan>
 <xmqqsixbth4h.fsf@gitster.dls.corp.google.com>
 <20130912074241.GC14259@raven.wolf.lan>
 <20130912092339.GA30702@sigill.intra.peff.net>
 <20130912103531.GD14259@raven.wolf.lan>
 <20130912194453.GD32069@sigill.intra.peff.net>
 <20130913100934.GE14259@raven.wolf.lan>
 <20130916215536.GB5477@sigill.intra.peff.net>
 <20130920092715.GG14259@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 24 09:36:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VONAU-000517-3s
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 09:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340Ab3IXHgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 03:36:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:53967 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724Ab3IXHgR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 03:36:17 -0400
Received: (qmail 7731 invoked by uid 102); 24 Sep 2013 07:36:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Sep 2013 02:36:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Sep 2013 03:36:13 -0400
Content-Disposition: inline
In-Reply-To: <20130920092715.GG14259@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235280>

On Fri, Sep 20, 2013 at 11:27:15AM +0200, Josef Wolf wrote:

> > Yes. If you know that the receiver has commit X, and you want to know if
> > it has some blob Y, the only way to know for sure is to look at every
> > tree of every commit reachable from X, and see whether any of them
> > references Y.
> 
> Jeff, in my original example, I did a cherry-pick from origin/somebranch.

Sorry, I thought we were talking about the general case, not your
specific example.

> Even without asking, we can assume with great probability that
> origin/somebranch is available at origin.

Bear in mind that the transfer process does not know about
cherry-picking at all. It only sees the other side's tips and traverses.

> And the file in question happens to reside in the tree at the very tip
> of origin/somebranch, not in some of its ancestors. In this case,
> there's no need to search the history at all. And even in this pretty
> simple case, the algorithm seems to fail for some reason.

Correct. And in the current code, we should be looking at the tip tree
for your case.  However, the usual reason to do so is to mark those
objects as a "preferred base" in pack-objects for doing deltas. I wonder
if we are not correctly noticing the case that an object is both
requested to be sent and marked as a preferred base (in which case we
should drop it from our sending list).

If that's the problem, it should be easy to fix cheaply. It would not
work in the general case, but it would for your specific example. But
since it costs nothing, there's no reason not to.

I'll see if I can investigate using the example script you posted.

> > Yes, you do not have to recurse into sub-trees (or commits) you have
> > already seen. And we already do that optimization.
> 
> Why is the file re-transmitted, then?

I meant "we do the optimization during history traversal that avoids
going into sub-trees we have already seen". We do _not_ do the full
history traversal for a partial push.

> With a little change in the protocol, a very simple optimization could be
> implemented, avoiding the complicated bitmap strategy you were talking about:
> [...]
> In the last step, instead of sending a packfile, the sending side should send
> a list of the SHA's which would be included in this packfile. The receiving
> side would then be able to request all the objects it needs to get up-to-date.

I think you have a mis-impression of the problem bitmaps are trying to
solve, mostly because it is not the problem you presented in your
thread (but your problem is one that bitmaps can help).

Consider what the sending side has to do to come up with that list of
objects to send. It has to traverse history to do it, looking at each
tree of each commit that is going to be sent. That effort is
proportional to the amount of history we are going to send. For a small
push or fetch, it is not much. For a clone, it can be quite a lot (tens
of seconds of CPU time per clone). Bitmaps drastically reduce the amount
of CPU required.

Bitmaps can _also_ solve other problems, like letting us be more
thorough in realizing which objects the other side has (without spending
effort on an expensive traversal). If that were the only thing they did,
it might not be worth it. But we basically get that for "free" by
solving the other problem.

So I do not think such a protocol extension is an argument against
pack bitmaps; you would want them with or without the protocol change.

> I think this change would be considerably simpler than the reachability bitmap
> you are talking about. And it would avoid all those time consuming traversals
> through the history and the tree. And it would omit _all_ redundant
> retransmissions. Even in the case when sender and receiver do not have _any_
> common heads at all, _no_ files at all would be retransmitted unnecessarily.

Yes, that would be nice. However, in the common cases it would make
things much worse. A clone of linux.git has ~3.5M objects. That's 70MB
of sha1s that the server tells the client "tell me which of these you
need", and then another 70MB for the client to say "yep, I need all of
them".  You could have the client instead say "here are the few I
_don't_ need", which would save the second half in the common cases.

And of course it would be smaller for a smaller fetch/push. Just looking
at "git rev-list --objects --all --since=1.week.ago" in the kernel,
there are ~77K new objects. So over the course of a week, we use an
extra 1.5MB of bandwidth. How many objects did we save ourselves from
sending, and how big were they (keep in mind they will typically be
deltas against object you already have anyway)?

The answer would depend on your cherry-picking and reverting habits. But
I would guess in a normal workflow that you would not come close to
breaking even.

There are, of course, cases where the user _knows_ there is a huge
object that the other side has, and they do not want to have to send it
again. For that case, it would be useful to have something like the
protocol you described as an optional extension to turn on. Of course,
somebody has to implement it. :)

-Peff
