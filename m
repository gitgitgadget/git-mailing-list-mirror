From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Merging submodules - best merge-base
Date: Thu, 7 Mar 2013 19:59:07 +0100
Message-ID: <20130307185906.GA9661@sandbox-ub.fritz.box>
References: <op.ws2l3rgnrbppqq@cicero.linkoping.osa>
 <20130306181156.GA4114@sandbox-ub>
 <op.wtklj7e9rbppqq@cicero.linkoping.osa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: Daniel Bratell <bratell@opera.com>
X-From: git-owner@vger.kernel.org Thu Mar 07 19:59:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDg2X-0003cj-5i
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 19:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932740Ab3CGS7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 13:59:12 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.103]:60737 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932414Ab3CGS7M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 13:59:12 -0500
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UDg20-0006fd-8u; Thu, 07 Mar 2013 19:59:08 +0100
Content-Disposition: inline
In-Reply-To: <op.wtklj7e9rbppqq@cicero.linkoping.osa>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217612>

On Thu, Mar 07, 2013 at 10:49:09AM +0100, Daniel Bratell wrote:
> Den 2013-03-06 19:12:05 skrev Heiko Voigt <hvoigt@hvoigt.net>:
> 
> >On Mon, Feb 25, 2013 at 05:44:05PM +0100, Daniel Bratell wrote:
> >>A submodule change can be merged, but only if the merge is a
> >>"fast-forward" which I think is a fair demand, but currently it
> >>checks if
> >>it's a fast-forward from a commit that might not be very interesting
> >>anymore.
> >>
> >>If two branches A and B split at a point when they used submodule commit
> >>S1 (based on S), and both then switched to S2 (also based on S)
> >>and B then
> >>switched to S21, then it's today not possible to merge B into A, despite
> >>S21 being a descendant of S2 and you get a conflict and this warning:
> >>
> >>warning: Failed to merge submodule S (commits don't follow merge-base)
> >>
> >>(attempt at ASCII gfx:
> >>
> >>Submodule tree:
> >>
> >>S ---- S1
> >>   \
> >>    \ - S2 -- S21
> >>
> >>Main tree:
> >>
> >>A' (uses S1) --- A (uses S2)
> >>   \
> >>    \ --- B' (uses S2) -- B (uses S21)
> >>
> >>
> >>I would like it to end up as:
> >>
> >>A' (uses S1) --- A (uses S2) ------------ A+ (uses S21)
> >>   \                                     /
> >>    \ --- B' (uses S2) -- B (uses S21)- /
> >>
> >>And that should be legal since S21 is a descendant of S2.
> >
> >So to summarize what you are requesting: You want a submodule merge be
> >two way in the view of the superproject and calculate the merge base
> >in the submodule from the two commits that are going to be merged?
> >
> >It currently sounds logical but I have to think about it further and
> >whether that might break other use cases.
> 
> Maybe both could be legal even. The current code can't be all wrong,
> and this case also seems to be straightforward.

Ok I have thought about it further and I did not come up with a simple
(and stable) enough strategy that would allow your use case to merge
cleanly without user interaction.

The problem is that your are actually doing a rewind from base to both
tips. The fact that a rewind is there makes git suspicious and we simply
give up. IMO, thats the right thing to do in such a situation.

What should a merge strategy do? It infers from two changes what the
final intention might be. For submodules we can do that when the changes
on both sides point forward. Since thats the typical progress of
development. If not there is some reason for it we do not know about. So
the merge gives up.

Please see this post about why we need to forbid rewinds from the
initial design discussion:

http://article.gmane.org/gmane.comp.version-control.git/149003

I am not saying that the current behavior is perfect but I think a merge
containing a rewind needs user support. We could give the user a hint
and say: "Hey I gave up but the two sides are contained in each other
and this is the commit containing both". Then the user can choose to use
that suggested solution. We already do the same for the merge commit
search.

Cheers Heiko
