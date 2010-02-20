From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v3 00/12] several notes refs, post-rewrite, notes rewriting
Date: Sat, 20 Feb 2010 23:16:21 +0100
Message-ID: <cover.1266703765.git.trast@student.ethz.ch>
References: <cover.1266361759.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 20 23:43:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NixdI-0006JW-AJ
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 23:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756812Ab0BTWQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 17:16:58 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:6942 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756689Ab0BTWQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 17:16:57 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 23:16:56 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 23:16:35 +0100
X-Mailer: git-send-email 1.7.0.137.gfe3f1
In-Reply-To: <cover.1266361759.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140566>

> I'm running out of git time today

I should repeat that incantation more often, it mysteriously freed up
more time.

Brief overview of changes since v2, with some inline questions about
things that need to be settled:

* new [1/12] "Support showing notes from more than one notes tree" that
  teaches a "notes.displayRef" option which can glob for notes that
  should be shown, and can be specified more than once.

  - maybe we should default this to "refs/notes/*"?

  - currently git-notes and the configs don't agree on what is a valid
    notes ref.  git-notes refuses even *showing* outside of
    refs/notes/.  I tend towards changing git-notes at least as far as
    reading notes is concerned (show/list), so that remote notes work.

* dropped [5/11] "notes: clean up t3301" as per Junio's comments

* changed [7/12] "notes: implement helpers needed for note copying
  during rewrite" to support "notes.rewriteRef" as announced earlier.
  "notes.rewrite.<cmd>" now default to true, so that you only need to
  enable one, namely set notes.rewriteRef = refs/notes/*.

  - do we want a default?

  - do we want the rewriteRefs to also implicitly be displayRefs?

  - the "notes.rewriteMode = overwrite for notes/volatile/*" hinted at
    earlier is missing.  Does anyone need that?

* new [12/12] "notes: add shorthand --ref to override GIT_NOTES_REF"


I haven't changed [10/12] & [11/12] "filter-branch..." yet, as I'm not
really sure what the best format of such a filter would be.

The existing code is probably a neat way of editing the notes, but it
creates a new commit to the notes ref for every rewritten commit.  If
I change the default --notes-filter to cope with multi-rewriting, this
means a new notes commit per rewritten commit.  Seems rather wasteful
just to salvage your notes across an otherwise unrelated
filter-branch.

So the obvious fix would seem to be a --post-rewrite addition that
just pipes through 'git notes copy --for-rewrite=filter-branch', but
that's again not very customizable short of reinventing the whole
thing.  Any ideas?


Thomas Rast (12):
  Support showing notes from more than one notes tree
  Documentation: document post-rewrite hook
  commit --amend: invoke post-rewrite hook
  rebase: invoke post-rewrite hook
  rebase -i: invoke post-rewrite hook
  notes: implement 'git notes copy --stdin'
  notes: implement helpers needed for note copying during rewrite
  rebase: support automatic notes copying
  commit --amend: copy notes to the new commit
  filter-branch: invoke post-rewrite hook
  filter-branch: learn how to filter notes
  notes: add shorthand --ref to override GIT_NOTES_REF

 Documentation/config.txt            |   40 +++++++-
 Documentation/git-filter-branch.txt |   20 +++-
 Documentation/git-notes.txt         |   20 +++-
 Documentation/githooks.txt          |   40 +++++++
 builtin-commit.c                    |   49 ++++++++
 builtin-notes.c                     |  168 +++++++++++++++++++++++++++-
 builtin.h                           |   16 +++
 git-am.sh                           |   13 ++
 git-filter-branch.sh                |   37 ++++++
 git-rebase--interactive.sh          |   45 +++++++-
 git-rebase.sh                       |    6 +
 notes.c                             |  125 +++++++++++++++++++-
 notes.h                             |   16 +++
 pretty.c                            |    6 +-
 refs.c                              |    4 +-
 refs.h                              |    5 +
 t/t3301-notes.sh                    |  213 ++++++++++++++++++++++++++++++++--
 t/t3306-notes-prune.sh              |    6 +-
 t/t3400-rebase.sh                   |   17 +++
 t/t3404-rebase-interactive.sh       |   11 ++
 t/t5407-post-rewrite-hook.sh        |  188 ++++++++++++++++++++++++++++++
 t/t7003-filter-branch.sh            |   22 ++++
 t/t7501-commit.sh                   |   12 ++
 23 files changed, 1046 insertions(+), 33 deletions(-)
 create mode 100755 t/t5407-post-rewrite-hook.sh
