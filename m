From: Christoph Bartoschek <bartoschek@gmx.de>
Subject: Re: Git-Svn-Bridge
Date: Sun, 21 Nov 2010 21:24:44 +0100
Organization: =?UTF-8?B?VW5pdmVyc2l0w6R0?= Bonn
Message-ID: <dpbor7-rtk.ln1@homer.bruehl.pontohonk.de>
References: <227dr7-3nl.ln1@burns.bruehl.pontohonk.de> <AANLkTimH=iv5y5OdBXnVM=EVY2+FvY7dTgnLc4pZSkWP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 21 21:25:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKGTc-0001G5-AK
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 21:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509Ab0KUUZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Nov 2010 15:25:27 -0500
Received: from lo.gmane.org ([80.91.229.12]:49713 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754993Ab0KUUZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Nov 2010 15:25:26 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PKGTU-0001Ek-Sk
	for git@vger.kernel.org; Sun, 21 Nov 2010 21:25:24 +0100
Received: from p4ff4b952.dip.t-dialin.net ([79.244.185.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Nov 2010 21:25:24 +0100
Received: from bartoschek by p4ff4b952.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Nov 2010 21:25:24 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p4ff4b952.dip.t-dialin.net
User-Agent: KNode/4.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161870>

Thomas Ferris Nicolaisen wrote:

...

> I've experimented with my own "hybrid bridge" setup [2], but I've yet
> to hear whether it's wrong or can be done better. Someone on #git
> claimed it was more complicated that it had to be, but as far as I've
> heard, the setup in Loeliger's book is even worse [3] (no offense to
> his book though, I haven't read it but heard it's great).

...

> So, to shape it in form of a question: What is the optimal git-svn bridge
> setup?

I see the following advantages of the Loeliger setup:

- The master branch on the bare repository reflects the whole history. The 
branches and merges the git users perform are visible in this branch.

- The git users do not need to know about subversion.


This is how I currently understand the setup:

A.1. Clone the subversion repository to a fetching git repository:

git svn clone -s --prefix=svn/ <SVN-URL> fetch.git

A.2. Fix master to check to the correct commit:

git reset --hard svn/trunk

A.3. Create a local branch for each subversion branch to follow:

git branch branch_A svn/branch_A

A.4. Create a bare repository that is used as depot for git:

git init --bare bare.git

A.5. Push the branches to the depot:

git push --all ../bare.git
git push ../bare.git 'refs/remotes/svn/*:refs/heads/svn/*

Now the setup is done and the git users can start to clone the depot and 
continue to work. The convention is that the svn/* branches always only 
reflect the subversion history. One does not directly work on them. Work is 
done on master and the branches that have been created locally.


If there are no updates to the bare repository but changes to subversion 
then one can update the bare repository with:

B.1. Go to the fetch repository and get the newest svn data:

git svn fetch

B.2. Merge the new data to each branch that tracks a svn branch:

git checkout master
git merge svn/trunk
git checkout branch_A
git merge svn/branch_A

B.3. Push the new data to the bare repository:

git push -all ../bare.git
git push ../bare.git 'refs/remotes/svn/*:refs/heads/svn/*'


Are there shortcuts to get the commands in B.2 and B.3 in a single one?


Now changes are commited to master on the bare repository and one wants to 
push them to the subversion server. If there are changes on the subversion 
side also fetch them:

C.1: Go to the fetch repository and pull the changes from the bare 
repository:

git checkout master
git pull ../bare.git master
git checkout branch_A
git pull ../bare.git branch_A

Is there a shortcut?

C.2: Fetch changes from svn:

git svn fetch

C.3: Create detached heads from the svn branches one follows, merge the 
changes from the git branches and dcommit them:

git checkout svn/trunk
git merge --no-ff --log master
git svn dcommit

Same for branch_A.

C.4: Merge the newly created subversion commit to the git branches:

git checkout master
git merge svn/trunk
git checkout branch_A
git merge svn/branch_A

C.5: Push the new commits to the bare repository:

git push --all ../bare.git
git push  ../bare.git 'refs/remotes/svn/*:refs/heads/svn/*'


This is how I understand the setup. Do you see any mistakes or ways to 
improve it?

Thanks
Christoph
