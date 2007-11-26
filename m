From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] add a howto document about corrupted blob recovery
Date: Mon, 26 Nov 2007 02:12:19 +0000
Message-ID: <20071126021219.GH23820@fieldses.org>
References: <4fe79b4b0711090538wf483ce7j89c518962e89780e@mail.gmail.com> <alpine.LFD.0.999.0711090758560.15101@woody.linux-foundation.org> <alpine.LFD.0.9999.0711091221210.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 03:13:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwTT5-000099-1W
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 03:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757591AbXKZCMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 21:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757551AbXKZCM3
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 21:12:29 -0500
Received: from mail.fieldses.org ([66.93.2.214]:46371 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757298AbXKZCM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 21:12:27 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IwTSN-0003pg-2y; Mon, 26 Nov 2007 02:12:19 +0000
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0711091221210.21255@xanadu.home>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66035>

On Fri, Nov 09, 2007 at 12:28:19PM -0500, Nicolas Pitre wrote:
> Extracted from a post by Linus on the mailing list.
> 
> Signed-off-by: Nicolas Pitre <nico@cam.org>

I rearranged this some more and added it to the manual, assuming that
makes sense to everyone.

I think there needs to be some discussion of pack objects and stuff too
some day.  I added a few mail archive references to the "todo" section.

--b.

commit d6e199cb6ff911e8e3e39c8b7021512a14ea79a5
Author: J. Bruce Fields <bfields@citi.umich.edu>
Date:   Sat Mar 3 22:53:37 2007 -0500

    user-manual: recovering from corruption
    
    Some instructions on dealing with corruption of the object database.
    
    Most of this text is from an example by Linus, identified by Nicolas
    Pitre <nico@cam.org> with a little further editing by me.
    
    Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index c027353..3166fb6 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1554,6 +1554,11 @@ This may be time-consuming.  Unlike most other git operations (including
 git-gc when run without any options), it is not safe to prune while
 other git operations are in progress in the same repository.
 
+If gitlink:git-fsck[1] complains about sha1 mismatches or missing
+objects, you may have a much more serious problem; your best option is
+probably restoring from backups.  See
+<<recovering-from-repository-corruption>> for a detailed discussion.
+
 [[recovering-lost-changes]]
 Recovering lost changes
 ~~~~~~~~~~~~~~~~~~~~~~~
@@ -3172,6 +3177,127 @@ confusing and scary messages, but it won't actually do anything bad. In
 contrast, running "git prune" while somebody is actively changing the
 repository is a *BAD* idea).
 
+[[recovering-from-repository-corruption]]
+Recovering from repository corruption
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+By design, git treats data trusted to it with caution.  However, even in
+the absence of bugs in git itself, it is still possible that hardware or
+operating system errors could corrupt data.
+
+The first defense against such problems is backups.  You can back up a
+git directory using clone, or just using cp, tar, or any other backup
+mechanism.
+
+As a last resort, you can search for the corrupted objects and attempt
+to replace them by hand.  Back up your repository before attempting this
+in case you corrupt things even more in the process.
+
+We'll assume that the problem is a single missing or corrupted blob,
+which is sometimes a solveable problem.  (Recovering missing trees and
+especially commits is *much* harder).
+
+Before starting, verify that there is corruption, and figure out where
+it is with gitlink:git-fsck[1]; this may be time-consuming.
+
+Assume the output looks like this:
+
+------------------------------------------------
+$ git-fsck --full
+broken link from    tree 2d9263c6d23595e7cb2a21e5ebbb53655278dff8
+              to    blob 4b9458b3786228369c63936db65827de3cc06200
+missing blob 4b9458b3786228369c63936db65827de3cc06200
+------------------------------------------------
+
+(Typically there will be some "dangling object" messages too, but they
+aren't interesting.)
+
+Now you know that blob 4b9458b3 is missing, and that the tree 2d9263c6
+points to it.  If you could find just one copy of that missing blob
+object, possibly in some other repository, you could move it into
+.git/objects/4b/9458b3... and be done.  Suppose you can't.  You can
+still examine the tree that pointed to it with gitlink:git-ls-tree[1],
+which might output something like:
+
+------------------------------------------------
+$ git ls-tree 2d9263c6d23595e7cb2a21e5ebbb53655278dff8
+100644 blob 8d14531846b95bfa3564b58ccfb7913a034323b8	.gitignore
+100644 blob ebf9bf84da0aab5ed944264a5db2a65fe3a3e883	.mailmap
+100644 blob ca442d313d86dc67e0a2e5d584b465bd382cbf5c	COPYING
+...
+100644 blob 4b9458b3786228369c63936db65827de3cc06200	myfile
+...
+------------------------------------------------
+
+So now you know that the missing blob was the data for a file named
+"myfile".  And chances are you can also identify the directory--let's
+say it's in "somedirectory".  If you're lucky the missing copy might be
+the same as the copy you have checked out in your working tree at
+"somedirectory/myfile"; you can test whether that's right with
+gitlink:git-hash-object[1]:
+
+------------------------------------------------
+$ git hash-object -w somedirectory/myfile
+------------------------------------------------
+
+which will create and store a blob object with the contents of
+somedirectory/myfile, and output the sha1 of that object.  if you're
+extremely lucky it might be 4b9458b3786228369c63936db65827de3cc06200, in
+which case you've guessed right, and the corruption is fixed!
+
+Otherwise, you need more information.  How do you tell which version of
+the file has been lost?
+
+The easiest way to do this is with:
+
+------------------------------------------------
+$ git log --raw --all --full-history -- somedirectory/myfile
+------------------------------------------------
+
+Because you're asking for raw output, you'll now get something like
+
+------------------------------------------------
+commit abc
+Author:
+Date:
+...
+:100644 100644 4b9458b... newsha... M somedirectory/myfile
+
+
+commit xyz
+Author:
+Date:
+
+...
+:100644 100644 oldsha... 4b9458b... M somedirectory/myfile
+------------------------------------------------
+
+This tells you that the immediately preceding version of the file was
+"newsha", and that the immediately following version was "oldsha".
+You also know the commit messages that went with the change from oldsha
+to 4b9458b and with the change from 4b9458b to newsha.
+
+If you've been committing small enough changes, you may now have a good
+shot at reconstructing the contents of the in-between state 4b9458b.
+
+If you can do that, you can now recreate the missing object with
+
+------------------------------------------------
+$ git hash-object -w <recreated-file>
+------------------------------------------------
+
+and your repository is good again!
+
+(Btw, you could have ignored the fsck, and started with doing a 
+
+------------------------------------------------
+$ git log --raw --all
+------------------------------------------------
+
+and just looked for the sha of the missing object (4b9458b..) in that 
+whole thing. It's up to you - git does *have* a lot of information, it is 
+just missing one particular blob version.
+
 [[the-index]]
 The index
 -----------
@@ -4381,4 +4507,7 @@ Write a chapter on using plumbing and writing scripts.
 
 Alternates, clone -reference, etc.
 
-git unpack-objects -r for recovery
+More on recovery from repository corruption.  See:
+	http://marc.theaimsgroup.com/?l=git&m=117263864820799&w=2
+	http://marc.theaimsgroup.com/?l=git&m=117147855503798&w=2
+	http://marc.theaimsgroup.com/?l=git&m=117147855503798&w=2
