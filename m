From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "git log --parent -m" from emitting duplicated parent info
Date: Sun, 08 Jul 2007 18:38:24 -0700
Message-ID: <7vps32xsof.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550707080737j56c161bdrf0c079b61877085b@mail.gmail.com>
	<7vd4z2za2g.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707090220281.4248@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 09 03:38:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7iCv-0003hJ-92
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 03:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210AbXGIBi0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 21:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755344AbXGIBi0
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 21:38:26 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:44551 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754830AbXGIBiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 21:38:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070709013823.RRSE11062.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Jul 2007 21:38:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MDeP1X00P1kojtg0000000; Sun, 08 Jul 2007 21:38:24 -0400
In-Reply-To: <Pine.LNX.4.64.0707090220281.4248@racer.site> (Johannes
	Schindelin's message of "Mon, 9 Jul 2007 02:22:57 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51943>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I only found this:
>
> http://thread.gmane.org/gmane.comp.version-control.git/29222

Thanks.  As it happens, the patch I just sent out is a moral
equivalent of your patch in that thread ;-)

We still may need to think about being careful upon --full-history
though.

Second try, this time not doing the simplification when --full-history
is given.

-- >8 --
[PATCH] remove duplicated parents after history simplification

When we simplify history due to path limits, the parents list
for a rewritten commit can end up having duplicates.  Instead of
filtering them out in the output codepath like earlier commit
88494423 did, remove them much earlier, when the parent
information actually gets rewritten.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 revision.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 5184716..740e6a8 100644
--- a/revision.c
+++ b/revision.c
@@ -1308,6 +1308,25 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
 	}
 }
 
+static void remove_duplicate_parents(struct commit *commit)
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
+}
+
 static int rewrite_parents(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list **pp = &commit->parents;
@@ -1324,6 +1343,8 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
 		}
 		pp = &parent->next;
 	}
+	if (revs->simplify_history)
+		remove_duplicate_parents(commit);
 	return 0;
 }
 
