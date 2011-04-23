From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH 00/23] RFC: Introducing git-test, git-atomic, git-base
 and git-work
Date: Sat, 23 Apr 2011 11:13:00 +0200
Message-ID: <20110423091300.GC9206@m62s10.vlinux.de>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 23 11:13:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDYu7-0000nd-2y
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 11:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab1DWJNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 05:13:07 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:43171 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752768Ab1DWJNF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 05:13:05 -0400
Received: (qmail invoked by alias); 23 Apr 2011 09:13:02 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp051) with SMTP; 23 Apr 2011 11:13:02 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+laIJJFb2lBJfY0/Kn0/thgiELbMl+wQ74hhHq6X
	dCKkFaFluGP6H0
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id C9D56D4037; Sat, 23 Apr 2011 11:13:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171978>

On Sat, Apr 23, 2011 at 05:22:29PM +1000, Jon Seymour wrote:
> This series is posted in order to solicit feedback about some commands I'd like to propose for inclusion in git. 
> 
> The commands are:
>    git test
>    git atomic
>    git base
>    git work
> 
> git work
> ========
> 
> git work depends on the other 3 commands. 
> 
> git work is the command I have been using every day myself for the last 8 months. It is the primary means
> I use to manage my working tree.
> 
> The basic idea of git work is to help manage a private working tree using the following principles:
> 
> * all dependencies received from others are merged into the 'base' of the working tree
> 
>   git work merge some-dependency
> 
>      - merges some-dependency into $(git base) producing (1)
>      - rebases $(git base)..HEAD onto (1) producing (2)
>      - resets the current branch to (2)
>      - updates $(git base) to refer to (1)
> 
> * all unpublished work is managed as a linear sequence of commits on top of the 'base' of the working tree
> 
>   so, 
>    git work --as-refs # shows you a symbolic range for your current work
>    git work # shows you a SHA1 range for your current work
>    gitk $(git work) # shows you your unpublished work
>    git diff $(git work) # shows you the diff of your current work
> 
> * prior to publishing work, you rebase it onto an appropriate base commit
> 
>   so,
> 
>   git branch topic upstream/master # choose the base commit for the topic
>   git work update topic HEAD~3     # pull the top 3 commits off the working tree onto the topic
> 
>     - rebases HEAD~3..HEAD onto topic to produce (1)
>     - merges topic into $(git base) to produce (2)
>     - rebases $(git base)..HEAD~3 onto (2) to produce (3)
>     - resets the current branch to (3)
>     - resets $(git base) to (2)
> 
> The nice thing about managing your work tree this way is that your working tree remains
> relatively stable (it always contains everything you have recently been working on)
> and your topic branches remain clean (i.e. they never contain any other cruft from your 
> working tree).

Reading this I have to admit I don't fully grok it, but it *sounds* like a solution
to my problematic workflow. Perhaps you can supply some examples, because reading 
the unit tests for git work hasn't enlightened me.

Ok, let me explain what I am aiming for:

I am stuck with git-svn (our customer is not yet ready to use git) and therefore have
a remote branch remotes/trunk tracking the trunk in SVN. Then there is at least one
debug branch which contains several commits only used to debug problems or to speed
up testing (e.g. avoid popping up error dialogs that some hardware is missing on one
of our test platforms, or to add more logging statements not suitable for the mainline).
Furthermore, there are several feature branches, lets call them topic{1, ...N}


               . -  q - q     <- topic3
              /
           . -s - s - s       <- topic2
          /
         /    t - t - t       <- topic1
        /   / 
       /   /
   o - o - o - o - o - o - o  <- remotes/trunk, master
                \
                  d  - d      <- debug 
           


If I want to deploy the software onto our target machine, I want to have
the code of several branches merged/combined to test them in integration.
If I suspect problems in one of the topics, I at least must have the 
topicX, debug and the upstream branch remotes/trunk.
 
So my workflow would have been - if it weren't clumsy - the following

  git checkout master
  git merge debug topic1 topic2 topic3
  ... compile ... deploy ... test

               . -  q - q -.       <- topic3
              /             \
           . -s - s - s ---. \     <- topic2
          /                 \|
         /    t - t - t - - -\     <- topic1
        /   /                 m    <- master
       /   /                / | 
   o - o - o - o - o - o - o  |    <- remotes/trunk
                \            /
                  d  - d - -       <- debug 
 
Having fond a small error, I can't commit it directly on the merge m, because
It is actually a fix a topic branch. Running git checkout topicX before doing
any change is also not an option, because I often forget to checkout the topic
before commiting. And rebasing afterwards is also not that easy, because there
is merge m in between.  So this isn't what I actually use, but would be *iff*
there where some sort of tool support to help me. 

What I end up doing is the following:

- o - o   <- remotes/trunk
       \
         d - d   <- debug
              \
                t - t -t  <- topic1
                        \
                          s - s -s  <- topic2
                                  \
                                   q - q   <- topic3, master
                                        
                                        
