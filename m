From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 20/21] git notes merge: Add testcases for merging notes trees at different fanouts
Date: Sat,  9 Oct 2010 03:16:43 +0200
Message-ID: <1286587004-3765-21-git-send-email-johan@herland.net>
References: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 03:18:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4O4V-0004Ya-5y
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 03:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760139Ab0JIBRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 21:17:53 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:50323 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759990Ab0JIBRx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 21:17:53 -0400
Received: from pd9587e9f.dip.t-dialin.net ([217.88.126.159] helo=localhost.localdomain)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P4O4O-00028k-0W; Sat, 09 Oct 2010 03:17:52 +0200
X-Mailer: git-send-email 1.7.3.1.104.g92b87a
In-Reply-To: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158570>

Notes trees may exist at different fanout levels internally. This
implementation detail should not be visible to the user, and it should
certainly not affect the merging of notes tree.

This patch adds testcases verifying the correctness of 'git notes merge'
when merging notes trees at different fanout levels.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3311-notes-merge-fanout.sh |  436 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 436 insertions(+), 0 deletions(-)
 create mode 100755 t/t3311-notes-merge-fanout.sh

diff --git a/t/t3311-notes-merge-fanout.sh b/t/t3311-notes-merge-fanout.sh
new file mode 100755
index 0000000..d1c7b69
--- /dev/null
+++ b/t/t3311-notes-merge-fanout.sh
@@ -0,0 +1,436 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Johan Herland
+#
+
+test_description='Test notes merging at various fanout levels'
+
+. ./test-lib.sh
+
+verify_notes () {
+	notes_ref="$1"
+	commit="$2"
+	if test -f "expect_notes_$notes_ref"
+	then
+		git -c core.notesRef="refs/notes/$notes_ref" notes |
+			sort >"output_notes_$notes_ref" &&
+		test_cmp "expect_notes_$notes_ref" "output_notes_$notes_ref" ||
+			return 1
+	fi &&
+	git -c core.notesRef="refs/notes/$notes_ref" log --format="%H %s%n%N" \
+		"$commit" >"output_log_$notes_ref" &&
+	test_cmp "expect_log_$notes_ref" "output_log_$notes_ref"
+}
+
+verify_fanout () {
+	notes_ref="$1"
+	# Expect entire notes tree to have a fanout == 1
+	git rev-parse --quiet --verify "refs/notes/$notes_ref" >/dev/null &&
+	git ls-tree -r --name-only "refs/notes/$notes_ref" |
+	while read path
+	do
+		case "$path" in
+		??/??????????????????????????????????????)
+			: true
+			;;
+		*)
+			echo "Invalid path \"$path\"" &&
+			return 1
+			;;
+		esac
+	done
+}
+
+verify_no_fanout () {
+	notes_ref="$1"
+	# Expect entire notes tree to have a fanout == 0
+	git rev-parse --quiet --verify "refs/notes/$notes_ref" >/dev/null &&
+	git ls-tree -r --name-only "refs/notes/$notes_ref" |
+	while read path
+	do
+		case "$path" in
+		????????????????????????????????????????)
+			: true
+			;;
+		*)
+			echo "Invalid path \"$path\"" &&
+			return 1
+			;;
+		esac
+	done
+}
+
+# Set up a notes merge scenario with different kinds of conflicts
+test_expect_success 'setup a few initial commits with notes (notes ref: x)' '
+	git config core.notesRef refs/notes/x &&
+	for i in 1 2 3 4 5
+	do
+		test_commit "commit$i" >/dev/null &&
+		git notes add -m "notes for commit$i" || return 1
+	done
+'
+
+commit_sha1=$(git rev-parse commit1^{commit})
+commit_sha2=$(git rev-parse commit2^{commit})
+commit_sha3=$(git rev-parse commit3^{commit})
+commit_sha4=$(git rev-parse commit4^{commit})
+commit_sha5=$(git rev-parse commit5^{commit})
+
+cat <<EOF | sort >expect_notes_x
+aed91155c7a72c2188e781fdf40e0f3761b299db $commit_sha5
+99fab268f9d7ee7b011e091a436c78def8eeee69 $commit_sha4
+953c20ae26c7aa0b428c20693fe38bc687f9d1a9 $commit_sha3
+6358796131b8916eaa2dde6902642942a1cb37e1 $commit_sha2
+b02d459c32f0e68f2fe0981033bb34f38776ba47 $commit_sha1
+EOF
+
+cat >expect_log_x <<EOF
+$commit_sha5 commit5
+notes for commit5
+
+$commit_sha4 commit4
+notes for commit4
+
+$commit_sha3 commit3
+notes for commit3
+
+$commit_sha2 commit2
+notes for commit2
+
+$commit_sha1 commit1
+notes for commit1
+
+EOF
+
+test_expect_success 'sanity check (x)' '
+	verify_notes x commit5 &&
+	verify_no_fanout x
+'
+
+num=300
+
+cp expect_log_x expect_log_y
+
+test_expect_success 'Add a few hundred commits w/notes to trigger fanout (x -> y)' '
+	git update-ref refs/notes/y refs/notes/x &&
+	git config core.notesRef refs/notes/y &&
+	i=5 &&
+	while test $i -lt $num
+	do
+		i=$(($i + 1)) &&
+		test_commit "commit$i" >/dev/null &&
+		git notes add -m "notes for commit$i" || return 1
+	done &&
+	test "$(git rev-parse refs/notes/y)" != "$(git rev-parse refs/notes/x)" &&
+	# Expected number of commits and notes
+	test "$(git rev-list HEAD | wc -l)" = "$num" &&
+	test "$(git notes list | wc -l)" = "$num" &&
+	# 5 first notes unchanged
+	verify_notes y commit5
+'
+
+test_expect_success 'notes tree has fanout (y)' 'verify_fanout y'
+
+test_expect_success 'No-op merge (already included) (x => y)' '
+	git update-ref refs/notes/m refs/notes/y &&
+	git config core.notesRef refs/notes/m &&
+	git notes merge x &&
+	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/y)"
+'
+
+test_expect_success 'Fast-forward merge (y => x)' '
+	git update-ref refs/notes/m refs/notes/x &&
+	git notes merge y &&
+	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/y)"
+'
+
+cat <<EOF | sort >expect_notes_z
+9f506ee70e20379d7f78204c77b334f43d77410d $commit_sha3
+23a47d6ea7d589895faf800752054818e1e7627b $commit_sha2
+b02d459c32f0e68f2fe0981033bb34f38776ba47 $commit_sha1
+EOF
+
+cat >expect_log_z <<EOF
+$commit_sha5 commit5
+
+$commit_sha4 commit4
+
+$commit_sha3 commit3
+notes for commit3
+
+appended notes for commit3
+
+$commit_sha2 commit2
+new notes for commit2
+
+$commit_sha1 commit1
+notes for commit1
+
+EOF
+
+test_expect_success 'change some of the initial 5 notes (x -> z)' '
+	git update-ref refs/notes/z refs/notes/x &&
+	git config core.notesRef refs/notes/z &&
+	git notes add -f -m "new notes for commit2" commit2 &&
+	git notes append -m "appended notes for commit3" commit3 &&
+	git notes remove commit4 &&
+	git notes remove commit5 &&
+	verify_notes z commit5
+'
+
+test_expect_success 'notes tree has no fanout (z)' 'verify_no_fanout z'
+
+cp expect_log_z expect_log_m
+
+test_expect_success 'successful merge without conflicts (y => z)' '
+	git update-ref refs/notes/m refs/notes/z &&
+	git config core.notesRef refs/notes/m &&
+	git notes merge y &&
+	verify_notes m commit5 &&
+	# x/y/z unchanged
+	verify_notes x commit5 &&
+	verify_notes y commit5 &&
+	verify_notes z commit5
+'
+
+test_expect_success 'notes tree still has fanout after merge (m)' 'verify_fanout m'
+
+cat >expect_log_w <<EOF
+$commit_sha5 commit5
+
+$commit_sha4 commit4
+other notes for commit4
+
+$commit_sha3 commit3
+other notes for commit3
+
+$commit_sha2 commit2
+notes for commit2
+
+$commit_sha1 commit1
+other notes for commit1
+
+EOF
+
+test_expect_success 'introduce conflicting changes (y -> w)' '
+	git update-ref refs/notes/w refs/notes/y &&
+	git config core.notesRef refs/notes/w &&
+	git notes add -f -m "other notes for commit1" commit1 &&
+	git notes add -f -m "other notes for commit3" commit3 &&
+	git notes add -f -m "other notes for commit4" commit4 &&
+	git notes remove commit5 &&
+	verify_notes w commit5
+'
+
+cat >expect_log_m <<EOF
+$commit_sha5 commit5
+
+$commit_sha4 commit4
+other notes for commit4
+
+$commit_sha3 commit3
+other notes for commit3
+
+$commit_sha2 commit2
+new notes for commit2
+
+$commit_sha1 commit1
+other notes for commit1
+
+EOF
+
+test_expect_success 'successful merge using "ours" strategy (z => w)' '
+	git update-ref refs/notes/m refs/notes/w &&
+	git config core.notesRef refs/notes/m &&
+	git notes merge -s ours z &&
+	verify_notes m commit5 &&
+	# w/x/y/z unchanged
+	verify_notes w commit5 &&
+	verify_notes x commit5 &&
+	verify_notes y commit5 &&
+	verify_notes z commit5
+'
+
+test_expect_success 'notes tree still has fanout after merge (m)' 'verify_fanout m'
+
+cat >expect_log_m <<EOF
+$commit_sha5 commit5
+
+$commit_sha4 commit4
+
+$commit_sha3 commit3
+notes for commit3
+
+appended notes for commit3
+
+$commit_sha2 commit2
+new notes for commit2
+
+$commit_sha1 commit1
+other notes for commit1
+
+EOF
+
+test_expect_success 'successful merge using "theirs" strategy (z => w)' '
+	git update-ref refs/notes/m refs/notes/w &&
+	git notes merge -s theirs z &&
+	verify_notes m commit5 &&
+	# w/x/y/z unchanged
+	verify_notes w commit5 &&
+	verify_notes x commit5 &&
+	verify_notes y commit5 &&
+	verify_notes z commit5
+'
+
+test_expect_success 'notes tree still has fanout after merge (m)' 'verify_fanout m'
+
+cat >expect_log_m <<EOF
+$commit_sha5 commit5
+
+$commit_sha4 commit4
+other notes for commit4
+
+$commit_sha3 commit3
+other notes for commit3
+
+notes for commit3
+
+appended notes for commit3
+
+$commit_sha2 commit2
+new notes for commit2
+
+$commit_sha1 commit1
+other notes for commit1
+
+EOF
+
+test_expect_success 'successful merge using "union" strategy (z => w)' '
+	git update-ref refs/notes/m refs/notes/w &&
+	git notes merge -s union z &&
+	verify_notes m commit5 &&
+	# w/x/y/z unchanged
+	verify_notes w commit5 &&
+	verify_notes x commit5 &&
+	verify_notes y commit5 &&
+	verify_notes z commit5
+'
+
+test_expect_success 'notes tree still has fanout after merge (m)' 'verify_fanout m'
+
+cat >expect_log_m <<EOF
+$commit_sha5 commit5
+
+$commit_sha4 commit4
+other notes for commit4
+
+$commit_sha3 commit3
+appended notes for commit3
+notes for commit3
+other notes for commit3
+
+$commit_sha2 commit2
+new notes for commit2
+
+$commit_sha1 commit1
+other notes for commit1
+
+EOF
+
+test_expect_success 'successful merge using "cat_sort_uniq" strategy (z => w)' '
+	git update-ref refs/notes/m refs/notes/w &&
+	git notes merge -s cat_sort_uniq z &&
+	verify_notes m commit5 &&
+	# w/x/y/z unchanged
+	verify_notes w commit5 &&
+	verify_notes x commit5 &&
+	verify_notes y commit5 &&
+	verify_notes z commit5
+'
+
+test_expect_success 'notes tree still has fanout after merge (m)' 'verify_fanout m'
+
+# We're merging z into w. Here are the conflicts we expect:
+#
+# commit | x -> w    | x -> z    | conflict?
+# -------|-----------|-----------|----------
+# 1      | changed   | unchanged | no, use w
+# 2      | unchanged | changed   | no, use z
+# 3      | changed   | changed   | yes (w, then z in conflict markers)
+# 4      | changed   | deleted   | yes (w)
+# 5      | deleted   | deleted   | no, deleted
+
+test_expect_success 'fails to merge using "manual" strategy (z => w)' '
+	git update-ref refs/notes/m refs/notes/w &&
+	test_must_fail git notes merge z
+'
+
+test_expect_success 'notes tree still has fanout after merge (m)' 'verify_fanout m'
+
+cat <<EOF | sort >expect_conflicts
+$commit_sha3
+$commit_sha4
+EOF
+
+cat >expect_conflict_$commit_sha3 <<EOF
+<<<<<<< refs/notes/m
+other notes for commit3
+=======
+notes for commit3
+
+appended notes for commit3
+>>>>>>> refs/notes/z
+EOF
+
+cat >expect_conflict_$commit_sha4 <<EOF
+other notes for commit4
+EOF
+
+test_expect_success 'verify conflict entries (with no fanout)' '
+	ls .git/NOTES_MERGE_WORKTREE >output_conflicts &&
+	test_cmp expect_conflicts output_conflicts &&
+	( for f in $(cat expect_conflicts); do
+		test_cmp "expect_conflict_$f" ".git/NOTES_MERGE_WORKTREE/$f" ||
+		exit 1
+	done ) &&
+	# Verify that current notes tree (pre-merge) has not changed (m == w)
+	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)"
+'
+
+cat >expect_log_m <<EOF
+$commit_sha5 commit5
+
+$commit_sha4 commit4
+other notes for commit4
+
+$commit_sha3 commit3
+other notes for commit3
+
+appended notes for commit3
+
+$commit_sha2 commit2
+new notes for commit2
+
+$commit_sha1 commit1
+other notes for commit1
+
+EOF
+
+test_expect_success 'resolve and finalize merge (z => w)' '
+	cat >.git/NOTES_MERGE_WORKTREE/$commit_sha3 <<EOF &&
+other notes for commit3
+
+appended notes for commit3
+EOF
+	git notes merge --commit &&
+	verify_notes m commit5 &&
+	# w/x/y/z unchanged
+	verify_notes w commit5 &&
+	verify_notes x commit5 &&
+	verify_notes y commit5 &&
+	verify_notes z commit5
+'
+
+test_expect_success 'notes tree still has fanout after merge (m)' 'verify_fanout m'
+
+test_done
-- 
1.7.3.1.104.g92b87a
