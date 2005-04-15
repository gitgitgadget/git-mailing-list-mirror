From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 08:32:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org>
References: <20050414002902.GU25711@pasky.ji.cz>  <20050413212546.GA17236@64m.dyndns.org>
  <20050414004504.GW25711@pasky.ji.cz>  <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
  <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
  <7v64ypsqev.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
  <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>  <20050414121624.GZ25711@pasky.ji.cz>
  <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
  <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org>
 <1113559330.12012.292.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 17:30:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMSkH-0004fL-1T
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 17:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVDOPbz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 11:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVDOPbz
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 11:31:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:52869 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261813AbVDOPbA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 11:31:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3FFUns4023673
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Apr 2005 08:30:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3FFUmJ9028949;
	Fri, 15 Apr 2005 08:30:48 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113559330.12012.292.camel@baythorne.infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 15 Apr 2005, David Woodhouse wrote:
> 
> And you're right; it shouldn't have to be for renames only. There's no
> need for us to limit it to one "source" and one "destination"; the SCM
> can use it to track content as it sees fit.

Listen to yourself, and think about the problem for a second.

First off, let's just posit that "files" do not matter. The only thing
that matters is how "content" moved in the tree. Ok? If I copy a function
from one fiel to another, the perfect SCM will notice that, and show it as
a diff that removes it from one file and adds it to another, and is
_still_ able to track authorship past the move. Agreed?

Now, you basically propose to put that information in the "commit" log, 
and that's certainly valid. You can have the commit log say "lines 50-89 
in file kernel/sched.c moved to lines 100-139 in kernel/timer.c", and then 
renames fall out of that as one very small special case.

You can even say "lines 50-89 in file kernel/sched.c copied to.." and 
allow data to be tracked past not just movement, but also duplication.

Do you agree that this is kind of what you'd want to aim for? That's a 
winning SCM concept.

How do you think the SCM _gets_ at this information? In particular, how 
are you proposing that we determine this, especially since 90% of all 
stuff comes in as patches etc? 

You propose that we spend time when generating the tree on doing so. I'm 
telling you that that is wrong, for several reasons:

 - you're ignoring different paths for the same data. For example, you 
   will make it impossible to merge two trees that have done exactly the 
   same thing, except one did it as a patch (create/delete) and one did it 
   using some other heuristic.

 - you're doing the work at the wrong point. Doing it _well_ is quite 
   expensive. So if you do it at commit time, you cannot _afford_ to do it 
   well, and you'll always fall back to doing an ass-backwards job that 
   doesn't really get you to the good state, and only gets you to a 
   not-very-interesting easy 1% of the solution (ie full file renames).

 - you're doing the work at the wrong point for _another_ reason. You're 
   freezing your (crappy) algorithm at tree creation time, and basically 
   making it pointless to ever create something better later, because even 
   if hardware and software improves, you've codified that "we have to
   have crappy information".

