From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 2/3] builtin-branch: factor out merge_filter matching
Date: Sat, 26 Jul 2008 12:27:24 +0200
Message-ID: <1217068045-3575-3-git-send-email-hjemli@gmail.com>
References: <1217068045-3575-1-git-send-email-hjemli@gmail.com>
 <1217068045-3575-2-git-send-email-hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 13:12:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMhhq-0008Hc-Q4
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 13:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbYGZLLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 07:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbYGZLLy
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 07:11:54 -0400
Received: from mail49.e.nsc.no ([193.213.115.49]:49995 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbYGZLLx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 07:11:53 -0400
X-Greylist: delayed 2664 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Jul 2008 07:11:53 EDT
Received: from localhost.localdomain (ti0025a380-0241.bb.online.no [88.89.68.241])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id m6QARRQj019909
	for <git@vger.kernel.org>; Sat, 26 Jul 2008 12:27:28 +0200 (MEST)
X-Mailer: git-send-email 1.6.0.rc0.79.gb0320
In-Reply-To: <1217068045-3575-2-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90206>

The logic for checking commits against merge_filter will be reused
when we recalculate the maxwidth of refnames.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 builtin-branch.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 675a9b1..bff74cf 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -294,6 +294,17 @@ static void fill_tracking_info(char *stat, const char *branch_name)
 		sprintf(stat, "[ahead %d, behind %d] ", ours, theirs);
 }
 
+static int matches_merge_filter(struct commit *commit)
+{
+	int is_merged;
+	
+	if (merge_filter == NO_FILTER)
+		return 1;
+		
+	is_merged = !!(commit->object.flags & UNINTERESTING);
+	return (is_merged == (merge_filter == SHOW_MERGED));
+}
+
 static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 			   int abbrev, int current)
 {
@@ -301,11 +312,8 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	int color;
 	struct commit *commit = item->commit;
 
-	if (merge_filter != NO_FILTER) {
-		int is_merged = !!(item->commit->object.flags & UNINTERESTING);
-		if (is_merged != (merge_filter == SHOW_MERGED))
-			return;
-	}
+	if (!matches_merge_filter(commit))
+		return;
 
 	switch (item->kind) {
 	case REF_LOCAL_BRANCH:
-- 
1.6.0.rc0.79.gb0320
