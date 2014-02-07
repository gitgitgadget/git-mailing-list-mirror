From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 07/11] tree-diff: simplify tree_entry_pathcmp
Date: Fri,  7 Feb 2014 21:48:48 +0400
Message-ID: <9186fb9d2c223241923111d4fd9b5360e474957e.1391794688.git.kirr@mns.spb.ru>
References: <cover.1391794688.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 18:47:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBpWc-0000ZZ-3M
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 18:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbaBGRrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 12:47:32 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:33788 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753311AbaBGRr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 12:47:26 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WBpWP-0002LQ-60; Fri, 07 Feb 2014 21:47:25 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WBpYA-0004AK-Uw; Fri, 07 Feb 2014 21:49:14 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1391794688.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1391794688.git.kirr@mns.spb.ru>
References: <cover.1391794688.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241782>

Since 74aa4a18 (Finally switch over tree descriptors to contain a
pre-parsed entry) we can safely access all tree_desc->entry fields directly
instead of first "extracting" them through tree_entry_extract.

Use it. The code generated stays the same - only it now visually looks
cleaner.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 tree-diff.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 604dc57..330ca07 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -15,18 +15,13 @@
  */
 static int tree_entry_pathcmp(struct tree_desc *t1, struct tree_desc *t2)
 {
-	unsigned mode1, mode2;
-	const char *path1, *path2;
-	const unsigned char *sha1, *sha2;
-	int cmp, pathlen1, pathlen2;
+	struct name_entry *e1, *e2;
+	int cmp;
 
-	sha1 = tree_entry_extract(t1, &path1, &mode1);
-	sha2 = tree_entry_extract(t2, &path2, &mode2);
-
-	pathlen1 = tree_entry_len(&t1->entry);
-	pathlen2 = tree_entry_len(&t2->entry);
-
-	cmp = base_name_compare(path1, pathlen1, mode1, path2, pathlen2, mode2);
+	e1 = &t1->entry;
+	e2 = &t2->entry;
+	cmp = base_name_compare(e1->path, tree_entry_len(e1), e1->mode,
+				e2->path, tree_entry_len(e2), e2->mode);
 	return cmp;
 }
 
-- 
1.9.rc1.181.g641f458
