From: David Greene <greened@obbligato.org>
Subject: [PATCH] Add a test for subtree rebase that loses commits
Date: Sun, 10 Jan 2016 17:08:17 -0600
Message-ID: <1452467297-16868-2-git-send-email-greened@obbligato.org>
References: <1451968805-6948-2-git-send-email-greened@obbligato.org>
 <1452467297-16868-1-git-send-email-greened@obbligato.org>
Cc: gitster@pobox.com, john@keeping.me.uk,
	sandals@crustytoothpaste.net, peff@peff.net,
	sunshine@sunshineco.com, j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 00:08:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIP6G-0004Vt-9p
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 00:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757624AbcAJXIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2016 18:08:36 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:53780 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757415AbcAJXIe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2016 18:08:34 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.us.cray.com)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aIP7E-0004uE-Dz; Sun, 10 Jan 2016 17:09:40 -0600
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1452467297-16868-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283625>

From: "David A. Greene" <greened@obbligato.org>

This test merges an external tree in as a subtree, makes some commits
on top of it and splits it back out.  In the process the added commits
are lost or the rebase aborts with an internal error.  The tests are
marked to expect failure so that we don't forget to fix it.

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 t/t3427-rebase-subtree.sh | 79 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100755 t/t3427-rebase-subtree.sh

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
new file mode 100755
index 0000000..add3b79
--- /dev/null
+++ b/t/t3427-rebase-subtree.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+
+test_description='git rebase tests for -Xsubtree
+
+This test runs git rebase and tests the subtree strategy.
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+check_equal() {
+	test_debug 'echo'
+	test_debug "echo \"check a:\" \"{$1}\""
+	test_debug "echo \"      b:\" \"{$2}\""
+	test "$1" = "$2"
+}
+
+last_commit_message() {
+	git log --pretty=format:%s -1
+}
+
+test_expect_success 'setup' '
+	test_commit README &&
+	mkdir files &&
+	(
+		cd files &&
+		git init &&
+		test_commit master1 &&
+		test_commit master2 &&
+		test_commit master3
+	) &&
+	test_debug "echo Add project master to master" &&
+	git fetch files master &&
+	git branch files-master FETCH_HEAD &&
+	test_debug "echo Add subtree master to master via subtree" &&
+	git read-tree --prefix=files_subtree files-master &&
+	git checkout -- files_subtree &&
+	tree=$(git write-tree) &&
+	head=$(git rev-parse HEAD) &&
+	rev=$(git rev-parse --verify files-master^0) &&
+	commit=$(git commit-tree -p $head -p $rev -m "Add subproject master" $tree) &&
+	git reset $commit &&
+	(
+		cd files_subtree &&
+		test_commit master4
+	) &&
+	test_commit files_subtree/master5
+'
+
+# Does not preserve master4 and master5.
+test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto' '
+	reset_rebase &&
+	git checkout -b rebase-preserve-merges master &&
+	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git commit -m "Empty commit" --allow-empty &&
+	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
+	check_equal "$(last_commit_message)" "files_subtree/master5"
+'
+
+# Does not preserve master4, master5 and empty.
+test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto' '
+	reset_rebase &&
+	git checkout -b rebase-keep-empty master &&
+	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git commit -m "Empty commit" --allow-empty &&
+	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
+	check_equal "$(last_commit_message)" "Empty commit"
+'
+
+# fatal: Could not parse object
+test_expect_failure 'Rebase -Xsubtree --onto' '
+	reset_rebase &&
+	git checkout -b rebase-onto master &&
+	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git commit -m "Empty commit" --allow-empty &&
+	git rebase -Xsubtree=files_subtree --onto files-master master &&
+	check_equal "$(last_commit_message)" "Empty commit"
+'
+
+test_done
-- 
2.6.1
