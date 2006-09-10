From: linux@horizon.com
Subject: Re: Change set based shallow clone
Date: 10 Sep 2006 11:21:22 -0400
Message-ID: <20060910152122.31694.qmail@science.horizon.com>
References: <e5bfff550609092214t4f8e195eib28e302f4d284aa@mail.gmail.com>
Cc: git@vger.kernel.org, jonsmirl@gmail.com, linux@horizon.com,
	paulus@samba.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun Sep 10 17:21:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMR7h-0002m8-Lq
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 17:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWIJPVZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 11:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWIJPVZ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 11:21:25 -0400
Received: from science.horizon.com ([192.35.100.1]:13359 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932226AbWIJPVX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 11:21:23 -0400
Received: (qmail 31695 invoked by uid 1000); 10 Sep 2006 11:21:22 -0400
To: junkio@cox.net, mcostalba@gmail.com
In-Reply-To: <e5bfff550609092214t4f8e195eib28e302f4d284aa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26797>

This conversation is going in so many directions at once that it's
getting annoying.

The first level decision requires input from the point of view of gitk
and qgit internals as to what's easy to implement.

I'm trying to figure out the gitk code, but I'm not fluent in tcl, and
it has 39 non-boilerplate comment lines in 229 functions and 6308 lines
of source, so it requires fairly intensive grokking.

Still, while it obviously doesn't render bitmaps until the data
appears in the window, it appears as though at least part of the
layout (the "layoutmore" function) code is performed eagerly as
soon as new data arrives via the getcommitlines callback.

(Indeed, it appears that Tk does not inform it of window scroll
events, so it can't wait any longer to decide on the layout.)


Case 1: The visualizer is NOT CAPABLE of accepting out-of-order
	input.  Without very sophisticated cacheing in git-rev-list,
	it must process all of the data before outputting any in
	order to make an absolute guarantee of no out-of-order data
	despite possibly messed-up timestamps.

	It is possible to notice that the date-first traversal only
	has one active chain and flush the queued data at that point,
	but that situation is unlikely to arise in repositories of
	non-trivial size, which are exactly the ones for which
	the batch-sorting delay is annoying.

Case 2: The visualizer IS CAPABLE of accepting out-of-order input.
	Regardless of whether the layout is done eagerly or lazily,
	this requires the visualizer to potentially undo part of
	its layout and re-do it, so has a UI implementation cost.

	The re-doing does not need to be highly efficient; any number
	of heuristics and exception caches can reduce the occurrence of
	this in git-rev-list output to very low levels.  It's just
	absolutely excluding it, without losing incremental output,
	that is difficult.

	Heuristic: I suspect the most common wrong-timestamp case is
	a time zone misconfiguration, so holding back output until the
	tree traversal has advanced 24 hours will eliminate most of the
	problems.  Atypically large time jumps (like more than a year)
	could also trigger special "gross clock error" handling.

	Cache: whenever a child timestamped older than an ancestor is
	encountered, this can be entered in a persistent cache that can
	be used to give the child a different sorting priority next time.
	The simplest implementation would propagate this information up a
	chain of bad timestamps by one commit per git-rev-list invocation,
	but even that's probably okay.

	(A study of timestamp ordering problems in existing repositories
	would be helpful for tuning these.)

In case 2, I utterly fail to see how delaying emitting the out-of-order
commit is of the slightest help to the UI.  The simplest way to merge
out-of-order data is with an insertion sort (a.k.a. roll back and
reprocess forward), and the cost of that is minimized if the distance
to back up is minimized.

Some "oops!" annotation on the git-rev-list output may be helpful to
tell the UI that it needs to search back, but it already has an internal
index of commits, so perhaps even that isn't worth bothering with.
Fancier output formats are also more work to process.

With sufficient cacheing of exceptions in git-rev-list, it may be
practical to just have a single "oops, I screwed up; let's start again"
output line, which very rarely triggers.


But can we stop designing git-rev-list output formats until we've figured
out if and how to implement it in the visualizer?  Or, more to the point,
visualizers plural.  That's the hard part.  Then we can see what sort
of git-rev-list output would be most convenient.

For example, is fixing a small number of out-of-place commits practical,
or is it better to purge and restart?  The former avoids deleting
already-existing objects, while the latter avoids moving them.

The original problem is that the long delay between starting a git history
browser and being able to browse them is annoying.  The visualizer UIs
already support browsing while history is flowing in from git-rev-list,
but git-rev-list is reading and sorting the entire history before
outputting the first line.
