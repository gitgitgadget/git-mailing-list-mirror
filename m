From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn problem: unexpected files/diffs in commit
Date: Fri, 25 Aug 2006 12:15:16 -0700
Message-ID: <20060825191516.GA8957@localdomain>
References: <m2u040n5e2.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 25 21:15:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGh9I-0001Gn-8T
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 21:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWHYTPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 15:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422778AbWHYTPU
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 15:15:20 -0400
Received: from hand.yhbt.net ([66.150.188.102]:65427 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1422747AbWHYTPS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Aug 2006 15:15:18 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id E232E7DC02E;
	Fri, 25 Aug 2006 12:15:16 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 25 Aug 2006 12:15:16 -0700
To: Seth Falcon <sethfalcon@gmail.com>
Content-Disposition: inline
In-Reply-To: <m2u040n5e2.fsf@ziti.local>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26008>

Seth Falcon <sethfalcon@gmail.com> wrote:
> Hi,
> 
> I just made an svn commit using 'git-svn commit' and ended up with a
> quite unexpected result.  
> 
> I'm using svn, version 1.3.2 (r19776) _with_ the SVN:: lib and 
> git is git version 1.4.2.g7099c (actually, I just updated and so I was
> a few commits back, but git-svn.perl didn't change, so I'm pretty
> confident that I'm current w.r.t. git-svn).

Cool that it works for you, I've yet to get SVN:: libs working with a
repository I didn't have full read access to.  I assume you have full
read access?

> Here is a copy/paste of my session (some edits since some history was lost):
> 
> ## Check for changes in svn repos and merge them in.
> 
>     ziti:~/proj/graph-git seth$ git-svn fetch
>     ziti:~/proj/graph-git seth$ git pull . remotes/git-svn
>     Trying really trivial in-index merge...
>     Wonderful.
>     In-index merge
>      DESCRIPTION            |    2 +-
>      R/AllGenerics.R        |    2 +-
>      R/clustergraph.R       |    4 ++--
>      man/distGraph-class.Rd |    6 ++++--
>      4 files changed, 8 insertions(+), 6 deletions(-)
> 
> ## I'm really where I think I am:
> 
>    ziti:~/proj/graph-git seth$ git branch
>    * master
> 
> ## Let's see what I _would_ commit if I did the normal git-svn commit
> ## thing
> 
>    ziti:~/proj/graph-git seth$ git diff --stat remotes/git-svn..master
>     inst/unitTests/graphNEL_test.R |    2 +-
>     inst/unitTests/runalltests.R   |    6 +++---
>     2 files changed, 4 insertions(+), 4 deletions(-)
> 
> ## Yeah, that looks right.

I usually check with git log remotes/git-svn..HEAD instead of git diff.
Perhaps adding --no-merges would be more correct?

> ## ok, go for the commit
> 
>     ziti:~/proj/graph-git seth$ git-svn commit remotes/git-svn..master
>     diff-tree f5ebf17f7e460d3bc3de72ab381c72dc76d26936 0681f7614c342b85b91d909ff02a9a966a44c3f4
>             M       DESCRIPTION
>             M       R/AllGenerics.R
>             M       R/clustergraph.R
>             M       inst/unitTests/graphNEL_test.R
>             M       inst/unitTests/runalltests.R
>             M       man/distGraph-class.Rd
>     r19467 = 1b75d81a95da328f0b0d06b7562fdb48970b4c98
>     RA layer request failed: OPTIONS request failed on '/bioconductor': OPTIONS of '/bioconductor': Could not read status line: SSL error: decryption failed or bad record mac (https://hedgehog.fhcrc.org) at /Users/seth/scm/bin/git-svn line 526
>     65280 at /Users/seth/scm/bin/git-svn line 547
>             main::commit_lib('0681f7614c342b85b91d909ff02a9a966a44c3f4', '0cccf3753b472b52a93154ed8021499055bb3923') called at /Users/seth/scm/bin/git-svn line 457
>             main::commit('remotes/git-svn..master') called at /Users/seth/scm/bin/git-svn line 149
> 
> 
> ## GAAAHH! That isn't what I wanted at all.  It looks as if I didn't
> ## really do the pull.  What is going on?
> 
> Despite the SSL error, the commit to svn actually went through and I
> had to back it out.  Did I do something wrong?  I did the git-svn
> fetch and pull to sync up, then reapplied my patch and git-svn commit
> "worked" although I got the same SSL error.
 
I haven't been able to reproduce the SSL error message consistently,
but I have seen it[1].  It could be SSL having state information that gets
screwed up with the forking git-svn does to avoid memory leaks in SVN::

Outside of the SSL problems, the mis-commit isn't strictly user-error,
but git-svn is confusing in this case, as the documentation is unclear
about what git-svn should do in this case :x

Simple answer: instead of pull, you should've used git rebase.  But I
don't think the documentation makes it clear at all.

I've been really slacking on the git-svn documentation the past few
months, help would be much appreciated.

Here's an in-depth explanation:

This is what git-svn does when issued "commit remotes/git-svn..master":
1. git-rev-list remotes/git-svn..master | tac =>
	0681f7614c342b85b91d909ff02a9a966a44c3f4
	0cccf3753b472b52a93154ed8021499055bb3923

0cccf3753b472b52a93154ed8021499055bb3923 is the result of your
'git pull . remotes/git-svn', correct?
And 0681f7614c342b85b91d909ff02a9a966a44c3f4 was made to git before
the pull.

So this is what git-svn does, it commits the output of:
diff-tree f5ebf17f7e460d3bc3de72ab381c72dc76d26936 0681f7614c342b85b91d909ff02a9a966a44c3f4
(f5eb... is remotes/git-svn at that point).

If the SVN/SSL connection had not died, it would've then proceeded to
commit the output of:

diff-tree 1b75d81a95da328f0b0d06b7562fdb48970b4c98 0cccf3753b472b52a93154ed8021499055bb3923
Where 1b75d81a95da328f0b0d06b7562fdb48970b4c98 is the output of your
previous commit (r19467)

Personally, I've been starting to favor 'git-svn commit-diff' myself
over 'git-svn commit', as it leaves cleaner history and makes git-svn
fetch results reproducable on different machines.

[1] - unfortunately, I seem to have forgotten about it since I use
commit-diff more often these days :x

-- 
Eric Wong
