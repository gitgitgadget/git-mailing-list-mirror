From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: merge removed content back into current content
Date: Tue, 28 Sep 2010 11:49:10 -0500
Message-ID: <i7t6ct$o94$1@dough.gmane.org>
References: <i7jp1a$kc0$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 18:50:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0dOG-00019W-2r
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 18:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756877Ab0I1Qus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 12:50:48 -0400
Received: from lo.gmane.org ([80.91.229.12]:39906 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756866Ab0I1Qur (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 12:50:47 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P0dOA-00017L-HA
	for git@vger.kernel.org; Tue, 28 Sep 2010 18:50:46 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 18:50:46 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 18:50:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Response
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157443>


"Neal Kreitzinger" <neal@rsss.com> wrote in message 
news:i7jp1a$kc0$1@dough.gmane.org...
> How do I tell git to merge a single program from an old commit into the 
> current version of that program in the HEAD commit?  In this scenario, I 
> want to get back some removed code but still keep the new code.
>
> e.g.
>
> Commit-1 = initial commit containing Program-A, and other programs
>
> Commit-2 = add Changeset-1 to Program-A , and make changes to other 
> programs
>
> Commit-3 = remove Changeset-1 from Program-A, then add Changeset-2 to 
> Program-A, and make changes to other programs
>
> *desired* Commit-4 = only merge Program-A from Commit-2 into Program-A of 
> Commit-3, and don't change any other programs
> (in other words, get my old changes from Commit-2 back, but don't loose 
> the new changes from Commit-3)
>
Here is a method for invoking git merge and git mergetool, but its very 
onerous and I'm hoping there's a more straightforward method to merge using 
the index so let me know if you have something better.  I've published these 
steps to my coworkers to answer their request for merging just two programs 
(as opposed to 2 commits), but it seems pretty ridiculous to have to go thru 
all of this just to merge one version of a program into another.

Using git diff commit-2 commit-3 -- Program-A and then using kdiff3's merge 
option is pretty easy, but is not using the index, conflicts, or 
git-mergetool (common ancestor 3-way merge) so I'm not crazy about it, but I 
have to recommend it over the cherry-pick because its so straightforward and 
the cherry-pick is so convoluted.  I feel like I'm going around git when I 
use git difftool (kdiff3 merge) to do this and that I'm going thru git when 
I use the cherry-pick methods below, but they are way more work!

Cherry-pick methods:

Possibly a more correct way to perform the merge is to let git run the merge 
and generate conflicts for you to resolve like any other git merge with git 
mergetool utilizing the common ancestor history.



Scenario:  use git to merge an old program version into the current program 
version and git-mergetool to resolve conflicts.  The old version does not 
reside in a commit by itself so therefore that commit cannot be cherry 
picked.



Assuming you are on already on a branch that contains the old version and 
new version of program in its history.

(1)  In gitk view the changes made to the program in question

$ gitk 12.5/Generic/Base -- SRC/SALES/SALEOUT

(2)  Right click on the commit containing the old version of the program and 
tag it, e.g. WKTG/MRG/Theirs/SALEOUT

(in a merge, "ours" = version in current branch HEAD, "theirs" = version 
from other branch being merged into current branch)



Decision:

If commit containing old version contains a few other objects with changes:

(3) Cherry-pick the commit onto your branch.

$ git cherry-pick WKTG/MRG/Theirs/SALEOUT (Cherry pick will inform you of 
conflicts)

(4) Discard the cherry-picked objects you don't want.

$ git checkout --ours otherobject1 otherobject2 otherobject3 etc.

(5) Merge your program with git-mergetool.

$ git mergetool (Merge the stuff using kdiff3)

$ git add SRC/SALES/SALEOUT

$ git commit -c WKTG/MRG/Theirs/SALEOUT (Cherry pick will tell you exactly 
how to do the git commit -c)

You're Done.



If commit containing old version contains "too many" other objects with 
changes, it may be faster to do this:

(3) Create a branch that points to MARK/MRG/Theirs/SALEOUT

$ git checkout -b WKBR/MRG/Theirs/SALEOUT WKTG/MRG/Theirs/SALEOUT

(4) Split the commit to isolate the "cherry" (the old version of the 
program) that you want to pick.

$ git rebase -i --onto WKBR/MRG/Theirs/SALEOUT~1 WKBR/MRG/Theirs/SALEOUT~1 
WKBR/MRG/Theirs/SALEOUT

(a) Change "pick" to "edit" for the commit in the rebase editor and save it. 
Rebase will inform you that it stopped after that commit.

(b) "Undo" the commit:

$ git reset HEAD^ (this will rollback the HEAD and index to the prior 
commit, but leave the commit changes in your working tree)

(c) Stage the old version of the program and commit it.

$ git add SRC/SALES/SALEOUT

$ git commit

(d) Commit the rest of the stuff.

$ git add .

$ git commit

(5) Tag the commit containing the old version of the program.

$ git logr (copy the sha1 of the second to last commit)

$ git tag <sha1-of-2nd-to-last-commit> WKTG/MRG/Cherry/SALEOUT

(6) Cherry pick that cherry commit onto your branch.  Cherry-pick will 
inform you of the conflict (user/datestamp will at least conflict).

$ git checkout <project-branch>

$ git cherry-pick --no-commit WKTG/MRG/Cherry/SALEOUT

(7) Merge using git mergtool.

$ git mergetool (Merge the stuff using kdiff3)

$ git add SRC/SALES/SALEOUT

$ git commit -c WKTG/MRG/Theirs/SALEOUT (Cherry pick will tell you exactly 
how to do the git commit -c)

You're Done.



v/r,

Neal
