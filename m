From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] git reflog show
Date: Wed, 27 Dec 2006 00:20:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612270006460.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061223101956.GD9396@spearce.org> <7v4prmsxjl.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612231552140.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061224061151.GE7443@spearce.org> <Pine.LNX.4.63.0612241333280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wmpq83g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612251449140.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vwt4fj1cs.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612261654330.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64byfpic.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 27 00:20:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzLan-0001Rw-7A
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 00:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827AbWLZXUR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 18:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932856AbWLZXUR
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 18:20:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:39548 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932827AbWLZXUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 18:20:16 -0500
Received: (qmail invoked by alias); 26 Dec 2006 23:20:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp009) with SMTP; 27 Dec 2006 00:20:14 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64byfpic.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35434>

Hi,

On Tue, 26 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> The most valuable parts of the revision walking code are about 
> >> ancestry traversal and history simplification with pathspec, neither 
> >> of which makes much sense to use when "walking" reflog.
> >
> > Sorry to be a PITA here, but I think that it _would_ make sense. Quite 
> > often I ask myself "That feature in this file used to work. When and 
> > how was it changed?" Right now, I use git-log with path 
> > simplification, but with reflog walking, I could ask in a more 
> > specific way!
> 
> When you put it that way, it sort of makes sense.  Right now, 
> get_revision() walks the chain of commits using the parent links and the 
> history simplification (try_to_simplify_commit) looks at each commit and 
> compares the tree with its parents' trees to decide if the commit is 
> worth considering.
> 
> [...]
> 
> I am not proposing to introduce a new object type here, but
> conceptually we could.  Maybe a quick hack would be to represent
> each reflog entry as a phony "struct commit" in core,
> 
>  1. whose tree is taken from the tree of the tip commit,
> 
>  2. whose buffer is handcrafted by the true commit log message
>     with data from reflog, and
> 
>  3. whose parent list points at another phony "commit" that
>     represents ref@{N+1} reflog entry.

I see only one problem with this approach: "next..master@{0}" would stop 
to work as expected.

> >> But it _also_ makes sense to use reflog when the primary thing we are 
> >> interested in seeing is not how the tip jumped around, but seeing how 
> >> the branch acquired commits, which I think is what you are 
> >> suggesting.  What we would want to have is a sort order different 
> >> from the existing topo or date, which is "reflog order".
> >
> > I think it should not be a different sort order. As you pointed out 
> > yourself, a "git reset --hard HEAD^" removes the assumption of the 
> > commit list being a DAG.
> 
> I think I misunderstood your proposal and the misunderstanding resulted 
> in an unrelated useful enhancement ;-).  If HEAD@{0} and HEAD@{2} points 
> at the same commit, then obviously commits reachable from that commit 
> did not come into the branch no later than HEAD@{2} time (what HEAD@{0} 
> says becomes irrelevant), so you can define an order that lists commits 
> in the order the earliest time they appeared on a branch.

I fear that this traversal is not as easy as it seems. We cannot just 
blindly walk the reflogs, since the simplification relies on being able to 
actually rewrite the commit_list. Also, if a commit was seen, it must be 
possible to show it _again_. And if you show the commit diff, you rely on 
commit->parents actually containing the rewritten parents. And the same 
commit could be in revs->commits twice, and the correct reflog has still 
to be shown.

So I tend to think that rewriting the parents, buffer _and_ flags is the 
way to go.

Ciao,
Dscho
