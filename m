From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 03/19] tree-diff: no need to manually verify that there is no mode change for a path
Date: Mon, 24 Feb 2014 20:21:35 +0400
Message-ID: <22aebb863fb2a5a556e68d57f3a1095d3c502d4e.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:21:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHyH8-0003IB-SQ
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbaBXQUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 11:20:51 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:34149 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753089AbaBXQUu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 11:20:50 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WHyGv-0003zi-80; Mon, 24 Feb 2014 20:20:49 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WHyIa-00079Z-DR; Mon, 24 Feb 2014 20:22:32 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242593>

Because if there is, such two tree entries would never be compared as
equal - the code in base_name_compare() explicitly compares modes, if
there is a change for dir bit, even for equal paths, entries would
compare as different.

The code I'm removing here is from 2005 April 262e82b4 (Fix diff-tree
recursion), which pre-dates base_name_compare() introduction in 958ba6c9
(Introduce "base_name_compare()" helper function) by a month.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

( re-posting without change )

 tree-diff.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 11c3550..5810b00 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -23,6 +23,11 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2,
 
 	pathlen1 = tree_entry_len(&t1->entry);
 	pathlen2 = tree_entry_len(&t2->entry);
+
+	/*
+	 * NOTE files and directories *always* compare differently,
+	 * even when having the same name.
+	 */
 	cmp = base_name_compare(path1, pathlen1, mode1, path2, pathlen2, mode2);
 	if (cmp < 0) {
 		show_entry(opt, "-", t1, base);
@@ -35,16 +40,6 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2,
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
