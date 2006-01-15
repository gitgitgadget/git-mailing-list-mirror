From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: Subprojects
Date: Sat, 14 Jan 2006 17:01:24 -0800
Message-ID: <7vfynq484b.fsf@assigned-by-dhcp.cox.net>
References: <43C52B1F.8020706@hogyros.de>
	<Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de>
	<43C537C9.4090206@hogyros.de>
	<Pine.LNX.4.64.0601110928350.5073@g5.osdl.org>
	<7vacdzkww3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
	<7vek3ah8f9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 15 02:01:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExwGv-0005zF-LP
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 02:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbWAOBB0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 20:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbWAOBB0
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 20:01:26 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:26523 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751594AbWAOBB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2006 20:01:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060115010015.HPPD6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 Jan 2006 20:00:15 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14691>

Continuing with the "union" approach...

Junio C Hamano <junkio@cox.net> writes:

>  - append the tree object in "kernel" commit object to the
>    current index, rerooted at linux-2.6/; similar for "gcc" at
>    gcc-4.0/. We may need a new mode and option for read-tree for
>    this, or we may not.  Internally this step would be scripted
>    in "git bind" wrapper like this:
>
> 	git read-tree --bind --prefix=linux-2.6 kernel
> 	git read-tree --bind --prefix=gcc-4.0 gcc
>
>    and would result in an index file that has these trees
>    "mounted" at specified places...

Clarification.  By "mounted", I mean 'without affecting existing
index entries, create index entries from the tree, with all the
paths have "linux-2.6/" prefixed to them'.

>  - record the branch name vs subproject directory binding in
>    $GIT_DIR/ somewhere, say $GIT_DIR/mtab ;-).
>
> 	$ cat .git/mtab
> 	kernel	linux-2.6
>       gcc	gcc-4.0

I now realize this needs to be something like:

	master	kernel=linux-2.6/ gcc=gcc-4.0/

that is, "when on branch master, bind these two heads at these
directories", to allow switching to another branch and switching
back to this branch.  And the file should probably be called
$GIT_DIR/modules, to parallel CVSROOT/modules file.

>	$ git cat-file commit HEAD
>       tree e9de76f2e141824439caa00a65e3b91d05d125c9
>       parent bfca932434cc65e7aa90794e7c4d66f75d00b16a
>       bind a8fe7257b8427d31cfcca0aa336335bb43689fc9 linux-2.6
>       bind b3b2df23226634f42c9646bd7961fbea8b00f914 gcc-4.0
>       author Junio C Hamano <junkio@cox.net> 1137205528 -0800
>       committer Junio C Hamano <junkio@cox.net> 1137205528 -0800
>
>	Bind kernel and gcc into us.
>...
> Now I have to think about clones and merges but this is getting
> too long so I'll leave it to a separate message.

The core-level cloning would just "clone" the objects, treating
"bind" line in the commit just like "parent" to pull necessary
objects.

Checkout would involve the usual read-tree -u which extracts the
tree (which is the whole tree, with files of the subprojects in
it), and notices "bind" lines are there but there are no
matching $GIT_DIR/modules entries for those directories.
Probably it would create $GIT_DIR/refs/heads/bind/a8fe725 for
the linux-2.6 subproject (what the original committer called
"kernel" branch), and similarly for the gcc-4.0 subproject, add
an appropriate entry to $GIT_DIR/modules file.  The user would
then rename the branch names and optionally arrange remotes/
files to update the bound branches appropriately:

	$ mv .git/refs/heads/bind/a8fe725 .git/refs/heads/kernel

Now, let's say this "master" branch is checked out, and somehow
the "kernel" branch gets updated.  That is, the commit recorded
on the "bind" line of the HEAD commit does not match the branch
head that can be found out via $GIT_DIR/modules file.  This will
not happen if you are committing into the "master" branch using
the "commit to subprojects and then to the toplevel project"
mechanism yourself, but it would happen if the "kernel" branch
was moved by "git fetch" fast-forwarding, or if you switched to
the "kernel" branch (which would essentially remove everything
from your tree, and checkout the kernel source at the root
level, not in linux-2.6/ subdirectory), did an upstream merge
yourself, and switched back to the "master" branch.

To keep the problem simpler, let's say we only deal with the
case where "kernel" branch head is a fast-forward of what is on
"bind" in the HEAD commit of "master" branch.  Then "checkout"
needs to notice it, and check out the subdirectory from the
"kernel" branch head (*not* using the object name on "bind"
line).

So the outline of the "checkout" would be like this:

 * Read commit object from new HEAD.

 * For each "bind" line:

   If the subdirectory does not have a corresponding branch,
   create one in $GIT_DIR/refs/heads/bind/; record it in
   $GIT_DIR/modules for the new branch (otherwise leave branch
   as is).

   Make sure the commit recorded on "bind" line is an ancestor
   of the branch head.  Otherwise it is an error and checkout is
   prevented until the "kernel" branch is resolved to be a
   descendant of it.

   Run "read-tree -u --prefix=" to merge in the subtree into the
   index, and update the working tree.

At this point, there may be mismatch between the tree in the
HEAD and the working tree files and index, when subproject
commit recorded on the "bind" line is different from the
corresponding subproject branch head, and "git diff" would show
it.  When making a commit here, the "subproject and then
toplevel" commit scheme I described earlier would record the
current "kernel" branch head on the "bind" line in the new
commit, along with the tree object that contains the tree from
"kernel" branch head commit as a subtree.


About "merge", we should be able to do this:

	$ git checkout master ;# the whole mess
        $ git pull -b kernel git://..torvalds/linux-2.6.git/

that is, 'pull from this URL but into "kernel" branch not to the
current branch'.  Independent of this "subprojects" topic,
merging in a separate temporary directory into non-current
branch is something we have talked about some time ago, and in
this particular case, instead of using a throw-away temporary
directory, we have a pre-made directory to do the merge already,
so let's say that is solved elsewhere first.  Once we have that,
the above "checkout" would be able to integrate the result into
the "master" project.
