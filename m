From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-http-pull broken in latest git
Date: Fri, 12 Aug 2005 04:45:52 +0200
Message-ID: <20050812024552.GO25280@pasky.ji.cz>
References: <42F8D472.3080404@de.bosch.com> <20050811223349.GI25280@pasky.ji.cz> <7v4q9wf4ad.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 04:46:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3PYV-0004o0-1s
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 04:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbVHLCp4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 22:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVHLCp4
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 22:45:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55310 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S1751051AbVHLCpz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2005 22:45:55 -0400
Received: (qmail 11690 invoked by uid 2001); 12 Aug 2005 02:45:53 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4q9wf4ad.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Aug 12, 2005 at 01:21:46AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > $ git-cat-file commit bf570303153902ec3d85570ed24515bcf8948848 | grep tree
> > tree 41f10531f1799bbb31a1e0f7652363154ce96f45
> > $ git-read-tree 41f10531f1799bbb31a1e0f7652363154ce96f45
> > fatal: failed to unpack tree object 41f10531f1799bbb31a1e0f7652363154ce96f45
> 
> > Kaboom. I think the issue might be that the reference dependency tree
> > building is broken and it should've pulled the other pack as well.
> 
> Last time I checked, git-http-pull did not utilize the pack
> dependency information, which indeed is wrong.  When it decides
> to fetch a pack instead of an asked-for object, it should check
> which commits the pack expects to have in your local repository
> and add them to its list of things to slurp.
> 
> A good news is that "git clone" as a whole works fine.

Yes, but cg-clone doesn't - it naively depended on the core git tools
actually, er.. working. ;-)

This became a nightmare to me by now - on two machines I tried to pull
to over HTTP, that failed miserably, and I got stuck until I applied
Daniel's patch there (and cleaned up after previous git-http-pulls).

So I have this packless git-pb repository and suspecting no evil, I pull
from you (thankfully I have .git/objects/pack there from some historical
pulls). I do a merge commit:

	packed
	 ... J
	packed \
		 > M
	       /
	 ... P

Now I want to pull on another machine. That pulls M and then fails since
I have no .git/objects/pack there, bummer. So I mkdir it, but get no
further w/o Daniel's patch - for git-*-pull, J is missing and that's it.
So I apply the patch, and get friendly

	error: Unable to determine requirements of type (null) for M

and only after I delete M from the database, I finally succeed with
git-http-pull. (That was with --repair.) That's not good since this
might occur even naturally when the pull is interrupted.

With git-ssh-pull, the situation is even more vexing - it refuses to
fetch the packs for some reason yet unknown to me (I will debug it
tomorrow).

The git-*-pull tools appear yet rather fragile. :/

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
