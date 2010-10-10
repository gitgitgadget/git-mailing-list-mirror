From: David Barr <david.barr@cordelta.com>
Subject: [PATCH] fast-import: Allow filemodify to set the root
Date: Sun, 10 Oct 2010 14:30:15 +1100
Message-ID: <1286681415-1831-1-git-send-email-david.barr@cordelta.com>
References: <AANLkTinsnMRyoeGzCn1Rkk7tc+zwVa5j3AGqVZCdDGDv@mail.gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 10 05:34:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4mgS-00015u-Ka
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 05:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760689Ab0JJDdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 23:33:08 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:37306 "EHLO
	mail02.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757335Ab0JJDdH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Oct 2010 23:33:07 -0400
Received: from localhost.localdomain (d110-33-95-167.mit3.act.optusnet.com.au [110.33.95.167])
	by mail02.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id o9A3UwuA016191;
	Sun, 10 Oct 2010 14:30:58 +1100
X-Mailer: git-send-email 1.7.3
In-Reply-To: <AANLkTinsnMRyoeGzCn1Rkk7tc+zwVa5j3AGqVZCdDGDv@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158640>

v1.7.3-rc0~75^2 (Teach fast-import to import subtrees named by tree id,
2010-06-30) has a shortcoming - it doesn't allow the root to be set.
Extend this behaviour by allowing the root to be referenced as the
empty path, "".

For a command (like filter-branch --subdirectory-filter) that wants
to commit a lot of trees that already exist in the object db, writing
undeltified objects as loose files only to repack them later can
involve a significant amount of overhead.
(23% slow-down observed on Linux 2.6.35, worse on Mac OS X 10.6)

Fortunately we have fast-import (which is one of the only git commands
that will write to a pack directly) but there is not an advertised way
to tell fast-import to commit a given tree without unpacking it.

This patch changes that, by allowing

	M 040000 <tree id> ""

as a filemodify line in a commit to reset to a particular tree without
any need to parse it.  For example,

	M 040000 4b825dc642cb6eb9a060e54bf8d69288fbee4904 ""

is a synonym for the deleteall command and the fast-import equivalent of

	git read-tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904

Signed-off-by: David Barr <david.barr@cordelta.com>
Commit-message-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Sverre Rabbelier <srabbelier@gmail.com>
Tested-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-fast-import.txt |    3 +++
 fast-import.c                     |    9 +++++++++
 t/t9300-fast-import.sh            |   21 +++++++++++++++++++++
 3 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 966ba4f..90a4666 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -524,6 +524,9 @@ start with double quote (`"`).
 If an `LF` or double quote must be encoded into `<path>` shell-style
 quoting should be used, e.g. `"path/with\n and \" in it"`.
 
+Additionally, in `040000` mode, `<path>` may also be an empty string
+(`""`) to specify the root of the tree.
+
 The value of `<path>` must be in canonical form. That is it must not:
 
 * contain an empty directory component (e.g. `foo//bar` is invalid),
diff --git a/fast-import.c b/fast-import.c
index 2317b0f..8f68a89 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1454,6 +1454,15 @@ static int tree_content_set(
 		n = slash1 - p;
 	else
 		n = strlen(p);
+	if (!slash1 && !n) {
+		if (!S_ISDIR(mode))
+			die("Root cannot be a non-directory");
+		hashcpy(root->versions[1].sha1, sha1);
+		if (root->tree)
+			release_tree_content_recursive(root->tree);
+		root->tree = subtree;
+		return 1;
+	}
 	if (!n)
 		die("Empty path component found in input");
 	if (!slash1 && !S_ISDIR(mode) && subtree)
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 7c05920..3c0cf05 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -875,6 +875,27 @@ test_expect_success \
 	 compare_diff_raw expect actual'
 
 test_expect_success \
+	'N: copy root directory by tree hash' \
+	'cat >expect <<-\EOF &&
+	:100755 000000 f1fb5da718392694d0076d677d6d0e364c79b0bc 0000000000000000000000000000000000000000 D	file3/newf
+	:100644 000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 0000000000000000000000000000000000000000 D	file3/oldf
+	EOF
+	 root=$(git rev-parse refs/heads/branch^0^{tree}) &&
+	 cat >input <<-INPUT_END &&
+	commit refs/heads/N6
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	copy root directory by tree hash
+	COMMIT
+
+	from refs/heads/branch^0
+	M 040000 $root ""
+	INPUT_END
+	 git fast-import <input &&
+	 git diff-tree -C --find-copies-harder -r N4 N6 >actual &&
+	 compare_diff_raw expect actual'
+
+test_expect_success \
 	'N: modify copied tree' \
 	'cat >expect <<-\EOF &&
 	:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	file3/file5
-- 
1.7.3
