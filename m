From: Joshua Williams <joshua.williams@qlogic.com>
Subject: git clone/push collision
Date: Tue, 26 Feb 2008 12:59:21 -0600
Message-ID: <47C46189.5050905@qlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 20:16:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU5I2-0004Jf-2P
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 20:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763838AbYBZTPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 14:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758788AbYBZTPg
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 14:15:36 -0500
Received: from eppat.qlogic.com ([198.186.5.11]:10653 "EHLO EPEXCH1.qlogic.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1763842AbYBZTPf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 14:15:35 -0500
X-Greylist: delayed 974 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Feb 2008 14:15:35 EST
Received: from Enki.local ([10.20.32.40]) by EPEXCH1.qlogic.org with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 26 Feb 2008 12:59:20 -0600
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
X-OriginalArrivalTime: 26 Feb 2008 18:59:20.0482 (UTC) FILETIME=[B19E8020:01C878A9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75162>

I'm unsure if this is a "problem" with git but the associated
error/warning messages can be concerning to uninitiated users.
It occurs when someone starts a clone and someone else does a
push while the clone is processing.  In 1.5.3.8 we are seeing
the following messages after the clone completes (the push was
to the b2 branch):

=====

jwilliams> git clone /nfs_share/repo.git my_clone.git
Initialized empty Git repository in 
/export/jwilliams/test/my_clone.git/.git/
5294402 blocks
Checking 6156 files out...
  100% (6156/6156) done

jwilliams> cd my_clone.git/

jwilliams> git branch
error: refs/remotes/origin/b2 does not point to a valid object!
* fwdev

jwilliams> git pull
error: refs/remotes/origin/b2 does not point to a valid object!
error: refs/remotes/origin/b2 does not point to a valid object!
remote: Generating pack...
remote: Counting objects: 1
remote: Done counting 1831 objects.
Result has 1288 objects.
remote: Deltifying 1288 objects...
remote:  100% (1288/1288) done
Indexing 1288 objects...
remote: Total 1288 (delta 855), reused 806 (delta 406)
  100% (1288/1288) done
Resolving 855 deltas...
  100% (855/855) done
127 objects were added to complete this thin pack.
Already up-to-date.

jwilliams> git branch
* fwdev

jwilliams> git pull
Already up-to-date.

=====

As you can see, the "does not point to a valid object" messages
go away after the subsequent pull.  This apparently synced things
up properly.  We clone a very large repo off of NFS which is slow
so this particular collision happens frequently.  This type of
message leaves users feeling uncomfortable.

In 1.5.4.2 this "window" appears much smaller.  When it does
appear to hit, the messages and behavior are a little different:

=====

jwilliams> git clone /nfs_share/repo.git my_clone.git
Initialized empty Git repository in 
/export/jwilliams/test/my_clone.git/.git/
5294419 blocks
error: Trying to write ref refs/remotes/origin/b2 with nonexistant 
object 9bf5a068f8ba817b93e1ef4e3904323833c948d8
fatal: Cannot update the ref 'refs/remotes/origin/b2'.
Checking out files: 100% (6156/6156), done.

jwilliams> cd my_clone.git/

jwilliams> git branch
* fwdev

jwilliams> git pull
remote: Counting objects: 1839, done.
remote: Compressing objects: 100% (890/890), done.
remote: Total 1296 (delta 902), reused 764 (delta 406)
Receiving objects: 100% (1296/1296), 21.82 MiB | 8845 KiB/s, done.
Resolving deltas: 100% (902/902), completed with 122 local objects.
 From /nfs_share/repo.git/
  * [new branch]      b2 -> origin/b2
Already up-to-date.

jwilliams> git branch
* fwdev

jwilliams> git pull
Already up-to-date.

=====

In 1.5.4.2 the subsequent pull does seem to sync things up properly
as well.

In both the 1.5.3.8 and 1.5.4.2 cases the b2 branch is unavailable
to work on until the subsequent pull.

I'm just curious to know if this behavior is known and if it is
considered "normal".

- Josh
