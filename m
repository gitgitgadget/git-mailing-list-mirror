From: Nicolas Pitre <nico@cam.org>
Subject: confusion over the new branch and merge config
Date: Thu, 21 Dec 2006 17:17:02 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Dec 21 23:17:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxWDs-00047X-B1
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 23:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423119AbWLUWRF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 17:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423120AbWLUWRE
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 17:17:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:44104 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423119AbWLUWRD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 17:17:03 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JAN00G4M9WEXSD0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 21 Dec 2006 17:17:02 -0500 (EST)
X-X-Sender: nico@xanadu.home
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35090>


OK I know I'm a total idiot and honnestly I didn't look at the code 
implementation at all because I don't expect newbies to even look there.  

But here's some pitfalls I'm sure people are likely to encounter...

$ git clone git://git.kernel.org/pub/scm/git/git.git git
Initialized empty Git repository in /home/nico/test/git/.git/
remote: Generating pack...
remote: Done counting 34527 objects.
remote: Deltifying 34527 objects.
remote:  100% (34527/34527) done
Indexing 34527 objects.
remote: Total 34527, written 34527 (delta 23920), reused 34111 (delta 23623)
 100% (34527/34527) done
Resolving 23920 deltas.
 100% (23920/23920) done
Checking files out...
 100% (748/748) done

[ wooh! I feel good ]

$ cd git
$ git branch
* master

[ Hmmm... there used to be many more (remote) branches before.  Where 
  are they? Looking into .git/refs I see a remote/ directory and all 
   remote branches are there.  But I'm cheating now because a newbie 
   might not even think of looking there.

   Ah? there is -a and -r options to git-branch.  Fair enough. ]

$ git branch -r
* master
  origin/HEAD
  origin/html
  origin/maint
  origin/man
  origin/master
  origin/next
  origin/pu
  origin/todo
$ git checkout next
error: pathspec 'next' did not match any file(s) known to git.
Did you forget to 'git add'?

[ WTF!?!?  This definitely used to work before.  OK it is listed as
  "origin/next" so let's try to be consistent. ]

$ git checkout origin/next
git checkout: to checkout the requested commit you need to specify
              a name for a new branch which is created and switched to

[ Hmmmmmmmm.... /me stares at the message wondering.
  I just want to _see_ and maybe _install_ the code from "next". ]

$ git checkout origin/next local_next
error: pathspec 'local_next' did not match any file(s) known to git.
Did you forget to 'git add'?

[ But it just said to me above that I needed to provide a name for the 
  branch to be switched to...  Why doesn't it just work? F***ing tool!

  OK I'll use my git knowledge and cheat again. ]

$ git checkout -b local_next origin/next

This is I think a good example where user experience might still be 
improved.  First the message about "providing a name for a new branch" 
could certainly be less anbigous.

Then the "next" branch name could possibly be made to work without the 
"origin/" if there is no conflict?

And there was a discussion about allowing checkouts to be made from a 
remote branch but not allowing any commit on it.  What happened of this 
idea?

Now that I have my local_next branch, I want it to be kept up to date 
when performing a pull.  Before the "next"  branch sort of was always 
updated, but now it is a separate thing I cannot see directly and I need 
to pull it in my local version.

$ git pull origin/next
fatal: The remote end hung up unexpectedly
Cannot get the repository state from git://git.kernel.org/pub/scm/git/git.git/next

[ WTF?  Where that ...pub/scm/git/git.git/next comes from?  Hmmm... ]

$ git pull next
fatal: 'next': unable to chdir or not a git archive
fatal: The remote end hung up unexpectedly
Cannot get the repository state from next

[ ... an even more interesting set of error messages.

  Yeah, Linus says you must use git-pull . blah syntax. ]

$ git pull . next
error: no such remote ref refs/heads/next
Fetch failure: .
$ git pull . origin/next
error: no such remote ref refs/heads/origin/next
Fetch failure: .

[ F**K YOU STUPID TOOL !!!  OK let's cheat a bit again. ]

$ git pull . remotes/origin/next
Already up-to-date.

[ Woooh!  But since I always hated this syntax let's try merge instead. ]

$ git merge origin/next
Already up-to-date.

OK here again various error messages could be improved.  The fact that a 
remote connection was established in some cases is really dubious.  And 
git-pull not accepting "origin/next" is IMHO a bug.

Well well... But I don't want to perform this two-step 
git-pull+git-merge all the time.  So let's have a look at this promising 
warning:

$ git pull origin
Warning: No merge candidate found because value of config option
         "branch.local_next.merge" does not match any remote branch fetched.
No changes.

So this means that branch.local_next.merge should be set to origin/next?  
Let's have a look at the default in .git/config:

[remote "origin"]
        url = git://git.kernel.org/pub/scm/git/git.git
        fetch = refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master

But according to the warning above, branch.master.merge should have been 
set to refs/remotes/origin/master, not refs/heads/master, right?  
Otherwise does this mean that master will merge itself into itself?

This is where my own git experience stops as I don't understand the 
above for real.  So let's see the doc:

|branch.<name>.merge::
|        When in branch <name>, it tells `git fetch` the default refspec to
|        be marked for merging in FETCH_HEAD. The value has exactly to match
|        a remote part of one of the refspecs which are fetched from the remote
|        given by "branch.<name>.remote".
|        The merge information is used by `git pull` (which at first calls
|        `git fetch`) to lookup the default branch for merging. Without
|        this option, `git pull` defaults to merge the first refspec fetched.
|        Specify multiple values to get an octopus merge.

Hmmmmmmm... Even after reading this twice I'm still not sure what it 
really means. But as I said at the top I'm an idiot.


Nicolas
