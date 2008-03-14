From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: About detached heads
Date: Fri, 14 Mar 2008 09:42:05 -0400
Message-ID: <20080314134205.GA19674@pe.Belkin>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com> <m3lk4ly3vy.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: geoffrey.russell@gmail.com, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 15:40:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaB4r-0000nz-Oe
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 15:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539AbYCNOjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 10:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754314AbYCNOjI
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 10:39:08 -0400
Received: from eastrmmtao107.cox.net ([68.230.240.59]:60593 "EHLO
	eastrmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208AbYCNOjH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 10:39:07 -0400
X-Greylist: delayed 3420 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Mar 2008 10:39:06 EDT
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20080314134207.JNLI24940.eastrmmtao104.cox.net@eastrmimpo01.cox.net>;
          Fri, 14 Mar 2008 09:42:07 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo01.cox.net with bizsmtp
	id 11hc1Z00V0epFYL021hc4i; Fri, 14 Mar 2008 09:41:36 -0400
Received: from chris by localhost with local (Exim 4.66)
	(envelope-from <c.shoemaker@cox.net>)
	id 1JaAAf-00058H-BU; Fri, 14 Mar 2008 09:42:05 -0400
Content-Disposition: inline
In-Reply-To: <m3lk4ly3vy.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77231>

On Fri, Mar 14, 2008 at 03:52:14AM -0700, Jakub Narebski wrote:
> "Geoff Russell" <geoffrey.russell@gmail.com> writes:
> 
> > This should be simple! I have a series of commits:
> > 
> >            1---2---3---4---5
> > 
> > I want to go back to 3 but not branch, so I want
> > 
> >            1---2---3---4---5---3
> > 
> > ?
> > 
> >          git checkout 3...
> > 
> > gets me the commit on a detached head, but I don't know how to put this back
> > as the HEAD.
> 
> Lets check what git does in each of scenarios. Let's assume that
> current branch is named 'master'.
> 
> At beginning we have:
> 
>    1---2---3---4---5    <--- master <--- HEAD
> 
> HEAD contents is "ref: refs/heads/master"
> 
> 1. Now, "git checkout 3...", which is equivalent to "git checkout 3",
> detaches HEAD because commit '3' is not a head (is not a branch), so
> we have:
> 
>    1---2---3---4---5    <--- master
>            ^
>             \ 
>              \-------------- HEAD
> 
> HEAD contents is "<sha1 of 3>"
> 
> 
> 2. If we did "git reset --hard 3" we would rewind the history,
> resulting in the following situation:
> 
>    1---2---3           <--- master <--- HEAD
>             \           
>              \-4---5   <... master@{1}, ORIG_HEAD, HEAD@{1}
>               
> and now commits 4 and 5 are referenced only by reflogs, and by the
> (temporary) "last position of HEAD" reference named ORIG_HEAD.
> 
> 
> 3. Now, if you have published 1..5 history you would not want
> (usually) to rewind published branch. If you do the following:
> 
>   $ git revert --no-commit 5
>   $ git revert 4
> 
> you would get the following:
> 
>    1---2---3---4---5---(5^-1 4^-1 => 3)  <--- master <--- HEAD
> 
> git-revert applies reversal of changes in given commit, in the 
> "patch -R" ("patch --reverse") sense. Using '--no-commit' option
> allows to squash reverting two commits into one commit. The ordering
> of reverting ensures that there are no merge conflicts.
> 
> 
> 4. Or you can just put the _contents_ of revision 3 into your working
> tree, either using plumbing command git-read-tree, or by checking out
> or resetting to top tree: "git checkout 3^{tree}", or 
> "git checkout 3 -- .", or equivalent git-reset invocation.
> 
> This way you would get exactly
> 
>    1---2---3---4---5---3   <--- master <--- HEAD
> 
> but the relation of 5---3 parentage is unclear: you would have to
> explain it in the commit mesage.

[Great explanation.  Let me offer one minor clarification:]

 This way you would get exactly:
 
    1---2---3---4---5---3'   <--- master <--- HEAD
 
 While the 3' commit has the same contents as 3, it is a new, distinct
 commit with its own history.  Its commit message should explain why
 you want to go from 5 back to the contents of 3.

-chris
