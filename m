From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 00/21] git notes merge
Date: Thu, 21 Oct 2010 04:08:35 +0200
Message-ID: <1287626936-32232-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 04:10:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8kbx-0007sY-Nh
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 04:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756870Ab0JUCJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 22:09:08 -0400
Received: from smtp.getmail.no ([84.208.15.66]:33116 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756756Ab0JUCJE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 22:09:04 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAM00IPDBB1YX70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Oct 2010 04:09:01 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 544751EA568A_CBFA0BDB	for <git@vger.kernel.org>; Thu,
 21 Oct 2010 02:09:01 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 97D8D1EA285A_CBFA0BCF	for <git@vger.kernel.org>; Thu,
 21 Oct 2010 02:09:00 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAM0096KBB03500@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Oct 2010 04:09:00 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159469>

Hi,

This is the 4th iteration of the 'git notes merge' patch series.

Changes between v3 and v4:

- Fix (void *) arithmetic in notes-merge.c:write_buf_to_worktree(), noticed
  by Junio

- Change "CC:" into "Thanks-to:" in commit messages, to conform with current
  conventions.

- Remove extranous show() function from notes-merge.c. Refactor OUTPUT()
  macro accordingly

- notes_merge(): Rewrite logic around dereferencing o->local_ref into local
  commit, and o->remote_ref into remote commit, to clarify how empty/missing
  notes refs are handled. Also add more testcases verifying this part of the
  code.

Some open questions:

- Sverre Rabbelier suggests renaming 'git notes merge --reset' to
  'git notes merge --abort'. I sort of agree, but would want some
  consistency with 'git merge', e.g. by providing 'git merge --abort'
  as an alias to 'git reset --merge'.

- Should we refuse to finalize a notes merge when conflict markers
  present in .git/NOTES_MERGE_WORKTREE? Since add/commit in regular
  merges does NOT do this, I have not implemented it for notes merge.

- When resolving notes merge conflicts, you can add/remove files/notes
  in .git/NOTES_MERGE_WORKTREE; 'git notes merge --commit' does not
  check that the notes have any relationship to the notes originally
  put there by 'git notes merge'. Should we warn about removed and
  added notes in .git/NOTES_MERGE_WORKTREE? Currently we don't, and
  I'm not sure it's worth it. Users can always review the merge commit
  afterwards.

- Fetching and pushing note refs:
  - Add refs/notes/* to default fetch refspec?
  - A way to specify (at clone time) which refspec(s) to set up?
  - A way for the remote repo to hint at which refspecs you might want
    to set up (by default?)


Have fun! :)

...Johan


Johan Herland (21):
  notes.c: Hexify SHA1 in die() message from init_notes()
  (trivial) notes.h: Minor documentation fixes to copy_notes()
  notes.h: Make default_notes_ref() available in notes API
  notes.c: Reorder functions in preparation for next commit
  notes.h/c: Clarify the handling of notes objects that are == null_sha1
  notes.h/c: Propagate combine_notes_fn return value to add_note() and beyond
  (trivial) t3303: Indent with tabs instead of spaces for consistency
  notes.c: Use two newlines (instead of one) when concatenating notes
  builtin/notes.c: Split notes ref DWIMmery into a separate function
  git notes merge: Initial implementation handling trivial merges only
  builtin/notes.c: Refactor creation of notes commits.
  git notes merge: Handle real, non-conflicting notes merges
  git notes merge: Add automatic conflict resolvers (ours, theirs, union)
  Documentation: Preliminary docs on 'git notes merge'
  git notes merge: Manual conflict resolution, part 1/2
  git notes merge: Manual conflict resolution, part 2/2
  git notes merge: List conflicting notes in notes merge commit message
  git notes merge: --commit should fail if underlying notes ref has moved
  git notes merge: Add another auto-resolving strategy: "cat_sort_uniq"
  git notes merge: Add testcases for merging notes trees at different fanouts
  Provide 'git notes get-ref' to easily retrieve current notes ref

 Documentation/git-notes.txt           |   85 ++++-
 Makefile                              |    2 +
 builtin.h                             |    2 +-
 builtin/notes.c                       |  268 +++++++++++--
 notes-cache.c                         |    3 +-
 notes-merge.c                         |  735 +++++++++++++++++++++++++++++++++
 notes-merge.h                         |   98 +++++
 notes.c                               |  274 ++++++++----
 notes.h                               |   47 ++-
 t/t3301-notes.sh                      |   23 +
 t/t3303-notes-subtrees.sh             |   19 +-
 t/t3308-notes-merge.sh                |  368 +++++++++++++++++
 t/t3309-notes-merge-auto-resolve.sh   |  647 +++++++++++++++++++++++++++++
 t/t3310-notes-merge-manual-resolve.sh |  556 +++++++++++++++++++++++++
 t/t3311-notes-merge-fanout.sh         |  436 +++++++++++++++++++
 t/t3404-rebase-interactive.sh         |    1 +
 t/t9301-fast-import-notes.sh          |    5 +
 17 files changed, 3426 insertions(+), 143 deletions(-)
 create mode 100644 notes-merge.c
 create mode 100644 notes-merge.h
 create mode 100755 t/t3308-notes-merge.sh
 create mode 100755 t/t3309-notes-merge-auto-resolve.sh
 create mode 100755 t/t3310-notes-merge-manual-resolve.sh
 create mode 100755 t/t3311-notes-merge-fanout.sh

--
1.7.3.98.g5ad7d9
