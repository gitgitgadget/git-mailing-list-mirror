From: Max Horn <max@quendi.de>
Subject: rebase: strange failures to apply patc 3-way
Date: Thu, 7 Mar 2013 11:16:50 +0100
Message-ID: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 07 11:33:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDY8J-0006qe-74
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 11:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971Ab3CGKck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 05:32:40 -0500
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:48193 "EHLO
	merkurneu.hrz.uni-giessen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752847Ab3CGKcj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Mar 2013 05:32:39 -0500
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Mar 2013 05:32:38 EST
Received: from mailgw82.hrz.uni-giessen.de by merkurneu.hrz.uni-giessen.de with ESMTP for git@vger.kernel.org; Thu, 7 Mar 2013 11:17:34 +0100
Received: from hermes.hrz.uni-giessen.de (hermes.hrz.uni-giessen.de [134.176.2.15])
	by mailgw82.hrz.uni-giessen.de (Postfix) with ESMTP id B2C50480008C
	for <git@vger.kernel.org>; Thu,  7 Mar 2013 11:16:50 +0100 (CET)
Received: from [134.176.2.15] by hermes.hrz.uni-giessen.de with ESMTP for git@vger.kernel.org; Thu, 7 Mar 2013 11:16:50 +0100
X-Mailer: Apple Mail (2.1283)
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: No virus found
X-Envelope-From: max@quendi.de
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217587>

Recently I have observed very strange failures in "git rebase" that cause it to fail to work automatically in situations where it should trivially be able to do so.

In case it matter, here's my setup: git 1.8.2.rc2.4.g7799588 (i.e. git.git master branch) on Mac OS X. The repos clone is on a HFS+ partition, not on a network volume. No gitattributes are being used.  Regarding the origin of the repos (I hope it doesn't matter, but just in case): The repository in question used to be a CVS repository; it was decided to switch to Mercurial (not my decision ;-) and I performed the conversion; I first converted it to git using cvs2git (from the cvs2svn suite), then performed some history cleanup, and finally used "hg convert" to convert it to git. Recently, I have been accessing the repository from git via the gitifyhg tool <https://github.com/buchuki/gitifyhg>. 

Anyway, several strange things just happened (and I had similar experiences in the past days and weeks, but that was using an older git, and I thought I was just doing something wrong).

Specifically, I wanted to rebase a branch with some experimental commits. The strange things started with this:

$ git rebase MY-NEW-BASE
First, rewinding head to replay your work on top of it...
Applying: SOME COMMIT
Applying: SOME OTHER COMMIT
...
Applying: COMMIT A
Applying: COMMIT B
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
error: Your local changes to the following files would be overwritten by merge:
	some/source.file
Please, commit your changes or stash them before you can merge.
Aborting
Failed to merge in the changes.
Patch failed at 0014 COMMIT B
The copy of the patch that failed is found in:
   /path/to/my/repo/.git/rebase-apply/patch

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".


Now, what is strange about this is that the failed patch actually applies cleanly:

$ patch -p1 < /path/to/my/repo/.git/rebase-apply/patch
patching file some/source.file
$

And there is no subtle merge issue here, either: That patch is the only one to have touched the surrounding code since 1999! There is no source of conflict there!

Anyway. The tale gets stranger, as I was trying to do this again (no changes were made to the repos in between, this is a straight continuation from above):

$ git rebase --abort
$ git rebase MY-NEW-BASE
First, rewinding head to replay your work on top of it...
Applying: SOME COMMIT
Applying: SOME OTHER COMMIT
...
Applying: COMMIT A
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
error: Your local changes to the following files would be overwritten by merge:
	some/othersource.file
	some/yetanother.file
Please, commit your changes or stash them before you can merge.
Aborting
Failed to merge in the changes.
Patch failed at 0013 COMMIT A
The copy of the patch that failed is found in:
   /path/to/my/repo/.git/rebase-apply/patch

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".



So suddenly it fails to apply the commit A, the one before the previously failing commit. Huh? But again, the failing patch applies cleanly (and after all, rebase was able to apply it in my previous attempt).  And again, the patch actually applies cleanly. So one more try:


$ git rebase --abort
$ git rebase MY-NEW-BASE
First, rewinding head to replay your work on top of it...
Applying: SOME COMMIT
Applying: SOME OTHER COMMIT
...
Applying: COMMIT A
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
error: Your local changes to the following files would be overwritten by merge:
	some/othersource.file
Please, commit your changes or stash them before you can merge.
Aborting
Failed to merge in the changes.
Patch failed at 0013 COMMIT A
The copy of the patch that failed is found in:
   /path/to/my/repo/.git/rebase-apply/patch

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".


Again it fails in commit A -- but this time, it only thinks one file is problematic. HUH? Again, the patch actually applies cleanly:

$ patch -p1 < /path/to/my/repo/.git/rebase-apply/patch
patching file some/othersource.file
patching file some/yetanother.file


At this point, things stabilized, and when I now abort and reattempt the merge, it always fails in the same way. This time trying to apply a change to a code comment that was last changed in 1997 (though for one hunk, a few lines before the changed lines, there is a line that was changed in 2008... but I assure you, that line is there in the ancestors of both the branch I want to rebase, and also in the MY-NEW-BASE branch I rebase onto).


Something seems to be really fishy here and I wonder if anybody has an idea what's going wrong here. Is this a bug in git? Is my repos broken in some way? Note that "git fsck" reported nothing except some dangling objects. Any other ideas? 


Cheers,
Max
