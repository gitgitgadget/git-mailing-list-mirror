From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 00/12] git notes
Date: Thu, 27 Aug 2009 03:43:45 +0200
Message-ID: <1251337437-16947-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 27 03:44:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgU2D-0004JU-WB
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 03:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbZH0BoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 21:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754696AbZH0BoG
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 21:44:06 -0400
Received: from smtp.getmail.no ([84.208.15.66]:47759 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754693AbZH0BoG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Aug 2009 21:44:06 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP000LNXI5H6Y50@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 27 Aug 2009 03:44:05 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP000MW0I5F4H50@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 27 Aug 2009 03:44:05 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.27.13316
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127127>

Another iteration of the 'git notes' feature. Rebased on top of 'next':
- Patches 1-7 are unchanged from (patches 1-5 + 7-8 of) the last iteration.
- Patch 8 introduces the new notes lookup code that offers both handling of
  fanout subtrees, and other performance improvements.
- Patch 9 adds a selftest that verifies correct parsing of notes trees with
  various fanouts.
- Patch 10 adds simple memory pooling to parts of the data structure from
  patch 8. This improves performance slightly.
- Patches 11-12 adds the '%N' format specifier for pretty-printing commit
  notes (as suggested by Dscho in the previous notes thread).


Some performance numbers from the notes lookup code:
(these numbers are from my Core 2 Quad, 4 GB RAM)

Test scenario I: Running t3302-notes-index-expensive
Timing numbers from the 'time_notes 100' following 'create_repo 10000'

              no-notes    notes
before         16.22s     23.74s
after          16.31s     22.16s
after+mempool  16.24s     22.03s

Comments: This is a worst case scenario for pretty much any notes lookup
algorithm: Looking up all 10000 notes with no fanout (fanout level 0).
The new implementation does marginally better than the old.


Test scenario II: Repo with 100,000 commits, 1 note per commit.
Timing 100 repetitions of 'git log -n 10 refs/heads/master >/dev/null'

            without notes  fanout level 0  fanout level 1  fanout level 2
  before         0.20s         32.44s           N/A             N/A
  after          0.19s         16.66s           0.85s           0.61s
  after+mempool  0.19s         16.20s           0.83s           0.57s

Comments: This hopefully gives a better simulation of a common use case
(displaying only a handful of commits, and their notes). In the (relative)
worst case (fanout level 0), the new code almost twice as fast as the old one.
As we add fanout, the runtime plummets (since we only need to unpack a handful
of subtrees).

In practice, this means that with even a modest 2/38 or 2/2/36 fanout in the
notes tree (fanout level 1 and 2, respectively), the 'git log' user experience
goes from unbearable to barely noticeable in a repo with hundreds of thousands
of notes.


Have fun! :)

...Johan


Johan Herland (7):
  Teach "-m <msg>" and "-F <file>" to "git notes edit"
  fast-import: Add support for importing commit notes
  t3302-notes-index-expensive: Speed up create_repo()
  Teach the notes lookup code to parse notes trees with various fanout schemes
  Selftests verifying semantics when loading notes trees with various fanouts
  notes.c: Implement simple memory pooling of leaf nodes
  Add flags to get_commit_notes() to control the format of the note string

Johannes Schindelin (5):
  Introduce commit notes
  Add a script to edit/inspect notes
  Speed up git notes lookup
  Add an expensive test for git-notes
  Add '%N'-format for pretty-printing commit notes

 .gitignore                        |    1 +
 Documentation/config.txt          |   13 ++
 Documentation/git-fast-import.txt |   45 +++++-
 Documentation/git-notes.txt       |   60 +++++++
 Documentation/pretty-formats.txt  |    1 +
 Makefile                          |    3 +
 cache.h                           |    4 +
 command-list.txt                  |    1 +
 commit.c                          |    1 +
 config.c                          |    5 +
 environment.c                     |    1 +
 fast-import.c                     |   88 +++++++++-
 git-notes.sh                      |  121 +++++++++++++
 notes.c                           |  338 +++++++++++++++++++++++++++++++++++++
 notes.h                           |   10 +
 pretty.c                          |   10 +
 t/t3301-notes.sh                  |  150 ++++++++++++++++
 t/t3302-notes-index-expensive.sh  |  118 +++++++++++++
 t/t3303-notes-subtrees.sh         |  206 ++++++++++++++++++++++
 t/t9300-fast-import.sh            |  166 ++++++++++++++++++
 20 files changed, 1332 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/git-notes.txt
 create mode 100755 git-notes.sh
 create mode 100644 notes.c
 create mode 100644 notes.h
 create mode 100755 t/t3301-notes.sh
 create mode 100755 t/t3302-notes-index-expensive.sh
 create mode 100755 t/t3303-notes-subtrees.sh
