From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/4] Always perfer annotated tags in git-describe.
Date: Sat, 13 Jan 2007 17:27:52 -0500
Message-ID: <20070113222752.GA18011@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 23:28:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5rM3-00025F-0F
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 23:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030514AbXAMW14 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 17:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030521AbXAMW14
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 17:27:56 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35985 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030514AbXAMW1z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 17:27:55 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5rLk-0000He-S6; Sat, 13 Jan 2007 17:27:44 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A72A820FBAE; Sat, 13 Jan 2007 17:27:52 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36778>

Several people have suggested that its always better to describe
a commit using an annotated tag, and to only use a lightweight tag
if absolutely no annotated tag matches the input commit.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-describe.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index a8c98ce..ad672aa 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -138,6 +138,7 @@ static void describe(const char *arg, int last_one)
 	commit_list_insert(cmit, &list);
 	while (list) {
 		struct commit *c = pop_commit(&list);
+		struct commit_list *parents = c->parents;
 		n = match(c);
 		if (n) {
 			struct possible_tag *p = xmalloc(sizeof(*p));
@@ -148,17 +149,17 @@ static void describe(const char *arg, int last_one)
 			else
 				all_matches = p;
 			cur_match = p;
-		} else {
-			struct commit_list *parents = c->parents;
-			while (parents) {
-				struct commit *p = parents->item;
-				parse_commit(p);
-				if (!(p->object.flags & SEEN)) {
-					p->object.flags |= SEEN;
-					insert_by_date(p, &list);
-				}
-				parents = parents->next;
+			if (n->prio == 2)
+				continue;
+		}
+		while (parents) {
+			struct commit *p = parents->item;
+			parse_commit(p);
+			if (!(p->object.flags & SEEN)) {
+				p->object.flags |= SEEN;
+				insert_by_date(p, &list);
 			}
+			parents = parents->next;
 		}
 	}
 
@@ -181,7 +182,8 @@ static void describe(const char *arg, int last_one)
 		while ((!min_match || cur_match->depth < min_match->depth)
 			&& get_revision(&revs))
 			cur_match->depth++;
-		if (!min_match || cur_match->depth < min_match->depth)
+		if (!min_match || (cur_match->depth < min_match->depth
+			&& cur_match->name->prio >= min_match->name->prio))
 			min_match = cur_match;
 		free_commit_list(revs.commits);
 	}
-- 
1.5.0.rc1.g4494
