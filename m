From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 3/8] tree-diff: no need to manually verify that there is no mode change for a path
Date: Mon,  3 Feb 2014 16:47:17 +0400
Message-ID: <83f38f44dab9e07e99ad851f531e01cee52e7019.1391430523.git.kirr@mns.spb.ru>
References: <cover.1391430523.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 13:46:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAIua-0006tq-93
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 13:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbaBCMqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 07:46:00 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:37425 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbaBCMp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 07:45:59 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WAIuT-0004Zi-Ln; Mon, 03 Feb 2014 16:45:57 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WAIwH-0007Fm-3M; Mon, 03 Feb 2014 16:47:49 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1391430523.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1391430523.git.kirr@mns.spb.ru>
References: <cover.1391430523.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241429>

Because if there is, such two tree entries would never be compared as
equal - the code in base_name_compare() explicitly compares modes, if
there is a change for dir bit, even for equal paths, entries would
compare as different.

The code I'm removing here is from 2005 April 262e82b4 (Fix diff-tree
recursion), which pre-dates base_name_compare() introduction in 958ba6c9
(Introduce "base_name_compare()" helper function) by a month.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 tree-diff.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 456660c..c2c67fd 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -23,6 +23,10 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2,
 
 	pathlen1 = tree_entry_len(&t1->entry);
 	pathlen2 = tree_entry_len(&t2->entry);
+
+	/* NOTE files and directories *always* compare differently, event when
+	 * having the same name.
+	 */
 	cmp = base_name_compare(path1, pathlen1, mode1, path2, pathlen2, mode2);
 	if (cmp < 0) {
 		show_entry(opt, "-", t1, base);
@@ -35,16 +39,6 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2,
 	if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER) && !hashcmp(sha1, sha2) && mode1 == mode2)
 		return 0;
 
-	/*
-	 * If the filemode has changed to/from a directory from/to a regular
-	 * file, we need to consider it a remove and an add.
-	 */
-	if (S_ISDIR(mode1) != S_ISDIR(mode2)) {
-		show_entry(opt, "-", t1, base);
-		show_entry(opt, "+", t2, base);
-		return 0;
-	}
-
 	strbuf_add(base, path1, pathlen1);
 	if (DIFF_OPT_TST(opt, RECURSIVE) && S_ISDIR(mode1)) {
 		if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE)) {
-- 
1.9.rc1.181.g641f458
