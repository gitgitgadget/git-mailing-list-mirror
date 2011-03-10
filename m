From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 06/10] revision.c: introduce --cherry-mark
Date: Thu, 10 Mar 2011 15:44:59 +0100
Message-ID: <c17a82478307a5a29455de09232087b17435c52a.1299767413.git.git@drmicha.warpmail.net>
References: <4D78AC8B.7010308@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 15:49:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxhB7-0007ob-MY
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 15:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795Ab1CJOsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 09:48:52 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:56207 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752780Ab1CJOsv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 09:48:51 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EF2DD20CC0;
	Thu, 10 Mar 2011 09:48:50 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 10 Mar 2011 09:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=u3y/IY/l3hdIjVLkpv0osUZIV5c=; b=TLoWgQwzGU97oKLetFi+rZL+lPJSw2rIM83nNUgidyXijGV1lVnSvyvxRP+0r5E38ceBn8LNdzxrmWFuAk1M3lKu1AAt8RenfwXqDmjK8Qhs6mUfhjPoS12v24fsxMcrD6uq/4ZUuazWovQkjxwJHC5wFnuPMUaUBiBvxR8UqNI=
X-Sasl-enc: R+m2uLtXcmzQgGjxb9B2Iv/XxRwJSWfVmAzPjea/ynvP 1299768530
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4931B44607F;
	Thu, 10 Mar 2011 09:48:50 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.317.gf445f
In-Reply-To: <4D78AC8B.7010308@drmicha.warpmail.net>
In-Reply-To: <cover.1299767412.git.git@drmicha.warpmail.net>
References: <cover.1299767412.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168825>

Introduce --cherry-mark for marking those commits which "--cherry-pick"
would drop.  The marker for those commits is '=' because '-' denotes a
boundary commit already, even though 'git cherry' uses it.

Nonequivalent commits are denoted '+' unless '--left-right' is used.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 revision.c |   19 +++++++++++++++++--
 revision.h |    4 +++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index 0de1608..864bc9b 100644
--- a/revision.c
+++ b/revision.c
@@ -535,6 +535,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 	int left_count = 0, right_count = 0;
 	int left_first;
 	struct patch_ids ids;
+	unsigned cherry_flag;
 
 	/* First count the commits on the left and on the right */
 	for (p = list; p; p = p->next) {
@@ -576,6 +577,8 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		commit->util = add_commit_patch_id(commit, &ids);
 	}
 
+	cherry_flag = revs->cherry_mark ? PATCHSAME : SHOWN;
+
 	/* Check the other side */
 	for (p = list; p; p = p->next) {
 		struct commit *commit = p->item;
@@ -598,7 +601,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		if (!id)
 			continue;
 		id->seen = 1;
-		commit->object.flags |= SHOWN;
+		commit->object.flags |= cherry_flag;
 	}
 
 	/* Now check the original side for seen ones */
@@ -610,7 +613,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		if (!ent)
 			continue;
 		if (ent->seen)
-			commit->object.flags |= SHOWN;
+			commit->object.flags |= cherry_flag;
 		commit->util = NULL;
 	}
 
@@ -1293,7 +1296,15 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->right_only = 1;
 	} else if (!strcmp(arg, "--count")) {
 		revs->count = 1;
+	} else if (!strcmp(arg, "--cherry-mark")) {
+		if (revs->cherry_pick && !revs->cherry-mark)
+			die("--cherry-mark is incompatible with --cherry-pick");
+		revs->cherry_mark = 1;
+		revs->cherry_pick = 1;
+		revs->limited = 1; /* needs limit_list() */
 	} else if (!strcmp(arg, "--cherry-pick")) {
+		if (revs->cherry_mark)
+			die("--cherry-pick is incompatible with --cherry-mark");
 		revs->cherry_pick = 1;
 		revs->limited = 1;
 	} else if (!strcmp(arg, "--objects")) {
@@ -2270,6 +2281,8 @@ char *get_revision_mark(const struct rev_info *revs, const struct commit *commit
 		return "-";
 	else if (commit->object.flags & UNINTERESTING)
 		return "^";
+	else if (commit->object.flags & PATCHSAME)
+		return "=";
 	else if (!revs || revs->left_right) {
 		if (commit->object.flags & SYMMETRIC_LEFT)
 			return "<";
@@ -2277,5 +2290,7 @@ char *get_revision_mark(const struct rev_info *revs, const struct commit *commit
 			return ">";
 	} else if (revs->graph)
 		return "*";
+	else if (revs->cherry_mark)
+		return "+";
 	return "";
 }
diff --git a/revision.h b/revision.h
index 0e4b35e..d38f135 100644
--- a/revision.h
+++ b/revision.h
@@ -14,7 +14,8 @@
 #define CHILD_SHOWN	(1u<<6)
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
-#define ALL_REV_FLAGS	((1u<<9)-1)
+#define PATCHSAME	(1u<<9)
+#define ALL_REV_FLAGS	((1u<<10)-1)
 
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
@@ -68,6 +69,7 @@ struct rev_info {
 			reverse:1,
 			reverse_output_stage:1,
 			cherry_pick:1,
+			cherry_mark:1,
 			bisect:1,
 			ancestry_path:1,
 			first_parent_only:1;
-- 
1.7.4.1.317.gf445f
