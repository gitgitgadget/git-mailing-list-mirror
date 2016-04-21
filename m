From: Jeff King <peff@peff.net>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 14:05:07 -0400
Message-ID: <20160421180507.GA12950@sigill.intra.peff.net>
References: <20160421113004.GA3140@aepfle.de>
 <87lh473xic.fsf@linux-m68k.org>
 <CA+55aFx8hPKKcuwe-HHoO7LHVYLmJ6khndd-OtQotMs3EJzZ0w@mail.gmail.com>
 <xmqqzismsxsu.fsf@gitster.mtv.corp.google.com>
 <20160421170815.GA10783@sigill.intra.peff.net>
 <CA+55aFyadCxX_Ws5fUC0QXwYYyaAjC5TC=y+tVA+YUHX1o+-iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:05:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atIyc-0007X1-Kx
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 20:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbcDUSFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 14:05:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:53714 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752810AbcDUSFL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 14:05:11 -0400
Received: (qmail 21992 invoked by uid 102); 21 Apr 2016 18:05:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 Apr 2016 14:05:10 -0400
Received: (qmail 11620 invoked by uid 107); 21 Apr 2016 18:05:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 Apr 2016 14:05:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Apr 2016 14:05:07 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFyadCxX_Ws5fUC0QXwYYyaAjC5TC=y+tVA+YUHX1o+-iQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292138>

On Thu, Apr 21, 2016 at 10:23:10AM -0700, Linus Torvalds wrote:

> > which is technically true, but kind of painful to read. It may be that a
> > reasonable weight is somewhere between "1" and "65535", though.
> 
> Based on my tests, the "right" number is somewhere in the 500-1000
> range for this particular case. But it's still a completely made up
> number.

Yeah, exactly. I think if we're going to tweak the weight heuristic it
would be worth choosing a random sample of commits throughout history
and seeing how they look with various weights.

> > However, I think the more fundamental confusion with git-describe is
> > that people expect the shortest distance to be the "first" tag that
> > contained the commit, and that is clearly not true in a branchy history.
> 
> Yeah.
> 
> And I don't think people care *too* much, because I'm sure this has
> happened before, it's just that before when it happened it wasn't
> quite _so_ far off the expected path..

I think about once a year somebody complains to the list that
git-describe chose a bad name. I don't know how many confused users it
takes to muster one complain to the list, though. ;)

> > I actually think most people would be happy with an algorithm more like:
> >
> >   1. Find the "oldest" tag (either by timestamp, or by version-sorting
> >      the tags) that contains the commit in question.
> 
> Yes, we might want to base the "distance" at least partly on the age
> of the base commits.

I had actually meant my (1) and (2) to be part of the same algorithm.
That is, to literally* do a two-pass check over the history, where first
we find the "best" tag, and then compute the distance from that tag. The
first concern trumps the latter completely.

* Where "literally" only means that's the conceptual model. We probably
  could do it in one pass if we're clever, but it would behave as if
  we made the two passes.

Another way to find the "oldest" tag that I didn't mention is to find
all containing tags, and then eliminate any that contain another tag
(similar to the way we cull duplicate merge bases). That gives you an
answer based on the topology, which is more robust than timestamps or
tag names. But it doesn't necessarily provide a single answer, so you'd
still have to break ties with timestamps or name-sorting.

> >   2. Find the "simplest" path from that tag to the commit, where we
> >      are striving mostly for shortness of explanation, not of path (so
> >      "~500" is way better than "~20^2~30^2~14", even though the latter
> >      is technically a shorter path).
> 
> Well, so the three different paths I've seen are:
> 
>  - standard git (65536), and 1000:
>    aed06b9 tags/v4.6-rc1~9^2~792
> 
>  - non-first-parent cost: 500:
>    aed06b9 tags/v3.13-rc7~9^2~14^2~42
> 
>  - non-first parent cost: 1:
>    aed06b9 tags/v3.13~5^2~4^2~2^2~1^2~42
> 
> so there clearly are multiple valid answers.
> 
> I would actually claim that the middle one is the best one - but I
> claim that based on your algorithm case #1. The last one may be the
> shortest actual path, but it's a shorter path to a newer tag that is a
> superset of the older tag, so the middle one is actually not just
> better based on age, but is a better choice based on "minimal actual
> history".

Yeah, I'd agree the middle one is the best one, because the other tags
contain -rc7. Finding the best tag is much more important than the path
distance, because that's the part that humans read and care about. The
rest is mostly machine-readable to find the exact commit, so we want any
path that's accurate, and not too cumbersome to look at or cut and
paste (and obviously shorter path is better, too).

I actually think the best name for aed06b9 is probably:

  v3.13-rc1~65^2^2~42

which I found by picking the oldest tag from "git tag --contains" and
plugging it into "git describe --match". Sadly, neither git's internal
version-sorting nor GNU's "sort -V" knows that "v1.0-rc1" comes before
"v1.0", so I had to rely on "--sort=taggerdate".

-Peff
