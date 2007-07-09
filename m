From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "git log --parent -m" from emitting duplicated parent info
Date: Sun, 08 Jul 2007 18:20:17 -0700
Message-ID: <7v4pkez832.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550707080737j56c161bdrf0c079b61877085b@mail.gmail.com>
	<7vd4z2za2g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 03:20:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7hvK-0001gP-GA
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 03:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757062AbXGIBUU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 21:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757354AbXGIBUU
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 21:20:20 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:61172 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756995AbXGIBUS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 21:20:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070709012018.BTSS1204.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Jul 2007 21:20:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MDLG1X00K1kojtg0000000; Sun, 08 Jul 2007 21:20:17 -0400
In-Reply-To: <7vd4z2za2g.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 08 Jul 2007 17:37:27 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51939>

Junio C Hamano <gitster@pobox.com> writes:

> This is whitespace damaged in a funny way (some lines do not
> have leading whitespace while some do).
>
> log_tree_diff() hence log_tree_commit() is caled by codepaths
> other than "git log -p", and I am not convinced that this patch
> would not break them.  Worrysome.
>
> I wonder why we did not actually remove the duplicate parents
> from "commit->parents" list after history simplification when we
> originally did 88494423, instead of filtering only on the output
> path.  Anybody remember the reason?

In any case, I think this patch would let us revert 88494239 and
the "matching" patch for git-log I sent out earlier, and also
makes your patch unnecessary.

Seems to pass the test suite, and your original example of
checking addafaf with path limiter of "diff.h".

I am a bit worried about the possible fallout, though.  There
might be some callers that expect to find the same number of
parents in commit->parents list and what is recorded in the
commit object itself, although I do not think of any, and I tend
to think it is broken if there is one.

-- >8 --
[PATCH] remove duplicated parents after history simplification

When we simplify history due to path limits, the parents list
for a rewritten commit can end up having duplicates.  Instead of
filtering them out in the output codepath like earlier commit
88494423 did, remove them much earlier, when the parent
rewriting actually happens.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 revision.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index 5184716..b8a7571 100644
--- a/revision.c
+++ b/revision.c
@@ -1308,6 +1308,26 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
 	}
 }
 
+static int remove_duplicate_parents(struct commit *commit)
+{
+	struct commit_list *p;
+	struct commit_list **pp = &commit->parents;
+
+	/* Examine existing parents while marking ones we have seen... */
+	for (p = commit->parents; p; p = p->next) {
+		struct commit *parent = p->item;
+		if (parent->object.flags & TMP_MARK)
+			continue;
+		parent->object.flags |= TMP_MARK;
+		*pp = p;
+		pp = &p->next;
+	}
+	/* ... and clear the temporary mark */
+	for (p = commit->parents; p; p = p->next)
+		p->item->object.flags &= ~TMP_MARK;
+	return 0;
+}
+
 static int rewrite_parents(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list **pp = &commit->parents;
@@ -1324,7 +1344,7 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
 		}
 		pp = &parent->next;
 	}
-	return 0;
+	return remove_duplicate_parents(commit);
 }
 
 static int commit_match(struct commit *commit, struct rev_info *opt)
