From: Jeff King <peff@peff.net>
Subject: Re: git pull & git gc
Date: Thu, 19 Mar 2015 00:20:50 -0400
Message-ID: <20150319042050.GA29999@peff.net>
References: <5509836D.2020304@aegee.org>
 <CACsJy8ChKgwr5OBRDG1p5nxwPC0vei7J=Lr3NefLYoReTMuhPA@mail.gmail.com>
 <55098A49.1020003@aegee.org>
 <CACsJy8AtoeSv7uZc3P2xXN0A15gpj-OUTRyNhMe__=HqtTkD2Q@mail.gmail.com>
 <CACsJy8DCdF1YmfFF1aCuhMJ0v4+FW7EkDiwBnBF2OFhE=kcbFg@mail.gmail.com>
 <20150318145815.GN1369@serenity.lan>
 <20150318210458.GA3376@peff.net>
 <CACsJy8AJfx8id+oHmhsLODBJeNLgRqD+5B295TtS+c-hrC5raQ@mail.gmail.com>
 <20150319012722.GA26867@peff.net>
 <CACsJy8CUbe4-f4rpieAKYzHb4rpKg8JW+uXB5yA4c1HFG6r4dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>,
	=?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 05:21:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYRxL-0007kA-Oc
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 05:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbbCSEUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 00:20:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:35018 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750731AbbCSEUx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 00:20:53 -0400
Received: (qmail 32696 invoked by uid 102); 19 Mar 2015 04:20:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 23:20:53 -0500
Received: (qmail 9843 invoked by uid 107); 19 Mar 2015 04:21:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 00:21:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 00:20:50 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8CUbe4-f4rpieAKYzHb4rpKg8JW+uXB5yA4c1HFG6r4dg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265781>

On Thu, Mar 19, 2015 at 11:15:19AM +0700, Duy Nguyen wrote:

> On Thu, Mar 19, 2015 at 8:27 AM, Jeff King <peff@peff.net> wrote:
> > Keeping a file that says "I ran gc at time T, and there were still N
> > objects left over" is probably the best bet. When the next "gc --auto"
> > runs, if T is recent enough, subtract N from the estimated number of
> > objects. I'm not sure of the right value for "recent enough" there,
> > though. If it is too far back, you will not gc when you could. If it is
> > too close, then you will end up running gc repeatedly, waiting for those
> > objects to leave the expiration window.
> 
> And would not be hard to implement either. git-gc is already prepared
> to deal with stale gc.pid, which would stop git-gc for a day or so
> before it deletes gc.pid and starts anyway. All we need to do is check
> at the end of git-gc, if we know for sure the next 'gc --auto' is a
> waste, then leave gc.pid behind.

That omits the "N objects left over" information. Which I think may be
useful, because otherwise the rule is basically "don't do another gc at
all for X time units". That's OK for most use, but it has its own corner
cases. E.g., imagine you are doing an SVN import that does an auto-gc
check every 1000 commits. You have some unreferenced objects in your
repository. After the first 1000 commits, we do a gc, and then say "wow,
still a lot of cruft; let's block gc for a day". Five minutes later,
after another 1000 commits, we run "gc --auto" again. It doesn't run
because of the cruft-check, even though there are a _huge_ number of new
packable objects.

If the blocker file tells us "7000 extra objects" and we see that there
are 17,000 in the repo, then we know it's still worth doing the gc
(i.e., we know we that we'll probably end up ignoring the 7000 cruft
that didn't get cleaned up last time, but we also know that there are
10,000 new objects).

-Peff
