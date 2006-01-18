From: Petr Baudis <pasky@suse.cz>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 13:51:58 +0100
Message-ID: <20060118125158.GN28365@pasky.or.cz>
References: <200601181325.59832.Mathias.Waack@rantzau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 13:51:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzCmG-0004zf-Nx
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 13:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWARMuq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 07:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWARMuq
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 07:50:46 -0500
Received: from w241.dkm.cz ([62.24.88.241]:30687 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932487AbWARMup (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 07:50:45 -0500
Received: (qmail 24698 invoked by uid 2001); 18 Jan 2006 13:51:59 +0100
To: Mathias Waack <Mathias.Waack@rantzau.de>
Content-Disposition: inline
In-Reply-To: <200601181325.59832.Mathias.Waack@rantzau.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14820>

  Hello,

Dear diary, on Wed, Jan 18, 2006 at 01:25:59PM CET, I got a letter
where Mathias Waack <Mathias.Waack@rantzau.de> said that...
> we're using git with cogito as a frontend. For some reasons I forgot we have 
> some repositories which belong to the same project. To simplify the whole 
> thing I would like to join these repositories. It mainly means to move some 
> directories. So lets say I have: 
> 
> 	/r1/.git
> 	/r2/.git
> 
> and what I would like to have is
> 
> 	/r/.git
> 	   r1
>            r2
> 
> Of course the history should remain (otherwise it would be to easy). 
> 
> How should I do this?

  The crucial question is what the joined repository's directory
structure should be. If from r1/a, r2/b you want r/a, r/b then it's
easy:

	cd r1
	cg-branch-add r2 ../r2/.git
	cg-fetch r2
	cg-merge -j r2

  But if you want r1/a, r2/b to turn to r/r1/a, r/r2/b, you will have
to rewrite the history of each (and then do the above). One rough
and untested sketch...

	mkdir r1-rewritten
	cd r1-rewritten
	cp -a ../r1/.git .
	for commit in $(git-rev-list --topo-order HEAD | tac); do
		git-read-tree --prefix=r1/ $commit
		# here, setup the AUTHOR/COMMITTER variables
		# appropriately (you can look at cg-commit's
		# $copy_commit handler)
		git-cat-file commit "$commit" | sed -e '1,/^$/d' | \
			git-commit-tree $(git-write-tree) \
				$(for parent in $(cg-object-id -p $commit); do
					cat commitmap/$parent
				  done) >commitmap/$commit
		last_commit=$commit
	done
	git-update-ref HEAD $(cat commitmap/$last_commit)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
