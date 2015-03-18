From: Jeff King <peff@peff.net>
Subject: Re: git pull & git gc
Date: Wed, 18 Mar 2015 17:04:58 -0400
Message-ID: <20150318210458.GA3376@peff.net>
References: <5509836D.2020304@aegee.org>
 <CACsJy8ChKgwr5OBRDG1p5nxwPC0vei7J=Lr3NefLYoReTMuhPA@mail.gmail.com>
 <55098A49.1020003@aegee.org>
 <CACsJy8AtoeSv7uZc3P2xXN0A15gpj-OUTRyNhMe__=HqtTkD2Q@mail.gmail.com>
 <CACsJy8DCdF1YmfFF1aCuhMJ0v4+FW7EkDiwBnBF2OFhE=kcbFg@mail.gmail.com>
 <20150318145815.GN1369@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	=?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>, Git Mailing List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:05:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYL9J-0006Hw-NN
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 22:05:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473AbbCRVFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 17:05:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:34840 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750719AbbCRVFB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 17:05:01 -0400
Received: (qmail 32531 invoked by uid 102); 18 Mar 2015 21:05:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 16:05:00 -0500
Received: (qmail 6980 invoked by uid 107); 18 Mar 2015 21:05:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 17:05:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Mar 2015 17:04:58 -0400
Content-Disposition: inline
In-Reply-To: <20150318145815.GN1369@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265756>

On Wed, Mar 18, 2015 at 02:58:15PM +0000, John Keeping wrote:

> On Wed, Mar 18, 2015 at 09:41:59PM +0700, Duy Nguyen wrote:
> > On Wed, Mar 18, 2015 at 9:33 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > > If not, I made some mistake in analyzing this and we'll start again.
> > 
> > I did make one mistake, the first "gc" should have reduced the number
> > of loose objects to zero. Why didn't it.?  I'll come back to this
> > tomorrow if nobody finds out first :)
> 
> Most likely they are not referenced by anything but are younger than 2
> weeks.
> 
> I saw a similar issue with automatic gc triggering after every operation
> when I did something equivalent to:
> 
> 	git add <lots of files>
> 	git commit
> 	git reset --hard HEAD^
> 
> which creates a log of unreachable objects which are not old enough to
> be pruned.

Yes, this is almost certainly the problem. Though to be pedantic, the
command above will still have a reflog entry, so the objects will be
reachable (and packed). But there are other variants that don't leave
the objects reachable from even reflogs.

I don't know if there is an easy way around this. Auto-gc's object count
is making the assumption that running the gc will reduce the number of
objects, but obviously it does not always do so. We could do a more
thorough check and find the number of actual packable and prune-able
objects. The "prune-able" part of that is easy; just omit objects from
the count that are newer than 2 weeks. But "packable" is expensive. You
would have to compute reachability by walking from the tips. That can
take tens of seconds on a large repo.

You could perhaps cut off the walk early when you hit a packed commit
(this does not strictly imply that all of the related objects are
packed, but it would be good enough for a heuristic). But even that is
probably too expensive for "gc --auto".

-Peff

PS Note that in git v2.2.0 and up, prune will leave not only "recent"
   unreachable objects, but older objects which are reachable from those
   recent ones (so that we keep or prune whole chunks of history, rather
   than dropping part and leaving the rest broken). Technically this
   exacerbates the problem (we keep more objects), though I doubt it
   makes much difference in practice (most chunks of history were
   created at similar times, so the mtimes of the whole chunk will be
   close together).
