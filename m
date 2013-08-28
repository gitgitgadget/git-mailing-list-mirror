From: "Brecht Machiels" <Brecht.Machiels@kla-tencor.com>
Subject: Re: BUG: git subtree split - revert commit followed by a merge
Date: Wed, 28 Aug 2013 09:59:28 +0200
Organization: KLA-Tencor
Message-ID: <op.w2ioheg99vfd47@bel1pc-0098.adcorp.kla-tencor.com>
References: <E71F820BDC168F4B91A464A8FD8ABBD8389BD9C7@CH1PRD0310MB391.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: apenwarr@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 28 10:05:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEakn-0003Qp-NB
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 10:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797Ab3H1IFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 04:05:11 -0400
Received: from plane.gmane.org ([80.91.229.3]:46328 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607Ab3H1IFG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 04:05:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VEakQ-00036S-Jq
	for git@vger.kernel.org; Wed, 28 Aug 2013 10:05:02 +0200
Received: from 192.146.11.2 ([192.146.11.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 10:05:02 +0200
Received: from Brecht.Machiels by 192.146.11.2 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 10:05:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 192.146.11.2
User-Agent: Opera Mail/1.0 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233179>

Hi,

I think I understand what's going on. If there are no net changes in one  
of the two branches, the id of the merge commit will be the same as that  
of the last commit on the other branch (pass the -d option to 'git subtree  
split' to see the new commit id's of the split out commits). In that case,  
git-subtree will drop the merge commit. I believe this is done because for  
regular commits, this means that the commit does not make changes to files  
in the subtree directory. I'm not sure I'm right about this, as I would  
expect the merge commit's hash to depend on the hashes of its parent  
commits.

I was thinking the solution would be to simply adjust the copy_or_skip  
function to always copy merge commits. However, this may result in the  
produced commit history to differ from before (unnecessary merge commits  
were previously left out), leading to other problems.

A solution might be to check for the presence of such commit +  
revert-commit branches. This can be done by checking for each parent of a  
merge commit if it is the ancestor of any of the other parents (using git  
merge-base --is-ancestor).

Best regards,
Brecht

On Tue, 27 Aug 2013 15:09:30 +0200, Machiels, Brecht  
<Brecht.Machiels@kla-tencor.com> wrote:

> Hello:
>
> I'm running into the problem described in this mailing list post:
> 	http://thread.gmane.org/gmane.comp.version-control.git/202645
>
>  'git subtree split' fails to reconstruct the history when a revert  
> commit is followed by a merge commit. I have slightly adjusted the test  
> script provided by Fabien in his mailing list post:
>
>     git init
>    # create a directory that is going to be split
>     mkdir doc
>     echo "TEST" > doc/README
>     git add doc
>     # commit A
>     git commit -a -m"first version"
>    # create a branch with a new commit (Z)
>     git checkout -b test
>     echo "TEST" > doc/README1
>     git add doc/README1
>     git commit -a -m"added README1"
>     git checkout master
>    # modify the README file (commit B)
>     echo "TEST_" > doc/README
>     git commit -a -m"second version"
>    # revert the change (commit C)
>     echo "TEST" > doc/README
>     git commit -a -m"revert second version"
>     # or use git revert HEAD^
>    # split
>     git subtree split --prefix="doc" --branch=TARGET
>    # add another commit (to a file *not* in the subtree dir)
>     echo "BLA" > BLA
>     git add BLA
>     git commit -a -m"third version"
>    # adding another commit to a file in the subtree dir will "fix" things
>     #echo "MEH" > doc/MEH
>     #git add doc
>     #git commit -a -m"fourth version"
>
>     # the log will show the 3 commits as expected (including B and C)
>     GIT_PAGER= git log --oneline TARGET
>    # merge the test branch
>     git merge -m"merged test" test
>    # attempt to re-split; this will fail
>     git subtree split --prefix="doc" --branch=TARGET
>    # see what history split generates
>     git subtree split --prefix="doc" --branch=TARGET2
>
> I have discovered that if the revert commit is followed by another  
> commit that makes changes in the subtree directory, the split will work  
> as expected (see "fourth version" above).
>
> See also this related SO question where I ask for a workaround:  
> http://stackoverflow.com/questions/18465867
