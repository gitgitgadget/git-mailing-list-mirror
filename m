From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATHC/RFC] revlist.c: introduce --cherry for unsymmetric picking
Date: Wed, 16 Feb 2011 11:59:33 +0100
Message-ID: <15a90a6606cff7d823fe4afbedd580aadf7b1d1e.1297853883.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 16 12:02:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppf9h-0001tt-Mt
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 12:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241Ab1BPLCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 06:02:40 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56127 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752983Ab1BPLCi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 06:02:38 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2BA3320CB3
	for <git@vger.kernel.org>; Wed, 16 Feb 2011 06:02:38 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 16 Feb 2011 06:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=83nG7Ewz/DCpFDIyYyWhRu3sSk0=; b=cLdJmopGkUcHdeOCtJ6ubZvEcqxIKBZ15nxwsRgUUTe6o62I2f6Ukk9sYBTKAYbb4Sh0eJoKJtQv/VnSVRMAPdUbPyF4szpdOufkBJcWKFnnhOrHzTUjoGyY7DTTKz7cLI5rELYUAY8irWg6JHhyV1rZUS6T0abO+9YmeI4teKM=
X-Sasl-enc: 0dzH4fWYo2TK43SC8oENFO02cspLb2U+NE3+pBPBY81r 1297854157
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 84C49441EB2;
	Wed, 16 Feb 2011 06:02:37 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166959>

The existing "--cherry-pick" does not work with unsymmetric ranges
(A..B) for obvious reasons.

Introduce "--cherry" which works more like "git-cherry", i.e.: Ignore
commits in B which are patch-equivalent to patches in A, i.e. list only
those which "git cherry B A" would list with a "-". This is especially
useful for things like

git log --cherry @{u}..

which is a much more descriptive than

git cherry @{u}

and potentially more useful than

git log --cherry-pick @{u}...

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
RFC for lack of doc and tests, and also:

I first considered "--cherry-pick A..B" to automatically invoke this mode.
Here are a few reasons why I didn't:

- I haven't found a better way to propagate "we have a fake symmetric
range" from handle_revision_arg() to cherry_pick_list(). Flags like
SHOWN or TMP_MARK are reset somewhere in between! A global wouldn't do a
better (more fine grained) job than the rev flag.

- In the case of multiple revision args, it's probably less confusing to
have one overall mode (think "--cherry-pick A...B C..D") than the added
flexibility.

- I don't like the name "--cherry-pick" for an option which is like "git
cherry" and unlike "git cherry-pick".

- We could still activate this mode as soon as one A..B range apears.

 revision.c |   17 +++++++++++++++--
 revision.h |    1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 86d2470..91d27ea 100644
--- a/revision.c
+++ b/revision.c
@@ -611,6 +611,16 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 	}
 
 	free_patch_ids(&ids);
+
+	if (!revs->cherry)
+		return;
+	/* Remove auxiliary commits */
+	for (p = list; p; p = p->next) {
+		struct commit *commit = p->item;
+
+		if (commit->object.flags & SYMMETRIC_LEFT)
+			commit->object.flags |= SHOWN;
+	}
 }
 
 /* How many extra uninteresting commits we want to see.. */
@@ -781,7 +791,7 @@ static int limit_list(struct rev_info *revs)
 		show(revs, newlist);
 		show_early_output = NULL;
 	}
-	if (revs->cherry_pick)
+	if (revs->cherry || revs->cherry_pick)
 		cherry_pick_list(newlist, revs);
 
 	if (bottom) {
@@ -1028,7 +1038,7 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 				verify_non_filename(revs->prefix, arg);
 			}
 
-			if (symmetric) {
+			if (symmetric || revs->cherry) {
 				exclude = get_merge_bases(a, b, 1);
 				add_pending_commit_list(revs, exclude,
 							flags_exclude);
@@ -1265,6 +1275,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--cherry-pick")) {
 		revs->cherry_pick = 1;
 		revs->limited = 1;
+	} else if (!strcmp(arg, "--cherry")) {
+		revs->cherry = 1;
+		revs->limited = 1;
 	} else if (!strcmp(arg, "--objects")) {
 		revs->tag_objects = 1;
 		revs->tree_objects = 1;
diff --git a/revision.h b/revision.h
index 82509dd..9a01050 100644
--- a/revision.h
+++ b/revision.h
@@ -65,6 +65,7 @@ struct rev_info {
 			show_decorations:1,
 			reverse:1,
 			reverse_output_stage:1,
+			cherry:1,
 			cherry_pick:1,
 			bisect:1,
 			ancestry_path:1,
-- 
1.7.4.1.74.gf39475.dirty
