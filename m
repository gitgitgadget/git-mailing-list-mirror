From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: problem when pulling a specific branch from origin
Date: Wed, 2 Feb 2011 03:17:34 +0300
Message-ID: <20110202001734.GL5713@localhost.localdomain>
References: <877hdjy8d8.fsf@kanis.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ivan Kanis <expire-by-2011-02-06@kanis.fr>
X-From: git-owner@vger.kernel.org Wed Feb 02 01:17:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkQPv-0004Bo-S0
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 01:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949Ab1BBARm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 19:17:42 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:46458 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576Ab1BBARl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 19:17:41 -0500
Received: from proxysrv.domain007.com ([10.8.0.42])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p120HZbm008038;
	Wed, 2 Feb 2011 03:17:37 +0300
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id 5996EB22FF6; Wed,  2 Feb 2011 03:17:35 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <877hdjy8d8.fsf@kanis.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165881>

On Tue, Feb 01, 2011 at 06:25:55PM +0100, Ivan Kanis wrote:

> When I pull a specific branch from a repository I get in a state where
> git thinks I am ahead of the branch by one commit. The use case is a
> programmer that doesn't want to pull all the branches of the server.
> 
> I have made a small script to reproduce the problem:
> 
> ----
> #!/bin/sh
> 
> rm -rf foo bar
> git --version
> mkdir foo
> cd foo
> git init
> echo foo > foo.txt
> git add foo.txt
> git commit -am"foo"
> git checkout -b branch
> cd ..
> git clone foo bar
> cd foo
> echo bar > foo.txt
> git commit -am"bar"
> cd ..
> cd bar
> git pull origin branch
> git status
> git branch -rv
> ----
> 
> I get the following output:
> 
> ----
> git version 1.7.3.5
> Initialized empty Git repository in /home/ivan/tmp/foo/.git/
> [master (root-commit) eefa065] foo
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 foo.txt
> Switched to a new branch 'branch'
> Cloning into bar...
> done.
> [branch 7ecd065] bar
>  1 files changed, 1 insertions(+), 1 deletions(-)
> remote: Counting objects: 5, done.
> remote: Total 3 (delta 0), reused 0 (delta 0)
> Unpacking objects: 100% (3/3), done.
> From /home/ivan/tmp/foo
>  * branch            branch     -> FETCH_HEAD
> Updating eefa065..7ecd065
> Fast-forward
>  foo.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> # On branch master
> # Your branch is ahead of 'origin/master' by 1 commit.
> #
> nothing to commit (working directory clean)
>   origin/HEAD   -> origin/master
>   origin/branch eefa065 foo
>   origin/master eefa065 foo
> ----
> 
> I expected to not be ahead of origin/master and that origin/branch
> points to 7ecd065. Is this a bug? 

I'm not really sure about your expectation as you did not clearly
articulate them, so it seems there are two points to touch here...

The first one is that you seem to maintain a wrong idea about what
happens when you do `git pull origin branch`.  It appears you assume
this action is supposed to first update the local branch
"remotes/origin/branch" and then merge it to the locally checked out
branch.  The truth is that specifying a branch in this way to git-pull
(or git-fetch, which is called by git-pull) is a special case -- it
means that no corresponding local ref is updated, and the fetched line
of history is directly merged into the checked out branch right after
fetching (see the git-fetch manual and the EXAMPLES section in the
git-pull manual).
In your particular case you're merging remote branch "branch" which is
one commit ahead of remote "master" to the locally checked branch
"master" which is, at the moment, the same as the same-named remote
branch.  Consequently, after merging "branch" (which results in
fast-forward) your local branch "master" starts to be one commit ahead
of its remote counterpart; no local branches beyond this one are
updated.

The second point is less clear/more complicated.
At first, it's not clear whether you wanted to have the remote branch
"branch" become the active local branch during the cloning process, or
"master" (in your case "master" became the active branch).
On the one hand, you explicitly branched "branch" off "master" right
before cloning (updating the first repo's HEAD ref) which hints you
intended that branch to be default in the clone.
On the other hand, while the documentation says the default branch in
the clone is the one listed in the HEAD ref of the source repository, in
my tests using Git (1.7.2.x in Debian and msysgit 1.7.3.x), in cases
like yours the destination repository ends up having the "master" branch
as the default one, not the branch from the HEAD ref; to make this work,
the branch listed in the HEAD ref should have received at least one
commit after forking.  I suspect the problem might be in that such a
branch freshly cloned off "master" points to the same commit object's
name which might confuse Git.
This, in my eyes, might indeed display a bug.
