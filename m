From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] merge-tree: fix "same file added in subdir"
Date: Wed, 27 Mar 2013 21:34:36 +0000
Message-ID: <0a6a0c978569906b8c8d9209a85338554e503236.1364419952.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 27 22:36:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKy0c-0007Tj-Nf
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 22:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275Ab3C0VfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 17:35:17 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:55517 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab3C0VfP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 17:35:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id E3566161E3F4;
	Wed, 27 Mar 2013 21:35:14 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pigWrroFRKHh; Wed, 27 Mar 2013 21:34:54 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 0586D161E409;
	Wed, 27 Mar 2013 21:34:48 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.411.g65a544e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219334>

When the same file is added with identical content at the top level,
git-merge-tree prints "added in both" with the details.  But if the file
is added in an existing subdirectory, threeway_callback() bails out early
because the two trees have been modified identically.

In order to detect this, we need to fall through and recurse into the
subtree in this case.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 builtin/merge-tree.c  |  9 +++++++--
 t/t4300-merge-tree.sh | 17 +++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index e0d0b7d..ca97fbd 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -298,12 +298,17 @@ static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, s
 {
 	/* Same in both? */
 	if (same_entry(entry+1, entry+2)) {
-		if (entry[0].sha1) {
+		if (entry[0].sha1 && !S_ISDIR(entry[0].mode)) {
 			/* Modified identically */
 			resolve(info, NULL, entry+1);
 			return mask;
 		}
-		/* "Both added the same" is left unresolved */
+		/*
+		 * "Both added the same" is left unresolved.  We also leave
+		 * "Both directories modified identically" unresolved in
+		 * order to catch changes where the same file (with the same
+		 * content) has been added to both directories.
+		 */
 	}
 
 	if (same_entry(entry+0, entry+1)) {
diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index d0b2a45..be0737e 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -298,4 +298,21 @@ test_expect_success 'turn tree to file' '
 	test_cmp expect actual
 '
 
+test_expect_success 'add identical files to subdir' '
+	cat >expected <<\EXPECTED &&
+added in both
+  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d sub/ONE
+  their  100644 43d5a8ed6ef6c00ff775008633f95787d088285d sub/ONE
+EXPECTED
+
+	git reset --hard initial &&
+	mkdir sub &&
+	test_commit "sub-initial" "sub/initial" "initial" &&
+	test_commit "sub-add-a-b-same-A" "sub/ONE" "AAA" &&
+	git reset --hard sub-initial &&
+	test_commit "sub-add-a-b-same-B" "sub/ONE" "AAA" &&
+	git merge-tree sub-initial sub-add-a-b-same-A sub-add-a-b-same-B >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.8.2.411.g65a544e
