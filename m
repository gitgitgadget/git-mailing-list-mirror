From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFC] rev-list --count: separate count for --cherry-mark
Date: Tue, 22 Mar 2011 13:41:06 +0100
Message-ID: <df0c562ed0e2255a3cfe581698298a6fe48900ca.1300797575.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 13:44:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q20x0-0004Jl-Pe
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 13:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220Ab1CVMoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 08:44:38 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:45450 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752089Ab1CVMog (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2011 08:44:36 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 317D12091D
	for <git@vger.kernel.org>; Tue, 22 Mar 2011 08:44:36 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 22 Mar 2011 08:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=2HHB7eUjj7o1eTn7QbC5TKBkSYE=; b=eqZnknPvYR9P15ILyyJauqeiH9rw/DWhBHjlLisJUHstOrgZqILVw88NMxZ4C0q6WyF0YJF6yCbEdZRmKoHIeKq/7NU52OM96TeiwWjSn2HHCfxO1gECvyhIOcJJtckzJri47IcfIbLr1/b3JFuSQjqfqukUM22Xjuy77ARCDG4=
X-Sasl-enc: OhxaaqywR1AAX+r6ZOw0JcgHvkLqq4qwu1qec144PTOe 1300797875
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8426E403D41;
	Tue, 22 Mar 2011 08:44:35 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.511.g72e46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169727>

When --count is used with --cherry-mark, omit the patch equivalent
commits from the count for left and right commits and print the count of
equivalent commits separately.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I noticed this in passing. It does not break anything and can be done
easily. I would feel strongly positive about it if rev-list --cherry
was faster. Then it would be useful for gitprompt, branch -vv and the like.

 Documentation/rev-list-options.txt |    5 ++++-
 builtin/rev-list.c                 |   10 ++++++++--
 revision.h                         |    1 +
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5c6850f..e092a7c 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -715,7 +715,10 @@ ifdef::git-rev-list[]
 	Print a number stating how many commits would have been
 	listed, and suppress all other output.  When used together
 	with '--left-right', instead print the counts for left and
-	right commits, separated by a tab.
+	right commits, separated by a tab. When used together with
+	'--cherry-mark', omit patch equivalent commits from these
+	counts and print the count for equivalent commits separated
+	by a tab.
 endif::git-rev-list[]
 
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index f458cb7..8761e9a 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -51,7 +51,9 @@ static void show_commit(struct commit *commit, void *data)
 	graph_show_commit(revs->graph);
 
 	if (revs->count) {
-		if (commit->object.flags & SYMMETRIC_LEFT)
+		if (commit->object.flags & PATCHSAME)
+			revs->count_same++;
+		else if (commit->object.flags & SYMMETRIC_LEFT)
 			revs->count_left++;
 		else
 			revs->count_right++;
@@ -402,8 +404,12 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			     &info);
 
 	if (revs.count) {
-		if (revs.left_right)
+		if (revs.left_right && revs.cherry_mark)
+			printf("%d\t%d\t%d\n", revs.count_left, revs.count_right, revs.count_same);
+		else if (revs.left_right)
 			printf("%d\t%d\n", revs.count_left, revs.count_right);
+		else if (revs.cherry_mark)
+			printf("%d\t%d\n", revs.count_left + revs.count_right, revs.count_same);
 		else
 			printf("%d\n", revs.count_left + revs.count_right);
 	}
diff --git a/revision.h b/revision.h
index ae94860..08900b3 100644
--- a/revision.h
+++ b/revision.h
@@ -141,6 +141,7 @@ struct rev_info {
 	/* commit counts */
 	int count_left;
 	int count_right;
+	int count_same;
 };
 
 #define REV_TREE_SAME		0
-- 
1.7.4.1.511.g72e46
