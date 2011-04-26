From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] rev-list --count: separate count for --cherry-mark
Date: Tue, 26 Apr 2011 10:24:29 +0200
Message-ID: <3e743b672c3e20a245055e47671bc1af1039b60a.1303806237.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 10:24:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEdZX-0003nr-FX
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 10:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216Ab1DZIYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 04:24:33 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:36639 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750903Ab1DZIYb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2011 04:24:31 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4E97B20CFC
	for <git@vger.kernel.org>; Tue, 26 Apr 2011 04:24:31 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 26 Apr 2011 04:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=yFPzCNKCmCEGANZ9ZpLOaSBZDJA=; b=eKRkguwM3DUNve8FJPKdgwHdgipgFvAYpLsetvOZjpp44AlCHfVbeaa8mnFLdlNagvarqVbqqODohOnpu3hhMvJD+2L5jbOjwPzyqAANIEo0Q7x0nNVNyJFh4Ci4yLESzveEw/kfPpzaXB68pfuwq1a7X+5BvgXkHXHkQcN7oQo=
X-Sasl-enc: t2CTAD3ze2yH8WzPNWc9gZ0w/sitBAy9QOrUHmVcUOQ1 1303806270
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9CCD74402AC;
	Tue, 26 Apr 2011 04:24:30 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.270.gafca7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172078>

When --count is used with --cherry-mark, omit the patch equivalent
commits from the count for left and right commits and print the count of
equivalent commits separately.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I noticed this in passing. It does not break anything and can be done
easily. It might even be useful for gitprompt, branch -vv and the like.

Resent for the new cycle.
---
 Documentation/rev-list-options.txt   |    5 ++++-
 builtin/rev-list.c                   |   10 ++++++++--
 revision.h                           |    1 +
 t/t6007-rev-list-cherry-pick-file.sh |   27 +++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 3 deletions(-)

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
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index cacf3de..28d4f6b 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -157,6 +157,33 @@ test_expect_success '--cherry' '
 	test_cmp actual.named expect
 '
 
+cat >expect <<EOF
+1	1
+EOF
+
+test_expect_success '--cherry --count' '
+	git rev-list --cherry --count F...E -- bar > actual &&
+	test_cmp actual expect
+'
+
+cat >expect <<EOF
+2	2
+EOF
+
+test_expect_success '--cherry-mark --count' '
+	git rev-list --cherry-mark --count F...E -- bar > actual &&
+	test_cmp actual expect
+'
+
+cat >expect <<EOF
+1	1	2
+EOF
+
+test_expect_success '--cherry-mark --left-right --count' '
+	git rev-list --cherry-mark --left-right --count F...E -- bar > actual &&
+	test_cmp actual expect
+'
+
 test_expect_success '--cherry-pick with independent, but identical branches' '
 	git symbolic-ref HEAD refs/heads/independent &&
 	rm .git/index &&
-- 
1.7.5.270.gafca7
