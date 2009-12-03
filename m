From: Johan Herland <johan@herland.net>
Subject: [PATCH for v1.6.6] Fix crasher on encountering SHA1-like non-note in
 notes tree
Date: Thu, 03 Dec 2009 04:53:54 +0100
Message-ID: <1259812434-24471-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net, spearce@spearce.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 03 04:54:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG2ld-0007XF-LR
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 04:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755454AbZLCDx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 22:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754291AbZLCDx5
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 22:53:57 -0500
Received: from smtp.getmail.no ([84.208.15.66]:50358 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753408AbZLCDx4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2009 22:53:56 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KU2000XB5I1OD50@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 03 Dec 2009 04:54:01 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KU2003195HZBW30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 03 Dec 2009 04:54:01 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.12.3.33917
X-Mailer: git-send-email 1.6.5.3.433.g11067
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134429>

When loading a notes tree, the code primarily looks for SHA1-like paths
whose total length (discounting directory separators) are 40 chars
(interpreted as valid note entries) or less (interpreted as subtree
entries that may in turn contain note entries when unpacked).

However, there is an additional condition that must hold for valid
subtree entries: They must be _tree_ objects (duh).

This patch adds an appropriate test for this condition, thereby fixing
the crash that occured when passing a non-tree object to the tree-walk
API.

The patch also adds another selftest verifying correct behaviour of
non-notes in note trees.

Signed-off-by: Johan Herland <johan@herland.net>
---

Junio,

I believe this should be included in v1.6.6. It fixes an existing crasher in
the early part of the notes series.


...Johan

 notes.c                |    2 +
 t/t3304-notes-mixed.sh |  172 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+), 0 deletions(-)
 create mode 100755 t/t3304-notes-mixed.sh

diff --git a/notes.c b/notes.c
index 50a4672..023adce 100644
--- a/notes.c
+++ b/notes.c
@@ -331,6 +331,8 @@ static void load_subtree(struct leaf_node *subtree, struct int_node *node,
 			hashcpy(l->key_sha1, commit_sha1);
 			hashcpy(l->val_sha1, entry.sha1);
 			if (len < 20) {
+				if (!S_ISDIR(entry.mode))
+					continue; /* entry cannot be subtree */
 				l->key_sha1[19] = (unsigned char) len;
 				type = PTR_TYPE_SUBTREE;
 			}
diff --git a/t/t3304-notes-mixed.sh b/t/t3304-notes-mixed.sh
new file mode 100755
index 0000000..256687f
--- /dev/null
+++ b/t/t3304-notes-mixed.sh
@@ -0,0 +1,172 @@
+#!/bin/sh
+
+test_description='Test notes trees that also contain non-notes'
+
+. ./test-lib.sh
+
+number_of_commits=100
+
+start_note_commit () {
+	test_tick &&
+	cat <<INPUT_END
+commit refs/notes/commits
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+notes
+COMMIT
+
+from refs/notes/commits^0
+deleteall
+INPUT_END
+
+}
+
+verify_notes () {
+	git log | grep "^    " > output &&
+	i=$number_of_commits &&
+	while [ $i -gt 0 ]; do
+		echo "    commit #$i" &&
+		echo "    note for commit #$i" &&
+		i=$(($i-1));
+	done > expect &&
+	test_cmp expect output
+}
+
+test_expect_success "setup: create a couple of commits" '
+
+	test_tick &&
+	cat <<INPUT_END >input &&
+commit refs/heads/master
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+commit #1
+COMMIT
+
+M 644 inline file
+data <<EOF
+file in commit #1
+EOF
+
+INPUT_END
+
+	test_tick &&
+	cat <<INPUT_END >>input &&
+commit refs/heads/master
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+commit #2
+COMMIT
+
+M 644 inline file
+data <<EOF
+file in commit #2
+EOF
+
+INPUT_END
+	git fast-import --quiet <input
+'
+
+test_expect_success "create a notes tree with both notes and non-notes" '
+
+	commit1=$(git rev-parse refs/heads/master^) &&
+	commit2=$(git rev-parse refs/heads/master) &&
+	test_tick &&
+	cat <<INPUT_END >input &&
+commit refs/notes/commits
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+notes commit #1
+COMMIT
+
+N inline $commit1
+data <<EOF
+note for commit #1
+EOF
+
+N inline $commit2
+data <<EOF
+note for commit #2
+EOF
+
+INPUT_END
+	test_tick &&
+	cat <<INPUT_END >>input &&
+commit refs/notes/commits
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+notes commit #2
+COMMIT
+
+M 644 inline foobar/non-note.txt
+data <<EOF
+A non-note in a notes tree
+EOF
+
+N inline $commit2
+data <<EOF
+edited note for commit #2
+EOF
+
+INPUT_END
+	test_tick &&
+	cat <<INPUT_END >>input &&
+commit refs/notes/commits
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+notes commit #3
+COMMIT
+
+N inline $commit1
+data <<EOF
+edited note for commit #1
+EOF
+
+M 644 inline deadbeef
+data <<EOF
+non-note with SHA1-like name
+EOF
+
+M 644 inline de/adbeef
+data <<EOF
+another non-note with SHA1-like name
+EOF
+
+INPUT_END
+	git fast-import --quiet <input &&
+	git config core.notesRef refs/notes/commits
+'
+
+cat >expect <<EXPECT_END
+    commit #2
+    edited note for commit #2
+    commit #1
+    edited note for commit #1
+EXPECT_END
+
+test_expect_success "verify contents of notes" '
+
+	git log | grep "^    " > actual &&
+	test_cmp expect actual
+'
+
+cat >expect_nn1 <<EXPECT_END
+A non-note in a notes tree
+EXPECT_END
+cat >expect_nn2 <<EXPECT_END
+non-note with SHA1-like name
+EXPECT_END
+cat >expect_nn3 <<EXPECT_END
+another non-note with SHA1-like name
+EXPECT_END
+
+test_expect_success "verify contents of non-notes" '
+
+	git cat-file -p refs/notes/commits:foobar/non-note.txt > actual_nn1 &&
+	test_cmp expect_nn1 actual_nn1 &&
+	git cat-file -p refs/notes/commits:deadbeef > actual_nn2 &&
+	test_cmp expect_nn2 actual_nn2 &&
+	git cat-file -p refs/notes/commits:de/adbeef > actual_nn3 &&
+	test_cmp expect_nn3 actual_nn3
+'
+
+test_done
--
1.6.5.3.433.g11067
