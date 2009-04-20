From: Todd Charron <tcharron@novator.com>
Subject: Git update delay
Date: Mon, 20 Apr 2009 17:37:12 -0400
Message-ID: <200904201737.13101.tcharron@novator.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 21 00:03:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw1Zc-0005kX-8K
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 00:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757016AbZDTWBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 18:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756822AbZDTWBJ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 18:01:09 -0400
Received: from mail.novator.com ([209.20.19.16]:39208 "EHLO
	mail00b.bcp.novator.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756450AbZDTWBH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 18:01:07 -0400
X-Greylist: delayed 1434 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Apr 2009 18:01:07 EDT
Received: from [67.211.112.33] (helo=tcharron.int.novator.com)
	by mail00b.bcp.novator.com with esmtp (Exim 4.63)
	(envelope-from <tcharron@novator.com>)
	id 1Lw1Au-0002OY-CV
	for git@vger.kernel.org; Mon, 20 Apr 2009 17:37:12 -0400
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-SA-Exim-Scanned: No (on mail00b.bcp.novator.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117040>

Hi all,

I'm trying to track down a potential git problem we've been having at my 
office.  Recently, we deployed a branch of code using git.  We deployed this 
code to a virtual machine running openvz with simfs as  the filesystem (the 
underlying filesystem on the host machine is ext3 with the noatime option 
on).  Kernel is 2.6.18-028stab053-vzserver-hammer. git version 1.6.0.5.

A git checkout of the branch was done and completed.   Upon returning to the 
bash prompt an rsync was done to sync the files out to other servers.  
However, what went out, was not the version of code that was deployed, but 
only some of the changesets that should have been there.

The machines also rsync via a cron every night and the evening sync sent out 
the correct code with no human intervention or rechecking out of code, so it 
appears as if once the git pull was completed (returned to the prompt) the 
changes had not been fully applied to the filesystem.  The sync then sync'd 
out an incomplete version of the code, which would have later finished 
updating and corrected itself on the nightly sync.   

Unfortunately, due to the second sync I can no longer prove this as all the 
code is no up to date. However, we have recently seen other instances that 
indicate a similar delay in the updates taking place on the file system.

Example 1:

user@dev:~/fol3$ git add modules/fol/local/MgntAuth.pm
user@dev:~/fol3$ git commit -m "fix auth closure bug"
Created commit 55ba2c9: fix auth closure bug
 1 files changed, 32 insertions(+), 29 deletions(-)
user@dev:~/fol3$ git push
Password:
Password:
Counting objects: 11, done.
Compressing objects: 100% (6/6), done.
Writing objects: 100% (6/6), 859 bytes, done.
Total 6 (delta 5), reused 0 (delta 0)
To ssh://cvs00t/clients/fol.git/central_git_repo/
   ba2e848..55ba2c9  ticket_128766 -> ticket_128766
user@dev:~/fol3$ git checkout qa_mar2009_1
M       modules/fol/local/FOL3_catalog_indices.pm
M       modules/fol/local/FOL3_indices.pm
M       www/fol/mgnt/Mgnt_indices_custom.html
Switched to branch "qa_mar2009_1"
user@dev:~/fol3$ git pull origin ticket_128766
Password:
From ssh://cvs00t/clients/fol.git/central_git_repo
 * branch            ticket_128766 -> FETCH_HEAD
error: Entry 'modules/fol/local/MgntAuth.pm' not uptodate. Cannot merge.
fatal: merging of trees e2b6fe42a504049333ef73b887554cf6afc8aedc and 
7c06608c2a7351522f0f357eacd982168b2179da failed
Merge with strategy recursive failed.
user@dev:~/fol3$ git status
# On branch qa_mar2009_1
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   modules/fol/local/FOL3_catalog_indices.pm
#       modified:   modules/fol/local/FOL3_indices.pm
#       modified:   www/fol/mgnt/Mgnt_indices_custom.html
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       bin/fol/#test.txt#
#       modules/fol/local/#FOL3_indices.pm#
#       update-cache-scripts
#       www/fol/mgnt/Mgnt_index_custom.html.new
no changes added to commit (use "git add" and/or "git commit -a")
user@dev:~/fol3$ git pull origin ticket_128766
Password:
From ssh://cvs00t/clients/fol.git/central_git_repo
 * branch            ticket_128766 -> FETCH_HEAD
Merge made by recursive.
 modules/fol/local/MgntAuth.pm |   61 +++++++++++++++++++++-------------------
 1 files changed, 32 insertions(+), 29 deletions(-)
user@dev:~/fol3$ git push
Password:
Counting objects: 13, done.
Compressing objects: 100% (5/5), done.
Writing objects: 100% (5/5), 524 bytes, done.
Total 5 (delta 4), reused 0 (delta 0)
To ssh://cvs00t/clients/fol.git/central_git_repo/
   94cd7dc..08f276d  qa_mar2009_1 -> qa_mar2009_1

Here, the only thing that changes between the first pull which fails and the 
second which succeeds is time.  No other user is pushing or pulling changes 
at this time.  The developer just walked away, came back and tried it again 
and it worked...

Example 2:

user@dev:~/fol3$ git commit -m "remove warning" 
Created commit b1dd989: remove warning 
 1 files changed, 0 insertions(+), 1 deletions(-) 
user@dev:~/fol3$ git push 
Password: 
Password: 
Counting objects: 11, done. 
Compressing objects: 100% (6/6), done. 
Writing objects: 100% (6/6), 484 bytes, done. 
Total 6 (delta 5), reused 0 (delta 0) 
To ssh://cvs00t/clients/fol.git/central_git_repo/ 
  55ba2c9..b1dd989  ticket_128766 -> ticket_128766 
user@dev:~/fol3$ git checkout qa_mar2009_1 
git pull origin modules/fol/local/Order_system.pm 
Switched to branch "qa_mar2009_1" 
user@dev:~/fol3$ git pull origin ticket_128766 
Password: 
From ssh://cvs00t/clients/fol.git/central_git_repo 
 * branch            ticket_128766 -> FETCH_HEAD 
fatal: unable to create '.git/index.lock': File exists 
Merge with strategy recursive failed. 

Here we see an index.lock file still existing when it should not.  Again, 
waiting a minute or two and trying again resolved the issue.  These were all 
done on a local filesystem (no-NFS) with one user in isolation.

These instances seem to happen at random and we have been unable to 
consistently reproduce them.  In all cases, just waiting a minute or two 
before running the commands again seems to resolve the issue.

I can't seem to determine whether this is a git issue or a filesystem issue 
and if so, what is the cause.  Can anyone think of any reason why this would 
happen?

Thanks!

Todd
