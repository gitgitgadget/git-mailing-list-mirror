From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Comments on recursive merge..
Date: Wed, 9 Nov 2005 08:30:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511090800330.3247@g5.osdl.org>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
 <20051107225807.GA10937@c165.ib.student.liu.se> <7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
 <Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051108210211.GA23265@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081351020.3247@g5.osdl.org>
 <20051108223609.GA4805@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081450080.3247@g5.osdl.org>
 <20051109003236.GA30496@pasky.or.cz> <Pine.LNX.4.64.0511081646160.3247@g5.osdl.org>
 <7vlkzyd4aq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511081716450.3247@g5.osdl.org>
 <7v8xvyd2bh.fsf@assigned-by-dhcp.cox.net> <7v4q6mgm1l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 17:39:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZsqt-00055e-IC
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 17:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbVKIQa4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 11:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbVKIQa4
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 11:30:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10952 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750962AbVKIQaz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 11:30:55 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA9GUonO009396
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 9 Nov 2005 08:30:51 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA9GUnUX028411;
	Wed, 9 Nov 2005 08:30:49 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q6mgm1l.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11402>



On Wed, 9 Nov 2005, Junio C Hamano wrote:
> 
> As you pointed out, still_interesting means "after we are done
> with this commit, do we still have something interesting to be
> processed?", and the later "extra < 0" check compensates for
> this.  After I pop the last interesting commit, I still look at
> its parents and push them back into the list.

That "extra" check only helps once. If we ever hit the "extra--", it's 
gone.

In other words, follow this:

 - we start out with "extra = 0" (default value)
 - we've got one "interesting" commit left, and we just popped it.
 - we now have "still_interesting = 0"
 - the commit has just one parent, and it's not something we've seen 
   before, so we add it to the seen list and decrement "extra", which is 
   now -1. We then insert it back to the list.
 - we go back up, pop the thing we just got, and now there are again no 
   interesting commits on the list any more, so "still_interesting = 0".
 - now "extra" is -1, and we break out of the loop without ever 
   percolating the flags of this commit to its parents.

No?

> It seems to be doing the right thing after all.  I hate to admit it, but 
> I have been having hard time figuring out how this thing works X-<.  In 
> the meantime, I've checked commits from linux-2.6 history that have more 
> than one merge-base candidates.

I'm not very impressed by "it works for the seven cases I tried".

It's entirely possible that there _is_ some reason it always works, but if 
so, I'd like to understand it. More likely, it works in _practice_ because 
the only way to trigger anything else is likely such a perverse commit 
history that you'd never see it, but hey..

Also, I don't think this has necessarily anything to do with "multiple 
merge bases". As far as I can tell, we can find a potential "merge base" 
that starts the culling of uniniteresting things, but some other branch 
(that we haven't followed yet - perhaps the one we just broke out of 
early) may end up causing an _earlier_ commit to turn out to also be a 
merge-base, and the merge-base we found originally turns out to be a 
parent of the new one, and thus totally uninteresting.

See what I'm saying? Even with just _one_ well-defined merge base, we 
might hit it.

It so happens that because we traverse the commit history in date order, 
we almost never (but the keyword here is _almost_) hit the case where a 
child of a commit ends up being parsed _after_ the commit that is its 
parent. That only happens when there are non-synchronized clocks etc, and 
there are very few cases of that in the kernel tree.

Just to see how rare that is, do this:

	git-rev-list --pretty=raw HEAD |
		grep '^committer' |
		cut -d'>' -f2 |
		cut -d' ' -f2 > date-list

which basically generates the list of dates of commits in the kernel tree, 
sorted in the natural order that we always traverse the commits in.

Now, do

	sort -nr date-list | diff -u date-list -

to see how often the dates are off. I'm seeing only _three_ commits that 
have time-warps (ie they were "earlier" than one of their parents). Out of 
13,000+.

So walking things in date order _almost_ always does the right thing just 
by mistake (well, it's not "mistake", of course. It's by design: it's the 
closest we can get to a nice balanced walk. But the point is that it's 
still just a heuristic, not something we can absolutely depend on).

And THAT was the reason for the problem with the original git-merge-base 
algorithm. Not multiple merge-bases (which was admittedly another 
problem), but the fact that it didn't give the right merge-base at all due 
to time warps.

(Again - it may be that there's something in show-branch that makes the 
optimization valid, but I just don't understand it).

			Linus
