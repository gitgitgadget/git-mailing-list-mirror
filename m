From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] work-tree clean ups
Date: Tue, 31 Jul 2007 17:55:18 -0700
Message-ID: <7vbqdsdqfd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
	<Pine.LNX.4.64.0708010058130.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, matled@gmx.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 01 02:55:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG2Un-0002Fh-FT
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 02:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880AbXHAAzV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 20:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755152AbXHAAzV
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 20:55:21 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:39511 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbXHAAzT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 20:55:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801005519.QCWN26965.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 31 Jul 2007 20:55:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WQvJ1X00V1kojtg0000000; Tue, 31 Jul 2007 20:55:19 -0400
In-Reply-To: <Pine.LNX.4.64.0708010058130.14781@racer.site> (Johannes
	Schindelin's message of "Wed, 1 Aug 2007 01:28:30 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54390>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> There is not really much that can be done about step 6/9: if we are in a 
> work tree: that does not mean that we are _not_ in the git_dir.  (And no, 
> this does not break git-clean, as a work tree is a work tree is a work 
> tree.  If the user was stupid enough to specify the same directory as 
> GIT_DIR and GIT_WORK_TREE, then that is _her_ problem.  Git is a powerful 
> tool, and you can harm yourself with it.  Tough.)

I think we might have a slight misunderstanding.  The "clean"
issue that was raised in an ancient thread was this sequence:

	$ git init
        $ cd .git
        $ git clean

It did not involve GIT_DIR (nor GIT_WORK_TREE as it was not even
there).  The point was that not all subdirectories of the
toplevel (i.e. the directory on the filesystem that corresponds
to the root level of your index entries and trees contained in
your commits) were safe to answer yes when asked "are we safe to
perform this worktree oriented command here".  Because no trees
nor index would have .git/ subdirectory tracked, "git clean"
will happily remove everything under .git/ (which is $cwd in the
above sequence).

I personally feel that the above sequence is a pilot error and
not worth worrying about, but as people wanted to have that
extra safety, and as we added that (arguably stupid) safety way
before the WORK_TREE stuff, we should mention it if we are
changing the behaviour and lifting it with this patch series.

> Note: if you are in a bare repository (a repository which either says 
> "core.bare = false" in the config, or which is a direct ancestor 
> directory, i.e. ../[...]/.. of the current working directory) there will 
> _not_ be an automatic working directory assignment.  You will be operating 
> _without_ any work tree, unless you specify one.

Sorry, I cannot interpret the condition part of the sentence,
nor "There will _not_ be an automatic assignment" part.

By the latter, do you mean to say your $cwd is assumed to be the
top of the working tree unless GIT_WORK_TREE or core.worktree,
if you are in a bare repository?  Or it is assumed that you do
not have a worktree and worktree oriented operations that
require a worktree such as "git diff-files" and "git status"
will fail?

> I somehow feel that core.bare = true weighs more than core.worktree = 
> /some/thing, and therefore I implemented it that way, but hey, if enough 
> people disagree, then I'll change it.

Personally, I think

 [core]
     bare = true
     worktree = /some/where

is a configuration error, but probably I am missing a useful use
case for such a configuration?

> IMHO we should (probably after 1.5.3) change setup_git_directory_gently() 
> to call check_repository_format() in every return path, so that we 
> ascertain that the current repository is recent enough.  Because that 
> function now checks also if the repo is bare, and if it has a worktree 
> set, in addition to ensuring a valid repository.

Agreed; gently() is there primarily because some commands do not
mind not having a git repository at all and if we do have a
repository to work against we probably should do the same checks
as setup_git_directory() would.
