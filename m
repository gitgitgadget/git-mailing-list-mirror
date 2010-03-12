From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH] Bug: failed octopus merge does not create MERGE_HEAD
Date: Fri, 12 Mar 2010 15:07:15 +0100
Message-ID: <1268402835-12992-1-git-send-email-sojkam1@fel.cvut.cz>
Cc: Michal Sojka <sojkam1@fel.cvut.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 12 15:07:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nq5WY-0000K1-Bi
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 15:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932963Ab0CLOH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 09:07:29 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:50319 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932850Ab0CLOH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 09:07:28 -0500
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id 55CD119F35DB;
	Fri, 12 Mar 2010 15:07:27 +0100 (CET)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id H0LQgGBy7jyW; Fri, 12 Mar 2010 15:07:26 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 132F219F35D3;
	Fri, 12 Mar 2010 15:07:26 +0100 (CET)
Received: from steelpick.localdomain (k335-30.felk.cvut.cz [147.32.86.30])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 0B3DDFA003;
	Fri, 12 Mar 2010 15:07:26 +0100 (CET)
Received: from wsh by steelpick.localdomain with local (Exim 4.71)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1Nq5WP-0003O3-JP; Fri, 12 Mar 2010 15:07:25 +0100
X-Mailer: git-send-email 1.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142036>

Hi,

the following test case exhibits behavior which I think is a bug. If
merge-one-file cannot handle the merge we end up with unmerged index
entries and no MERGE_HEAD created. I suppose that MERGE_HEAD should be
created whenever a merge fails.

If someone gives me a hint how to correct this, I can try to do it.

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>

---
 t/t7611-merge-octopus-fail.sh |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/t/t7611-merge-octopus-fail.sh b/t/t7611-merge-octopus-fail.sh
new file mode 100755
index 0000000..b7f983b
--- /dev/null
+++ b/t/t7611-merge-octopus-fail.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description='git merge
+
+Testing octopus merge with one file changed and deleted on different branches.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit initial file &&
+	test_commit changed file &&
+	git reset --hard initial -- &&
+	git rm file &&
+	git commit -m deleted &&
+	git tag deleted &&
+	git reset --hard initial -- &&
+	test_commit file2
+'
+test_expect_success 'failed octopus merge' '
+	git reset --hard changed &&
+	test_must_fail git merge deleted file2
+'
+
+test_expect_failure 'check that MERGE_HEAD exists' '
+	test -f .git/MERGE_HEAD
+'
+
+test_done
-- 
tg: (90a2bf9..) t/test-failed-octopus-merge (depends on: master)
