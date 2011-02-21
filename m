From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/2] revlist.c: introduce --left/right-only for unsymmetric picking
Date: Mon, 21 Feb 2011 17:09:11 +0100
Message-ID: <a3224c4269b26c366bb5b5df691f22f17b767f83.1298304396.git.git@drmicha.warpmail.net>
References: <4D625972.4090500@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 21 17:12:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrYNF-0003rd-R8
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 17:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902Ab1BUQM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 11:12:28 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45731 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751395Ab1BUQM1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 11:12:27 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 157CD204E1;
	Mon, 21 Feb 2011 11:12:27 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 21 Feb 2011 11:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=B9AAd39fqbSEz89U/XL9wrevR6k=; b=FHElu/VYa+fCIKYUVbQeXwq7pkCMG+z8UPaZFE5D2HsOFt42idD11Ioq3HBXR7IcckTVM/ib99cuVPei3qOdNHQfe9b4MaAHGndfv5NkTSnpP0+G3kF2bJfjXKcGiB2L56h7pipnpS6KnZCk5pt/Bq6ifWltrou5S2kNdhVNnYI=
X-Sasl-enc: a/ep2v2FXqVGJUXML8E6JV+26XMsJs9vFQejeSzAnED5 1298304746
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 66C65400957;
	Mon, 21 Feb 2011 11:12:26 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <4D625972.4090500@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167490>

The existing "--cherry-pick" does not work with unsymmetric ranges
(A..B) for obvious reasons.

Introduce "--left-only" and "--right-only" which limit the output to
commits on the respective sides of a symmetric range (i.e. only "<"
resp. ">" commits as per "--left-right").

This is especially useful for things like

git log --cherry-pick --right-only @{u}...

which is much more flexible (and descriptive) than

git cherry @{u}

and potentially more useful than

git log --cherry-pick @{u}...

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Notes:
    v2 does it the --left/right-only way, which I hope is the right way :)
    
    Those new limiters work together with --left-right, --cherry-pick etc.
    
    It could be followed up by introducing --cherry as equivalent to
    --cherry-pick --right-only --ignore-merges
    and optionally making this work for A..B, or making "--cherry-pick A..B"
    invoke "--cherry-pick --right-only A...B" which would make a lot of sense
    but also change existing behavior.

 revision.c |   24 ++++++++++++++++++++++++
 revision.h |    2 ++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 86d2470..6ffa8fb 100644
--- a/revision.c
+++ b/revision.c
@@ -729,6 +729,23 @@ static struct commit_list *collect_bottom_commits(struct commit_list *list)
 	return bottom;
 }
 
+/* Assumes either left_only or right_only is set */
+static void limit_left_right(struct commit_list *list, struct rev_info *revs)
+{
+	struct commit_list *p;
+
+	for (p = list; p; p = p->next) {
+		struct commit *commit = p->item;
+
+		if (revs->right_only) {
+			if (commit->object.flags & SYMMETRIC_LEFT)
+				commit->object.flags |= SHOWN;
+		} else	/* revs->left_only is set */
+			if (!(commit->object.flags & SYMMETRIC_LEFT))
+				commit->object.flags |= SHOWN;
+	}
+}
+
 static int limit_list(struct rev_info *revs)
 {
 	int slop = SLOP;
@@ -784,6 +801,9 @@ static int limit_list(struct rev_info *revs)
 	if (revs->cherry_pick)
 		cherry_pick_list(newlist, revs);
 
+	if (revs->left_only || revs->right_only)
+		limit_left_right(newlist, revs);
+
 	if (bottom) {
 		limit_to_ancestry(bottom, newlist);
 		free_commit_list(bottom);
@@ -1260,6 +1280,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->boundary = 1;
 	} else if (!strcmp(arg, "--left-right")) {
 		revs->left_right = 1;
+	} else if (!strcmp(arg, "--left-only")) {
+		revs->left_only = 1;
+	} else if (!strcmp(arg, "--right-only")) {
+		revs->right_only = 1;
 	} else if (!strcmp(arg, "--count")) {
 		revs->count = 1;
 	} else if (!strcmp(arg, "--cherry-pick")) {
diff --git a/revision.h b/revision.h
index 82509dd..a4096ca 100644
--- a/revision.h
+++ b/revision.h
@@ -59,6 +59,8 @@ struct rev_info {
 			boundary:2,
 			count:1,
 			left_right:1,
+			left_only:1,
+			right_only:1,
 			rewrite_parents:1,
 			print_parents:1,
 			show_source:1,
-- 
1.7.4.1.74.gf39475.dirty
