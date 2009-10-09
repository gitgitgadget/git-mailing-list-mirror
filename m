From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv7 00/22] git notes
Date: Fri, 09 Oct 2009 12:21:56 +0200
Message-ID: <1255083738-23263-2-git-send-email-johan@herland.net>
References: <1255083738-23263-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 12:31:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwClN-0004PL-5Y
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 12:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760660AbZJIKXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 06:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760656AbZJIKXE
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 06:23:04 -0400
Received: from smtp.getmail.no ([84.208.15.66]:54694 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760655AbZJIKXC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 06:23:02 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800BN2STD9320@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:22:25 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800IEJST91V00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:22:25 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.9.101220
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1255083738-23263-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129776>

Hi,

Here is the 7th iteration of the git-notes series. Changes in this
iteration are as follows:

- Rebased onto current 'next'

- Patch 1: Include minor leak fix

- Patch 10: Rename free_commit_notes() to free_notes() (Notes are
  no longer bound to only commits, see patch 15 for details)

- Patch 12: Remove tests that are invalidated by concatenation code
  in patch 13.

There's also a slew of new patches:

- Patches 13-14: Concatenation of multiple notes annotating the same
  commit/object. This was originally suggested by mugwump many months
  ago, and the suggestion was re-iterated by Dscho. This change has a
  minor perfomance impact (see [1]), but I still think it's worth it.

- Patch 15: Allow notes to be attached to any object (not just commits).
  Rename get_commit_notes() to format_note() to reflect this change.

- Patch 16-19: Expand notes API in preparation for querying and manipulating notes from other parts of Git.


TODO:
- Builtin-ify git-notes shell script to take advantage of notes API
- Garbage collect notes whose referenced object is unreachable (gc_notes())
- Handle note objects that are not blobs, but trees

Have fun! :)

...Johan


[1] Performance impact of the concatenation rewrite.

In order to concatenate notes correctly, the tree traversal code must be
changed to more proactively unpack subtree entries (so that we can safely
determine whether there are multiple notes for a given key).

As before, the test case is as follows:
Linux kernel repo with 157101 commits, 1 note per commit, organized into
various fanout schemes. Hardware is Intel Core 2 Quad with 4GB RAM.


Algorithm / Notes tree   git log -n10 (x100)   git log --all

next / no-notes                 4.78s             63.90s

before / no-notes               4.77s             63.61s
before / no-fanout             56.59s             65.19s

16tree / no-notes               4.73s             63.80s
16tree / no-fanout             30.21s             65.11s
16tree / 2_38                   5.53s             65.24s
16tree / 2_2_36                 5.15s             65.12s

concat / no-notes               4.80s             64.21s
concat / no-fanout             30.66s             65.35s
concat / 2_38                   5.64s             65.87s
concat / 2_2_36                 5.23s             66.44s

Conclusion: There is a measurable impact (about .1s or so in the 100 x
'git log -n10' case), but I think this is low enough to be acceptable.


Johan Herland (17):
  Teach "-m <msg>" and "-F <file>" to "git notes edit"
  fast-import: Add support for importing commit notes
  t3302-notes-index-expensive: Speed up create_repo()
  Add flags to get_commit_notes() to control the format of the note string
  Teach notes code to free its internal data structures on request.
  Teach the notes lookup code to parse notes trees with various fanout schemes
  Add selftests verifying that we can parse notes trees with various fanouts
  Refactor notes code to concatenate multiple notes annotating the same object
  Add selftests verifying that multiple notes for the same commits are concatenated correctly
  Notes API: get_commit_notes() -> format_note() + remove the commit restriction
  Notes API: init_notes(): Initialize the notes tree from the given notes ref
  Notes API: add_note(): Add note objects to the internal notes tree structure
  Notes API: get_note(): Return the note annotating the given object
  Notes API: for_each_note(): Traverse the entire notes tree with a callback
  Notes API: Allow multiple concurrent notes trees with new struct notes_tree
  Refactor notes concatenation into a flexible interface for combining notes
  fast-import: Proper notes tree manipulation using the notes API

Johannes Schindelin (5):
  Introduce commit notes
  Add a script to edit/inspect notes
  Speed up git notes lookup
  Add an expensive test for git-notes
  Add '%N'-format for pretty-printing commit notes

 .gitignore                        |    1 +
 Documentation/config.txt          |   13 +
 Documentation/git-fast-import.txt |   45 +++-
 Documentation/git-notes.txt       |   60 ++++
 Documentation/pretty-formats.txt  |    1 +
 Makefile                          |    3 +
 cache.h                           |    4 +
 command-list.txt                  |    1 +
 commit.c                          |    1 +
 config.c                          |    5 +
 environment.c                     |    1 +
 fast-import.c                     |  176 +++++++++++-
 git-notes.sh                      |  121 ++++++++
 notes.c                           |  579 +++++++++++++++++++++++++++++++++++++
 notes.h                           |  121 ++++++++
 pretty.c                          |   10 +
 t/t3301-notes.sh                  |  150 ++++++++++
 t/t3302-notes-index-expensive.sh  |  118 ++++++++
 t/t3303-notes-subtrees.sh         |  188 ++++++++++++
 t/t9300-fast-import.sh            |  296 +++++++++++++++++++
 20 files changed, 1883 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/git-notes.txt
 create mode 100755 git-notes.sh
 create mode 100644 notes.c
 create mode 100644 notes.h
 create mode 100755 t/t3301-notes.sh
 create mode 100755 t/t3302-notes-index-expensive.sh
 create mode 100755 t/t3303-notes-subtrees.sh
