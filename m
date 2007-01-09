From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 9 Jan 2007 18:39:48 -0500
Message-ID: <20070109233948.GC30023@spearce.org>
References: <87ps9xgkjo.wl%cworth@cworth.org> <7virfprquo.fsf@assigned-by-dhcp.cox.net> <87odphgfzz.wl%cworth@cworth.org> <7vbql9ydd7.fsf@assigned-by-dhcp.cox.net> <20070108131735.GA2647@coredump.intra.peff.net> <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net> <20070109142130.GA10633@coredump.intra.peff.net> <7virffkick.fsf@assigned-by-dhcp.cox.net> <20070109213117.GB25012@fieldses.org> <7vy7obj07k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 00:39:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4QZS-0004pS-3C
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 00:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbXAIXjz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 18:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbXAIXjz
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 18:39:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34690 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932542AbXAIXjz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 18:39:55 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4QZA-0005sp-RY; Tue, 09 Jan 2007 18:39:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D4E3620FBAE; Tue,  9 Jan 2007 18:39:48 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy7obj07k.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36424>

Junio C Hamano <junkio@cox.net> wrote:
> I do not want to think about the consequences of adding more
> cruft under .git/ directory.  For example, should PREV be
> noticed by fsck and prune?  What should various forms of
> 'git-reset' do with it?  How does it interact with 'git-bisect'?

I agree.  The reachability list for those is already starting to
get out of control, and the rules for making sure those files are
always in sync with every command is getting crazy.  Didn't we just
fix `git reset --hard` to throw away .git/MERGE_MSG?  That's been
a longstanding bug right there, and that's something that has been
in the tree for a loooooooong time.
 
> Being able to test merge or even make commits without being on a
> branch is vastly useful.  It might or might not lead to anywhere
> even after you make a handful commits -- and I would imagine
> that it would be very handy to be able to be lazy and not having
> to decide if it is worth a new branch.

I agree.  I'm always creating and deleting `foof` because I need
someplace to work real quick.  Being able to work on a detached HEAD
would just slightly streamline the process, especially given that
`git checkout -b a-real-name` is readily available to move that
detached HEAD state into a real branch and continue on with it.
 
> If Carl wants to do a patch to teach
> 'git-commit' (and all other things that can create commits) not
> to do things from working in a detached HEAD

My concern here is to hit all of the corner cases.  reset.  bisect.
am.  rebase.  merge.  cherry-pick/revert.  Did I get all of 'em?
I'm not sure actually.  ;-)

> It's tempting to forget about this whole "safety" business.
> Because we allow "reset --hard" and other forms of operations
> that can lose history if they were done while on a branch, only
> giving the safety to "git checkout" feels somewhat silly.

But isn't the --hard switch the safety valve here?  And lets not
forget that reflogs are enabled by default now so even a `reset
--hard` on a real branch isn't a total loss (its only a loss for
uncommitted files in the working directory).

But a detached HEAD has no reflog. Which means operations that
update it in a non-fastforward way would orphan work.  A subsequent
gc/prune/repack might destroy it, unless an existing ref contains
that previous commit.

> Which makes the "merge-base --check-ancestry" stuff I did last
> night pretty much unnecessary, but that's Ok.  It will find
> other uses.

Pity.  It looked like it was a good change and would be useful here
as a safety valve.  Though based on what you said above I would
think we'd actually want it in both checkout and reset (--soft and
--hard versions).

-- 
Shawn.
