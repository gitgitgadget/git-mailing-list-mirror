From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: [PATCH 1/3] upload-pack: Remove a piece of dead code
Date: Thu, 11 Jul 2013 13:25:52 +0200
Message-ID: <1373541954-16493-1-git-send-email-matthijs@stdin.nl>
References: <20130711105733.GG10217@login.drsnuggles.stderr.nl>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org, Matthijs Kooijman <matthijs@stdin.nl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 13:26:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxF15-0006gD-3p
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 13:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385Ab3GKL0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 07:26:20 -0400
Received: from 84-245-11-97.dsl.cambrium.nl ([84.245.11.97]:53746 "EHLO
	grubby.stderr.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932111Ab3GKL0T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 07:26:19 -0400
Received: from matthijs by grubby.stderr.nl with local (Exim 4.80)
	(envelope-from <matthijs@stdin.nl>)
	id 1UxF0j-0004Ib-5w; Thu, 11 Jul 2013 13:26:09 +0200
X-Mailer: git-send-email 1.8.3.rc1
In-Reply-To: <20130711105733.GG10217@login.drsnuggles.stderr.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230088>

Commit 682c7d2 (upload-pack: fix off-by-one depth calculation in shallow
clone) introduced a new check in get_shallow_commits to decide when to
stop traversing the history and mark the current commit as a shallow
root.

With this new check in place, the old check can no longer be true, since
the first check always fires first. This commit removes that check,
making the code a bit more simple again.

Signed-off-by: Matthijs Kooijman <matthijs@stdin.nl>
---
 shallow.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/shallow.c b/shallow.c
index cbe2526..8a9c96d 100644
--- a/shallow.c
+++ b/shallow.c
@@ -110,17 +110,12 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 					continue;
 				*pointer = cur_depth;
 			}
-			if (cur_depth < depth) {
-				if (p->next)
-					add_object_array(&p->item->object,
-							NULL, &stack);
-				else {
-					commit = p->item;
-					cur_depth = *(int *)commit->util;
-				}
-			} else {
-				commit_list_insert(p->item, &result);
-				p->item->object.flags |= shallow_flag;
+			if (p->next)
+				add_object_array(&p->item->object,
+						NULL, &stack);
+			else {
+				commit = p->item;
+				cur_depth = *(int *)commit->util;
 			}
 		}
 	}
-- 
1.8.3.rc1
