From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Really fix git-merge-one-file-script this time.
Date: Sun, 01 May 2005 11:38:15 -0700
Message-ID: <7vzmveu6zs.fsf@assigned-by-dhcp.cox.net>
References: <7vd5sbz436.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 20:33:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSJFE-0000vm-0v
	for gcvg-git@gmane.org; Sun, 01 May 2005 20:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVEASia (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 14:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVEASia
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 14:38:30 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:48312 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261688AbVEASiR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 14:38:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050501183817.BVJE12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 14:38:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vd5sbz436.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 01 May 2005 02:29:49 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Following up to my own message...

Linus, have you decided to like or dislike the behaviour of
git-merge-one-file-script touching the work tree in some cases
but not in other cases?  A straightforward merge implementation
that does a "git-read-tree -m" followed by a "git-merge-cache
git-merge-one-file-script" does the following to your work tree
and the cache:

 - Paths merged unsuccessfully makes git-merge-cache phase fail
   and the work tree is not affected for such paths.

 - Paths merged "git-read-tree -m" trivially does not change the
   work tree and "git-read-tree -m" result is kept in the cache.

 - Paths merged by "merge" successfully, and paths chosen from a
   single side by "git-merge-one-file-script" change the work
   tree, possibly checking out the file if you started out from
   an empty work tree.
 
I am not worried about the first case where you will have to
manually examine and resolve anyway. I am wondering if the rest
is the desired behavior for _your_ way of using the GIT merge.
After a successful merge, what kind of verification would you
typically do?

First of all, would you usually do the merge in an empty work
tree, or in a populated work tree?  Secondly, would you care
about the distinction between "git-read-tree -m" trivial merges
and "merge" trivial merges when reviewing the result?

If you work in an empty work tree, and never review the merge
result while in that tree, then not touching the work tree in
git-merge-one-file-script at all may be desirable, especially if
you really want to keep things only in the cache.  On the other
hand, if you do review there, leaving the merge result in the
work tree is desirable.  Especially, if you want to verify the
resulting files that are "merge" trivial but not are
"git-read-tree -m" trivial, the files you see in the work tree
are the only ones you need to check.

If you do your merge in a populated work tree, and assuming your
starting work tree matches one of the commits being merged
[*1*], it becomes harder to review the changes to the "merge"
trivial but not "git-read-tree -m" trivial files.  The cache
does not tell you which ones are which with the current
implementation of "git-merge-one-file-script".  "git-diff-cache"
against the tree before the merge would report all merges,
including "git-read-tree -m" trivial ones, so you end up needing
to save the output from git-merge-one-file-script and decide
which paths to check.

I am wondering if the following changes would make sense and
make things easier for you:

 * git-merge-one-file-script is changed to register the path
   with --cacheinfo using magic SHA1 0{40} instead of using the
   resulting file on the filesystem.  Do keep the current
   behaviour of leaving the merge results of trivial merges
   (both kind) in the work tree.

 * git-write-tree is changed to refuse to write from a cache
   that records the magic SHA1.

 * git-ls-files acquires a new option --merged to notice the
   magic SHA1 and shows the paths that have such SHA1.

 * git-update-cache acquires a new option --resolve to notice
   the magic SHA1 and:

   - if the named path is not in the work tree anymore, delete
     the entry.

   - if the named path exists in the work tree, compute the
     latest SHA1 for that file and update the entry.

Changes other than the first two listed above are purely
optional, since the Porcelain layer can implement them without
the Plumbing support.  Not doing them would keep the Plumbing
somewhat cleaner by not having to know about this magic SHA1
convention.  On the other hand, we already use that convention
in git-diff-cache, so it may even be a consistent change to make
these optional changes.  Essentially, the magic SHA1 in the
cache means "I know the user wants me to keep an eye on this
path when it matters" [*2*].

Please veto if these changes would not help _your_ use pattern.

[Footnotes]

*1* That is, you do "read-tree -m O A B" and your work tree
before the merge matches A (e.g. linux-2.6.git or your
yet-to-be-published descendant of it), B is a subsystem tree
(e.g. rmk/linux-2.6-serial.git) and O is the common ancestor.

*2* This convention would also make an implementation of "SCM
add" in the Porcelain layer a bit more efficient.  A typical
workflow without such a convention would consist of:

 * Create a file and start editing.
 * "SCM add" file, causing "git-update-cache --add -- file".
 * Do more changes, and review.
 * "SCM commit" which does"git-update-cache" changed files,
   "git-write-tree" and "git-commit-tree" to commit.

which wastes one extra blob object per "SCM add".  My gut
feeling is that more than 80% of the time "SCM add" is followed
by some edit to the added file before "SCM commit", unless it is
the initial import.  If we adopt that convention, "SCM add"
would register with --cacheinfo with the magic SHA1 without
creating the useless blob, and "SCM commit" will be written to
lazily pick things up from the work tree.



