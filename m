From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] modify/delete conflict resolution overwrites untracked file
Date: Wed, 10 Dec 2008 21:12:59 +0100
Message-ID: <20081210201259.GA12928@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 21:14:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAVSE-0000iQ-LV
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 21:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbYLJUNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 15:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752993AbYLJUNL
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 15:13:11 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:19606 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbYLJUNK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 15:13:10 -0500
Received: from darc.dyndns.org ([84.154.80.98]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Dec 2008 21:13:05 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LAVQZ-0003QV-Fn; Wed, 10 Dec 2008 21:12:59 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 10 Dec 2008 20:13:06.0867 (UTC) FILETIME=[B6EB4030:01C95B03]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102713>

If a file was removed in HEAD, but modified in MERGE_HEAD, recursive merge
will result in a "CONFLICT (delete/modify)". If the (now untracked) file
already exists and was not added to the index, it is overwritten with the
conflict resolution contents.

In similar situations (cf. test 2), the merge would abort with

"error: Untracked working tree 'file' would be overwritten by merge."

The same should happen in this case.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

If it's a regression, it dates far back, since 1.5.0 fails as well.

I don't have time to look into this until Saturday. I won't complain if
someone beats me to it. ;-)

Clemens

 t/t7607-merge-overwrite.sh |   87 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 87 insertions(+), 0 deletions(-)
 create mode 100755 t/t7607-merge-overwrite.sh

diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
new file mode 100755
index 0000000..513097c
--- /dev/null
+++ b/t/t7607-merge-overwrite.sh
@@ -0,0 +1,87 @@
+#!/bin/sh
+
+test_description='git-merge
+
+Do not overwrite changes.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo c0 > c0.c &&
+	git add c0.c &&
+	git commit -m c0 &&
+	git tag c0 &&
+	echo c1 > c1.c &&
+	git add c1.c &&
+	git commit -m c1 &&
+	git tag c1 &&
+	git reset --hard c0 &&
+	echo c2 > c2.c &&
+	git add c2.c &&
+	git commit -m c2 &&
+	git tag c2 &&
+	git reset --hard c1 &&
+	echo "c1 a" > c1.c &&
+	git add c1.c &&
+	git commit -m "c1 a" &&
+	git tag c1a &&
+	echo "VERY IMPORTANT CHANGES" > important
+'
+
+test_expect_success 'will not overwrite untracked file' '
+	git reset --hard c1 &&
+	cat important > c2.c &&
+	! git merge c2 &&
+	test_cmp important c2.c
+'
+
+test_expect_success 'will not overwrite new file' '
+	git reset --hard c1 &&
+	cat important > c2.c &&
+	git add c2.c &&
+	! git merge c2 &&
+	test_cmp important c2.c
+'
+
+test_expect_success 'will not overwrite staged changes' '
+	git reset --hard c1 &&
+	cat important > c2.c &&
+	git add c2.c &&
+	rm c2.c &&
+	! git merge c2 &&
+	git checkout c2.c &&
+	test_cmp important c2.c
+'
+
+test_expect_failure 'will not overwrite removed file' '
+	git reset --hard c1 &&
+	git rm c1.c &&
+	git commit -m "rm c1.c" &&
+	cat important > c1.c &&
+	! git merge c1a &&
+	test_cmp important c1.c
+'
+
+test_expect_success 'will not overwrite re-added file' '
+	git reset --hard c1 &&
+	git rm c1.c &&
+	git commit -m "rm c1.c" &&
+	cat important > c1.c &&
+	git add c1.c &&
+	! git merge c1a &&
+	test_cmp important c1.c
+'
+
+test_expect_success 'will not overwrite removed file with staged changes' '
+	git reset --hard c1 &&
+	git rm c1.c &&
+	git commit -m "rm c1.c" &&
+	cat important > c1.c &&
+	git add c1.c &&
+	rm c1.c &&
+	! git merge c1a &&
+	git checkout c1.c &&
+	test_cmp important c1.c
+'
+
+test_done
-- 
1.6.0
