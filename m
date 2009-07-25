From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v3 0/5] {checkout,reset,stash} --patch
Date: Sat, 25 Jul 2009 23:29:29 +0200
Message-ID: <cover.1248557241.git.trast@student.ethz.ch>
References: <7vzlat64u1.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 23:30:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUoog-00037K-4M
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 23:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbZGYV3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 17:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbZGYV3q
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 17:29:46 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:7772 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752414AbZGYV3p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 17:29:45 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 25 Jul 2009 23:29:44 +0200
Received: from localhost.localdomain ([77.56.221.170]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 25 Jul 2009 23:29:43 +0200
X-Mailer: git-send-email 1.6.4.rc2.227.gf5e17
In-Reply-To: <7vzlat64u1.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 25 Jul 2009 21:29:43.0811 (UTC) FILETIME=[06AE7D30:01CA0D6F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124078>

Junio C Hamano wrote:
> > ... Unfortunately I don't know how hard the necessary change will be,
> > because these two commands are now implemented in C...
> 
> That's OK.  There are others on the list who groks C, like Thomas ;-)

Well, then let's see if your trust is justified ;-)

>  - "add" goes from work tree to the index;
> 
>  - "reset" goes from commit to index.

Luckily "reset" is exactly symmetrical to "add", so that's not too
hard.

>  - "checkout" goes from commit or index to the work tree; and

Unfortunately there are some subtleties here.  In the 'git checkout
HEAD -- $file' case, we overwrite both worktree and index.  So
morally, if you select a hunk for checking out it should be reverse
applied to both, too.  However, that may not always be possible.

[One possible change to checkout -p would be to reverse the direction
of hunks as shown.  Currently it's more in the "discard" spirit: you
made the change shown in this hunk, saying 'y' will throw this change
away.]

Similarly, "stash" has some problems: we want to encode the changes
HEAD..index into one commit, and index..worktree into another.
However, these patches may not apply on top of each other depending on
what hunks were selected.  I see three options:

* Make more a priori restrictions, such as, --patch is strictly about
  the worktree and simply refuses to stash anything if you have staged
  changes; or, we only deal with the worktree and always stash the
  index whole.  I think at least the first option would make it
  significantly less useful though.

* Hope that it works out, and catch failure later.  This is what it
  currently does.

* Expand the stash format to four commits so that, e.g.,
  stash^1..stash^2 is HEAD..index and stash^3..stash is
  index..worktree.  (Currently stash^1 is HEAD, stash^2 is index and
  stash is worktree.)  This would require more changes, and make these
  stashes backward incompatible w.r.t. application, so I'm not sure it
  is worth the trouble.

Yeah, there still aren't any tests, sorry.  I'm not sure I will get
around to it this weekend, but then it's -rc anyway and we're in no
hurry.


Thomas Rast (5):
  git-apply--interactive: Refactor patch mode code
  builtin-add: refactor the meat of interactive_add()
  Implement 'git reset --patch'
  Implement 'git checkout --patch'
  Implement 'git stash save --patch'

 Documentation/git-checkout.txt |   13 +++-
 Documentation/git-reset.txt    |   15 +++-
 Documentation/git-stash.txt    |   10 ++-
 builtin-add.c                  |   43 ++++++---
 builtin-checkout.c             |   19 ++++
 builtin-reset.c                |   15 +++
 commit.h                       |    2 +
 git-add--interactive.perl      |  189 +++++++++++++++++++++++++++++++++-------
 git-stash.sh                   |  120 +++++++++++++++++++++-----
 9 files changed, 355 insertions(+), 71 deletions(-)
