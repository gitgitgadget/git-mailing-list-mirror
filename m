From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Sun, 21 Jan 2007 03:20:06 -0800
Message-ID: <7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 12:20:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8akC-0007Ev-9t
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 12:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbXAULUM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 06:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbXAULUM
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 06:20:12 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:49128 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbXAULUI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 06:20:08 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070121112007.FJPZ20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Sun, 21 Jan 2007 06:20:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id DnKB1W00B1kojtg0000000; Sun, 21 Jan 2007 06:19:12 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37321>

BTW, as the upcoming v1.5.0 release will introduce quite a bit of
surface changes (although at the really core it still is the old
git and old ways should continue to work), I am wondering if it
would help people to try out and find wrinkles before the real
thing for me to cut a tarball and a set of RPM packages.

Comments?

Also, in the same spirit of giving the release an early
exposure, here is the current draft of 1.5.0 release notes.

-- >8 -- cut here -- >8 --

GIT v1.5.0 Release Notes (draft)
================================

Old news
--------

This section is for people who are upgrading from ancient
versions of git.  Although all of the changes in this section
happened before the current v1.4.4 release, they are summarized
here in the v1.5.0 release notes for people who skipped earlier
versions.

In general, you should not have to worry about incompatibility,
and there is no need to perform "repository conversion" if you
are updating to v1.5.0.  However, some of the changes are
one-way street upgrades; once you use them your repository
can no longer be used with ancient git.

 - There is a configuration variable core.legacyheaders that
   changes the format of loose objects so that they are more
   efficient to pack and to send out of the repository over git
   native protocol, since v1.4.2.  However, loose objects
   written in the new format cannot be read by git older than
   that version; people fetching from your repository using
   older clients over dumb transports (e.g. http) using older
   versions of git will also be affected.

 - Since v1.4.3, configuration repack.usedeltabaseoffset allows
   packfile to be created in more space efficient format, which
   cannot be read by git older than that version.

