From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 12:13:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701271156260.25027@woody.linux-foundation.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org>
 <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
 <45BB9C8B.8020907@fs.ei.tum.de> <Pine.LNX.4.64.0701271103520.25027@woody.linux-foundation.org>
 <Pine.LNX.4.64.0701271119300.25027@woody.linux-foundation.org>
 <epgaj2$bn9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 21:13:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAtvI-0006PU-48
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 21:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbXA0UNN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 15:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752388AbXA0UNN
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 15:13:13 -0500
Received: from smtp.osdl.org ([65.172.181.24]:33563 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386AbXA0UNM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 15:13:12 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0RKD81m018422
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 27 Jan 2007 12:13:09 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0RKD8Kc015902;
	Sat, 27 Jan 2007 12:13:08 -0800
In-Reply-To: <epgaj2$bn9$1@sea.gmane.org>
X-Spam-Status: No, hits=-0.48 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37995>



On Sat, 27 Jan 2007, Jakub Narebski wrote:
> 
> By the way, in git-blame you can also give the cutoff like in git-log;
> the lines which come from outside given revision range either get blamed
> on boundary, or are shown "unblamed".

Well, that's not actually all that useful. It's ok when nothing else 
works, but it would be nicer if it just acted well "by default".

Because You generally don't know a priori where your point of interest 
lies.

This is why "git log -p" (or "git whatchanged" before it) is so nice. A 
streaming format means that you get the stuff you likely care about soon, 
but if you aren't quite sure about where it was, it will come _eventually_ 
as you page down. And you can decide at any point in the middle that "ok, 
the thing I was looking for is obviously ancient", which may end up 
changing your whole outlook on a problem.

Which is why I think "incremental" things are so important.

In Sydney at Linux.conf.au I talked a bit to Paul Mackerras about gitk, 
and gitk is _fairly_ good at doing things incrementally (and apparently it 
is internally better at it than I have realized), but by default it still 
passes "--topo-order" to git-rev-list.

Which turns git-rev-list totally non-incremental, and makes gitk horrible 
to start up with default arguments (ie none) on a huge repository. If it 
takes 1 minute to walk the whole history, then gitk will take a minute 
before it shows the first commit.

Paulus was saying that it should be easily fixable, and that gitk 
*already* internally has a reorder buffer for commits out of topological 
order (for the "--date-order" thing, aka "gitk -d"), so gitk too should be 
able to stream perfectly well.

And once you can stream, who cares how big the history is? The part that 
is old will take a long time, but people won't even see it, because 
they'll be busy looking at the new parts that they saw immediately.

So this is why I tend to think that doing

	time <fundamental git operation>

is actually not all that interesting. It's a *lot* more interesting in 
many cases to do


	time <fundamental git operation> | head

because that gives a much more accurate view of what the user experience 
is like.

To get back to the patch I sent out to "git blame", just to illustrate 
this issue:

	[torvalds@woody linux]$ time git blame --incremental -C block/ll_rw_blk.c > /dev/null
	real    0m8.540s
	user    0m8.109s
	sys     0m0.432s

vs

	[torvalds@woody linux]$ time git blame --incremental -C block/ll_rw_blk.c | head > /dev/null
	real    0m0.238s
	user    0m0.240s
	sys     0m0.004s

and 8.5 seconds is a _loong_ time even for a human, but 0.24 seconds is 
"instant". THAT is the difference between "streaming" and "non-streaming".

For a similar example, and seeing why "topo-order" is problematic, just 
try this:

	[torvalds@woody linux]$ time git rev-list --all | head > /dev/null
	real    0m0.007s
	user    0m0.000s
	sys     0m0.012s

vs

	[torvalds@woody linux]$ time git rev-list --topo-order --all | head > /dev/null
	real    0m1.058s
	user    0m1.028s
	sys     0m0.036s

and note how they both just time the first few lines: one takes basically 
no time at all (it's fast *and* streaming) and the other one takes over a 
second (it gets the whole kernel history and then sorts it - so it can't 
stream. A second is still fast for "whole history", but the lack of 
streaming means that it's two orders of magnitude slower IN PRACTICE).

So it's really the *second* case we want to avoid. We want to avoid 
teaching people bad manners, and here "bad manners" is not "having large 
repositories with lots of history", but simply means "do operations that 
fundamentally depend on all of history".

This is why I would much prefer the "--incremental" blame. Suddenly, that 
turns "git blame" from a non-streaming (and thus fundamentally broken) 
operation into something that streams and can thus have a nice user 
experience.

			Linus
