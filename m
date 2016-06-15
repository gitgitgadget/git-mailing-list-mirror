From: Junio C Hamano <junkio@cox.net>
Subject: GIT 0.99.6
Date: Wed, 07 Sep 2005 17:08:31 -0700
Message-ID: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Sep 08 02:09:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ED9y6-0005Mh-A1
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 02:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbVIHAIg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 20:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVIHAIg
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 20:08:36 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:4996 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751322AbVIHAIf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2005 20:08:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050908000833.JBNJ20473.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Sep 2005 20:08:33 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8183>

Highlights
==========

* Documentation is in much better shape.  Thanks everybody.

* Two grave bugs in 'git fetch' were caught and fixed.  One is "Fix
  fetching of tags", the other is "Fix pulling into the same branch.".

* We have archimport (unfortunately undocumented yet), and
  cvsimport is being improved.

* Revert, rebase and cherry-pick are done using three-way merge,
  not a straight patch application.

* 'git commit' should be a bit easier to use than before in
  initial commits and merge commits.

* 'git applymbox' is a bit more accomodating and it should be
  easier to handle MIME patches than before.

* As usual, comes with more recent gitk.

Better merge algorithms and the infrastructure are being worked
on by Daniel and Fredrik; they are not in this release yet.


What to expect after 0.99.6
===========================

This is written in a form of to-do list for me, so if I say
"accept patch", it means I do not currently plan to do that
myself.  People interested in seeing it materialize please take
a hint.  The latest copy of this document is found at 

    http://kernel.org/git/?p=git/git.git;a=blob;hb=todo;f=TODO

Tool Renames Plan
-----------------

 - All non-binary commands will lose -script suffix in
   $(bindir).  The source to git-foo will be either git-foo.sh
   or git-foo.perl in the source tree, and the documentation
   will be in Documentation/git-foo.txt.

 - The commands whose names have 'cache' to mean 'index file'
   will get 'cache' in their names replaced with 'index'. For
   git-fsck-cache and git-convert-cache, 'cache' will be
   replaced with 'objects'.

 - The commit walkers will have 'pull' in their names replaced
   with 'fetch'.  'git-ssh-push' will become 'git-ssh-upload'.

 - We continue to follow the convention to name the C source
   file that contains the main program of 'git-foo' command
   'foo.c'.  That means we will have 'fsck-objects.c', for
   example.

 - At this moment, I am not planning to rename the symbols used
   in programs, nor any library sources.  "cache.h" will stay
   "cache.h", so does "read-cache.c".  "struct cache_entry"  and
   "ce_match_stat()" will keep their names.  We _might_ want to
   rename them in later rounds but not right now.

 - In 0.99.7, all renamed commands will have symbolic links in
   $(bindir) so that old names continue to work.  These backward
   compatible symlinks will not be present in documentation,
   though.  Especially, the main documentation, git(7) will talk
   about the new names.  Old environment names defined in
   gitenv() will also be removed in this release.

   Tentatively we aim to do this on Sep 17th.

 - In 0.99.8, we do not install these backward compatible
   symbolic links in $(bindir) anymore.  The Makefile will have
   a target to remove old symlinks from $(DESTDIR)$(bindir) you
   can run manually to help you clean things up.

   The timeframe for this is around Oct 1st, but I could be
   talked into delaying the symlink removal if Porcelain people
   find this schedule too tight.


Documentation
-------------

* Accept patches from people who actually have done CVS
  migration and update the cvs-migration documentation.
  Link the documentation from the main git.txt page.

* Accept patches from people who were hit by shiny blue bat to
  update the SubmittingPatches [ONGOING].

* Talk about using rsync just once at the beginning when
  initializing a remote repository so that local packs do not
  need to be expanded.  I personally do not think we need tool
  support for this (but see below about optimized cloning).

* Maybe update tutorial with a toy project that involves two or
  three developers..

* Update tutorial to cover setting up repository hooks to do
  common tasks.

* Accept patches to finish missing docs.


Technical (heavier)
-------------------

* Tony Luck reported an unfortunate glitch in the 3-way merge.
  Encourage discussions to come up with a not-so-expensive way
  to catch the kind of ambiguities that led to his misery.
  [Daniel's patch looks quite promising, so is the one from
  Fredrik.]

* HPA has two projects, klibc and klibc-kbuild, that have large
  set of overlapping files in different paths (i.e. one has many
  renames from the other).  There currently is no way for git to
  help keep these two trees in sync, merging criss-cross between
  them.  The merge logic should be able to take advantage of
  rename/copy detection smarts git-diff-* family has.  Linus,
  me, and Daniel outlined a smarter merge strategy for this.
  Try them out.

* To make it easier to experiment with different merge
  strategies, make git-merge driver that will run merge backends
  for the best merge [Outlined the idea; just do it].

* We might want to optimize cloning with GIT native transport
  not to explode the pack, and store it in objects/pack instead.
  We would need a tool to generate an idx file out of a pack
  file for this.  Also this itself may turn out to be a bad
  idea, making the set of packs in repositories everybody has
  different from each other.

* Maybe a pack optimizer.  I am not convinced that packing all
  objects into a single pack and removing all the existing panck
  is the right way to go, since that would work against people
  who already have those packs.

* Maybe an Emacs VC backend.


Technical (milder)
------------------

* Tool renames [STARTED].

* Have Daniel's read-tree graduate from "pu" after plugging leaks.

* Implement a merge backend using Daniel's read-tree.

* Accept Fredrik merge after renaming it (I want to name the
  driver 'git merge').  Suggest where to place *.py stuff --
  probably in $(share)/git-core/ and add Makefile entry for
  installation.

* Encourage concrete proposals to commit log message templates
  we discussed some time ago.

* Bug Martin for archimport script documentation.

* More portability.  I dropped a SunOS patch on the floor by
  somebody.

* Accept patches to cause "read-tree -u" delete a directory when
  it makes it empty.

* Perhaps accept patches to introduce the concept of "patch flow
  expressed as ref mappings" Josef has been advocating about.

* Perhaps accept patches to do undo/redo.

* Maybe grok PGP signed text/plain in applymbox as well.

* Perhaps a tool to revert a single file to pre-modification
  state?  git-cat-file blob `git-ls-files | grep foo` >foo or
  git-cat-file blob `git-ls-tree HEAD foo` >foo?  What should
  the command be called?  git-revert is taken so is
  git-checkout.

* A tool to detect, show and prune already merged topic
  branches.

* Enhance "git repack" to not always use --all; this would be
  handy if the repository contains wagging heads like "pu" in
  git.git repository.

* Internally split the project into non-doc and doc parts; add
  an extra root for the doc part and merge from it; move the
  internal doc source to a separate repository, like the +Meta
  repository; experiment if this results in a reasonable
  workflow, and document it in howto form if it does.

* Option to limit rename detection for more than N paths.


Technical (trivial)
-------------------

* Perhaps "git branch -d" to delete a branch.

* We would want test scripts for the relative directory path
  stuff Linus has been working on.  So far, the following
  commands should be usable with relative directory paths:

    update-cache
    ls-files
    diff-files
    diff-cache
    diff-tree
    rev-list
    rev-parse

* In a freashly created empty repository, `git fetch foo:bar`
  works OK, but `git checkout bar` afterwards does not (missing
  `.git/HEAD`).
