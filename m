From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv10 00/11] git notes
Date: Mon, 07 Dec 2009 12:27:23 +0100
Message-ID: <1260185254-1523-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 12:29:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHbmC-0007m5-7F
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 12:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933807AbZLGL1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 06:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933770AbZLGL1j
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 06:27:39 -0500
Received: from smtp.getmail.no ([84.208.15.66]:46132 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933744AbZLGL1i (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2009 06:27:38 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KUA00A0Z565MPE0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 07 Dec 2009 12:27:41 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KUA002OO5616830@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 07 Dec 2009 12:27:41 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.12.7.111518
X-Mailer: git-send-email 1.6.5.3.433.g11067
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134738>

Hi,

Here is the 10th iteration of the git-notes series. Changes in this
iteration are as follows:

Changes to existing patches:

- Rebased onto 488bdf2... (Fix crasher on encountering SHA1-like non-note
  in notes tree) (There are no conflicts resolved by this, but a test in
  this series crashes without the crash fix in 488bdf2...).

- Yet another rewrite of the fast-import patch. After trying to implement
  Shawn's suggestions, I found that hacking the mode bits of note entries
  could not work, since they are stripped by a mktree()/load_tree()
  round-trip. The new versions treats _all_ entries with note-compatible
  paths (40 hex chars, not including directory separators) as note entries
  (to be subjected to fanout adjustments) in branches where there are note
  activity (one or more 'N' commands).
  Branches without note activity are not touched, of course.

- Otherwise, Shawn's suggestions to the previous iteration have been
  incorporated.

- Extended t9301 tests to verify that non-notes residing in a notes tree
  are not clobbered by the fast-import patch.

- Fix t9301 test #12 to not "cheat" (by 'deleteall' followed by a few
  additions). Instead, remove notes one-by-one to verify correct
  fanout consolidation.

- Minor cleanups here and there


If Shawn is OK with the fast-import patch, I believe that at least
patches #1 - #3 (and possibly #4 - #5) are ready for 'next'.

Patches #6 - #11 drastically extend the notes API. Since there are
currently no users of that API, and it has not been discussed much
on the list (although these patches have already been present in a
few iterations), I would still consider them RFC quality.


TODO:
- Builtin-ify git-notes shell script to take advantage of notes API
- Garbage collect notes whose referenced object is unreachable (gc_notes())
- Handle note objects that are not blobs, but trees


Have fun! :)

...Johan


Johan Herland (11):
  fast-import: Proper notes tree manipulation
  Rename t9301 to t9350, to make room for more fast-import tests
  Add more testcases to test fast-import of notes
  Minor style fixes to notes.c
  Notes API: get_commit_notes() -> format_note() + remove the commit restriction
  Notes API: init_notes(): Initialize the notes tree from the given notes ref
  Notes API: add_note(): Add note objects to the internal notes tree structure
  Notes API: get_note(): Return the note annotating the given object
  Notes API: for_each_note(): Traverse the entire notes tree with a callback
  Notes API: Allow multiple concurrent notes trees with new struct notes_tree
  Refactor notes concatenation into a flexible interface for combining notes

 fast-import.c                                    |  134 +++++-
 notes.c                                          |  345 +++++++++----
 notes.h                                          |  114 ++++-
 pretty.c                                         |    9 +-
 t/t9300-fast-import.sh                           |  156 +++++-
 t/t9301-fast-import-notes.sh                     |  623 ++++++++++++++++++++++
 t/{t9301-fast-export.sh => t9350-fast-export.sh} |    0
 7 files changed, 1259 insertions(+), 122 deletions(-)
 create mode 100755 t/t9301-fast-import-notes.sh
 rename t/{t9301-fast-export.sh => t9350-fast-export.sh} (100%)
