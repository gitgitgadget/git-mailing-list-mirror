From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 10:29:08 -0500
Message-ID: <U-ySqQANiPRpld4kgzdXbovGgsj6LfOEdRmtTDU2yyvITSG3LnZAsQ@cipher.nrlssc.navy.mil>
References: <willow-jeske-01l5oEsvFEDjCjRW>	<willow-jeske-01l5PFjPFEDjCfzf-01l5oEswFEDjCZBN> <willow-jeske-01l5oJ=64=91FEDjCgQT>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Jeske <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 17:30:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBATC-0002pw-AL
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 17:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213AbYFXP3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 11:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754344AbYFXP3O
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 11:29:14 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58582 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbYFXP3N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 11:29:13 -0400
Received: by mail.nrlssc.navy.mil id m5OFT96o009472; Tue, 24 Jun 2008 10:29:09 -0500
In-Reply-To: <willow-jeske-01l5oJ=64=91FEDjCgQT>
X-OriginalArrivalTime: 24 Jun 2008 15:29:08.0839 (UTC) FILETIME=[0BA6BF70:01C8D60F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86072>

David Jeske wrote:
> As a more practical question, how do I do this workflow illustrated below?
> 
> It's sort of similar to the workflow that "git stash" is trying to support,
> except that I have a bunch of commits instead of a bunch of
> uncommitted-changes.
> 
> I pull a repository that looks like this:
> 
> .  a<--b<--c  <--master

git clone <master_repo>
cd master_repo

> 
> Then I hack away to this, and then throw my own branch on the end, along with
> master:
> 
> .  a<--b<--c<--d<--e<--f<--g  <--master (jeske)
> .                             <--feature1 (jeske)

hack hack hack
git commit -a -m 'd'
hack hack hack
git commit -a -m 'e'
hack hack hack
git commit -a -m 'f'
hack hack hack
git commit -a -m 'g'
git branch feature1


> 
> While the server looks like this:
> 
> .  a<--b<--c<--1<--2<--3  <--master (server)

git fetch

> I want to get my repository to look something like this:
> 
> .  a<--b<--c<--1<--2<--3  <--master (jeske)
> .           \
> .            d<--e<--f<--g   <-- feature1 (jeske)

git reset --hard origin/master

Side Note: you probably should have been developing on 'feature1' branch
from the start. 'reset --hard' is a special case. If feature1 is a private
branch for developing in, you may want to rebase it ontop of master and retest
before merging into master and pushing so that you can maintain a nice linear
history when possible. Or you can just merge into master and then push.

> So I can then do this:
> 
> .  a<--b<--c<--1<--2<--3<--zz  <--master (jeske)
> .           \
> .            d<--e<--f<--g   <-- feature1 (jeske)

hack hack hack
git commit -a -m 'zz'

> 
> ..and then push zz onto the server after 3.

git push

> ..and I want to do it with safe commands that won't leave any dangling
> references. (say if I forget to put the feature1 branch on)

_Don't_ forget. 'reset --hard' is named that way for a reason. If you do
forget, git makes it _easy_ to recover from.

Let's say you _did_ forget. You did the 'reset --hard' on master and then
you committed the 'zz' change without creating the 'feature1' branch.
You can still create the feature1 branch since git saved the previous state
in the reflog. It is two changes back.

git branch feature1 master@{2}

If you didn't know it was two changes back, then you can look through the
reflog using 'git log -g master'. The commit message is there along with a
reflog message describing what action was performed.



After saying all of that, here is how I think you _should_ have done things.
Notice I _did_not_ use 'reset --hard'.

git clone <master_repo>
cd master_repo
git checkout -b feature1   # we create our feature branch immediately since
                           # creating branches is so effortless in git. A
                           # private feature branch should _always_ be created
                           # and used for development.
hack hack hack
git commit -a -m 'd'       # Make our 4 commits on the feature branch
hack hack hack
git commit -a -m 'e'
hack hack hack
git commit -a -m 'f'
hack hack hack
git commit -a -m 'g'
git checkout master         # Let's go back to master
git pull                    # Fetch and merge the changes from the server
git checkout -b 'master_zz' # Create a branch for developing the zz feature
hack hack hack
git commit -a -m 'zz'       # Commit the zz feature
git checkout master         # Go back to master
git merge master_zz         # Merge zz
git push                    # And push master out
git branch -d master_zz     # Now we're done with master_zz since it's all merged in

Now you're in the same place you were above, you can continue developing your feature
on feature1 branch by checking it out. This is also were rebase comes in handy, since
you may want to rebase feature1 on top of the new current master. Once it is done and
retested, you merge it into master and push it out.

-brandon
