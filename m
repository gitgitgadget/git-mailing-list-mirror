From: Andreas Ericsson <ae@op5.se>
Subject: Re: Best way to generate a git tree containing only a subset of commits
 from another tree?
Date: Thu, 23 Mar 2006 01:44:15 +0100
Message-ID: <4421EF5F.3000601@op5.se>
References: <Pine.LNX.4.64.0603221920260.22475@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 01:44:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMDw4-0005LK-UB
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 01:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWCWAoS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 19:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWCWAoR
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 19:44:17 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:49350 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932081AbWCWAoR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 19:44:17 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id C18E66BD14; Thu, 23 Mar 2006 01:44:15 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Anton Altaparmakov <aia21@cam.ac.uk>
In-Reply-To: <Pine.LNX.4.64.0603221920260.22475@hermes-2.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17838>

Anton Altaparmakov wrote:
> As subject, what is at present the best way to generate a git tree 
> containing only a subset of commits from another tree.
> 

git format-patch -k <start-commit>..<end-commit> --stdout | git am -k

Make sure you're on the right branch first, but see below.

> So I have /usr/src/my-big-tree and /usr/src/linux-2.6 and now I want to 
> add some of the commits in my-big-tree to the tree linux-2.6 so I can push 
> out to Linus.
> 

I sense some nomenclature confusion here. By "tree", do you happen to 
mean "branch", or possibly "repository"? I know bk does things with 
trees that's vaguely git-ish, but a tree in git is, basically, just a 
simplified directory listing (without depth, although it can contain 
other trees ad infinitum iiuc).

If you mean "branch" (or repository, it doesn't matter since by then 
you'll have something like a master branch anyway), as I think you do, 
then let's assume the Vanilla Linux lives in the "linus" branch.

You would then do

    $ git checkout -b for-linus linus

followed by either multiple
    $ git cherry-pick <commit-ish>

or, if the commits are all in series, an iteration of the following

    $ git format-patch --stdout <start-commit>..<end-commit> | git am -k

If you have several topic branches, one for each series of commits, you 
should be able to do an octopus, like so:
    $ git pull . <topic-branches-to-publish>

If you *don't* have several topic branches, or if some commits aren't in 
topic-branches, you could try something like this (untested, although it 
shouldn't break anything except the for-linus branch which you can 
re-create fairly simply)

   $ for b in <topic-branches-for-linus>; do
       git checkout $b
       git rebase for-linus || (git reset --hard; echo $b >> to-merge)
     done
   # now merge what couldn't be rebased
   $ git checkout for-linus
   $ git pull . $(cat to-merge)

In your "please-pull" mail to Linus, ask him to pull the 'for-linus' 
branch. When he's done so, pull his 'master' branch to your 'linus', 
branch and remove the 'for-linus' branch and re-create it from Linus' 
master branch again. If your vanilla tree is up-to-date and he pulls 
from you before pulling from someone else or adding other commits this 
isn't necessary, although you'll have to do
    $ git checkout linus; git pull . for-linus

to get the vanilla branch up to speed with Linus' HEAD.


That turned out a bit longer than I expected, and with me being slightly 
off sobriety at the moment it would be good if someone less so could 
double-check the thinking. Incidentally, this is one of the reasons why 
topic-branches is such a Good Thing (tm).


> Preferable I would like to do it so that later when Linus has pulled from 
> my /usr/src/linux-2.6 tree, I do a "git pull" of Linus' tree from 
> /usr/src/my-big-tree and it all works correctly and I don't end up with 
> the same commits twice.
> 
> Is that possible at all?
> 

I hope so, or I just spent a good 20 minutes not drinking beer for 
nothing. ;)


> If not what can I do to do it cleanly?  Does git help in any way or do I 
> literally have to export all my commits from /usr/src/my-big-tree to diff 
> style patches and then throw away the tree, clone Linus tree after he has 
> pulled my /usr/src/linux-2.6 tree and commit all my generated diff patches 
> again?  That would be rather horrible to have to do...
> 

It's worth re-iterating:
git format-patch --stdout -k <start-commit>..<end-commit> > patch-series
git am -k patch-series

It will save you a lot of work.

> I am happy to be pointed to a FAQ or RTFM if you tell me where to look for 
> it...
> 

Hopefully I just supplied one that can be re-used with some 
text-mangling by someone capable of being legible and making sense at 
the same time.

For more info, check out the man-pages of the commands above (notably 
the cherry-pick man-page and the pull command's "merge with local" feature).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
