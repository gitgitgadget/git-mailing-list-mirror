From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v3 05/13] parse the -L options
Date: Thu, 22 Jul 2010 11:06:39 +0200
Message-ID: <201007221106.39623.trast@student.ethz.ch>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com> <201007200951.56218.trast@student.ethz.ch> <7v39venom7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bo Yang <struggleyb.nku@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 11:07:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObrkE-0007Vz-H7
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 11:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759085Ab0GVJHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 05:07:04 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:5958 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755761Ab0GVJHB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 05:07:01 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 22 Jul
 2010 11:07:00 +0200
Received: from thomas.localnet (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.0.702.0; Thu, 22 Jul
 2010 11:06:39 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.93; x86_64; ; )
In-Reply-To: <7v39venom7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151447>

Junio C Hamano wrote:
[moved up this chunk from the end]
> If you instead choose to retain the "start from one commit", then the way
> you ask the question becomes "I have these lines in these files at this
> commit; explain how they came about in the history", which is exactly what
> you ask "blame".  You are just using a different presentation from what
> the default "blame" output gives.
[...]
> > Then you suddenly have a mode of git-blame that takes the normal
> > options, and another that takes all the git-log arguments that pertain
> > to commit formatting.
> 
> I would consider it similar to "blame --incremental"; you can choose a
> very different output format driven by a single switch to change the mode
> of operation.

For me (and Bo seemed to agree off-list) the main interest is in the
*history*.  Yes, it is an important feature that the diffs are also
limited to the ranges you are scanning, but that is the secondary
feature.

[If you think that is unfair, consider: if you remove the history
filtering or view, the line-log becomes log or blame, respectively.
If you just remove the diff display, it's still a new mode of history
simplification.]

In the rest of the mail I'll make some more points why it is more
log-like than blame-like, but this is the main point.


The comparison to "blame --incremental" is not valid because blame
always shows exactly one commit per line.  That's not history in my
book.  It does not even compute the history that line-log computes (it
gives up on tracking a line once it has assigned blame for it) so it
is not a new output format of existing data either.

> I think "log -L" conceptually is very different from the normal "log with
> pathspecs".
> 
> The "log with pathspecs" is about "I have these histories that lead to
> these commits; show commits that touch paths that match them".  On the
> other hand, "log -L" asks "I have these lines in these files; explain how
> they came about in the history leading to...".  Now, the question is:
> "leading to" WHAT?

If pathspec limiting wasn't broken in the sense that it does not
support --follow (properly, anyway), they would be exactly equivalent.
With --follow, you would mean "I have these files, please explain how
they came about", and you would expect git to track renames and
copies.

That the current "I want to see some history, but only when it touched
this file" works is a fortunate side effect of the fact that people
rarely rename files (and that if they do, there are few collisions so
simply adding the old name usually works).

In particular, proper log --follow would have a problem exactly
analogous to:

> Because you start from "I have _these lines_", you are fundamentally
> discussing contents that appear as a set of line ranges _in a particular
> version_, adjusting the range to match their older incarnations as
> necessary as you dig deeper, no?
[...]
> E.g. if you have a history of this shape where commit C is at the tip:
> 
>     ---o---A---x---B---o---C
> 
> you _could_ ask "log -p -L1,10,B:Makefile A..C" (I am not proposing this
> syntax at all, by the way) to browse the history between A and C, looking
> for commits that touch the region of Makefile that appeared as lines 1..10
> in revision B.  Between B and C, some new lines might have been introduced
> inside the range and you would dig in reverse enlarging the range to show
> what have been added to it.

[I think this would be entirely possible to do for the line-log case,
though it would be too much effort for GSoC since it is also a
hard-to-explain and probably rarely-used case.]

Similarly, the plans for simplification that I have discussed with Bo
are roughly:

* commits that take all ranges from one of their parents are simplified
  away (even if a merge)

* commits that take each range fully from a single parent should stay
  but not show a diff

* ranges that are "split" between parents should show some format of
  diff

Compare this to pathspec filtering:

* commits that are TREESAME to one of their parents are simplified
  away

* commits that take each hunk literally from a single parent do not
  show a diff with --cc

* commits that have hunks "mixed" from the parents show a diff

[The latter was first and served a guideline, of course.]

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
