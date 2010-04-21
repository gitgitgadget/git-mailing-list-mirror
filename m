From: Johan Herland <johan@herland.net>
Subject: 'git notes merge' implementation questions
Date: Wed, 21 Apr 2010 09:57:47 +0200
Message-ID: <201004210957.48138.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 21 09:58:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4Uor-0001Uq-AA
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 09:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615Ab0DUH5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 03:57:54 -0400
Received: from smtp.getmail.no ([84.208.15.66]:60707 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752552Ab0DUH5x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 03:57:53 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L17008ASVGDTS30@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 21 Apr 2010 09:57:49 +0200 (MEST)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L1700B0JVGCMY00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 21 Apr 2010 09:57:49 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.4.21.74517
User-Agent: KMail/1.13.2 (Linux/2.6.33-ARCH; KDE/4.4.2; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145415>

Hi,

I'm planning the implementation of 'git notes merge', a new 'git notes'
subcommand that will (in addition to various options not yet determined)
take a <notes_ref> argument, identifying a notes tree to be merged into
the _current_ notes_ref (as specified with --ref, $GIT_NOTES_REF,
core.notesRef, or defaulted to "refs/notes/commits").

This subcommand will typically be used when pulling notes from remotes.
What follows, are my thoughts on how this command should work, and
implementation challenges/problems that I'm not yet sure how to solve:

For merges between notes refs with no common history the merge should be
a straightforward joining of trees. This also covers the "history-less"
notes refs, like Peff's notes-cache, and should work whether the notes
refs point to parentless commits, or point directly to tree objects (if
we want to support that). For merges between notes refs with common
history we want to do a (more or less regular) three-way merge.

In both cases (with or without common history), conflicts may ensue,
and these must of course be resolved in some way. Since the notes refs
have no accompanying worktree, we must find some other way to resolve
conflicts. See the discussion on "conflict resolvers" below for more
details.

I would like to adapt the current merge machinery to do most of the
work for us, but there are some non-trivial challenges in adapting it
to the needs of the 'git notes merge' command. AFAICS, there are two
major problems:


1. Handling different notes-tree fanouts in a merge scenario

   Notes trees adjust their fanout automatically based on the number
   of notes, and we will inevitably have to merge notes trees with
   _different_ fanouts. This must be handled in some fashion, so that
   conflicting notes for the same object - but located at different
   fanouts - are properly conflict-resolved.

   Possible solution: When building the index, add a callback (within
   'read-tree'?) that may manipulate each entry added to the index.
   Provide a callback that simply removes all directory separators,
   thus normalising all note object names to their 40-char SHA1. As a
   result, the merge happens in a large flat "directory" with no
   "subdirs". When converting the index back into a notes tree, we
   obviously need to auto-establish an appropriate fanout.

   Remaining problem: How do we still ignore/skip identical subtrees?

   Alternative solution: As a pre-merge step, require that the notes
   trees are forced/rewritten to a common fanout (rewriting the smaller
   notes tree into the fanout of the larger notes tree).


2. Merging without a worktree

2.1 Problem: 'git merge' operates on the current HEAD.

    Possible solution: Allow 'merge' to update a ref that is not HEAD
    (i.e. remove HEAD from all merge logic). Instead, allow users to
    explicitly specify which ref to update (and thus the first parent
    of the merge).

2.2 Problem: 'git merge' operates on the current index.

    Simple solution: Provide a separate index (using $GIT_INDEX_FILE)
    in which the merge can take place (possibly using the modified
    'read-tree' from above)

2.3 Problem: 'git merge' updates the worktree.

    Simple solution:  When 'merge' has prepared an index (containing
    unmerged entries), _don't_ start looking for a working tree.
    Instead, invoke conflict resolvers on the unmerged entries (see
    below).

2.4 Problem: Resolving conflicts without a worktree.

    Possible solution: Conflict resolvers:

    These are functions/programs that resolve unmerged entries in the
    index without requiring a worktree. There should be several
    built-in/bundled conflict resolvers, and it should be possible for
    the user to choose between them, and also to add _additional_
    (custom) conflict resolvers. The merge machinery should have a
    simple interface against the conflict resolvers, with 3 inputs
    (<base SHA1>, <ours SHA1>, <theirs SHA1>) and 1 output
    (<resulting SHA1>).
    The bundled conflict resolvers should at least include:

    - "ours" (similar to 'git merge-file --ours')
    - "theirs" (similar to 'git merge-file --theirs')
    - "union" (similar to 'git merge-file --union')

    In addition to the fully automatic resolvers, there may be room for
    additional conflict resolvers that require user interaction:

    - "edit" (manually resolve conflicts in an editor)
    - "mergetool" (manually resolve conflicts in the chosen mergetool)

    These resolvers would follow the same interface towards the merge
    machinery, and the resolvers are thus responsible for preparing
    whatever temporary file(s) and/or invoking whatever editors,
    mergetools or other user interactions that are needed.


As you may see from the above, I'm not very familiar with the merge
machinery and manipulation of the index (currently struggling to grok
merge.c...). I hope to re-use as much as possible of the current merge
logic (instead of re-implementing it), but I might be ignorant of
certain details that simplifies, or complicates, the implementation of
'git notes merge'.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
