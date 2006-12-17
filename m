X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Make left-right automatic.
Date: Sat, 16 Dec 2006 16:12:55 -0800
Message-ID: <7vlkl78jnc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 17 Dec 2006 00:13:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34663>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvjeG-0005Fm-Pj for gcvg-git@gmane.org; Sun, 17 Dec
 2006 01:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422910AbWLQAM5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 19:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422914AbWLQAM5
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 19:12:57 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:33098 "EHLO
 fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1422910AbWLQAM5 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 19:12:57 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061217001256.JHSD7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Sat, 16
 Dec 2006 19:12:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zcD81V0081kojtg0000000; Sat, 16 Dec 2006
 19:13:08 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

When using symmetric differences, I think the user almost always
would want to know which side of the symmetry each commit came
from.  So this removes --left-right option from the command
line, and turns it on automatically when a symmetric difference
is used ("git log --merge" counts as a symmetric difference
between HEAD and MERGE_HEAD).

Just in case, a new option --no-left-right is provided to defeat
this, but I do not know if it would be useful.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I think this would make life easier for merge-heavy people.
   I'd push this out on 'next' soonish.

 revision.c |   13 ++++++++++---
 revision.h |    1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index d84f46e..56819f8 100644
--- a/revision.c
+++ b/revision.c
@@ -853,8 +853,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->boundary = 1;
 				continue;
 			}
-			if (!strcmp(arg, "--left-right")) {
-				revs->left_right = 1;
+			if (!strcmp(arg, "--no-left-right")) {
+				revs->no_left_right = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--objects")) {
@@ -1055,13 +1055,18 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 void prepare_revision_walk(struct rev_info *revs)
 {
 	int nr = revs->pending.nr;
+	int has_symmetric = 0;
 	struct object_array_entry *list = revs->pending.objects;
 
 	revs->pending.nr = 0;
 	revs->pending.alloc = 0;
 	revs->pending.objects = NULL;
 	while (--nr >= 0) {
-		struct commit *commit = handle_commit(revs, list->item, list->name);
+		struct commit *commit;
+
+		if (list->item->flags & SYMMETRIC_LEFT)
+			has_symmetric = 1;
+		commit = handle_commit(revs, list->item, list->name);
 		if (commit) {
 			if (!(commit->object.flags & SEEN)) {
 				commit->object.flags |= SEEN;
@@ -1073,6 +1078,8 @@ void prepare_revision_walk(struct rev_info *revs)
 
 	if (revs->no_walk)
 		return;
+	if (!revs->no_left_right && has_symmetric)
+		revs->left_right = 1;
 	if (revs->limited)
 		limit_list(revs);
 	if (revs->topo_order)
diff --git a/revision.h b/revision.h
index 4585463..b2ab814 100644
--- a/revision.h
+++ b/revision.h
@@ -41,6 +41,7 @@ struct rev_info {
 			limited:1,
 			unpacked:1, /* see also ignore_packed below */
 			boundary:1,
+			no_left_right:1,
 			left_right:1,
 			parents:1;
 
-- 
1.4.4.2.g83c5

