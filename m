From: Jon Loeliger <jdl@freescale.com>
Subject: Expected Behavior?
Date: Sun, 06 Nov 2005 16:16:02 -0600
Message-ID: <E1EYsny-0004hq-IW@jdl.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 23:16:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYso8-0003He-Lf
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 23:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVKFWQJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 17:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbVKFWQJ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 17:16:09 -0500
Received: from www.jdl.com ([66.118.10.122]:57789 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932246AbVKFWQH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 17:16:07 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EYsny-0004hq-IW
	for git@vger.kernel.org; Sun, 06 Nov 2005 16:16:03 -0600
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11231>


I was working through some examples and found some
rather curious behavior.  I'm wondering if it is
expected or not.  This isn't quite minimal, but
it is still small and shows the weirdness:

    git-init-db
    echo "Stuff for file1" > file1
    echo "Stuff for file2" > file2

    git add file1 file2
    git commit -m "Initial file1 and file2"

    git checkout -b dev

    echo "More for file1" >> file1
    rm -f file2
    echo "Another file!" > file3

    git update-index file1
    git update-index --force-remove file2
    git add file3

    git commit -m "Updated some stuff."

    git checkout master
    echo "Stuff for a conflict." >> file3
    git add file3
    git commit -m "Master update of file3"

    git merge "Grab dev stuff" master dev

Then, the part that I think is odd is demonstrated by "git status":

    $ git status
    #
    # Updated but not checked in:
    #   (will commit)
    #
    #       modified: file1
    #       deleted:  file2
    #       unmerged: file3
    #
    #
    # Changed but not updated:
    #   (use git-update-index to mark for commit)
    #
    #       unmerged: file3
    #
    #
    # Untracked files:
    #   (use "git add" to add to commit)
    #
    #       file3

Why is file3 considered untracked and needing to be added?
It was present in both "dev" and "master" branches before
the merge.  It doesn't end up with "<<< one === other >>>"
style diffs either.

My guess is that the file is small, one line, in each branch.
When the diff happens, it sees the file as empty in the other
branch and considers that "new" directly, rather than asking
the index if it knows about it to determine "newness" status.

Or perhaps it is that the file  became new in each branch
independently and never really had a true common ancestor.

Thanks,
jdl
