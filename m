From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Looking for a way to set up Git correctly
Date: Thu, 11 Nov 2010 10:46:06 -0600
Message-ID: <20101111164606.GA16972@burratino>
References: <BD94CB4FDD0C4462804E316F814A3CCA@denny>
 <20101111132502.GB23423@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Enrico Weigelt <weigelt@metux.de>
To: Dennis <denny@dennymagicsite.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 17:46:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGaIJ-0007LL-ET
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 17:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488Ab0KKQqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 11:46:33 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38592 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360Ab0KKQqd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 11:46:33 -0500
Received: by vws13 with SMTP id 13so385079vws.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 08:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ovn/c9g0QHziYvVITx74td/vNnzQ4q0kTh1Z3Hua7Uw=;
        b=ktxRAUYuP0loctYM2Ud5WktSd/NzWVaSwJIoz4hCB2hcgVCnIUhkymq0/ExxVNF9eG
         dhkyq54MbamqP9d4hcZ7n1oEfQmsVZfeBfWhGVyVgfaiPsSeJawkM2lMfLHZXVOKlOho
         kUMEbDiNddGSYo9O//Mc7WjesU1o/WH7CRAjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BaWf0BzXqiaAmTYTfEMi0FVRZGtLklEMbLyWNRO+DaqopmX/YGipHrP5rp+hO3XQHX
         gmPpugUAwdObcr+q5E2FpG1O6b6o1QChFPFUptqBqixaqQwgOg/hAtoBCygXWI0kJ54G
         jW1Hu0xQZQVmx9QsUIigVOQxt+bfKUHwaSXhk=
Received: by 10.220.95.208 with SMTP id e16mr226131vcn.176.1289493991792;
        Thu, 11 Nov 2010 08:46:31 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id x26sm802337vbw.18.2010.11.11.08.46.29
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 08:46:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101111132502.GB23423@nibiru.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161268>

(+cc: Dennis again, Alex)

Hi,

Enrico Weigelt wrote:
> * Dennis <denny@dennymagicsite.com> wrote:

>> Now, this can be either really simple or really complicated.  My first 
>> question is:  how do I set the repository up in the proper way where I 
>> could work on all 3 projects separately, with additional possibility of 
>> working on branch1 only and later committing my changes to branch2 and 
>> branch3.  
>
> As first step you could create 3 separate git repos in each directory
> and add everything to it (git init, git add -A, git commit). Then 
> rename the branches properly (so instead of "master", they'll be called
> "branch1", "branch2", "branch2" or something like that). Create another
> (maybe bare) repo elsewhere, add it as remote to the three other ones
> and push their branches upwards.

So this looks like so:

	for i in project1 project2 project3
	do
		(
			cd "$i"
			git init
			git add .
			git commit
		)
	done
	git init main
	cd main
	for i in project1 project2 project3
	do
		git fetch ../$i master:$i
	done
	mv project1 project2 project3 away/

If you would like multiple worktrees (one for each branch, maybe) for
the main repo, you might want to look into the new-workdir script in
contrib/workdir (but do consider the caveats[1]).

>> (Since projects are virtually identical, a fix in one branch 
>> usually needs to be propagated to other branches)
>
> In your case, cherry-pick might be the right for you.

e.g., when project3 gets a new fix:

	git checkout project1
	git cherry-pick project3

> You could also do a little bit refactoring, making a 4th branch which
> the other 3 are then rebased onto.

Right, what is the actual relationship between these projects?  Do
they actually represent branches in the history of a single project?

Suppose project1 is historically an ancestor to project2, project3,
and project4, which are independent.  (Maybe project1 is the initial
version and projects 2,3,4 are ports to other platforms.)  You could
take this into account when initially setting up the branches, like
this:

	git init main
	cd main
	GIT_DIR=$(pwd)/.git; export GIT_DIR
	GIT_WORK_TREE=../project1 git add .
	GIT_WORK_TREE=../project1 git commit
	git branch -m project1
	for i in project2 project3 project4
	do
		git checkout -b $i project1
		GIT_WORK_TREE=../$i git add -A
		GIT_WORK_TREE=../$i git commit
	done

(and use gitk --all when done to make sure everything looks right)

Alternatively, you can rearrange the history afterwards:

	$ git cat-file commit project2 | tee project2
	tree 76db51024713f6ef191928a8445d48d39ab55434
	author Junio C Hamano <gitster@pobox.com> 1289324716 -0800
	committer Junio C Hamano <gitster@pobox.com> 1289324716 -0800

	project2: an excellent project
	$ git rev-parse project1
	$ vi project2
	... add a "parent <object id>" line
	    after the tree line,
	    where <object id> is the full object name rev-parse printed ...
	$ git hash-object -t commit -w project2
	$ git branch -f branch2 <the object name hash-object prints>
	... repeat for project3 and project4 ...
	$ gitk --all;		# to make sure everything looks right

This is less convenient than it ought to be.  It would be nice to add
a "git graft" command to automate this procedure, which

 - interacts well with "git replace"
 - doesn't interact poorly with "git fetch" like .git/info/grafts does
 - could be more convenient to use than .git/info/grafts.

As the gitworkflows man page mentions, if you make your fixes on the
oldest branch they apply to (project1) and then merge to all later
branches, then the fixes will propagate forward correctly.  See the
"Graduation" and "Merging upwards" sections of gitworkflows for details.

>> My second question is that each branch has a huge folder with image data. 
>> By huge I mean 1 to 4Gb, depending on the branch.  Since images are not 
>> directly relevant to the development work, is there a way to not include 
>> those folders in git?

I would suggest tracking a symlink to another repository (or to a
directory tracked through other means, like unison).

Hope that helps,
Jonathan

[1] If you have two worktrees for the same project with the
same branch checked out at a given moment, the results can be
confusing (changes made in one worktree will look like they have
been commited and undone in the other).

The "detached HEAD" feature (which git-checkout.1 explains) and
multiple worktrees do not interact so well: the need to preserve
commits while no branch was checked out in one worktree will not be
taken into account when "git gc" runs (explicitly or implicitly!) on
the other.  This can be very disconcerting.
