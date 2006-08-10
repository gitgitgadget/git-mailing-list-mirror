From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH and RFC] gitweb: Remove --full-history from git_history
Date: Thu, 10 Aug 2006 23:39:20 +0200
Message-ID: <20060810213920.GC13446@c165.ib.student.liu.se>
References: <200608091257.19461.jnareb@gmail.com> <20060809192815.GA7954@c165.ib.student.liu.se> <7vk65h1t8q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 10 23:39:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBIFX-0007nM-19
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 23:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWHJVjX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 17:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWHJVjX
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 17:39:23 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:48560 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1750930AbWHJVjW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 17:39:22 -0400
Received: from c165 ([213.114.27.85] [213.114.27.85])
          by mxfep01.bredband.com with ESMTP
          id <20060810213920.IXUG17083.mxfep01.bredband.com@c165>;
          Thu, 10 Aug 2006 23:39:20 +0200
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1GBIFM-0004XK-00; Thu, 10 Aug 2006 23:39:20 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk65h1t8q.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25212>

On Wed, Aug 09, 2006 at 02:42:13PM -0700, Junio C Hamano wrote:
> Fredrik Kuivinen <freku045@student.liu.se> writes:
>
> The thing is, your patch, while I very much liked the direction
> it was taking us, was so intrusive that it scared the h*ck out
> of me ;-).
> 

I kind of suspected that :) It certainly is intrusive and it changes
revision.c which is at the very core of git.


> >> What is needed by gitweb is for git-rev-list to not only follow revisions
> >> of file contents across renames, and return more revisions, 
> >
> > Note that it is not enough to only return more revisions.
> >
> > For example, consider the commits (newest commit first)
> > A: Rename "bar" to "foo"
> > B: No changes to "bar"
> > C: No changes to "bar", delete "foo"
> > <more commits here>
> >
> > Then you want "git-rev-list --renames A -- foo" to return A,... not A,C,...
> 
> Yes.  For this "following renames for a single file" example, we
> should not extend the pathspec which originally starts out as
> "foo" to _include_ "bar"; instead it should _replace_, and after
> that point we should not care about "foo".
> 
> This was another reason I shied away from your patch back then.
> We would need to think about interactions between this pathspec
> for a single file (which should be switched) and pathspecs for
> directories ("more useful form of usage than single file", as
> Linus would put it).

I mentioned a couple of different strategies for handling the
directory case in the original mail. 

> I have this vague feeling, without revisiting the code to make
> an informed argument, that it might be cleaner and with less
> impact (read: smaller chance to break the "directories" usage)
> if we special case "follow a single file" case.  I dunno.

Yes, it most certainly is. We actually already have the "follow a
single file from a single commit" case implemented already, in
blame.c. But it is much cooler to be able to track multiple files from
several different starting points ("git-rev-list --renames A B C --
foo bar") :)   It also makes the git-rev-list interface more
consistent. No special cases such as "if you use --renames then you
can only specify one pathspec (which has to be a filename)".

> Also I was not sure how well your pathspec switching worked
> across forks and merges.
> 
>                             M bar
>            .----------------4------5
>           /                         \
>  A bar   /    R bar->foo  M foo      \     M foo
>  0------1-----2-----------3-----------6----7-------8
> 
> Suppose we are at 8 and start digging for the history of "foo".
> Our pathspec starts out as "foo" at 8 and stays so until we hit
> 6.  If the lower branch renamed bar->foo while the upper didn't,
> and merge-recursive merged them correctly at 6, we would use
> "foo" as pathspec while on the lower branch while traversing 6,
> 3 and 2 (at that point we switch to "bar").  On the upper
> branch, we switch pathspec to "bar" while traversing 6, 5, 4.
> When we hit 1, pathspec of both of its children (2 and 4) happen
> to match in this example.  But what would we do if for some
> reason they didn't?  Do we care?  Is that die("an internal
> error")?  I did not have a good anser to that question, and I
> still don't.

I _think_ that the patch as it currently is would track both files
from 1 and onwards. That is, if the upper branch tracks "foobar" when
we hit 1 and the lower branch tracks "bar" then we would track both
"foobar" and "bar" at 1 and 0.

- Fredrik
