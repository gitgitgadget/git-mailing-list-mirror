From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Tue, 21 Mar 2006 17:58:28 -0800
Message-ID: <7vodzzb5q3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Mar 22 02:58:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLscL-0002Vv-0C
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 02:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbWCVB6a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 20:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbWCVB6a
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 20:58:30 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62163 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751977AbWCVB63 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Mar 2006 20:58:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060322015634.IMET6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 21 Mar 2006 20:56:34 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17795>

* The 'master' branch has these since the last announcement.

 - git.el updates (Alexandre Julliard)
 - git-svn updates (Eric Wong)
 - git-blame updates (Fredrik Kuivinen)
 - documentation updates (Francis Daly, Jon Loeliger)
 - Makefile: Add TAGS and tags targets (Fredrik Kuivinen)
 - http-push support for deleting remote branches (Nick Hengeveld)

 - assorted minor fixes and tweaks (Alexandre Julliard, Mark
   Hollomon, Shawn Pearce, Yasushi SHOJI, Nicolas Pitre, Randal
   L. Schwartz and me)

* The 'next' branch, in addition, has two important fixes and
  enhancements, and it probably is a good time to do a 1.3
  release when they graduate to "master" and prove stable.

 - quicker and dirtier rename detection by Linus and me.

   I've been using this myself and haven't seen major
   misdetection so far, but I do not use much renames.  Maybe
   it's time to push this out and see what happens.  This is
   _not_ the "important" part.

 - cvsimport post-import checkout fix.

   Earlier we had a workaround to deal with people who import
   into the current branch by not checking out.  After
   incrementally importing from the same CVS repository again,
   however, the code did update the branch head.  This made the
   working tree and the index stale and was causing more
   confusion than it avoided.

   This fix is to make re-importing act more like git-pull, not
   git-fetch.  So if you run an incremental import into the
   current branch, it tries to fast-forward the working tree and
   index (your current branch head, index and working tree had
   better be pristine with respect to the CVS repository for
   this, but that is already an requirement for a tracking
   branch anyway) when your current branch is the tracking
   branch, or merge the imported result into your current branch
   if you are using a separate tracking branch.

   I've done some testing on this myself, but am waiting for
   independent confirmations from cvsimport users.  Merlyn?

 - refs/remotes support.

   This has been the recent hot topic, on git-clone.

   First, not so controversial one.  A new option --reference
   can be used to help cloning a project similar to what you
   already have over thin wire:

	$ git clone --reference /git/linux-2.6.git \
          git://git.kernel.org/pub/.../jgarzik/libata-dev.git/ \
          libata-dev

   What happens here is that the new repository (libata-dev you
   are creating by cloning from Jeff) is set up to borrow from
   vanilla Linus repository you already keep track of, and the
   initial clone downloads and expands objects that are only
   present in Jeff's tree.

   Another new option, --use-separate-remote, changes the way
   $GIT_DIR/remotes/origin file and your tracking branches are
   set up after the initial cloning.  Without it, all the remote
   heads are copied to your $GIT_DIR/refs/heads/ and a copy of
   the remote HEAD is made as $GIT_DIR/refs/heads/origin, and
   remotes/origin file is set up to keep this structure up to
   date.  This is the traditional behaviour.

   When --use-separate-remote is in effect, the tracking
   branches are created in $GIT_DIR/refs/remotes/origin/ and you
   will not get the extra "origin" head.  Your local branch
   namespace under $GIT_DIR/refs/heads/ will only have "master".
   In addition, a symref $GIT_DIR/refs/remotes/origin/HEAD
   points at the primary branch of the remote repository.
   Similar to a filename in $GIT_DIR/refs/{heads,tags} that can
   be used to name a ref (e.g. when you say "git diff frotz",
   you are telling git to read from $GIT_DIR/refs/heads/frotz
   and use that commit ID to diff your working tree against), a
   directory that has such a symref under $GIT_DIR/refs/remotes
   can be used to name the ref.  IOW, "git diff origin" in a
   repository a cloned this way means you want a diff against
   $GIT_DIR/refs/remotes/origin/HEAD.

   I've done reasonable amount of testing over git:// transport,
   and some with http:// as well, but I do not know if rsync://
   works at all (I never use rsync:// transport myself).  If
   anybody cares about rsync:// transport, please test it while
   it still is in "next" to keep things working for you.

   A new configuration option, 'core.warnambiguousrefs', can be
   set to warn you if you use "frotz" to name a ref when you
   have more than one "frotz" under $GIT_DIR/refs (e.g. you have
   both branch "frotz" and tag "frotz", and/or you have
   refs/remotes/frotz/HEAD).

   It also has changes by Eric Wong to teach git-fetch about
   $GIT_DIR/refs/remotes hierarchy.
