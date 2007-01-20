From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] --walk-reflogs: do not crash with cyclic reflog ancestry
Date: Sat, 20 Jan 2007 22:28:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701202227500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Jan 20 22:28:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8Nl7-0004nU-BT
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 22:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965392AbXATV2S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 16:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965393AbXATV2S
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 16:28:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:40196 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965392AbXATV2R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 16:28:17 -0500
Received: (qmail invoked by alias); 20 Jan 2007 21:28:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 20 Jan 2007 22:28:16 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37292>


Since you can reset --hard to any revision you already had, when
traversing the reflog ancestry, we may not free() the commit buffer.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-log.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index f3cff13..13a3f9b 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -50,8 +50,11 @@ static int cmd_log_walk(struct rev_info *rev)
 	prepare_revision_walk(rev);
 	while ((commit = get_revision(rev)) != NULL) {
 		log_tree_commit(rev, commit);
-		free(commit->buffer);
-		commit->buffer = NULL;
+		if (!rev->reflog_info) {
+			/* we allow cycles in reflog ancestry */
+			free(commit->buffer);
+			commit->buffer = NULL;
+		}
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
 	}
-- 
1.5.0.rc1.g956c1-dirty