Now, look at my proposal: 

 - the actual information tracking tracks _nothing_ but information. You 
   have an SCM that tracks what changed at the only level that really 
   matters, namely the whole project. None of the information actually 
   makes any sense at all at a smaller granularity, since by definition, a
   "project" depends on the other files, or it wouldn't be a project, it
   would be _two_ projects or more.

 - When you're interested in the history of the information, you actually 
   track it, and you try to be _intelligent_ about it. You can actually do 
   a HELL of a lot better than whet you propose if you go the extra mile. 
   For example, let's say that you have a visualization tool that you can 
   use for finding out where a line of code came from. You start out at 
   some arbitrary point in the tree, and you drill down. That's how it 
   works, right?

   So how do you drill down? You simply go backwards in history for that 
   project, tracking when that file+line changed (a "file+line" thing is 
   actually a "sensible" tracking unit at this point, because it makes
   sense within the query you're doing - it's _not_ a sensible thing to
   track at "commit" time, but when you ask yourself "where did this line
   come from", that _question_ makes it sensible. Also note that "where 
   did this _file_ come from is not a sensible question, since the file 
   may have been the combination (or split) of several files, so there is
   no _answer_ to that question"

   So the question then becomes: "how can you reasonably _efficiently_
   find the history of one particular line", and in fact it turns out that 
   by asking the question that way, it's pretty obvious: now that you
   don't have to track the whole repository, you can always try to 
   minimize the thing you're looking for.

   So what you do is walk back the history, and look at the tree objects 
   (both sides when you hit a merge), eand see if that file ever changes. 
   That's actually a very efficient operation in GIT - it matches
   _exactly_ how git tracks things anyway. So it's not expensive at all.

   When that file changes, you need to look if that _line_ changed (and 
   here is where it comes down to usability: from a practical standpoint
   you probably don't care about a single line, you really _probably_ want
   to see changes around it too). So you diff the old state and the new 
   state, and you see if you can still find where you were. If you still 
   can, and the line (and a few lines around it) is still the same, you 
   just continue to drill down. So that's not the interesting case.

   So what happens when you found "ok, that area changed"? Your 
   visualization tool now shows it to the user, AND BECAUSE IT SEES THE 
   WHOLE TREE DIFF, it also shows where it probably came from. At _that_ 
   point, it is actually very trivial to use a modest amount of CPU time, 
   and look for probable sources within that diff. You can do it on modern 
   hardware in basically no time, so your visualization tool can actually 
   notice that
 
	"oops, that line didn't even exist in the previous version, BUT I
	 FOUND FIVE PLACES that matched almost perfectly in the same diff,
	 and here they are"

   and voila, your tool now very efficiently showed the programmer that
   the source of the line in question was actually that we had merged 5 
   copies of the same code in different archtiectures into one common
   helper function.

   And if you didn't find some source that matched, or if the old file was
   actually very similar around that line, and that line hadn't been
   "totally new"? That's the easy case again - you show the programmer the
   diff at that point in time, and you let him decide whether that diff 
   was what he was looking for, or whether he wants to continue to "zoom
   down" into the history.

The above tool is (a) fairly easy to write for git (if you can do 
visualization tools and (b) _exactly_ what I think most programmers 
actually want. Tell me I'm wrong. Honestly..

And notice? My clearly _superior_ algorithm never needed any rename
information at all. It would have been a total waste of time. It would
also have hidden the _real_ pattern, which was that a piece of code was
merged from several other matching pieces of code into one new helper
function. But if it _had_ been a pure rename, my superior tool would have
trivially found that _too_. So rename infomation really really doesn't
matter.

So I'm claiming that any SCM that tries to track renames is fundamentally
broken unless it does so for internal reasons (ie to allow efficient
deltas), exactly because renames do not matter. They don't help you, and 
they aren't what you were interested in _anyway_.

What matters is finding "where did this come from", and the git
architecture does that very well indeed - much better than anything else
out there. I outlined a simple algorithm that can be fairly trivially
coded up by somebody who really cares. Sure, pattern matching isn't
trivial, but you start out with just saying "let's find that exact line,
and two lines on each side", and then you start improving on that.

And that "where did this come from" decision should be done at _search_ 
time, not commit time. Because at that time it's not only trivial to do, 
but at that time you can _dynamically_ change your search criteria. For 
example, you can make the "match" algorithm be dependent on what you are 
looking at.

If it's C source code, it might want to ignore vairable names when it
searches for matching code. And if it's a OpenOffice document, you might
have some open-office-specific tools to do so. See? Also, the person doing 
the searches can say whether he is interested in that particular line (or 
even that particial _identifier_ on a line), or whether he wants to see 
the changes "around" that line.

All of which are very valid things to do, and all of which my world-view
supports very well indeed. And all of which your pitiful "files matter" 
world-view totally doesn't get at all.

In other words, I'm right. I'm always right, but sometimes I'm more right 
than other times. And dammit, when I say "files don't matter", I'm really 
really Right(tm).

Please stop this "track files" crap. Git tracks _exactly_ what matters, 
namely "collections of files". Nothing else is relevant, and even 
_thinking_ that it is relevant only limits your world-view. Notice how the 
notion of CVS "annotate" always inevitably ends up limiting how people use 
it. I think it's a totally useless piece of crap, and I've described 
something that I think is a million times more useful, and it all fell out 
_exactly_ because I'm not limiting my thinking to the wrong model of the 
world.

			Linus
