From: Johan Herland <johan@herland.net>
Subject: [PATCH 00/18] git notes merge
Date: Wed, 29 Sep 2010 02:23:13 +0200
Message-ID: <1285719811-10871-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 29 02:24:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0kTP-0001F0-CS
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 02:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811Ab0I2AXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 20:23:46 -0400
Received: from smtp.getmail.no ([84.208.15.66]:44298 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858Ab0I2AXo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 20:23:44 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9H003XSFRITS70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Sep 2010 02:23:42 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id E9FEA1EEF823_CA2870DB	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 00:23:41 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 3B2461EEF595_CA2870DF	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 00:23:41 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9H00IQEFRHZC10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Sep 2010 02:23:41 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157503>

Hi,

This is the 2nd iteration of the 'git notes merge' patch series.

Changes between the 1st WIP/RFC iteration and this version:

- Rebased on top of e93487d which obsoletes patch #7 in the previous
  series. AFAICS, it now merges cleanly against "master", and almost
  cleanly (modulo one trivial conflict) against "next". If desired,
  I can rebase the series onto "next" to avoid the trivial conflict.

- (Jonathan Nieder) Future-proof by always checking add_note() return
  value.

- (Stephen Boyd) Simplify argc logic.

- (Stephen Boyd) Use test_commit.

- (Stephen Boyd) Use "automatically resolves" instead of
  "auto-resolves".

- Renamed -X/--resolve to -s/--strategy. This is more in line with
  'git merge' (although the available strategies are different), and
  allows us to use -X for strategy-specific options in the future.

- Documentation: Moved documentation of notes merge strategies into
  its own section.

- Implemented manual conflict resolution of notes. Conflicting note
  entries are stored in .git/NOTES_MERGE_WORKTREE/*, while the
  non-conflicting note entries are committed, and referenced by
  .git/NOTES_MERGE_PARTIAL (aka. the partial merge result). When the
  conflicts have been edited/fixed, the user calls
  'git notes merge --commit' to recombine the partial merge result and
  the resolved conflicts to produce the final notes merge result.
  Alternatively, the user can call 'git notes merge --reset' to abort
  the notes merge.

- Add another auto-resolving notes merge strategy: "cat_sort_uniq"

- Test merging of notes trees at different fanout levels


To be done in later series:

- Handle merging of notes trees with non-notes

- Allow notes merge strategies to be specified (per (group of?) notes
  ref) in the config


Some open questions:

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


Johan Herland (18):
  (trivial) notes.h: Minor documentation fixes to copy_notes()
  notes.h: Make default_notes_ref() available in notes API
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

 Documentation/git-notes.txt           |   81 ++++-
 Makefile                              |    2 +
 builtin.h                             |    2 +-
 builtin/notes.c                       |  245 ++++++++++--
 notes-cache.c                         |    3 +-
 notes-merge.c                         |  718 +++++++++++++++++++++++++++++++++
 notes-merge.h                         |   92 +++++
 notes.c                               |  272 +++++++++-----
 notes.h                               |   47 ++-
 t/t3301-notes.sh                      |    4 +
 t/t3303-notes-subtrees.sh             |   19 +-
 t/t3308-notes-merge.sh                |  327 +++++++++++++++
 t/t3309-notes-merge-auto-resolve.sh   |  647 +++++++++++++++++++++++++++++
 t/t3310-notes-merge-manual-resolve.sh |  556 +++++++++++++++++++++++++
 t/t3311-notes-merge-fanout.sh         |  436 ++++++++++++++++++++
 t/t3404-rebase-interactive.sh         |    1 +
 t/t9301-fast-import-notes.sh          |    5 +
 17 files changed, 3315 insertions(+), 142 deletions(-)
 create mode 100644 notes-merge.c
 create mode 100644 notes-merge.h
 create mode 100755 t/t3308-notes-merge.sh
 create mode 100755 t/t3309-notes-merge-auto-resolve.sh
 create mode 100755 t/t3310-notes-merge-manual-resolve.sh
 create mode 100755 t/t3311-notes-merge-fanout.sh

--
1.7.3.98.g5ad7d9
