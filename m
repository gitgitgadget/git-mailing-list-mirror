From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Clean up work-tree handling
Date: Tue, 31 Jul 2007 22:17:31 -0700
Message-ID: <7v3az3deac.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
	<Pine.LNX.4.64.0708010058130.14781@racer.site>
	<Pine.LNX.4.64.0708010129530.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, matled@gmx.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 01 07:17:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG6aV-00058k-Ls
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 07:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbXHAFRd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 01:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbXHAFRd
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 01:17:33 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:50039 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbXHAFRc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 01:17:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801051733.VYOX26965.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 1 Aug 2007 01:17:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id WVHX1X00A1kojtg0000000; Wed, 01 Aug 2007 01:17:31 -0400
In-Reply-To: <Pine.LNX.4.64.0708010129530.14781@racer.site> (Johannes
	Schindelin's message of "Wed, 1 Aug 2007 01:30:14 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54408>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The old version of work-tree support was an unholy mess, barely readable,
> and not to the point.
>
> For example, why do you have to provide a worktree, when it is not used?
> As in "git status".  Now it works.
> ...

Without continuing with negatives, let's try to define the new,
corrected world order.

I do not think the following is exactly what your cleaned-up
version tries to perform, but I am writing this down primarily
to demonstrate the style and the level of detail I expect to
accompany a clean-up patch like this.

----------------------------------------------------------------

Definitions:

 - You can have "checked out" files on the filesystem, and such
   files are said to be in your "work tree".  The directory
   on the filesystem that corresponds to the toplevel entries of
   the index and the tree objects directly contained in the
   commit objects is called "the toplevel of the work tree",
   or simply "work tree" if it is not ambiguous from the
   context.

 - The directory that holds git repository information is called
   "git directory".  This is typically .git directory at the
   toplevel of your work tree, but not necessarily so.

 - You can perform many git operations without a work tree, but
   some operations fundamentally require you to have one
   (e.g. checkout and diff, unless two tree-ishes are given, do
   not make sense without a work tree).

There are four predicates, two interrogators, and two
manipulators:

 - is_inside_git_dir(): this returns true if the $cwd is the git
   directory or its subdirectory. [IS THIS STILL NEEDED???]

 - is_inside_work_tree(): this returns true if the $cwd is
   inside work tree (i.e. either at the toplevel of the work
   tree or its subdirectory).  [NEEDSHELP: is .git in the usual
   layout considered "is_inside_work_tree()"?  Should it?]

 - is_bare_repository(): this returns true if no work tree is
   found.  There is a corresponding function usable from the
   scripts.

 - require_work_tree (shell): this is called by scripts that
   needs to have a work tree to operate, and barfs otherwise.

 - get_git_dir(): this returns the location of the git
   directory.  With GIT_DIR environment variable, or --git-dir
   command line option, you can tell git to use a specific
   directory as the git directory.  Otherwise a directory that
   looks like a git directory and whose name is .git is looked
   for, in the $cwd or its parent directory.  If there is no
   such directory, and if the $cwd looks like a git directory,
   $cwd is the git directory.

 - get_git_work_tree(): this returns the location of the work
   tree; it returns NULL if there is none.  The command line
   option --work-tree, or the environment variable GIT_WORK_TREE
   can specify the location; otherwise, git directory is looked
   for so that its configuration file can be read.  If
   core.worktree is there, that specifies the location.
   Otherwise, if the basename of the git directory is .git, it
   is the parent directory of the git directory.  Otherwise, you
   do not have work tree.

 - set_git_dir(): used to set the git directory, internally to
   handle --git-dir option;

 - set_work_tree(): used to set the git directory, internally to
   handle --work-tree option;

----------------------------------------------------------------

After writing the above down, it strikes me odd that we do not
have a predicate that says "we know the work tree is there".

If a command wants a work tree, and if you are outside the work
tree, then is_inside_work_tree() returns false and
get_git_work_tree() returns non NULL, so that is a good pair of
interface that can be mixed and matched (e.g. you can chdir to
the former to perform the whole tree operation, or refuse to
perform, based on is_inside_work_tree being false, cwd relative
operations).
