From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 2/4] diff test: Add tests for combine-diff with orderfile
Date: Mon, 20 Jan 2014 20:20:39 +0400
Message-ID: <0c3e9511a4ff373ecf432fcb4a5d00864e1d8b2a.1390234183.git.kirr@mns.spb.ru>
References: <cover.1390234183.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 20 17:34:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5Ho2-0003B2-EH
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 17:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbaATQe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 11:34:28 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:60903 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754007AbaATQe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 11:34:26 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1W5HZ6-0007Vl-Vj; Mon, 20 Jan 2014 20:19:09 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1W5Hb1-0001Pz-8q; Mon, 20 Jan 2014 20:21:07 +0400
X-Mailer: git-send-email 1.9.rc0.143.g6fd479e
In-Reply-To: <cover.1390234183.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1390234183.git.kirr@mns.spb.ru>
References: <cover.1390234183.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240714>

In the next patch combine-diff will have special code-path for taking
orderfile into account. Prepare for making changes by introducing
coverage tests for that case.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 t/t4056-diff-order.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
index 9e2b29e..c0460bb 100755
--- a/t/t4056-diff-order.sh
+++ b/t/t4056-diff-order.sh
@@ -97,4 +97,25 @@ do
 	'
 done
 
+test_expect_success 'setup for testing combine-diff order' '
+	git checkout -b tmp HEAD~ &&
+	create_files 3 &&
+	git checkout master &&
+	git merge --no-commit -s ours tmp &&
+	create_files 5
+'
+
+test_expect_success "combine-diff: no order (=tree object order)" '
+	git diff --name-only HEAD HEAD^ HEAD^2 >actual &&
+	test_cmp expect_none actual
+'
+
+for i in 1 2
+do
+	test_expect_success "combine-diff: orderfile using option ($i)" '
+		git diff -Oorder_file_$i --name-only HEAD HEAD^ HEAD^2 >actual &&
+		test_cmp expect_$i actual
+	'
+done
+
 test_done
-- 
1.9.rc0.143.g6fd479e
