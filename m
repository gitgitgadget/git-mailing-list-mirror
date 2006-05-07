From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] test case for transitive info/alternates
Date: Sun, 7 May 2006 20:19:47 +0200
Message-ID: <20060507181947.GE23738@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 07 20:20:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcnrh-0004Bx-KL
	for gcvg-git@gmane.org; Sun, 07 May 2006 20:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWEGSTt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 14:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWEGSTs
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 14:19:48 -0400
Received: from admingilde.org ([213.95.32.146]:37839 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1751216AbWEGSTr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 14:19:47 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Fcnr9-0000q1-6I
	for git@vger.kernel.org; Sun, 07 May 2006 20:19:47 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19712>

Signed-off-by: Martin Waitz <tali@admingilde.org>

---

 t/t5710-info-alternate.sh |  105 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 105 insertions(+), 0 deletions(-)
 create mode 100755 t/t5710-info-alternate.sh

47d59f8b0c26226a40344673ecd9e6255a576b98
diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
new file mode 100755
index 0000000..097d037
--- /dev/null
+++ b/t/t5710-info-alternate.sh
@@ -0,0 +1,105 @@
+#!/bin/sh
+#
+# Copyright (C) 2006 Martin Waitz <tali@admingilde.org>
+#
+
+test_description='test transitive info/alternate entries'
+. ./test-lib.sh
+
+# test that a file is not reachable in the current repository
+# but that it is after creating a info/alternate entry
+reachable_via() {
+	alternate="$1"
+	file="$2"
+	if git cat-file -e "HEAD:$file"; then return 1; fi
+	echo "$alternate" >> .git/objects/info/alternate
+	git cat-file -e "HEAD:$file"
+}
+
+test_valid_repo() {
+	git fsck-objects --full > fsck.log &&
+	test `wc -l < fsck.log` = 0
+}
+
+base_dir=`pwd`
+
+test_expect_success 'preparing first repository' \
+'test_create_repo A && cd A &&
+echo "Hello World" > file1 &&
+git add file1 &&
+git commit -m "Initial commit" file1 &&
+git repack -a -d &&
+git prune'
+
+cd "$base_dir"
+
+test_expect_success 'preparing second repository' \
+'git clone -l -s A B && cd B &&
+echo "foo bar" > file2 &&
+git add file2 &&
+git commit -m "next commit" file2 &&
+git repack -a -d -l &&
+git prune'
+
+cd "$base_dir"
+
+test_expect_success 'preparing third repository' \
+'git clone -l -s B C && cd C &&
+echo "Goodbye, cruel world" > file3 &&
+git add file3 &&
+git commit -m "one more" file3 &&
+git repack -a -d -l &&
+git prune'
+
+cd "$base_dir"
+
+test_expect_failure 'creating too deep nesting' \
+'git clone -l -s C D &&
+git clone -l -s D E &&
+git clone -l -s E F &&
+git clone -l -s F G &&
+test_valid_repo'
+
+cd "$base_dir"
+
+test_expect_success 'validity of third repository' \
+'cd C &&
+test_valid_repo'
+
+cd "$base_dir"
+
+test_expect_success 'validity of fourth repository' \
+'cd D &&
+test_valid_repo'
+
+cd "$base_dir"
+
+test_expect_success 'breaking of loops' \
+"echo '$base_dir/B/.git/objects' >> '$base_dir'/A/.git/objects/info/alternates&&
+cd C &&
+test_valid_repo"
+
+cd "$base_dir"
+
+test_expect_failure 'that info/alternates is neccessary' \
+'cd C &&
+rm .git/objects/info/alternates &&
+test_valid_repo'
+
+cd "$base_dir"
+
+test_expect_success 'that relative alternate is possible for current dir' \
+'cd C &&
+echo "../../../B/.git/objects" > .git/objects/info/alternates &&
+test_valid_repo'
+
+cd "$base_dir"
+
+test_expect_failure 'that relative alternate is only possible for current dir' \
+'cd D &&
+test_valid_repo'
+
+cd "$base_dir"
+
+test_done
+
-- 
1.3.1.g6ef7
