From: Gaspard Bucher <gaspard@teti.ch>
Subject: Re: keep a subversion mirror in sync
Date: Wed, 17 Sep 2008 21:04:54 +0200
Message-ID: <5F812637-559B-4454-B624-30CCF5E07351@teti.ch>
References: <B529992F-3C09-4708-A3F4-645DB23DF158@teti.ch> <32541b130809171052q4e32e353ld3fdd109d0d34b00@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 21:06:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg2MK-0002QW-Lv
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 21:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754423AbYIQTF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 15:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754381AbYIQTF3
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 15:05:29 -0400
Received: from vserv96.swisslink.ch ([217.162.2.96]:39280 "EHLO teti.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754093AbYIQTF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 15:05:28 -0400
Received: from 95-62.0-85.cust.bluewin.ch ([85.0.62.95] helo=[10.0.0.13])
	by teti.ch with esmtpa (Exim 4.63)
	(envelope-from <gaspard@teti.ch>)
	id 1Kg2EZ-0000RY-IE; Wed, 17 Sep 2008 20:58:40 +0200
In-Reply-To: <32541b130809171052q4e32e353ld3fdd109d0d34b00@mail.gmail.com>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96133>

I am the only one writing to the subversion repository. It's just a  
public "read-only" mirror.

After I dcommit, I get a merge commit that's added to the master  
branch. The "origin/master" does not have this merge commit. When I  
pull from origin/master, I get a conflict
for all modified files. Reading the docs, it says "Running git-merge  
or git-pull is NOT recommended on a branch you plan to dcommit from".

I think I will use svk to handle this sync problem.

SETUP:
1. svk mirror svn://... //mirror/foo
2. svk sync //mirror/foo
3. svk co //mirror/foo
4. cd foo
5. svk ps svn:ignore ".git" .
6. cd ..
4. rm -rf foo
5. git clone git@... foo
6. cd foo

SYNC:
1. get the last commit message from git and use it to sync back
"git log -1 --pretty=short --no-color > /tmp/git_svk_msg && svk ci -- 
import -F /tmp/git_svk_msg && rm /tmp/git_svk_msg"

I have tried this setup and it works fine. The fact that svk and git  
totally ignore each other is really nice in this situation.

I thought there would be an easier path, but finally the solution here  
seems good, as long as the "master" branch does not contain uncommited  
content.

Gaspard

> On Wed, Sep 17, 2008 at 7:58 AM, Gaspard Bucher <gaspard@teti.ch>  
> wrote:
>> I have been trying different strategies to keep subversion  
>> repository in
>> sync with a git repository (on github).
>>
>> Some details with pictures can be found here:
>> http://zenadmin.org/en/documentation/page439.html.
>>
>> I have tried to use a single database to pull/push from github and  
>> dcommit
>> to the old subversion repository but I get lots of conflicts and  
>> duplicates
>> (see link above).
>>
>> I have then tried to create a "pull" only clone to dcommit, but it  
>> looses
>> the commit messages and replaces then with a merge message. At  
>> least this
>> solution keeps the github repository clean.
>>
>> What is the canonical way to do this ?
>
> The bad news is that a fully automatic two-way sync with svn is pretty
> much impossible, AFAIK.  The act of committing to svn adds a
> git-svn-id line to your commit, so your old commit object needs to be
> thrown away and replaced with a new commit object.  This makes
> everybody else's git commits totally confused.  It's possible that the
> svn.noMetaData option will avoid this problem, but I've never tried
> it, and it's dangerous: if you lose your svn rev-map database, you
> can't get it back.
>
> As for dcommits losing commit messages... yes.  There is no way to
> represent the idea of parallel development in svn without creating
> branches.  For example, if we fetch from svn at point A, and person #1
> commits to svn based on point A producing point B, and person #2
> commits to git based on point A producing point C, then in order to
> have git-svn send point C back into svn, it will have to merge points
> B and C.
>
> Git can do the merge with no problem, but now it has to commit the
> changes from the merged version into svn.  It doesn't make sense to
> commit *each* of the commits from A to C, because it would have to do
> it *on top of* B.  The best it can do it commit the entire set of
> changes as a merge commit.
>
> You have two options:
>
> 1) Manually git-rebase the changes from A..C onto B, then hurry up and
> dcommit them before someone else commits to svn before you (otherwise
> you'd have to rebase again).  git svn dcommit will then be smart
> enough to commit each one separately.
>
> 2) Accept the merge commit.  The good news is that in the git repo,
> history will still have all the interesting information; svn's history
> isn't wrong, it's just incomplete.
>
> You could also try to modify git-svn to implement a third solution:
>
> 3) Create a temporary branch in svn by copying commit A.  Commit each
> of the changes from A..C in that branch one by one, then create a
> merge back on the real branch that merges your temporary branch in,
> using the commit message and files from your git merge commit.
>
> Option #3 sounds hairy and gross, so it would be a lot of work and
> there's no guarantee your patch would be accepted.
>
> Basically, svn's limited ability to express history is preventing you
> from committing your "full" git history back into svn.
>
> At work, I currently use option #2.  As long as the full history is
> available *somewhere*, the world is an okay place.
>
> Have fun,
>
> Avery