The above two are not enabled by default and you explicitly have
to ask for them, because these two features make repositories
unreadable by older versions of git, and in v1.5.0 we still do
not enable them by default for the same reason.  We will change
this default probably 1 year after 1.4.2's release, when it is
reasonable to expect everybody to have new enough version of
git.

 - 'git pack-refs' appeared in v1.4.4; this command allows tags
   to be accessed much more efficiently than the traditional
   'one-file-per-tag' format.  Older git-native clients can
   still fetch from a repository that packed and pruned refs
   (the server side needs to run the up-to-date version of git),
   but older dumb transports cannot.  Packing of refs is done by
   an explicit user action, either by use of "git pack-refs
   --prune" command or by use of "git gc" command.

 - 'git -p' to paginate anything -- many commands do pagination
   by default on a tty.  Introduced between v1.4.1 and v1.4.2;
   this may surprise old timers.

 - 'git archive' superseded 'git tar-tree' in v1.4.3;

 - 'git cvsserver' was new invention in v1.3.0;

 - 'git repo-config', 'git grep', 'git rebase' and 'gitk' were
   seriously enhanced during v1.4.0 timeperiod.

 - 'gitweb' became part of git.git during v1.4.0 timeperiod and
   seriously modified since then.

 - reflog is an v1.4.0 invention.  This allows you to name a
   revision that a branch used to be at (e.g. "git diff
   master@{yesterday} master" allows you to see changes since
   yesterday's tip of the branch).


Updates in v1.5.0 since v1.4.4 series
-------------------------------------

* Index manipulation

 - git-add is to add contents to the index (aka "staging area"
   for the next commit), whether the file the contents happen to
   be is an existing one or a newly created one.

 - git-add without any argument does not add everything
   anymore.  Use 'git-add .' instead.  Also you can add
   otherwise ignored files with an -f option.

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


* Repository layout and objects transfer

 - The data for origin repository is stored in the configuration
   file $GIT_DIR/config, not in $GIT_DIR/remotes/, for newly
   created clones.  The latter is still supported and there is
   no need to convert your existing repository if you are
   already comfortable with your workflow with the layout.

 - git-clone always uses what is known as "separate remote"
   layout for a newly created repository with a working tree;
   i.e. tracking branches in $GIT_DIR/refs/remotes/origin/ are
   used to track branches from the origin.  

 - New branches that appear on the origin side after a clone is
   made are also tracked automatically.  This is done with an
   wildcard refspec "refs/heads/*:refs/remotes/origin/*", which
   older git does not understand, so if you clone with 1.5.0,
   you would need to downgrade remote.*.fetch in the
   configuration file to specify each branch you are interested
   in individually if you plan to fetch into the repository with
   older versions of git (but why would you?).

 - git-branch and git-show-branch know remote tracking branches.

 - git-push can now be used to delete a remote branch or a tag.
   This requires the updated git on the remote side.

 - git-push more agressively keeps the transferred objects
   packed.  Earlier we recommended to monitor amount of loose
   objects and repack regularly, but you should repack when you
   accumulated too many small packs this way as well.  Updated
   git-count-objects helps you with this.

 - A new command, git-remote, can help you manage your remote
   tracking branch definitions.


* Bare repositories

 - Certain commands change their behaviour in a bare repository
   (i.e. a repository without associated working tree).  We use
   a fairly conservative heuristic (if $GIT_DIR is ".git", or
   ends with "/.git", the repository is not bare) to decide if a
   repository is bare, but "core.bare" configuration variable
   can be used to override the heuristic when it misidentifies
   your repository.

 - git-fetch used to complain updating the current branch but
   this is now allowed for a bare repository.  So is the use of
   'git-branch -f' to update the current branch.

 - Porcelain-ish commands that require a working tree refuses to
   work in a bare repository.


* Reflog

 - Reflog records the history of where the tip of each branch
   was at each moment.  This facility is enabled by default for
   repositories with working trees, and can be accessed with the
   "branch@{time}" and "branch@{Nth}" notation.

 - "git show-branch" learned showing the reflog data with the
   new --reflog option.  "git log" has --walk-reflogs option to
   view reflog entries in a more verbose manner.

 - git-branch knows how to rename branches and moves existing
   reflog data from the old branch to the new one.

 - The commits referred to by reflog entries are now protected
   against pruning.  The new command "git reflog expire" can be
   used to truncate older reflog entries and entries that refer
   to commits that have been pruned away previously with older
   versions of git.

   Existing repositories that have been using reflog may get
   complaints from fsck-objects and may not be able to run
   git-repack, if you had run git-prune from older git; please
   run "git reflog expire --stale-fix --all" first to remove
   reflog entries that refer to commits that are no longer in
   the repository when that happens.


* Crufts removal

 - We used to say "old commits are retrievable using reflog and
   'master@{yesterday}' syntax as long as you haven't run
   git-prune".  We no longer have to say the latter half of the
   above sentence, as git-prune does not remove things reachable
   from reflog entries.

 - 'git-prune' by default does not remove _everything_
   unreachable, as there is a one-day grace period built-in.

 - There is a toplevel garbage collector script, 'git-gc', that
   is an easy way to run 'git-repack -a -d', 'git-reflog gc',
   and 'git-prune'.


* Detached HEAD

 - You can give non-branch to "git checkout" now.  This will
   dissociate your HEAD from any of your branches.  A typical
   use of this feature is to "look around".  E.g.

	$ git checkout v2.6.16
	... compile, test, etc.
	$ git checkout v2.6.17
	... compile, test, etc.

 - After detaching your HEAD, you can go back to an existing
   branch with usual "git checkout $branch".  Also you can
   start a new branch using "git checkout -b $newbranch".

 - You can even pull from other repositories, make merges and
   commits while your HEAD is detached.  Also you can use "git
   reset" to jump to arbitrary commit.

   Going back to undetached state by "git checkout $branch" can
   lose the current stat you arrived in these ways, and "git
   checkout" refuses when the detached HEAD is not pointed by
   any existing ref (an existing branch, a remote tracking
   branch or a tag).  This safety can be overriden with "git
   checkout -f $branch".


* Packed refs

 - Repositories with hundreds of tags have been paying large
   overhead, both in storage and in runtime, due to the
   traditional one-ref-per-file format.  A new command,
   git-pack-refs, can be used to "pack" them in more efficient
   representation.

 - Clones and fetches over dumb transports are now aware of
   packed refs and can download from repositories that use
   them.


* Configuration

 - configuration related to color setting are consolidated under
   color.* namespace (older diff.color.*, status.color.* are
   still supported).


* Less external dependency

 - We no longer require the "merge" program from the RCS suite.
   All 3-way file-level merges are now done internally.

 - The original implementation of git-merge-recursive which was
   in Python has been removed; we have C implementation of it
   now.

 - git-shortlog is no longer a Perl script.  It no longer
   requires output piped from git-log; it can accept revision
   parameters directly on the command line.


* I18n

 - We have always encouraged the commit message to be encoded in
   UTF-8, but the users are allowed to use legacy encoding as
   appropriate for their projects.  This will continue to be the
   case.  However, a non UTF-8 commit encoding _must_ be
   explicitly set with i18n.commitencoding in the repository
   where a commit is made; otherwise git-commit-tree will
   complain if the log message does not look like a valid UTF-8
   string.

 - The value of i18n.commitencoding in the originating
   repository is recorded in the commit object on the "encoding"
   header, if it is not UTF-8.  git-log and friends notice this,
   and reencodes the message to the log output encoding when
   displaying, if they are different.  The log output encoding
   is determined by "git log --encoding=<encoding>",
   i18n.logoutputencoding configuration, or i18n.commitencoding
   configuration, in the decreasing order of preference, and
   defaults to UTF-8. 

 - Tools for e-mailed patch application now default to -u
   behaviour; i.e. it always re-codes from the e-mailed encoding
   to the encoding specified with i18n.commitencoding.  This
   unfortunately forces projects that have happily been using a
   legacy encoding without setting i18n.commitencoding to set
   the configuration, but taken with other improvement, please
   excuse us for this very minor one-time inconvenience.


* e-mailed patches

 - See the above I18n section.

 - git-format-patch now enables --binary without being asked.
   git-am does _not_ default to it, as sending binary patch via
   e-mail is unusual and is harder to review than textual
   patches and it is prudent to require the person who is
   applying the patch to explicitly ask for it.

 - The default suffix for git-format-patch output is now ".patch",
   not ".txt".  This can be changed with --suffix=.txt option,
   or "format.suffix = .txt" in the configuration.


* Foreign SCM interfaces

  - git-svn now requires the Perl SVN:: libraries, the
    command-line backend was too slow and limited.

  - the 'commit' subcommand of git-svn has been renamed to
    'set-tree', and 'dcommit' is the recommended replacement for
    day-to-day work.


* User support

 - Quite a lot of documentation updates.

 - Bash completion scripts have been updated heavily.

 - Better error messages for often used Porcelainish commands.


* Sliding mmap

 - We used to assume that we can mmap the whole packfile while
   in use, but with a large project this consumes huge virtual
   memory space and truly huge ones would not fit in the
   userland address space on 32-bit platforms.  We now mmap huge
   packfile in pieces to avoid this problem.


* Shallow clones

 - There is a partial support for 'shallow' repositories that
   keeps only recent history.  A 'shallow clone' is created by
   specifying how deep that truncated history should be.

   Currently a shallow repository has number of limitations:

   - Cloning and fetching _from_ a shallow clone are not
     supported (nor tested -- so they might work by accident but
     they are not expected to).

   - Pushing from nor into a shallow clone are not expected to
     work.

   - Merging inside a shallow repository would work as long as a
     merge base is found in the recent history, but otherwise it
     will be like merging unrelated histories and may result in
     huge conflicts.

   but this would be more than adequate for people who want to
   look at near the tip of a big project with a deep history and
   send patches in e-mail format.
