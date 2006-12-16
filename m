X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Sat, 16 Dec 2006 15:10:53 -0800
Message-ID: <7vodq3a136.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 23:11:48 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34653>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvih0-0008Q9-Cz for gcvg-git@gmane.org; Sun, 17 Dec
 2006 00:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422768AbWLPXK4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 18:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422712AbWLPXK4
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 18:10:56 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:59406 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1422768AbWLPXKz (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 18:10:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216231054.QFQO97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Sat, 16
 Dec 2006 18:10:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zbB51V00x1kojtg0000000; Sat, 16 Dec 2006
 18:11:06 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Things that I feel should be done need to be done to complete
v1.5.0 are:

 - 'git-rm' needs to be fixed up as Linus outlined; remove
   working tree file and index entry but have a sanity check to
   make sure the working tree file match the index and HEAD.

 - tutorials and other Porcelain documentation pages need to be
   updated to match the updated 'git-add' and 'git-rm' (to be
   updated), and their description should be made much less
   about implementation; they should talk in terms of end-user
   workflows.

   We need a full sweep on Porcelain-ish documentation.

 - now reflog is enabled by default for user repositories, I
   have two worries about its effect, fortunately can be killed
   with a single stone.

   * the reflog grows unbounded;

   * revisions recorded in the reflog can be pruned out,
     rendering some entries in reflog useless.

   I am thinking about teaching fsck-objects and prune to keep
   revisions recorded in the reflog; we would need an end-user
   way to prune older reflog entries and I would appreciate
   somebody codes it up, but even without it, people can always
   use "vi" or "ed" on reflog files ;-).

 - 'git-add' might want to do 'update-index --replace'; probably
   needs a sanity-checking discussion before implementing it.

 - 'git-svn' users should speak out about two issues:

   * use of svn command line client as the backend is being
     removed;

   * 'git-svn commit' command is being renamed to avoid
     confusion, and potentially 'dcommit' will be renamed to 
     'commit'.

   Please discuss these with Eric.

 - we might want to address the issue that 'git-status' output
   does not make it easy to tell mode changes from content
   changes.  Personally I do not like cryptic "M+" output format
   proposed by Lars and find the current output more readable.

----------------------------------------------------------------
As usual, '+' are both in 'next' and 'pu', '-' are in 'pu' only.

*  jn/web (Sat Dec 16 17:12:55 2006 +0100) 9 commits
 - gitweb: Add some mod_perl specific support
 + gitweb: Add "next" link to commit view
 + gitweb: Add title attribute to ref marker with full ref name
 + gitweb: Do not show difftree for merges in "commit" view
 + gitweb: SHA-1 in commit log message links to "object" view
 + gitweb: Hyperlink target of symbolic link in "tree" view (if
   possible)
 + gitweb: Add generic git_object subroutine to display object of any
   type
 + gitweb: Show target of symbolic link in "tree" view
 + gitweb: Don't use Content-Encoding: header in git_snapshot

All except the tip (mod_perl) looked good and should be in
v1.5.0; I haven't formed an opinion on mod_perl change yet.

*  js/branch-config (Sat Dec 16 15:15:02 2006 +0100) 2 commits
 + git-branch: rename config vars branch.<branch>.*, too
 + add a function to rename sections in the config

This moves branch.$foo.* variables to branch.$bar.* when $foo
branch is renamed to $bar.  Because we already have branch -m
(stands for "mv"), this series is a must-have in v1.5.0.

*  jc/clone (Sat Dec 16 01:53:10 2006 -0800) 4 commits
 + git-clone: lose the traditional 'no-separate-remote' layout
 + git-clone: lose the artificial "first" fetch refspec
 + git-pull: refuse default merge without branch.*.merge
 + git-clone: use wildcard specification for tracking branches

Fixes the workflow wart and removes the traditional layout that
maps remote 'master' to refs/heads/origin.  Also 'git pull' and
'git pull origin' would not merge the ref on the first Pull:
line (nor remote.*.fetch item) anymore.  You either have to give
an explicit command line parameter or branch.$currbranch.merge
item.  With blessing from Linus, this will be in v1.5.0.

