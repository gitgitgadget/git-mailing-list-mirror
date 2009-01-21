From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Short "git commit $file" syntax fails in the face of a resolved
 conflict
Date: Wed, 21 Jan 2009 16:00:36 -0500 (EST)
Message-ID: <alpine.DEB.2.00.0901211549070.15860@vellum.laroia.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: nathan@creativecommons.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 22:15:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPkPq-000051-Uv
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 22:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbZAUVNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 16:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753987AbZAUVNR
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 16:13:17 -0500
Received: from rose.makesad.us ([219.105.37.19]:48384 "EHLO rose.makesad.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526AbZAUVNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 16:13:16 -0500
Received: from vellum.laroia.net (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id 28E5AA02C7;
	Wed, 21 Jan 2009 16:13:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by vellum.laroia.net (Postfix) with ESMTPS id BBD2A3A62B9;
	Wed, 21 Jan 2009 16:00:36 -0500 (EST)
X-X-Sender: paulproteus@vellum.laroia.net
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106674>

I have found what seems to be a bug in the short "git commit $file" mode 
of interaction with git. To reproduce it, you can:

1. Create a repository with some content.

 	$ (mkdir a ; cd a ; git init ; echo hi > file ; git add file ; git commit -m 'initial commit')
 	Initialized empty Git repository in /tmp/playground.2009-01-21.w15613/a/.git/
 	Created initial commit 276d6eb: initial commit
 	 1 files changed, 1 insertions(+), 0 deletions(-)
 	 create mode 100644 file

2. Clone that repository.

 	$ git clone a b
 	Initialized empty Git repository in /tmp/playground.2009-01-21.w15613/b/.git/

3. Create changes in "a" that are not yet cloned into "b".

 	$ (cd a ; echo ho > file ; git add file ; git commit -m update)
 	Created commit 91deff9: update
 	 1 files changed, 1 insertions(+), 1 deletions(-)

4. Make changes in "b", the clone.

 	$ echo lol > file
 	$ git add file ; git commit -m 'Some changes'
 	Created commit 5d74b5b: Some changes
 	 1 files changed, 1 insertions(+), 1 deletions(-)

5. Fetch and merge (AKA pull) from the first repo.

 	$ git pull
 	remote: Counting objects: 5, done.
 	remote: Total 3 (delta 0), reused 0 (delta 0)
 	Unpacking objects: 100% (3/3), done.
 	From /tmp/playground.2009-01-21.w15613/a/
 	   276d6eb..91deff9  master     -> origin/master
 	Auto-merged file
 	CONFLICT (content): Merge conflict in file
 	Automatic merge failed; fix conflicts and then commit the result.

6. Resolve the conflict (in our case, by discarding the changes in the "b" 
clone).

 	$ echo ho > file

7. Commit the resolved conflict.

NOTE: The normal way to do step 6 is to "git add file ; git commit -m 
yay". But I will now try to use the "git commit file" shorthand:

 	$ git commit file -m 'Resolved conflict'
 	fatal: cannot do a partial commit during a merge.

8. Declare a bug.

I believe that the "git commit file" command issued in step 6 should have 
worked as well as the "git add file ; git commit" that us old-time git 
users do.

9. Discuss on the git list.

Do y'all agree that the git behavior is strange and unnecessarily 
user-impeding here?

Cheers!

-- Asheesh.

P.S. I'm not the one who ran into the bad behavior here; Nathan (CC:d) is 
the one who did. You don't have to keep him CC:d, though.

-- 
Avoid gunfire in the bathroom tonight.
