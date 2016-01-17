From: David Greene <greened@obbligato.org>
Subject: [PATCH v4 1/1] contrib/subtree: Add a test for subtree rebase that loses commits
Date: Sun, 17 Jan 2016 17:43:21 -0600
Message-ID: <047e625a28954b8fd79225b55cab7620cb5f3b1f.1453074191.git.greened@obbligato.org>
References: <CAPig+cTMAnbyT3-FFN4juUooosiydOCX-ETwTghpnKoOeXcMpQ@mail.gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 00:44:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKwzT-00062k-M6
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 00:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbcAQXne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 18:43:34 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:33018 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752990AbcAQXnd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 18:43:33 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.us.cray.com)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aKx0D-0003gw-0q; Sun, 17 Jan 2016 17:44:57 -0600
X-Mailer: git-send-email 2.6.1
In-Reply-To: <CAPig+cTMAnbyT3-FFN4juUooosiydOCX-ETwTghpnKoOeXcMpQ@mail.gmail.com>
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: David A. Greene <greened@obbligato.org> This test merges
    an external tree in as a subtree, makes some commits on top of it and splits
    it back out. In the process the added commits are lost or the rebase aborts
    with an internal error. The tests are marked to expect failure so that we
    don't forget to fix it. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The qu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284276>

From: David A. Greene <greened@obbligato.org>

This test merges an external tree in as a subtree, makes some commits
on top of it and splits it back out.  In the process the added commits
are lost or the rebase aborts with an internal error.  The tests are
marked to expect failure so that we don't forget to fix it.

Signed-off-by: David A. Greene <greened@obbligato.org>
---

Notes:
    Change History:
    
    v1 - Initial version
    v2 - Additional tests and code cleanup
    v3 - Remove check_equal, mark comments on failure and remove
         test_debug statements
    v4 - Send correct v3 test (botched v3)

 t/t3427-rebase-subtree.sh | 70 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
new file mode 100755
index 0000000..4d47f77
--- /dev/null
+++ b/t/t3427-rebase-subtree.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+
+test_description='git rebase tests for -Xsubtree
+
+This test runs git rebase and tests the subtree strategy.
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
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
+	git fetch files master &&
+	git branch files-master FETCH_HEAD &&
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
+# FAILURE: Does not preserve master4 and master5.
+test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto' '
+	reset_rebase &&
+	git checkout -b rebase-preserve-merges master &&
+	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git commit -m "Empty commit" --allow-empty &&
+	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
+	verbose "$(last_commit_message)" "files_subtree/master5"
+'
+
+# FAILURE: Does not preserve master4, master5 and empty.
+test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto' '
+	reset_rebase &&
+	git checkout -b rebase-keep-empty master &&
+	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git commit -m "Empty commit" --allow-empty &&
+	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
+	verbose "$(last_commit_message)" "Empty commit"
+'
+
+# FAILURE: fatal: Could not parse object
+test_expect_failure 'Rebase -Xsubtree --onto' '
+	reset_rebase &&
+	git checkout -b rebase-onto master &&
+	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git commit -m "Empty commit" --allow-empty &&
+	git rebase -Xsubtree=files_subtree --onto files-master master &&
+	verbose "$(last_commit_message)" "Empty commit"
+'
+
+test_done
-- 
2.6.1
