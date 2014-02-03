From: David Kastrup <dak@gnu.org>
Subject: [PATCH 5/5] Avoid queuing commits multiple times for the same origin
Date: Mon,  3 Feb 2014 20:14:09 +0100
Message-ID: <1391454849-26558-6-git-send-email-dak@gnu.org>
References: <1391454849-26558-1-git-send-email-dak@gnu.org>
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 20:14:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAOyj-0008Tb-OF
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 20:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbaBCTOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 14:14:30 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:57356 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbaBCTO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 14:14:29 -0500
Received: from localhost ([127.0.0.1]:56394 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WAOyJ-0007G1-Bl; Mon, 03 Feb 2014 14:14:20 -0500
Received: by lola (Postfix, from userid 1000)
	id ED5E2E86FF; Mon,  3 Feb 2014 20:14:18 +0100 (CET)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1391454849-26558-1-git-send-email-dak@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241453>

---
 builtin/blame.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 0188115..80345db 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -928,9 +928,12 @@ static int pass_blame_to_parent(struct scoreboard *sb,
 	/* The rest are the same as the parent */
 	blame_chunk(&d.dstq, &d.srcq, INT_MAX, d.offset, INT_MAX, target, parent);
 	*d.dstq = NULL;
-	parent->suspects = blame_merge(parent->suspects, newdest);
 	if (parent->suspects)
+		parent->suspects = blame_merge(parent->suspects, newdest);
+	else if (newdest) {
+		parent->suspects = newdest;
 		prio_queue_put(&sb->commits, parent->commit);
+	}
 
 	return 0;
 }
@@ -1303,8 +1306,12 @@ static void pass_whole_blame(struct scoreboard *sb,
 		origin_decref(e->suspect);
 		e->suspect = porigin;
 	}
-	porigin->suspects = blame_merge(porigin->suspects, suspects);
-	prio_queue_put(&sb->commits, porigin->commit);
+	if (porigin->suspects)
+		porigin->suspects = blame_merge(porigin->suspects, suspects);
+	else if (suspects) {
+		porigin->suspects = suspects;
+		prio_queue_put(&sb->commits, porigin->commit);
+	}
 }
 
 /*
-- 
1.8.3.2
