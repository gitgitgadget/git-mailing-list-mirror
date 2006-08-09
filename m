From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] merge-recur: try to merge older merge bases first
Date: Wed, 9 Aug 2006 22:30:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608092221590.13885@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Aug 09 22:31:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAuht-0002Gi-J6
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 22:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWHIUbD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 16:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWHIUbD
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 16:31:03 -0400
Received: from mail.gmx.de ([213.165.64.20]:56034 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750940AbWHIUbB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Aug 2006 16:31:01 -0400
Received: (qmail invoked by alias); 09 Aug 2006 20:30:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp007) with SMTP; 09 Aug 2006 22:30:59 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25143>


It seems to be the only sane way to do it: when a two-head merge is
done, and the merge-base and one of the two branches agree, the
merge assumes that the other branch has something new.

If we start creating virtual commits from newer merge-bases, and go
back to older merge-bases, and then merge with newer commits again,
chances are that a patch is lost, _because_ the merge-base and the
head agree on it. Unlikely, yes, but it happened to me.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c |   16 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index f5b547b..2d3ab4f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1191,6 +1191,17 @@ static int merge_trees(struct tree *head
 	return clean;
 }
 
+static struct commit_list *reverse_commit_list(struct commit_list *list)
+{
+	struct commit_list *next = NULL, *current, *backup;
+	for (current = list; current; current = backup) {
+		backup = current->next;
+		current->next = next;
+		next = current;
+	}
+	return next;
+}
+
 /*
  * Merge the commits h1 and h2, return the resulting virtual
  * commit object and a flag indicating the cleaness of the merge.
@@ -1216,7 +1227,8 @@ int merge(struct commit *h1,
 	if (ancestor)
 		commit_list_insert(ancestor, &ca);
 	else
-		ca = get_merge_bases(h1, h2, 1);
+		ca = reverse_commit_list(get_merge_bases(h1, h2, 1));
+		//ca = get_merge_bases(h1, h2, 1);
 
 	output("found %u common ancestor(s):", commit_list_count(ca));
 	for (iter = ca; iter; iter = iter->next)
-- 
1.4.2.rc3.g29d0-dirty
