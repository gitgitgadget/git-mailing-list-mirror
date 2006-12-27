From: Junio C Hamano <junkio@cox.net>
Subject: [RFH] An early draft of v1.5.0 release notes
Date: Tue, 26 Dec 2006 23:39:41 -0800
Message-ID: <7vvejx948y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Dec 27 08:39:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzTO7-0008A4-Jc
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 08:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932969AbWL0Hjn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 02:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932970AbWL0Hjn
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 02:39:43 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:36353 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932969AbWL0Hjm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 02:39:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061227073942.CEIU2628.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Dec 2006 02:39:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3jfv1W00L1kojtg0000000; Wed, 27 Dec 2006 02:39:55 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35450>

This is still rough, but I think we have a pretty good idea what
will and what won't be in v1.5.0 by now, and end-of-year is a
good slow time to summarize what we have done.

One thing I am wondering is if delta from v1.4.4.3 is good
enough for the intended audience of this release notes.  I am
reasonably sure that the name v1.5.0 will attract more people
than usual and there will be many people upgrading directly from
ancient versions such as v1.1.6 or v1.2.0, and there are a
handful "one-way-street upgrades" and quite a few user visible
changes that already have happened before v1.4.4.  Namely:

 - Pack-compatible loose object headers, introduced between
   v1.4.1 and v1.4.2; repository cannot be read with ancient
   version of git anymore -- this is a one-way street but
   core.legacyheaders is still not enabled by default);

 - delta-base-offset pack encoding, introduced between v1.4.2
   and v1.4.3; this is also a one-way street.

 - 'git -p' to paginate anything -- many commands do pagination
   by default on a tty.  Introduced between v1.4.1 and v1.4.2;
   this may surprise old timer users.

 - 'git archive' superseded 'git tar' in v1.4.3;

 - 'git pack-refs' appeared in v1.4.4;

 - 'git cvsserver' was new invention in v1.3.0;

 - 'git repo-config', 'git grep', 'git rebase' and 'gitk' were
   seriously enhanced during v1.4.0 timeperiod.

 - 'gitweb' became part of git.git during v1.4.0 timeperiod and
   seriously modified since then.

 - reflog is v1.4.0 invention.

In the following, I am assuming that jc/utf8 and jc/fsck-reflog
topics currently in 'next' will be part of v1.5.0.


-- >8 --

Updates in v1.5.0 since v1.4.4 series
-------------------------------------

* Index manipulation

 - git-add is to add contents to the index (aka "staging area"
   for the next commit), whether the file the contents happen to
   be is an existing one or a newly created one.

 - git-add without any argument does not add everything
   anymore.  Say "git add ." if you want to.

 - git-add tries to be more friendly to users by offering an
   interactive mode.

 - git-commit <path> used to refuse to commit if <path> was
   different between HEAD and the index (i.e. update-index was
   used on it earlier).  This check was removed.

 - git-rm is much saner and safer.  It is used to remove paths
   from both the index file and the working tree, and makes sure
   you are not losing any local modification before doing so.

 - git-reset <tree> <paths>... can be used to revert index
   entries for selected paths.

 - git-update-index is much less visible.


* Repository layout

 - The data for origin repository is stored in the configuration
   file $GIT_DIR/config, not in $GIT_DIR/remotes/, for newly
   created clones (the latter is still supported).

 - git-clone always uses what is known as "separate remote"
   layout for a newly created repository with a working tree;
   i.e. tracking branches in $GIT_DIR/refs/remotes/origin/ are
   used to track branches from the origin.  New branches that
   appear on the origin side after a clone is made are also
   tracked automatically.

 - git-clone used to be buggy and copied refs outside refs/heads
   and refs/tags; it doesn't anymore.

 - git-branch and git-show-branch know remote tracking branches.

 - git-push can now be used to delete a remote branch or a tag.


* Reflog

 - Reflog records the history of where the tip of each branch
   was at each moment.  This facility is enabled by default for
   repositories with working trees, and can be accessed with the
   "branch@{time}" and "branch@{Nth}" notation.

 - "git show-branch" learned showing the reflog data with the
   new --reflog option.

 - The commits referred to by reflog entries are now protected
   against pruning.  The new command "git reflog expire" can be
   used to truncate older reflog entries and entries that refer
   to commits that have been pruned away previously.

   Existing repositories that have been using reflog may get
   complaints from fsck-objects; please run "git reflog expire
   --all" first to remove reflog entries that refer to commits
   that are no longer in the repository before attempting to
   repack it.

 - git-branch knows how to rename branches and moves existing
   reflog data from the old branch to the new one.


* Packed refs

 - Repositories with hundreds of tags have been paying large
   overhead, both in storage and in runtime.  A new command,
   git-pack-refs, can be used to "pack" them in more efficient
   representation.

 - Clones and fetches over dumb transports are now aware of
   packed refs and can download from repositories that use
   them.


* Configuration

 - configuration related to colorize setting are consolidated
   under color.* namespace (older diff.color.*, status.color.*
   are still supported).


* Less external dependency

 - We have been depended on "merge" program from RCS suite for
   the file-level 3-way merge, but now we lost this dependency.

 - The original implementation of git-merge-recursive which was
   in Python has been removed; we have C implementation of it
   now.

 - git-shortlog is not in Perl anymore, and more importantly it
   does not have to be piped output from git-log.  It can
   traverse the commit ancestry itself.


* I18n

 - We have always encouraged the commit message to be encoded in
   UTF-8, but the users are allowed to use legacy encoding as
   appropriate for their projects (which will never change).
   A non UTF-8 commit encoding however _must_ be explicitly set
   with i18n.commitencoding in the repository configuration;
   otherwise git-commit-tree will complain if the log message does
   not look like a valid UTF-8 string.

 - A commit object recorded in non UTF-8 encoding records the
   encoding i18n.commitencoding specified in the originating
   repository in a new "encoding" header.  This information is
   used by git-log and friends to reencode the message to UTF-8
   when displaying.


* User support

 - Quite a lot of documentation updates.

 - Bash completion scripts have been updated heavily.

 - Better error messages for often used Porcelainish commands.


----------------------------------------------------------------
(shortlog since v1.4.4.3 here)