The topic branches are just there for illustration, I normally do not track
those explicitly with git branches, as master is rebase often on top of trunk,
thanks to git-svn. Now if I do want to commit a topic branch to SVN, I rebase
so that my history is now   trunk - topic1 - debug - topic2 - topic3, master
and then run git checkout topic1; git svn dcommit to make sure only the commits
in topic1 are commited.

All in all, this workflow is not perfect, but at least it sort of works.

Now back to my initial question: 
Could your new "git work" command help me to adjust my workflow and ease the pain?

Greetings,
Peter


> git base
> ========
> 
> git base is a command that is heavily relied on by git work, and is occasionally used by
> the user to reset the base of their working tree.
> 
> git base tries to automagically maintain the base of the working tree by maintaining
> an invariant that the path between the base and the tip of the current branch should
> never traverse a merge. If it ever finds the invariant violated, it calls 'git base reset'
> to attempt to restore the invariant. 
> 
> For more information about git base, refer to the Documentation/git-base.txt
> 
> git atomic
> ==========
> git atomic is more an experiment than anything else. The idea is to run another git operation "atomically".
> The git operation either succeeds or it fails. If it fails, git branch attempts to restore the
> working tree and current branch to the state they were in to their original state prior to the comamnd being run.
> 
> The reason I need something like this is that git work performs several operations in sequence some
> of which I can't guarantee will work. I don't want the user to work out what they have to do
> to recover, so I try to restore to the state they were originally in.
> 
> Note: the current implementation doesn't handle rebase failures properly and would probably needed
> to be cleaned up a little before being accepted into the mainline.
> 
> git test
> ========
> This is another experiment. The idea is to provide a uniform way to test for various conditions
> into the working tree, index and repo. For example:
> 
>     git test --not-unstaged --branch-exists foobar
> 
> will fail if there are unstaged files in the working tree or the branch foobar does not exist.
> 
> As I say, git atomic and git test are somewhat experimental. I don't really care about those commands
> and if the consensus is that git doesn't need them, I am happy to rework git base and git work
> to not use them.
> 
> However, I would like to propose git base and git work as being very useful additions to the git toolset.
> 
> Let me know if the consensus is that I should proceed with a submission and I will prepare one.
> 
> Jon Seymour (23):
>   Introduce git-test.sh and git-test-lib.sh
>   Introduce --unstaged.
>   Introduce --staged
>   Introduce --untracked.
>   Introduce --conflicted
>   Introduce --rebasing
>   Introduce --detached
>   Introduce --branch-exists
>   Introduce --tag-exists
>   Introduce --ref-exists
>   Introduce --commit-exists.
>   Introduce --checked-out
>   Introduce --reachable
>   Introduce --tree-same.
>   Introduce --same
>   misc
>   whitespace fix.
>   tests --conflicted.
>   rebasing: add tests
>   test: git test cleanups.
>   Introduce git-atomic.
>   Introduce git base.
>   Introduce support for the git-work command.
> 
>  .gitignore                   |    7 +
>  Documentation/config.txt     |   10 +
>  Documentation/git-atomic.txt |   92 ++++++++
>  Documentation/git-base.txt   |  216 ++++++++++++++++++
>  Documentation/git-test.txt   |  182 +++++++++++++++
>  Documentation/git-work.txt   |  163 ++++++++++++++
>  Makefile                     |    7 +
>  git-atomic-lib.sh            |   58 +++++
>  git-atomic.sh                |    5 +
>  git-base.sh                  |  378 +++++++++++++++++++++++++++++++
>  git-conditions-lib.sh        |  176 +++++++++++++++
>  git-test-lib.sh              |  188 ++++++++++++++++
>  git-test.sh                  |   11 +
>  git-work.sh                  |  323 +++++++++++++++++++++++++++
>  t/t1520-test.sh              |  506 ++++++++++++++++++++++++++++++++++++++++++
>  t/t3418-base.sh              |  214 ++++++++++++++++++
>  t/t3419-atomic.sh            |   59 +++++
>  t/t3421-work.sh              |  174 +++++++++++++++
>  18 files changed, 2769 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/git-atomic.txt
>  create mode 100644 Documentation/git-base.txt
>  create mode 100644 Documentation/git-test.txt
>  create mode 100644 Documentation/git-work.txt
>  create mode 100644 git-atomic-lib.sh
>  create mode 100755 git-atomic.sh
>  create mode 100644 git-base.sh
>  create mode 100644 git-conditions-lib.sh
>  create mode 100644 git-test-lib.sh
>  create mode 100755 git-test.sh
>  create mode 100644 git-work.sh
>  create mode 100755 t/t1520-test.sh
>  create mode 100755 t/t3418-base.sh
>  create mode 100755 t/t3419-atomic.sh
>  create mode 100755 t/t3421-work.sh
> 
> -- 
> 1.7.5.rc1.23.g7f622
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
