From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-log --reflog -p --full-history: Show commit diffs instead
 of faked diffs
Date: Fri, 23 Mar 2007 21:21:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703232120560.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Mar 23 21:21:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUqGP-0002EZ-Q6
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 21:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbXCWUV0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 16:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbXCWUV0
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 16:21:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:49755 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752548AbXCWUVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 16:21:25 -0400
Received: (qmail invoked by alias); 23 Mar 2007 20:21:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 23 Mar 2007 21:21:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/qQTIBc9Dq/f3/xDQkuRrrBR1EPD+OjU9dVVQnPP
	XGDy6V9OT70TmU
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42959>


With `--reflog` and `-p`, git-log will show diffs according to the reflog 
history, while adding `--full-history` will produce the true commit diffs.

In other words, `git-log -g -p HEAD` will show the diff between HEAD@{n+1} 
and HEAD@{n} with each commit HEAD@{n}.

In contrast, `git-log -g -p --full-history HEAD`, will show the diff 
between HEAD@{n}^ and HEAD@{n} with each commit HEAD@{n}.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 revision.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index f23c1d5..edd7dfd 100644
--- a/revision.c
+++ b/revision.c
@@ -1197,6 +1197,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 	do {
 		struct commit_list *entry = revs->commits;
 		struct commit *commit = entry->item;
+		struct commit_list *parents = commit->parents;
 
 		revs->commits = entry->next;
 		free(entry);
@@ -1215,6 +1216,8 @@ static struct commit *get_revision_1(struct rev_info *revs)
 				continue;
 			add_parents_to_list(revs, commit, &revs->commits);
 		}
+		if (revs->reflog_info && !revs->simplify_history)
+			commit->parents = parents;
 		if (commit->object.flags & SHOWN)
 			continue;
 
-- 
1.5.1.rc1.2356.g2054
