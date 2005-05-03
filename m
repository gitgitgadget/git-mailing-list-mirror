From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cogito "origin" vs. HEAD
Date: Tue, 3 May 2005 11:47:23 +0200
Message-ID: <20050503094723.GA22436@pasky.ji.cz>
References: <1115090660.6156.56.camel@gaston> <20050503064943.GB10244@pasky.ji.cz> <1115104408.6156.100.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 11:42:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DStu3-00062J-W7
	for gcvg-git@gmane.org; Tue, 03 May 2005 11:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVECJre (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 05:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVECJre
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 05:47:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39359 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261437AbVECJrZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 05:47:25 -0400
Received: (qmail 27192 invoked by uid 2001); 3 May 2005 09:47:23 -0000
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Disposition: inline
In-Reply-To: <1115104408.6156.100.camel@gaston>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 03, 2005 at 09:13:28AM CEST, I got a letter
where Benjamin Herrenschmidt <benh@kernel.crashing.org> told me that...
> > when accessing the remote repository, Cogito always looks for remote
> > refs/heads/master first - if that one isn't there, it takes HEAD, but
> > there is no correlation between the local and remote branch name. If you
> > want to fetch a different branch from the remote repository, use the
> > fragment identifier (see cg-help cg-branch-add).
> 
> Ok, that I'm getting. So then, what happen of my local
> refs/heads/<branchname> and refs/heads/master/ ? I'm still a bit
> confused by the whole branch mecanism... It's my understanding than when
> I cg-init, it creates both "master" (a head without matching branch)
> and "origin" (a branch  + a head) both having the same sha1. It also
> checks out the tree.
> 
> Now, when I cg-update origin, what happens exactly ? I mean, I know it's
> pulls all objects, then get the master from the remote pointed by the
> origin branch, but then, I suppose it updates both my local "origin" and
> my local "master" pointer, right ? I mean, they are always in sync ? Or
> is this related to what branch my current checkout is tracking ?

They are in sync as long as you update only from that given branch.
At the moment you do a local commit, they get out of sync, at least
until your master branch is merged to the origin branch on the other
side. Every cg-update will then generate a merging commit, so it will
look like this:

     [origin]    [master]
            commit1
              |
            commit2               Both heads are in sync so far...
              |
            commit3
             /    \
            /     commit4         Now heads/master is commit4, but
           /        |             heads/origin is still commit3
          /         |
      commit5-.     |             heads/master:commit4, heads/origin:commit5
          |    \    |
          |     `-commit6         commit6 merges origin to master
          |       /
          |     /
          |   /
      commit6                     origin merged your master; since it
                                  contained all the commits on the origin
               |                  branch, it just took over the commit6
             commit6              commit pointer as its new head; so both
                                  heads are again in sync now


This is the reason why there are always at least two branches, origin
and master. The checked out tree is always of the master branch (unless
you do cg-seek, which is somewhat special anyway). [*] "Normally", when
you do no local changes and just always cg-update the origin branch, the
two branches are always in sync. At the point you start to "mix" several
remote branches besides origin in your tree, or at the point you do a
local commit, the master branch gets standalone - until the origin
merges your changes as drawn in the diagram.

There is one other situation when the head pointers may not be in sync -
when you do cg-pull instead of cg-update. You want to see what are the
changes in the origin branch, but you are not sure if you want them to
appear in your master branch, you do cg-pull origin. Your origin head
pointer is updated, but your master pointer stays where it is. If you
decide it's ok to bring the changes in, you do either cg-update, or only
cg-merge to avoid re-pulling.


[*] Technically, you can have multiple local branches and your tree can
be based on any of them, not only "master". Cogito supports that
internally, but (deliberately) provides no UI to set that up, at least
until we devise a way to do it without confusing people even more.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
