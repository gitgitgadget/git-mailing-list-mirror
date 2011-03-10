From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 01/10] revlist.c: introduce --left/right-only for unsymmetric picking
Date: Thu, 10 Mar 2011 15:44:54 +0100
Message-ID: <60adf7d73e44126289a98dada60f9c335ffc84b0.1299767412.git.git@drmicha.warpmail.net>
References: <4D78AC8B.7010308@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 15:48:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxhAX-0007SI-9K
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 15:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715Ab1CJOsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 09:48:42 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:41202 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752091Ab1CJOsl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 09:48:41 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 36A2F20D39;
	Thu, 10 Mar 2011 09:48:41 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 10 Mar 2011 09:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=YUxrdwpy2PjSfwKiPeVreGYSxLo=; b=JpSEdjjjKlqbr/doBSoW6Psi+zkEVBN38MEFPAoUbiH1qZuDzEat6GL5nzpHM4I9CZpbLHFLcTOJhlOyAyoDUlEd/ihZinfTJMBl8th0bHMliR54/a/XPT7JlEgQsfMDN+0fMauCyqrrA+SlLszyWdDeaXBT56U7d4YEawH3qp4=
X-Sasl-enc: SbH2Ok0JRohBukCczKdK3KSXV41Nd8dFyDy2QiNLYT3s 1299768520
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8C71644708E;
	Thu, 10 Mar 2011 09:48:40 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.317.gf445f
In-Reply-To: <4D78AC8B.7010308@drmicha.warpmail.net>
In-Reply-To: <cover.1299767412.git.git@drmicha.warpmail.net>
References: <cover.1299767412.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168819>

The existing "--cherry-pick" does not work with unsymmetric ranges
(A..B) for obvious reasons.

Introduce "--left-only" and "--right-only" which limit the output to
commits on the respective sides of a symmetric range (i.e. only "<"
resp. ">" commits as per "--left-right").

This is especially useful for things like

    git log --cherry-pick --right-only @{u}...

which is much more flexible (and descriptive) than

    git cherry @{u} | sed -ne 's/^+ //p'

and potentially more useful than

    git log --cherry-pick @{u}...

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c |   24 ++++++++++++++++++++++++
 revision.h |    2 ++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 7b9eaef..0681c7c 100644
--- a/revision.c
+++ b/revision.c
@@ -733,6 +733,23 @@ static struct commit_list *collect_bottom_commits(struct commit_list *list)
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
@@ -788,6 +805,9 @@ static int limit_list(struct rev_info *revs)
 	if (revs->cherry_pick)
 		cherry_pick_list(newlist, revs);
 
+	if (revs->left_only || revs->right_only)
+		limit_left_right(newlist, revs);
+
 	if (bottom) {
 		limit_to_ancestry(bottom, newlist);
 		free_commit_list(bottom);
@@ -1263,6 +1283,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
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
index 05659c6..d2ffde1 100644
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
1.7.4.1.317.gf445f
