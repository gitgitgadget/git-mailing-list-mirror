From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 00/11] several notes refs, post-rewrite, notes rewriting
Date: Mon, 22 Feb 2010 01:10:13 +0100
Message-ID: <cover.1266797028.git.trast@student.ethz.ch>
References: <cover.1266703765.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 01:43:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjLsr-0000CG-7F
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 01:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756Ab0BVAKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 19:10:31 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:6288 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732Ab0BVAKa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 19:10:30 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 01:10:27 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 01:10:29 +0100
X-Mailer: git-send-email 1.7.0.147.g5aeb9
In-Reply-To: <cover.1266703765.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140625>

Thanks Junio for your big batch of feedback.  Yet another round...

Since this topic already has three different goals, I decided to try
and get it in at least 'pu' shapes to have an agreed-upon basis for
what's next.  To that end, I ejected the filter-branch commits for
now, and hopefully addressed all comments on the existing patches.  I
still need to make up my mind (and would still appreciate input) on
the filter-branch part, but if I'm not mistaken the rest of the series
has been on Junio's wishlist.  I also already have a patch to make
format-patch fill the comment region from a notes ref that has textual
dependencies on this, which IIRC has also been mentioned as a wishlist
item once or twice.

I used the entire series plus the format-patch feature mentioned above
fairly heavily during its own development, which unearthed a few more
bugs.  If there is a comment after the --- line in every patch, it
worked ;-)

On Sunday 21 February 2010 04:06:52 Junio C Hamano wrote:
> If I wrote
> 
> 	[notes]
>             displayRef = refs/notes/commit
>             displayRef = refs/notes/amlog
> 
> I would expect that the normal notes come first and then notes from the
> amlog tree, not in the alphabetical "amlog happens to sort before commit"
> order.  [v3 always sorted the displayRef entries for display]

I considered this a feature, but changed it anyway since I don't care
much.  My original rationale was: core.notesRef should be in that list
implicitly, and I think the natural position if it is unsorted would
be: first.  However, that means that changing core.notesRef or
GIT_NOTES_REF can shuffle around your notes, which I thought would be
confusing.


Thomas Rast (11):
  test-lib: unset GIT_NOTES_REF to stop it from influencing tests
  Support showing notes from more than one notes tree
  Documentation: document post-rewrite hook
  commit --amend: invoke post-rewrite hook
  rebase: invoke post-rewrite hook
  rebase -i: invoke post-rewrite hook
  notes: implement 'git notes copy --stdin'
  notes: implement helpers needed for note copying during rewrite
  rebase: support automatic notes copying
  commit --amend: copy notes to the new commit
  notes: add shorthand --ref to override GIT_NOTES_REF

 Documentation/config.txt      |   49 ++++++-
 Documentation/git-notes.txt   |   20 +++-
 Documentation/githooks.txt    |   40 +++++
 builtin-commit.c              |   45 ++++++
 builtin-notes.c               |  195 +++++++++++++++++++++++-
 builtin.h                     |   18 ++
 cache.h                       |    3 +
 git-am.sh                     |   13 ++
 git-rebase--interactive.sh    |   52 ++++++-
 git-rebase.sh                 |    6 +
 notes.c                       |  173 ++++++++++++++++++++-
 notes.h                       |   17 ++
 pretty.c                      |    6 +-
 refs.c                        |    4 +-
 refs.h                        |    5 +
 t/t3301-notes.sh              |  344 ++++++++++++++++++++++++++++++++++++++++-
 t/t3400-rebase.sh             |   17 ++
 t/t3404-rebase-interactive.sh |   24 +++
 t/t5407-post-rewrite-hook.sh  |  172 ++++++++++++++++++++
 t/t7501-commit.sh             |   12 ++
 t/test-lib.sh                 |    4 +
 21 files changed, 1194 insertions(+), 25 deletions(-)
 create mode 100755 t/t5407-post-rewrite-hook.sh
