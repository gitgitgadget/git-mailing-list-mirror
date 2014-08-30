From: Max Kirillov <max@max630.net>
Subject: [PATCH] reachable.c: add HEAD to reachability starting commits
Date: Sat, 30 Aug 2014 23:58:35 +0300
Message-ID: <1409432315-20803-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 30 23:07:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNpru-0001FD-Dt
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 23:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbaH3VH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 17:07:26 -0400
Received: from p3plsmtpa08-05.prod.phx3.secureserver.net ([173.201.193.106]:37948
	"EHLO p3plsmtpa08-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751898AbaH3VHZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Aug 2014 17:07:25 -0400
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Aug 2014 17:07:25 EDT
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa08-05.prod.phx3.secureserver.net with 
	id l8zK1o00J3gsSd6018zR5N; Sat, 30 Aug 2014 13:59:27 -0700
X-Mailer: git-send-email 2.0.1.1697.g73c6810
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256267>

HEAD is not explicitly used as a starting commit for
calculating reachability, so if it's detached and reflogs
are disabled it may be pruned.

Add test which demonstrates it.

Signed-off-by: Max Kirillov <max@max630.net>
---
Hi.

This is a followup of http://thread.gmane.org/gmane.comp.version-control.git/255996
I digged it a bit more and look what I found!

Actually, I think would be nice if someone familiar with the code greps for
for_each_ref() usage and for each case verify if head should be added.
 reachable.c               |  3 +++
 t/t5312-prune-detached.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100755 t/t5312-prune-detached.sh

diff --git a/reachable.c b/reachable.c
index 654a8c5..6f6835b 100644
--- a/reachable.c
+++ b/reachable.c
@@ -229,6 +229,9 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	/* Add all external refs */
 	for_each_ref(add_one_ref, revs);
 
+	/* detached HEAD is not included in the list above */
+	head_ref(add_one_ref, revs);
+
 	/* Add all reflog info */
 	if (mark_reflog)
 		for_each_reflog(add_one_reflog, revs);
diff --git a/t/t5312-prune-detached.sh b/t/t5312-prune-detached.sh
new file mode 100755
index 0000000..fac93e1
--- /dev/null
+++ b/t/t5312-prune-detached.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='no prune detached head without reflog'
+. ./test-lib.sh
+
+test_expect_success 'make repo' '
+	git config core.logAllRefUpdates false
+	git commit --allow-empty -m commit1 &&
+	git commit --allow-empty -m commit2 &&
+	git checkout  --detach master &&
+	git commit --allow-empty -m commit3
+'
+
+test_expect_success 'prune does not delete anything' '
+	git prune -n >prune_actual &&
+	: >prune_expected &&
+	test_cmp prune_expected prune_actual'
+
+test_done
-- 
2.0.1.1697.g73c6810
