From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git log -g: Complain, but do not fail, when no reflogs are
 there
Date: Tue, 24 Jul 2007 00:39:50 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707240039300.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 24 01:40:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID7VZ-0005Yo-3k
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 01:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758837AbXGWXkG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 19:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757958AbXGWXkG
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 19:40:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:36860 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751363AbXGWXkE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 19:40:04 -0400
Received: (qmail invoked by alias); 23 Jul 2007 23:40:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 24 Jul 2007 01:40:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+rxul+jsKr5uSjaApvZQ62BjnE93fkQ2ok6+T61Q
	V6tu1OPmtNaKOZ
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53505>


When asking "git log -g --all", clearly you want to see only those refs
that do have reflogs, but you do not want it to fail, either.

So instead of die()ing, complain about it, but move on to the other refs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reflog-walk.c |    7 ++++---
 reflog-walk.h |    2 +-
 revision.c    |    7 ++++---
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index c983858..7809fad 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -136,7 +136,7 @@ void init_reflog_walk(struct reflog_walk_info** info)
 	*info = xcalloc(sizeof(struct reflog_walk_info), 1);
 }
 
-void add_reflog_for_walk(struct reflog_walk_info *info,
+int add_reflog_for_walk(struct reflog_walk_info *info,
 		struct commit *commit, const char *name)
 {
 	unsigned long timestamp = 0;
@@ -188,7 +188,7 @@ void add_reflog_for_walk(struct reflog_walk_info *info,
 			}
 		}
 		if (!reflogs || reflogs->nr == 0)
-			die("No reflogs found for '%s'", branch);
+			return error("No reflogs found for '%s'", branch);
 		path_list_insert(branch, &info->complete_reflogs)->util
 			= reflogs;
 	}
@@ -200,13 +200,14 @@ void add_reflog_for_walk(struct reflog_walk_info *info,
 		if (commit_reflog->recno < 0) {
 			free(branch);
 			free(commit_reflog);
-			return;
+			return error("No reflog found for '%s'", name);
 		}
 	} else
 		commit_reflog->recno = reflogs->nr - recno - 1;
 	commit_reflog->reflogs = reflogs;
 
 	add_commit_info(commit, commit_reflog, &info->reflogs);
+	return 0;
 }
 
 void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
diff --git a/reflog-walk.h b/reflog-walk.h
index a4f7015..7ca1438 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -2,7 +2,7 @@
 #define REFLOG_WALK_H
 
 extern void init_reflog_walk(struct reflog_walk_info** info);
-extern void add_reflog_for_walk(struct reflog_walk_info *info,
+extern int add_reflog_for_walk(struct reflog_walk_info *info,
 		struct commit *commit, const char *name);
 extern void fake_reflog_parent(struct reflog_walk_info *info,
 		struct commit *commit);
diff --git a/revision.c b/revision.c
index 16f35c7..038693c 100644
--- a/revision.c
+++ b/revision.c
@@ -118,10 +118,11 @@ static void add_pending_object_with_mode(struct rev_info *revs, struct object *o
 {
 	if (revs->no_walk && (obj->flags & UNINTERESTING))
 		die("object ranges do not make sense when not walking revisions");
+	if (revs->reflog_info && obj->type == OBJ_COMMIT &&
+			add_reflog_for_walk(revs->reflog_info,
+				(struct commit *)obj, name))
+		return;
 	add_object_array_with_mode(obj, name, &revs->pending, mode);
-	if (revs->reflog_info && obj->type == OBJ_COMMIT)
-		add_reflog_for_walk(revs->reflog_info,
-				(struct commit *)obj, name);
 }
 
 void add_pending_object(struct rev_info *revs, struct object *obj, const char *name)
-- 
1.5.3.rc2.31.gf7d7-dirty
