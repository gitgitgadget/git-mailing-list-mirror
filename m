From: Eric Wong <normalperson@yhbt.net>
Subject: Re: How to use git-svn to clone from a mirror?
Date: Tue, 5 Jun 2007 03:41:01 -0700
Message-ID: <20070605104101.GC12948@muzzle>
References: <86hcpq8qjz.fsf@lola.quinscape.zz> <85myzfsqji.fsf@blr-RHarinath.blr.novell.com> <Pine.LNX.4.64.0706041906570.4046@racer.site> <86r6oqoqdd.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 12:41:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvWTM-0008Ol-Hj
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 12:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762970AbXFEKlF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 06:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763983AbXFEKlF
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 06:41:05 -0400
Received: from hand.yhbt.net ([66.150.188.102]:52467 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762970AbXFEKlE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 06:41:04 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 61A6C2DC032;
	Tue,  5 Jun 2007 03:41:01 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 05 Jun 2007 03:41:01 -0700
Content-Disposition: inline
In-Reply-To: <86r6oqoqdd.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49190>

David Kastrup <dak@gnu.org> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 4 Jun 2007, Raja R Harinath wrote:
> >
> >> David Kastrup <dak@gnu.org> writes:
> >> 
> >> > I have used something like
> >> >
> >> > git-svn clone -T trunk -b branches -t tags file:///tmp/rsync-mirror
> >> >
> >> > to clone an rsync mirror of an SVN repository.  Now I want to have 
> >> > fetch revert to pulling from the upstream repository in future. 
> >> > However, if I change the respective line in .git/config to 
> >> > svn://the.svn.link/whatever, git-rebase will fetch the right updates, 
> >> > but then says that it can't work with the objects in the git 
> >> > repository.
> >> >
> >> > Changing the config back will make git-rebase -l work.
> >> >
> >> > So what would be the right procedure to shift the SVN source from an
> >> > rsync mirror to the original, without git-svn breaking?
> >> 
> >> I think you'll have to
> >> 
> >> -------------8<------------
> >>   # remove stored revision db, since we're going to change all the commit ids
> >>   rm .git/svn/git-svn/.rev_db.*
> >> 
> >>   # rewrite git-svn-id: lines
> >>   cg-admin-rewritehist \
> >> 	--msg-filter \
> >> 	'sed "s,file:///tmp/rsync-mirror,svn://the.svn.link/whatever,"'
> >> 
> >>   # recreate new revision db, and fetch updates, if any
> >>   git-svn rebase
> >> -------------8<------------
> >
> > <shameless plug>
> > 	Or you use the just-rewritten version of it, git-filter-branch.
> > </shameless>
> 
> Well, part of the reason I worked from an rsynced copy was to be able
> to repeat the experiment by just wasting a few hours of time each
> time, without wasting more bandwidth.
> 
> What I arrived at was to use
> git-svn init -T trunk -t tags -b branches
>   --rewrite-root svn://tug.org/texlive file:///mirror/texlive
> git-svn fetch --all
> [edit .git/config and replace the url and rewrite-root lines with a
>  single url line pointing to the root]
> git-reset --hard   [don't ask me why]
> and afterwards fetches worked online.

Yes, sorry for the late response, but --rewrite-root was written
with this purpose in mind.

> I liked the commit messages when using --no-metadata better than with
> --rewrite-root, but I found no way to get the resulting archive
> operative for git-svn rebase afterwards.

You should be able to use git-svn fetch and then plain git-rebase <remote>

> Could someone explain to me why git needs to know the upstream URL
> history, whether by --rewrite-root or rewrite-hist or
> git-filter-branch?
> 
> I find this rather hard to understand, so I would like to get an idea
> where this fits naturally into the overall design of git, and how it
> makes sense.

Having the git-svn-id: lines in commits allows commits to be made to the
upstream SVN repository more easily and without user interaction or
configuraton.  I put git-svn-id: in the commit objects themselves
because they're immutable and robust.

The URL portion of git-svn-id: is useful when I'm using many throwaway
branches and I've forgotten which upstream (SVN) branch I need to
dcommit against, and git-svn can easily figure it out for me
without needing to remember to use git-checkout --track on my part
or memorization.

It's possible to clone the refs and objects over to a new repository
over the native git:// protocol and have it fully usable from git-svn
without needing additional setup or having to copy the .git/config or
.git/svn (neither of which are transferred over the git protocol).
Cloning the refs is a bit of a pain these days because of the "remotes/"
convention in the name, but still possible.

The .rev_db files in .git/svn can get corrupted or deleted, and since
they're not managed by git, they're next to impossible to recover
if the git-svn-id: lines didn't exist.

I'll be the first to admit that the git-svn-id: lines are ugly, but
that's why I wrote "git svn log" :)

-- 
Eric Wong
