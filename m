From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/9] revlist.c: introduce --left/right-only for unsymmetric picking
Date: Mon,  7 Mar 2011 13:31:35 +0100
Message-ID: <60adf7d73e44126289a98dada60f9c335ffc84b0.1299499429.git.git@drmicha.warpmail.net>
References: <cover.1299499429.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 13:35:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwZei-0003M8-1l
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 13:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221Ab1CGMfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 07:35:16 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43191 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750754Ab1CGMfO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Mar 2011 07:35:14 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 66D0E206B1;
	Mon,  7 Mar 2011 07:35:13 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 07 Mar 2011 07:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=UtEk9bgDRYZMi1jTruWpCAwQgD8=; b=jeyHfsipKLBXz6IcS3px8+Ukky5hW1PQFSTdJK8rvzncbH321FpCDK6xbwbXZcPjq6DbTypyipd1EbY5PkQ0f3eRsuGt3p6aqmO+6b+6LTJjBWQw/8rbQauef8YJUDivbuIUAzVwcCCa/BUNvePPi3Z3x1ysY815Rc6Fb819arQ=
X-Sasl-enc: r/7kVPdzRbzZd5+4li4Z0Ay/481vkjNUILTD8Zwjev5C 1299501312
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 689FB44424F;
	Mon,  7 Mar 2011 07:35:12 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.299.g567d7.dirty
In-Reply-To: <cover.1299499429.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168581>

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
1.7.4.1.299.g567d7.dirty
