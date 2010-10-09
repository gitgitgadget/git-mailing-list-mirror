From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 00/21] git notes merge
Date: Sat,  9 Oct 2010 03:08:27 +0200
Message-ID: <1286586528-3473-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 03:09:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4Nw8-0001XH-TX
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 03:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760111Ab0JIBJN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 21:09:13 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:52263 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760090Ab0JIBJL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 21:09:11 -0400
Received: from pd9587e9f.dip.t-dialin.net ([217.88.126.159] helo=localhost.localdomain)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P4Nvu-00011L-QA; Sat, 09 Oct 2010 03:09:07 +0200
X-Mailer: git-send-email 1.7.3.1.104.g92b87a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158552>

Hi,

This is the 3rd iteration of the 'git notes merge' patch series.

Changes between v2 and v3:

- Add initial patch fixing a missing sha1_to_hex() call in die() messag=
e
  from init_notes().

- (=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason) Don't use C99 comments.

- (=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason) Fix nonsense sentence in --c=
ommit description

- (Stephen Boyd) Use correct option name

- (Stephen Boyd) Remove unbalanced '('

- (Jonathan Nieder) Split the function reordering from (then) patch
  #3 into a separate patch (now patch #4), preceding the rest of the
  original patch (now patch #5). Also, clarify the behavioural change
  of that patch in its commit message.
 =20
- (Jonathan Nieder) Describe in the commit message how existing callers
  of add_note() are modified to deal with add_note()'s return value.

- (Jonathan Nieder) Add patch implementing 'git notes get-ref'


To be done in later series:

- Handle merging of notes trees with non-notes

- Allow notes merge strategies to be specified (per (group of?) notes
  ref) in the config


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

=2E..Johan


Johan Herland (21):
  notes.c: Hexify SHA1 in die() message from init_notes()
  (trivial) notes.h: Minor documentation fixes to copy_notes()
  notes.h: Make default_notes_ref() available in notes API
  notes.c: Reorder functions in preparation for next commit
  notes.h/c: Clarify the handling of notes objects that are =3D=3D null=
_sha1
  notes.h/c: Propagate combine_notes_fn return value to add_note() and =
beyond
  (trivial) t3303: Indent with tabs instead of spaces for consistency
  notes.c: Use two newlines (instead of one) when concatenating notes
  builtin/notes.c: Split notes ref DWIMmery into a separate function
  git notes merge: Initial implementation handling trivial merges only
  builtin/notes.c: Refactor creation of notes commits.
  git notes merge: Handle real, non-conflicting notes merges
  git notes merge: Add automatic conflict resolvers (ours, theirs, unio=
n)
  Documentation: Preliminary docs on 'git notes merge'
  git notes merge: Manual conflict resolution, part 1/2
  git notes merge: Manual conflict resolution, part 2/2
  git notes merge: List conflicting notes in notes merge commit message
  git notes merge: --commit should fail if underlying notes ref has mov=
ed
  git notes merge: Add another auto-resolving strategy: "cat_sort_uniq"
  git notes merge: Add testcases for merging notes trees at different f=
anouts
  Provide 'git notes get-ref' to easily retrieve current notes ref

 Documentation/git-notes.txt           |   85 ++++-
 Makefile                              |    2 +
 builtin.h                             |    2 +-
 builtin/notes.c                       |  268 +++++++++++--
 notes-cache.c                         |    3 +-
 notes-merge.c                         |  718 +++++++++++++++++++++++++=
++++++++
 notes-merge.h                         |   97 +++++
 notes.c                               |  274 +++++++++-----
 notes.h                               |   47 ++-
 t/t3301-notes.sh                      |   23 +
 t/t3303-notes-subtrees.sh             |   19 +-
 t/t3308-notes-merge.sh                |  327 +++++++++++++++
 t/t3309-notes-merge-auto-resolve.sh   |  647 +++++++++++++++++++++++++=
++++
 t/t3310-notes-merge-manual-resolve.sh |  556 +++++++++++++++++++++++++
 t/t3311-notes-merge-fanout.sh         |  436 ++++++++++++++++++++
 t/t3404-rebase-interactive.sh         |    1 +
 t/t9301-fast-import-notes.sh          |    5 +
 17 files changed, 3367 insertions(+), 143 deletions(-)
 create mode 100644 notes-merge.c
 create mode 100644 notes-merge.h
 create mode 100755 t/t3308-notes-merge.sh
 create mode 100755 t/t3309-notes-merge-auto-resolve.sh
 create mode 100755 t/t3310-notes-merge-manual-resolve.sh
 create mode 100755 t/t3311-notes-merge-fanout.sh

--=20
1.7.3.1.104.g92b87a