*  ew/svn-pm (Fri Dec 15 23:58:08 2006 -0800) 3 commits
 + git-svn: rename 'commit' command to 'set-tree'
 + git-svn: remove support for the svn command-line client
 + git-svn: convert to using Git.pm

It is in 'next' because I agree it is in the right direction in
the longer term, but not in 'master' because this might be
controvertial for shorter term.  The users should decide.

** jc/reflog (Thu Dec 14 15:58:56 2006 -0800) 1 commit
 - Teach show-branch how to show ref-log data.

A strawman to make reflog data a bit more browsable; it would be
useful while recovering from a mistake you made recently.  Not
essential and can wait or be dropped if people do not find it
useful.

** jc/git-add--interactive (Mon Dec 11 17:09:26 2006 -0800) 2 commits
 - git-add --interactive: hunk splitting
 - git-add --interactive

I've thought about further allowing to edit the patches in the
'patch' subcommand, but the more I think about it, the less it
makes sense from the workflow point of view.  Will be the topic
for a separate message.

** sv/git-svn (Tue Dec 5 16:17:38 2006 +1100) 5 commits
 . git-svn: re-map repository URLs and UUIDs on SVK mirror paths
 . git-svn: collect revision properties when fetching
 . git-svn: collect SVK source URL on mirror paths
 . git-svn: let libsvn_ls_fullurl return properties too
 . git-svn: make test for SVK mirror path import

Still held but dropped from 'pu' for now (depends on "sub sys"
that was removed from git-svn).

** jc/explain (Mon Dec 4 19:35:04 2006 -0800) 1 commit
 - git-explain

Backburnered.

*  jc/blame-boundary (Fri Dec 1 20:45:45 2006 -0800) 1 commit
 + git-blame: show lines attributed to boundary commits differently.

Will merge.

*  jc/3way (Wed Nov 29 18:53:13 2006 -0800) 1 commit
 + git-merge: preserve and merge local changes when doing fast
   forward

Will merge, if only to see what breaks.

*  js/shallow (Fri Nov 24 16:00:13 2006 +0100) 15 commits
 + fetch-pack: Do not fetch tags for shallow clones.
 + get_shallow_commits: Avoid memory leak if a commit has been
   reached already.
 + git-fetch: Reset shallow_depth before auto-following tags.
 + upload-pack: Check for NOT_SHALLOW flag before sending a shallow
   to the client.
 + fetch-pack: Properly remove the shallow file when it becomes
   empty.
 + shallow clone: unparse and reparse an unshallowed commit
 + Why didn't we mark want_obj as ~UNINTERESTING in the old code?
 + Why does it mean we do not have to register shallow if we have
   one?
 + We should make sure that the protocol is still extensible.
 + add tests for shallow stuff
 + Shallow clone: do not ignore shallowness when following tags
 + allow deepening of a shallow repository
 + allow cloning a repository "shallowly"
 + support fetching into a shallow repository
 + upload-pack: no longer call rev-list

Undecided but not likely to be in v1.5.0.  Needs more real
project testing.

** jc/web (Wed Nov 8 14:54:09 2006 -0800) 1 commit
 - gitweb: steal loadavg throttle from kernel.org

Undecided.

** jc/pickaxe (Sun Nov 5 11:52:43 2006 -0800) 1 commit
 - blame: --show-stats for easier optimization work.

Developer only.

** jc/leftright (Sun Oct 22 17:32:47 2006 -0700) 1 commit
 - rev-list --left-right

Backburnered.

** jc/diff (Mon Sep 25 23:03:34 2006 -0700) 1 commit
 - para-walk: walk n trees, index and working tree in parallel

Backburnered.

*  jc/diff-apply-patch (Fri Sep 22 16:17:58 2006 -0700) 1 commit
 + git-diff/git-apply: make diff output a bit friendlier to GNU patch
   (part 2)

Not in v1.5.0.
