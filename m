From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] clear_commit_marks(): avoid deep recursion
Date: Wed, 10 Oct 2007 23:14:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710102313530.4174@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: spearce@spearce.org
To: git@vger.kernel.org, hjemli@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 11 00:15:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifjpe-0000iv-FP
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 00:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbXJJWO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 18:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753486AbXJJWO4
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 18:14:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:52022 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753356AbXJJWOz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 18:14:55 -0400
Received: (qmail invoked by alias); 10 Oct 2007 22:14:53 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 11 Oct 2007 00:14:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Acw4qIDZAq9lN3J69SJ/xniDFS8rz7JULpK9ixW
	o2byry/0JsQMAI
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60560>


Before this patch, clear_commit_marks() recursed for each parent.  This
could be potentially very expensive in terms of stack space.  Probably
the only reason that this did not lead to problems is the fact that we
typically call clear_commit_marks() after marking a relatively small set
of commits.

Use (sort of) a tail recursion instead: first recurse on the parents
other than the first one, and then continue the loop with the first
parent.

Noticed by Shawn Pearce.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/commit.c b/commit.c
index 20fb220..ac24266 100644
--- a/commit.c
+++ b/commit.c
@@ -441,17 +441,22 @@ struct commit *pop_most_recent_commit(struct commit_list **list,
 
 void clear_commit_marks(struct commit *commit, unsigned int mark)
 {
-	struct commit_list *parents;
+	while (commit) {
+		struct commit_list *parents;
 
-	commit->object.flags &= ~mark;
-	parents = commit->parents;
-	while (parents) {
-		struct commit *parent = parents->item;
+		if (!(mark & commit->object.flags))
+			return;
 
-		/* Have we already cleared this? */
-		if (mark & parent->object.flags)
-			clear_commit_marks(parent, mark);
-		parents = parents->next;
+		commit->object.flags &= ~mark;
+
+		parents = commit->parents;
+		if (!parents)
+			return;
+
+		while ((parents = parents->next))
+			clear_commit_marks(parents->item, mark);
+
+		commit = commit->parents->item;
 	}
 }
 
-- 
1.5.3.4.1169.g5fb8d
