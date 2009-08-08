From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH] Simplify away duplicate commits with --cherry-pick --parents
Date: Sat, 8 Aug 2009 18:34:26 +0200
Message-ID: <50f4386635a3ab08ee7fd432d672f775cc760f39.1249749019.git.trast@student.ethz.ch>
References: <200908060919.27780.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>,
	Adam Simpkins <adam@adamsimpkins.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 08 18:34:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZosg-0004ry-Hl
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 18:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbZHHQek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 12:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbZHHQek
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 12:34:40 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:21870 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586AbZHHQej (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 12:34:39 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sat, 8 Aug
 2009 18:34:38 +0200
Received: from localhost.localdomain (77.56.221.170) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sat, 8 Aug
 2009 18:34:38 +0200
X-Mailer: git-send-email 1.6.4.201.g5a53b
In-Reply-To: <200908060919.27780.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125288>

The current --cherry-pick declares commits SHOWN that are found to be
duplicates.  Unfortunately this disconnects the history at every such
duplicate, making it quite hard to follow in graphical viewers.

Add an extra stage of parent rewriting after scanning for duplicates,
which simplifies the history to omit all duplicate commits.  This
cannot easily be shifted to the existing parent rewriting because
cherry_pick_list() always comes last in the entire filtering process
(presumably because it is the most expensive).

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I wrote:
> The problem with [gitk --left-right --cherry-pick A...B] is that it
> disconnects history
[...]
> Sadly, it's really the underlying git-rev-list that is "broken" in the
> sense that it does not fix the parent lists.  And git log --graph
> handles it much worse than gitk.

Maybe this is an approach.  It unfortunately breaks down if merges can
disappear because of patch-ids too.  Can they?

(In the case where a merge is flagged SHOWN, it might have its parent
list reduced to one at some point, and then later filterings would
simplify it away whereas earlier ones didn't.)

Also, I'm not entirely sure we want to do this without any guards
except rewrite_parents.

On the plus side, the issues with git log --graph vanish because
history is again connected :-)


 revision.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 9f5dac5..9e24514 100644
--- a/revision.c
+++ b/revision.c
@@ -517,6 +517,8 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 	return 0;
 }
 
+static int remove_duplicate_parents(struct commit *commit);
+
 static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 {
 	struct commit_list *p;
@@ -599,6 +601,25 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		commit->util = NULL;
 	}
 
+	if (revs->rewrite_parents) {
+		/* Prune away commits we've just found to be duplicates */
+		for (p = list; p; p = p->next) {
+			struct commit *commit = p->item;
+			struct commit_list *pp;
+
+			for (pp = commit->parents; pp; pp = pp->next) {
+				struct commit *parent = pp->item;
+				while (parent->object.flags & SHOWN
+				       && parent->parents
+				       && !parent->parents->next)
+					parent = parent->parents->item;
+				pp->item = parent;
+			}
+
+			remove_duplicate_parents(commit);
+		}
+	}
+
 	free_patch_ids(&ids);
 }
 
-- 
1.6.4.199.g24c3
