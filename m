From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] rev-list: estimate number of bisection step left
Date: Tue, 17 Feb 2009 06:09:44 +0100
Message-ID: <20090217060944.488184b0.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 06:13:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZIGW-00044e-BH
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 06:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbZBQFK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 00:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbZBQFK2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 00:10:28 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:36880 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791AbZBQFK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 00:10:27 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 15CBB81809A;
	Tue, 17 Feb 2009 06:10:19 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with SMTP id EF3EF81807F;
	Tue, 17 Feb 2009 06:10:15 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110307>

This patch teaches "git rev-list --bisect-vars" to output an estimate
of the number of bisection step left along with the other variables it
already outputs.

The estimate is calculated using log2(all_revisions_left/2 - 1).
This is the most straightforward formula and seems to work fine in
practice.

We substract 1 to "all_revisions_left/2" because we allready know one
bad revision.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-list.c |   27 +++++++++++++++++++++++++--
 git-bisect.sh      |    2 +-
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 436afa4..ee4abe7 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -574,6 +574,27 @@ static struct commit_list *find_bisection(struct commit_list *list,
 	return best;
 }
 
+/*
+ * Estimate the number of bisect steps left
+ * Taking log2(all_revisions_left/2 - 1) seems to work fine.
+ * "- 1" is because we already know one bad revision.
+ */
+static int estimate_bisect_steps(int all)
+{
+	int log2 = 0;
+	int left = (all >> 1) - 1;
+
+	if (left <= 0)
+		return 0;
+
+	do {
+		left = left >> 1;
+		log2++;
+	} while (left);
+
+	return log2;
+}
+
 int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct commit_list *list;
@@ -688,12 +709,14 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			       "bisect_nr=%d\n"
 			       "bisect_good=%d\n"
 			       "bisect_bad=%d\n"
-			       "bisect_all=%d\n",
+			       "bisect_all=%d\n"
+			       "bisect_steps=%d\n",
 			       hex,
 			       cnt - 1,
 			       all - reaches - 1,
 			       reaches - 1,
-			       all);
+			       all,
+			       estimate_bisect_steps(all));
 			return 0;
 		}
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 85db4ba..6b23439 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -500,7 +500,7 @@ bisect_next() {
 	# commit is also a "skip" commit (see above).
 	exit_if_skipped_commits "$bisect_rev"
 
-	bisect_checkout "$bisect_rev" "$bisect_nr revisions left to test after this"
+	bisect_checkout "$bisect_rev" "$bisect_nr revisions left to test after this (roughtly $bisect_steps steps)"
 }
 
 bisect_visualize() {
-- 
1.6.2.rc0.90.g0753.dirty
